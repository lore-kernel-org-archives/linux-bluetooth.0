Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E553BFE34
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320346; cv=none; b=AQ8+YmuNJfL1T7zisiw0cuLqYXN3KAv7pesgdt1KBJZgs3QxlyNAOxF5EXvFmi75LBoAhXFoeh9QGUUoZkVLM0bQASXbT/B22bX5AofTKP0TAZzEHgjOhsltKHrNNhCUz+tC+1+36nKKEgT4p+E/K2QW8Ny7GA7BfYhzJ+dSb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320346; c=relaxed/simple;
	bh=XPwuxn9rq3TFXRRMq7vydr572c9aNSxh5niqU3WqUvI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S4ZnT698mfFJiG2c7UZnHyG4CNBDb95GYdP/8p9F5ge92N0CPGAuzUrC7sfY0Hwe6rxkdNtGB/GIg3laXbfvQ11o/VdBQjHfL2/uwGs2BpRpVlrmm7iyxTLYV9lpdYDDRIJyZwupi0IHlDfYA7c8xvapG/bWWp1C9zx3v+soQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5k7AwjK; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5k7AwjK"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66825847b2cso763623d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785320344; x=1785925144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F1H7CbpiozvAiT/2mKkCKyGTzLFyy3LQaQKTJ/ndyDY=;
        b=i5k7AwjKTaVh1z9XyXCjID1y79g6FuylzmAj4NSUCiSwrJXXDOLltod1eOxizgZd/V
         /ZAtFPC5t14rf3d92bvLNwEQYej0v31x6uhkd3rOmDpVjB/7PVY15fNR4saabiWyjv/k
         zderYqsC+Ve8rQPcmKjx07YvxMQIzwPvz7osWwqE9nDUpvJV6tpXOojbgvMKwloCXBM4
         ZC/nwZIEj0IoH/1BuNGKTtri+tAq7wtY0fEUs4PyXcyQSoj8vBuntwl3skTuoDxuCvH9
         qV4b3dGERT0WpSg68msYMdjtKJo2HXG7wy8/pL+N1UpGXD+jA1JtmfxixdGjem/zdW5B
         31bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785320344; x=1785925144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F1H7CbpiozvAiT/2mKkCKyGTzLFyy3LQaQKTJ/ndyDY=;
        b=rSwYXgU69akAgs9GlUL1mP+sMTuz+cylsrsqbXfVRBZ9tS7eXUUX3QJx8Y3AONE9yS
         ivTQZsr9MCvLMtLSm0lWDfzGFN2/6C2XCZjYReB525Enjiuq6P4Zz97Oo+NIl7wYimWF
         WJNucF/vNJmNyQQ7y/ieXZvFVIyEesJ7zKVzTrI1Ble+twRSO4UfKk3pl1iD8lory4G+
         y2ET354QqXmNWXwdpbNepsd880A+XENrHnNQpo9yLpxn8Ey8ag9ipcxgI/gs0UBIz4TM
         Xc0H7VFkC/v0F/F/WxDtn8MmkVK5TQBAqr9HyoAJlQ+krc1OKcn6LulqApwB2DqG4yCt
         l28Q==
X-Gm-Message-State: AOJu0Yy7V5f6BabGxz7m1Q3EH7lw9V4VzaI1xUzZLXNypCbJ3Aq/yeQo
	br6bH/vugISovKkowfumzCCcB4dE0Ylxz5QS68cY6Ok51z5zjfeSYGBRJt2D6g==
X-Gm-Gg: AR+sD10B4uESmF6pVH2T2BC4cGOdF7zd91B0N/5plCJqze1zgpWX2QPBC5JUYWphuOC
	xqwbDekyDABKz/6N3XKRJYVIYUQDLQ14lRpKBeszWgMXZctkFrSMsHvgPRRGijp35ZyhPCgOgtt
	a5I3rcT0cVgmAkIXOAz4U0a5oQN9AF/+WXTolCJgEcI3P6zIHi9V+c8DqqLrjzJzJICgT7Hw9BW
	VfnlizNU/lqlYa3fAYF0PiAXq6TEF7Ck7kdaNUU5TbF/1+b1a5YPYkWJ/mzpvTTsD7OXJC/rKIt
	OPezvOmn58G9UNKUAx0qj9aR6hPv9NJUC3anTM9NnTXisMjH2SrkNH0lla+V20/HcMkGUff8/En
	yXuMua5Ne9JxB7k8iwMpTSCkmPqCYKTirJ55GEqB2WuZC5kEvYgbiFdcaAY0xrTRxMCsDEnO7rh
	lVtTX3+4ylwBrsYVVXfVUXJPDM/JAHS4a5eHVWpHizsgIDTSelvsTGq7DGCMkSqsq+vawK
X-Received: by 2002:a05:690c:6d08:b0:81e:799f:d55e with SMTP id 00721157ae682-81f990fe96dmr31810927b3.19.1785320343798;
        Wed, 29 Jul 2026 03:19:03 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.192.144])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa279db0csm15400637b3.20.2026.07.29.03.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:19:03 -0700 (PDT)
Message-ID: <6a69d397.a68844b4.1be9b5.a7e0@mx.google.com>
Date: Wed, 29 Jul 2026 03:19:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7243076624427241740=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez,v2] bap: fixed the return value of GIOFunc
In-Reply-To: <20260729-fix_iofunc-v2-1-f4043eff6664@amlogic.com>
References: <20260729-fix_iofunc-v2-1-f4043eff6664@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7243076624427241740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136408

---Test result---

Test Summary:
CheckPatch                    FAIL      0.41 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      21.06 seconds
BluezMake                     PASS      551.31 seconds
MakeCheck                     PASS      3.73 seconds
MakeDistcheck                 PASS      162.74 seconds
CheckValgrind                 PASS      161.22 seconds
CheckSmatch                   PASS      317.67 seconds
bluezmakeextell               PASS      103.40 seconds
IncrementalBuild              PASS      552.80 seconds
ScanBuild                     PASS      991.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,bluez,v2] bap: fixed the return value of GIOFunc
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 322c39a64323 ("bap: Start BIG sync after receiving BIGInfo")'
#77: 
Fixes: 322c39a64 ("bap: Start BIG sync after receiving BIGInfo")

/github/workspace/src/patch/14717383.patch total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14717383.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2358

---
Regards,
Linux Bluetooth


--===============7243076624427241740==--
