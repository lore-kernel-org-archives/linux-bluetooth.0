Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567314;
	b=KHZkpBAsW5WF9gp+3gzcrgZmv7W6LRQ+FdkRs/yHexyA6DQNI6pqonyrjcswSkEbGBeW
	 EFI11HE6F9xgMBq+tMrs/umDf9eRLXAnftRdbEk/wrmEvXrOCb/XHSliSRu/M5uHkZjog
	 w6B0zlLCMVdqU6Qnl4yaKcqDa11ssMllXbQFTKOvC7avLPYEK0K0e84QdTl3ckzZb6e0I
	 jYKS2PUfM7WSk87ahcB3prdnFyyncMp41tn9MGmqG3Dq+DgB9BEZ30CpAIiPruFCwjmng
	 q+vl8FhHJmLsLq6I0+XXT2GSRsJXj5++3rarNnE4GWYoVYZFppLk4juRGbfD8tErfeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+Hw9AociNSPeM7PIE5erW7iCLcqS7a+bHpJxAxY5cUM=;
	b=iwSPqPXvdmXgpLJtZXcfPb0+bj6lx45ltXEuUFnyYrkyklZhW8cu1TvDZJRixXKjG7Qi
	 dYIkJD3sp8Jy2joKy3QKsdfaG3fNl1q0xqPxjcHKmOYEZSJ7ZG1j/L4x/6uG/aaFQf0uh
	 V+1y/dQ3nsXkdQBPifId2mJsnJpETCUjKJohYN8Pl/U56LTjV07o13z5AAL7lJscIvpWf
	 o0XaISY4pdLGuYbhDPaHdMGpuvokw+S7a+EaCusREQBUOwNziePB6waM4Am3zy/TjFm0J
	 RgjTwK9yHhOgrPBcdfnqbzlMGk5aB4Lv2TGYREN7EuHl1SBdIRJ+4dD6XuScjzssfuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tooangel.de;
	spf=pass smtp.mailfrom=tooangel.de;
	dkim=pass header.d=tooangel.de header.i=@tooangel.de header.a=rsa-sha256 header.s=google header.b=DSiORcLg;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64732606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 07:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64732606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tooangel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tooangel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tooangel.de header.i=@tooangel.de header.a=rsa-sha256 header.s=google header.b=DSiORcLg
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so556384a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tooangel.de; s=google; t=1792567313; x=1793172113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Hw9AociNSPeM7PIE5erW7iCLcqS7a+bHpJxAxY5cUM=;
        b=DSiORcLgDKCDAzrNyQ7ecqwVbUwkg1GrlQC3jhBjj/CTa6PZo7tI449+L/86vCHxgk
         ko5jXNYq3wp220zrAN69Q5nxRROaTlZFYr6sNvEIwr1viRsvaDkjNSVIYmYQkcHG+ALX
         LsYYVq/7TznLQjbsUoRg6D4R2+HiCe0/rhSk/PU0uThh5ohAkAwW7reNcwMYQd3mvgkd
         Vt8BVC67L8PRW21D5mFR4zC6a0aOjr6EwzipUIZrBtA9UfPcOggpy0v8VB13c6FHgptm
         R4WdE2A9UB6hiqmS0mOgRLK1ssv1GA5HGT20aBF2E/UwoGLK8Me4atEf2WCEGzU/VzsB
         8NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567313; x=1793172113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Hw9AociNSPeM7PIE5erW7iCLcqS7a+bHpJxAxY5cUM=;
        b=D3JMSUZH3wHjm+IcRbVV2V7WQ7KneVIwrAXp0kZG9/rEeogr279JdikKeEuhFPAdMk
         rw2NM6xpdAWvE5VoZbdlPC04xTwxd6vs+ZwbkjiS2afRFR6zTa8P4G3qdobSTGG6SegD
         s6h8ccPcwu6BO73sHR4ngUpuAofewWEiglrWuKINARrtKrYXprSPvAEnqCL0GfP6oIvo
         AjeC6itM9w2UriXILRYHNPu8RTviy28TRFIlVLiEggEn6hGVcf+UKcGPouuYGmUuVycQ
         GXYxj5X3ylIiuxBN5ceFVVVy5ydJPA2aiUpGDwa0vaPblxXVGOJkfvoePEFH3uGYxOdK
         N9Fw==
