Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH BlueZ] Handle HCI emulator setup errors
Date: Thu,  1 Oct 2015 13:18:41 +0100
Message-Id: <1443701921-24460-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Missing return is causing confusing output from sco-tester:

  Read Index List callback
    Status: 0x00
  Failed to setup HCI emulation
eSCO CVSD - Success - pre setup failed
  New hciemu instance created
eSCO CVSD - Success - done
---
 tools/sco-tester.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index d55d51a3155faacb43742271c2e7ea6754b9f42c..651fbe01d14e59b4580704b3319196620d9d54e5 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -160,6 +160,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
 		tester_pre_setup_failed();
+		return;
 	}
 
 	tester_print("New hciemu instance created");
-- 
1.9.3

