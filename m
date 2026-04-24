Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CC346E6D
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058706; cv=pass; b=ZT87CCpCJIUo+IMqkzeuL7rcRrkuzPvHarqd9GfVPmq9eENe8SyG5XAasdN2g1ImAbm/i2El4fY3QYwBSM2uLjahA/0zYQ7T+kFrfED5JhauqwIRGtbdTiD/Nny64NLGkit2rH0Se4pAfxEcKJ3pM0uqxJy0x9vvHlffnkp26FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058706; c=relaxed/simple;
	bh=SImdqwnZssbxVMp6BHu/VceGUXhj4tDWMbAyhItzfWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QYf6gUy9+S9Ecp0CXhoE5fqxSQ4volvW6iQL88ZAbY+sjhnAAKicbtrNX6+gXxPB/wrAFY5xbmEfmCP17vx2rdULvp8ABTZ/l08SSIfjG66+t6cOOCTYUo3fbSfPKC022sRPPDu992VCAQ5RnQkIN4ho4R0t0ZQyv5TdXntZOCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=lYm9Sz8S; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="lYm9Sz8S"
Received: from monolith (unknown [193.138.7.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4g2NFl5mFPzyV6;
	Fri, 24 Apr 2026 22:24:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1777058701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r5s4ITLzucb1NombRG39OYMqsz80PblAoilF2T+Vi8I=;
	b=lYm9Sz8Su6evx9NdAj+NTRpFmH+VaKSbfnNYiWy4GiQ5Hq0VtDwqofaeRgDuf/CaL3EeId
	KktWdt9Z0/Ma4m/q9mN/7Hn9Mfmr+AldJctIalDiGFSuaKn2NJHZ3+elK7nLQv2mpgjx15
	plpWMgSS9NFXnF5fzK6Nzgfn5j6oKnc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1777058701;
	b=lVKRQcw71A0X2HmW6qGRuOXSvX42hQANcV+YaO/NEZgIQDEDKF8RSBwHaaSfskQ2C68kQm
	2G+olXdqYAK5cNR7wLCbVtaApRKz7DQ8jlLUE2XGx5Zf9fcQrtbQP6JtiknC106r79jgHT
	Na2R5PWieWtQ6AWyHqe/9fnI+n1z5e8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1777058701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r5s4ITLzucb1NombRG39OYMqsz80PblAoilF2T+Vi8I=;
	b=sNFrQ2sbGtdQ2cyjNtHKrjvkm+m2fpUXJwSc9VLf5WJMx/Mi354s3/MQ+SlzQU7kmGy1z/
	E7kXDc7alHpSzgqeZDCuj45cJzgACS7GQ1OHOWNKciEGuEHyin9PRn5oJLOlVoxUIon8zd
	I81LJwj81aGsyPCvbxRbk/RX3AHhsTE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	tristan@talencesecurity.com,
	linux-mediatek@lists.infradead.org,
	sean.wang@mediatek.com,
	mark-yw.chen@mediatek.com
Subject: [PATCH] Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
Date: Fri, 24 Apr 2026 22:24:29 +0300
Message-ID: <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT7925 (USB ID 0e8d:e025) on fw version 20260106153314 sends WMT
FUNC_CTRL events that are missing the status field.

Prior to commit 006b9943b982 ("Bluetooth: btmtk: validate WMT event SKB
length before struct access") the status was read from out-of-bounds of
SKB data, which usually would result to success with
BTMTK_WMT_ON_UNDONE, although I don't know the intent here.  The bounds
check added in that commit returns with error instead, producing
"Bluetooth: hci0: Failed to send wmt func ctrl (-22)" and makes the
device unusable.

Fix the regression by interpreting too short packet as status
BTMTK_WMT_ON_UNDONE, which makes the device work normally again.

Fixes: 006b9943b982 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    AFAICS the commit is not yet pulled and is only in bluetooth-next, so
    maybe this should be just fixup?

 drivers/bluetooth/btmtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ab34f1dd42bc..68a32d11e5ec 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -719,8 +719,8 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	case BTMTK_WMT_FUNC_CTRL:
 		if (!skb_pull_data(data->evt_skb,
 				   sizeof(wmt_evt_funcc->status))) {
-			err = -EINVAL;
-			goto err_free_skb;
+			status = BTMTK_WMT_ON_UNDONE;
+			break;
 		}
 
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
-- 
2.53.0

