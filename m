Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Fix long_term_keys debugfs output
Date: Thu, 30 Jan 2014 19:39:57 -0800
Message-Id: <1391139600-15366-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
References: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The code was previously iterating the wrong list (and what's worse
casting entries to a type which they were not) and also missing a proper
line terminator when printing each entry. The code now also prints the
LTK type in hex for easier comparison with the kernel-defined values.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 369d30750417..8094a41c9a26 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -620,9 +620,9 @@ static int long_term_keys_show(struct seq_file *f, void *ptr)
 	struct list_head *p, *n;
 
 	hci_dev_lock(hdev);
-	list_for_each_safe(p, n, &hdev->link_keys) {
+	list_for_each_safe(p, n, &hdev->long_term_keys) {
 		struct smp_ltk *ltk = list_entry(p, struct smp_ltk, list);
-		seq_printf(f, "%pMR (type %u) %u %u %u %.4x %*phN %*phN\\n",
+		seq_printf(f, "%pMR (type %u) %u 0x%02x %u %.4x %*phN %*phN\n",
 			   &ltk->bdaddr, ltk->bdaddr_type, ltk->authenticated,
 			   ltk->type, ltk->enc_size, __le16_to_cpu(ltk->ediv),
 			   8, ltk->rand, 16, ltk->val);
-- 
1.8.5.3

