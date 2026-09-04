Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932722192F9
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484259; cv=none; b=od4FDUVVSHIFwZhrTT4sJiPJKZXl6Rq7NhAVuzw2GXeEDh84ImxksuukYhRMAWrzUtnc+dVmDFja/MWmr64DAlgOvxyXnp7pdwb53JoidQfY4ZDhTVA6Ymi8uH3B00XT5scQvZsy5UiLgib4thFFJzS3mvbU0ZoEf77XEyaevzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484259; c=relaxed/simple;
	bh=vCmHgnF2NuxrWwmIq9Vnxz7vTI9jMv/+2TITcS+QcGY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gIdRl4Tzm/47SEeHySybJVyXbIzL8GjTLP1O8pZQ8JO5RTZu8a7Io0xHWl3pfkz0JbObB7mRFW+9BrPi4vNGJu/Ux5PEngWtv/6iag1MhnNPbj1BPxGWgDAkqpyQSrxgfNuaYW1JvDz4EQGcpwuMdyDvnkiUTqBNJYMeZs4hDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGvqHkPW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGvqHkPW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso605829a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788484258; x=1789089058; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8D5LrAxmXAWQitl5OrKnNwalq9W3folU+vVziM7KK8A=;
        b=XGvqHkPWl7PhF0o2r63BW3E6uBfeqzj3RpF0E+j4K9DrW94mH5oAxwco90y5bttDt+
         lkie6ZRCU9vzrUd+d1BYh5TxkllrnFofqRiQGBf1VTlZfF72waQxUbnnVeEX1S/5nqJS
         cJjQ13QRe4Vv9WLSdjtvihPwt0h3mfsun0EX4k6sed3x4hvNEOQuiZ2eO+z1f1mgU1HL
         Fl45xYuAAnE5wy7vIfy128thNtyHFx9kbveP4rv7DEsLFjZvlM8wS62UxSIQusYDRPGB
         KrEzg70tUEOzZqnPyWd6k6fSJ5ddNH1CPg96ipx9DiJSzDeRyU/5YTZf9NxkSOlG3obQ
         zerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788484258; x=1789089058;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8D5LrAxmXAWQitl5OrKnNwalq9W3folU+vVziM7KK8A=;
        b=P0P+dB7uADDFHFYDRFpT4+novnZGCR0LvDV6/9sZM+c6imlu/nrBKRzbDv5CGd/pap
         0mXLp4i/RYs4BT+WEZ/CmVmXgoTkcKNcoDMOjvuxvqc7Q2xuywxwUewAZcusFCSIXaFX
         EPZABzAukAfc/YEFp6xzzgFwS6hFXEPutt6dYQCirB76WFg/tAAzh/Bnx+VVZLzf+XEk
         T63of5XAfK9JjWYzKbmgIHcXBScGX+kj78axja7ZzokNFq+2Z2ZpCqV9Au8DBuWVElzW
         kfAUXWFJLswehEtPUwr1B7Ok5ai6uTPxOn4LEMoeyU2pGtsFWdsUvRa82/jL8FBp6Bm8
         PEGg==
X-Gm-Message-State: AFuF++mZGo/FCFdxk4LHOxhGHYQbySMfJlRNmqgl07MkM4rxV0icBhuc
	U93vE3GtIjUSV/4x7bKjLiL7IXa613Mk4CfOJ64Xmm3g3BtJGNyuZP6ZMJRuDg==
X-Gm-Gg: AYBFou2/rYSLAGddBdfJPwRTxeT6orkBo3ga9cPZZehiO3dYWYak1AVbX//Hyj3ybDb
	l8U2p0pygQt/+Gl/oon6kmpiZTvYX8BlLYFeaFpcjXwEownh3ZFXv1eQlzosLc7ISAgnuB4M8+H
	fRDtKe2z8d0bkEijHqpAuCI8jNnbkctNI3e6BQ8ZWQREdk+sqxOAoBjSHO+KCxo2LAOXSNdfHdj
	79b7yPJZz3C2e6HCQPGArNjBwX8qZNPu8DEXFyrJXIKOW/ynOsQ/0m0UqTYugNUZwHnLOnGmGwX
	4cD8fsaJzFyfLRAbebQIupQ1nmRMiuyfjqaDRYRNGyXmH8xaoEjrc1UW8H9NQZdAfZFDKgBOoas
	qByEa48da6GX/f340e8NPNcj4+moS0OB1MZPR2kwZIxKZyysdVi9QgAVxtiGmIFBT9lcQNUvMDY
	EKJ+slSfVc2cIuem2xapyghkeDqpJUIm9mp4NlmbRaIS4jRa0vvq8gJ3u8f5zd+BIvLU2yO1Nk6
	PRv1cuuVA==
X-Received: by 2002:a17:90b:3ec5:b0:398:9c00:29ed with SMTP id 98e67ed59e1d1-39b26277673mr3624308a91.21.1788484257849;
        Thu, 03 Sep 2026 18:10:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.239.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm2358758eec.13.2026.09.03.18.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 18:10:57 -0700 (PDT)
Message-ID: <6a9a1aa1.3865fcc3.16a676.43fc@mx.google.com>
Date: Thu, 03 Sep 2026 18:10:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8010105167738670274=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v2,1/3] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
In-Reply-To: <20260904002939.622659-1-chandrashekar.devegowda@intel.com>
References: <20260904002939.622659-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8010105167738670274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157479

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.18 seconds
CheckAllWarning               PASS      28.61 seconds
CheckSparse                   PASS      27.17 seconds
BuildKernel32                 PASS      25.03 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      463.98 seconds
IncrementalBuild              PASS      24.55 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/3] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition

1: T1 Title exceeds max length (84>80): "[v2,1/3] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/700

---
Regards,
Linux Bluetooth


--===============8010105167738670274==--
