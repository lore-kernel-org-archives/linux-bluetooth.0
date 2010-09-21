Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: barbieri@profusion.mobi,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Simplify linker script
Date: Tue, 21 Sep 2010 15:46:56 -0300
Message-Id: <1285094816-1683-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Version linker scripts support function names and globs, so there's no
need to rely on nm tool to gather the exported symbols.
---
 .gitignore           |    1 -
 Makefile.am          |   14 +-------------
 configure.ac         |    2 +-
 src/bluetooth.ver.in |   10 ++++++++++
 4 files changed, 12 insertions(+), 15 deletions(-)
 create mode 100644 src/bluetooth.ver.in

diff --git a/.gitignore b/.gitignore
index e12508e..db6c3f3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -34,7 +34,6 @@ bluez.pc
 lib/bluetooth
 src/builtin.h
 src/bluetoothd
-src/bluetooth.exp
 src/bluetooth.ver
 audio/telephony.c
 scripts/bluetooth.rules
diff --git a/Makefile.am b/Makefile.am
index 05bc8fc..1c70e5d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -258,7 +258,7 @@ builtin_files = src/builtin.h $(builtin_nodist)
 
 nodist_src_bluetoothd_SOURCES = $(builtin_files)
 
-CLEANFILES += src/bluetooth.ver src/bluetooth.exp $(builtin_files)
+CLEANFILES += $(builtin_files)
 
 man_MANS = src/bluetoothd.8
 
@@ -392,18 +392,6 @@ src/plugin.$(OBJEXT): src/builtin.h
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
-src/bluetooth.exp: $(src_bluetoothd_OBJECTS)
-	$(AM_V_GEN)$(NM) $^ | $(AWK) '{ print $$3 }' | sort -u | \
-				$(EGREP) -e '^btd_' -e '^g_dbus_' > $@
-	$(AM_V_at)echo -e "info" >> $@
-	$(AM_V_at)echo -e "error" >> $@
-	$(AM_V_at)echo -e "debug" >> $@
-
-src/bluetooth.ver: src/bluetooth.exp
-	$(AM_V_at)echo "{ global:" > $@
-	$(AM_V_GEN)$(SED) -e "s/\(.*\)/\1;/" $< >> $@
-	$(AM_V_at)echo "local: *; };" >> $@
-
 audio/telephony.c: audio/@TELEPHONY_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
diff --git a/configure.ac b/configure.ac
index 6fda7fe..08f4877 100644
--- a/configure.ac
+++ b/configure.ac
@@ -65,5 +65,5 @@ if (test "${enable_netlink}" = "yes"); then
 fi
 AM_CONDITIONAL(NETLINK, test "${enable_netlink}" = "yes")
 
-AC_OUTPUT(Makefile scripts/bluetooth.rules doc/version.xml
+AC_OUTPUT(Makefile scripts/bluetooth.rules doc/version.xml src/bluetooth.ver
 					src/bluetoothd.8 bluez.pc)
diff --git a/src/bluetooth.ver.in b/src/bluetooth.ver.in
new file mode 100644
index 0000000..b71c70d
--- /dev/null
+++ b/src/bluetooth.ver.in
@@ -0,0 +1,10 @@
+{
+	global:
+		btd_*;
+		g_dbus_*;
+		info;
+		error;
+		debug;
+	local:
+		*;
+};
-- 
1.7.2.3

