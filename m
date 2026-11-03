Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724448;
	b=cr8qMAf/qWAi2va7/q+YmPzDVlQrv4QGCOZJg4Wg4iGiuk5ObzwKungnpdYoAtAsu3LE
	 8ko6ugAnOkRnjPJabg9niJgeVsx309r96lqzjrcnNYeIS6rzFp595sGI1mOxQSpJ2bXuq
	 /mPTF9HEnZ/8+B4mxxKuvbrSL04FB48J9r5kA9Ajcum4Kusa1U7dI+G6GwHICHisog/DZ
	 uu3rJsas8WDrI01QDzJFZ2nVKY84gxk5cKZ8ZmhIIoxl+MWOOuGmp8Z9vDbEfyeypb5aE
	 5MF1wwz25x/q5E6WjGFQ2ppEpgqk2+Z0eXzqUdpMOUZvW9EQkzE2j7mOptLkgjSXLJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=+vysQMZ7+4XrW8rBJgnzMoOiMZCI5Qp1JVNA/mVkjCk=;
	b=A1x5RIiHO25zIMtafzvHdDStJg/Rk3ZzRY9D0C6LZ9zxry2ezqqKXyh1YYMiNbmdkznS
	 4hbaoagSEW9F2mdYXr3iW7TxROSQcSC2B8jAc75WxCUk4LrJbu6QIbbfQm/GD4YSNhork
	 R4xh6daj7uRTtqLAzRqJqbsuK2KbOboqST6YjZt9kjSgl3y5YoESy6zU6vi4m1u7YPRPF
	 ybPUUVila8bWLB2JEbekBEp0u6o50vvFQmmaafHwwbexVEUdY+m6mfF6F+UuISYs58int
	 ydbTqGoEzbVOGPyHmcPPPj7DZuLOp4ibv6ja2fTJzZYkLspQz7H7v+AgyFlP/PRrUOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P/2o5we9";
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B81606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 16:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6B81606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P/2o5we9
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53644b28706so67102541cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 08:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793724447; x=1794329247; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+vysQMZ7+4XrW8rBJgnzMoOiMZCI5Qp1JVNA/mVkjCk=;
        b=P/2o5we9mqtvblYHbiE+YEzGJf943ykufjtGmEu9IdN7Azzl2e7MlhUyNQChwlt8rg
         tKawmYWKXzRZD3VCjU1mnhSGpkHSIx3KC/OhjdAE1fb9KmohrkiNPSiZi+zBqRoJ6ArK
         xiReTzV5ML+GcRpj/D/w5nuJB+5bVZr1oBzDNF4kgJfz7kmoarrnZmg8FC5OIRXqJ8Wi
         Ht5Dgs4YETHQHIAIanL3NElYwbT1Qth96OjZB8xn268VFTVxd9XcuiOhJGB4QuOVuIwU
         8kfrcviDo2HpPDev8ti3zTxAtLr611VJIx+dpVrU94tLw5djmUqVWfuUn6Wl21OyLfq2
         xO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793724447; x=1794329247;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+vysQMZ7+4XrW8rBJgnzMoOiMZCI5Qp1JVNA/mVkjCk=;
        b=PfUbDVPilN/veT3RFgQgIG7+XJWa7K5NdFeuSU3QVNLIx7Pdm5iEV57Iin9abTQYJf
         GFu0udN51cyG1M98pVFqR2uKsWw6fo6Tt/L0Jtz60JF2Z5tQb/i7a0+MOyZj/OGVmkFq
         kE+GTaG5jMb9WPbtUVhbTt925w55qFYd+SJcAK5JbXD503BP3nprvHw8MoG9/hCnz4cs
         jZBxyddqr/2eUlHyLn881BnfkC0+ik/3vnWmsGhXexlLURp4rvhlHPiVoJTJQ4vI0WDd
         fPjDpITVqYLHmUid8/OEmYrhnv0pCNAKRGZgwxSMP0vCuzXHG7NbqgV3d0fGWssntrYQ
         p2Fw==
X-Gm-Message-State: APuU4Z+p068WIKG/z3uxSDhJGLyEUvHlQT2SkRMEXuR0KqFq3qvN/BBT
	KBx7s9LrgVIF3DF9PhNdJIn6VGg1aRX95BM39d4dJDd9T4M4y8rd1FuikkI6UqvI
X-Gm-Gg: AYBFou21eMCpsPGet7LvYV6v/B9+ipUtF8HDNvFKoE1xLGrBHPlVieJvIRJPt9rXdR8
	dxLiETlY2YoOKewYtqYqMBFOUdFwCegBxQfRZJ0z1FwBsh3xXW8bqNDlkuQ4EYIkRbtE53WRJhr
	DE4Y68mZmKbLKO8P++xvdzNsLtM4//hcRUtCGCPicBBI/jBSH3nGbgPbb9ZvyDZ5DhjZWJEAqoJ
	mFGkATVNvZLF2bCJHBFWVgdw1ZdnQt05RDMge0ecLlGoZoTycsKZwBcG1yxvrYz26HUeSAx7rIy
	TR8D+0L6k/TgwNpNGjMvEOklfFecKUDdiydg1nmG1Z5tA6xnmSv/8lIqwTrXz7qQNea2L1C9kDG
	vU6s9Yjqr+ghZUP2B844zjRcSghDjNxF7BOon5sfLoXSwQcgKVVvhMwlWLF89f5j0tsA/1Z4nv/
	GLkGC1LLRqReMA07I4hnMg6qaPgSAVEWQcUrKMt65Cz69mRMYMPsJh8x0gs1U1ALSrUmxfuQXKY
	0N3K36PBsJFqYQ5O0bev37rzQy2LiVAeUX0H3+biH627slZQAkaX5Ksvd8AcQk=
X-Received: by 2002:a05:622a:2445:b0:536:6c22:e346 with SMTP id d75a77b69052e-542b7ef7ee4mr227561571cf.68.1793724446795;
        Tue, 03 Nov 2026 08:47:26 -0800 (PST)
Received: from [172.17.0.2] ([20.97.198.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a7ab83sm364271cf.13.2026.11.03.08.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:47:25 -0800 (PST)
Message-ID: <6aea101d.17e05534.3c03c.7a32@mx.google.com>
Date: Tue, 03 Nov 2026 08:47:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4349920917600987781=="
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
To: linux-bluetooth@vger.kernel.org, valorcool@gmail.com
Subject: RE: Bluetooth: qca: Disable SoC debug logging for WCN3950
In-Reply-To: <20261103103414.803861-1-valorcool@gmail.com>
References: <20261103103414.803861-1-valorcool@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4349920917600987781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1200170/

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
VerifyFixes                   PASS      0.42 seconds
VerifySignedoff               PASS      0.22 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.59 seconds
CheckAllWarning               PASS      33.24 seconds
CheckSparse                   PASS      36.18 seconds
BuildKernel32                 PASS      29.45 seconds
CheckKernelLLVM               PASS      30.44 seconds
TestRunnerSetup               PASS      693.06 seconds
IncrementalBuild              PASS      27.28 seconds



https://github.com/bluez/bluetooth-next/pull/1051

---
Regards,
Linux Bluetooth


--===============4349920917600987781==--
