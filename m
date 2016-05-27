Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Fix checking flags for non-connectable advertisements
Date: Fri, 27 May 2016 12:52:01 +0300
Message-Id: <1464342721-24307-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Supplement to Bluetooth Core Specification | CSSv6, Part A page 12:

  "The Flags data type shall be included when any of the Flag bits
   are non-zero and the advertising packet is connectable, otherwise
   the Flags data type may be omitted."

So checking the flags is not really necessary for non-connectable and
even tools/eddystone don't set it which makes bluetoothd unable to
expose it.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index f4fbf82..71b3f14 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5451,7 +5451,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 	memset(&eir_data, 0, sizeof(eir_data));
 	eir_parse(&eir_data, data, data_len);
 
-	if (bdaddr_type == BDADDR_BREDR)
+	if (bdaddr_type == BDADDR_BREDR || not_connectable)
 		discoverable = true;
 	else
 		discoverable = eir_data.flags & (EIR_LIM_DISC | EIR_GEN_DISC);
-- 
2.5.5

