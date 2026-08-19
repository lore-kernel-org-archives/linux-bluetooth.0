Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087B3793B6
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122877; cv=none; b=NgLlsVSjSKS+2X2i2Mr9+Z+4uhB+clLRDC3RRG6tjXtxxfbISJJB9u4fqG++NY3CJeY9PuPHRzJ1f0w9KNje0KQumRHrb0CaUWNT09/O4ql2CAqfvLWnzxpGerS6hU6SZUc8S+irHKJ/9ibDFKq2nOjbgrI0j8TNGFX9pVNmNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122877; c=relaxed/simple;
	bh=0N19gBt9TtzGJofvKcyyVZxzGtQ/jKh5kVoHxMIfmvs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j3kMy2MyXA5IS7CToHKL0HeiREskynJCh4kEHOeCZy4R5nDs7eKn4nrh7xAE0MUav1tRZ9D3iZzvkviuF2dG7aBNyAq8edmrAhlSutYC9Ttlzt+Wk6JTT9zf0A2hwU6s2eNsmEkMEMjAFvCC4nXIRCK+V3xwkjnHgNc1HWdpF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVHOch8a; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVHOch8a"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caed617615so7250415ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787122875; x=1787727675; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7TCL+NOw+vXWHTb2cwAUhKGpT9Fi4FRzP0ACiQyDKzU=;
        b=TVHOch8aRkbUMQeQMCfLWEVxPeHKcoXzX1Zb1LZPpynbEjM3f7iL8xWBKBXGCWD69+
         rEWd3cxJiaWFzbCZrNM1YPAbSBftDc/ZMy9wu31EC/x8KEfPFYXuGbz2dNFnG/h+RvLO
         qgGhziqIqMssShay1PhKW6exq7/t1kh/GJCCsuDQtn6AxDu7g/loyzlEdaNzNeNQvQWf
         k/7YXl2pEA0RHcA60gQLg/ssRc+SrIL3VMvH2M4amglx/CJyqF7Qb1nx8/oQvJu+sJmv
         n8U3QldtykmYgEhRaAp0YPE+Ie4pPl4NT3n4fwx8Z8dAQX16Rg67LC/mz0QhbLds8Uz8
         MOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787122875; x=1787727675;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7TCL+NOw+vXWHTb2cwAUhKGpT9Fi4FRzP0ACiQyDKzU=;
        b=PE0hXVjCWx3Kk1HWNo+IAUrDI0348qBXgs4vRPyLRHrewsCFo4la0W0bAHgqCnQw77
         jnmAj7jXWc6MNhu92Ubo9bRU1oXOLubCmOfn9mlW51lAFx58RNBAYnKQjvCBajtb99jD
         ED5+lWPym8qzmTYazHfe3SbapOp/GTCGp0BfVDDy2hvcYGTTkAmQoKnT9i+cHE4o7MO9
         yaVAfLyZy8hJXxB/uUmii5IeARo0jPjzLzNtwfWpJZXMv48+rUnAWNr3SzVjj6w9/QHR
         mdfD00D8kcggUPkSjvjn5GGaL8lhna9SZ+XzjVBNG0I3rNUQy6/Bbb3Za8pcTevBkfDX
         g7Qw==
X-Gm-Message-State: AOJu0Yz8pTHmTE2lnp9yMEZ1/LY+M5I+pRySGAHjhbyHudcZz4C9WRfD
	aG7dxsswqimr5A/k+oSjPErMAyOp00JKoacqYKiAolfyd9tU0gPyC0Qi1SH5drnQ
X-Gm-Gg: AR+sD11iHoYC5AmQRMisBdT20/M/p4Uenh4pZCxhFFfZC4JU+R3I7DlzehTAgJ7KuvZ
	uPlQCgx1DtjzBzsGw9rM3dabzUSWKGkqT1dHAFsvKsTHlsvteLbl3yWQBXrL2EoJafye7AvIfY/
	qzXxmxnGqg2JD0fsB9YDJi4EcWWs1rnUVXFbYSc6ADYW6D6RM0exBiK5mlS7GJ7JSpEp1KOQh3N
	GZKReWl54sKOj4V3OilliDqaddrshpietqHTlhGdIyoTDKVwCTznZOhW214d3AUaLYHVV1Pgi/u
	DB+k6VjACRrV4mdJEq3vWC8xns+oms09p/IBeQbE8GM4KgtFFntbjImVhhNwDwfyK9EciT07vt/
	nmEUV9qx3MzkYFyIUgg6h16HO8tzTcyiGd6rukC0e7fcZDa/R1HHAtgx7Nty1OS/f7nS+Mm27Wp
	fZ2NQ4e8rJ8fh/rwxXRpoiH8aU+4gTNPHYJgVSHP21osLo16fnuPTerncZChPUZaM7ncyi
X-Received: by 2002:a17:903:b4e:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2d601863883mr46966655ad.13.1787122875354;
        Wed, 19 Aug 2026 00:01:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.189.187.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3993dsm3440850eec.5.2026.08.19.00.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:01:13 -0700 (PDT)
Message-ID: <6a8554b9.b1b3e0a1.22f0ed.161a@mx.google.com>
Date: Wed, 19 Aug 2026 00:01:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0176740731893081997=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lijun01@kylinos.cn
Subject: RE: [v2] bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
In-Reply-To: <20260819062334.2410737-1-lijun01@kylinos.cn>
References: <20260819062334.2410737-1-lijun01@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0176740731893081997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148228

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 FAIL      7.84 seconds
BuildKernel                   PASS      27.53 seconds
CheckAllWarning               PASS      29.91 seconds
CheckSparse                   PASS      28.75 seconds
BuildKernel32                 PASS      26.36 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      500.74 seconds
IncrementalBuild              PASS      26.07 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/613

---
Regards,
Linux Bluetooth


--===============0176740731893081997==--
