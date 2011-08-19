Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Read local extended features at the initialization
Date: Fri, 19 Aug 2011 17:30:41 -0300
Message-Id: <1313785841-24047-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1313785841-24047-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1313785841-24047-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Local extended features bitmask may change when Write LE Host Supported
Command is sent by the kernel. This patch adds reading of the local
extended features in the initialization sending a HCI command, extend
the ioctl HCIGETDEVINFO is not suitable due possible inconsistency
between kernel and userspace.
---
 plugins/hciops.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 0f8f79d..ddff544 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1372,20 +1372,6 @@ static inline void remote_features_notify(int index, void *ptr)
 	write_features_info(&dev->bdaddr, &evt->bdaddr, NULL, evt->features);
 }
 
-static void write_le_host_complete(int index, uint8_t status)
-{
-	struct dev_info *dev = &devs[index];
-	uint8_t page_num = 0x01;
-
-	if (status)
-		return;
-
-	if (hci_send_cmd(dev->sk, OGF_INFO_PARAM,
-				OCF_READ_LOCAL_EXT_FEATURES, 1, &page_num) < 0)
-		error("Unable to read extended local features: %s (%d)",
-						strerror(errno), errno);
-}
-
 static void read_local_version_complete(int index,
 				const read_local_version_rp *rp)
 {
@@ -1801,9 +1787,6 @@ static inline void cmd_complete(int index, void *ptr)
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY_CANCEL):
 		cc_inquiry_cancel(index, status);
 		break;
-	case cmd_opcode_pack(OGF_HOST_CTL, OCF_WRITE_LE_HOST_SUPPORTED):
-		write_le_host_complete(index, status);
-		break;
 	case cmd_opcode_pack(OGF_LE_CTL, OCF_LE_SET_SCAN_ENABLE):
 		cc_le_set_scan_enable(index, status);
 		break;
@@ -2498,6 +2481,13 @@ static void device_devup_setup(int index)
 	bacpy(&dev->bdaddr, &di.bdaddr);
 	memcpy(dev->features, di.features, 8);
 
+	if (dev->features[7] & LMP_EXT_FEAT) {
+		uint8_t page_num = 0x01;
+
+		hci_send_cmd(dev->sk, OGF_INFO_PARAM,
+				OCF_READ_LOCAL_EXT_FEATURES, 1, &page_num);
+	}
+
 	/* Set page timeout */
 	if ((main_opts.flags & (1 << HCID_SET_PAGETO))) {
 		write_page_timeout_cp cp;
-- 
1.7.6

