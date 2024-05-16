Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A224EB30
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861414; cv=none; b=to6N2MG6JqZ944zP/lwU420MWNbFdGFZYCqxay/1Uj0d60FwiE9wxM4UPrrjlBd0gDxhGT28aZ+BYzy63LE4UIExhkhB+AaCf38HluL7IfjnvPG+b4abOuvUcv56wl8hTYEbrZbIDunEfYN1p3eOw84rdTeW7yxs6jqC744IQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861414; c=relaxed/simple;
	bh=tdeRK8PXwyXnd7jKPooWvd2tI0Tf3H+d77nskytbmRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pO/yARLFDigqAtZJM/8ack0gc54KxniOSdK83APv5RjUAR70nIKIeZAHltq0ZlhWXPj6frYg1DjWjEILfaDKMtX+NSKojDbtsHZLQCLQhUNys1qZFP5O9OPc3VOD1HR16BThGATr8WqGQa8UVT06N29gs34W5RLLkM+RbiF1VgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXqru7Dv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXqru7Dv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715861412; x=1747397412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tdeRK8PXwyXnd7jKPooWvd2tI0Tf3H+d77nskytbmRc=;
  b=iXqru7DvLu7B07pt8I4IOHg9PeNcaFX24edfipzoU/Uh/0UNkvhNQPQ4
   Z/fbYfMzyw8g4lbnx4XfGZXrTJAOPTN9drkqZ4SaoUAwYxIQ4xB0nGQBG
   HVaCy+uBpoS7w9tktbCZH6QOtvYYqteIdsvN8A35xZks+FZadRUSayorf
   2YziLHMVzJlToyLV+uxeYoAj3jppl6HKeCmPa1rbK9huK8vTEHvfpYkSq
   FNSLQEp9XzmTrxpOB7/yRdKNHQBKbYTrO4LmBugmEwfLpu2j7sVNGxzAI
   M8fJuP5kG3iUXArOrvCp+3yLLisxRIqfAeEglB7HRFp0TVvYYyiuyE91o
   Q==;
X-CSE-ConnectionGUID: 42Chnm2yTu61DufwprP5Xw==
X-CSE-MsgGUID: f2NCRAuuRh+6hk4S8LpuBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23370725"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23370725"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 05:10:12 -0700
X-CSE-ConnectionGUID: GBaDO1o2QKedOUeLPvuYYw==
X-CSE-MsgGUID: PKT6N7kiTZ+8RdCbjYi4OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31404086"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 16 May 2024 05:10:10 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Refactor btintel_set_ppag()
Date: Thu, 16 May 2024 17:54:36 +0530
Message-Id: <20240516122436.880999-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current flow iterates the ACPI table associated with Bluetooth
controller looking for PPAG method. Method name can be directly passed
to acpi_evaluate_object function instead of iterating the table.

Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 119 +++++++++++-------------------------
 1 file changed, 34 insertions(+), 85 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0c855c3ee1c1..7ecc67deecb0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -26,21 +26,11 @@
 #define ECDSA_OFFSET		644
 #define ECDSA_HEADER_LEN	320
 
-#define BTINTEL_PPAG_NAME   "PPAG"
-
 enum {
 	DSM_SET_WDISABLE2_DELAY = 1,
 	DSM_SET_RESET_METHOD = 3,
 };
 
