Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA1383AA
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711973535; cv=none; b=HAb2PkFICNgiSWZmTEqN2I3cvBCyZ1qpr2Dm6skDqylWrEO/NK58cb2vcu3G1cdvXbGtoJGydHNlvQcPjaPziDJo0FS23vMDlfSXj393eNjx3Br+0y2Vu6Eb5+je/wZweF73H7FCnLl5jptozBCJ+bnlffOBROYGB1bLeDrGCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711973535; c=relaxed/simple;
	bh=crgzU3wdhBfAO5fxKkFrZz3AjrsIAgXMLOZhqEsWg0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WXZ/AbbKuQSu2bP5BmruzaDrKn6UA3JRvfcj+lumTAZH/vx9aJ3bIHcgLSMDj5LZUhxOdkftfqEWB1s0vpuSkdRn+26FWQb+vEr4lzrm1UjQ8AjnyyDAU2bVdnPfcZmspdDedsUPXsU+EqUw6qN0rRHFcS6aWx/KXux49Qu1Jl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGJ8H4zY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGJ8H4zY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711973533; x=1743509533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=crgzU3wdhBfAO5fxKkFrZz3AjrsIAgXMLOZhqEsWg0Y=;
  b=GGJ8H4zYAb24FzrtXeSf7CAdAz92Ow5LvAwEKPDKLLNxqh8gaBOWjEBB
   bdHZVhbW9oliPE/O9W8N92D+QfyXjR4dvF2ksaX5PM+gn2n0Fsc3wvowP
   HJQ0vMtk20ddbduuZ+O54cH67kBZQTb/DkPeGGln0SAAlbJeQaS3MFz8A
   USOGf0MpGdBYqRAUW5Bxso3v/VvCzYV+HevP3q7iGwba/LbQ36bGFmbXn
   kVzZID8StrHfhB+Ly8JFdMqVk6mQtPeMdpcN71YOdrtu8GUIzO0TcLGWL
   PsLK/x+vaqdjZ+S6oAGK5y88F1TIKkaPLw9x52o9FPKB+mOrE8fcqY0pa
   g==;
X-CSE-ConnectionGUID: FMzBPfQST8mIh8qFnyUtwA==
X-CSE-MsgGUID: oivBc0ymRo+WCWSpWo9SNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="17668341"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17668341"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 05:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="22362866"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 01 Apr 2024 05:12:11 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: btintel: Dump exception event
Date: Mon,  1 Apr 2024 17:55:58 +0530
Message-Id: <20240401122559.1097489-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having exception event dump in kernel log helps debugging the use cases
where snoop traces are not available.

dmesg:

[27.032666] Bluetooth: hci0: Exception occurred - type: 0xde
[27.032703] Bluetooth: hci0: ff 4f 87 80 03 01 01 de 07 01 de 06 1c ef be ad
[27.032729] Bluetooth: hci0: de ef be ad de ef be ad de ef be ad de ef be ad
[27.032753] Bluetooth: hci0: de ef be ad de ef be ad de 05 14 ef be ad de ef
[27.032778] Bluetooth: hci0: be ad de ef be ad de ef be ad de ef be ad de 43
[27.032803] Bluetooth: hci0: 10 ef be ad de ef be ad de ef be ad de ef be ad
[27.032827] Bluetooth: hci0: de

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd95..c0dbbd1a2032 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3119,6 +3119,7 @@ EXPORT_SYMBOL_GPL(btintel_configure_setup);
 static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct intel_tlv *tlv = (void *)&skb->data[5];
+	char prefix[64];
 
 	/* The first event is always an event type TLV */
 	if (tlv->type != INTEL_TLV_TYPE_ID)
@@ -3129,6 +3130,12 @@ static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 	case INTEL_TLV_FATAL_EXCEPTION:
 	case INTEL_TLV_DEBUG_EXCEPTION:
 	case INTEL_TLV_TEST_EXCEPTION:
+		bt_dev_err(hdev, "Exception occurred - type: 0x%2.2x",
+			   tlv->val[0]);
+		snprintf(prefix, sizeof(prefix), "Bluetooth: %s: ",
+			 bt_dev_name(hdev));
+		print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_NONE, 16, 1,
+			       skb->data, skb->len, false);
 		/* Generate devcoredump from exception */
 		if (!hci_devcd_init(hdev, skb->len)) {
 			hci_devcd_append(hdev, skb);
-- 
2.34.1

