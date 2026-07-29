Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE952C0274
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301689; cv=none; b=rvK6Yp3apvdwzolRJXyvwjUPXgTLeizKHenqYipoHknxqFV1o/dp9z9CzOLCgG3WeeKaQZrdycJOqP7lKt4YjQk/eEzQHRrMCETk020uz3kt6NjTEwODX8xW6vIVAE3eeQ6xw43gq4v4Pva80kfcO/nJnddXrtPPw1Cl5VNBHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301689; c=relaxed/simple;
	bh=8JRFPiP14bZyYZY899tC14FZZE5lOlLxo2EzCAkZ6kY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h3a9XLIJeIaZ6EOi37ZAWxkL6Tf/r5jc/ebG1e3qbgVhnZgJ3n2izLrgXnjI4uYYBkt4Br13U50pwG3ixV524KM7xHf3wNH+5URI0w4kYnRV9vR9zmOLHYpbPJSVRZRIp4F+JObO6lvOe7capCiRX6Y+xvYf49FJzji++qGz510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSk1Iqt9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSk1Iqt9"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e041ea211so620859a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 22:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785301687; x=1785906487; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3KDCePJX8npf5Lna9Q18jeaPedzwhCTMv+VqUS/2kUQ=;
        b=RSk1Iqt9rdz0iwPoMLRtmqKa8ZZIkhbzf99o0ub+J1JoaGpknAxXRDHy+MUM3R3UC1
         +SP2psrvzRrbGH4LKThV+xCU8WaNb/y6dNajD/bLBTaNFUU0ZpPJE+Nl9xD9HdFIuvbC
         mK16XioIDUictdHu03y8/tIcKIRUXkWO/ZnHHbPCsupRBwtRpAw8cpmLyPZIJqSavMkM
         E55LhM9mEc3is6jsYAyxbRbQFUyP7XdS5Fjovt49Cim+36FVN6I0Lm7UUhDDHu67kSJw
         DgpvdDt/v+bfFeFYI6+ftfxrYhITGhTJw3/QQ9MNYE9xFbJ8tu1d6MphFJQn4L7oBcn4
         NgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785301687; x=1785906487;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3KDCePJX8npf5Lna9Q18jeaPedzwhCTMv+VqUS/2kUQ=;
        b=jfN0VJQc+Mt/wgfe6ffPQsK89HT9hXueaXpdsPjiOCZJWrOLXOAm1R4MG3E6/FG5N0
         XM9ArvSF2IVxERH2xkM4kxpkyrHhz+S1Uv80NUQE19Zvf8GuPBDeJW8f5V3TmUvWxVEC
         5fr/8dNug6qsoXIml4U93qa/pfE+KuoVgoowfepbul0+g0I3Ob8NCbqZw7lHIqjJW1BE
         Wjpo0kqNWi8rNOuOwURbTrWJYKBGlpn/32q2LiNDfpQSlYVbd1gVsAnl9lOO+8NnSl7/
         fxeXYtntRNZoYJ0uFbDrPADzZo544ovPckDvCqy2bJHGs/B/PJSg/lxlawzs1ZQeJOHy
         6PcA==
X-Gm-Message-State: AOJu0YxtBp3ksUMpILYq96hBr9Vnb1sahkimFfMse5x6ElCbi1FbeGbd
	V4K3WRq1HpgqL2Q4K7ycwUj8I1Ilo9ImiE4rRESuGNCVg1MsNz1yCx/d3EISBQ==
X-Gm-Gg: AR+sD134IEut3/U6KNOslCO5PbNDYywQI1RuaGdN71UncpJuHGCnJ5yqqD6q1u2hl0k
	gl+2qGKlwP24v8X1c+C+lsEn1PvYPdn9t3CUvXw/qWyghancBeoU1T1IChtVQRHe8BlJSFwHdFx
	bGqt9M1OSriQGfbJl26o972PZWlb4VH5OeWjgRfwuzGMH4BfdasWMHLeaksji4/nU3yLroZd6Cv
	VRs5/D+IllLFQr2olI/hqUROL0p9GH7XnAnUOVUIf/dtPWlNSPvORhDXaHin7HndWjnWzVXxGvL
	WH3u/PXArc8vIR/n5D0ZpYT7EyzA+/c1U9TTKG49jy/n+B/d10xzfmI3QDl9u7SaddprqxVzZU0
	7b+7DsnEkj/6qgi/2IXXgOvYXZQ2ylJUWEmevcWgbiP08Mu0AFXWvU/8AZq3506v+4LDMvAgrkX
	L5EhQxS2Y6ldP9wva22NoU6Lz46rX0On7jnrUyVAWTFnK81g1noLONjnK8NpB27hRfFQ==
X-Received: by 2002:a17:90b:4b84:b0:38e:63de:730d with SMTP id 98e67ed59e1d1-38f6a33de96mr5225180a91.3.1785301687455;
        Tue, 28 Jul 2026 22:08:07 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.56.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b88e12sm5339828eec.11.2026.07.28.22.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:08:06 -0700 (PDT)
Message-ID: <6a698ab6.d1496011.12e41e.48eb@mx.google.com>
Date: Tue, 28 Jul 2026 22:08:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6753281707649703732=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] bap: fixed the return value of GIOFunc
In-Reply-To: <20260729-fix_iofunc-v1-1-653c8e9ac29a@amlogic.com>
References: <20260729-fix_iofunc-v1-1-653c8e9ac29a@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6753281707649703732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136288

---Test result---

Test Summary:
CheckPatch                    FAIL      0.28 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      555.77 seconds
MakeCheck                     PASS      3.19 seconds
MakeDistcheck                 PASS      159.43 seconds
CheckValgrind                 PASS      159.91 seconds
CheckSmatch                   PASS      312.43 seconds
bluezmakeextell               PASS      103.33 seconds
IncrementalBuild              PASS      563.46 seconds
ScanBuild                     PASS      984.05 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,bluez] bap: fixed the return value of GIOFunc
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 322c39a64323 ("bap: Start BIG sync after receiving BIGInfo")'
#77: 
Fixes: 322c39a64 (bap: Start BIG sync after receiving BIGInfo)

/github/workspace/src/patch/14717048.patch total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14717048.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2357

---
Regards,
Linux Bluetooth


--===============6753281707649703732==--
