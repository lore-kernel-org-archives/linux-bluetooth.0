Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87E125C1
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479595; cv=none; b=Km+wbPjO9wLZeitksNOjmWcfGr/RXFrmSOAZHn3yfSZL2xQC+tNL7RQ6+ZD35SCf0InHfAeWKkTXhEdy3790gLV3uU4/aNKSFr/6+6rT51qxa8F3LHokiSOHiocdzL4Q6UdZ6qUjii3/lwVF68vMnY8EAkgG0dmhMmZD8mR3Ad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479595; c=relaxed/simple;
	bh=tdW02JtjijsdxTCSM5tkxlwFOP/eLVq6eZod7wkmGv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ie3h7ZI3l58QwchGHwSKRqOA9gW+tO6zi9pJUB255YroXgAe/u+G4oAijL1wx+L8BfiJOfaAea5jejAe/fHPgk4LoY4yXyLxrufoV5rjtfUjpciMHzYKa5Z/BRlF/Z3zcFzwwphZYYaWWcFXApts9+nxf4XOlBc8dBwfY8SBeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=uDaLoYJt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="uDaLoYJt"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59c0a6415fso1213006466b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716479591; x=1717084391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwnwPjzccLpPvdiGanFWdjhMbKs+Z/p4Bub/3nQbGtY=;
        b=uDaLoYJtGHiIDtQZcWnNk/UaPux9h1y+gLcXqosBYirAoU0V5JnPDd0N5KAGJUpGTp
         Pdz4EbEJgpc/gL3wPuVPdBktPg6kkc1sT86QCCLfSJmPu3alxi42R5YT1rMhzpTynoFh
         WCKq92pI2aGf0sKNED+uVb4FwDeyl/5y9udgj+Dj4Mf90VC0o/+ixOVWeuc7GAe+apHO
         F0sXGGp7xovng4ms66bJ6VTlKlOmijX/WdJAerVV2uaQGdBBfBh3NcxkH2e5XjcCIaQT
         MnCaOJjPdUSw/fF9xIRIP1bnZx2NWEX3zyHZ6M2KskQDykBy9o/V69zQsaJkPRzcMcc9
         Z1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479591; x=1717084391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwnwPjzccLpPvdiGanFWdjhMbKs+Z/p4Bub/3nQbGtY=;
        b=VsJjih4/3XXAB8dGg240mjBEXCJQTOxZBOf8UpgCvokPtqiVF0TWuzRQSZt/S9vtdF
         fsMiyA3jfTb6dbvz1Ware24el5sAyGQEoyKzhWctdVhVaxII4M3gkjlmMwVK//k5S0Hl
         GptZde3dBCHED4aTscEVVupoM/yG7htnzJYsewQzvg0i5xXwstotLqa5BH9CwNe1logY
         GdtHDaS5tnMLIyBcB6f+tPU27zylZ8BunvIwUwwjTR/RsW09awI9AWwGrz9yohTEUoSu
         vgXiub7i4suNUcGA8byywKVQudOGK/c3ANpXLxWti4/7DnIp1fKMtxGOOJHRYUC6P/Kt
         sRJw==
X-Gm-Message-State: AOJu0Yzb1CV/nMKz2jNd3QgTKkv0VB5YtuMLEX+32aJ2HTBgpNYuCAsv
	WOX7AalGQ+xxcowdW6gYwHg60fxqCtrZkGGQxlcbX3lPUdBV4btimhLdfMZJm+pmMREbi4FcKPc
	W
X-Google-Smtp-Source: AGHT+IHAI5Mf3Z5uTa+Qu06Qa9I6rXpduoHfFBAEpAGbFa3QqvFWTnSch9FeDDGLSrwMhCPwaqzSCA==
X-Received: by 2002:a17:906:34cc:b0:a5a:6f4f:e54e with SMTP id a640c23a62f3a-a622818e3ecmr383455666b.65.1716479591235;
        Thu, 23 May 2024 08:53:11 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c686sm1947600566b.47.2024.05.23.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:53:11 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v8 0/5] ASHA plugin
Date: Thu, 23 May 2024 11:52:56 -0400
Message-ID: <20240523155301.140522-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This is v8 of the ASHA plugin patch set:

  * I've now refactored things so that fd management is all in the
    profile code, rather than shared code
  * In the process, there is bt_asha_device struct, so the transport
    only interacts with that, and access to the shared bt_asha struct is
    more cleanly mediated by shared code
  * Absorbed the connection parameter update into the first two patches
    for easier rebase

Cheers,
Arun

Arun Raghavan (5):
  src/shared: Add initial implementation for an ASHA profile
  profiles/audio: Add an ASHA plugin
  test: Add a script to test ASHA
  gitignore: Add compile_commands.json
  gitignore: Add __pycache__

 .gitignore                 |   3 +
 Makefile.am                |   3 +-
 Makefile.plugins           |   5 +
 configure.ac               |   4 +
 lib/uuid.h                 |   3 +
 profiles/audio/asha.c      | 533 +++++++++++++++++++++++++++++++++++++
 profiles/audio/asha.h      |  38 +++
 profiles/audio/media.c     |  30 +++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 194 +++++++++++++-
 src/shared/asha.c          | 368 +++++++++++++++++++++++++
 src/shared/asha.h          |  64 +++++
 test/simple-asha           | 166 ++++++++++++
 13 files changed, 1410 insertions(+), 3 deletions(-)
 create mode 100644 profiles/audio/asha.c
 create mode 100644 profiles/audio/asha.h
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h
 create mode 100755 test/simple-asha

-- 
2.45.1

