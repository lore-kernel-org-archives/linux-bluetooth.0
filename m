Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4721FF49
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692565; cv=none; b=fv0TKCqOnycImjN0RBohldMpxgntL0yLrdcFJxF29ASMMq7KpfnvAvfS7Wvrx4QZqi9Tgy7VcVoV58Xy1acgRHlav1/xn5GHKyK0KBROzdkj5pzORE4budz4Nkf992XZdNdAGRMmBECvnJvlFICjPKfX15owMjYI3sCbEb+U3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692565; c=relaxed/simple;
	bh=YnVahnKsa1LWVgLdegvJa5k8ARcFkBGHpOuGp818N+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpzBFbxvUIjSCwz6KSrzygeX1hwneTtbsl8Gto5NedTlPAHclvLSbpbqJOxem6zN3pMnP5GQTs0p9Xh5jU+2GZPJTWpm1l1mt0Uvj8HDw3CnxJrrbuCcsDB+5wZ7tkxb/ZaI4y+d+CjHRhRhIrv9bURIRfkinFICcFw8VSEd1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvTDkZwX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvTDkZwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753692563; x=1785228563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YnVahnKsa1LWVgLdegvJa5k8ARcFkBGHpOuGp818N+A=;
  b=jvTDkZwX2KmWLEfSihzDKTEzDZJTh2Fof8++Pp70cDsAfdV7YrDC1ejf
   gIhtNOdAsxeiGZTjephRzGxm+ecjW3VWNX1XJu6DCK7sIKKBKXxXsMBor
   SCSmvjnjZyYUNQNhoV2FYEby+C7nuXlRv9wH13wd9obW5dNJRtAShAAjD
   ieLq+CQlhhOsxejNJqAWWwND6iSXwIywLXCKlr2vuR6PmrHFnM6pXFxsH
   JsT7AggYKYb3HBvGjcSuWQySR7+Uthp1U0HSRXwlPMUK9UTx5enY1ued3
   S3ieXX0I8MRUzG1Twb12NWqHwMzt1Jbq7R3xKhYkSORJ+0dii1n8y+fPR
   g==;
X-CSE-ConnectionGUID: u1I0iaxkSq2kD9WIcWwcLA==
X-CSE-MsgGUID: qbMr4tHBQHGJ930bLeNIXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="66504897"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66504897"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 01:49:23 -0700
X-CSE-ConnectionGUID: WfE2ChSiT0OrGQfQ8+Clxg==
X-CSE-MsgGUID: 1YaJawnzSzSV1Rq/7k4yaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="167770828"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa005.jf.intel.com with ESMTP; 28 Jul 2025 01:49:22 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/2] Bluetooth: btintel_pcie: Add support for device
Date: Mon, 28 Jul 2025 14:35:54 +0530
Message-ID: <20250728090554.1425120-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728090554.1425120-1-kiran.k@intel.com>
References: <20250728090554.1425120-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sudo lspci -v -k -d 8086:e376
00:14.7 Bluetooth: Intel Corporation Device e376
        Subsystem: Intel Corporation Device 0011
        Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 14
        Memory at 14815368000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable+ Count=32 Masked-
        Capabilities: [100] Latency Tolerance Reporting
        Kernel driver in use: btintel_pcie
        Kernel modules: btintel_pcie

Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v2:
    - No change

 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 8f02c27bc544..c0c3e17a4fa4 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -37,6 +37,7 @@
 static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) }, /* BlazarI, Wildcat Lake */
 	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) }, /* BlazarI, Lunar Lake */
+	{ BTINTEL_PCI_DEVICE(0xE376, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H484 */
 	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H404 */
 	{ 0 }
 };
-- 
2.43.0

