Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH 2/2] Rename fast_connectable function in hciops
Date: Fri, 17 Jun 2011 12:44:14 +0300
Message-Id: <1308303854-2017-2-git-send-email-antti.julku@nokia.com>
In-Reply-To: <1308303854-2017-1-git-send-email-antti.julku@nokia.com>
References: <1308303854-2017-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rename fast_connectable function in hciops to set_fast_connectable
to make it consistent with rest of the file and with mgmt interface
counterpart.
---
 plugins/hciops.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 6ce0e27..db4b9a4 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3107,7 +3107,7 @@ static int hciops_stop_discovery(int index)
 	}
 }
 
-static int hciops_fast_connectable(int index, gboolean enable)
+static int hciops_set_fast_connectable(int index, gboolean enable)
 {
 	struct dev_info *dev = &devs[index];
 	write_page_activity_cp cp;
@@ -3662,7 +3662,7 @@ static struct btd_adapter_ops hci_ops = {
 	.cancel_resolve_name = hciops_cancel_resolve_name,
 	.set_name = hciops_set_name,
 	.set_dev_class = hciops_set_dev_class,
-	.set_fast_connectable = hciops_fast_connectable,
+	.set_fast_connectable = hciops_set_fast_connectable,
 	.read_clock = hciops_read_clock,
 	.read_bdaddr = hciops_read_bdaddr,
 	.block_device = hciops_block_device,
-- 
1.7.2.5

