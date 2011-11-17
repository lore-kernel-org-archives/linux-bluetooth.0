Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hciconfig] Print features for AMP devices
Date: Thu, 17 Nov 2011 14:52:35 +0200
Message-Id: <1321534355-9517-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check for HCI device type, the magic shift is due to dev type is packed
to dev_info type.
---
 tools/hciconfig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index cbd0d0e..0ee41ef 100644
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

