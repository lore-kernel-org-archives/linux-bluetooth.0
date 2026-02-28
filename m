Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F43D7D96
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268854; cv=none; b=fyKPTAi9dBW57DCq4PiyM2dF9ohKGJ6QnoTUdseUZ4DDDF8cGB6EUa+KS1I0v8oUJDcthvFtVGayJM2a6YaO0ipQXaqfYtalX2e3MTOi8F+zGG/LVSKxIoNZGoOYfJOLLFaYpVkOOxEBG+e1H0OphDQb+xiK8v0++5lkMgi3sJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268854; c=relaxed/simple;
	bh=WlhDSIpyqr2Da0J/dcmI9CcPz0H4X6+yYkUQavZVNIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMtkLzObW0RSMdCaaO6RB6XicjnqHZ/OUFupFGGwOYnJ97fWDUX0IccrWw6n+VYh8LdI/oEhkNG1FzGfFAK3IaB+/wfGkk6LtnEWgIU3IL079sZsXrPXM0H6LKXZFu12db976uGV9MbdXxyLulUoVWBT0l6lOzBW9qOOHPT/aXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVjrznC5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVjrznC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772268853; x=1803804853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WlhDSIpyqr2Da0J/dcmI9CcPz0H4X6+yYkUQavZVNIM=;
  b=eVjrznC58WRRGuhNVyxVJRaf53ZtIH2MJuJtIpIUlBPHm8Z7g15bkXpm
   /YeIg16eM2ggs36ApkSTiZuES0KUyh1+JeKeZBv9OsAJ8b6WOuqpNgcW3
   QLxzLlaUhVoRCBjDUcS4cNRHhD/r63Bol3eUQZBo4OuLvzVzt/QXh/01a
   /RK7HHJgoze/JA+Ybn3Z9gWfs/4CDn1rfe2nbKtUyquXlsQhiUmiz0HhP
   ++A60N0d/bc+F+xSbUbP1CH+mapgkWUoQP1mS6DZ/GqI0fwWuczZFyOA5
   X3n6U0RHcXuY7+pCsRgwlLpABCho498Y6bXhh1trfliOW95TqGGVwaXp2
   g==;
X-CSE-ConnectionGUID: yQz9+ihVQkGujP0fUxGg2w==
X-CSE-MsgGUID: QUXjax8GRTOiDg2avr8C3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77189243"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="77189243"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 00:54:13 -0800
X-CSE-ConnectionGUID: qRK5muApRWqtjshGYSrPZA==
X-CSE-MsgGUID: MunHdxZUQbypToncrWUZvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221630156"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2026 00:54:11 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 6/9] Bluetooth: btintel: Add support for Scorpious Peak2F support
Date: Sat, 28 Feb 2026 14:42:36 +0530
Message-ID: <20260228091239.230284-6-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228091239.230284-1-kiran.k@intel.com>
References: <20260228091239.230284-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Intel Bluetooth Scorpious Peak2F core.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index b3cbb61065d1..b6dd3ab830c7 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -498,6 +498,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1e:	/* BlazarI (Bzr) */
 	case 0x1f:      /* Scorpious Peak */
 	case 0x20:	/* Scorpious Peak2 */
+	case 0x21:	/* Scorpious Peak2 F */
 	case 0x22:	/* BlazarIW (BzrIW) */
 		break;
 	default:
@@ -3325,6 +3326,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x1e:
 	case 0x1f:
 	case 0x20:
+	case 0x21:
 	case 0x22:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
@@ -3667,6 +3669,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x1e:
 	case 0x1f:
 	case 0x20:
+	case 0x21:
 	case 0x22:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 83b09a63eae1..5f281403bcfa 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2108,6 +2108,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
 	case 0x20:	/* ScP2 */
+	case 0x21:	/* ScP2 F */
 	case 0x22:	/* BzrIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
-- 
2.43.0

