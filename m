Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE238F938
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650346; cv=none; b=m2hXmgn/jhDzsqK59ADCcGxZtdn7ae1ssqE4jvrNkCPKAFrLsX9lbBorMtopdVg6JxYiGPg88Wllo6rDYWUFY0516Ncqh/LzgCeOowfRv//oCTLeKW3EkPUKb1HjZg+xwiBG2DcaYC0OaALzhEWeXAjvVPNzvkKo0V2qEzJUlXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650346; c=relaxed/simple;
	bh=MFStpe9y5+2Ywjy/B3zVFvCXzNku+H2GvuoA6oqhEl8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GP1GZ12qJxpazWQ3O4/beIQoRZbk13YCu53tOe/ugcJNZP8GTE9Lp4xobe+rU1h30q50wn0gr4RNSa0bGtVgeG/whsUxC0dJnuZ2CtZo1eJB4tSuAYL4QyQbJX1psLw5oyhf34bKsmfyGPUJ6NseKDJrgS9a1TPgSFxywv9OyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh4MC0fm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh4MC0fm"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39647184c73so587421a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787650344; x=1788255144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C0i+qDqfGPoEwASiQucNQSUoAfw/o8jxk2IardA2s5Q=;
        b=nh4MC0fmP95JNKK3MmrV90MjQ8jH6exBWBxEcPCIpO1hKOMMMeD7cBlXcI4BHLTaYB
         tdbSDL+aLtLz0I2YF3FNiezsM0kT/OrnMvGvgv7OD+HDctOvQlvtPSuIPsAmGdDS3uFV
         dzMmMMJkNY8fjupUxb5WbePYHg1ExwTxqtbwPoNHgVGK8xsdSAC0JycaQ/XfFmiWIS4k
         pt2Ao56VlN0XMQ3aHWzeGd3wTm1R1/3hRCtQC0jBZmJrjUhB5ey3Ev76zlOQ/fdEsT6H
         6lXIhbuGsGTSbQtNCEtlhpUmp9/MRiZBBlqVYZnnNN+5KrI7ftaOgEgDB202NncxIc84
         8Tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650344; x=1788255144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C0i+qDqfGPoEwASiQucNQSUoAfw/o8jxk2IardA2s5Q=;
        b=UvvjMJYyI3igGUTf6nGrDY+hJxKkgs7/84FuigpQvzSNl8UULQNfZNGqCcIKR1mJ5F
         72GqxyYIwCgnN+x/vDokl3Rpe5a8Lvi9FC8J9kUaB7PssMwuT3UNfwdOX3jvAS6j+t1y
         TPfqcGyQccnCPGzH87OFzZHaRopvCDfBDbE753+VLUywsKYpUHNAAT+ElcPKZ4WM/bSn
         aINXrmu68uS2OddLiTkfR6yQCoxee/X6S9pXkbA1D+5mzmJUF01Lqb/48wL52396v1rV
         20ZHZ3tFf39UZ2WRV+EjF7z+p/FlIro9OXxe04yqhTdJP9ltowB7ZyEBjQ0hcHk2vxwO
         8bfw==
X-Gm-Message-State: AFuF++m8CCkqzZWxsUBK9eGq4ftO0+RT2mcyVKdZArcwLt5RZqK/+CEb
	fDlHxHGFAiO5kbEbMb1Hu3kUw3lJrOLefAEtLriTzK8PxklTnv51Y8Der1DsOw==
X-Gm-Gg: AR+sD13nLmONQTPz7HXco/cMlKZ/u6GEosygkuIEEe/bf1Q+YdvPmXmAM8RQDakqRUg
	DLpBTETQPt3l5Hb/KSocdXxhecYHWktzjb/4Pb8cSeZGr2+XYB56MX2fKijZNLZTvzov99mFOM0
	NZdEsmWFedgDWgPSTLl9E07Cnj+CpuUDlsIxQg5b7ardjNDB4JK5T5RoIflUIkGxlyh/4c+a8HI
	wdClERbt/C2KmeoNCxMFvQ1qMAfJ3oOhzsl20GqBvdbuVkc7klCGd94pm8kAehRXEUrRlUScHsO
	vWVNz+WM+5w3Kt4vLupnMd7FY4F/7LIKwFq+4ib0tZOoQJBNBCYYzjPeG7c0u8sRWm/2Bgpqekl
	IhK88dbgT52kUPkKlRQeJt7E2M6kzFhOo2iK58eySsDheyzMz/F3ZCpTtE/79U55sAjsL/V+1OH
	ogW+huULG8x4ZemEKSGqtPzWHkf8wE0h1l7kkJqGh+kVensMpPanwsFYGqjb+Vklzrd4Qt
X-Received: by 2002:a17:90b:3844:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-39645acc458mr6170980a91.16.1787650344490;
        Tue, 25 Aug 2026 02:32:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.193.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f8e2a730sm36902560eec.0.2026.08.25.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:32:24 -0700 (PDT)
Message-ID: <6a8d6128.510f576d.1e8f6d.88e2@mx.google.com>
Date: Tue, 25 Aug 2026 02:32:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0127866183182849129=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: Bluetooth: btmtksdio: Do not fail probe on wakeup init failure
In-Reply-To: <20260825084321.3544900-1-13875017792@163.com>
References: <20260825084321.3544900-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0127866183182849129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1151352

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      28.84 seconds
CheckAllWarning               PASS      31.20 seconds
CheckSparse                   PASS      29.27 seconds
BuildKernel32                 PASS      26.97 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      518.92 seconds
IncrementalBuild              PASS      26.89 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/651

---
Regards,
Linux Bluetooth


--===============0127866183182849129==--
