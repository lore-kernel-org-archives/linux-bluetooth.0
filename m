Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v1 2/3] profile: Fix remotely initiated connections without service
Date: Tue,  7 May 2013 09:44:03 +0200
Message-Id: <1367912644-17401-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367912644-17401-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367912644-17401-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Remotely initiated connections need to be associated to a service
instance to avoid the following crash as reported by Vinicius Costa:

bluetoothd[14366]: src/profile.c:ext_confirm() incoming connect from A0:4E:04:F6:F5:05
bluetoothd[14366]: src/profile.c:ext_confirm() hfp_hf authorizing connection from A0:4E:04:F6:F5:05
bluetoothd[14366]: src/agent.c:agent_ref() 0x6a85e0: ref=2
bluetoothd[14366]: src/agent.c:agent_authorize_service() authorize service request was sent for /org/bluez/hci0/dev_A0_4E_04_F6_F5_05
bluetoothd[14366]: src/profile.c:ext_svc_complete() Services resolved for A0:4E:04:F6:F5:05
bluetoothd[14366]: src/profile.c:ext_svc_complete() Services resolved but still waiting for authorization
bluetoothd[14366]: src/profile.c:ext_auth() A0:4E:04:F6:F5:05 authorized to connect to hfp_hf
bluetoothd[14366]: src/agent.c:agent_unref() 0x6a85e0: ref=1
bluetoothd[14366]: src/profile.c:ext_connect() hfp_hf connected to A0:4E:04:F6:F5:05

Program received signal SIGSEGV, Segmentation fault.
btd_service_connecting_complete (service=0x0, err=err@entry=0) at src/service.c:315
315		if (service->state != BTD_SERVICE_STATE_DISCONNECTED &&
---
 src/profile.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index 0500983..6a71627 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1044,6 +1044,7 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 						bdaddr_t *src, bdaddr_t *dst)
 {
 	struct btd_device *device;
+	struct btd_service *service;
 	struct ext_io *conn;
 	GIOCondition cond;
 
@@ -1055,9 +1056,15 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 
 	device = adapter_find_device(server->adapter, dst);
 
-	if (device)
+	if (device) {
 		conn->device = btd_device_ref(device);
 
+		service = btd_device_get_service(device,
+						server->ext->remote_uuid);
+		if (service)
+			conn->service = btd_service_ref(service);
+	}
+
 	cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	conn->io_id = g_io_add_watch(io, cond, ext_io_disconnected, conn);
 
-- 
1.8.1.4

