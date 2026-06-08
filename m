Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071ED33F8DC
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916878; cv=none; b=I1R9uftWADCKjhq0aDbb+LGyElgOLCYF7854BrohSMqzajIogjqMbm5fwNN8UwOR/p1hVRulQ4z/H4umvxt3vIaHXCjUrHGScM/eEWY4OLKCdUs2WMQyEhRp/SkldzZj66PFZM0PktAo2mR/0S4iHDlOiOWlvgPWNVA+ZJ+eFTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916878; c=relaxed/simple;
	bh=DlLP/EvlXV1Fmm6xv8/iGNq6G2LiaQZ7p5PYZEtzsVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsObYKm9Y0kjgcibSGOfjyOJIvN0v3XBr19MV02MloZPzKrJWMEr/wW61J9j+iCYOpWfrYZ4Z9O40rb3AVyGKBdqk+v8B6vKAf4JrFKVlArsFcgvHFeEO2eEEBbj5J+634EPE6pTziKZhE6GTSGsIBxydMvplXQzxyYyDpOPJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=xFxbgtpq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="xFxbgtpq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490c1915793so25196595e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780916875; x=1781521675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKM86Jz+9xfZomYQd1MfLmCrC3ERihpYsnZ4hyXMRJ8=;
        b=xFxbgtpqxO8nAQNby3h4S0CDj4ENKX1rVKuC71IidU8FmSIJzVHXXGmlbvAbofjszZ
         xmCuh+Xo8ydwAImqgzKtCp7KAsbBW3B7mlPzkl8xm+QKNNnuxbRtpei/d8DBuAxGI+gL
         tXgP0ii2gvTdQFdEBP4o4X7CnlRR8NpwZMrx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780916875; x=1781521675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKM86Jz+9xfZomYQd1MfLmCrC3ERihpYsnZ4hyXMRJ8=;
        b=loSBg/Ka6xwPnL5Bfe0i8tuggT0/CYBnac4mrkt/tqmQ97kibmIdyDiHgra7GmqxNY
         h5Oh/juAV2Iq/4NLnwtowXQQO4PL0+HeAAt4ghl7t8z/a+wUo7aVkHY1amP3z4B0C65E
         eQAc4sg8ADpnkArZ7vfJCqTcosXXZBd4kNdUB+d2/RKF1VvI9tjNgeyI6ezmrCpYt/S9
         Y/gys2pcWuQJky+YV/OfSWCskedfEnU0XbYhHX8nSFF8ozgCUteHi86DJnhVO+bb6fc+
         Rp6GgmhXCnWXUMF6M/8lU8HQjc5IaiTUinlT8ZDEWYi34Kj+UmYzWXokt0a88aZ9RU6H
         hXnQ==
X-Gm-Message-State: AOJu0Ywkq+gfqH5DI09Fyhm+TxwC56fSGcGVDR7kRe0agMABvFPGwxGT
	HPK8kfFOJHUw8oZFbqwUprwt3gTcvRXo5iyhSyKr0KCx6NwfFGd40qus3qBWvWnkA+y6PmQP35y
	QrlaC
X-Gm-Gg: Acq92OEr9V9bmfmsaUlwSCDqIp9KPLXwBnwGkklkTeQPsXqXjf5uqsQJ/X4cNFPV+ry
	ywM856PAq6KpHln3kGO1y7FKnVKVKgbPiL/H7paOwMGxJpaQqtf3LuT9r09px9FMVwHnP99ZOfW
	SdmDF9bICaHsQKm2gsopqb1Gw5XhW1PMp0KxPTI0pA9eFHzCHr1ffsySHd6gfrbvcjnEpSjYvi7
	N+B0054xktva4BFn838e1p3p6vx9uPI7ugVEerimXTzdzKINA6qOyYOy1XFj5LxuLalqiL1Dksl
	gyh3MP6kTnSj1dOjGd+rkVnjmJ1pOf9XkTFFfcdQc03eFteG3UKs4hyPL3F7a7a133OErKvMpq8
	J/kRi7SfwPr2ss0nAVSYJh+b5WpEJ4senUi8rE17gd/TWbS2l53HILkVP2eDxHju1mi0cJCLzRB
	Kw8be4d5WDK1qk18zJaf3M9bGVTWAPP44vOP8AESdomCKscdTdvUA78Q==
X-Received: by 2002:a05:600c:4708:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-490c2604735mr242744145e9.20.1780916875414;
        Mon, 08 Jun 2026 04:07:55 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm326962625e9.1.2026.06.08.04.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:07:54 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 2/3] device: Rename start_discovery function
Date: Mon,  8 Jun 2026 13:07:42 +0200
Message-ID: <20260608110743.3683728-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608110743.3683728-1-simon.mikuda@streamunlimited.com>
References: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
 <20260608110743.3683728-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename it to start_discovery_cb to indicate that it is callback function
from timer.
---
 src/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 223e25102..b0c1960ff 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7185,7 +7185,7 @@ bool device_is_connectable(struct btd_device *device)
 	return state->connectable;
 }
 
-static bool start_discovery(gpointer user_data)
+static bool start_discovery_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
@@ -7364,7 +7364,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 			DBG("setting timer for reverse service discovery");
 			device->discov_timer = timeout_add_seconds(
 							DISCOVERY_TIMER,
-							start_discovery,
+							start_discovery_cb,
 							device, NULL);
 		}
 	}
@@ -7409,7 +7409,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 
 		dev->discov_timer = timeout_add_seconds(
 						0,
-						start_discovery,
+						start_discovery_cb,
 						dev, NULL);
 	}
 
-- 
2.43.0

