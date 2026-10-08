Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A19E3033E1
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467157; cv=none; b=A1uo+rSiQ684TSXfcPkg5FV8LJ39G7QC4p3Nqk6+rLO/icD5ypjzyGgaHK4VYDYm9VfzPyX+xKNpUYvHv1ootEulzwsD9MsfIw6N0qzw5VSdQmNUu3Tg011ADC3/LefTrnr9aXQiXsU1iSY0QHohKOmKR/ACMkcjyBLIyYh+rlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467157; c=relaxed/simple;
	bh=dr34OAtewChzbflWYlz0X6YfhEXVdBRDiBuK7IslzgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4VMIjcOqPxUixMFjv3GX0XoSuP7bFu4NbDArPWNWdJCi3/mzfwSQV1J2W462ilDVCLAdx6L0Tek0W0HHEDCPyvsXsc1MbKyuPzEWx0fjx0+IWqKs5qJdg5Ho8JqOYX9/NWpOd1tLnLDRb41IPaxhdhGFvXsgiv/R6U9Kwc3ZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbH8+JF5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbH8+JF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791467156; x=1823003156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dr34OAtewChzbflWYlz0X6YfhEXVdBRDiBuK7IslzgA=;
  b=MbH8+JF5JSsNrZvEAdMIIx5Y5UQVlX1Mszg/PdiMrCnzTJ8MyRubeuUb
   H8+Gmp7Crg1XHtYJJVtkqhDv037qiz+a6UDs9ir0qz3fNRFHAJoWZ5Phd
   O3bofwdo+xSl4ob22zoqRPSEwMrQ8+vgcxmaP/1/r7XNZlfahJ32dmuov
   lNcl/64+DJN0TmDge6yymFddVeT0OifcbSC0GDyxyANDWpmievshNqxP9
   D7NPRhNoi9lcwp9wzNLb0TmPzm4fPpNYG00jLFpuQB5nfYJN+m2fIXoeG
   AozHHEcOicGVgYgPjW+ivtY6zVVILOoXy7B3dLizX97NLdQal6i4VhxjY
   w==;
X-CSE-ConnectionGUID: 2KRXqnC4RE6D+Ki2jOm/og==
X-CSE-MsgGUID: m8aiXdIASleaDmZVnvXgQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="260189"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="260189"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 06:45:55 -0700
X-CSE-ConnectionGUID: 0p40Ej3KS7mog9Ktfv8kOw==
X-CSE-MsgGUID: w6N4swTzT9Ws6BLxzU9noQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="368042"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa008.fm.intel.com with ESMTP; 08 Oct 2026 06:45:54 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 1/2] Bluetooth: btintel: Zero version data before parsing TLVs
Date: Thu,  8 Oct 2026 19:36:01 +0530
Message-ID: <20261008140602.2623464-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware may omit optional TLVs, leaving their corresponding fields
unset in the caller-supplied struct intel_version_tlv. Since the
structure is typically stack-allocated and not cleared beforehand,
fields for which no TLV is received retain uninitialized stack
memory. This stale data can be logged via btintel_version_info_tlv()
and copied back to the caller, leaking kernel stack contents.

Clear the structure in btintel_read_version_tlv() before parsing so
that fields with no corresponding TLV are deterministically zero
instead of containing garbage.

Fixes: 57375beef71a ("Bluetooth: btintel: Add infrastructure to read controller information")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index f298c91f4f4e..c4a6b5ea64f1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -752,6 +752,7 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 		return -EIO;
 	}
 
+	memset(version, 0, sizeof(*version));
 	err = btintel_parse_version_tlv(hdev, version, skb);
 
 	kfree_skb(skb);
-- 
2.54.0

