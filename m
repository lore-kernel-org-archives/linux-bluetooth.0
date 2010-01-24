Return-Path: <cyrus@holtmann.org>
Message-ID: <4B5C554D.4030702@gmx.de>
Date: Sun, 24 Jan 2010 15:12:29 +0100
From: Thomas Egerer <hakke_007@gmx.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] add configurable support for bridge forward delay
Content-Type: multipart/mixed;
 boundary="------------010601070407090800070209"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010601070407090800070209
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


the default learning time of a bridge -- 15 seconds -- appears
unacceptably long, especially for clients that disconnect quite
often after a short time (e.g. web-browsers);
this patch tries to remedy this by setting the the waiting period to a
value of zero (by default) or -- if the administrator wishes a larger
value -- to whatever the General section of the network.conf holds in
the variable ForwardDelay;
---
 Makefile.am       |    2 +-
 acinclude.m4      |    6 +++
 configure.ac      |    1 +
 network/bridge.c  |  117
++++++++++++++++++++++++++++++++++++++++++++++++++++-
 network/bridge.h  |    3 +-
 network/manager.c |   19 +++++++-
 6 files changed, 142 insertions(+), 6 deletions(-)

--------------010601070407090800070209
Content-Type: text/x-patch;
 name="46dfe45150c2a82d911ddabc81e13c3dc7b8c164.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="46dfe45150c2a82d911ddabc81e13c3dc7b8c164.diff"

diff --git a/Makefile.am b/Makefile.am
index f8111a9..0d8e2e1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -305,7 +305,7 @@ EXTRA_DIST += doc/manager-api.txt \
 
 AM_YFLAGS = -d
 
-AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ \
+AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ @SYSFS_CFLAGS@ \
 		-DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
 
 INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
diff --git a/acinclude.m4 b/acinclude.m4
index 7ce2588..f2b6aa2 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -109,6 +109,12 @@ AC_DEFUN([AC_PATH_GLIB], [
 	AC_SUBST(GLIB_LIBS)
 ])
 
