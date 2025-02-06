Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248861EA7D6
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848356; cv=none; b=GrVw2Dbqx2lcYPuvdE57XNUs1D5tJWi5nJyQuPr3rbHo2/DN42YXVJ1964p9PymzjD4YRxNcGMMMaytCTo71j2nLgRC4nEQgMONCUiUm0jBcKBQPCKGE+P+cxZ9p1ObJEsLYNLnYuX6KuMC6x+O2c185VR2zV5WnFgXKXUgPZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848356; c=relaxed/simple;
	bh=bdsbQKTdXtCaZqFJNwlrT1N5y8XWf6JyYsRWrr0ew38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xeo3A73umJ7YZB+1nT1h8JdJHmnCSim0/LM292dPfLWfBeS48jFTikHxZFCghDd1oIBYhfiu+IEq7rsv/HUD+KpdrRTb9FsJq/pR62ifl+JIUvvL18qPpw9/t2rSqDbMR5hc4aGQgaKhV/dwLO7VBsMQ0X9qBT2pEFTL6tVSEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=KeJatSbj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="KeJatSbj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f11b0e580so17682745ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 05:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1738848353; x=1739453153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+1Yr52iPZKlzqdNARNVcyhrSrbMxq6DcLYS7qOk04os=;
        b=KeJatSbjSfzubMt/VZbNst+Mp0NlZ3xqCMaRq/IsYHP94LzbAaUgr7XLeazLapdw7Y
         pCwazSTHEBtmxbEViNa1A6i6PYTS9byESQmqofovc/2oXQkTddcGQO7g1Q90oOv0uu34
         HVtYd9I/cFF4HZCzqhpxbHyH61fi5bq6WAYtvx3txw8uPNrwyNOv6WZlt0j2/+g8KRYf
         s1XO0x+QAz/KSLtMEMleLgw5vYejwa3+s8dES9KSV/cQZ8uM5ZgI2XXoI3jn2LnA6pTz
         eEzKmKQ22/+fIz3oBFsc8XTVv/uhbnvmNZb55iZs+AaXIxNF8PUAy3L3R+djJ9HlhKys
         s3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738848353; x=1739453153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1Yr52iPZKlzqdNARNVcyhrSrbMxq6DcLYS7qOk04os=;
        b=KYKkR0bUXrMoNljE5hpnKI1O9c5m4LDLTM/PLJAa7xwqJ6kLIdibtDr0bXO++JhTiq
         b7XRLwVcMLWiDkIXAym2geUdI9ZFJ0VbQNT/322o4PWRS1p7aSXkdjs9aqX9+DARtSpi
         yzkOLUeBsv8rhomfj6c+vH4dzEejreExhEYBm8c3g/2Ol4Iz5nVCqdF4kZSxBeAzaDqZ
         leKeggQ6HxFT7vT79HIcpqhTGI7k7tQ2N+UkAAgXVMUZZYDUUwqtcc3MqiPJidTJFkws
         J758hwa5olu6preeiFnqEtPY8QmsHryfW19goz+EI7x4GhD14FMPtT3QutToVAXMqoQM
         lisA==
X-Gm-Message-State: AOJu0Yypcxvc4y5gUjH2QK6PbcmPZJDUx5OPxhakPs8yHnG0p+V3z+op
	fIrFNyJkwIkgOiMRebT0NE5y8HMJYR9lOcmkgBxnPMCUXfQZctNaRBB7CIfcEimX2t2FTFysdGA
	R
X-Gm-Gg: ASbGnctK2NM1gwSMcA4vZICn/8EkhWxzkePL1Gsbi/3JhK4u+2P2+4b+84Ioh0qx9P/
	I+DlZK3jWlZCBXQ4tZ2VnU7HWrMkD2v4IX6WfqQf0+vLHJ6bo1aw50Ws37pQl0cpQGLedFzdKQb
	ts+YMFPf7+bsV/TDhOtAHqE15W8lLLdBFxlwhXrqXgZLD4mpknlunJyxmnCmu+/IwTHMVOq8So1
	qPW/k1KaX7CNcMZZEFFk7f85NGzJsR4Pedwza+SoQcqzF8dEyJ4pFEFIeeVZU91cySFALu0PHKY
	eF7BTWBD28QjxDEf81v5Wg==
X-Google-Smtp-Source: AGHT+IFNxNVVxZcqkLhCkHbgzCOTR3xrzB3zlczo+NJNkd4SnqUyvpOAqi/dCTTqxFY+p0jnPMG2jw==
X-Received: by 2002:a17:902:f60d:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-21f17e4e955mr123648295ad.19.1738848353084;
        Thu, 06 Feb 2025 05:25:53 -0800 (PST)
Received: from localhost ([2401:4900:1cba:442a:bf93:c2be:de2e:76b7])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f36538c26sm12537075ad.55.2025.02.06.05.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 05:25:52 -0800 (PST)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: arun@asymptotic.io,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ v3 0/1] shared/asha: Add support for other side update
Date: Thu,  6 Feb 2025 18:55:46 +0530
Message-ID: <20250206132548.363559-1-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ASHA specification requires that the status of the other side be
communicated with the start command. The status is also updated
if one of the device in the pair is connected/disconnected after
the other.

See AudioControlPoint at
https://source.android.com/docs/core/connect/bluetooth/asha

Changes since v2:
- Fix warnings from checkpatch.
- Link to v2: https://lore.kernel.org/linux-bluetooth/20250204064103.672327-1-sanchayan@asymptotic.io/T/#t

Changes since v1:
- Fixes the below build failure.

In file included from ./profiles/audio/asha.h:16,
                 from profiles/audio/asha.c:43:
./src/shared/asha.h:56:22: error: ‘asha_devices’ defined but not used [-Werror=unused-variable]
   56 | static struct queue *asha_devices;
      |                      ^~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [Makefile:10783: profiles/audio/bluetoothd-asha.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:4693: all] Error 2

- Link to v1: https://lore.kernel.org/linux-bluetooth/20250130090158.266044-1-sanchayan@asymptotic.io/T/#u

Sanchayan Maity (1):
  shared/asha: Add support for other side update

 src/shared/asha.c | 170 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/asha.h |   6 ++
 2 files changed, 173 insertions(+), 3 deletions(-)

-- 
2.48.1

