Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/2] neard: Set device UUIDs from EIR
Date: Sat, 18 Jan 2014 13:42:59 +0100
Message-Id: <1390048980-16670-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle UUIDs received in EIR from neard in same way as UUIDs received
on device discovery.
---
 plugins/neard.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 35fdaeb..da6e37c 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -643,7 +643,8 @@ static void store_params(struct btd_adapter *adapter, struct btd_device *device,
 		btd_device_device_set_name(device, params->name);
 	}
 
-	/* TODO handle UUIDs? */
+	if (params->services)
+		device_add_eir_uuids(device, params->services);
 
 	if (params->hash) {
 		btd_adapter_add_remote_oob_data(adapter, &params->address,
-- 
1.8.5.3

