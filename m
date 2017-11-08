Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 2/2] plugins/sixaxis: Provide DualShock 3 SDP record while adding new device
Date: Wed,  8 Nov 2017 20:38:28 +0100
Message-Id: <20171108193828.5471-2-hadess@hadess.net>
In-Reply-To: <20171108193828.5471-1-hadess@hadess.net>
References: <20171108193828.5471-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to skip SDP search for DualShock 3 devices, since some
DS3 clones do not provide any SDP record. This allows them to operate
nonetheless.

The HID SDP record is lifted straight off an original DualShock 3
controller. The PNPID SDP record is not set as not required to provide
a working device.

Tested with a "SHANWAN" clone controller.
---
 plugins/sixaxis.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 22e4bb537..c5f90498d 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -40,6 +40,8 @@
 
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "lib/sdp.h"
 #include "lib/uuid.h"
 
 #include "src/adapter.h"
@@ -71,6 +73,8 @@ static guint watch_id = 0;
 /* key = sysfs_path (const str), value = auth_closure */
 static GHashTable *pending_auths = NULL;
 
+#define SIXAXIS_HID_SDP_RECORD "3601920900000A000100000900013503191124090004350D35061901000900113503190011090006350909656E09006A0901000900093508350619112409010009000D350F350D350619010009001335031900110901002513576972656C65737320436F6E74726F6C6C65720901012513576972656C65737320436F6E74726F6C6C6572090102251B536F6E7920436F6D707574657220456E7465727461696E6D656E740902000901000902010901000902020800090203082109020428010902052801090206359A35980822259405010904A101A102850175089501150026FF00810375019513150025013500450105091901291381027501950D0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0050175089527090181027508953009019102750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C0090207350835060904090901000902082800090209280109020A280109020B09010009020C093E8009020D280009020E2800"
+
 /* Make sure to unset auth_id if already handled */
 static void auth_closure_destroy(struct authentication_closure *closure,
 				bool remove_device)
@@ -360,6 +364,9 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 	btd_device_set_trusted(closure->device, true);
 	btd_device_set_temporary(closure->device, false);
 
+	if (closure->type == CABLE_PAIRING_SIXAXIS)
+		btd_device_set_record(closure->device, HID_UUID, SIXAXIS_HID_SDP_RECORD);
+
 	ba2str(&closure->bdaddr, device_addr);
 	ba2str(&master_bdaddr, master_addr);
 	ba2str(adapter_bdaddr, adapter_addr);
-- 
2.14.3

