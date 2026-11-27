Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808014;
	b=Y6Daic31zbm2vm/n+2CHb7Rv/DpfspcFbhGl/NKGpiAmf63TB3aPDYzioZJsdyjp2xBn
	 R9tCzpEbDQs7m+wEAUjWpdfZw2VbOqHTWEdl4swKnOuLqlIgf05l6bHFXRznLxmFntQwr
	 zD9mRWGVfPfpaLGDZSjvsFovyIfMB6m6MbQpuiemHdR/smZ3NXngLsm+RQJWYDwYcGEdS
	 RHnisnsZi1jSjEJ9W4cObhHNSQ8aTtLfKSwyzY3iawRRt99Wx5xwi9LE7CmNFrehneHdi
	 tbLc1s959Tajy53eEGN8BuxCuzOAFKnTV5dF+oizzQ7xAd/rOMBYEy5pykxGIPCtWqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ks5K4xCt3QDj6aak+FARlnPXL1Z0aMm25EBCIUbUEBc=;
	b=JGw4h/7+PNJ6FCt24GsofTr00U4/ZF5WSUnzfOAdBvB4bqFvaPGeBNeL0qJN2HG4HOTK
	 0vsxHFZ9fVWPrZEC3izDgyJpw1d+52AJVC2TEXm7dzzUKi4mZ5U78ZGzdVHvZ8Ix2s/lv
	 kHHeDpdqvfhn5IQ0iZViInUfcRkQtEsAyEdRDNYyuz2hdbBsoEqlZMdxTw3o1V1Ows2zZ
	 sTpSVaQx6QWg9iKmVp149SFcQzLFN1kwT2Lpto3GgHZ1GhFe4sT7dr0+H2CBSH41dtJso
	 tpDuCEZQ0LMPTOkdg8mnfdsZEgCpE8C4ec3ZhoKnDsVUHHi7X5qGyIjWIec3d+KHwTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7m4+LVY;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A82606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 19:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46A82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7m4+LVY
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6756bb1cso5528135e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 11:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795808013; x=1796412813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ks5K4xCt3QDj6aak+FARlnPXL1Z0aMm25EBCIUbUEBc=;
        b=S7m4+LVYPEmAZBVlSVukpJdA0Cfd/ZG4EtsTA7nsAS7atV6Dj/aSo2fTzKWZYDUJJj
         VKK5mUFBSZRBa6Fh1LwwJ704N+lllSQ/9sGF58pYVpz3CECafAg42C+XquBDH4BjDJQu
         hIYxbxbQHA27u39xJK4JdRcrn1TF9EMSxHW1fWIZ/R4VRQ/2pJUZjzxMBl13TuatFYKM
         LLkzQfJGMrhGrNKwUA1rqz7Zy2pkbBVkFPJjnhxlQtGQd4p82Nth7r1ENnW9AFYS6Qp/
         VKVcTlD2K1ZSs1pGLuoszYS9LEaNc0edBED030ayccGXY4G240o3IimZlt77cRTkq9up
         7k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795808013; x=1796412813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ks5K4xCt3QDj6aak+FARlnPXL1Z0aMm25EBCIUbUEBc=;
        b=sdwLW/ZNu6SNG/75VrjrbN7MebGvmrUiaoYZREZbVoXTstwFJ+h+hYA+nV8a8FbeXZ
         1Rm9jcV5E+qhQ9jpq9pMBZtHxnYgs0yGKL2CMPB+2ews7Q/6DCbXahEJ+y337yQR3xZR
         CqhyJ22vrk0esQagpHtqZZkXoAp5M4U++AObb6KPs+P4h4Ewi/HG0BDIW3v6tSmr/KUy
         if3Am3NWeC9Y7ADhnPhMEzqBfLQS76kW1Gd6w1Qz8y0iTVy6iJdX1ZARktSiuFiG8wx1
         q3lfTc2RCpZoHjgjSFJ2badO6VXKNfiG3n0XA+8f9eTvc9eSiMpaF9+vW5m1gFet2sT7
         ZRkg==
