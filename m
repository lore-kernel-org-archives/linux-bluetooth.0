Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBD3BD649
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770098; cv=none; b=F8EXEY9U1Zhp/HAtsAyqrWt17bJ2JX21sFqWyFTRd47lcMUGjeRaJ1ZkX9/TvNA6zKO3X4CUGhS0aHyVUWGkYztCDNMos5oGehwSeMGb0XVJsVfebhI/igUlBHPWb7BEs5gc6NhodnyErDGB0zAbKwfCFCBFU9QkOyRXNzUoB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770098; c=relaxed/simple;
	bh=MH029eDJfEvKtox6zoGFIugdoIrSt90GG37NR0eJiAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKkHVJLMchE1P0uMqt9LuFYWDyAAnrG22f7C7Dj5/xatELwhbkCDlYnZIl3nisKx/rF3ejKO8qfS+S9luq7LtkIWtGynpw28GucOyW8hfEPtV0Pa2Uc9rWCwVEipJndq4QlVoXg8Hi8KLXLkF6rgxtpIAxhzAwdBCK0Dx6PheTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVOPb/1D; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVOPb/1D"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so4365187f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770096; x=1777374896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjPHv1Hru04ZXzIaQ9HvSw3rx3tnPbEFHQIlqAw5RuA=;
        b=aVOPb/1DYinFAxge6hyLa+szvLEjQjJFYpIHKc63H5XqmdzkQ7lbn2y0atN1kAlmv6
         9FGRArzEASWeRCiMbw5In4OEMMS8OOaf5ysAF8UiSosKO/Vd3w1+DfkmGBIwk2lpNKS6
         Lcap4FudwTxV6vx6o/EzZ0QW5ZofPmL+XKXX9hkTIqK0SDgGKB3LsbM0T9/CsqibpCzc
         sD3qTs4dGSAdiRjpMUE2aomLLM7A6dYTkzUcO3xB8/jDJGqzAfOxxsgQny0A31YvlFiM
         Lim8hJ5S0Lk1DoQE4EV4nkzOaKQgrz0Ute1B9CwvJJpEtNeQHD1jBJj9GwYWHPNMVeoQ
         S23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770096; x=1777374896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjPHv1Hru04ZXzIaQ9HvSw3rx3tnPbEFHQIlqAw5RuA=;
        b=hGYITzch5f03oghPKGL92RtXCHHtTAdrd0FbIJCA3OKpHfhtHtYb+7KlynU60BHa0Z
         4tZa3qO4t77idt4WqV8jxIoptqLBL2yFVAQmzzE25rKcjVaNYRTCIuZgr99xBt7qhHda
         8yDFKDxTCXp6I6keDO1Yj6QGRtNMkemG2BJHoisijdSL0bvlEWG/uriUHuUPFszMzlrF
         9oEwVs3gAMHZ0liCb9sBc2nFVLtvJZ3zSshFU9doTALZpbcRHNgjY1BEYy40OwYeFb5Q
         Jeig6lPFijKnfZKNoJw0aZA/b30Sqf4mUoaNEfi4kQKARKkLPtNJPUnr+VtuzJSXXs6B
         l1UA==
X-Forwarded-Encrypted: i=1; AFNElJ+LbaeyfXjAc8U/dwdSHdHdIgmOScn5A4zikSL3xeAKEF6oc5zsvwfqGmGEZu8vd+HPRNyriksM+qnu66fOEkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/O9k8PHZWzW+ATbYVTt4PE11VWjvtcbgklZ+yZWfk5oOcahj/
	dxqQ9yLnzKO7GIBcWTWnSzFTMcaM2hEIOm+Y1lrglVWV13DViwPKGJE=
X-Gm-Gg: AeBDievttnVoKicyjlSBGukicjgOL3QftNA+F/nML2m35Cv18oit1V/AKFsWKHLKq1c
	cYdDe7Rm77rlf6AT4eNMLx4JHYpqTze5XhKFH/f+RvUzRGbdXpVNanR38h218rpJAM6hd7Nke8m
	0qsHYQClcKmY5GtGkkKmpO5lzT5aVazL/ESy0hskjenswXlL8QAeVTwjQcq711Nmo/3RXGlGafs
	y7ogGW3hV+D+8xOVP029v4vAUcjSuGjaFo/8jlf+s3nLMIh9Cv+BP/aZUpk3MXd7df284WJx7bE
	/FHhUCHAUnIt1uoX4Pd/HLC7RF+nf5kB3AoJGLCt+bus99sNF5GI8QTKVZ39UqmlZx65LFnJ1bX
	FYUCWVsGLw8g4KnrMJZB512v0qgye9fbQiTT+ksaOsQNPH9n6N6TIbULp5ADZKfN6klA69o+K0a
	bYXrI=
X-Received: by 2002:a05:6000:1889:b0:43d:7b7b:ab76 with SMTP id ffacd0b85a97d-43fe3dc54ddmr27175189f8f.10.1776770095504;
        Tue, 21 Apr 2026 04:14:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm36910279f8f.0.2026.04.21.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:14:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Chen <mark-yw.chen@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v4] Bluetooth: btmtk: validate WMT event SKB length before struct access
Date: Tue, 21 Apr 2026 11:14:54 +0000
Message-ID: <20260421111454.3403059-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
(9 bytes) without first checking that the SKB contains enough data.
A short firmware response causes out-of-bounds reads from SKB tailroom.

Use skb_pull_data() to validate and advance past the base WMT event
header. For the FUNC_CTRL case, pull the additional status field bytes
before accessing them.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v4:
  - Use skb_pull_data() instead of manual length checks, per
    Luiz Augusto von Dentz.

Changes in v3:
  - CI all pass (CheckPatch, BuildKernel, CheckSparse, etc.).
 drivers/bluetooth/btmtk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6fb6ca2748086..f70c1b0f89903 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -695,8 +695,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb == NULL)
 		goto err_free_wc;
 
-	/* Parse and handle the return WMT event */
-	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	wmt_evt = skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   data->evt_skb->len);
+		err = -EINVAL;
+		goto err_free_skb;
+	}
 	if (wmt_evt->whdr.op != hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -712,6 +717,12 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
+		if (!skb_pull_data(data->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			err = -EINVAL;
+			goto err_free_skb;
+		}
+
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
-- 
2.47.3

