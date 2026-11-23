Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415721;
	b=PIf47pVlPBM7yB9dLA9xWah9sQMB+ThJkT4MPCmP3lOgnp5g/ndCbwJW29aJFyE7RnDs
	 av2OSzVyAzPa5Y9hYZUIHkcuH+af2xC8B2MycWFBLERGF/ZMBIZLC313wNtTHoAFoFXbP
	 M0r8Z44VGEA/xEz+oj4F+jBm0O6hGg08SWDzRhaqH/LXyh2TJMeK9SlBQcx1vYJ5vrfl2
	 /sdhOSuuZ+//eIBX80s1ZTtOdVRurhktU3H7ijUTdNKSISUNnT+NxRwQXUXOdcQFApwvj
	 q6Tf/htlFkn4mkOOK8NHUoW2guvDPZl+p5zHSbZp/2NNZC5sHjlmtkptKK12ZPmvaPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415721;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LC6tL3ZGR8ArpIhmmGPTBMVCvBcrlKCcgy3k/29xwfE=;
	b=zQAWqtTmiu4guiFmB5CmdT0+XS3qNrmo6U/L7BfhbeSm93BT91XvNx/Ogu49uvhuTviV
	 FMBrOm7fAPQGq7YiM8DqpGSV0fR1cWn9O2Zz54MDyrxAec/NsogZIOIwe+YH2+4xk5qyb
	 swEHksmDslV1cPNJpBk+fAu1OQNuY9pAcvb2XBSLeC++EQ+VpcifBUJ9RmtvzWlu+FqYM
	 lRGXMJ3/L/B9sD3J+8hZiH5hqVAKyqPCs4gqiW5GwpCM02ZaySNh2BHIQ6GXKCLwSL3Ho
	 mRx5k1TdzPz/2Hv1FDEFHTJos3J8BAGNwCSGDmER24laUZ2oPig8poJBFqZV8J+2oJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bBTeLw9A;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE451606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 06:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE451606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bBTeLw9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795415721; x=1826951721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TmxqdHc4Tlt+oxJqhY9C6vF+CIzK797jAz2hFh+LeRk=;
  b=bBTeLw9AIoi/k/v/BKpx/VQrXaAQqNXMxjsvB4pD1VygguYz40iVUToj
   rvXBGj2eImQhKxRlJcG32GttzfWtXHL/mOaKFR1fIJDbDGHZb+E25yA2C
   WmQJM0Tdz2dl2rdR+YsrasRK3cfVSbdJzAfwQtVE8vw6vWd7G+VeiHh7n
   jk1YMoJvlm0daXpQL2rBgf1OTw3edmzuIW4ZbhLgbPY3DFe3YIiCf0EzK
   rxXD6fLCGQXasHYpUT5C/fEP+fdYP7SB6Vhn/0m2Nbs4v5sQwi5MF+lGd
   VvjVdOIcTCe9egg0ORl9u1+kWsjOpCyKUx0PeIHC/fciWAc//omqIeg8A
   g==;
X-CSE-ConnectionGUID: HhQw6dG2QxGZtGmQFnVn8w==
X-CSE-MsgGUID: /tK62D/+RJC3aY0gxt7YgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4316335"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4316335"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 22:35:21 -0800
X-CSE-ConnectionGUID: DkvZQNyMSQu4PWQBn1lqrg==
X-CSE-MsgGUID: d0DEKkAxSgOyT0eSlTPkKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="12925767"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa012.fm.intel.com with ESMTP; 22 Nov 2026 22:35:19 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	ravindra@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/3] Revert "Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt"
Date: Mon, 23 Nov 2026 12:25:21 +0530
Message-ID: <20261123065523.2769017-1-kiran.k@intel.com>
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

This reverts commit d572ea4b621ce60279da5179a0c338660c8b7331.

That commit worked around invalid mbox TLV reads by making the mbox
worker wait for the GP0 alive interrupt before the target access. The
controller must not see an access to HBUS_TARG_WRPTR at the same time as
an access to the PRPH_DEV_ADDR/PRPH_DEV_RD register pair. Waiting for GP0
is not exhaustive: it only narrows the window for the mbox worker, and
there are other cases where these accesses overlap, such as the other
users of target access (hwexp, fwtrigger, coredump) and the TX doorbell.

The next patch serializes these accesses with a lock, which covers all
of them. Drop the handshake as it is no longer needed.

Also drop the handshake completion that commit 4f6ead67b93b
("Bluetooth: btintel_pcie: verify and serialize D-state transitions")
added to the set_dxstate() D0 fallback path, since the flags and wait
queue it relied on no longer exist.

Assisted-by: Copilot:claude-sonnet-5.5
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 51 ++------------------------------
 drivers/bluetooth/btintel_pcie.h |  7 -----
 2 files changed, 3 insertions(+), 55 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 55454900322b..d95127327c71 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1986,25 +1986,6 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 	struct mbox_tlv *tlv;
 	struct btintel_data *cnvi_data = hci_get_priv(data->hdev);
 	u8 hw_variant = INTEL_HW_VARIANT(cnvi_data->cnvi_bt);
