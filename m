Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FAC39182D
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291912; cv=none; b=Bw/kY05Swegxob1gvsik//Ljz15U6v5JOJPaP3NNQIY5CKEDcMQDtAg+8dR+0+uyfWE+JGGBQGwiFkVxgJqBlGCtDpmF8+/SZYATuZLaVD89+aLmgfLRKaCSkTrcJfgklbRNm+PgbqrHi4PlFQWKd5AQ/HaoyYKDinrcTcZiLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291912; c=relaxed/simple;
	bh=j/RdyUSgIqnVcyQ9dkzn1R2ZJV2VOS7yiyrwlkgQjzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQ3QNYk9DCWisoUYJH/BATZR4pYXPMmO5fWGc8F8wcKRKNQEGX23aoErIJQHIBwcPKX0Nj4jz/stzGC+Fi2OcEQjYwM0QFKqml4jSbQwzrlLx1+2yu+YR+ziw7ODMis42RQp/xXkJr6GIxFoJhLbHVsUMGHEjQWu5TVXN58OL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuYyVmi5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuYyVmi5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488971db0fdso72533525e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291909; x=1776896709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ekJFR8aHl8gFtfDV7mGpSffAeuoYKf7uk1sbVZ81Z4=;
        b=VuYyVmi50yCW1NjSfeODaU7T0TSgPehdWz7HbNtM5Sa/fHksEe6B3bEcYw+RXdlsNZ
         mnhyCDvQG+9bNynW/z6tbpmhVg0NWiRu4qS+JJOyXLmC7cV9pfOXLu3WsOd9H6JtNdk6
         bqtlCF9y0DkjSjOhglcnhI63EnHao9UoBNOktb8nrQAYzR9h6cE6paF96TpYB7oLzO16
         h9cwWFQFloZEM16GU3lF4nXGbVbqMuxAmFLAqTaNK8Tkf6BL75iFteL+VCvmee6pU024
         MaKJ+UCOaVWGrBJ0NX7y6RilzPLGMWQeThW/C6wEVgpIYE9F/aZcuDXi3FXjD9osa563
         mtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291909; x=1776896709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ekJFR8aHl8gFtfDV7mGpSffAeuoYKf7uk1sbVZ81Z4=;
        b=e3BoYjL29ylKasMQnGzQzRliD+39DHhDg8m4sPJzuCpLoMCDt+D5wQavnbAG5/X0Z1
         t898aEjmViSlaEjqjVijxtioPOzQEa+ylL4+FQzpEBN8wdQrCRUAa75HLGmsXt8ZrVyU
         BzFpFi2+tc58N+kcs4yvIiRCXT5ZXfarzRWkJVJTtMnwsKSe+Ekhgfl2fEjTJOV40S0G
         1kERbdqwSI4woP6Ttillxle/KW42MKxjA1soMsLUieXfEyROkXbV/HAUEPbJNxhkHIvF
         /98ZM5e+T1AmhQ+noZQR7WlhgSFC4KD12z2owHUsPFVsc+oxsTgKiwSxDoRCylDxrkIp
         iyPA==
X-Forwarded-Encrypted: i=1; AFNElJ/1DmAeUnJYjEL33ldt7QPvZVvynO4CSaketnD41dHohhg476Fo9RjUnA7L77TTiDVXM8nmQF0eaye5FDb0kGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1yY8NgDAgZ7C63+Q/zIwgcrMTavRnX5ZX2aOjYiVIW0jdB318
	fFKmSL2QhkN+PWyXgadF4CSkr6DVy3/IZ89UjDIrxWhD1suAVEeF7NQ=
X-Gm-Gg: AeBDieuveGmIw2Kpox08HO6Mvopcsk/Vq4uIIXJUhVv+f6w+hoagB/dREY880DQC4p6
	XIw+pjePgzh4pt1DLWk/h48Wed6manSXozMYeJPMo2LqUB1O/7foylB52OhJfXPcRr+Ky4VrZS4
	Y4nUd1Ir6Yld2mQDABnuAO1K4XS24+bt9RhnYiLlCvRgxkWS72ZZ3V1NVe9j2tjwTwHCa0fF9hg
	0kXDCa6Er/ZQAwmijIk4rUP65++fN+VXDKEMRLpypPuhFYO0Eb4xDg742Nzl4/tgfvy8CKgrWIU
	/5pub4Wi70ec85u95cM1LjvnAcdKn356lJR+aaZXwUMjyItgmLJoUC0qsAc2prnmCUYymwV4TUZ
	F4gjuCXG7/Btrm5SDsOaEnHi1eoyPblYW4L/xbAf6YlyaNWg/AUaFc39mthjP55wxx2OSo0T4ud
	iUvKE=
X-Received: by 2002:a05:600c:3546:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488d6890a46mr324874205e9.27.1776291909075;
        Wed, 15 Apr 2026 15:25:09 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ea65b9sm46796695e9.5.2026.04.15.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:25:08 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btmtk: fix OOB read from short WMT event SKB
Date: Wed, 15 Apr 2026 22:25:06 +0000
Message-ID: <20260415222506.1548403-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The WMT event response SKB is cast to typed structs (7, 9, and 18
bytes) without checking that the SKB contains enough data. Short
firmware responses cause out-of-bounds reads from SKB tailroom.

Add length validation before each struct access.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Note: v2 resubmission -- original sent via Gmail had HTML rendering
issues. This version uses git send-email for plain-text formatting.

drivers/bluetooth/btmtk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -658,6 +658,8 @@ int btmtk_process_wmt_evt(struct btmtk_data *data, struct sk_buff *evt_skb)
 	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;

+	if (data->evt_skb->len < sizeof(*wmt_evt))
+		return -EINVAL;
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
 	if (wmt_evt->whdr.op != hdr->op) {

@@ -674,6 +676,9 @@ int btmtk_process_wmt_evt(struct btmtk_data *data, struct sk_buff *evt_skb)
 	switch (wmt_evt->whdr.op) {
 	case BTMTK_WMT_FUNC_CTRL:
+		if (data->evt_skb->len < sizeof(*wmt_evt_funcc))
+			return -EINVAL;
+
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)

