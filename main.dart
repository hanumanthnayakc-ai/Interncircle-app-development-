import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const ProfileCardApp());

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: const ProfileCard(
                name: 'Aarav Sharma',
                role: 'Senior Product Designer',
                initials: 'AS',
                contacts: [
                  ContactInfo(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: 'aarav.sharma@example.com',
                  ),
                  ContactInfo(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: '+91 98765 43210',
                  ),
                  ContactInfo(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: 'Bengaluru, India',
                  ),
                  ContactInfo(
                    icon: Icons.link,
                    label: 'Website',
                    value: 'aarav.design',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactInfo {
  final IconData icon;
  final String label;
  final String value;
  const ContactInfo({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String initials;
  final List<ContactInfo> contacts;

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    required this.initials,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with gradient and overlapping avatar
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [scheme.primary, scheme.tertiary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                bottom: -48,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: scheme.primaryContainer,
                    child: Text(
                      initials,
                      style: text.headlineMedium?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Text(
            name,
            style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, indent: 24, endIndent: 24),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                for (final c in contacts) ContactRow(info: c),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  final ContactInfo info;
  const ContactRow({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: info.value));
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text('${info.label} copied')),
          );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(info.icon, color: scheme.onSecondaryContainer),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.label,
                    style: text.labelMedium
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                  Text(info.value, style: text.bodyLarge),
                ],
              ),
            ),
            Icon(Icons.copy, size: 18, color: scheme.outline),
          ],
        ),
      ),
    );
  }
}
