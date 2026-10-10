Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F4370AD5
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791648575; cv=none; b=TC8FNXgHonyeLdKQqvsHi9HCvgSve0MXj5joF4bxTsWGbcbCff1kRUUpk91kS3QZyODxeaipuzq4vdR/SEwNQvDegmoZ/76Nf+wyjO3fYJcRD2ILB4k0qdLhxblOkYFX7FDMPHQFIcyAdf/UTMBF51Bwq+mBUr5Vx+BRP1g0n2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791648575; c=relaxed/simple;
	bh=tr+pO9xTmELeHiLt7sTt2vxsNFitZ2SndrHEUL0i/7I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aIVrREjC3G0KYmPdXAvETpg3PPaE5deaLyYYuqw9zQjfx9VaQA3nQ1AnOh2M/fOfwLyMHXg4aq5UW8xCie+zY602zRDKITSc3oYDOQUEsWxcqqWHnsTWAlh9RWMWlpXVzOZyHxUJtduORURmTB+yvSibBz5Ik46jVtSw4Yd8CkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8lXxyme; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8lXxyme"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535a54bed9so849836eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791648573; x=1792253373; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lXN8/gtgqvuuOPMARsIt2O2T1mRlvsRIJ24/3zGuLFI=;
        b=F8lXxymesG4xV8jlXTRmLu0yKYVoGi7e+yFSSyd+NmhNYD582ZG3lBQ53q7EtDu5vr
         9x1u6HQCTZFp9F9KTGLk1qWOnANqAt+RqRLI51pspqUnM2BizooMTuAJ5TH7+uQWXHcz
         PZ7mUvwY9ivuOzeJSu20LD6dreiNDS1Xpl/h1VIBCYlzEMqHS5WULTj1PUxdEJQs2UBt
         EB074ViOBr2HKvPa2a/fu59p60Td1+qQID3d/kjSMCJ6rICjpPBpW+/+qw8P9sfDEsP1
         69HhcfZ97g406FlBEOjxAp8j5fl99jgJmvnu8bDxr9hv0cLjJ88KF+QlIb6tqZGiCXst
         5KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791648573; x=1792253373;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lXN8/gtgqvuuOPMARsIt2O2T1mRlvsRIJ24/3zGuLFI=;
        b=gvkSPRRiaWCFn53L098oJdErGCDsh1R08+rx28TEYalvTFhJ3s8IPuJxYy3SI73Loe
         B+VE92oB9ZLkHGb7kULz+bYFtQrbECQSXou5+jDfAtqX3u+rreoO2JS1G0P8F0iJ67C8
         uwMAGagPBPm2UqS9WseUwg7l045Mw739JdTDemi+ZZznTAUd1NifDyP3SAFgGIoRLDme
         20/utf79Hw3OX7PQ790AECkkS0ZpKfHKlekGglew40mMzVu6gZILImzN9JurKgD97LCi
         JTD5C+iAjaVnbJeaRLO49oNGkIC/MI1HZPWsTnT1cYC5+EVktsAehq9VL9DC5oOX0Xse
         xSrg==
X-Gm-Message-State: AFq9FYL/e9Zbdjjt+KvwdXGUG/8+STeCDLrPbaxgkeBRiM4WgZWgQ6qC
	Buya0kgpYn1gMWrJp/PEPP2Qi8Xwd2P05RKaJIGMbcGsicZWRAvyeXtdD2pm/Q==
X-Gm-Gg: AYBFou1MpjTVM/CqLSvDXqhlzHZtnLNPrumz8WrMqZV4ZgNbgQj5vO1zoyt49BNX8Yz
	xvJAdJ830Kl458RtRwjCagAWcKax51OmvV5KoBDbuRt1ApPj/lewzQcZwlLIDCcS0KJGpoA3pfS
	VvphP7GLKa8JQ9wYPVvm7qa34Smknmn+9AmKO87EM3YEabr0baD2ybLonul7S0/F7Gt0qy2QE7H
	V7jHHBUNnXVP+W/3XUC89eSkmHDATe+hhtIihFtvHEiDjiYJnyHaiDUQWGGCVUg0Zr9CO25FJfc
	ri+hhQXJQtE82Tvq9Tw75nmnDba15yo5f1PXnEYZtZc6l53pojsxlIyK/wT+CD5C7dg9TK0Xj0z
	Bhcr5hvylBgmEe/z2saOyeguVHx3j9Mpj6noOxEBU17cV3EAP3sKxC9Ug7DPZ6FsUj9LYWqMivA
	u/ypNSfP/CdwwN6xmqVvBBlcDxZUl0ijsuVtS3h2hwWZ/Uw6bFZBscXEOzM3qNIxv39QOHf/iPM
	p5fiw==
X-Received: by 2002:a05:7300:8803:b0:353:7b46:4819 with SMTP id 5a478bee46e88-3537e032905mr8096409eec.8.1791648573338;
        Sat, 10 Oct 2026 09:09:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.125.104])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1cc25sm19805854eec.8.2026.10.10.09.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:09:32 -0700 (PDT)
Message-ID: <6aca633c.1619dd05.33e34e.1306@mx.google.com>
Date: Sat, 10 Oct 2026 09:09:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7327202110306107359=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] unit: test-rap: disable optimization to speed up compilation
In-Reply-To: <ba9d7cd83367a994657de01f124f1fee19f7485b.1791630862.git.pav@iki.fi>
References: <ba9d7cd83367a994657de01f124f1fee19f7485b.1791630862.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7327202110306107359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182943/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.30 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      16.48 seconds
BluezMake                     PASS      229.14 seconds
MakeCheck                     PASS      13.60 seconds
MakeDistcheck                 PASS      119.98 seconds
CheckValgrind                 PASS      189.61 seconds
CheckSmatch                   PASS      224.23 seconds
bluezmakeextell               PASS      74.82 seconds
TestFunctional                PASS      927.53 seconds
IncrementalBuild              PASS      230.67 seconds
ScanBuild                     PASS      819.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] unit: test-rap: disable optimization to speed up compilation
WARNING:SPACING: space prohibited between function name and open parenthesis '('
#101: FILE: unit/test-rap.c:14:
+#pragma GCC optimize ("O0")

/home/runner/work/bluez/bluez/src/patch/14879301.patch total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14879301.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2658

---
Regards,
Linux Bluetooth


--===============7327202110306107359==--
