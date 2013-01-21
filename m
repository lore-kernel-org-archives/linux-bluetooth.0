Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v4 3/4] Bluetooth: Change type of "discovering" from u8 to bool
Date: Mon, 21 Jan 2013 19:43:38 +0530
Message-id: <1358777619-27018-3-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1358777619-27018-1-git-send-email-jaganath.k@samsung.com>
References: <1358777619-27018-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the only possible values of discovering is 0 and 1, bool is
more appropriate

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |    4 ++--
 net/bluetooth/mgmt.c             |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d8f68c7..f20da05 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1114,7 +1114,7 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_start_discovery_cancelled(struct hci_dev *hdev);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
-int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
+int mgmt_discovering(struct hci_dev *hdev, bool discovering);
 int mgmt_interleaved_discovery(struct hci_dev *hdev);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 596660d..ce6a696 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -326,12 +326,12 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	switch (state) {
 	case DISCOVERY_STOPPED:
 		if (hdev->discovery.state != DISCOVERY_STARTING)
-			mgmt_discovering(hdev, 0);
+			mgmt_discovering(hdev, false);
 		break;
 	case DISCOVERY_STARTING:
 		break;
 	case DISCOVERY_FINDING:
-		mgmt_discovering(hdev, 1);
+		mgmt_discovering(hdev, true);
 		break;
 	case DISCOVERY_RESOLVING:
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3527095..ba5ca81 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3757,7 +3757,7 @@ int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
+int mgmt_discovering(struct hci_dev *hdev, bool discovering)
 {
 	struct mgmt_ev_discovering ev;
 	struct pending_cmd *cmd;
-- 
1.7.9.5

