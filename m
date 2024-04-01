Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520320DD2
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711970903; cv=none; b=C9yzgl+9lCneMEqLRuiHnFxSJY9k2X/hK60HzKOR1wjcEKXgc+QG6UdZWY7NoExBICOGjRBJTRrWrh1OBKE5kSC2k5SfyifITGyAss89Goavv4Ezhxul8w2cnRACsGUsW9xrUNd2CfwRcXGhE4GMJZGksTiGqHOzD19iwOfil4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711970903; c=relaxed/simple;
	bh=NtNfgLoQS1qaenlry7e410aNwdTWCjE4QIoU2Nl3qOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCngsrkSH1XyPJvJTmMv5wKq3PKbMlPyfnoFFGjDs+BkUWCJk7UxGyEt8qK6S3mxYRlWn96NCcK5MhYr4o6LP/3h4cvaoiRnpK/2Lp91jnsxNMmYBB5VdeSVI49F098/q/V6ok+KMbOjJ6mFChxpaD/UhDl2xGW5Ob93vn0Qbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNKdjhSy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNKdjhSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711970901; x=1743506901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NtNfgLoQS1qaenlry7e410aNwdTWCjE4QIoU2Nl3qOg=;
  b=dNKdjhSyc3SdYMtBvRwsIRGDcD+dKYjfFscwj6C3AYceT83OPT5xSM4x
   cRbJ94+gIkpS05whhFSg/4l7ZXcaEo8htR6IAJ2/a6IZNA90HBD6XCq8f
   /GUls9iYNfce5qNoz+buxpKgyb3ANW8HX/HCQ9xZASGWRJvVdaLuj8hvu
   HJ8ZIUeBZUpxlAcTXGDTT2ZJBQTM/ypeVWuALl8nKLN6So7HoODflkLnR
   QOcDNk66jntmDFw7uVBtuIv4NUq4hEjclmCROnCjxzWhiGkwlJYnRbljw
   dc+mrsVzJjjHrY046MqRYPoOTgnZQjZX73bZKLgzkSGUVeztAgrYy5JN0
   Q==;
X-CSE-ConnectionGUID: FwyAW4/PQpG1yDPEolZnrQ==
X-CSE-MsgGUID: ox4o/docTWqDtBdOKmTD7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6958019"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="6958019"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 04:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="18148552"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 01 Apr 2024 04:28:19 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel: Dump exception event
Date: Mon,  1 Apr 2024 17:12:14 +0530
Message-Id: <20240401114214.1082870-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401114214.1082870-1-kiran.k@intel.com>
References: <20240401114214.1082870-1-kiran.k@intel.com>
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
index f2670bc2367c..5c38fadf4c32 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3119,6 +3119,7 @@ EXPORT_SYMBOL_GPL(btintel_configure_setup);
 static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct intel_tlv *tlv = (void *)&skb->data[5];
+	char buff[64];
 
 	/* The first event is always an event type TLV */
 	if (tlv->type != INTEL_TLV_TYPE_ID)
@@ -3129,6 +3130,12 @@ static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 	case INTEL_TLV_FATAL_EXCEPTION:
 	case INTEL_TLV_DEBUG_EXCEPTION:
 	case INTEL_TLV_TEST_EXCEPTION:
+		bt_dev_err(hdev, "Exception occurred - type: 0x%2.2x",
+			   tlv->val[0]);
+		snprintf(buff, sizeof(buff), "Bluetooth: %s: ",
+			 bt_dev_name(hdev));
+		print_hex_dump(KERN_ERR, buff, DUMP_PREFIX_NONE, 16, 1,
+			       skb->data, skb->len, false);
 		/* Generate devcoredump from exception */
 		if (!hci_devcd_init(hdev, skb->len)) {
 			hci_devcd_append(hdev, skb);
-- 
2.34.1

