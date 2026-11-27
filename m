Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755514;
	b=EPdBxLXlmDMEJw3uPgKPoDfI5gbCGZ/mIgMpi+/wJceUFY43dXMmeBq4ee7ULYng8Smo
	 sQO3ldBiKW/ZbF5zp6iEK7GJT1pos2iiraqfze8KJpVZ2xzX0MdEiXRtiCJscUh2MJm/K
	 xBr0fozmETCSQLii8HYDJAtwslaej2RlLpEMBQaPojcTk2vMGoXe0KmHrtIac61CsKR3H
	 oDM8OhpxfzPGxAzNT3EQ4N+lrCRVLvNj3v9MiMrXcn9LR+jsSirIxCk41x4D4gQqrVrqg
	 zziDJL9mBeTlk+NlWQ+zeTZSXGmCu6WJVqWjz6D/SXYMytGwJscWXNsSDXm7ne/p6dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=PQdhw/kpFn+qimbagnZVtfP6hWMeb/ZacYQ4LAFwgSM=;
	b=EV0RR8mPqTJLGzkUbxmMoep8UMq5F6oNAu3KzZlU/M6urYLtgAOZr/Ct/myMAHniTjaG
	 +q/gXtS8QnyQVHFCdFTBS8Qj+7ogXG3+QAhFb3aeixueh8IWInHyvYulDXUpUuEZIpfWN
	 ACWzR7tx5a4+yw9vlQedfFjuY1YTYjV7sN2jOkDdb5ipnxkfxzjSTQ1PDWrT4fSxYy1hq
	 /MkPs6bodB6iymQtgytotHHdTQF9iKxrILhmUu7vFo8ufsSYha3OLWHAKJvp58v5PWW7A
	 L2orpaO0kceWKcnuFixnTGLxatOIhHUGRfjYzn0zkN86IxSK6fk3ju36Mfsuw9qbKeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jb+7jRaB;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DD1606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66DD1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jb+7jRaB
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so4585583b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 20:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755514; x=1796360314; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PQdhw/kpFn+qimbagnZVtfP6hWMeb/ZacYQ4LAFwgSM=;
        b=Jb+7jRaBj2cHCj4UfZJcV5Qcjj6rXvQid6tN0cdxozRuJZMgMcqR5UgxlkIzHZWKbG
         gJ/ElD0m7Y5RdlM1nB1uEy9sHcT+G0NsVJxidqwalzAr+JNs2x5MQZlYWiAd/sTUayEH
         hYGNpcaL9GeJ8OhHKF/6AfVsJ2BG+NdrHiwUjkhS0JXSavImIh5cKqR5zaE9r9ikGlLD
         aWkJB8Ta4HF/PF5EbKonFII7Tqjcf2KrdYf9G3UW9XOlmRkQAwInpBRI1g7cx7v1e11v
         8GhlGe+JFegYRw7JArq47Nz/WQZa7yp9wrAIMg2502ZcVSCmF6SRLP1rj+gah+WwgNZU
         LPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755514; x=1796360314;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PQdhw/kpFn+qimbagnZVtfP6hWMeb/ZacYQ4LAFwgSM=;
        b=F3XClHyym0MVnXTSBqxkkrGPWSlSSUzdxMofj4J2Tc29J0++ETaxmb7u/HCzh2V8j2
         poGUJ1lonKNoPk0/OVU4nYofOs0LsflhJ0cb/n4ujlJEemSbaEC9jST4Ele2IXsRer3d
         2Js0pBkyofQssEy8M7OAxx0Tz7/e8dU2m0391AIt0+PA8QHUcFYvb5khHVCbIndGVDEw
         y9jQ/7Vk8nV03ZOgjfTbUq+rjOl8YuhRhbM4pVItzUaE1qleYlmzNMsnK49epK55g3lZ
         Kc1VCUQyrSlQ8iOTkEt/N7cu9kxGwW9ZvUhlbcvZxPiOKpx4zBpDW/8CNpzE56qXyDBz
         UMcQ==
X-Gm-Message-State: APuU4Z/GLzKGxjiLKUT601X1zSr5LeMnRGK775oYs+EsSa1ZjUzg96hr
	iqO61yJ4Yk5/0egB30dJUaK+E7riHLmmt4Nrsr8gHvlpObn1Q+88O5kTKTzmrg==
X-Gm-Gg: AZFdTZexMlULeozmrj7OyLbMpaO3ukb3NuESl7qvAErRR0tmE3P6eQExjuxxQrDXWIB
	RuzcuSr7E6KXcVpx1MVRb6HTVtWZY2V9NZRR+W8xtVKmM+9ajQ0DRv3cXkLUbFITB0+ZeZHMeaG
	JH9Kt9rwXkVzhTagxWOkgNvVg2U6f9seQGWbIsUG7g2MjvjJpeqnZr6TP//Rop1yWzZGdv4XqpA
	2KmsdroxtjQ3EbOfnAxPG9Tc1xrlvYPII1q5aPVNMVJ/v21wKi0umRmFgMN1iZzvek6dUZUFO/c
	HbUk/a70mfvdmhy2z3yHDNX0hlgVhSKZ1Kah0jYP5euLjxOvkIOiATHMj8a0qRZ8cAln+BRJJKR
	KovKr3q/hED5MHi+xBRLwniZ/j0xQSchzytoOsiwCMpj60EN+zMT2ldzCZ95eBWWFuhgTzzr99F
	bal0FTPSXxvbtm9F71iv5Py9kOJg3OWoz8HZrNwU9IswDrJ2R8f1aRi1pJItTI5/MuTOBDH8CWo
	6eKJALkqpC9mE5QZzFm1QEbLtN5hTirmbN6SoYfRl0yOEp1Vs/uwnsuAY6hBY/Rg94UW61oxZDl
	Cg3X/ybfASMI3FczB6T4iMpCHhdFRuRtE9enut5X
X-Received: by 2002:a05:6a00:2384:b0:89e:70fb:9da with SMTP id d2e1a72fcca58-8c7d844ecf2mr16634542b3a.0.1795755513654;
        Thu, 26 Nov 2026 20:58:33 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-112.us-west-2.compute.amazonaws.com. [3.42.157.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f726sm12297327b3a.36.2026.11.26.20.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:58:33 -0800 (PST)
Message-ID: <6b090df9.933e9b20.14a0b0.d4d3@mx.google.com>
Date: Thu, 26 Nov 2026 20:58:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4879239409746678171=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: shared/gatt-client: Track internal discovery reads
In-Reply-To: <4c16af75cbdb770ef8bf3ba44ef2173c10e9fc8a.1794432472.git.cochcoder@proton.me>
References: <4c16af75cbdb770ef8bf3ba44ef2173c10e9fc8a.1794432472.git.cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4879239409746678171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       shared/gatt-client: Track internal discovery reads
   Pull Request: https://github.com/bluez/bluez/pull/2810
   Created:      2026-11-12 00:38:04+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4879239409746678171==--
