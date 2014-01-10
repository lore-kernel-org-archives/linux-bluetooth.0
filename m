Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v6 1/4] android/pan: Register Network Access Point
Date: Fri, 10 Jan 2014 15:50:37 +0200
Message-Id: <1389361840-5021-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389361840-5021-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389361840-5021-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register NAP server and adds bnep bridge. Removes bridge
on destroy call. Bridge mechanism is needed when device acting
as a server and listen for incoming connections.
---
 android/pan.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 107 insertions(+), 5 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 38e353d..ea0e34e 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -28,6 +28,11 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <glib.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <net/if.h>
+#include <linux/sockios.h>
 
 #include "btio/btio.h"
 #include "lib/bluetooth.h"
@@ -45,11 +50,11 @@
 #include "bluetooth.h"
 
 #define SVC_HINT_NETWORKING 0x02
+#define BNEP_BRIDGE	"bnep"
 
 static bdaddr_t adapter_addr;
 GSList *devices = NULL;
 uint8_t local_role = HAL_PAN_ROLE_NONE;
-static uint32_t record_id = 0;
 
 struct pan_device {
 	char		iface[16];
@@ -60,6 +65,12 @@ struct pan_device {
 	struct bnep	*session;
 };
 
+static struct {
+	uint32_t	record_id;
+} nap_dev = {
+	.record_id = 0,
+};
+
 static int device_cmp(gconstpointer s, gconstpointer user_data)
 {
 	const struct pan_device *dev = s;
@@ -297,6 +308,89 @@ failed:
 	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT, status);
 }
 
+static int set_forward_delay(void)
+{
+	int fd, ret;
+	char path[41];
+
+	sprintf(path, "/sys/class/net/%s/bridge/forward_delay", BNEP_BRIDGE);
+
+	fd = open(path, O_RDWR);
+	if (fd < 0)
+		return -errno;
+
+	ret = write(fd, "0", sizeof("0"));
+	close(fd);
+
+	return ret;
+}
+
+static int nap_create_bridge(void)
+{
+	int sk, err;
+
+	DBG("%s", BNEP_BRIDGE);
+
+	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (sk < 0)
+		return -EOPNOTSUPP;
+
+	if (ioctl(sk, SIOCBRADDBR, BNEP_BRIDGE) < 0) {
+		err = -errno;
+		if (err != -EEXIST) {
+			close(sk);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	err = set_forward_delay();
+	if (err < 0)
+		ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
+
+	close(sk);
+
+	return err;
+}
+
+static int nap_remove_bridge(void)
+{
+	int sk, err;
+
+	DBG("%s", BNEP_BRIDGE);
+
+	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (sk < 0)
+		return -EOPNOTSUPP;
+
+	err = ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
+	close(sk);
+
+	if (err < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void destroy_nap_device(void)
+{
+	DBG("");
+
+	nap_remove_bridge();
+}
+
+static int register_nap_server(void)
+{
+	int err;
+
+	DBG("");
+
+	err = nap_create_bridge();
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static void bt_pan_enable(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_pan_enable *cmd = buf;
@@ -437,11 +531,18 @@ bool bt_pan_register(const bdaddr_t *addr)
 	err = bnep_init();
 	if (err) {
 		error("bnep init failed");
-		sdp_record_free(rec);
+		bt_adapter_remove_record(rec->handle);
+		return false;
+	}
+
+	err = register_nap_server();
+	if (err < 0) {
+		bt_adapter_remove_record(rec->handle);
+		bnep_cleanup();
 		return false;
 	}
 
-	record_id = rec->handle;
+	nap_dev.record_id = rec->handle;
 	ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
@@ -455,6 +556,7 @@ void bt_pan_unregister(void)
 	bnep_cleanup();
 
 	ipc_unregister(HAL_SERVICE_ID_PAN);
-	bt_adapter_remove_record(record_id);
-	record_id = 0;
+	bt_adapter_remove_record(nap_dev.record_id);
+	nap_dev.record_id = 0;
+	destroy_nap_device();
 }
-- 
1.8.3.2

