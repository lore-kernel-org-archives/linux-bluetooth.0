Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163924;
	b=coBiEXHhK8xS1Mtp+2h13/lq8GczKPHXCSDsxJJ++5ZSRAITkJjNXBKrxMAh5IIPinub
	 nwWyrDvu7/F8bq+/FD10XVT68/30FU1z3A/dFOEPKCsnSCSMWtn0M7fsX8K2/KAElBEDJ
	 72LvgGw0nMzwRZLbl9GHyNCLgEU8MbCgeFcUdWPkzHgxIuhH+fUgOLGi9A1KgjZDumIKJ
	 SOOvqOBRnxkX5IWuNfGg+za50uGKBnG9451OxbY0Q0HTWDAiFo8KziufPbakaEfRUJ7N/
	 1+mlr2XJYen3BD92OtVdms2g3sqfSPstAYR/xO9xof7d4OMRZdiDMS+5EfUDw6WU7uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=l576yHfUaS0LQMYilY+EoGgrkBDtV8YuhMauxdCzceI=;
	b=sezuI7U5AOplasw6C5DInkKGWfLKcGLjWIGG6G/PS0a/thrTJWXoMXNlGOs9TDEn5Akw
	 1a2XyyGuoxeGhAYHUhtbzGkPPOsqxMLa692IzZSzRW0w06RhF/CCxuH7MurPjwCaInGbG
	 JFebuqpdmSAxMRb8PJuLcnQiGRHu1d+xZc3I5NNaDH3PSM7BRHJX8/x6KzDb4noQugu3o
	 NQej9fmpD6//ehMVDmnrj7v3BYVHDmRwueqg+MaYv2VilmAIezniQUcDtsM2Y1xQfHN5A
	 /OljIBjKDm6pNdJ7akOMNY14LDssgE/RjDb0yFYYme0Euaa+wUseTCAc2rL3fT8DlMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ao9E4HbE;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD8606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 05:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1FD8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ao9E4HbE
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6deb848ddd7so510768eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 22:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793163923; x=1793768723; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l576yHfUaS0LQMYilY+EoGgrkBDtV8YuhMauxdCzceI=;
        b=ao9E4HbEKq7/1KwwPGdCCLMClDjavWVfAxnfpii3juxvckYLPayyQnusAmMTLcsd3K
         +b3gHpOOuZP6HRvDmsK647LnEXaZ2hnfjGCljVW68erz4Q+rDNy7U831Kky9sXa/n54J
         Ghs3QX61/29G9fYslLcnpakZCOEpOfvd88D3UZS3LDPdj9UwiAdhdQhBw0tMP/dIlQdD
         031aTasc1eVyZTGL2jqukb8bI8iEIuiFTiYTuE/637hC5Bi/7scIUe5b7kLP/Zf6fywZ
         amacuOqaHauRBgHZtzHFuDzkxe6+J8K8KmYoJGsAXAg4sadvE9octZFBTWW9nLvoe3l6
         Vcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793163923; x=1793768723;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l576yHfUaS0LQMYilY+EoGgrkBDtV8YuhMauxdCzceI=;
        b=soNw8+SCxYIFflhb5KnHekfhFBAhjm4Heya4pZLlwF0/yhrqJubdUfzb0APGTJy7iA
         cD/T+qc9JqaUrjnAL/HmFtVGsqsOayB+7hRQeGWodxI0E0ZPHfcFqMaSkSBEKJmXPFp/
         irE1uZoAoLAE48J0ZwRgkNj0V7Gnu6liJz5IuCpdx1byZxzfAK8OAx/zbSSKaoYgRU5u
         WeZ2exsLg5cbv2E6okwmNjKUkqYzAi07+eihZvfPKry8WaomojHXJaqPyeTmOBDXdqtP
         ssx602GOufFIJ/ovOLK6M5vpINiq5lvZ5q/iJ3p0pwRZmT3OGFHiJFj/l7IYFn+92Ig2
         tiag==
X-Gm-Message-State: AFq9FYIODpe76Ct7cNfzGxTeGULrpxDVE5TbNkiA+iklGeIb9zJ8zcwW
	Nh3iyzglyXqWxcZSUyEttfTxrUW1RbNq9Blgy8+BeLmPJ00Sz/HDz4Ps97eE/g==
X-Gm-Gg: AYBFou2kHvhn9xDVLkXkChDp5CG/MKdSnGDuiwsuMeKqFtW8LMDlPg5HR2zSr+3sJex
	6MF6rjBaahBeIgS/G2qgBB+yI7I6tWste07rA1w43liVYnv9dayVEemzdY4YpifZuTE+o1Esvfx
	yPYhbK40FJD2lsT83qXAwMgnyFa73HbHarjCX5dUXtl7d97XkCpFCPhukBa7N9N96FOy7c4UA2E
	pN89Rky89NiKqT7cuL3soiJd2HRJtvnMm9Gu/icabNBvqGBw9P9D6/hoqx9BbqClciE91zT4y4i
	QtbIBKG+ks6GRYeyMhGiDPO+QdWXAHqNn+QSw3pd0XL2gJqzGInJvTKacodmvaZcdZjClMKEt9a
	2/o+pE7OL/0tVzfpOFJUMUK3O9ZDssYnNBWpYkNjcaiYHZEtxSWDuODyPvKX0fq8W3cp2+B9KtY
	6sfr9hQEev2ApkyzEY152dRFVkXv2Vxwrh4dgXwn6C3Uk9wFGGg5cM3kMEgWYLe4rFthJ7RUv+y
	TipyGUqQ3U32F2KptAuNy7n3TDxZsY9MLUD6dgVL6JiRf5kGxss3ABSyKgJ2rf1O865W1aVY2o8
	p8mMuJbl3g==
X-Received: by 2002:a05:6820:55c8:20b0:6f6:1e3a:6fc with SMTP id 006d021491bc7-713f04d6e13mr488056eaf.79.1793163922875;
        Tue, 27 Oct 2026 22:05:22 -0700 (PDT)
Received: from [172.17.0.2] ([40.124.29.227])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71429d864c9sm563720eaf.2.2026.10.27.22.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:05:22 -0700 (PDT)
Message-ID: <6ae18292.446579d6.309172.0d3f@mx.google.com>
Date: Tue, 27 Oct 2026 22:05:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4148134163086586725=="
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
To: linux-bluetooth@vger.kernel.org, bsdhenrymartin@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: fix memory leak from repeated configuration of a connected ERTM channel
In-Reply-To: <20261028030107.2213982-1-bsdhenrymartin@gmail.com>
References: <20261028030107.2213982-1-bsdhenrymartin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4148134163086586725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195059/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      18.57 seconds
CheckAllWarning               PASS      21.91 seconds
CheckSparse                   PASS      24.23 seconds
BuildKernel32                 PASS      19.93 seconds
CheckKernelLLVM               PASS      21.51 seconds
TestRunnerSetup               PASS      435.33 seconds
TestRunner_l2cap-tester       PASS      12.79 seconds
IncrementalBuild              PASS      18.12 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: L2CAP: fix memory leak from repeated configuration of a connected ERTM channel

1: T1 Title exceeds max length (94>80): "[v2] Bluetooth: L2CAP: fix memory leak from repeated configuration of a connected ERTM channel"


https://github.com/bluez/bluetooth-next/pull/1013

---
Regards,
Linux Bluetooth


--===============4148134163086586725==--
