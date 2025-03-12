Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B1189913
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792471; cv=none; b=hUSHqPAoYo/nkKhYVUimIcwPg3mC5EAuh46q5/V8l4zeEBviz+RZxUwdbtMO0dAk6cRWdn0102i/kPtFAuES+MVcoJtnEDt17T9x1sDiGT6EkadIIbY9U3gefTcZV40e/1u9yNaRRsttTcWilAPq5UOTCnYMYfpGzj+FqR69wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792471; c=relaxed/simple;
	bh=x7DJ43O6OFaiFqLQReY/wki62pbE1P84CEV0HQZzgv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RErbcZOmzmy0nkm5QP8ggZGwcKD7vsX9uB5tylFuTWljppmYCTr7dJb6O5dBP27KOIQ030kzCnMnpgshbwPwHGk/LItJ/uhvJvcnbOam0l44s5zBeO6PFaRbxTNtgf9mDfp7LiTRPsEcyV83XrE2etWKzyrDonk6ovBI6CNOygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSKXxB/w; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSKXxB/w"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52410fb2afeso2609852e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 08:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741792468; x=1742397268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYfAk8FrBNezPEVCH+yQ9hkmmdOp4rMGm8XAUYcDWUw=;
        b=CSKXxB/w/0sOpQcZaHYkFDVzrkGXAFrClGfRp43cndpPF2lnypWMaEV4Xpc6eOeeWa
         3LRyOYVDV6qq4EBtkPvKYqL5e1p6+JH9l/GHTqYeGWEZyagK5r2tPNeu/HDdUlx27CMC
         nvEa2A4r0+8zX3qv6RxxlEgm/F8ooqywgv7j1lmuInEPhrk/dGQlEpKHVtH8MKj7RCK0
         JIjp/NDQxvzLcIY/9ahKwU/KwCiT5NWOYR0Djobmpzj2Ism3uS7jizQJZNoXxxxlraPo
         0A95WwlDLMbBxFYgC9ZrTJlc4eY7VilZ47e7s6F9OLBx4Yie2bkwNJjiaSM+4J0FEtNb
         0q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792468; x=1742397268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYfAk8FrBNezPEVCH+yQ9hkmmdOp4rMGm8XAUYcDWUw=;
        b=ev/CtM7evfCySWr1x/7BCh7Atk34gZvuoqU1QrkKHdSKRDvyMVVLGAlJPtL2ySyu+7
         N6LD21XtOramyKL3eOfcBssHNw+7OnAXQMyJOm2ac6zy9TeuBceBQM2hE318kOGUbz4o
         NS7GjEdVgLa6yOVP19hJt/a8lcJnE0h4sxP5aFMexghz0mYj80meS2QVlrXqKkV1FW7B
         ScaKgUgEVBK8FW/VaLk2X3iWkxlNW06NTb3zTHLdfUcsDJ9R5xPz4VgNPN5NP6OgAPHY
         prmFY6+l/BCqLHMeuziorQufSLX9wq/WuyFC5XjNS9/eJ/HmOz3eEgsQP2VnqTx8tJrF
         FITA==
X-Gm-Message-State: AOJu0YxRqvLDbHokAQKKo/j1KvYYe+CowvcvNSnexlSHhdgBHNAYN6bP
	vnomKGwkpW0Ki9ppNZ1aWlTmsHOW4JEnL7BLslh4furbiwwVFBi0tV3vzAQo
X-Gm-Gg: ASbGncs6yPGTTvgbAYYTh5IDAoMWFIo5HGKJVyFenXqvE3qBiU0p846mK9RYKYzwipd
	mYkjAXbR96qvQJBn3cta8UaGUQ/XRG4Lu1WHDd7IY9riRGEfIuNYo+sAYKqnw+i6kN+b3BrT+iw
	Xx8mZ3+gUuylQD0KC3YoPeNYTy6qEUWM3K95mEy0yJPTJBTddkv/ZwNoez98pANwKJwsH+WjijI
	SZrnYMadw1x4G7o873y03/r/4Y7VAXvNpkhIKAH6LFEj+38xwH2n0NdH79MMfZ1HF7pGNBV5cou
	a3JsPoBp1KRl7Udd5KKB5w2JuUR92VoUUhtAC4ovjEjLaltlRQDh4aklUFgIdG2G1z4CQUDI6Wx
	qsAtBH781dtbPCQ==
X-Google-Smtp-Source: AGHT+IE+PnBQwE4j8evf8CoFB+Sh+1ts6LDTXjuZo5GSEkkoAYlq+NqqTup0mpynpI3h5/7fUS6G4w==
X-Received: by 2002:a05:6122:1d9f:b0:523:91e8:324c with SMTP id 71dfb90a1353d-523e4130a63mr14882734e0c.8.1741792468419;
        Wed, 12 Mar 2025 08:14:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8c8339asm2152287e0c.34.2025.03.12.08.14.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:14:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_vhci: Mark Sync Flow Control as supported
Date: Wed, 12 Mar 2025 11:14:21 -0400
Message-ID: <20250312151421.201772-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312151421.201772-1-luiz.dentz@gmail.com>
References: <20250312151421.201772-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED which indicates that
controllers created by vhci driver support Sync Flow Control.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 963741490106..a51935d37e5d 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -416,6 +416,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->wakeup = vhci_wakeup;
 	hdev->setup = vhci_setup;
 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+	set_bit(HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED, &hdev->quirks);
 
 	/* bit 6 is for external configuration */
 	if (opcode & 0x40)
-- 
2.48.1

