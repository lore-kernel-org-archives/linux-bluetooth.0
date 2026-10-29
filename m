Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266426;
	b=wztb/wFogq2nsW9W5EWIQO3ww+yqfRIptS1h5Zb38mxjHVLmucZLqiTeOH9nGooCdBOQ
	 xQI6/oXgy3U502kjXx+eiYIUGNZOFhkAJL19XTcpqjEPyoCa+4ujemn9iog/4inOSkNAA
	 z9i+fRxD5QS0fQKJGOKsrkHbn7SrMw++9sE73f/juGzmqREbJjjT3Qo4okaMYz9c+p6ox
	 IuH9JluQB9W76CWxnZsP2Xs4r7XQohAoc8CevcYVJoue3eJ04jCXXqInAOM2NGSksQguJ
	 CXdzmyhzEHwNRcO6JhZ+XtAi8rqgGbNkHVIXxw3NUrnH5ZgqBfmS4ZwPV5emGSCSOMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266426;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J2kGObaG3A061HcXau2S+MuYV5crRNCiNjKurRvfNT4=;
	b=FuVyRUpmj/9LU7vPN7qWOy60arANuaIeUKnK3VECQvlDmhjgVFX9ctGjBgBG40xRtylj
	 vtmQG0oUu39WadoaqQaqN6VDCc0GB5mbGCUwK8jH9cXG5ivY2liwSowfOQ4dUTLiwTK/5
	 wmJeyG7mbNU2/8yDQyJBZyKOVB+P6kk0553R7ZkmYrldU8WMp5++q7M9uxkHfYVgzg18O
	 PPz9VBtgsRYkTD9hUiH+cnFk1gJE5IgCDyxfbU/A3fyaNaANwlNjpLqhWfRbJj0fGxnFT
	 mHtb2yne3279mCIg3RQjz2bUmLLiuaJqPjbwDUPnwsNrYaqSAmXzbvbfe8LjyrMlRog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LvjaVSg6;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB8606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 09:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95DB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LvjaVSg6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793266424; x=1824802424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OEVzWmNmrHY7Nmehw8QstwdPE9+zRmk8P22M3ES/fMM=;
  b=LvjaVSg6XBZK7cz63CNbUu6iAZhuYNNOqHfT2qu+s2Ci8KCKd6VgFz2i
   M9vIvoImGNLFWaBKK6cN4ML3jRuEMxfCoCRi8awgmJOEbPVDz7St8C48k
   qZCB5cEb1NFz5XPpAflYQBuv23VLP/3QSuXV0tYG2Qrq/kqvUK3wGDSpl
   dT5iuvI86/jq+zV5g0sRbsK2vwK9rq1Gcnd9DEZNS7A1eWIIpglrRmo8d
   GsczihBGQlsHIg6NDhVKajqzVj+EsMSj6Y2PhHNwcwpBji08xzyTnFedE
   285JP3pQvsp20qRoM9G/fAj9/8LSaHJK7MMHcRehv2hVuxSRmfxk3rAfV
   w==;
X-CSE-ConnectionGUID: JgI7zQS1RKesTOjaFRABJQ==
X-CSE-MsgGUID: RYxyBEvtTw2oW1ot+VsseQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1887612"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1887612"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:33:44 -0700
X-CSE-ConnectionGUID: ao3l6vmESXqoEGrJjlOthg==
X-CSE-MsgGUID: Rr2lQdc7Sk+DOcapq2lZHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5183781"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2026 02:33:42 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 7/7] Bluetooth: btintel_pcie: Gate mailbox logging behind LOG_MASK
Date: Thu, 29 Oct 2026 15:23:44 +0530
Message-ID: <20261029095344.3989729-7-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029095344.3989729-1-kiran.k@intel.com>
References: <20261029095344.3989729-1-kiran.k@intel.com>
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

Move the informational mailbox messages (GP1 register contents, target
access mailbox, interrupt and TLV parse timestamps, TLV hex dump and
parsed dump region summary) behind BTINTEL_PCIE_LOG_MBOX (bit 6) so
they no longer flood the log by default. Mailbox errors and warnings
remain unconditional.

Reuse btintel_pcie_hex_dump() so the TLV dump is prefixed with the
device name.

Assisted-by: Copilot:Claude Opus 4.7
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 95 +++++++++++++++++---------------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 324c25807d57..7d84c8106cf1 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -38,6 +38,7 @@
 #define BTINTEL_PCIE_LOG_SX		BIT(3)
 #define BTINTEL_PCIE_LOG_MAC_ACCESS	BIT(4)
 #define BTINTEL_PCIE_LOG_TARGET_ACCESS	BIT(5)
+#define BTINTEL_PCIE_LOG_MBOX		BIT(6)
 
 #define BTINTEL_PCI_DEVICE(dev, subdev)	\
 	.vendor = PCI_VENDOR_ID_INTEL,	\
@@ -1915,10 +1916,11 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 	}
 	clear_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
 
-	bt_dev_info(data->hdev,
-		    "mbox TLV parse started at %lld ns (%lld us after mbox interrupt)",
-		    ktime_to_ns(ktime_get()),
-		    ktime_to_us(ktime_sub(ktime_get(), data->mbox_intr_ts)));
+	if (data->log_mask & BTINTEL_PCIE_LOG_MBOX)
+		bt_dev_info(data->hdev,
+			    "mbox TLV parse started at %lld ns (%lld us after mbox interrupt)",
+			    ktime_to_ns(ktime_get()),
+			    ktime_to_us(ktime_sub(ktime_get(), data->mbox_intr_ts)));
 
 	memset(&data->dump_info, 0, sizeof(data->dump_info));
 
@@ -1956,8 +1958,8 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 	if (err)
 		goto exit_on_error;
 
