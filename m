Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D38529B
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814632; cv=none; b=Dh1omMCxrhd5DB543YRqdQYoaDn5WQf5zvhoO2JKn/CLbBMujNtgalaaiogQI6Cui5IAaOkbh1ncchJ9WkKgD3gQ6BeJVngZU/YQZ+uB7U5iPQkU1fN9+qjyyavtxN91YKNPPxEdGw9HxwVvFJ2DEN1+8npYDnpUA0Y/u0e6+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814632; c=relaxed/simple;
	bh=/52bgWmfzVBdBycWkeYpSqsNuz91qjGOeus3xfaIrU8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syfMsiO44rFNpkMvV8ydSb1dvutSkzY3zqA/ZUyOD2CNwU6WilyxO/isnFZMan6F4KQ3aMSaf/xqozQeCpYwDLujI8aV8i8ieHodhtyJHZSCs9brNRZFTImMTDI2OkE4B1FvxEHmNh7kwD5Z+j/egtDuyh+IVK7ZoMJMekDxsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/Q/S3u1; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/Q/S3u1"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bda4bd14e2so1030289b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814629; x=1707419429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqkf6vTxx5YRE7E2hXtKrZibTUoWwFKj03+5JwG7p+o=;
        b=J/Q/S3u1J1Isv7YqHCScz+Z/SwIMfeBgQtUBo+8+eqC3l8irBlJTy0/p4P4rS+iory
         QezsLyYSAqgGYCMiUSmT6SJ9HMS+/fZfTnT/ULVDy0ET55iRvLdU4nBB/uoArkdr3+GQ
         ntS6pp6P+XmvpRUVz2fznw03MUOLsIxGewiYV3SpX7JXLws7LHI+ue9Bzz+7X1mLJaYf
         FoVs4UC/OQEDz/uY6jnM1OlZz/yHPwYgzx0WWGqZK5MZSno+YXd+8UNnWxxg4Rj+UgtE
         Q7bYqx6YBiRd96fpb8ZTUV3UcRUykwHxn409dT1KiSqFQF8krM1j9NPWqfqHMhfTIs+6
         8euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814629; x=1707419429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqkf6vTxx5YRE7E2hXtKrZibTUoWwFKj03+5JwG7p+o=;
        b=dA3OBeqdjsH8ZZZ9DbdvgUxFldXacqLEDVRnpMiDiF0rjg4tN40CwyJEiFUnzsaUV9
         QlsOxK4QAzkBNUH+WN5FMvNNPTy55TM0yHoH7lQcjPWvrp/CG92OH2k/83hbn7StxA7H
         OtzLUsZyzKl95ES15gEfKp/JLMlkpVkB43nbs4O9inKLqHdRuXm7aaYWjVIImmJgfkie
         XG6KLT3+fMctdFo8QPJ/P1z/PRfyXD9uBlr89LFnVM3g26DlvZEzTAIsqlAYGBNkoSfW
         kCH8/WDi8mePMAcolBTq1H7brrS//ow38XzUHm8w6/LCKtvdNARGhROxowqrpTpahWFP
         b+iQ==
X-Gm-Message-State: AOJu0Yy/10ZIdz8udr3F+KfqiZVjpEUEb9NJC50R1Kk29ZHky5RslbVp
	p64ZhDaoa9aYgrrqcxThK0n4G94GTIGJldZPKp1deC2T1KyQ267Js3NZG+UB
X-Google-Smtp-Source: AGHT+IFWEPoGkVvUO1haqdeT4g9EyHvFlupbuWNOlbZyCExsMH09QB1RPwpMm6vpxRlHpUGEGlrvpQ==
X-Received: by 2002:a05:6808:e86:b0:3bd:59da:57ba with SMTP id k6-20020a0568080e8600b003bd59da57bamr6152479oil.59.1706814629225;
        Thu, 01 Feb 2024 11:10:29 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db16-20020a056130239000b007d2e2f14bd4sm35912uab.29.2024.02.01.11.10.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/8] transport: Fix crash when disable bcast stream
Date: Thu,  1 Feb 2024 14:10:15 -0500
Message-ID: <20240201191016.1122194-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201191016.1122194-1-luiz.dentz@gmail.com>
References: <20240201191016.1122194-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_bap_stream_disable does cause the stream to go to releasing state
removing the owner in the process so calling bap_disable_complete
passing the existing owner would likely cause a crash.
---
 profiles/audio/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 796017a4c6de..bd8960ef74fd 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1532,7 +1532,8 @@ static guint transport_bap_suspend(struct media_transport *transport,
 	id = bt_bap_stream_disable(bap->stream, bap->linked, func, owner);
 
 	if (bt_bap_stream_get_type(bap->stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		bap_disable_complete(bap->stream, 0x00, 0x00, owner);
+		if (transport->owner == owner)
+			bap_disable_complete(bap->stream, 0x00, 0x00, owner);
 		return 0;
 	}
 
-- 
2.43.0

