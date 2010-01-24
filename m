Return-Path: <cyrus@holtmann.org>
Message-ID: <4B5C737F.8030304@gmx.de>
Date: Sun, 24 Jan 2010 17:21:19 +0100
From: Thomas Egerer <hakke_007@gmx.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] add configurable support for bridge forward delay
Content-Type: multipart/mixed;
 boundary="------------090904050600030800070004"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090904050600030800070004
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
 network/bridge.c  |   97
++++++++++++++++++++++++++++++++++++++++++++++++++++-
 network/bridge.h  |    3 +-
 network/manager.c |   19 +++++++++--
 3 files changed, 114 insertions(+), 5 deletions(-)

--------------090904050600030800070004
Content-Type: text/x-patch;
 name="771fcb1abb3b5ba53a589816ad8bbb1d21e23a01.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="771fcb1abb3b5ba53a589816ad8bbb1d21e23a01.diff"

diff --git a/network/bridge.c b/network/bridge.c
index f3528ad..842cd02 100644
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
@@ -33,6 +35,7 @@
 #include <sys/types.h>
 #include <net/if.h>
 #include <linux/sockios.h>
+#include <linux/if_bridge.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
@@ -43,10 +46,95 @@
 #include "common.h"
 
 static int bridge_socket = -1;
+static unsigned long int forward_delay = 1500;
 static const char *gn_bridge = NULL;
 static const char *nap_bridge = NULL;
 
-int bridge_init(const char *gn_iface, const char *nap_iface)
+/**
+ * convert the given string to the corresponding value in 
+ * jiffies; small helper function since a bridge's forward
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
+	int ret, *ptr = NULL;
+	static int done[] = { 0, 0 };
+	struct ifreq ifr;
+	const char *name;
+	unsigned long data[4] = { BRCTL_SET_BRIDGE_FORWARD_DELAY,
+			delay, 0, 0 };
+
+	name = bridge_get_name(id);
+	/* invalid id */
+	if (!name)
+		return -EINVAL;
+
+	if (BNEP_SVC_NAP == id)
+		ptr = &done[0];
+	else if (BNEP_SVC_GN == id)
+		ptr = &done[1];
+	else
+		return -EINVAL;
+
+	/* operation already done... */
+	if (1 == *ptr)
+		return 0;
+
+	strncpy(ifr.ifr_name, name, IFNAMSIZ);
+	ifr.ifr_data = (char *)&data;
+	// FIXME ioctl is marked deprecated, and might disappear...
+	ret = ioctl(bridge_socket, SIOCDEVPRIVATE, &ifr);
+
+	if (0 > ret)
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
@@ -64,6 +152,9 @@ int bridge_init(const char *gn_iface, const char *nap_iface)
 	gn_bridge = gn_iface;
 	nap_bridge = nap_iface;
 
+	/* ignore return value, default is 1500 anyway... */
+	__str_to_jiffies(fwd_delay, &forward_delay);
+
 	return 0;
 }
 
@@ -132,6 +223,10 @@ int bridge_add_interface(int id, const char *dev)
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


--------------090904050600030800070004--