-	print_hex_dump(KERN_INFO, "Bluetooth: mbox_tlv: ", DUMP_PREFIX_OFFSET, 16, 1,
-		       buffer, buffer_len, false);
+	if (data->log_mask & BTINTEL_PCIE_LOG_MBOX)
+		btintel_pcie_hex_dump(data, "mbox_tlv:", buffer, buffer_len);
 
 	ptr = buffer;
 	remaining = buffer_len;
@@ -2122,34 +2124,36 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 		remaining -= tlv_total;
 	}
 
-	bt_dev_info(data->hdev,
-		   "exception_dump: addr:0x%08x len:0x%08x",
-		   data->dump_info.exception_dump_addr,
-		   data->dump_info.exception_dump_len);
-	bt_dev_info(data->hdev,
-		   "dccm: start:0x%8.8x size:%u",
-		   data->dump_info.dccm_addr_start,
-		   data->dump_info.dccm_size);
-	bt_dev_info(data->hdev,
-		   "sds_fixed_rom: start:0x%8.8x size:%u",
-		   data->dump_info.sds_fixed_rom_addr_start,
-		   data->dump_info.sds_fixed_rom_size);
-	bt_dev_info(data->hdev,
-		   "sds: start:0x%8.8x size:%u",
-		   data->dump_info.sds_start_addr_start,
-		   data->dump_info.sds_start_size);
-	bt_dev_info(data->hdev,
-		   "sds_iosf: start:0x%8.8x size:%u",
-		   data->dump_info.sds_iosf_data_addr_start,
-		   data->dump_info.sds_iosf_data_size);
-	bt_dev_info(data->hdev,
-		   "ecl: start:0x%8.8x size:%u",
-		   data->dump_info.ecl_addr_start,
-		   data->dump_info.ecl_size);
-	bt_dev_info(data->hdev,
-		   "smem: start:0x%8.8x size:%u",
-		   data->dump_info.smem_addr_start,
-		   data->dump_info.smem_size);
+	if (data->log_mask & BTINTEL_PCIE_LOG_MBOX) {
+		bt_dev_info(data->hdev,
+			    "exception_dump: addr:0x%08x len:0x%08x",
+			    data->dump_info.exception_dump_addr,
+			    data->dump_info.exception_dump_len);
+		bt_dev_info(data->hdev,
+			    "dccm: start:0x%8.8x size:%u",
+			    data->dump_info.dccm_addr_start,
+			    data->dump_info.dccm_size);
+		bt_dev_info(data->hdev,
+			    "sds_fixed_rom: start:0x%8.8x size:%u",
+			    data->dump_info.sds_fixed_rom_addr_start,
+			    data->dump_info.sds_fixed_rom_size);
+		bt_dev_info(data->hdev,
+			    "sds: start:0x%8.8x size:%u",
+			    data->dump_info.sds_start_addr_start,
+			    data->dump_info.sds_start_size);
+		bt_dev_info(data->hdev,
+			    "sds_iosf: start:0x%8.8x size:%u",
+			    data->dump_info.sds_iosf_data_addr_start,
+			    data->dump_info.sds_iosf_data_size);
+		bt_dev_info(data->hdev,
+			    "ecl: start:0x%8.8x size:%u",
+			    data->dump_info.ecl_addr_start,
+			    data->dump_info.ecl_size);
+		bt_dev_info(data->hdev,
+			    "smem: start:0x%8.8x size:%u",
+			    data->dump_info.smem_addr_start,
+			    data->dump_info.smem_size);
+	}
 
 	vfree(buffer);
 	return 0;
@@ -2170,8 +2174,9 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 		data->mbox.mbox1 = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_1_REG);
 		if (data->mbox.mbox1 ==
 		    BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING) {
-			bt_dev_info(data->hdev,
-				    "mailbox for target access");
+			if (data->log_mask & BTINTEL_PCIE_LOG_MBOX)
+				bt_dev_info(data->hdev,
+					    "mailbox for target access");
 			target_access = true;
 		}
 	}
@@ -2191,11 +2196,12 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 	if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX4)
 		data->mbox.mbox4 = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_4_REG);
 
-	bt_dev_dbg(data->hdev,
-		   "GP1: sts:0x%08x mb1:0x%08x mb2:0x%08x mb3:0x%08x mb4:0x%08x",
-		   data->mbox.mbox_status, data->mbox.mbox1,
-		   data->mbox.mbox2, data->mbox.mbox3,
-		   data->mbox.mbox4);
+	if (data->log_mask & BTINTEL_PCIE_LOG_MBOX)
+		bt_dev_info(data->hdev,
+			    "GP1: sts:0x%08x mb1:0x%08x mb2:0x%08x mb3:0x%08x mb4:0x%08x",
+			    data->mbox.mbox_status, data->mbox.mbox1,
+			    data->mbox.mbox2, data->mbox.mbox3,
+			    data->mbox.mbox4);
 
 	if (target_access &&
 	    !test_and_set_bit(BTINTEL_PCIE_MAIL_BOX_INTR,
@@ -2205,9 +2211,10 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 		set_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING, &data->flags);
 		data->mbox_intr_ts = ktime_get();
 
-		bt_dev_info(data->hdev,
-			    "mbox interrupt received at %lld ns; queuing mbox_work",
-			    ktime_to_ns(data->mbox_intr_ts));
+		if (data->log_mask & BTINTEL_PCIE_LOG_MBOX)
+			bt_dev_info(data->hdev,
+				    "mbox interrupt received at %lld ns; queuing mbox_work",
+				    ktime_to_ns(data->mbox_intr_ts));
 
 		WRITE_ONCE(data->debug_table_addr, addr);
 		WRITE_ONCE(data->debug_table_size, size);
-- 
2.54.0

