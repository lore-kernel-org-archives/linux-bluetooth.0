Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D314C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 10:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjB1Kxs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 05:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjB1KxZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 05:53:25 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383359EB
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 02:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677581513; x=1709117513;
  h=from:to:cc:subject:date:message-id;
  bh=PBh7oF+xmX3Dwr12D78FFTtthrJm7mEfp5YF6+Ko6k4=;
  b=C/ppi7y6htF/0+LHYTogxxRUNvYVChXXGnxjV03eqBxOYYnWKnp0XtpX
   RViXyv/wU+5i7s977K2gr+JIEQdysARiy+SiEggy5DGM+6/Vo1xQfW8lw
   7/zj/clqoyXggmAjjKUnCX7vc6J3uRxz1L1lzge+hMbA5hXAjPfc7Fexj
   goglVNtetT2on5NFpI8zEkWZLFy2IQ4F0gwywfkZX8jpK4QT32G0s4Wpe
   IikEuO+tmwwCDjs8Cv7+vZpBA2FdrVjLTzOjEM8i4JpcXqRBaU1qcWBDm
   WKCSqgGdPoyBKAdASnjONpC8ukNyO4x2lbOFe+pxXKS4+nujLbag0qVKj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314528973"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="314528973"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 02:51:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="817045276"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="817045276"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2023 02:51:13 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Iterate only bluetooth device ACPI entries
Date:   Tue, 28 Feb 2023 16:31:54 +0530
Message-Id: <20230228110154.18936-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Current flow interates over entire ACPI table entries looking for
Bluetooth Per Platform Antenna Gain(PPAG) entry. This patch iterates
over ACPI entries relvant to Bluetooth device only.

Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 44 +++++++++++++++++++-------------
 drivers/bluetooth/btintel.h      |  7 -----
 include/net/bluetooth/hci_core.h |  1 +
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bede8b005594..e8d4b59e89c5 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -26,7 +26,14 @@
 #define ECDSA_HEADER_LEN	320
 
 #define BTINTEL_PPAG_NAME   "PPAG"
-#define BTINTEL_PPAG_PREFIX "\\_SB_.PCI0.XHCI.RHUB"
+
+/* structure to store the PPAG data read from ACPI table */
+struct btintel_ppag {
+	u32	domain;
+	u32     mode;
+	acpi_status status;
+	struct hci_dev *hdev;
+};
 
 #define CMD_WRITE_BOOT_PARAMS	0xfc0e
 struct cmd_write_boot_params {
@@ -1295,17 +1302,16 @@ static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data
 
 	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
 	if (ACPI_FAILURE(status)) {
-		bt_dev_warn(hdev, "ACPI Failure: %s", acpi_format_exception(status));
+		bt_dev_warn(hdev, "PPAG-BT: ACPI Failure: %s", acpi_format_exception(status));
 		return status;
 	}
 
-	if (strncmp(BTINTEL_PPAG_PREFIX, string.pointer,
-		    strlen(BTINTEL_PPAG_PREFIX))) {
+	len = strlen(string.pointer);
+	if (len < strlen(BTINTEL_PPAG_NAME)) {
 		kfree(string.pointer);
 		return AE_OK;
 	}
 
-	len = strlen(string.pointer);
 	if (strncmp((char *)string.pointer + len - 4, BTINTEL_PPAG_NAME, 4)) {
 		kfree(string.pointer);
 		return AE_OK;
@@ -1314,7 +1320,8 @@ static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data
 
 	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		bt_dev_warn(hdev, "ACPI Failure: %s", acpi_format_exception(status));
+		ppag->status = status;
+		bt_dev_warn(hdev, "PPAG-BT: ACPI Failure: %s", acpi_format_exception(status));
 		return status;
 	}
 
@@ -1323,8 +1330,9 @@ static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data
 
 	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
 		kfree(buffer.pointer);
-		bt_dev_warn(hdev, "Invalid object type: %d or package count: %d",
+		bt_dev_warn(hdev, "PPAG-BT: Invalid object type: %d or package count: %d",
 			    p->type, p->package.count);
+		ppag->status = AE_ERROR;
 		return AE_ERROR;
 	}
 
@@ -1335,6 +1343,7 @@ static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data
 
 	ppag->domain = (u32)p->package.elements[0].integer.value;
 	ppag->mode = (u32)p->package.elements[1].integer.value;
+	ppag->status = AE_OK;
 	kfree(buffer.pointer);
 	return AE_CTRL_TERMINATE;
 }
@@ -2314,12 +2323,11 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 
 static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver)
 {
-	acpi_status status;
 	struct btintel_ppag ppag;
 	struct sk_buff *skb;
 	struct btintel_loc_aware_reg ppag_cmd;
 
-    /* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
+	/* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
 	switch (ver->cnvr_top & 0xFFF) {
 	case 0x504:     /* Hrp2 */
 	case 0x202:     /* Jfp2 */
@@ -2330,26 +2338,26 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	memset(&ppag, 0, sizeof(ppag));
 
 	ppag.hdev = hdev;
-	status = acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX, NULL,
-				     btintel_ppag_callback, &ppag, NULL);
+	ppag.status = AE_NOT_FOUND;
+	acpi_walk_namespace(ACPI_TYPE_PACKAGE, ACPI_HANDLE(GET_HCIDEV_DEV(hdev)),
+			    1, NULL, btintel_ppag_callback, &ppag, NULL);
 
-	if (ACPI_FAILURE(status)) {
-		/* Do not log warning message if ACPI entry is not found */
-		if (status == AE_NOT_FOUND)
+	if (ACPI_FAILURE(ppag.status)) {
+		if (ppag.status == AE_NOT_FOUND) {
+			bt_dev_dbg(hdev, "PPAG-BT: ACPI entry not found");
 			return;
-		bt_dev_warn(hdev, "PPAG: ACPI Failure: %s", acpi_format_exception(status));
+		}
 		return;
 	}
 
 	if (ppag.domain != 0x12) {
-		bt_dev_warn(hdev, "PPAG-BT Domain disabled");
+		bt_dev_warn(hdev, "PPAG-BT: domain is not bluetooth");
 		return;
 	}
 
 	/* PPAG mode, BIT0 = 0 Disabled, BIT0 = 1 Enabled */
 	if (!(ppag.mode & BIT(0))) {
-		bt_dev_dbg(hdev, "PPAG disabled");
+		bt_dev_dbg(hdev, "PPAG-BT: disabled");
 		return;
 	}
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 8e7da877efae..8fdb65b66315 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -137,13 +137,6 @@ struct intel_offload_use_cases {
 	__u8	preset[8];
 } __packed;
 
-/* structure to store the PPAG data read from ACPI table */
-struct btintel_ppag {
-	u32	domain;
-	u32     mode;
-	struct hci_dev *hdev;
-};
-
 struct btintel_loc_aware_reg {
 	__le32 mcc;
 	__le32 sel;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7254edfba4c9..6ed9b4d546a7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1613,6 +1613,7 @@ void hci_conn_add_sysfs(struct hci_conn *conn);
 void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->dev.parent = (pdev))
+#define GET_HCIDEV_DEV(hdev) ((hdev)->dev.parent)
 
 /* ----- LMP capabilities ----- */
 #define lmp_encrypt_capable(dev)   ((dev)->features[0][0] & LMP_ENCRYPT)
-- 
2.17.1

