Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1531F8AC5
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414913; cv=none; b=qO/askhMuWdAA/qzeUGbz3S2AUoq5nBJHnN+L9X68VORuDOQyL9x6h9c2InVCFiPEpx+wxHYVEzhtKuVqta03wHj9KvtWxfX2ki0h5xNUWPT/9uS4XheFyx1MYksGIS9hAM4x0R/oEtAXQ86IDfS6Z7dh/KGj7UsXyQSYMzlLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414913; c=relaxed/simple;
	bh=etRbnA3xZin9MqbRKKbN4xHljgwi2Jr5O1pQXqZ1N/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1LPQbSs8oGeF79Eh+r03Z2LghmHO3rPHt5QOcs6qVLIfa8r5e5rW6P7RirKNNVHhkEFajnvrcgfFDyp9MoYzIucGQAFBh+XfU4up6Vjy9hoHO0ruVibj8AUEstwlqLTcccwXboKnS/k78ZeiJa5TC7CmuwBB/mTEmxy6ark0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=fI4lC8fq; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="fI4lC8fq"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f9a7cbc8f1so781945b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1748414911; x=1749019711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPvGOSoqhKg3HDWOQ8u+r39VlbKRUC6utvJP/sL9JLw=;
        b=fI4lC8fqZ+nKlKsum3jrCu70vf0ToABAjjpDaQj+v+MW/QSbjw/G1M/dbXClc6ta7W
         RQFLmRT+bcmokpn8ipoW8+A4GTxIGRzcqc2YTVjxszXGQxGLmBlIb6F0zEQYLA9WRq0Z
         TuRvbVuX3ZYODCnycU4nPmWkR+eGE17LnUv7ZFi++EsISZ4ldBd12+eYZWOEmYOZxu7v
         AhI4KZwWnerYEPZwNvaLb+rmxN/VPIBGhRQBMibLeAaQFfprzie18M6VcgMMPyFDeLxL
         PE+qLFMMVfMcDUo7t1YFt60uSp30/MkcLwn4ASatxPKS/i+p93oKVNmiKikc/GPTznb4
         KX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748414911; x=1749019711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPvGOSoqhKg3HDWOQ8u+r39VlbKRUC6utvJP/sL9JLw=;
        b=dw1M5kU69ARStsKw7M2hNkmpRNtFO4Nx+hFvVvdSa5O9n0X9ZL9F2NZArWW5LpnV5t
         o65JAhzQQeNaUM6X2TBbjS29gtZjDG7zyyeOD3gUZ6sPI9zS3kLPPg4X5cxqkmnG7QiV
         W/7JYoc3fYktljkpoHgNrUZleihCW7x1mxUbW9lr0oUGuki2p6+59+ohMUhrbJrev8QV
         5NVShVmxcik/9pro7isL5yOfgn3PvdnZV4AtNbQPgo7abOrQByvjVDP8aws4fh/0thja
         4pXIGYCEjF1TRhoIQ7yEeTJslWqT65KSqhTmh+TIhRJgOj5nUwKIkK0IJsPfV9H6tZVW
         okBw==
X-Gm-Message-State: AOJu0YwTcfysamwmdGUzH/PxgKoadsMiHuXimgl5Z5B0ZrQyZ3wq5tBV
	My9vrbFyGAMpTrIxZVmRXWsMtYJ7Awv4IqB/MAhsUdlAe9qZ3TIWMe1r4vtWFOR22y0=
X-Gm-Gg: ASbGncuNV5sDyNGCUnOUbAI8eMqmaEPcnY1BRo1ubT1oufTIpyz0j4ojmr9Ga/5UFqY
	PR1WA0rJVfYLzRv/xGp5uiHNKejXcyrJPXowyEB9/w+UWfylicax1/sEi3o/sGwRsQVHg20OIDW
	4+e4UZ3QmYGHA1T8u+5vonQL9cFfyQcQnNPuDatVeW058tReR8xvY/G9mZ4UEnmUdMMmTGVSSVj
	ArDcrQwR8ZLYV7F6gEIDtP0fxvHgdWv91fPVBAOQTTSIywuv9TT0vdx6NLp/bm1iI421nAOJUHs
	QLUmbfbj8WKtjhSx4NY7duqZuDsUnNd/FxqoMXQbFSxbSysqhOppNWyWkQOHMe+LZdI+pGcXrxj
	klDPd7FL+YYVvGx26L2Cd0/I9txmydg==
X-Google-Smtp-Source: AGHT+IGchj3vYrZA2FlcLUNGNEiAVfySRrcOoVWx2qIqozY3Q5RXbSOS19g6uYvk3sFwWF90c+7PoQ==
X-Received: by 2002:a05:6808:3191:b0:406:1e0c:319d with SMTP id 5614622812f47-406467fff9fmr8991080b6e.19.1748414910949;
        Tue, 27 May 2025 23:48:30 -0700 (PDT)
Received: from localhost (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-60bd9c1bd5asm102369eaf.9.2025.05.27.23.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 23:48:29 -0700 (PDT)
From: Steev Klimaszewski <steev@kali.org>
To: quic_chejiang@quicinc.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org
Subject: 
Date: Wed, 28 May 2025 01:48:27 -0500
Message-ID: <20250528064828.4112-1-steev@kali.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20240821105027.425783-1-quic_chejiang@quicinc.com>
References: <20240821105027.425783-1-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Subject: Re: [PATCH v2] Bluetooth: hci_qcca: Drop unused event during BT on

Hi Cheng,

I have been looking into a long standing issue on the Thinkpad X13s, which has a
WCN6855 where every so often would get the following error in dmesg output:

Bluetooth: hci0: unexpected event for opcode 0xfc48

I don't get the message super often, 11 times since 16 April, though I do not
know how many reboots happened in that time.

I noticed you wrote this patch 9 months ago, and I've applied it locally and in
my testing, with it applied, I cannot get the unexpected event anymore.  Looking
in patchwork, it says this patch was superseded, but I can't find what its
replacement is.

Does anyone know if this patch just fell through the cracks?

-- steev
