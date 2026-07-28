Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1340A953
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280861; cv=none; b=IJJ7Jd8V9FWtSK2HODC/LKIpRY8OjF1aQzXy8qNuQlr7YRd2Xf60gZn8/dYNXJOVOOmD1bGIo0NuJMWa/f282rc4yMulerhem1Sl48u2M/SY4gYAwhJiEikdYP2oFoNrfKQz6pWjK8jrv3pUSXH32GOEkgqXAH5cd40NHHZJrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280861; c=relaxed/simple;
	bh=ODAPbLv3Fef4h1TRG8NhRGHTXpYCtz+NApigEuvstNs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GdS22nd9c62sOHp+I0OOIjmWW/SzqOuCPZiNJ7dXiBjAy/HPAGqzhM3adDUvb5/IejQJ5OKTQS5E5p+EAyRi4Y6fH2+UfTV4F/otlLCme+0hbN166y6FCdY1wH5GihImYIvvAVgNba5Tpp+6gPeqIypU/vlJ+reY3ev8i9fwEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3lPMFzA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3lPMFzA"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c15bf5000so2041301cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785280859; x=1785885659; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tq4LvkhDyUYDMcm3CsQwDAlWv76Yp4qi4S2UeIUJDho=;
        b=c3lPMFzAFyNhoA/9K7EvrYrgM6pXYYxGmON85GnXG31OC0VzXfb/lX20KzbhACn16B
         svvk0M3S8/BTE+LQkK3Sytq/v0RQiPVL8+gGCrJ2GzSkb/GUEkZfDhg7f5EtUwN11bLx
         qJVCsjbobbBkKaEnc5MD1Sw+rf+yFzSmUvlkQAijHRjkNctp5n16aYSQhhVUTuN0h5BH
         SuXZBQa/mKVTOYrp0Cl9koxUsipGnasi8DxWkejCOFUDIGJ2ZiwCa8tJ6DcUiQES35S7
         Ik2hFo9vwURuD04nyhIM3mvoQPUT/+Kr1fjrY0jSuFWU1Bby3g17krmZCcriK/468Ujk
         frXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785280859; x=1785885659;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tq4LvkhDyUYDMcm3CsQwDAlWv76Yp4qi4S2UeIUJDho=;
        b=mnM9cj5Sq0Sdg+wIQAR+pfBDa/bW3CQQ8bWyg1Kdt/M16n+r/XzwktI6eE7i0qECa9
         CsaLwK3z9bpmSSerstUVKeiuwMIxmGXILQPMHjYkBiienl6XrBnIr3/4N5UP44BfGfxo
         Z69NI2tBXbfQ09PKQ5p0jdOKU9DLqCh9EQfPsHuQW1F2jNggJzOCPbhKSzu+0GMoOn+P
         aUII7+pMH0GEcijx7xADQoe2f3oWPD948BDIKbILNnEkYzG9Zy1sRmHx8urusdnUOOat
         H+56IxEVo7TZWyQNiYVqCaj6702Mxcm+vyBdkEgLGnRs0V8n9ySokv2QIrtEK57z+IIi
         VkdQ==
X-Gm-Message-State: AOJu0YwHVfamRqovw4GyNDk5AQJS7/AG7Gnk1e4EavVH/1h78eQEcu79
	2T+551GJfgoLnfFNJo688vtAn4nxR86dMa+LtToJWbYCpA13cffSKkQ5eCDdXw==
X-Gm-Gg: AR+sD12X0CWwvGjAL2ihhgjn1eqc0JKu9kIlMSfEW7OWHr/j1YnigqcrpuCHD7YaQw4
	9dXXZCWL0K7WLPvnUCsoTm2KA6673ODJb16Q0XTfGPTIvqhG/JbIz3w5HzZvz5Ddh+fl5ZXoKc2
	P7g7P8sxa7pmVq/S+fdgg74KRUdFLc8Km4SHm0ToFrnmIXHmvEprdqzcU54U/hQABtkGmD4BCdq
	iukmGRjvl3del3UD/f/xygDm8gcFoqMlzgH7Ev1EClHAIasNrmr70tGa0aeCKHWj9XgkjAUkZbR
	QUMXQCXrlQSCP52iProQQYxy6725AveiyHqWvVnQWuQkZrdXCuVEqgiXiu0S0YWHXQfjVhdyUum
	I4VRN4M1QdfTp6OBBHYr0o/sKAAQpv3ezVTAIRNMLrghwo0TWZtqt2kzmD6Kgt3Af9wv9xSDLbf
	GB2MssDEiEmOVK+dllJL/6sQPQKE+YWOyYsGjy8q7aU89ODPFfhQX4x3k5RFProkNs6KwXcD+V5
	Rp2+HE=
X-Received: by 2002:a05:622a:1b10:b0:51c:1ff:2515 with SMTP id d75a77b69052e-529d7135d23mr41229591cf.65.1785280858971;
        Tue, 28 Jul 2026 16:20:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.45.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2d822dbsm7899451cf.16.2026.07.28.16.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:20:58 -0700 (PDT)
Message-ID: <6a69395a.b5fdfa5d.fb43f.151d@mx.google.com>
Date: Tue, 28 Jul 2026 16:20:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5327239976132046555=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, deaner92@yahoo.com
Subject: RE: Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for qca_dump_hdr
In-Reply-To: <20260728212431.106411-1-deaner92@yahoo.com>
References: <20260728212431.106411-1-deaner92@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5327239976132046555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136220

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.87 seconds
CheckAllWarning               PASS      29.11 seconds
CheckSparse                   PASS      28.02 seconds
BuildKernel32                 PASS      25.90 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      492.88 seconds
IncrementalBuild              PASS      25.18 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/506

---
Regards,
Linux Bluetooth


--===============5327239976132046555==--
