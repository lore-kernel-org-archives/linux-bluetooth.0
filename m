Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415722;
	b=fOS+dT6E11ZJfGsP3nMbrOC2Jmsx2z+EIZ2EhC6x83/zIfOKkaNnsCmY0sYvUXqE0um6
	 bvADV3i4k2os0fD3DMBgoXrnTLgTuG8kABJuUvHYQwgay0tZkCHXlNfxzJypw7sYUn2ER
	 n6Ee9GYXdcgX4RWZv4UlB5BHWzUc3jiCDW+Uh0nNbdHZ+SWaSQ8v4y4DngdlFGdyLz5r3
	 BHp9gNu2avIZ0GqhZvoVhrGvi9C5XVCBl+x+JB8jVg11Subt34D1xPXS7s9Bfv8+Er10Q
	 8otImnnTh2LuEpJGrUwK9qJ/5zn8q6mzxMuU2OhV+kiL1UDWevV1Dbchs/7OGU2MaCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415722;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yQ9X/ynb5TI8OmC40Ru4/2Lp7dFtqVVJNEK1dUdOKfk=;
	b=pL34NGhPBeQALICd0cZmWlb9Js9P8Z/eu8ZDknnu8q3ONT57r5YlHv9ExRzM2JqPDHaY
	 vopkGm4G/V9qxhKx/N7LUWir6BMgqNBKwynieClzGGEzy+j0eAYWlxRFSBMOhwGl6sfwl
	 gsk3I2K0D+deQkx1SHviHUq7aZiqLZeMLX4v87C5MqCRRfjNgoHgTWSh4W+e5Zf5QItIA
	 BDU0U0z9lKEpDGw6kuc42STWP2BNOSU7p/lAA8qkKx8kcqC9jQ6OUg/83iksUKsDOXb//
	 dt5QFEsFessNqqiKXSpVUlHImhiYfW7UEzsGS1/nbMxbkFLdt/kDYT6X1ATpvWQ9OjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g8O+Ykz4;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEFF606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 06:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CEFF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g8O+Ykz4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795415723; x=1826951723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PTbP411VJMLiRPlzihBpmxs2Xiimw+B+HsPzaKMuz5s=;
  b=g8O+Ykz47jWzCV6fuUBEWqykVm6CgSTbD5wpUfYDUWFMjK1yj4hn9WvN
   zunMiObAjTuE080/d4XMkdA94ITCjmPcXX7HKg8meIMuYpz2vS/XwK/0n
   q1Df6PDaCoxo3G9HFMKi+vxAfOCAadQsbJvQ7P/2sqUv8Nmk9IVgt9eoe
   gM6d6q9ERjTCw9hyzifA5XDAjTYMdg1/jIRonpbePhk0pAZ26At6/TD/j
   GPk9KtBUX7NRhj5qOk+PGWF6CASptJBTnD+5kJXQSA6U953j9mbV0kZ3j
   aIANF2B/FUyce43DhH1MQ3TvZZm0syyzg8iJg/fJBgdjTEWQS1mu99cPH
   w==;
X-CSE-ConnectionGUID: Y0m7cw1UTOKzmLq7EPuCiw==
X-CSE-MsgGUID: RY1GE9LPSnya3Rz/YEsi0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4316338"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4316338"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 22:35:23 -0800
X-CSE-ConnectionGUID: Eri9TdvdQGuSEpj+muYI+w==
X-CSE-MsgGUID: afRokok5Sh2d7mH8ACMRXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="12925781"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa012.fm.intel.com with ESMTP; 22 Nov 2026 22:35:21 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	ravindra@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/3] Bluetooth: btintel_pcie: Serialize doorbell writes and target reads
Date: Mon, 23 Nov 2026 12:25:22 +0530
Message-ID: <20261123065523.2769017-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123065523.2769017-1-kiran.k@intel.com>
References: <20261123065523.2769017-1-kiran.k@intel.com>
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

The controller must not see an access to HBUS_TARG_WRPTR at the same
time as an access to the PRPH_DEV_ADDR/PRPH_DEV_RD register pair used
for target access. Posting an RX buffer or ringing the TX doorbell while
a target read is in flight can produce invalid mailbox values. The
address/data pair also has to stay together, since several works
(mbox, hwexp, fwtrigger, coredump) read device memory concurrently.

Add dev_mem_lock and take it inside btintel_pcie_rd_dev_mem() and the new
btintel_pcie_wr_dev_mem() and btintel_pcie_wr_wrptr() helpers. The YoYo
config set writes use the same lock.

The critical sections are only a few MMIO accesses and never sleep, so a
spinlock is sufficient.