-	long t;
-
-	/* Wait for GP0 alive interrupt to post RX buffers */
-	t = wait_event_timeout(data->mbox_parse_wait_q,
-			       test_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags),
-			       msecs_to_jiffies(BTINTEL_PCIE_MBOX_INTR_TIMEOUT_MS));
-	if (!t) {
-		bt_dev_warn(data->hdev,
-			    "Timeout (%u ms) waiting for alive interrupt before mbox TLV parse; skipping",
-			    BTINTEL_PCIE_MBOX_INTR_TIMEOUT_MS);
-		return 0;
-	}
-	clear_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
-
-	if (data->log_mask & BTINTEL_PCIE_LOG_MBOX)
-		bt_dev_info(data->hdev,
-			    "mbox TLV parse started at %lld ns (%lld us after mbox interrupt)",
-			    ktime_to_ns(ktime_get()),
-			    ktime_to_us(ktime_sub(ktime_get(), data->mbox_intr_ts)));
 
 	memset(&data->dump_info, 0, sizeof(data->dump_info));
 
@@ -2288,23 +2269,12 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 	if (target_access &&
 	    !test_and_set_bit(BTINTEL_PCIE_MAIL_BOX_INTR,
 				   &data->flags)) {
-		/* Arm the mbox<->alive handshake */
-		clear_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
-		set_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING, &data->flags);
-		data->mbox_intr_ts = ktime_get();
-
-		if (data->log_mask & BTINTEL_PCIE_LOG_MBOX)
-			bt_dev_info(data->hdev,
-				    "mbox interrupt received at %lld ns; queuing mbox_work",
-				    ktime_to_ns(data->mbox_intr_ts));
-
 		WRITE_ONCE(data->debug_table_addr, addr);
 		WRITE_ONCE(data->debug_table_size, size);
 		if (!queue_work(data->dump_workqueue,
-				&data->mbox_work)) {
-			clear_bit(BTINTEL_PCIE_MAIL_BOX_INTR, &data->flags);
-			clear_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING, &data->flags);
-		}
+				&data->mbox_work))
+			clear_bit(BTINTEL_PCIE_MAIL_BOX_INTR,
+				  &data->flags);
 	}
 
 	/* Mailbox is read, ack to FW */
@@ -2421,12 +2391,6 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 	if (submit_rx) {
 		btintel_pcie_reset_ia(data);
 		btintel_pcie_start_rx(data);
-
-		/* Complete the mbox<->alive handshake */
-		if (test_and_clear_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING, &data->flags)) {
-			set_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
-			wake_up(&data->mbox_parse_wait_q);
-		}
 	}
 
 	if (signal_waitq) {
@@ -4911,8 +4875,6 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	init_waitqueue_head(&data->rfkill_wait_q);
 	data->rfkill_wait_done = false;
 
-	init_waitqueue_head(&data->mbox_parse_wait_q);
-
 	data->workqueue = alloc_ordered_workqueue(KBUILD_MODNAME, WQ_HIGHPRI);
 	if (!data->workqueue)
 		return -ENOMEM;
@@ -5261,13 +5223,6 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 				if (err)
 					return err;
 
-				/* Complete the mbox<->alive handshake */
-				if (test_and_clear_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING,
-						       &data->flags)) {
-					set_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
-					wake_up(&data->mbox_parse_wait_q);
-				}
-
 				return 0;
 			}
 		} else {
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 28acc20eefdf..6b7cf3819f25 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -174,8 +174,6 @@ enum {
 	BTINTEL_PCIE_HW_RFKILL_STATE_CHECK,
 	BTINTEL_PCIE_SETUP_DONE,
 	BTINTEL_PCIE_MAIL_BOX_INTR,
-	BTINTEL_PCIE_MBOX_PARSE_PENDING,
-	BTINTEL_PCIE_MBOX_PARSE_READY,
 	BTINTEL_PCIE_FATAL_ERR_POST_SETUP_PENDING,
 };
 
@@ -237,7 +235,6 @@ enum btintel_pcie_mbox_msg {
 
 /* Default interrupt timeout in msec */
 #define BTINTEL_DEFAULT_INTR_TIMEOUT_MS	3000
-#define BTINTEL_PCIE_MBOX_INTR_TIMEOUT_MS	500
 
 #define BTINTEL_PCIE_DX_TRANSITION_MAX_RETRIES	3
 
@@ -842,10 +839,6 @@ struct btintel_pcie_data {
 	struct btintel_pcie_mbox	mbox;
 	atomic64_t	last_dump_jiffies64;
 
-	/* Wait queue for mbox_worker to wait for GP0 alive interrupt */
-	wait_queue_head_t	mbox_parse_wait_q;
-	/* Timestamp captured in GP1 handler when mbox interrupt is received */
-	ktime_t	mbox_intr_ts;
 	bool		pcie_alloc_init;
 };
 
-- 
2.54.0

