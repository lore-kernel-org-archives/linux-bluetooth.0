Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>,
        Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 3/3] Bluetooth: Expire advertisement if name or appearance changed
Date: Wed,  7 Sep 2016 22:40:37 +0200
Message-Id: <1473280837-4093-3-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1473280837-4093-1-git-send-email-szymon.janc@codecoup.pl>
References: <1473280837-4093-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

Expire currently advertised instance if it contains appearance or
name and one of those is being changed.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5eb8716..9be23b5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3015,6 +3015,39 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
+static void adv_expire(struct hci_dev *hdev, u32 flags)
+{
+	struct adv_info *adv_instance, *n, *next_instance;
+	u8 schedule_instance = 0;
+	struct hci_request req;
+	int err;
+
+	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
+		if (hdev->cur_adv_instance != adv_instance->instance)
+			continue;
+
+		/* stop if current instance doesn't need to be changed */
+		if (!(adv_instance->flags & flags))
+			break;
+
+		cancel_adv_timeout(hdev);
+
+		next_instance = hci_get_next_instance(hdev,
+						      adv_instance->instance);
+		if (next_instance)
+			schedule_instance = next_instance->instance;
+		break;
+	}
+
+	if (!schedule_instance)
+		return;
+
+	hci_req_init(&req, hdev);
+	err = __hci_req_schedule_adv_instance(&req, schedule_instance, true);
+	if (!err)
+		hci_req_run(&req, NULL);
+}
+
 static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct mgmt_cp_set_local_name *cp;
@@ -3030,13 +3063,17 @@ static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	cp = cmd->param;
 
-	if (status)
+	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
 			        mgmt_status(status));
-	else
+	} else {
 		mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
 				  cp, sizeof(*cp));
 
+		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+			adv_expire(hdev, MGMT_ADV_FLAG_LOCAL_NAME);
+	}
+
 	mgmt_pending_remove(cmd);
 
 unlock:
@@ -3132,11 +3169,8 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
-		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_APPEARANCE,
-				MGMT_STATUS_BUSY);
-		goto failed;
-	}
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+		adv_expire(hdev, MGMT_ADV_FLAG_APPEARANCE);
 
 	hdev->appearance = cp->appearance;
 
-- 
2.7.4