X-Forwarded-Encrypted: i=1; AL+hErFoF5zB2F2yA9Bui5si1c/oiBLStGgQUQLDZ+3qzVfxkbBGJDq4SXsiW6p/8KcorzIObbHHRhu+/O1wK+8r91Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8N+hhAZGxD8Oq1qORpcdGYylpejfwWmzooUZMeZvKynBeDxk5d
	YqR0KqOByNcgrFswCOimJYKVCFCHODuUHZiNn39+E4vesbLo+6nTafCUUW87TUDtapg=
X-Gm-Gg: AZFdTZcOvRLbLt482JlE7smPVuqnx4L+IpvnlNdc2F7UHw0++orkauJLJ5HedxHRh5o
	GobbR30l3n3pkUwn1U54o49AYLFKpKTNwgfkwYcOhvtvNNRavdiJh9EaKUm0vbNfyCHdJQe3rn7
	/CwOBz9GB5b7JVo83BcLUMvCX7+OiqKfRE8rv60FCoGdfp4rElbOgY6UzEId88F6rABuPg8GMLS
	BUHVtRUMIRZw9AwNaFXtysR/beIGbA2Sw8R1LH5diJN+x9cYtsTS4h0MUQmfxkrv57c8bVLf3Hn
	l3A9dqUqlNCF2iH6il4F4decEajuYnWjZb45NGy7eL89MLtx6EPHKOSRL6dl7Drq44eGdMt6Ue3
	N7+RW2lCbBTV+Q5r3/CyZD0y1D9NH2MQYNJSGmTQwN+MOGlfGuBSNpCNY8zXcpCdNmrONR7xGXr
	cXGwuzqMlfuU7res3uuW/I8GgEtkn+WFFTP1fJNxZ32nMw7D+MiLzwVOGXHMw0/3ZBzoixEhhpM
	Kr1/8jSx+yKe1cE9HrB9qCNwDd7kSoDUl0tsVIOl5yVdVtKIiMOPh7iim8mIfmL9Ac1zX18/c2h
	g1WmiCSwz+tKZEjNRoSHBngXYS9aQJNtMXipWq56wiHNsz8YaR9T2sslpKgDqYPnT7MhQMGWpt+
	js57w0vQlcds1tseqoo2ROvMSZsELfnU=
X-Received: by 2002:a05:600c:8284:b0:4bb:6c01:de9c with SMTP id 5b1f17b1804b1-4bb887f55c1mr467048545e9.2.1795808012466;
        Fri, 27 Nov 2026 11:33:32 -0800 (PST)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm700878635e9.5.2026.11.27.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:33:32 -0800 (PST)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Tibor Harcsa <silurust@gmail.com>
Subject: Re: [REPORT] btusb: QCA9377 13d3:3503 on ROM firmware: HCI hang during mSBC SCO
Date: Fri, 27 Nov 2026 20:29:02 +0100
Message-ID: <20261127193124.2627445-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b5219ca5-a8bb-4dd3-a4b1-692ab362d400@oss.qualcomm.com>
References: <20261029013350.360574-1-yaroslav.voytovych@gmail.com> <bf27c4e0-31ac-4ee6-b7ba-afc6744e5c0a@oss.qualcomm.com> <20261124043440.1206949-1-yaroslav.voytovych@gmail.com> <b5219ca5-a8bb-4dd3-a4b1-692ab362d400@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Nov 2026 at 08:51 +0800, Zijun Hu wrote:
> no, let me try to up-stream QCA9377 BTUSB firmware, you may override
> the one loaded currently by QCA9377 as WAR
> we will think about how to support it.

Thank you. The Rome 3.2 rampatch and NVM are not the intended files
for this chip.

When the QCA9377 firmware is available for testing, I can test it on
this module (13d3:3503, ROM 0x302 build 0x111) with the test that
showed the hang: mSBC calls with headsets, counting HCI command
timeouts after each SCO link comes up.

Iaroslav
