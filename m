Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use individual flags for certain management events
Date: Mon, 29 Aug 2016 06:19:46 +0200
Message-Id: <1472444387-129975-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of hiding everything behind a general managment events flag,
introduce indivdual flags that allow fine control over which events are
send to a given management channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  5 ++++-
 net/bluetooth/hci_sock.c    |  5 ++++-
 net/bluetooth/mgmt.c        | 32 +++++++++++++-------------------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0aac123b5eee..ddb9accac3a5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -208,7 +208,10 @@ enum {
 	HCI_MGMT_INDEX_EVENTS,
 	HCI_MGMT_UNCONF_INDEX_EVENTS,
 	HCI_MGMT_EXT_INDEX_EVENTS,
-	HCI_MGMT_GENERIC_EVENTS,
+	HCI_MGMT_OPTION_EVENTS,
+	HCI_MGMT_SETTING_EVENTS,
+	HCI_MGMT_DEV_CLASS_EVENTS,
+	HCI_MGMT_LOCAL_NAME_EVENTS,
 	HCI_MGMT_OOB_DATA_EVENTS,
 };
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 3e6a649a0601..0a3f2f380345 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1164,7 +1164,10 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 			hci_sock_set_flag(sk, HCI_MGMT_INDEX_EVENTS);
 			hci_sock_set_flag(sk, HCI_MGMT_UNCONF_INDEX_EVENTS);
-			hci_sock_set_flag(sk, HCI_MGMT_GENERIC_EVENTS);
+			hci_sock_set_flag(sk, HCI_MGMT_OPTION_EVENTS);
+			hci_sock_set_flag(sk, HCI_MGMT_SETTING_EVENTS);
+			hci_sock_set_flag(sk, HCI_MGMT_DEV_CLASS_EVENTS);
+			hci_sock_set_flag(sk, HCI_MGMT_LOCAL_NAME_EVENTS);
 		}
 		break;
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9071886df194..d84924b38262 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -256,13 +256,6 @@ static int mgmt_limited_event(u16 event, struct hci_dev *hdev, void *data,
 			       flag, skip_sk);
 }
 
-static int mgmt_generic_event(u16 event, struct hci_dev *hdev, void *data,
-			      u16 len, struct sock *skip_sk)
-{
-	return mgmt_send_event(event, hdev, HCI_CHANNEL_CONTROL, data, len,
-			       HCI_MGMT_GENERIC_EVENTS, skip_sk);
-}
-
 static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 len,
 		      struct sock *skip_sk)
 {
@@ -579,8 +572,8 @@ static int new_options(struct hci_dev *hdev, struct sock *skip)
 {
 	__le32 options = get_missing_options(hdev);
 
-	return mgmt_generic_event(MGMT_EV_NEW_CONFIG_OPTIONS, hdev, &options,
-				  sizeof(options), skip);
+	return mgmt_limited_event(MGMT_EV_NEW_CONFIG_OPTIONS, hdev, &options,
+				  sizeof(options), HCI_MGMT_OPTION_EVENTS, skip);
 }
 
 static int send_options_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
@@ -1007,8 +1000,8 @@ static int new_settings(struct hci_dev *hdev, struct sock *skip)
 {
 	__le32 ev = cpu_to_le32(get_current_settings(hdev));
 
-	return mgmt_generic_event(MGMT_EV_NEW_SETTINGS, hdev, &ev,
-				  sizeof(ev), skip);
+	return mgmt_limited_event(MGMT_EV_NEW_SETTINGS, hdev, &ev,
+				  sizeof(ev), HCI_MGMT_SETTING_EVENTS, skip);
 }
 
 int mgmt_new_settings(struct hci_dev *hdev)
@@ -3000,8 +2993,8 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (err < 0)
 			goto failed;
 
-		err = mgmt_generic_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev,
-					 data, len, sk);
+		err = mgmt_limited_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, data,
+					 len, HCI_MGMT_LOCAL_NAME_EVENTS, sk);
 
 		goto failed;
 	}
@@ -6502,8 +6495,9 @@ void __mgmt_power_off(struct hci_dev *hdev)
 	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
 
 	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)
-		mgmt_generic_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
-				   zero_cod, sizeof(zero_cod), NULL);
+		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
+				   zero_cod, sizeof(zero_cod),
+				   HCI_MGMT_DEV_CLASS_EVENTS, NULL);
 
 	new_settings(hdev, match.sk);
 
@@ -7100,8 +7094,8 @@ void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
 
 	if (!status)
-		mgmt_generic_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
-				   dev_class, 3, NULL);
+		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class,
+				   3, HCI_MGMT_DEV_CLASS_EVENTS, NULL);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -7130,8 +7124,8 @@ void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 			return;
 	}
 
-	mgmt_generic_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
-			   cmd ? cmd->sk : NULL);
+	mgmt_limited_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
+			   HCI_MGMT_LOCAL_NAME_EVENTS, cmd ? cmd->sk : NULL);
 }
 
 static inline bool has_uuid(u8 *uuid, u16 uuid_count, u8 (*uuids)[16])
-- 
2.7.4

