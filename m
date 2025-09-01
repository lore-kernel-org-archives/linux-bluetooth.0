Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE232F776
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Sep 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741766; cv=none; b=IJIu5QXE31B2SMfQZoz1nni20uxoUb59PlSIvCXBIt88o8eIqAaIFgSN6EOGMWFMxNn2Bnl6laAUIKLpdnatL8gZkWH5Fc10TUzwbGJ/b/05qIJqdHdQjJnwAlGgpnNKjz6GVnjBpuiLS8Y/sm/btHD+sYWQ/tENYPH/CLK4/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741766; c=relaxed/simple;
	bh=ztEt6B1qHI2r7Irue3ptBhQ4KiPgaR9bRywIh4sOgdA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBPSRp/ZPBdspQxyN76W9/Ju0gZLm7G00M6tsrWPOb0NFquWBcuXruCcUpEgex4c4YKCE/eE9rq+a46exdzIJ2g76fqpxmfgW3gI/vgBPzpuYrfI3vb1pPJ2W5W8sVCilJt4m5QoSBpDDdgsK4hziK+pnYTNbxh93pSEY7qCOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MyJ4ifdN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MyJ4ifdN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756741761;
	bh=ztEt6B1qHI2r7Irue3ptBhQ4KiPgaR9bRywIh4sOgdA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MyJ4ifdN+SxwtDiqzqW7RQMPCatR5YZ5mjih6SZUdDsu6yqxT+47klfDx3l6+i5V5
	 Yj5HondUblvmYI1rVGwH+bzByGU7AEedtW3DboodniffMU2uLaQceux+0PcnDJevYV
	 ZzlMCnM/2N65Upbn+CNfZ9lanA1foVdvFkZiTWLpsbpYxltYG3Hp+HiObOJqX+Y8IJ
	 /S4j8uFpTFElN3pSVes+L4dZqmkLyg/XgbbDtdoudbECpUKzwoK0pfHTw4rG/LThVe
	 /mF84tYQFnFrSP9+Jh5ou8QW0RF/XXMLiT4emvZpSB59KMBC3jY25Ogtw+DFTpulru
	 HsALM946Euqag==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-5631-59f6-fA6F-7AAD.rev.sfr.net [IPv6:2a02:8428:af44:1001:5631:59f6:fa6f:7aad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D86A17E0488
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Sep 2025 17:49:21 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/hfp: Fix typos
Date: Mon,  1 Sep 2025 17:49:02 +0200
Message-ID: <20250901154903.187038-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901154903.187038-1-frederic.danis@collabora.com>
References: <20250901154903.187038-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 src/shared/hfp.c | 14 +++++++-------
 src/shared/hfp.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 71f193f83..d01915ab1 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1576,7 +1576,7 @@ static void ciev_service_cb(uint8_t val, void *user_data)
 
 	if (val < hfp->ag_ind[HFP_INDICATOR_SERVICE].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_SERVICE].max) {
-		DBG(hfp, "hf: Incorrect state %u:", val);
+		DBG(hfp, "hf: Incorrect state: %u", val);
 		return;
 	}
 
@@ -1594,7 +1594,7 @@ static void ciev_call_cb(uint8_t val, void *user_data)
 
 	if (val < hfp->ag_ind[HFP_INDICATOR_CALL].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_CALL].max) {
-		DBG(hfp, "hf: Incorrect call state %u:", val);
+		DBG(hfp, "hf: Incorrect call state: %u", val);
 		return;
 	}
 }
@@ -1607,7 +1607,7 @@ static void ciev_callsetup_cb(uint8_t val, void *user_data)
 
 	if (val < hfp->ag_ind[HFP_INDICATOR_CALLSETUP].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_CALLSETUP].max) {
-		DBG(hfp, "hf: Incorrect call setup state %u:", val);
+		DBG(hfp, "hf: Incorrect call setup state: %u", val);
 		return;
 	}
 }
@@ -1620,7 +1620,7 @@ static void ciev_callheld_cb(uint8_t val, void *user_data)
 
 	if (val < hfp->ag_ind[HFP_INDICATOR_CALLHELD].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_CALLHELD].max) {
-		DBG(hfp, "hf: Incorrect call held state %u:", val);
+		DBG(hfp, "hf: Incorrect call held state: %u", val);
 		return;
 	}
 }
@@ -1633,7 +1633,7 @@ static void ciev_signal_cb(uint8_t val, void *user_data)
 
 	if (val < hfp->ag_ind[HFP_INDICATOR_SIGNAL].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_SIGNAL].max) {
-		DBG(hfp, "hf: Incorrect signal value %u:", val);
+		DBG(hfp, "hf: Incorrect signal value: %u", val);
 		return;
 	}
 
@@ -1651,7 +1651,7 @@ static void ciev_roam_cb(uint8_t val, void *user_data)
 
 	if (val < hfp->ag_ind[HFP_INDICATOR_ROAM].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_ROAM].max) {
-		DBG(hfp, "hf: Incorrect roaming state %u:", val);
+		DBG(hfp, "hf: Incorrect roaming state: %u", val);
 		return;
 	}
 
@@ -1669,7 +1669,7 @@ static void ciev_battchg_cb(uint8_t val, void *user_data)
 
 	if (val < hfp->ag_ind[HFP_INDICATOR_BATTCHG].min ||
 			val > hfp->ag_ind[HFP_INDICATOR_BATTCHG].max) {
-		DBG(hfp, "hf: Incorrect battery charge value %u:", val);
+		DBG(hfp, "hf: Incorrect battery charge value: %u", val);
 		return;
 	}
 
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index f54b86a92..e6f7bbbb6 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -36,7 +36,7 @@
 #define HFP_AG_FEAT_HF_INDICATORS			0x00000400
 #define HFP_AG_FEAT_ESCO_S4_T2				0x00000800
 #define HFP_AG_FEAT_ENHANCED_VOICE_RECOGNITION_STATUS	0x00001000
-#define HFP_AG_FEAT_VOICE_RECOGNITION_TEXT		0x00001000
+#define HFP_AG_FEAT_VOICE_RECOGNITION_TEXT		0x00002000
 
 enum hfp_result {
 	HFP_RESULT_OK		= 0,
-- 
2.43.0

