Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF03ADB98
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598014; cv=none; b=RF1tOuTKrniDbVcT/OklvgaQ1saL6get5pmhuqpOeBeDuVNcjqATtMGFxA90f47W/lOV+sffroiQQkxC5wPXJS68L20VrjpcDkJtRktz5iLgzl3p+eqDOCddGROfez+uT3SKpfIUomw+dmtPq1TPFhiVtpsfKOp/tLRvQm6mHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598014; c=relaxed/simple;
	bh=BaFZu9KnK3I/Ad4PGI49F2WGywFRFZTwlprtcn+3HVg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uKzVh/5E4WcH4PNps0GKEEYWDX67RihpGJ/inj2OvxIZuP5mr83dJFD+4qTO5GMBUJXkmCV/7+uqdAn1bOvzrTwQ6bDxwTyNSGsA6J+WnSTd+Pzlr09ZwGiGQyWDBsSTYa6AdPbmSFEz57CR3puum2az56rDFR453yMfl+BMoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGlRIKVw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGlRIKVw"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383cb94f742so433808a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 22:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786597995; x=1787202795; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X8yYsC+ylqkI5TaDsfMQAUrtVUPmyQr5m+C4sruEqyY=;
        b=VGlRIKVwrGlbYMt8D5U86tb9KFmzCZTE2Eq2zepjX0MYsAOYJOdvXlHVS6p5408LXm
         POxIjh6qsLcJGKkaU4H2+tkbOgdhEEh1gwmKCnPMk/Tw4MP8DADc6nPwmvwfaNTNVMRE
         DYZbypFjlrPsw+ixusGF2eQ0jmZkcqC4Iy+R4t3ivS3D9RCUlvFFUgkOO96qKU2a8qgV
         JTGJo64DwMYzyCfHs1jcZrlcsGQlDkGJK98F/1Sa4oTSfRIeX74F58xK/fwbpq4wc29T
         N4yyA9QFa0LJbvPTWkUF5se5/k6HZD1zLiHdtxOFmUzg4LDxZA+xb+/rUUtnH8KzID/P
         OX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786597995; x=1787202795;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X8yYsC+ylqkI5TaDsfMQAUrtVUPmyQr5m+C4sruEqyY=;
        b=isD8Wj9ehLiVvrSLZHoRFS0xFtPfw60U8V9Xjyuh3TPK31x7oESIVJAuIkTrIB1lyH
         RdHQ/sReCrHPyM5pN4g67Hz5doNIkVG5N2R6eGG/KtEY3qSbpqYwESPv/jXZyLy/9VDD
         fG4qBMJqWBFmgTwOPiaCc9DTUypHfK57l5NI3vFpMytFKZeyuw/LKNDdrgmDkuE1b2oU
         Wfh8ydaB5mKFx86x/24tpLHkP3xD5end8Ic7VbDUA5vRyOetGMsK+2J4IOleRYV+zcN2
         R+P+PB4UeORNwPTRlc7cyA6SL+F6eUl80nNEthLKU0lflF8QPblZQM9bwbmp0wDQLC3v
         mlWw==
X-Gm-Message-State: AOJu0YzkzVKksjGdOMQUeqohVNchpFTggfksfqVkX9p2Z6fRLcnPWTtS
	gVtAECD3FBnn1WmsJZ7AoXnEB6et+AswpWzvCtc8xujQxUEySgNSx+zVKViCew==
X-Gm-Gg: AR+sD10EDxZJONVt8uWlqGXBLC1r42zU0vVDML9wOISqSgMv3XchVozCN20Off8z91q
	8AXJA/GuPElP1pcwjn1w7lZnQTWN1JWMZlh3L8DQP8kqhXA155l/ccftHrc+SeJdCSYC94m1Kdr
	waL2rn4s7yq5hY27/7iY0NAJa+WhsG3NhNx2h3uG6yIeW1zYaG19vt2n6UGJKkMBKZrG7G6l9FY
	YTkPqtKuavdp+47g73XFzCdgR5LR0lyEakz0TOWe3HvN19kfyZzIxDBAgesohrVdHklNgosJzC3
	hpGU1qXQywhl0pRpG1UW1RE+vho3P2kMqAXfo5XaV0nT8PzbeI0RBr51I0tEnzCOu+GU4qj8wTA
	q5pj0TFrUT5RVAsGBS4muk8FRk5I1iMVoF7QlKoAXglbxccDvin66mhJQ66uzdY4AyH8LIJWdiU
	7Zm2ybMVuYLK9dvrh9v+kX1O2rFlxScDwDj91FdQX+X+a3LbWZ2IdoTrN1RktYxeLLah/Uau8Ci
	teE6g==
X-Received: by 2002:a17:90b:540c:b0:390:b41a:b92f with SMTP id 98e67ed59e1d1-3931e31bd38mr3754704a91.18.1786597995053;
        Wed, 12 Aug 2026 22:13:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.211.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412d8bd946sm4405199c88.5.2026.08.12.22.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:13:14 -0700 (PDT)
Message-ID: <6a7d526a.4987c784.134a38.c10c@mx.google.com>
Date: Wed, 12 Aug 2026 22:13:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4569114850090619902=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: Bluetooth: btmtk: improve error logs of MT79xx WMT operations
In-Reply-To: <20260813033317.23914-1-liujiajia@kylinos.cn>
References: <20260813033317.23914-1-liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4569114850090619902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1145096

---Test result---

Test Summary:
CheckPatch                    PASS      2.83 seconds
VerifyFixes                   PASS      0.17 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.87 seconds
CheckAllWarning               PASS      30.41 seconds
CheckSparse                   PASS      29.24 seconds
BuildKernel32                 PASS      27.25 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      507.95 seconds
IncrementalBuild              PASS      26.10 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/575

---
Regards,
Linux Bluetooth


--===============4569114850090619902==--
