Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378191;
	b=oh+fNFSusc5va3e/US/raKr7+d88V+ZTnIb7SHENBZchVtVzDe6xBnNZytbbmNFJkCC+
	 ajWPRwHDFddCHGJRD+mvbYgFdPWmDIJgwBQg7OpgSLXDYGu6oVTbqydZDFOPtM1Y+/kfG
	 fqdZKVXAv9ks8AAtdijLLjfHTX4QoVHdgzZis7f/XgiZwI0taVlHeVV2l/p2HOvzlD28N
	 15CUBAWZqnRurG7707gUuG1h4qaeK7qA2jYEHjouFZEnbY2Q6fF2acMH9m/HBQcsfxSVc
	 X/6n5gCq9gyeqRuTW2ejeuMeIlxnqHGSsS4akLbFDWG0j8H/KQ9mA5LhhLRKA5C4xtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hMwq0jwnpGY5DDXXzn0wA2/J2r8j9XeuBLIl8Yfy6eU=;
	b=GaQhf0aRqI0/iKzxq6d73g0GEc/HO0TFWMv+rA4rnCxBpPhxbCe9K0zd51KjMw3wP4eu
	 uxZFK67fAVaEUM3PPn1Xkek7wZWnQ6KNG//1611xPkYhKCmPqGZfX9M2YtD2iCKDaQGnb
	 +ZjepxDVNsMpElFAhO8GTyWq+SJb5KWA0KBt6Nzsk/1C2zMk0kdNMrBpt7YZHiUTA2y0P
	 oFMneBB5UOQKTvyinyAK+mEZTSW4pMjRzphSTjvMwn/YOAuqGYZRQliirhpCBvM0d/SHk
	 dTGZ5iF9GWR/hIRbiyD8p0odsIVKPtIPIWR3bo4aKbPEQL+6kGFIaV+/fON/lXEQYDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cNppgfUB;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDA606A699
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDDDA606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cNppgfUB
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso24969915e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378189; x=1795982989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hMwq0jwnpGY5DDXXzn0wA2/J2r8j9XeuBLIl8Yfy6eU=;
        b=cNppgfUB2S0u8no+JUTpWJR52lniSmJqK5UIW9HWGYH9tWFVj4E5PCci5E/6WsEfs/
         Q3nSkGLIT1HQjIh6gjrZIaX9WLAdvYJDLtYsCi+uv8S2vOodrPysMvZ2XDHTymCgdASN
         kZELVX4OudCt0MAQGdUb6gLSakSdFHOSoefIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378189; x=1795982989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hMwq0jwnpGY5DDXXzn0wA2/J2r8j9XeuBLIl8Yfy6eU=;
        b=ZK4SWBLoNI7c7ZDL8lVMWbCAs0iFo3gI88+kwy1VB2eZhCheqOJOHRY/faamdw1nkv
         oCTURco3V01MEjpv8A5FMPRiW9c/DZORSeXt0UPh0KRz7/NNTAf/n+JkuY3nF+6yaN2u
         CC+xxCvn+OId2Mt7jBWSGHrsDKtYLOSPqiA6kTZAAjf0jZzSGi+LuZzlxS+z/37DOXPU
         qpmGcxtmTP+lzwTuxir3x71NHh7M87odHNhzCQ3LjADJZ7PUo9KoahpYGj1bIQWwBNnE
         XpgWnMoowrgNnNiF0TMyM0zmmnmxjY25INoc5kTxdpjc4x7l76SkQNZIpFkuZfucs/TO
         t17w==
X-Gm-Message-State: APuU4Z+AvMY95i1KYuat+eQJvDOmqyQGHjw6eS5Yf0IuQVc05c611mw7
	uePngHRQQDOAkYE5i6evH++9bTeYvmEgUydBSVcGSDUPg9PmUhiTH+Fv1j0xAGzYpXnkrvN5FEh
	tdrB+
X-Gm-Gg: AZFdTZelEGe3SGM3nu68rimnR1lnM74DoFf4iiQEF8KFQd9LW/wSqssBr9HmmsoNKBv
	+LfWM83PV4DQtoJK6z1pRgtECV8qVplNSJRcYQOdFgsCP5ibBTTSLNjdYoLOqSH6XlINScVpI2I
	AO5bLP9huJ1gObdlRys6YoN4OkXL9UrSS1AYZMzAg4v+0AESW3ducBIJnUrItCDx5svi5HexJrQ
	nm1HsymWC/g4sNxY+5yRHdlKBdrzVTmdRNbLz7fDTY3AweJAIOdjFLOGwW9jM1RKsSXUosLzi5i
	YX7oGuqfSvF0NdPUufcWNFpv9BrVEmUXeSzcLRYf8LrRN1+xndOQw/kHL6C6ZS8YN1J5U7xhGke
	ZfoKNK35p323eEQ6SdMo2UJV23C/1t2o51Swx5nOD0Ir9Rct1nruFiJqENgQvZyVRbr4PVD8nDZ
	GfGKsx/Eu2hPOZpfGRfpsHG1IB0m6AEatgp5Kc/IJkAWp4PGFrdllQOZ2uxQP321xsxOqjX4mX5
	fZJS8Aqr5Xe03ZyW4BOg5khnsoSUp68BrkVkNlqFuhuYFG0R6nZauK/2MFVtGvoEilaaJ4Pn6cr
	W2BJpGpBblvVV1fPm4JhwvX93vnsdW2Ci9gDMkev/7UskdPYagXP6962ryw6aqJqBAYNxQ4=
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4bb8881ae90mr209873685e9.32.1795378189248;
        Sun, 22 Nov 2026 12:09:49 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm537907435e9.4.2026.11.22.12.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:09:49 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: lib: Map Connection Failed to be Established to ETIMEDOUT
Date: Sun, 22 Nov 2026 21:09:47 +0100
Message-ID: <20261122200947.2780757-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

Connection Failed to be Established / Synchronization Timeout (0x3e) is
not handled by bt_to_errno() so it is reported to userspace as ENOSYS.

It is the error the controller uses when the first packets of an LE
connection or CIS are not received, and when it cannot synchronize to
a periodic advertising train or BIG in time, i.e. a timeout, so map it
to ETIMEDOUT like Connection Timeout (0x08).

This changes what userspace sees: connect() on an L2CAP LE or ISO (CIS)
socket that fails with 0x3e now reports ETIMEDOUT instead of ENOSYS.
BlueZ iso-tester "ISO Connect - Reject" expects ENOSYS for this case
and needs "iso-tester: Accept ETIMEDOUT for Connection Failed to be
Established" to pass.

Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index cea21a4c49a0..0f84c397891a 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -89,6 +89,7 @@ int bt_to_errno(__u16 code)
 		return ENOMEM;
 
 	case 0x08:
+	case 0x3e:
 		return ETIMEDOUT;
 
 	case 0x09:

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

