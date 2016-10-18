Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 1/2] Bluetooth: Shorten complete name if no short name in set local name
Date: Tue, 18 Oct 2016 15:10:23 +0200
Message-Id: <1476796224-14476-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Generate shortened local name if no short name specified
to simplify appending local name to scan rsp data.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/mgmt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7360380..cc6e571 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3103,7 +3103,16 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
+	/* if no short name set and complete name is longer than max
+	 * short name length then shorten complete name
+	 */
+	if (!strlen(cp->short_name) &&
+	    (strlen(cp->name) > HCI_MAX_SHORT_NAME_LENGTH)) {
+		memcpy(hdev->short_name, cp->name, sizeof(hdev->short_name));
+	} else {
+		memcpy(hdev->short_name, cp->short_name,
+		       sizeof(hdev->short_name));
+	}
 
 	if (!hdev_is_powered(hdev)) {
 		memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
-- 
2.7.4

