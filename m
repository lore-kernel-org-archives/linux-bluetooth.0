Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use %zu print specifier for size_t type
Date: Fri, 28 Sep 2012 14:44:23 +0300
Message-Id: <1348832663-13569-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20120928011624.GB5522@localhost>
References: <20120928011624.GB5522@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Correct warnings reported by Fengguang Wu <fengguang.wu@intel.com>.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3151d85..82e478a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -883,7 +883,7 @@ static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
 	rem_len = __le16_to_cpu(rp->rem_len);
 
 	if (rem_len > frag_len) {
-		BT_DBG("frag_len %ld rem_len %ld", frag_len, rem_len);
+		BT_DBG("frag_len %zu rem_len %zu", frag_len, rem_len);
 
 		memcpy(assoc->data + assoc->offset, rp->frag, frag_len);
 		assoc->offset += frag_len;
-- 
1.7.9.5