X-Gm-Message-State: AFq9FYI6WkP6Rqsgp/JhfDMgb8Ero0wgEfbGJ7c8ZnqOGLsUSgDPQY/Y
	nlgB0lEjS0IIQyoPEIzlcZt7bNkyClT0Usp96skIQr6BIqOm4hHM17AXMi75Ezouwj6G8ExJv8a
	fFG4TpNHFSA==
X-Gm-Gg: AYBFou3RcXaF8v0vvXWr2IcZLZcTOGsOItxVCvX79OpGsZP5vD3ImTMg0ZAPM+4c471
	k1aTuN6T7vXzktcGlIQDkRAcclLkaZ64g3vywpMJxg+ERc41+e7YJt1LtA7il+vVpX0S3kgh8N7
	E1gnVfYxU9woD8K69tlFK74JDpcSKcGfAS8FuW9Kx5/GP/WLedfsQ6Yz2jRa6sAaB+dRhQN0IXV
	1Fl1qXOoWTzOrNxzpQfp0+EiLDtKHqdMkpaVjcLjMQ3lyVt7zSLNWgxVA0O/knfBNzMWM/aHQpv
	jnZdWmh6as3+ErSyveTlRqb0cCh2y1ejzWGh9BWEEoZagyWXQiyEuOsAyxOKWfVSAMbkUcKyFSc
	8JC1NYMwpoStSUp3iL3SvpzCoX4dvw4lHWaMCJQySTemivVv1NnjN/x8pQzaQuoLStL03TuTAGe
	2kcMDe3oH87B00WJa0fo9ZisrywHTtKqLbb+248H9RptcM0bcWPpz1VOTjiMYdW9YMOhKzqcqoH
	dGh4Pi45p3LVmG6ixBjcZFUcQUefzPY5RiKXtL86n77A/PxhG1du2SaqabzR1peDcs1IjKCwgoD
	dMUIQoCK7ZMZ/x94CQQtZ9thbLIFw82uRzqItXiBEU55+0x7QhHba1bbnelqIMQMfVTnhzRyyWr
	MgNqzxO0OeRw+26WHFe2eDDnpntTTcRgcfzwu+ku/FDsxNJPQwjf/Xrsk7s60S9HbtKVAdW83RM
	XL921P7vQ=
X-Received: by 2002:a17:907:72cd:b0:c31:866c:9696 with SMTP id a640c23a62f3a-c467973ae23mr94677466b.31.1792567312823;
        Wed, 21 Oct 2026 00:21:52 -0700 (PDT)
Received: from toogaming.fritz.box (2a02-8206-7df6-9800-2fb8-381c-b7e8-86f2.dynamic.ewe-ip-backbone.de. [2a02:8206:7df6:9800:2fb8:381c:b7e8:86f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b40315506bsm534286a12.29.2026.10.21.00.21.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:21:52 -0700 (PDT)
From: Tobias Wilken <tooangel@tooangel.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] doc: Add CONFIG_RFKILL to the tester kernel config
Date: Wed, 21 Oct 2026 09:21:32 +0200
Message-ID: <20261021072133.136948-1-tooangel@tooangel.de>
X-Mailer: git-send-email 2.47.3
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

Needed by mgmt-tester to block a controller through /dev/rfkill.

Assisted-by: Claude:claude-opus-5-5
---

Notes:
    As far as I understand, this is needed for the following mgmt-tester
    patch: without CONFIG_RFKILL its new test is skipped instead of run.
    Please correct me if I'm wrong.

 doc/tester.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/tester.config b/doc/tester.config
index 34f1530..a9d8de2 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -45,6 +45,8 @@ CONFIG_BT_MSFTEXT=y
 CONFIG_BT_AOSPEXT=y
 CONFIG_BT_FEATURE_DEBUG=y
 
+CONFIG_RFKILL=y
+
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_USER_API=y
-- 
2.47.3

