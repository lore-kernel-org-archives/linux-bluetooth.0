Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED09371876
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421763; cv=none; b=q+3TQPeTwJbmEt6RNAwUC4oRGzCT++E0qpICBynPgRtm+HweyFFWrYGtxuniGupKLKeEyBijTol4Rhxg3Fp5MOBY9EIZAW6j2fddeqQYO6eo4G0MLJUpTXbNE6JGsdoreZm7SwlDIsYFZj/eRE4amyyzFPq4XrDebqNXAqckG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421763; c=relaxed/simple;
	bh=yy99X5ZV6EUa6VM0MQM1D/ya75MnDqHlC2agDPMvgQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKCLKxfkUaEl94uibjX33V00A1Gd1G1eme6KMobjdCJ+gZNoneylyBYJkhiNUvkt3xEUwOkFj2rGR13ICiLiW3waewxODTNYswPt38rd8PI15zApv5Llai97DM3s1vxvEfPy64qAqFvHc9jIa9MmN797fP41oxynGB/TJeoBp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT0cwr5W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT0cwr5W"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso6397725e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776421760; x=1777026560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fE+qnOdm3zs6vETg/xjRcNv6wjpPT+qb+RS/sbJQMYo=;
        b=FT0cwr5W+nVQVd7Mqs9ZMC1zMV35dp30Y/faZNSdwHYBrS2Kr09Xk9vGS2Zlg6npVb
         XFzGegkJ6IikFwPJ31IzZfghEuJS/+6oj1PtzubWJynJHLdh5O8dAF92lgvcotCYwwYT
         tqelDA3+aFIrTVp/yb0jzkWagc3AIwbkf89Q+Dlh/KaRdxEn6cTYH8HbAjST4Ph/jDqd
         ggecJ9AG3wtInJTt1jXIAZrr5S7kk9jAQfGZ4x0bWq8a6dXbB1TQcmraPbiI7WBuw6va
         fsxzLfq51j+UPOoDWsArGn/C6ytisqISUngvSz6QFHEWOoyARolJrvXpE70t9G8fJE7R
         e3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776421760; x=1777026560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE+qnOdm3zs6vETg/xjRcNv6wjpPT+qb+RS/sbJQMYo=;
        b=dT6PJ+4LONAI88riRBhaKChCfPnygzMWjmzU/xcB59eJU8IOSJahRNWFhhz9G59gX2
         QE+vS8aJfgWhdbXlI3M+L9Y+Nwd/4FnUYKK7gLwY9sLPrB7uGAXfEl2c6d0RE5tVAa4K
         pZvkhSyZlMdYSOXnlHsEpT7vBmmwfSdfe0/FnzPlTZEZiKioWuXTZFxUejXwWnLY1iV6
         CgWDq3hrikIB3a0NLW0TP5LfjAme2+X7QmqbRE2+9soYRUJgovBy6JRhTrOQa3x6yZpO
         jOUBgTA/aJq1fsMDQ4h3lwWJYh4+tPROcs22cDNlIYy7y56WlO/5iywY3X+jXXkIngpT
         gNYA==
X-Gm-Message-State: AOJu0Yz7GP2NCHTN2xfvd1KyIsVeK2EPDuJBvHGkNnErKcJ6ZHbuNtLN
	JfjnGtmFgg58uVCCEsuoZ8kfaQcP7Ce4yhzkO/Pxoes/LaLNt7thkgJG8AhJgjg=
X-Gm-Gg: AeBDietIIrbOytDOYI3oddwKMAZ4+HhIJ3gPCQ0AM1LFy/p63h9/Eu4plt0bPUb+Qfc
	ej1fNKx5EwsEBjuAWwhNke0GAmDWlzTUeMAhNBf4ngMAITDgNXevP9BwsZTNkhDFW64FIypA0QS
	7PJR0f2mhrcc7nKrMUoEdvg85ScTIz73iebc2kKkaPaxL/mkBZBTyzh8eWTTbaIM9v7JNlAuxwF
	mWjVIn7J1W7VPfi97l5/v8/lBM2PiWAky2eTXUsGQG4mpoaqUGNNtZCvl7bCpufjMjg9ss/EmmW
	WA6TVrXK9/iu8iL8q6uL3qPV9R7MIdgownJhSKqygdBHalHfPBTvMdMAPyWYOWsLm9K3aI9aCTo
	zTJk5G55k2XpJSvsa1uh6WC+YNPyxbHW7Uf81iJrK/adAIsrsnM6Gt2d7g+/mUVmuKTXaHqFw2T
	YF0Cc=
X-Received: by 2002:a05:600c:c4a1:b0:488:c014:34da with SMTP id 5b1f17b1804b1-488fb77ed1bmr27199815e9.26.1776421760356;
        Fri, 17 Apr 2026 03:29:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7c0eacsm13854955e9.35.2026.04.17.03.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:29:19 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	sean.wang@mediatek.com,
	mark-yw.chen@mediatek.com,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btmtk: validate WMT event SKB length before struct access
Date: Fri, 17 Apr 2026 10:29:19 +0000
Message-ID: <20260417102919.2549352-1-tristmd@gmail.com>
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

Add length validation before each struct access to prevent OOB reads
from malformed WMT event responses.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/bluetooth/btmtk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6fb6ca274..b1a96ebae 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -695,6 +695,12 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb == NULL)
 		goto err_free_wc;
 
+	/* Validate SKB length before accessing WMT event structs */
+	if (data->evt_skb->len < sizeof(*wmt_evt)) {
+		err = -EINVAL;
+		goto err_free_skb;
+	}
+
 	/* Parse and handle the return WMT event */
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
 	if (wmt_evt->whdr.op != hdr->op) {
@@ -712,6 +718,10 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
+		if (data->evt_skb->len < sizeof(*wmt_evt_funcc)) {
+			err = -EINVAL;
+			goto err_free_skb;
+		}
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
-- 
2.47.3

