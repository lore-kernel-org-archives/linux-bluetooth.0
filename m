Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Use lmp_ssp_capable where applicable
Date: Tue, 24 Jul 2012 15:03:48 -0300
Message-Id: <1343153033-898-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
References: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces all LMP_SIMPLE_PAIR bit checking by the helper
macro lmp_ssp_capable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 2 +-
 net/bluetooth/mgmt.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 498d55e..b120388 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -528,7 +528,7 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	if (hdev->features[7] & LMP_LSTO)
 		events[6] |= 0x80; /* Link Supervision Timeout Changed */
 
-	if (hdev->features[6] & LMP_SIMPLE_PAIR) {
+	if (lmp_ssp_capable(hdev)) {
 		events[6] |= 0x01;	/* IO Capability Request */
 		events[6] |= 0x02;	/* IO Capability Response */
 		events[6] |= 0x04;	/* User Confirmation Request */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0351bf27..a3329cb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -380,7 +380,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	settings |= MGMT_SETTING_DISCOVERABLE;
 	settings |= MGMT_SETTING_PAIRABLE;
 
-	if (hdev->features[6] & LMP_SIMPLE_PAIR)
+	if (lmp_ssp_capable(hdev))
 		settings |= MGMT_SETTING_SSP;
 
 	if (lmp_bredr_capable(hdev)) {
@@ -1121,7 +1121,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
+	if (!lmp_ssp_capable(hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
 				 MGMT_STATUS_NOT_SUPPORTED);
 		goto failed;
@@ -2201,7 +2201,7 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
+	if (!lmp_ssp_capable(hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
 				 MGMT_STATUS_NOT_SUPPORTED);
 		goto unlock;
-- 
1.7.11.2

