Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 06/11] plugins/sixaxis: Rename sixaxis specific functions
Date: Wed, 18 Oct 2017 03:58:10 +0200
Message-Id: <20171018015815.10045-6-hadess@hadess.net>
In-Reply-To: <20171018015815.10045-1-hadess@hadess.net>
References: <20171018015815.10045-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

And provide wrappers to prepare for the addition of other device types.
---
 plugins/sixaxis.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 1bc64e1c4..69b1041e1 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -55,13 +55,14 @@ struct authentication_closure {
 	struct btd_device *device;
 	int fd;
 	bdaddr_t bdaddr; /* device bdaddr */
+	CablePairingType type;
 };
 
 static struct udev *ctx = NULL;
 static struct udev_monitor *monitor = NULL;
 static guint watch_id = 0;
 
-static int get_device_bdaddr(int fd, bdaddr_t *bdaddr)
+static int sixaxis_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 {
 	uint8_t buf[18];
 	int ret;
@@ -82,7 +83,14 @@ static int get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int get_master_bdaddr(int fd, bdaddr_t *bdaddr)
+static int get_device_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType type)
+{
+	if (type == CABLE_PAIRING_SIXAXIS)
+		return sixaxis_get_device_bdaddr(fd, bdaddr);
+	return -1;
+}
+
+static int sixaxis_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
 {
 	uint8_t buf[8];
 	int ret;
@@ -103,7 +111,14 @@ static int get_master_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
+static int get_master_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType type)
+{
+	if (type == CABLE_PAIRING_SIXAXIS)
+		return sixaxis_get_master_bdaddr(fd, bdaddr);
+	return -1;
+}
+
+static int sixaxis_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 {
 	uint8_t buf[8];
 	int ret;
@@ -121,6 +136,14 @@ static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 	return ret;
 }
 
+static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr,
+					CablePairingType type)
+{
+	if (type == CABLE_PAIRING_SIXAXIS)
+		return sixaxis_set_master_bdaddr(fd, bdaddr);
+	return -1;
+}
+
 static void agent_auth_cb(DBusError *derr,
 				void *user_data)
 {
@@ -136,12 +159,12 @@ static void agent_auth_cb(DBusError *derr,
 
 	btd_device_set_temporary(closure->device, false);
 
-	if (get_master_bdaddr(closure->fd, &master_bdaddr) < 0)
+	if (get_master_bdaddr(closure->fd, &master_bdaddr, closure->type) < 0)
 		goto error;
 
 	adapter_bdaddr = btd_adapter_get_address(closure->adapter);
 	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
-		if (set_master_bdaddr(closure->fd, adapter_bdaddr) < 0)
+		if (set_master_bdaddr(closure->fd, adapter_bdaddr, closure->type) < 0)
 			goto error;
 	}
 
@@ -164,6 +187,7 @@ static bool setup_device(int fd,
 				uint16_t vid,
 				uint16_t pid,
 				uint16_t version,
+				CablePairingType type,
 				struct btd_adapter *adapter)
 {
 	bdaddr_t device_bdaddr;
@@ -171,7 +195,7 @@ static bool setup_device(int fd,
 	struct btd_device *device;
 	struct authentication_closure *closure;
 
-	if (get_device_bdaddr(fd, &device_bdaddr) < 0)
+	if (get_device_bdaddr(fd, &device_bdaddr, type) < 0)
 		return false;
 
 	/* This can happen if controller was plugged while already connected
@@ -206,6 +230,7 @@ static bool setup_device(int fd,
 	closure->device = device;
 	closure->fd = fd;
 	bacpy(&closure->bdaddr, &device_bdaddr);
+	closure->type = type;
 	adapter_bdaddr = btd_adapter_get_address(adapter);
 	btd_request_authorization_cable_configured(adapter_bdaddr, &device_bdaddr,
 				HID_UUID, agent_auth_cb, closure);
@@ -271,7 +296,7 @@ static void device_added(struct udev_device *udevice)
 	}
 
 	/* Only close the fd if an authentication is not pending */
-	if (!setup_device(fd, name, source, vid, pid, version, adapter))
+	if (!setup_device(fd, name, source, vid, pid, version, type, adapter))
 		close(fd);
 
 	g_free(name);
-- 
2.14.2

