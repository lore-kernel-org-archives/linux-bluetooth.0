Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F85FDB3
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935818; cv=none; b=JrF4p08Jh9kf7xiG5ir8HNsXiA46VSgiJSleMDZaMCNX+hwItJR/Mnipv0gMruDMu1pt9biLXwmbBCmAbrGSzuMhapk/oTbgZKclsBTPS/ndgkEs9CTVMhuKrN2rIfbWnc4/gfkwN+cZHsehJbCep1Xlr6w3/Cn0eSHVvms44YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935818; c=relaxed/simple;
	bh=28iptPzQ8GM/Czk49i40kS2ksA0YKipUYYgpTO5/15I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccNyhl+mXeDG+th8hmLKOOJMIBUpqce/mM2zUm2TXz/qYI+VmeMVEYkNfSEzQM5f3j0GN6nYvCFDjq6S+QQNlbN/7uRic4NC2Vcn/UIvbLiZLcozFkZkukT1CxCIbyF775h0UYQQ+WBfH7LERsE2DY1GVq8HS2JhMaI1VtDmEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/8MRtaH; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/8MRtaH"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7db1a2c1f96so1639947241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 14:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709935815; x=1710540615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuefABokbSsjxTGPqgZ0gA9y3X9yGv7eqCAtxoixHko=;
        b=R/8MRtaHnsR1zKf2tDPFrx7fQeqkxuQ66oBWEbC0PLMTDxdGHcDoJ/W4Hiq/aLNQSN
         ZfE+5B08aNwYnNaIDfPTsIdYnA5NVidEj0eJBgs7hccgM1C25mdJ+Z6mk/VXJ0po3yOQ
         ym7YdyYZYaqloFjt22ovfGx4/tvXceJViBY+fqn86F4sddB3TIkENIg/KBAX/d+khK3X
         p2x4YtJKkH10MkFzNOwPxFu8lwFgiy0+Uegx4LRNsDm2V09HLqAkrawhdKFymnzhUZfV
         Cb8BbPz8Xcmb/uUMXOJveruuO5mMe+xsnhirJYRdrNQVHphQkkc0ik+erslM2ZFZKXVx
         SVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935815; x=1710540615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuefABokbSsjxTGPqgZ0gA9y3X9yGv7eqCAtxoixHko=;
        b=FFmB67zQ8fDNSCgw+w7IBcuFFUU6xv+E+O/qDt7TGrWSbCeED8eWmMgH4OT8Bjq76x
         EW6I8BwnRHGAkw65bEY8C9MJ0rq9Ploa+v0xQzfZaA2fdwJUuzdGo9UsFF4Ep6tyVsy/
         /m+pxDEE2i8KJNAeUv0NA0hmTH5bsbnmWstUdKHeKuaGQR+cVbut8NpQvDyU7JvxFYLl
         LoRNy1Gcr3nP+OTKDtHZ/Uyg74OzRtP/qdJfTZF8shMO9I0NmkvZ8eSwF7m/aSNnkd8d
         Rfnvcx4JUm0xVuoAmX8dbHVDS024yiG/xHH1o0s95V12vJTQNieEe53MbxawhMp62pyL
         Zmpg==
X-Gm-Message-State: AOJu0YxF1GNsNf/cHgxwrU5El1e5z9sVTCXnprAbWxAHvw5NuL+4tkjc
	GtRv4IfwpA7jH2aWVUnYaNQynddh6TMzIim5y6ctrH1c/V039/sVd0FpeRQh
X-Google-Smtp-Source: AGHT+IGTqSl/1IUs9ZjDlSYAJf/GB0klKfz7w1M+iHof6oNPXK3wR0ZfJlsYI5qfeCB6U6REQ1gYzQ==
X-Received: by 2002:a05:6122:905:b0:4c9:2540:8520 with SMTP id j5-20020a056122090500b004c925408520mr812720vka.1.1709935814764;
        Fri, 08 Mar 2024 14:10:14 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id el15-20020a056122278f00b004d33d93758asm29039vkb.23.2024.03.08.14.10.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:10:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] input: Use bt_uhid_create instead of UHID_CREATE
Date: Fri,  8 Mar 2024 17:10:06 -0500
Message-ID: <20240308221007.250681-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308221007.250681-1-luiz.dentz@gmail.com>
References: <20240308221007.250681-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_uhid_create instead of directly submitting
UHID_CREATE since it can track UHID_START by itself.

Fixes: https://github.com/bluez/bluez/issues/771
---
 profiles/input/device.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 0d32b705bd00..d5b7d6728c88 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -941,28 +941,15 @@ static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
 static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 {
 	int err;
-	struct uhid_event ev;
 
 	if (idev->uhid_created)
 		return 0;
 
-	/* create uHID device */
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_CREATE;
-	strncpy((char *) ev.u.create.name, req->name, sizeof(ev.u.create.name));
-	ba2strlc(&idev->src, (char *) ev.u.create.phys);
-	ba2strlc(&idev->dst, (char *) ev.u.create.uniq);
-	ev.u.create.vendor = req->vendor;
-	ev.u.create.product = req->product;
-	ev.u.create.version = req->version;
-	ev.u.create.country = req->country;
-	ev.u.create.bus = BUS_BLUETOOTH;
-	ev.u.create.rd_data = req->rd_data;
-	ev.u.create.rd_size = req->rd_size;
-
-	err = bt_uhid_send(idev->uhid, &ev);
+	err = bt_uhid_create(idev->uhid, req->name, &idev->src, &idev->dst,
+				req->vendor, req->product, req->version,
+				req->country, req->rd_data, req->rd_size);
 	if (err < 0) {
-		error("bt_uhid_send: %s", strerror(-err));
+		error("bt_uhid_create: %s", strerror(-err));
 		return err;
 	}
 
-- 
2.43.0

