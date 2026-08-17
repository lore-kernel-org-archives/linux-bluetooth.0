Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FF3EEAD7
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960562; cv=none; b=huaYiIKbI+K0sMjTHBy36Ky/FOAErjdbg9phYOWoSPtK3wNYRHukDfs12BRJdt06MRtaON+eqvFGCYzcKJjG+E3RRZuQN1k4c18kAspCJsnwRz9L5S4UqWIkFzkhU+v1YqqNIYEan1TxiuvBrJWLV1Y+l4kDfY06OMfSA8Wd8zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960562; c=relaxed/simple;
	bh=gl3B8ifsV7d/4hCmtUg6SYjyv5TXw2+LHTnAr7tsYxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HKsrG6ZyepslUIDQAxzsMB7EJBxjk/HIL4zTo1pMYSGwHOENaRm3RTHYPRgbXu7RudrrJ2giPywFR5GGVWBJrlGX58gl2sCXwXyvcu6/Leyrm6pwOzHpMiklXZAHOWhvq3BS826m0c5tFihjj+BMPNW3LPg5bWuChKylypf589M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=fH9RbSP4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="fH9RbSP4"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3077002a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1786960561; x=1787565361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v0x7REC+Dg2dGvdXaqGEhAI1YKD3GSMLH/CxsoF9aq0=;
        b=fH9RbSP4Gdw987al2P/3KAxjxajBlH9hz1AtMWVKpkXKaJsNTPeMjmoBzA8+NP8HX3
         qPJLA1+8RXU9w2nUf8Oho7iaUw1tFesvGn6kw01F6C+JmSyBpJngvJWYdawA/Qo0jtVa
         nshTch+PtE87T+xrHeBkPFFfcyoeex3VMSfPQmhpjALRA9khFmhTj3WRe53vpegPMd5r
         7l02mJiqDqI0wocuDoAQ+Dd4sNv4KSl9O199PSDNJZafn9BUEliiB4Ji/uy41jlG618y
         81NkS5n7dfRpxvhdv6zCopYnTW/bamfmkwWGfq+GCinTknnfiTfecUZIlAtsY9Fl8MRX
         +2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786960561; x=1787565361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v0x7REC+Dg2dGvdXaqGEhAI1YKD3GSMLH/CxsoF9aq0=;
        b=T/x4DmegY5Ih4N+5ajGCNMcCFm3rLmz1xdLsWHBY2h335xeBeKURJhyOSj5kLLl6HS
         uGX6Z141YZqiqqwtuwI9sgkgcWG7nnSWLxo5ftsFA5iC+RNuYFnxrLQZPO1TcCT7KHTZ
         /Yyr0wDB/y6KhgAyPxN2/0TMYaBL1sU/hn1+fho2Xq4DP3SJR1SPcd49XICRnJQdQsyO
         nKKr9TIfUMXB9mZ+g41e1WJgAoEn6HeUbo2MzCs2I7V4n66JCxx/qp7HyL1xh2TXrwzU
         FRtsMwnWTjr8zYBXtyMlO9r0ZVKOWdiyQqsGLPq2dyqgoBclJIkcwrBTzmuTNPxqmelG
         BQRg==
X-Gm-Message-State: AOJu0YyycM1hC7kg3kY/N2+wGAvvs9kvys3iGoQZIw2mj8UcknSdhP4/
	/xvdQFJ0hO88ezf9A3NqcyKeNQ7KG/bvhGvqYJb6UzQobEjXA5EJltUI0b2zuIbgfAVKgA9FgUN
	0axQ=
X-Gm-Gg: AR+sD121dKURrYIB+xk97dmvGj/I0xRJbY04NV9bbUmY5/Gu16DVIg7IKxXuIIVJZfU
	eokQn25NiDYNOVFMPCw89ThNN9JJsV0+DQiVlIis4Swfoc+u8Yft/w32ZfIHLw5clhyhpnNgZ+y
	88RCiW66/gKqkcYqyrSUXTmOqTIm0Kg7S4euW33aNNH7I9/ckPcbitCfGYpl4K/UEzHkuMsEDIi
	EN9MOfw0nz7BpQOV19T3igmuF7FMfjX1mLXyF0EPiNP1Qx4Wy9Z1HoHc4pCiTkLOipxpshwOi6b
	lGHBOvfROwAYy2XV27fWCsIPAVOhPcFiy/j5rblbTvHIJaW3EfhNaNDb2CXeGNFosb0tbiNCg27
	EJB2EyDGJYAD8BlpS5BeWfLaRP4TA7oNrXleU4jS4S5YnHjWxa1931j72yaZbGXNXoNXTj1eT/C
	oeqBIkHx6eg54ISx/Sypd8psbxtzWCzISjVHh6gpJZV/YR64VdjFd5J6KUbMhSNIXHls7QQrGUZ
	eThkQglbCtZFwqluEX8JePpvFQTOtB6Jh/hJeMRGAPatwttpmjiLXBAG9eK8IxkSQ==
X-Received: by 2002:a17:90b:3c4a:b0:38e:63de:730d with SMTP id 98e67ed59e1d1-3933b6f15dbmr24036091a91.3.1786960560679;
        Mon, 17 Aug 2026 02:56:00 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d3b4383sm1692047a91.15.2026.08.17.02.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:56:00 -0700 (PDT)
From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: Kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH 0/2] Add support for the Synaptics BCM4384 Bluetooth controller.
Date: Mon, 17 Aug 2026 17:55:48 +0800
Message-ID: <20260817095550.648774-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch adds the BCM4384 Device Tree compatible string.
The second patch adds the controller support to the Broadcom
Bluetooth driver

Kaihsin Chung (2):
  dt-bindings: net: bluetooth: add BCM4384
  Bluetooth: btbcm: Add Synaptics 4384 chip support

 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml   | 1 +
 drivers/bluetooth/btbcm.c                                   | 6 +++++-
 drivers/bluetooth/hci_bcm.c                                 | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0

