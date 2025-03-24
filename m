Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C9525D8E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824169; cv=none; b=XySa9brn4FEI76Rmce8BugMb3uEvlFxjQG15Rp8PblTVBRez2kugmr/vhgsjr6+0vITCt3JvTwQJsVIJhFuBeGQWsC2aRLYeP5Cg0ywVoBMaN25BrTWXqHzt+vT8lanVo1Jk5OmJ0cwuU8rEovRDgDQUhHEAj3ad4vNfPRVeDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824169; c=relaxed/simple;
	bh=BEugHfuWTTWwpom9bxqbBFACjK5cjiXEg+fSDceHnjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XElOOlAZYldvv1wgm8e9OUwIspn41Yp7SeFkSseaHxjEk6FTrpC772IzokptQvpVMvsbLamluQIYjypPJAEd1YvOHqo+fOsFMglqeIfggVVaK3hk15trUsG12GDSbQ3Y0eCd15ZdpnEoBkLm8XoT+oIFCYDPdBEVJUT3ABHLqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQY6JER1; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQY6JER1"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51eb18130f9so2243219e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742824166; x=1743428966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yUFzEeP23ae02zx94YcHk+D3FSZrRH8pMWsZ4/dLsk=;
        b=dQY6JER1Ntc8MuA8V32VGZnf/368h1nocQtmUQ8a6zC4vi+NRdExuBS+2hVg55jG6u
         WgTOmmTCf7m52A6+dEJMObBy5+ubmBOF23ym78D5x878He6VBlv3xzgkV8EuJTsRZw+s
         B7JOnqEdeRyuuRkbKAG4R2DsxgnGaemcpuX8eQkidhb5e2XR5gTwDuH+GhV5WryeLhsj
         lm/t/S+c7v5d68hJ+B6MaFekVa/Qq2tQko9J57TS+o364fk2NZ6Ta5lhzsc37EiKE86c
         3vdtBwjWvmCuwjmLqkyAGN+Io1IX2mZM0HE3s7DLfTfDP9ul6vnlvRGFGp3YsCyqfNr0
         aybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824166; x=1743428966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yUFzEeP23ae02zx94YcHk+D3FSZrRH8pMWsZ4/dLsk=;
        b=B1tpCSo0UQ1ut7EoqiMJVO+Y4EmW3IC1D0kQG4VRu0sRXe/s1oK7ROHZe80paG4/k5
         UNRno0BAbGWUvDmv7xxt8x8Bl4774VLk0tpOEIe8VAbrYswbHCYwt8cxup/c5YZ3/Jgc
         HJlGlEhHktpjCRlHAU5/fezvrhvF2rXfdIoEqOU2rbe/dE1ubgvaenvyaOqrvLbEBw+C
         WIOcQvTZDLQMGxExfHJ0VcHdqTZ0qu9mfyG3gtEwEj72lqmehzeuf9h26TCt0qe1TcFz
         bZyXxRORLKXCMGFaWcxhGGQW7X1lyghefVum+XZSqdl+DCW3MW2BNahT8aw2MhS8wjjA
         T6OA==
X-Gm-Message-State: AOJu0YwgwfMNu4Bh/chpw5wNnn/FUvZeO2Uy4RjYW3lVQ4L5YYN1IbLQ
	zJGzL0Tx/otRSijEnHTW6nQWwzUpxPTFMIzsG/k1Lf+G1gJfzdo2XotzQ43s
X-Gm-Gg: ASbGnctdnpnlBYU7G6SNx9vdsGFGO5Qd/kp1B1sqZXbCsa6Yj8mP7b8jIXC+9YiTAEC
	+bYsKy9od1FIBkk+ipBzKa/A2FOQdO9vgV2z4JFMxA1QB4QTay8Ehyj7r4RwRxTdRKic5Ax88Y+
	FaEIxQJcBbVYY6Jp4fooGpiof0xTsE05p8rmgS0qkR4uXSz9rOP64NmNZgbzo2eTFUSX85Ahk8w
	AHG0Hu7Iv0IOM0zvPoOElG9188S7FFeef8LkMsGvw9lOjdou0zsTlwLQ8j9Yxp6O7GHFWiNaeAu
	GXn301NxmK4ciMj6afDQAPL+7ZZoUPPlUV/pP6OV0D2GEWCOfre5cIIciLK0V6tvfWeP78O6whT
	9aaY/p8o9LHb2wA==
X-Google-Smtp-Source: AGHT+IECObbByp0tAZ5Spn4gmKGNGEmTFTfklF2RHoCaHrLYVa+JwoH/UmTFPody74qQSP2grZ9tHg==
X-Received: by 2002:a05:6122:8c04:b0:520:51a4:b84f with SMTP id 71dfb90a1353d-525a8339647mr9510318e0c.4.1742824165847;
        Mon, 24 Mar 2025 06:49:25 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a73ed878sm1398381e0c.26.2025.03.24.06.49.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:49:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] mgmt-api: Add LL Privacy setting
Date: Mon, 24 Mar 2025 09:49:17 -0400
Message-ID: <20250324134920.2111414-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324134920.2111414-1-luiz.dentz@gmail.com>
References: <20250324134920.2111414-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds LL Privacy (bit 22) to Read Controller Information so it can
be propagated to the likes of bluetoothd.
---
 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 3181607d94fa..2fe8ca22b9b5 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -336,6 +336,7 @@ Read Controller Information Command
 		19	Connected Isochronous Stream - Peripheral
 		20	Isochronous Broadcaster
 		21	Synchronized Receiver
+		22	LL Privacy
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
-- 
2.48.1

