Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79745DF68
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788302190; cv=none; b=L9g2zEQq6TlXDw2lWwKwJZ8gue5DazfhP8fKtA5yYYwAjFqLmoOXjZVzc+tx08ycMKSBwSPftKfZkdw1S58Rfxm9DPR4/KmSrQYKVHlX7JZ3EgzF51KxTSrx02228CpMvisu47I9R4ScQfIGfrWm2GbqDB0UR7KDh0ecApnWMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788302190; c=relaxed/simple;
	bh=DAAOx2Md22T7IJlZ/iu+vYwpquN4IFuRn4ly9W/iHcQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gF89Exy4RczJmTXDMaEzheXyjnkO326g+A7qstGkERHUbruru81OVXlPvKk5SyW5HEunlKbhjAoG3lEUQScI0uqjwUZKkQB1zbUZyGj5E7Ux5h7ZkbEkChMAqqMeVnwER4iEeca9qjTQ1CRUrEoSFEU9pIAs3+NH68Ikoq3f7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvTxWK11; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvTxWK11"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbee846deecso535144a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788302187; x=1788906987; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yEH7AJx8bVhYuANFH78pnwGgDmwU2rVXyTMP/W5uxMg=;
        b=CvTxWK1191MUqKwY5+Qv4JC1fHPdKmJprI04Nn5ixW6Chdxk1hvg1lGf0pMzm0wGpX
         DQFh6DXpXo0pxKM4QPqNDTRrY569x5UDPNdxVLP5mzaPXctc1uPD4iYcnGZj3qFCiA4R
         9Q1j/E8jrg+mGYwZqjM6KWRXcFrUMKoYXQMO7cdldMvi5BIF6sx7hqROqomQG+Ryp1nW
         SjaemXEzTSqOT+XdUaKZgJhXvekGb6mnZsrl73OTnIoog7pR2WmZtxu0kong35gFTpRl
         yyNIuCTOz11pd+Q4fKsfx3vviFMMWM5nLeHOSYS5htduNUyxogXF8n0iSQk3w+GqZ+GQ
         +TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788302187; x=1788906987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yEH7AJx8bVhYuANFH78pnwGgDmwU2rVXyTMP/W5uxMg=;
        b=suykk6tMgfaKfia+cfPMqH0vc/23iZ/np8FRMgSfYwkuP4lM7qS8g1PQj0dh3nsYKN
         DbSgOd5sfy1Mlvx5hQiy6fshJBb6nxhft5SfN+UtESQlNSIs/GTJll8RneUZjDSvYvn8
         kHKsQ/q0JtKpH+llT7eZYBEE7WPoj7UftFtIwnbe45ZVZUuFAuCVP/ussuGLYE9qvxgD
         XFZiYSe8qkuQhCvhl++sOwej4eLAIUCMFx0qElZFeXi7qygw6haxeVwtccZ0w0QPrB6w
         lLa6AapI4tVPjbFEnRUSnJewipq4dc6W5o8pRdW7w2kI6ZeDSCETeFxDe1nmzGervJiq
         123A==
X-Gm-Message-State: AFuF++kJg93vEn6PdB+xkjstXoJaRBwAvtbjwh35V2ifP9mo+xtu8DAa
	La3WFMlXM5SzEyXL/5Tm2fTEs3wOJ9eDPY+/TKOjOU8PiiYQlhDVOEkZRLSegg==
X-Gm-Gg: AYBFou3T+yIIsmQB6dUVxBHIhzYEydgcgdnu9duN3qYqpuS4kt5wuHRyeJn54p6srPT
	K9Hj9i7dB1pBQCk0BPfyWDD8tEgrzA38MLmuvtIecrQTchdC1PJiTBeTj+TXyYDM/eY8nbnr9r/
	CI/6K71mOaLvqWK5Gz3dCIzgYt5fAfyeNI30aaCQGD4hr0o+UFir1aelIbKl4vqp+U/fFk9ykK2
	9LvKYfBDnEbKvS+RwhMIdpz5+bF3LmcSjDp2b6KS2Y8Ygyh9+3s6aOqYboEVELh56n7bHblYPWn
	JQ4NeP/dStyK6aBm2gyhnFTImb1xsz+NuaKC/Opc5xjT8Otdayo7AbQ8NoH/hvZ0zcATS6HOeVa
	ZSThRey8fgki7Ev6Ur0tK48AVQ0pegEFA0bjIJbtteISnxvXgjK6q3GyplDcEN8+FFLP2DTvdap
	20JbSX6rC0z/SnWKn8BXQYLU8w+fbjnHkAefCTCPqN3Byp9Q+a9Qvggb6P8XhJqLEpZXGEQWYql
	uRXBxY8dA==
X-Received: by 2002:a17:90a:d887:b0:398:e1f4:bda1 with SMTP id 98e67ed59e1d1-39aee260bb4mr247944a91.21.1788302186790;
        Tue, 01 Sep 2026 15:36:26 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.219.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079bd68asm1079360eec.2.2026.09.01.15.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:36:26 -0700 (PDT)
Message-ID: <6a97536a.a865c849.a45c7.09e3@mx.google.com>
Date: Tue, 01 Sep 2026 15:36:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5621543435651247220=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vladimirkondratyev2@gmail.com
Subject: RE: Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
In-Reply-To: <20260901203818.112189-2-vladimirkondratyev2@gmail.com>
References: <20260901203818.112189-2-vladimirkondratyev2@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5621543435651247220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1155660

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.84 seconds
CheckAllWarning               PASS      28.20 seconds
CheckSparse                   PASS      27.63 seconds
BuildKernel32                 PASS      24.69 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      457.25 seconds
IncrementalBuild              PASS      23.96 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/683

---
Regards,
Linux Bluetooth


--===============5621543435651247220==--
