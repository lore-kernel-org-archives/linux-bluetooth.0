Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589813;
	b=4iupPAg/JEA1Dak6L8Gxf9eVQElP1AfLeYgoEe5345aKgF3eP/79Qba5dx2ztheQuOeg
	 TZGNQzSNWU5KeYnVQ6T/4c+4qFj6s600ujPxFTO5mtRHRgLdzaX4LzioBWYll60WRO4Kk
	 7nTpwzBZZKkXEhbfCfh4HWdAjcgK3mg1RJU1X9jrfP5cxgFi9Q+8OfeiXUk/bP2gR6LjN
	 9hu7/VjmEGysk7fZCcQP9I1QbeRZxtB20zdRjjbcayzQgtV5fts7SovsnbXFRm/SuhS1E
	 PY44msEFjEKbimXxHC6cApCydXpwb8ZcgtTMnIbUYPbjYBLcWhc/zrNghqhAg36VJ4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ItH3HVjD0WaEYhHq/AEHfSoL6+p94Xem1sdPbVjieSw=;
	b=FTyG3jdqNhoUutSdrbWTVqV22YEhAAfQy5N5jRoL3TUiwGiPcJIkt94nMP3/itzGzrfx
	 bChUcWolRXcta7LP7as7VMyz6f10yeJ4jzVp7o3caZiSl858If0DkPmaXbtEgiyjMpgFG
	 X08xU4gMQy8UitkdCTtt9srAUfPSKYlaNOwuvbm6WwwkfouTN6TTwSITfmzzAtGpZjjqT
	 24fzLxCD7RyoO/WGYGWxrNNB4lmYiX3Atfh0T/FFwpuXLJZRP7SsuXF/9xIEwB9PuOmAp
	 J6wcG5XjmCf8jLGVM8sFOBDFXvPj9RkASwYmN4C3xwTdauEXlmsyjPGsG2knqbA4KpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlh0ixOx;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0882606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0882606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlh0ixOx
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36e795af1d4so847665eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794589812; x=1795194612; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ItH3HVjD0WaEYhHq/AEHfSoL6+p94Xem1sdPbVjieSw=;
        b=hlh0ixOx7eFsNueaP9vrR48/zv1au3OqqKaVIjCq5zyYOby5P2BkS6Hk7pfydp1yhk
         3Z6skFIfwstRH5uzoLZDqwayQ9joLjYxjiJeaojuePfl8ZM1Vd5oki9ZHKfOij3EU1l1
         d6IODfiEWUga2Nu0GTftM1UkQS1QTT2oN1r0dlfQqFj1QdyaaK4GGruRYtOv4zLIHxIt
         L9sezXKgx3U4qPUT1SOiUxhgWMdhtsIYdR8h+FCf02dc2XdAK2c/zrSgjBRVmoYYF6O7
         1+7Kk0NRgh474jhQaYtz6St/2o1mWkl/MeHNurIJlcs7vfpjtiMXh20s8QOHF7IryCX/
         RTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589812; x=1795194612;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ItH3HVjD0WaEYhHq/AEHfSoL6+p94Xem1sdPbVjieSw=;
        b=pYPd92unqkWQXs+SmwJM141AxsXWj7/wIICj8QhRseC35rsgZl97YmwRfNoaF2PJFi
         NSOUrqC2jVfdvqm6M0TvTq/YneieZLqocQwh+ogOuAr/tk/7RXpQ42fh3bVxm7YjMQ/l
         ICyr0Ir/LH0D0C5ORmrhLqRjThmTxCVC/SI92WugHCxK+r3Vxm69+m672k8qc7/lwZYT
         FVM2fLchGAk0jU1qKecBffjuRyGeiYJmk6nWATIwifwwcdOFRoh2yJJZ004wgZ8T38UC
         7gPk/dNU/+1AZSlpywcEG5oOD0sNL2P4qdhV0y6Enz/AzqfiRlqxRcY5TzTXl2huuixb
         2KQg==
X-Gm-Message-State: APuU4Z8FQOwt2yHQQskJKRNfTssf7ouRB5G6YcvwugTfa+OzlyGyrNXL
	TUGwGaBcKw6pLiXftZy3ESfHWxhkW/hE3/xIHhHbt1ozrsxsez6m5+BpMbl8eQ==
X-Gm-Gg: AYBFou0DvWjcK7NM3PsURSmdWl16CWDa2Rp8Ksv7cgUhSmvMspL4waxsTywYzToV3hL
	3AkWxx414Hzu58YpuD1h0YYkjx1xz8RKleAUQvcTrQ8XXo5NmxAokrYQSLNYmcH4IJcpDs9zRRn
	gD2g6eEtlU7abFe/UMdYu+xhyMUUfGarELSNIU94H0BabLi+CV6yjejHQL6dg5BZuCYgXTPhtwP
	Bei4xlfjgqNi8pzKwM4d5Gujw7tpoBTelnE5LIbIxLScoW3jIYspP7tWbIkrIS1hvb7IclUbgAm
	kEFf0SNYHbM+LfzbY4/Pb4WWfIw0AR8fW1MhT14lMdFYNzB121v5RcNbyLW8DFCiqYAS2sUyXMj
	7neUADBUppJT8KZN2TEN0mO28jXUiT19JjGCY43nnLwbnTUGdM/rnBhyqbJC0YKyCcEVRFma/nb
	0VKq/N4syE+xGHSqqEjF5JifAvtatQ7VMcamqetjgJBjkPqlRGY6lWiuvOZGiSNTzGowS4V+m0U
	ktM8xBJO7bxGWsNkIxavj/f9KCMGc612d0EJaptL/nYQfohQKyN34z2/eIN1oEa
X-Received: by 2002:a05:7301:1887:b0:36d:6a77:960a with SMTP id 5a478bee46e88-37963564b9fmr2466285eec.1.1794589811509;
        Fri, 13 Nov 2026 09:10:11 -0800 (PST)
Received: from [172.17.0.2] ([172.182.202.201])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f02ff0sm8417478eec.16.2026.11.13.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:10:10 -0800 (PST)
Message-ID: <6af74472.be2e0958.1f432b.de3d@mx.google.com>
Date: Fri, 13 Nov 2026 09:10:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1775954714874513556=="
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
Subject: RE: [v11,1/2] Bluetooth: L2CAP: Restrict LE credits to connected CoCs
In-Reply-To: <4278a9caf4dc8e949092452c141a5be465ec77e1.1794550328.git.github.filter194@slmail.me>
References: <4278a9caf4dc8e949092452c141a5be465ec77e1.1794550328.git.github.filter194@slmail.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1775954714874513556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1210580/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.65 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      30.81 seconds
CheckAllWarning               PASS      34.66 seconds
CheckSparse                   PASS      37.43 seconds
BuildKernel32                 PASS      30.52 seconds
CheckKernelLLVM               PASS      34.69 seconds
TestRunnerSetup               PASS      752.68 seconds
TestRunner_l2cap-tester       PASS      14.88 seconds
IncrementalBuild              PASS      28.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v11,1/2] Bluetooth: L2CAP: Restrict LE credits to connected CoCs
WARNING: Non-standard signature: Assisted-by:
#89: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#89: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14980058.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1127

---
Regards,
Linux Bluetooth


--===============1775954714874513556==--
