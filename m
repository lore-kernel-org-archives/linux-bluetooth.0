Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1C15099A
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058972; cv=none; b=RISOyoDZKqSG/COgkiB+/k6YSMZx8Df740eMWiRqY0gNSEmotpxcTvCPuBVlFUWrrMaTGJIDiWexGcw2Ye+1/hQLPuu3nTeUc4LEDmn79HI//NyHirgRYxU+vNw5oERLKcBFzezIdgKAMhkBVw5F752Y+xmkBHHwpbqk+31IUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058972; c=relaxed/simple;
	bh=yRgs2oKSK5mvvh2f4ecDY63LiWwaoIa0w88lL5yIgXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpvM/AYSLcxe4Va+lbi0HarLsIZuyWO+RwfqjbRu/XW9aONcX3WF8w1WLXO+PDR+nMPe709F7XU9VMBBQacq09vXc+1qufGpcF0/qh4JmAH6Jdh75nRbM8oReM0GnunWowrzcg+ps+2GMXkuNRO4ExHQIYm6qDXIeRFEoDdaMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=KhwWteA6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="KhwWteA6"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4405cf0cb1eso2408101cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1718058968; x=1718663768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29QxwBmSBGHvtZSixP9QwBNl1hmBr1E+2NRDlhKbMnM=;
        b=KhwWteA63wGcK2/ARBd35uHyeXGAnHiGKFg1MbXnrm3FWnM7sfrn3ecbrhap0AWDDX
         LgOr4IRiDS2XCfPhA4hwz/YThiKPpWnfmlEa8GM1iXfeTZGNwdNOkMRia2Xp1LfSEjlR
         a31LM+xdOQq2rsWwCgevAMVYk9gdSZrU61v/kk0oTq19765DEtdRqakgk4i4PC5uhlAh
         Iwh83MHRYOqTR0OP0soxzV9po1PGciSyk/wxZv+NHhQWxRY/fAlEfA6y4x0vfY38RWp+
         os4T4TRwJpm+OXBzK6Mx7dtUNqackr27sRLeSI8Jqk47Cd4NpZs3pCaw+VW90WwNDKTy
         7D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058968; x=1718663768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29QxwBmSBGHvtZSixP9QwBNl1hmBr1E+2NRDlhKbMnM=;
        b=F9ots/0gNm/tRxmkUYyue7Eu7vRLRoN+VWcyLwD8Dy0F/r6XG6Okbaks1hIkYpqrHz
         pg78tfyFwDOovPhcdQZWiFqWUYaYgPFJTSCXhrP15ehxlt3ZkJWPZfZUfk2bIXO+PnmG
         8O8U80ZBRryygUfmsrfKTTSU+Rb5l/YVJwi1pVLBlRn3zH7Y+Xuvl1fdB920id6tgHHZ
         yBD+QB6CSaxq8e+5kA09jfyNWD/VN27MZPfciJbi9GL+W2ptIC/uvcZJG9yq6zU6lltA
         F13pUb8J/Pru9IVzOzf3q8xxNKYNUoQG6c9iNaK2Jz+St9/x+KIQ/BWt4wDsmInDMAIF
         vzLQ==
X-Gm-Message-State: AOJu0YyuCrgzZeopaNuizvnHzNJGtcUMaZ5FaqbCQB+yizPQ9noRGsMk
	FN9oULv6OcVF30GRNsJ02gn6C9Xz1zB7Sn3bE3ZYk8Jsz/1a9hl6Sb9EDKHffUdawdWvHeYUBoO
	m
X-Google-Smtp-Source: AGHT+IGQcbg9oVgQG9MOpXv+VhNr+BcY+3aj9lUzaaQ09NwUbProk/AOqdbONIiHMl17hFrnpaIkIg==
X-Received: by 2002:ac8:5e08:0:b0:43d:f335:425b with SMTP id d75a77b69052e-44041ce39ebmr134790271cf.44.1718058968472;
        Mon, 10 Jun 2024 15:36:08 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440711c3c53sm16283221cf.80.2024.06.10.15.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:36:08 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v9 0/3] ASHA plugin
Date: Mon, 10 Jun 2024 18:35:58 -0400
Message-ID: <20240610223601.378127-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello again,
Here's v9 of the ASHA plugin patchset. Changes include:

  * Switch to btio API to connect socket -- this makes the connection
    async, so we don't tie up the mainloop for longer/erroneous
    connections
  * Minor fixups based on CI/lint
  * Trivial gitignore changes are already merged

Cheers,
Arun

Arun Raghavan (3):
  src/shared: Add initial implementation for an ASHA profile
  profiles/audio: Add an ASHA plugin
  test: Add a script to test ASHA

 Makefile.am                |   3 +-
 Makefile.plugins           |   5 +
 configure.ac               |   4 +
 lib/uuid.h                 |   3 +
 profiles/audio/asha.c      | 524 +++++++++++++++++++++++++++++++++++++
 profiles/audio/asha.h      |  38 +++
 profiles/audio/media.c     |  30 +++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 201 +++++++++++++-
 src/shared/asha.c          | 360 +++++++++++++++++++++++++
 src/shared/asha.h          |  63 +++++
 test/simple-asha           | 166 ++++++++++++
 12 files changed, 1396 insertions(+), 3 deletions(-)
 create mode 100644 profiles/audio/asha.c
 create mode 100644 profiles/audio/asha.h
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h
 create mode 100755 test/simple-asha

-- 
2.45.2

