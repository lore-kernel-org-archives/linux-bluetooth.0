Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09D3BBA09
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767997; cv=none; b=Hnsxmx1w8VylqtfVMvsTzqXcPA8w5Bzc7o0hCZl1f09sPRLliUfwgMKShvowDNUWqxlbjAKMTmMMKKnexoVYBihEYbWuOjus6AQI3zu1g13cZb86ZM7ChbMaAa442lBUZnF81ls6s7xHsCWUdKdiV80FdorxrUrYRuiCvD9jhi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767997; c=relaxed/simple;
	bh=ymo8Yrctecma/M2W6veSSsi6Ymbtcjf0rAGf06SezC8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=knaLAvYxy/s1qqOR6RcPrlyGMvacekzM8+l90pOq2poP3vLDaVHsJ4f/6mMa4NLhGfSMCs1U1jhY3AjWzUM2TwXopz9FcYE7I97PnNd+Wqx6djYofMgwJfsQMJDWwjEAQt6RLeM4JcMOvejXgvRj24A6lwhLvzgG70wePWoReG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGfutDN4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGfutDN4"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fde5b81a1so2978709f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776767993; x=1777372793; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=13ZWL/eHlUY5OOB6+y7Y+vPu0LaU5nOnT6pQcRP3ud4=;
        b=sGfutDN4hNp9DzEJJLgd5ZJX+j52qkS13eYp4/lY75URx4EHIv/KCqCJrcRLifzm/0
         GIzOQr7LAojZCz2X47W9yBGTZ9vKUqyrOPMusDIAt8I6Cqm50RsVT6yWuKE0qWOlGsyb
         EJi2fpDE5kExBGKYQxaA4wRJTQMfeiSVORoFa3jHZ1tn/PMYPENbkMGQ92hbsE1IHVCx
         jp1iU1WfzV50DSeLy5f1T7wI2FJDm820Gy5f9FpSZjYBGQe0AOOENlIQqDPQU45g7Dz4
         pAJZDHHD+bFUhFh4RcTFhqieEQLYGl9yMG2UatsnZWxOV6qpaQvcixvaTwJ5Fw1n8T2l
         iEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776767993; x=1777372793;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13ZWL/eHlUY5OOB6+y7Y+vPu0LaU5nOnT6pQcRP3ud4=;
        b=McUGXDC8EMOVqpEZfrWwoQ+T/9KE/+Eb3UY5vdAb3Z9MgogWfAEhZVDG68fvL2cjWQ
         TP4OHsBlbjxG/cA36NxkpnBZooPvK5qS4hmcb9wt9Q/AczU7/LCae6QZDJiMYasEb3c1
         OOreZm10j/bX64FGqdMWcQVPjaA+N92EUNtiDQu9yo3ZMHGZg7nSzUVXqkcGCW7WyiGi
         BnCFpnCmfJk5X8hjahmOc21+I0PLjkqd557li8GQMJUnpsbwaDMEx/R4eGvlBr2f/R1E
         LUR7pfJXX+rBY3qV3/XEPZnixWaW/ayKY731exjDa6SnmuYIR+pY7y22BZBcN8yv3qDX
         7hoA==
X-Forwarded-Encrypted: i=1; AFNElJ+ku2l+VKyOQhRow1enqXMFFVjxyaxsJEehCFEcRmUZIQ5k5aKFCwCBQRB386TuvDACBXxvNFVFktM9K+WAxBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJg+D1cTss4e4bZ4RlJfEnrr8iFpqof0/CL+lvBetdZfaVHkG
	yb2uiFZ6fnXVcP3zJGIPNYVz2+zcc3moYOnNTLOPPJ7GlbMeF+jowws=
X-Gm-Gg: AeBDievwYN45jz6NDm7xVhCFVqn21tr2EuytgxOWzMzrEu6XMbc3nM44qIFmdTGm5XZ
	ra3NgtqhvGFnRgM7r1C5IlQyOvgQgj+cHyPPLNzHajPIubE/H7GnBx93IippTfAle0l6FSGU2U5
	zWhiN0GRoet0CZy8o7oLUdwktl5wRIo53pyWRn7H7YI/FyOj2jQaREduKnE5a8AQRq528kO9RtR
	kZ1KQ3BSEoB/a+oegK3VAq3aQ/yeBxMS2c/yeh2NGp/yemthcFopOinao7aFRnk+r5H19O0CTNS
	/bPa5f230fKGwgBiEEkJOTMw9BChXiuGgzH58DPNxEU5iCiF3QtRzTsM/SOiZtVs1HpBQW0YkaN
	RmKOh0hkAlaKJZ7+KByjLGAjh/UOKc7x3YESF4cqYWj5101lpEZU0Kpox1NP2lJjK54ZaXRAZtF
	W5gOs2p5zzZAQ=
X-Received: by 2002:a05:6000:2c0b:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-43fe3dfbff5mr27427886f8f.31.1776767992844;
        Tue, 21 Apr 2026 03:39:52 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm38619383f8f.17.2026.04.21.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:39:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Sean Wang <sean.wang@mediatek.com>,
 Mark Chen <mark-yw.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: btmtk: validate WMT event SKB length before
 struct access
Date: Tue, 21 Apr 2026 10:39:51 -0000
Message-ID: <177676799168.2227510.2141901333230538239@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 20 Apr 2026, Luiz Augusto von Dentz wrote:
> Can't we just use skb_pull_data instead?

Good call -- much cleaner. v4 below uses skb_pull_data for the initial
struct access and a follow-up pull for the FUNC_CTRL status field.

skb_pull_data(evt_skb, sizeof(*wmt_evt)) validates + returns a pointer
to the 7-byte wmt_evt before advancing. For the FUNC_CTRL case, we
pull the extra sizeof(__be16) to validate the status field is present,
and read it via the original wmt_evt pointer cast to wmt_evt_funcc
(which embeds wmt_evt as its first member).

---

From: Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v4] Bluetooth: btmtk: validate WMT event SKB length before st=
ruct access

btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
(9 bytes) without first checking that the SKB contains enough data.
A short firmware response causes out-of-bounds reads from SKB tailroom.

Use skb_pull_data() to validate and advance past the base WMT event
header. For the FUNC_CTRL case, pull the additional status field bytes
before accessing them.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.=
c")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v4:
  - Use skb_pull_data() instead of manual length checks, per
    Luiz Augusto von Dentz.

 drivers/bluetooth/btmtk.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6fb6ca274..XXXXXXX 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -695,8 +695,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb =3D=3D NULL)
 		goto err_free_wc;

-	/* Parse and handle the return WMT event */
-	wmt_evt =3D (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	wmt_evt =3D skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   data->evt_skb->len);
+		err =3D -EINVAL;
+		goto err_free_skb;
+	}
+
 	if (wmt_evt->whdr.op !=3D hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -712,7 +717,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 		status =3D BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
-		wmt_evt_funcc =3D (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
+		if (!skb_pull_data(data->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			err =3D -EINVAL;
+			goto err_free_skb;
+		}
+
+		wmt_evt_funcc =3D (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) =3D=3D 0x404)
 			status =3D BTMTK_WMT_ON_DONE;
 		else if (be16_to_cpu(wmt_evt_funcc->status) =3D=3D 0x420)
--
2.47.3
