Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Send global configuration updates to all management users
Date: Sat, 14 Mar 2015 19:14:28 -0700
Message-Id: <1426385668-7973-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes to the global configuration updates like settings, class of
device, name etc. can be received by every user. They are allowed to
read them in the first place so provide the updates via events as
well. Otherwise untrusted users start polling for updates and that
is not a desired behavior.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_sock.c    |  5 +++++
 net/bluetooth/mgmt.c        | 34 ++++++++++++++++++++--------------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7a24acaafeea..7f41c7741e76 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -185,6 +185,7 @@ enum {
 	HCI_MGMT_INDEX_EVENTS,
 	HCI_MGMT_UNCONF_INDEX_EVENTS,
 	HCI_MGMT_EXT_INDEX_EVENTS,
+	HCI_MGMT_GENERIC_EVENTS,
 };
 
 /*
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index f4b10344b1e5..7c719602dbca 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -808,10 +808,15 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		 * socket when binding keeps this functionality. They
 		 * however might be cleared later and then sending of these
 		 * events will be disabled, but that is then intentional.
+		 *
+		 * This also enables generic events that are safe to be
+		 * received by untrusted users. Example for such events
+		 * are changes to settings, class of device, name etc.
 		 */
 		if (haddr.hci_channel == HCI_CHANNEL_CONTROL) {
 			hci_sock_set_flag(sk, HCI_MGMT_INDEX_EVENTS);
 			hci_sock_set_flag(sk, HCI_MGMT_UNCONF_INDEX_EVENTS);
+			hci_sock_set_flag(sk, HCI_MGMT_GENERIC_EVENTS);
 		}
 		break;
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fe2dc753787f..981dfb4f94f0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -260,6 +260,13 @@ static int mgmt_index_event(u16 event, struct hci_dev *hdev, void *data,
 			       flag, NULL);
 }
 
+static int mgmt_generic_event(u16 event, struct hci_dev *hdev, void *data,
+			      u16 len, struct sock *skip_sk)
+{
+	return mgmt_send_event(event, hdev, HCI_CHANNEL_CONTROL, data, len,
+			       HCI_MGMT_GENERIC_EVENTS, skip_sk);
+}
+
 static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 len,
 		      struct sock *skip_sk)
 {
@@ -607,8 +614,8 @@ static int new_options(struct hci_dev *hdev, struct sock *skip)
 {
 	__le32 options = get_missing_options(hdev);
 
-	return mgmt_event(MGMT_EV_NEW_CONFIG_OPTIONS, hdev, &options,
-			  sizeof(options), skip);
+	return mgmt_generic_event(MGMT_EV_NEW_CONFIG_OPTIONS, hdev, &options,
+				  sizeof(options), skip);
 }
 
 static int send_options_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
@@ -1552,11 +1559,10 @@ failed:
 
 static int new_settings(struct hci_dev *hdev, struct sock *skip)
 {
-	__le32 ev;
-
-	ev = cpu_to_le32(get_current_settings(hdev));
+	__le32 ev = cpu_to_le32(get_current_settings(hdev));
 
-	return mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), skip);
+	return mgmt_generic_event(MGMT_EV_NEW_SETTINGS, hdev, &ev,
+				  sizeof(ev), skip);
 }
 
 int mgmt_new_settings(struct hci_dev *hdev)
@@ -3677,8 +3683,8 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (err < 0)
 			goto failed;
 
-		err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, data, len,
-				 sk);
+		err = mgmt_generic_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev,
+					 data, len, sk);
 
 		goto failed;
 	}
@@ -6673,8 +6679,8 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
 
 	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)
-		mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
-			   zero_cod, sizeof(zero_cod), NULL);
+		mgmt_generic_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
+				   zero_cod, sizeof(zero_cod), NULL);
 
 new_settings:
 	err = new_settings(hdev, match.sk);
@@ -7325,8 +7331,8 @@ void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 	mgmt_pending_foreach(MGMT_OP_REMOVE_UUID, hdev, sk_lookup, &match);
 
 	if (!status)
-		mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev, dev_class, 3,
-			   NULL);
+		mgmt_generic_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
+				   dev_class, 3, NULL);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -7355,8 +7361,8 @@ void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 			return;
 	}
 
-	mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
-		   cmd ? cmd->sk : NULL);
+	mgmt_generic_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
+			   cmd ? cmd->sk : NULL);
 }
 
 void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
-- 
2.1.0

