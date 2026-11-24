Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795480770;
	b=RMwPRVeIX1bAXMRunULzSmWn1zAns1tNzDBR9vYmlJsLsikdGj0YUBRiQRINCJq7JHMW
	 lerMswQJVdhIsP7kBcl5BOpZilErR21KG0m/KX0J+ku57Z4noAa7dwD1gATWvE+2sIFNB
	 hjKlntyIQs2/an4J8BMbTyKTqZw2pc6qioXkKVcAlZZW01CZVGqFxPSBfRzptfNbTXN+K
	 uXjAEZ5nyQi6NZEqCvM7N+w6Y5vckSpGqvXuitVGuDE8UjDbRz5MwvZHwHW4VTILWglyB
	 Z0rdJbKmfFI1OMYctjulHGBYHSs8vNrM0wR3jts79pnuoqvyjEyoRRRZ4GZqzDFYf4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795480770;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=E7lHDRoZZDlLF9Vk6ZjGwMQE93FuNNjxt06lTW8nudE=;
	b=WJmzAHQuhowAx52/R7iSwTNCYFex8exQ4qXctwqFBOKu7mWmyvM1Ek+29W6xq9bhSMHa
	 aAQRlvU0D8/v9J/zIRHY/wl3NCsFvl6W2kuOg7ON6e0tWQ1cddsir6B2Z79+1Sj6g0Nbt
	 yKwn6rDzYZcnaZUsv5EEXLo+xen3En+rwaSkBM4dbGUlKvK/lnJYY56FhsVGw7IFx2SLc
	 W+8hGiQ30ZmmNBfhZuWxO6/A+pWvA7HQvoe90AjgKh4DXTTOi1Z3lZPCDV98LruKiMpA1
	 nQC59BMG+hDgxNU1mrO3wY9mhAYdj1R25Pt6jknD7t/Xo/TryuLfD6C6fvf7NG1oQcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JUpf+S0P;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83DC606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 00:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C83DC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JUpf+S0P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795480770; x=1827016770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rvoPIcDxz61ipvcJsgnGaUH17DDTTZIeJKG2qxhXxJ4=;
  b=JUpf+S0P7/AZqoD7WWRCLRoaKc/qUq+8YPs6aD8xQyykpZU79zXq6S/r
   Ck/FKcXaDqaQs9x8A8BUKNNhM1MU3hwvgLYLhtJHn9hmppqxHxyLJLBbu
   AMQIPHEYuVUlwyyNWAXlGmXb1snoBAuAMETVkJtlb6gRUKcRJ9lOP+iKK
   pJxAY24wnfHXiEeHBLWvSXH0negcn4CriuHJrTkkWW68IgoIwU7sujcGz
   mB4OKRYr1u7WdvmsCaOCrodjo0zkNFRGfLNBFCY3RQBRsKfZQMIn57bHB
   F4B0KrKdYl9Jmg7qjlN8uIT3WJy1+BbkSAf1drWPwmtjxQE03kYnZL/P1
   g==;
X-CSE-ConnectionGUID: O7uqIO1sQ1CYXEfnislwow==
X-CSE-MsgGUID: Ab4WJisqSGCoF/w2hbGqCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4210287"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4210287"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 16:39:29 -0800
X-CSE-ConnectionGUID: bvjCpGlSQvam/fo9AJ6quQ==
X-CSE-MsgGUID: 1ETKpyZ4RPijNpfydud6pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11207069"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 16:39:28 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Fix RX hdev publication race
Date: Tue, 24 Nov 2026 06:29:39 +0530
Message-ID: <20261124005939.2981368-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_register_dev() queues hci_power_on without waiting for
hdev->setup(), so setup can run before btintel_pcie_setup_hdev()
returns and publishes data->hdev. Publish data->hdev at the start of
hdev->setup(), when the hdev is fully registered, so the command/event
exchange finds it. Publishing before registration would expose a
partially initialised hdev to RX and the dump workers.

The race is seen as a NULL pointer dereference in the RX work while
hdev->setup() is still running:

  Oops: general protection fault, kernel NULL pointer dereference 0xc28: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 904 Comm: kworker/u35:1 Tainted: G C OE 7.3.0-nvl-ww44-2bkc #2 PREEMPT(lazy)
  Hardware name: Intel Corporation Nova Lake Client Platform/NVL UPH/UL LP5X T3 MEMSKT RVP5, BIOS NVLPFWR1.R00.3414.D22.2610141025 10/14/2026
  Workqueue: btintel_pcie btintel_pcie_rx_work [btintel_pcie]
  RIP: 0010:btintel_pcie_recv_frame.isra.0+0xc8/0x3c0 [btintel_pcie]
  Call Trace:
   <TASK>
   btintel_pcie_rx_work+0x24/0x40 [btintel_pcie]
   process_one_work+0x1dc/0x3f0
   worker_thread+0x1b8/0x360
   kthread+0xf9/0x130
   ret_from_fork+0x2c3/0x380
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Drop received frames when data->hdev is unavailable to avoid NULL
dereferences.

Fixes: 6e65a09f9275 ("Bluetooth: btintel_pcie: Add *setup* function to download firmware")
Assisted-by: Copilot:claude-sonnet-5.5
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 3b2c8bbb36e9..4aff83ba1bbd 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2533,7 +2533,15 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 	u32 plen;
 	u32 pcie_pkt_type;
 	void *pdata;
-	struct hci_dev *hdev = data->hdev;
+	struct hci_dev *hdev = READ_ONCE(data->hdev);
+
+	/* RX can start before hdev is published (see btintel_pcie_setup()).
+	 * No command can be pending yet, so drop the frame.
+	 */
+	if (!hdev) {
+		kfree_skb(skb);
+		return -ENODEV;
+	}
 
 	spin_lock(&data->hci_rx_lock);
 
@@ -2953,10 +2961,11 @@ static void btintel_pcie_coredump_worker(struct work_struct *work)
 	struct btintel_pcie_data *data = container_of(work,
 					struct btintel_pcie_data, coredump_work);
 
-	/* hdev is NULL until setup_hdev() succeeds, and is cleared on
+	/* hdev is NULL until it is registered and published by
+	 * btintel_pcie_setup() or btintel_pcie_setup_hdev(), and is cleared on
 	 * teardown after disable_work_sync() drains us; bail in that case.
 	 */
-	if (!data->hdev)
+	if (!READ_ONCE(data->hdev))
 		goto out;
 
 	/* When firmware routes debug traces to the WiFi DBGC, no host
@@ -4273,6 +4282,12 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
 	bool fips_crc_failed;
 
+	/* hci_register_dev() only queues setup(), so it can run before
+	 * setup_hdev() returns. hdev is registered by now; publish it so RX
+	 * and the dump workers can use it.
+	 */
+	WRITE_ONCE(data->hdev, hdev);
+
 	btintel_pcie_fatal_err_load(data);
 
 	while ((err = btintel_pcie_setup_internal(hdev, &fips_crc_failed)) &&
@@ -4846,11 +4861,8 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 		return err;
 	}
 
-	/* Publish hdev only after successful registration; the coredump
-	 * worker bails on !data->hdev, so it never observes a half-set-up
-	 * device.
-	 */
-	data->hdev = hdev;
+	/* Idempotent: setup() may already have published hdev. */
+	WRITE_ONCE(data->hdev, hdev);
 	data->dmp_hdr.driver_name = KBUILD_MODNAME;
 	return 0;
 }
-- 
2.54.0

