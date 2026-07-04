Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA32BEC34
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783206637; cv=none; b=u7AQFyFk+wEkIqmi1jgKT31/3/LHsX3HjxKBtfJohG6LGDKxPKTmmuP2rYqOCoEGYCOmrcXyIAaDDHnvDBRea9RFr20mR5aP4PCKAtlfenKmM8JrI+jxrth90WHjCIAJ2z29898ChnRcndhpjbWFNBRZc3VPRPuGvVrrmuBDm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783206637; c=relaxed/simple;
	bh=sT5wemHAKNb8cWJ9p/AjTxRLEpdCgK3k12iQatwCdMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJsFcuYg/nvwxPRD7Wp+/ihU/Q5ykpMerBCpKMBWuXzwBf4q5WwY8BFVfqhUs/6ZauA7h2aGMa04ApD/WBdrmLl0OZkQAtqswAiJ2SkT0tE5ROxTndDcTB6T1z6RoHg9Sqfkyib+M0Zimacqn8KCVTN4LRTuE4oDL2k2ihRVIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=dEtHOKIz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="dEtHOKIz"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so1422011b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jul 2026 16:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783206636; x=1783811436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XH9ys4cQuWdzdfC6HOKn7TYSZ2C+VL0tpE7eq5642T0=;
        b=dEtHOKIzSlmczaL0Ly2S14ltD8KMZAp287DAy99Na8WO94bQoaLNvqSsk+dQZINs2j
         odM6Fk0S5TMenDtf6wFXLTy8OZCSlRAWA3NecalL8OZSkNa1otuN7tLL6eJE1uZT/F/o
         CfbFpdP1Elqh2W5xJsfvLTtiB7g8NuGUGx2wsE1TIjmlz7Nca8wSrQsy+VaaYacTHJTD
         PqnK7PD7PYVq4UDTQn4pwHmCcd+AjvGo352ul01k7+/2K3oRo09K1K1M2nCB8hQbUnlw
         DfDs0ia/C0gCsdUQ6iRmpteDsoexi/cmepxX3ThikOJYeQV5Xui4w/iOL1dObAEQcKDP
         wTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783206636; x=1783811436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH9ys4cQuWdzdfC6HOKn7TYSZ2C+VL0tpE7eq5642T0=;
        b=nsCMary2HXWbDkl2raVshfpez3fstGHnQJCx1FsmmdsgCCvm/FoYQWLKRiigF8m0mt
         1NXYEQNfceFHXKQRdSrLMRnGkNfanLzyzlAsVGpGva1U4IPyX9UBFduvHgNHkXEwpK/d
         mFO8MJkSnkBuDMyYvGzqALJo3gB1PcKSDxY5XA7yxD09xAuHCuDg30SDD8E0Pbue0pMz
         9PCzRpdHylJUSyFfuK1AT2pHQPIzeWtfKCNHWf97oYz2TPuWLJWZ81CV5KPJE68ZlEpG
         9/R5tiVK9fB/YIvz04f//jz7/aV/sqVyuFLpmJJ4gjRX7Ip3WrUHxCLrfHnj8sGPpl7g
         GxKw==
X-Forwarded-Encrypted: i=1; AFNElJ8qRm4IHC89WBbWDuxlOKSuTM2KP8FasEhYU/tpuEtLSzkouxA1P77i1Y3nZSG2rfbBXRBGRQzy1lxa4mT2DtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKmPiJ5tgW/PI7TiH2uX3CzatDayNSHTcsgKYiPNgzTA4FdwJ
	yc86kqBNPcoNM2n5LX9AHb9/e8kndq+u1Qe6MH6crUNrpS98dokBG5vMOd7W+uFzPMIO6YPwN5p
	qEVU=
X-Gm-Gg: AfdE7cmxP088vZsAjscMJpYFC/xCf7KJNtYCsPvoZzjrIJGTjYhOm2qlK9yWh2M3XSa
	7Spn5L8cLl8rVYeT1GRONSV3oS/X4qSdSVBlp6g/f7J5j69QanJKNcZZbpbBSAzg7EvgjqOb8a3
	/oA57smSH7f2nniDbd9SkEwA8Kv5grjPrxYXK1UOa/Rn/RbM81fbQK8i3U1qUkShsiNnUQzsFeF
	o3S8r1+vEWGxBaiUqB9J+/j1BTtmY/HfAgMuXvbPqiMPBymoZKl0lpO7SHUnubSQzA33ZCPdHtG
	+cG5r+9Dse3LsKC85WCfgBq5byER4loWUFlwMvBffFMdUHiPgrgVn/jE7f3psx0QyFvrTeE0CKF
	C2fcDwGhALOkWUl2Cvyz0csWthSqgt/d8VQpBAJbTb1GoPvgms6/dahePfnRL767j9V5NygL+
X-Received: by 2002:a05:6a00:8d4:b0:845:3033:6cbb with SMTP id d2e1a72fcca58-847e176799amr7598392b3a.11.1783206635616;
        Sat, 04 Jul 2026 16:10:35 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec84:47f4:d046:58a1:f66:9eee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm1626921b3a.3.2026.07.04.16.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:10:35 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH bluetooth] Bluetooth: qca: fix NVM tag length underflow in TLV parser
Date: Sat,  4 Jul 2026 16:10:30 -0700
Message-ID: <20260704231030.996390-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the TLV_TYPE_NVM branch of qca_tlv_check_data() the tag loop bound is
"while (idx < length - sizeof(struct tlv_type_nvm))". "length" is a signed
int from the firmware TLV header and sizeof(struct tlv_type_nvm) is a
size_t (12), so "length" is converted to size_t and any firmware-supplied
"length" < 12 makes the subtraction wrap to a huge value. The loop body
then reads a 12-byte struct tlv_type_nvm past the end of the short
vmalloc'd firmware buffer (and the EDL_TAG_ID_* handlers can write past it).

Rewrite the bound as "idx + sizeof(struct tlv_type_nvm) <= length"; both
operands are non-negative, so it no longer underflows and a "length" too
small for one record correctly skips the loop.

  BUG: KASAN: vmalloc-out-of-bounds in qca_download_firmware.isra.0 (drivers/bluetooth/btqca.c:421)
  Read of size 2 at addr ffffc900000e5004 by task kworker/u9:0/52
  Workqueue: hci0 hci_power_on
  Call Trace:
   ...
   kasan_report (mm/kasan/report.c:595)
   qca_download_firmware.isra.0 (drivers/bluetooth/btqca.c:421 drivers/bluetooth/btqca.c:617)
   qca_uart_setup (drivers/bluetooth/btqca.c:948)
   qca_setup (drivers/bluetooth/hci_qca.c:2029)
   hci_uart_setup (drivers/bluetooth/hci_ldisc.c:438)
   hci_dev_open_sync (net/bluetooth/hci_sync.c:5227)
   hci_power_on (net/bluetooth/hci_core.c:920)
   process_one_work (kernel/workqueue.c:3322)
   worker_thread (kernel/workqueue.c:3486)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

Fixes: 2e4edfa1e2bd ("Bluetooth: qca: add missing firmware sanity checks")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/bluetooth/btqca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 04ebe290bc78..10c496eaea2c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -415,7 +415,7 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
 
 		idx = 0;
 		data = tlv->data;
-		while (idx < length - sizeof(struct tlv_type_nvm)) {
+		while (idx + sizeof(struct tlv_type_nvm) <= length) {
 			tlv_nvm = (struct tlv_type_nvm *)(data + idx);
 
 			tag_id = le16_to_cpu(tlv_nvm->tag_id);
-- 
2.43.0