-/* structure to store the PPAG data read from ACPI table */
-struct btintel_ppag {
-	u32	domain;
-	u32     mode;
-	acpi_status status;
-	struct hci_dev *hdev;
-};
-
 #define CMD_WRITE_BOOT_PARAMS	0xfc0e
 struct cmd_write_boot_params {
 	__le32 boot_addr;
@@ -1324,65 +1314,6 @@ static int btintel_read_debug_features(struct hci_dev *hdev,
 	return 0;
 }
 
-static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data,
-					 void **ret)
-{
-	acpi_status status;
-	size_t len;
-	struct btintel_ppag *ppag = data;
-	union acpi_object *p, *elements;
-	struct acpi_buffer string = {ACPI_ALLOCATE_BUFFER, NULL};
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	struct hci_dev *hdev = ppag->hdev;
-
-	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
-	if (ACPI_FAILURE(status)) {
-		bt_dev_warn(hdev, "PPAG-BT: ACPI Failure: %s", acpi_format_exception(status));
-		return status;
-	}
-
-	len = strlen(string.pointer);
-	if (len < strlen(BTINTEL_PPAG_NAME)) {
-		kfree(string.pointer);
-		return AE_OK;
-	}
-
-	if (strncmp((char *)string.pointer + len - 4, BTINTEL_PPAG_NAME, 4)) {
-		kfree(string.pointer);
-		return AE_OK;
-	}
-	kfree(string.pointer);
-
-	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		ppag->status = status;
-		bt_dev_warn(hdev, "PPAG-BT: ACPI Failure: %s", acpi_format_exception(status));
-		return status;
-	}
-
-	p = buffer.pointer;
-	ppag = (struct btintel_ppag *)data;
-
-	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
-		kfree(buffer.pointer);
-		bt_dev_warn(hdev, "PPAG-BT: Invalid object type: %d or package count: %d",
-			    p->type, p->package.count);
-		ppag->status = AE_ERROR;
-		return AE_ERROR;
-	}
-
-	elements = p->package.elements;
-
-	/* PPAG table is located at element[1] */
-	p = &elements[1];
-
-	ppag->domain = (u32)p->package.elements[0].integer.value;
-	ppag->mode = (u32)p->package.elements[1].integer.value;
-	ppag->status = AE_OK;
-	kfree(buffer.pointer);
-	return AE_CTRL_TERMINATE;
-}
-
 static int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
@@ -2427,10 +2358,13 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 
 static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver)
 {
-	struct btintel_ppag ppag;
 	struct sk_buff *skb;
 	struct hci_ppag_enable_cmd ppag_cmd;
 	acpi_handle handle;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *p, *elements;
+	u32 domain, mode;
+	acpi_status status;
 
 	/* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
 	switch (ver->cnvr_top & 0xFFF) {
@@ -2448,22 +2382,34 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 		return;
 	}
 
-	memset(&ppag, 0, sizeof(ppag));
-
-	ppag.hdev = hdev;
-	ppag.status = AE_NOT_FOUND;
-	acpi_walk_namespace(ACPI_TYPE_PACKAGE, handle, 1, NULL,
-			    btintel_ppag_callback, &ppag, NULL);
-
-	if (ACPI_FAILURE(ppag.status)) {
-		if (ppag.status == AE_NOT_FOUND) {
+	status = acpi_evaluate_object(handle, "PPAG", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		if (status == AE_NOT_FOUND) {
 			bt_dev_dbg(hdev, "PPAG-BT: ACPI entry not found");
 			return;
 		}
+		bt_dev_warn(hdev, "PPAG-BT: ACPI Failure: %s", acpi_format_exception(status));
+		return;
+	}
+
+	p = buffer.pointer;
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
+		bt_dev_warn(hdev, "PPAG-BT: Invalid object type: %d or package count: %d",
+			    p->type, p->package.count);
+		kfree(buffer.pointer);
 		return;
 	}
 
-	if (ppag.domain != 0x12) {
+	elements = p->package.elements;
+
+	/* PPAG table is located at element[1] */
+	p = &elements[1];
+
+	domain = (u32)p->package.elements[0].integer.value;
+	mode = (u32)p->package.elements[1].integer.value;
+	kfree(buffer.pointer);
+
+	if (domain != 0x12) {
 		bt_dev_dbg(hdev, "PPAG-BT: Bluetooth domain is disabled in ACPI firmware");
 		return;
 	}
@@ -2474,19 +2420,22 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	 * BIT 1 : 0 Disabled in China
 	 *         1 Enabled in China
 	 */
-	if ((ppag.mode & 0x01) != BIT(0) && (ppag.mode & 0x02) != BIT(1)) {
-		bt_dev_dbg(hdev, "PPAG-BT: EU, China mode are disabled in CB/BIOS");
+	mode &= 0x03;
+
+	if (!mode) {
+		bt_dev_dbg(hdev, "PPAG-BT: EU, China mode are disabled in BIOS");
 		return;
 	}
 
-	ppag_cmd.ppag_enable_flags = cpu_to_le32(ppag.mode);
+	ppag_cmd.ppag_enable_flags = cpu_to_le32(mode);
 
-	skb = __hci_cmd_sync(hdev, INTEL_OP_PPAG_CMD, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, INTEL_OP_PPAG_CMD, sizeof(ppag_cmd),
+			     &ppag_cmd, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR_ERR(skb));
 		return;
 	}
-	bt_dev_info(hdev, "PPAG-BT: Enabled (Mode %d)", ppag.mode);
+	bt_dev_info(hdev, "PPAG-BT: Enabled (Mode %d)", mode);
 	kfree_skb(skb);
 }
 
-- 
2.40.1