+AC_DEFUN([AC_PATH_SYSFS], [
+	PKG_CHECK_MODULES(SYSFS, libsysfs >= 1.3.0, dummy=yes,
+				AC_MSG_ERROR(libsysfs library version 1.3.0 or later is required))
+	AC_SUBST(SYSFS_CFLAGS)
+])
+
 AC_DEFUN([AC_PATH_GSTREAMER], [
 	PKG_CHECK_MODULES(GSTREAMER, gstreamer-0.10 gstreamer-plugins-base-0.10, gstreamer_found=yes, gstreamer_found=no)
 	AC_SUBST(GSTREAMER_CFLAGS)
diff --git a/configure.ac b/configure.ac
index 199d2ad..afff4f9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,6 +35,7 @@ AC_FUNC_PPOLL
 AC_CHECK_LIB(dl, dlopen, dummy=yes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 
+AC_PATH_SYSFS
 AC_PATH_DBUS
 AC_PATH_GLIB
 AC_PATH_ALSA
diff --git a/network/bridge.c b/network/bridge.c
index f3528ad..1dc09ca 100644
--- a/network/bridge.c
+++ b/network/bridge.c
@@ -25,6 +25,8 @@
 #include <config.h>
 #endif
 
+#include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
@@ -33,6 +35,8 @@
 #include <sys/types.h>
 #include <net/if.h>
 #include <linux/sockios.h>
+#include <linux/if_bridge.h>
+#include <sysfs/libsysfs.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
@@ -43,10 +47,114 @@
 #include "common.h"
 
 static int bridge_socket = -1;
+static unsigned long int forward_delay = 1499;
 static const char *gn_bridge = NULL;
 static const char *nap_bridge = NULL;
 
-int bridge_init(const char *gn_iface, const char *nap_iface)
+/**
+ * convert the given string to the corresponding value in 
+ * jiffies; small helper function since a brige's forward
+ * delay is expressed in jiffies;
+ *
+ * @param str	string to convert
+ * @param val	converted value
+ * @return	0 on success, -ERANGE otherwise
+ */
+static int __str_to_jiffies(const char *str, unsigned long int *val)
+{
+	double d;
+
+	if (!val)
+		return -EINVAL;
+
+	errno = 0;
+	d = strtod(str, NULL);
+
+	if (errno) {
+		error("unable to convert string to double: %s (%d)",
+				strerror(errno), errno);
+		return -errno;
+	}
+
+	if (0 > d)
+		d *= -1;
+	*val = d * 100UL;
+
+	return 0;
+}
+
+/**
+ * set the forward_delay of a bridge;
+ *
+ * @param id 		id of the bridge to manipulate
+ * @param delay		value of the forward delay to use (jiffies!)
+ * @return		0 on success,
+ * 			-EINVAL if id was invalid
+ * 			-errno if fprintf or ioctl failed
+ */
+static int __set_br_fwd_delay(const int id, const unsigned long int delay)
+{
+	char path[SYSFS_PATH_MAX];
+	FILE *fp; 
+	int ret, *ptr = NULL;
+	const char *name, *sysfs_mnt;
+	static int done[] = { 0, 0 };
+
+	name = bridge_get_name(id);
+	/* invalid id */
+	if (!name)
+		return -EINVAL;
+
+	if (BNEP_SVC_NAP == id)
+		ptr = &done[0];
+	else if (BNEP_SVC_NAP == id)
+		ptr = &done[1];
+
+	/* invalid id again */
+	if (NULL == ptr)
+		return -EINVAL;
+
+	/* operation already done... */
+	if (1 == *ptr)
+		return 0;
+
+	/* there's two ways to set the forward_delay, the new one,
+	 * - use the sysfs file for the bridge, or
+	 * - the 'old-fashioned' one, employing an obsolete ioctl */
+	sysfs_mnt = getenv(SYSFS_PATH_ENV);
+	if (!sysfs_mnt)
+		sysfs_mnt = SYSFS_MNT_PATH;
+	snprintf(path, SYSFS_PATH_MAX, "%s/" SYSFS_CLASS_NAME
+			"/net/%s/bridge/forward_delay", sysfs_mnt, name);
+	fp = fopen(path, "w");
+
+	if (fp) {
+		ret = fprintf(fp, "%ld", delay);
+		fclose(fp);
+	} else {
+		struct ifreq ifr;
+		unsigned long data[4] = { BRCTL_SET_BRIDGE_FORWARD_DELAY,
+			delay, 0, 0 };
+
+		strncpy(ifr.ifr_name, name, IFNAMSIZ);
+		ifr.ifr_data = (char *)&data;
+		ret = ioctl(bridge_socket, SIOCDEVPRIVATE, &ifr);
+	}
+
+	if (0 >= ret)
+		/* failed to set forward_delay */
+		ret = -errno;
+	else {
+		/* success, remember we set forward_delay */
+		*ptr = 1;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+int bridge_init(const char *gn_iface, const char *nap_iface,
+	const char *fwd_delay)
 {
 #if 0
 	struct stat st;
@@ -64,6 +172,9 @@ int bridge_init(const char *gn_iface, const char *nap_iface)
 	gn_bridge = gn_iface;
 	nap_bridge = nap_iface;
 
+	/* ignore return value, default is 1499 anyway... */
+	__str_to_jiffies(fwd_delay, &forward_delay);
+
 	return 0;
 }
 
@@ -132,6 +243,10 @@ int bridge_add_interface(int id, const char *dev)
 	err = bnep_if_up(name, id);
 	if (err < 0)
 		return err;
+	
+	err = __set_br_fwd_delay(id, forward_delay);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
diff --git a/network/bridge.h b/network/bridge.h
index f241148..4c18baf 100644
--- a/network/bridge.h
+++ b/network/bridge.h
@@ -21,7 +21,8 @@
  *
  */
 
-int bridge_init(const char *gn_iface, const char *nap_iface);
+int bridge_init(const char *gn_iface, const char *nap_iface,
+	const char *forward_delay);
 void bridge_cleanup(void);
 
 int bridge_create(int id);
diff --git a/network/manager.c b/network/manager.c
index bc84de0..47eb641 100644
--- a/network/manager.c
+++ b/network/manager.c
@@ -46,6 +46,7 @@
 #define IFACE_PREFIX "bnep%d"
 #define GN_IFACE  "pan0"
 #define NAP_IFACE "pan1"
+#define FORWARD_DELAY "0"
 
 static struct btd_adapter_driver network_panu_server_driver;
 static struct btd_adapter_driver network_gn_server_driver;
@@ -58,6 +59,7 @@ static struct network_conf {
 	gboolean server_enabled;
 	gboolean security;
 	char *iface_prefix;
+	char *forward_delay;
 	char *panu_script;
 	char *gn_script;
 	char *nap_script;
@@ -68,6 +70,7 @@ static struct network_conf {
 	.server_enabled = TRUE,
 	.security = TRUE,
 	.iface_prefix = NULL,
+	.forward_delay = NULL,
 	.panu_script = NULL,
 	.gn_script = NULL,
 	.nap_script = NULL,
@@ -78,6 +81,7 @@ static struct network_conf {
 static void conf_cleanup(void)
 {
 	g_free(conf.iface_prefix);
+	g_free(conf.forward_delay);
 	g_free(conf.panu_script);
 	g_free(conf.gn_script);
 	g_free(conf.nap_script);
@@ -122,6 +126,13 @@ static void read_config(const char *file)
 		g_clear_error(&err);
 	}
 
+	conf.forward_delay = g_key_file_get_string(keyfile, "General",
+						"ForwardDelay", &err);
+	if (err) {
+		debug("%s: %s", file, err->message);
+		g_clear_error(&err);
+	}
+
 #if 0
 	conf.panu_script = g_key_file_get_string(keyfile, "PANU Role",
 						"Script", &err);
@@ -176,13 +187,15 @@ done:
 		conf.gn_iface = g_strdup(GN_IFACE);
 	if (!conf.nap_iface)
 		conf.nap_iface = g_strdup(NAP_IFACE);
+	if (!conf.forward_delay)
+		conf.forward_delay = g_strdup(FORWARD_DELAY);
 
 	debug("Config options: InterfacePrefix=%s, PANU_Script=%s, "
 		"GN_Script=%s, NAP_Script=%s, GN_Interface=%s, "
-		"NAP_Interface=%s, Security=%s",
+		"NAP_Interface=%s, Security=%s, ForwardDelay=%s",
 		conf.iface_prefix, conf.panu_script, conf.gn_script,
 		conf.nap_script, conf.gn_iface, conf.nap_iface,
-		conf.security ? "true" : "false");
+		conf.security ? "true" : "false", conf.forward_delay);
 }
 
 static int network_probe(struct btd_device *device, GSList *uuids, uint16_t id)
@@ -343,7 +356,7 @@ int network_manager_init(DBusConnection *conn)
 	 * (setup connection request) contains the destination service
 	 * field that defines which service the source is connecting to.
 	 */
-	if (bridge_init(conf.gn_iface, conf.nap_iface) < 0) {
+	if (bridge_init(conf.gn_iface, conf.nap_iface, conf.forward_delay) < 0) {
 		error("Can't init bridge module");
 		return -1;
 	}


--------------010601070407090800070209--
