Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5F2D7393
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787104557; cv=none; b=rnaafKbT9DKKP/8gqJpESsuk2iKJoon036XP2JDH6jBCBAe1z8pGnJaVfbWsltpL5Dlg2X7QgZP1a6v0mHrO3jnn8Bvh7bgRRHnQSyBafIxeSM5spHmF5cLTA31pa79DJPdjjwcw/EEbQj+/itkMBw8K1LfcyRWFuJWWNkJe4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787104557; c=relaxed/simple;
	bh=rC8sHAIepuRrV5MzkBKnTwHvP6UUG0+QsM3UnUt2YGQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Fl7RGrPLj9HJ1JtZFk0uz+o3wV9gBMmGsk0dlEs52NTELQJwcjD8ZsCx5qz43OYuKoSlwHIud9UwEIUwH1g+HxR6/gzjk+REcNJ4l7XCMG6xWXY+WDHq7uIEy9K5Kom8+iTym/fQ7IP2evfZtjCAVV+K4wVk+4+XVuJ8BSsffp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me7uzE3D; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me7uzE3D"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so657750a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787104555; x=1787709355; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zEAgKC1V4MadzPeqYpUU64OCTXvlqt6Ebwvpc0D+w/0=;
        b=me7uzE3DFo5Kl67Z2CQWerF295UWlNPjzcKYKHxbd1yNayzvoLLUpFXKCxFeLr+jeN
         WG+ulDvFq1U30COcKGCfhN0jvGYzIqayA+7D2TGA/KW1yiXmeKL78bZZYwXhqd0gHG6k
         gIHSehwkv6Xk1vc8IkcqcPrxaSiFbKzWudMKV9iPQF4ewJRuELMFDcE4UY7bJlaULLI6
         Hs+2NbSQ35tXl8RgtglPAmCzpiSrSkmhBxup6g0enYmysJ9Tp4zYuST646ip5/gy32Op
         NHc4yJJoXeaTdiudJVyUYKF6j2Z1QJxLNyvA1eB/ShvWCMtbTclKD8qDNnmU9OnKPPOD
         T07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787104555; x=1787709355;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zEAgKC1V4MadzPeqYpUU64OCTXvlqt6Ebwvpc0D+w/0=;
        b=HIhFZfC5vTn8H19BhK8qB4m+xYsJXLAPrIqMOryQ5JVd1eo0bIta2mKbgHYaPfzLps
         9BpctjLF6k1XhYLQpxCyk4NUUwO/Mb6+Aww60Uj2wzyAC39mX/OSycUT1ZjIRV+xmnWM
         4UqLkQertlK/M/bADx/u82+4P+EPaX92cCvyd12eUlA0CmQTI6NpIWNs+PVB/0KnJn5/
         j+Bf9YlBvX8urhy8rqFJv4TpPkJ5jj/eT2iOBkbVRb+tmF1HNNSh01L1NvOg0SSYkwyL
         tYJM3uRi3WzG6y+MPV1eKwMopBL/vohe3GPPUAkdbC1z7UDLxQyhJaT32mZxGOggmQPm
         9ecw==
X-Gm-Message-State: AOJu0YyfSDBuKu3TaEw5OGosZkQYPTy2aQ+SsgWe9+8NgWULTj/EUdPj
	aP92rFcnLiZvOLKTHgQeljGKBRxVKzTIiXpHP2T0bXJmx/8STreebgg3Z2eo5NQU
X-Gm-Gg: AR+sD11hUNMyHbApjX40UVUPxqytub7mfyvJWtgV6QZ4n5mR0gfyqt79Y0eTcCGaZiY
	Yk/2dL1EMsd/NUcSq2u3YgfNW1i0+XaD+p3AtR6EGcK+0AhuSK0/RLBWLXwJYfaNB5gJXnQZ4Eq
	lSo8bxWp3CJBEHxdZ739sjcpeyUQJGfOvdez2AYmdgljldk252r4McurZuW0n3xGseVxj4+BVdC
	7MeKwY+WcAaOfEtDHfHTNNckskjQJ6yP1Wv62iOnC2rgjeI29GLZaFesYU25sQEBI68JW4o5rFA
	BCuh91Oi6ihN9u6/jfId7zj7cl7gIokbgHlQ635MPg3OZJv2+4cEPP7DkPn3wG3qnrSVB8GRYqR
	a4Tv+1IasxenwunwlkgItNTJeS+GWpSupQEyIudfdIfLEmIzEU0o88+vcCisXtFLjbXNNctdiaN
	jjC4gZg/F8pO17Vc/yF/tu9MmdFtPQTxQc7aky9LDTuss+CBBPfck71Lp7Bu//nGuhODTm
X-Received: by 2002:a17:90a:d604:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-3958127a5aamr2126028a91.13.1787104554984;
        Tue, 18 Aug 2026 18:55:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.184.150.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef79243sm1250003eec.11.2026.08.18.18.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 18:55:52 -0700 (PDT)
Message-ID: <6a850d28.d1496011.7fc0d.7bcc@mx.google.com>
Date: Tue, 18 Aug 2026 18:55:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6515881056764119360=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2122295973@qq.com
Subject: RE: [v4] Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
In-Reply-To: <tencent_FFECEB355DB76CFDA2C0FE89B8E509028905@qq.com>
References: <tencent_FFECEB355DB76CFDA2C0FE89B8E509028905@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6515881056764119360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148137

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      20.93 seconds
CheckAllWarning               PASS      23.19 seconds
CheckSparse                   PASS      26.24 seconds
BuildKernel32                 PASS      20.20 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      378.99 seconds
TestRunner_iso-tester         PASS      73.82 seconds
IncrementalBuild              PASS      20.71 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/611

---
Regards,
Linux Bluetooth


--===============6515881056764119360==--
