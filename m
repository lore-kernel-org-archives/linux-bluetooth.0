Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A5486E78
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726116; cv=none; b=dWTjG306QlW3taOV/EGEdtOtPuvicHhS/1kaa5SZgtXgav8Xnc2zCZTC0IJKuhGE0+GqLrRhC85gqwfDyAL0fSlHwFlsIkNrwtMw1WNYYf8EVf+muiO8/vkpNZHvGjqyR/+M9/6kuWUeOuh+gzqdAkfQ6ygS4qzc1ccsiO1wGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726116; c=relaxed/simple;
	bh=RtZVNlcODPfXCjsE5MM2A9CPAzGn/26j4puFJGkylAk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ac8jNQ2OgrkgpxLMwdNGkNuTE3e8UXRsUpbcMStbL0Ga9mEuNLDzJE3ZaMzyEcInAADy5EER/GR2T4ULE4rN3BWGWSUjHDLfFQVcD0xqyfA12b6RvbMEWGTk33osimOikZKABjBOTYazr/P2lHwmZvqDwMtJlhuIcN/VHaSy/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/lzKEPq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/lzKEPq"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso406934a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 03:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789726114; x=1790330914; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RtZVNlcODPfXCjsE5MM2A9CPAzGn/26j4puFJGkylAk=;
        b=f/lzKEPqRAU0IxiY6KfNDTKdFFcK4MIpPbOxRsAtoQy5RdrOaQA9pz1snc4s6ST2W2
         uaTulDejPc4UYbucweFCTI84q6p8DcFiimS+xAmwjpuwWQ397WEeyJf+QQXpvihZuf5X
         KMcfPi8BDbRxdDv0zBa3W0+tzgkU5dPNKeGNiCLo+0rBEdvUwTt4gD5CrCsO97pfpu9q
         VIv0AbT/F95P1BTFkvR85LsCsOnox9bRt0zI5Hlkp9AF4kxeBPACsnfWd2HRlDdkO29f
         uHuLdPGfsVdet8a2Q1LAnPhlCpl338WA/cLQ010L6+YF1WsEc2XbtlZrcgNbByZT/pAS
         a6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789726114; x=1790330914;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RtZVNlcODPfXCjsE5MM2A9CPAzGn/26j4puFJGkylAk=;
        b=LXp8eS1wkuxg1wa4UH13Pgp+TrVoEWYvhcOHUYVEhXKjVK1FuZY5E6P7EHNp5bcc+a
         CO163Nw/wveo1ZItyS22xX0q2G4uDWf7RIvVf2l0bLyYWvaic5uSDEeL2d6MQfQFv1Rx
         WACZGwmKiPgQptMfkR+iMbiNnK5/iyMrorJvjjl5i6M6RKPdXmSl4VbTM7G3PcXDwZFz
         a/3SuYmmLBvKOVY1UgWWbn94r5Luuq2wmTwpAKgRZPgI5lMcLYRk8TYnqhCHZsErqtQ4
         hYbkTN6RLOY6fKc059+QgNDP4mR+L+6RC7iQWzChXEDt4hYo/ExvfG+Vx0qoRKEyS3hX
         nuoA==
X-Gm-Message-State: AFuF++k6lNVmJSEpLNjIk77kJ1mwkP0S6kMJ7vHK8zKuy6BOjLyS0nzI
	IC59H9FhOC3LK6xgGUmy7tStp5aCt1089Fka3NUS0a3LMAwy2OtqUxLytilACg==
X-Gm-Gg: AYBFou2Fe/BGNtmauqArOnXk7wBbHdtr1n72hnX96S31vsZCzsqtal996HbZJWogLSM
	wWYubfIgBvIKbgI/HD0QhB5rp2VQyrVOjCgbG1VtBLld0TWkwSrkGj/G5bbJELjoBofIlN9N4G0
	eaQNQaW2VagH63gzzmZn+L9AXuYWjG4Ep+cIorOQM6ht4+wT+UUbYUXaDFsttKq/igyKSdWCnfU
	UIqC9/JHIgPLIwyqdFMbJz4Xjd01FgUqZiEs3t8L05+NU+p3IVg1nI8L69ITjcEHLDw++qQDWxf
	EGCVVvJf+Y29t6rUS4uLkYZ/izw+RVQk0S/IdsQyDw4YCsrSWdE81RUHXjzI7hq2pV0Pbw9I/FV
	Hwbax294O80g1MX4pFe1WB/LrAiFzf2vJLjW/NNjTygwQ9ketI3weis4CrFMfDB8NyMvMx2A3pF
	BzbhPfvko5u5DFjkUT1Wke+tkueWDEe6SBzvCfcP0EOzu76DgKWKJ50oeaVHJ1DfU6NCRRFCm+z
	oQ8j0U=
X-Received: by 2002:a17:90b:4ac7:b0:39e:252:ae4d with SMTP id 98e67ed59e1d1-39e54f9d387mr4167325a91.17.1789726114111;
        Fri, 18 Sep 2026 03:08:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.254.73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144cddb4cf8sm3396214c88.1.2026.09.18.03.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 03:08:33 -0700 (PDT)
Message-ID: <6aad0da1.54e42a5c.d3cd8.f66d@mx.google.com>
Date: Fri, 18 Sep 2026 03:08:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3975231854418124508=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v3] Bluetooth: btintel: read ROM debug registers on FW download failure
In-Reply-To: <20260918084457.2746999-1-ravindra@intel.com>
References: <20260918084457.2746999-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3975231854418124508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel.c:2251
error: drivers/bluetooth/btintel.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3975231854418124508==--
