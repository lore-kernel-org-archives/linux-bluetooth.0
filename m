Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA402989A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806313; cv=none; b=ZIIKqbiBqbduw9LCneyFy92/YCys47M30a0P6jQ9Xh/4KisKLrwA6aFGaS51Clp8AmBDrOD1F0/JZ/DlSD4BANm0UUCW0e5VlG1U5R97H1YQmweageUZLtZ9bK/7dvaUAzhdip0y+7wPFOsNsK+JhGwv19EQM43xB3lmKtqtV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806313; c=relaxed/simple;
	bh=RhMg+IznBO5OX5AY38WAFGJ16Yvqc6xWSBm5PKAE7jo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFxjJYuqrxqHyz+j3qLsrQj0Pd+fniF+0G8mW3YdzUtsV3WhyiiwM+W3gofbAPaBRbThvgLwumkYlqRHNAwtiszScTtzvxb23Y0AJXKoZzlD3sKbuEdWucW47Er3PxjhPfGs6w5lIqJKu17CCwR4dEhLhsbHXdmhZoadxIqRdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkwpdR4k; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkwpdR4k"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-531a1fad7faso2045902e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753806310; x=1754411110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWb32+oBRb1BKjiEQiJI7N7kGxLYQOFRJWyELtGsobY=;
        b=SkwpdR4kqnSxoTaqscT0PvtsEVSWVZW0rMZVjJYmWLXmR5JHQFPBrVj9yzXYTI9qSj
         NoZ3Sa5d/ZlY8pCF1DCljspSlVXQpJe/8TbnGTqtR5bwrvGdGe2KsNtz+WYiwOruEGt2
         l7otGOYh/afnCQFiuXHDTfOi47JdLpJh8NctUXJ/LpWZOL2gzvt07h+2Je9Batow3NbX
         4wPZFpGZQX305Gk8tDrfVpLkJPac35nDqK+9NX9zxLE0BqAt3cfUSavQCVpXl2IMpxUL
         2Q6fgoC2OphsbvegjxctfHSdK0WAnC2qWH7vmgUoDkMqK0oxuZKYmPVG1nxhT6ohW8GG
         QNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806310; x=1754411110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWb32+oBRb1BKjiEQiJI7N7kGxLYQOFRJWyELtGsobY=;
        b=UqeIaCofuiuWjGKmqFK2zse8bfLQ7prxS8n594DAno6QWyTRsz5zkC3jSUxxasQ3gy
         T9reK3uUK8FJnClLH2mDLCU/VJ0tfciOrwWaLjYZeodHUE5+RkuHdFciIEzESp4DF3iH
         scUkj4ql/bbFYWk70GX9Huex81MCxAxm9kFaFehGwY85/cjJDv0STXb0rv1ILPNltfzD
         x4+GQSemvH60HaOnfkb3DFPGoh3gQ/xmqT1coxH0xYUx9Cvn/0B84ACv/J4rd12/zcY9
         KoseGMn+uhIXaCmJ8tZv7l6XS6o+64wKJY0ZhUvhYff0ifPt5og5ChMi63u7Da86mNH1
         tErQ==
X-Gm-Message-State: AOJu0YzmREQ7/Yw/jx+kbk3W6rkQy+NbL49dSbMRPzPTtgOMeaKZcv03
	+8cB6WDgY45F8JzmoOQTBbhqnctl8E9tGs8pOlEbIeE8yxIlppVs17okCiQn0Y7l
X-Gm-Gg: ASbGncv0Mti6bWkPF61GPdN7kYxlGeQ9s0puvaAvvGVnl7hMKkPgoams8j/tvhmsHX+
	kj3nV+TpnKCJ+8UIhcjCx6Dp93Ga7F5J40SVIlbgCG1FEytNUXxtM0j79+9apBrlx6Z0FacjQAj
	4qhqZotD1TFNHbQuO7MlUFxswZ/TjUs0L5JV/6vOajmAt/FYWt1zKsFgBx22q0XbZo6wskp/hcv
	EEsl9Ee0fMmA0moujAlcROTs8+pBoYqkJVi1S/MSmHamMhCs1YqS3zRXEhvcQfNN60h55InG8Cx
	zFs/RJIc35ohwp9MSEbbRKGruzKJ3lY74xE+zea99fNvq5Zz40+uwv3vLWNb7Rden07BeHFLWVq
	N37K502zc9iVaYV9VpZxOrkqAkF/jpdA1/D0bMvd+Y+/m58Xhqs6lc3xME3Tu7yO9
X-Google-Smtp-Source: AGHT+IGZA18Dii9Q5w/PPYXMC6O/MTSeIbtuFa1RTOu+dLId+wxXruASLqJKOJ8MdQUYWr9KR79rlA==
X-Received: by 2002:a05:6122:181a:b0:538:dbaf:773e with SMTP id 71dfb90a1353d-5391cad8150mr452876e0c.0.1753806309845;
        Tue, 29 Jul 2025 09:25:09 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-538e288700bsm2139773e0c.27.2025.07.29.09.25.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:25:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: hci_conn: Fix not cleaning up Broadcaster/Broadcast Source
Date: Tue, 29 Jul 2025 12:24:53 -0400
Message-ID: <20250729162453.221656-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729162453.221656-1-luiz.dentz@gmail.com>
References: <20250729162453.221656-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes Broadcaster/Broadcast Source not sending HCI_OP_LE_TERM_BIG
because HCI_CONN_PER_ADV where not being set.

Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f8b20b609a03..ab6fe5b0cc0f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2259,7 +2259,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	 * the start periodic advertising and create BIG commands have
 	 * been queued
 	 */
-	hci_conn_hash_list_state(hdev, bis_mark_per_adv, PA_LINK,
+	hci_conn_hash_list_state(hdev, bis_mark_per_adv, BIS_LINK,
 				 BT_BOUND, &data);
 
 	/* Queue start periodic advertising and create BIG */
-- 
2.50.1

