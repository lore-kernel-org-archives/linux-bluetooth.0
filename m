Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 2/3] Bluetooth: Fix local name validation
Date: Thu, 22 Sep 2016 16:01:38 +0200
Message-Id: <1474552899-3837-2-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1474552899-3837-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1474552899-3837-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Short name should be shorter than complete name
and it should be a prefix of complete name.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/mgmt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7b2bac4..5709377 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3099,6 +3099,24 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static bool name_is_valid(u8 *complete_name, u8 *short_name)
+{
+	size_t complete_len = strlen(complete_name);
+	size_t short_len = strlen(short_name);
+
+	if (complete_len <= short_len)
+		return false;
+
+	/* Core Specification Supplement, A, 1.2.1:
+	 * A shortened name shall only contain contiguous characters from
+	 * the beginning of the full name.
+	 */
+	if (strncmp(short_name, complete_name, short_len) != 0)
+		return false;
+
+	return true;
+}
+
 static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 len)
 {
@@ -3122,6 +3140,12 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	if (!name_is_valid(cp->name, cp->short_name)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto failed;
+	}
+
 	memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
 
 	if (!hdev_is_powered(hdev)) {
-- 
2.7.4