Fixes: d572ea4b621c ("Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt")
Fixes: 68e0925f16c0 ("Bluetooth: btintel_pcie: Add yoyo support for config set TLV")
Assisted-by: Copilot:claude-sonnet-5.5
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 15 +++++++--------
 drivers/bluetooth/btintel_pcie.h | 33 +++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d95127327c71..75f1724336ae 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -540,7 +540,7 @@ static void btintel_pcie_set_tx_db(struct btintel_pcie_data *data, u16 index)
 	val = index;
 	val |= (BTINTEL_PCIE_TX_DB_VEC << 16);
 
-	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR, val);
+	btintel_pcie_wr_wrptr(data, val);
 }
 
 /* Copy the data to next(@tfd_index) data buffer and update the TFD(transfer
@@ -754,7 +754,7 @@ static void btintel_pcie_set_rx_db(struct btintel_pcie_data *data, u16 index)
 	val = index;
 	val |= (BTINTEL_PCIE_RX_DB_VEC << 16);
 
-	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR, val);
+	btintel_pcie_wr_wrptr(data, val);
 }
 
 /* Update the FRBD (free buffer descriptor) with the @frbd_index and the
@@ -1075,7 +1075,10 @@ btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
 				}
 
 				BT_DBG("YoYo: CSR write [0x%08x] = 0x%08x", addr, value);
+				/* addr may be PRPH_DEV_* or HBUS_TARG_WRPTR */
+				spin_lock(&data->dev_mem_lock);
 				btintel_pcie_wr_reg32(data, addr, value);
+				spin_unlock(&data->dev_mem_lock);
 				break;
 			/* Indirect Address Access (Peripheral MAC and Device Memory) */
 			case BTINTEL_PCIE_CFGSET_PERIPH_MAC:
@@ -1089,12 +1092,7 @@ btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
 					continue;
 				}
 
-				btintel_pcie_wr_reg32(data,
-						      BTINTEL_PCIE_PRPH_DEV_ADDR_REG,
-						      addr);
-				btintel_pcie_wr_reg32(data,
-						      BTINTEL_PCIE_PRPH_DEV_WR_REG,
-						      value);
+				btintel_pcie_wr_dev_mem(data, addr, value);
 				BT_DBG("YoYo: indirect write type %u addr 0x%08x value 0x%08x",
 				       config_set->config_set_type, addr, value);
 				break;
@@ -4864,6 +4862,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	spin_lock_init(&data->irq_lock);
 	spin_lock_init(&data->hci_rx_lock);
 	spin_lock_init(&data->ipc_lock);
+	spin_lock_init(&data->dev_mem_lock);
 	mutex_init(&data->rfkill_doorbell_lock);
 
 	init_waitqueue_head(&data->gp0_wait_q);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 6b7cf3819f25..124e837da94b 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -769,6 +769,10 @@ struct btintel_pcie_data {
 	spinlock_t	hci_rx_lock;
 	/* lock to serialize IPC control register updates */
 	spinlock_t	ipc_lock;
+	/* lock to serialize HBUS_TARG_WRPTR writes against the PRPH_DEV_ADDR/
+	 * PRPH_DEV_RD target access register pair. Never sleep while held.
+	 */
+	spinlock_t	dev_mem_lock;
 
 	void __iomem	*base_addr;
 
@@ -880,9 +884,36 @@ static inline void btintel_pcie_clr_reg_bits(struct btintel_pcie_data *data,
 	iowrite32(r, data->base_addr + offset);
 }
 
+/* Caller must hold MAC access. The address/data register pair is accessed
+ * under dev_mem_lock so that it neither overlaps a HBUS_TARG_WRPTR write nor
+ * interleaves with another reader.
+ */
 static inline u32 btintel_pcie_rd_dev_mem(struct btintel_pcie_data *data,
 					  u32 addr)
 {
+	u32 val;
+
+	spin_lock(&data->dev_mem_lock);
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_PRPH_DEV_ADDR_REG, addr);
+	val = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_PRPH_DEV_RD_REG);
+	spin_unlock(&data->dev_mem_lock);
+
+	return val;
+}
+
+static inline void btintel_pcie_wr_dev_mem(struct btintel_pcie_data *data,
+					  u32 addr, u32 val)
+{
+	spin_lock(&data->dev_mem_lock);
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_PRPH_DEV_ADDR_REG, addr);
-	return btintel_pcie_rd_reg32(data, BTINTEL_PCIE_PRPH_DEV_RD_REG);
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_PRPH_DEV_WR_REG, val);
+	spin_unlock(&data->dev_mem_lock);
+}
+
+static inline void btintel_pcie_wr_wrptr(struct btintel_pcie_data *data,
+					 u32 val)
+{
+	spin_lock(&data->dev_mem_lock);
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR, val);
+	spin_unlock(&data->dev_mem_lock);
 }
-- 
2.54.0

