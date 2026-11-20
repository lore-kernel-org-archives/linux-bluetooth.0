Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181188;
	b=bAQggXQWno5OK511J9szfVsXrN+0W6ycHdkEhDL2sugV6+TLJtznmOB15jj7CCDdIPQc
	 DmLQBGzV9psQTlxnhfq4EWDQ8C9LHjHsF+jxDceT+pn8i35oFcatkl2n696B4ui9vGAdG
	 C7SE0E1qNeNfgZf0QbTAyU2B9SVHXfKonHqYicxaR+YrmeuU+2zQnM++R+t4qa2mFLWbo
	 eLym6kGPODS5UOXNNkePbMWd5e59PAfWdTcxqLbuQJI+bm/VV03kp1553kthMaJKPi4pf
	 NOYMd0Ljv3h36IOlgB6HPFiSDsM65MlqICQDOxPCECbHtN5YOqMat/UaREDPlWpTNdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=hMw8PHKfCCZ8FYTHt1Z5gHPzUJ4zwuHaSBzwIiq1rEw=;
	b=rhacl3QpCV08bs1vNp9U/pgi0k98P4A2twxyRgyjxk5WBapMbl2c3ipgjhj7Duyl2a7F
	 idVrtmm7WX4xIK5fqrXRCacNMwAIqUENBCZGh/wg/lX7MP7U7o2tkhVDwyLPLK5E8u30Q
	 jGrz/P2SHFeyMQZPIZH/5diZD9B8LX3gQpPqM0K9tEM0ko09EFQYAaAc7RpLdEFvqDY9h
	 F9eAhbBLzuJLZR+FU7hNmpvuM8vFzTrlq8tLuFlUOFizeyDO4eEMCtDvFAzdFJyK00S+V
	 gJBUPxVqUXeMGne+B0v8Cq+4TJPOooqd8gNGAEy+Rg5Fqulu4k2/DbaI920lVQodLOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bC93OZ6S;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6BA606A33F
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C6BA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bC93OZ6S
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38587f3de36so1001633eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795181187; x=1795785987; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hMw8PHKfCCZ8FYTHt1Z5gHPzUJ4zwuHaSBzwIiq1rEw=;
        b=bC93OZ6S4QuoOe6HguwuabJL8LksR4Ee9X1w7T7Cewie/gcHSLUl2WQc89ap9/+IMq
         /SvvS19Fhy+Wx8Wi2PlMASJEnlaTQ5JZfa8I91Jd4oIC/O3OK+QJ5AVhtrVz+d9FMN7y
         smUuN4VsAe/EtoL/wTocj/EbC8H9MA+L2XOk23t0aOtXHI7zWxPaQCScHARRjRw5UDxI
         4NddHTA1ZbDqfXsFTTKXjVqXbhYY7JI0C9iX8seiW7hYxAThoCvh7C1Iy/N3YVpvVa3H
         Z0+LTcUJ4iAibmh4BvfqGDZIj8H7rh+jWSiyjwQA1/6xjEZndJNAlA08xQ45/rCPcvcf
         Uk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181187; x=1795785987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hMw8PHKfCCZ8FYTHt1Z5gHPzUJ4zwuHaSBzwIiq1rEw=;
        b=zOO3as6LOycGeVonQ+vpWAoB/RKcLAmMj0eP45PVwE/3Qj1t/OKCANYe06xw/0YFsc
         dRzfLRXPIP6Ja99/+x4/BABv0LgrENiHvmHIKPYAq3OlNGmU+h/eqkgD1TL6tuS43xFh
         oUqxm72qQkfA0v78uCZuboFKOXgnVf+Wap62QO4xZg9KXi8xfde38f7bOPEG8vY/NQYg
         tJOZe8nQC8Txi0/jezHnkCbbwUoGDKSWaX6Isjj2n1jE5WW5si9XBe73bOkPMlBbzEXA
         gzjWuRHn2razH4uKKQpIzvxxE/TCuBJ86gGqgnlL6ce/e9Wh9jrBQb0r56qmOeQtTGHC
         cb1w==
X-Gm-Message-State: APuU4Z9EjjtbyZF+jUN/Po9M6L3n7297ztXfVHPaY5v7MVzue+YGxu7c
	VFMulLV/cxz1JVeHM0F4iBx0CjthV/IGt3aLCY5vCBpunJ/X4C+meuaGYwYQdA==
X-Gm-Gg: AZFdTZeBbeHzy/Fm3nnl+SQzDWsW4kXeWArQsl7eR9iGGsdf7I/teFTYhcKkt/IjY3Y
	RXh8l0zAW/KpRr0LCgT+UXpoXJViC8vqfyki3tQHbq++wDKyU4XZMIvXCpv8ZHXTCpFhVUhKrJp
	tpUEV0sOmeMAS4o2zgO8SpwPc/x19HWSNLiI8CSz89xDqBXM3gWNmcvLtWUOVggZJQXQhwWjrUx
	g2sBbFtUg7XVSZQpMlFOycxsaVXkZTOF/SDtjfJlyhZ0Crx5GdhEwNfvnyCDo5+tNLb6byfhXxx
	paqDzxf7Gbu4eaOonI8i14rC6uxBoMObVFATQ1tvW0ql2sS4boFmEdP25tKVhPF2JDIzCBZjC8T
	rhw2FvsklkaD9DA/noFNYZg6n7A6NIhK/Eb8bYdrke4vhxZ9XkzS/tg2HakLjigaZN8e1XKi+GF
	YCpKoPEzLiAtqv0Nn6gY7hbQhevDaT9wD+MoBlSlHKw3uA5tAFUVB1vfQ4idxLu0626O9u87Bx4
	FVEZERqtOUfBldlvS7e7pzwwZ2XUt5FCvxXAbS0inuDB7StHyN5cKU40BaRK14=
X-Received: by 2002:a05:693c:4001:b0:370:d6e4:e8aa with SMTP id 5a478bee46e88-38570b34fecmr2969651eec.41.1795181187237;
        Fri, 20 Nov 2026 05:26:27 -0800 (PST)
Received: from [172.17.0.2] ([20.169.101.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7fc3sm7539983eec.8.2026.11.20.05.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:26:26 -0800 (PST)
Message-ID: <6b004a82.e5646aef.135df4.13a5@mx.google.com>
Date: Fri, 20 Nov 2026 05:26:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8800677509597923027=="
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
To: linux-bluetooth@vger.kernel.org, enderaoelyther@gmail.com
Subject: RE: [v2] Bluetooth: hci_serdev: stop write_work before closing the port
In-Reply-To: <20261120062048.40310-1-enderaoelyther@gmail.com>
References: <20261120062048.40310-1-enderaoelyther@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8800677509597923027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1216955/

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.55 seconds
CheckAllWarning               PASS      29.29 seconds
CheckSparse                   PASS      30.55 seconds
BuildKernel32                 PASS      24.23 seconds
CheckKernelLLVM               PASS      26.12 seconds
TestRunnerSetup               PASS      554.79 seconds
IncrementalBuild              PASS      23.44 seconds



https://github.com/bluez/bluetooth-next/pull/1164

---
Regards,
Linux Bluetooth


--===============8800677509597923027==--
