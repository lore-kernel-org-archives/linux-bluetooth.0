Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core: Fix crash on device removal
Date: Fri, 30 Jan 2015 15:04:35 +0200
Message-Id: <1422623075-6319-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1422623075-6319-1-git-send-email-luiz.dentz@gmail.com>
References: <1422623075-6319-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following crash happen when attempting to remove a device while it
is connecting, this will turn all services to unavailable without first
setting it to disconnected causing the backtrace:

Invalid read of size 8
   at 0x495BF8: btd_service_connect (service.c:200)
   by 0x49D942: connect_next.isra.7 (device.c:1283)
   by 0x4A2B82: device_profile_connected (device.c:1328)
   by 0x4A2B82: service_state_changed (device.c:5325)
   by 0x4957A9: change_state (service.c:108)
   by 0x495AF4: service_remove (service.c:173)
   by 0x4A4BD9: device_remove (device.c:3207)
   by 0x48AAC1: btd_adapter_remove_device (adapter.c:1135)
   by 0x48B536: remove_device (adapter.c:2270)
   by 0x4BF4CB: process_message.isra.3 (object.c:259)
   by 0x4BFD12: generic_message (object.c:1070)
   by 0x518C5CE: ??? (in /usr/lib64/libdbus-1.so.3.8.10)
   by 0x517E193: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.8.10)
 Address 0x7a22e60 is 16 bytes inside a block of size 40 free'd
   at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E847FE: g_free (in /usr/lib64/libglib-2.0.so.0.4200.1)
   by 0x495988: btd_service_unref (service.c:130)
   by 0x495B26: service_remove (service.c:177)
   by 0x4A4BD9: device_remove (device.c:3207)
   by 0x48AAC1: btd_adapter_remove_device (adapter.c:1135)
   by 0x48B536: remove_device (adapter.c:2270)
   by 0x4BF4CB: process_message.isra.3 (object.c:259)
   by 0x4BFD12: generic_message (object.c:1070)
   by 0x518C5CE: ??? (in /usr/lib64/libdbus-1.so.3.8.10)
   by 0x517E193: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.8.10)
   by 0x4BA45F: message_dispatch (mainloop.c:72)
---
 src/service.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/service.c b/src/service.c
index b66b1c9..8c85cd1 100644
--- a/src/service.c
+++ b/src/service.c
@@ -170,6 +170,7 @@ int service_probe(struct btd_service *service)
 
 void service_remove(struct btd_service *service)
 {
+	change_state(service, BTD_SERVICE_STATE_DISCONNECTED, -ECONNABORTED);
 	change_state(service, BTD_SERVICE_STATE_UNAVAILABLE, 0);
 	service->profile->device_remove(service);
 	service->device = NULL;
-- 
2.1.0

