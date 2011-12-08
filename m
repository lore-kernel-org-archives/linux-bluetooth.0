Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hciemu v2 2/2] Print features for AMP devices
Date: Thu,  8 Dec 2011 10:54:37 +0200
Message-Id: <1323334477-32179-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1323334477-32179-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323334477-32179-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check for HCI device type, the magic shift is due to dev type is packed
to dev_info type.
---
 tools/hciconfig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 35b80b1..a7249db 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1870,7 +1870,7 @@ static void print_dev_info(int ctl, struct hci_dev_info *di)
 		st->byte_tx, st->acl_tx, st->sco_tx, st->cmd_tx, st->err_tx);
 
 	if (all && !hci_test_bit(HCI_RAW, &di->flags) &&
-			bacmp(&di->bdaddr, BDADDR_ANY)) {
+			(bacmp(&di->bdaddr, BDADDR_ANY) || (di->type >> 4))) {
 		print_dev_features(di, 0);
 		print_pkt_type(di);
 		print_link_policy(di);
-- 
1.7.4.1

