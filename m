Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCE17E9
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814153; cv=none; b=O4JXtDcA8L9m5bZHrSYWHl1AK/YTMk6TaloprbmElah8mGe3XPxtjMpUP/xl4Yl30UV2FXeF1r3ayFeED8WwhOUrf1Xg6EMDDN9U5fVlf7WTAfrFZBFQJc8/832O0gTFR5LzvDtipqcXS9QKPqK1wgSVVor65NWRMDqkj/QIkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814153; c=relaxed/simple;
	bh=8QzJTNKcdUycyOP+3ejDLo+WoZV9pbp4lVWDPfDB3V0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WKuylR2XlM8XV8gkM0irVBCxtSIulgL57/i0wEZmXBJlLYFQdNqCdoBodp0gbCVdDlulbes0TIehRvsicEaD3+DFHCRoJ14uWebVxO4j506DyJ552CWeB55plnO+7ETtkehdH1zUQh/PUD4zf6fcryzuhg+nhvUf6jOOo0iKuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9MkTtcm; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9MkTtcm"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5cbc5b63939so3461918eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721814150; x=1722418950; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg2CS/5HYqF97Wvis6NTrGlBmCqcx9wOTPmg3k+W8gU=;
        b=I9MkTtcmd0KIwGLRXoG7vqF9gIQXklN9iw3L7mrdppge9v5okQjEc7m9XtoLLN56Qq
         hcwtEvKNIBHyPCSSjWqtURju1XbgLUlJAEmh0bbnr+Z9Kfw949m+z9sIeMqsVclipCgo
         kIacGT7GGhIBIEOfJ7VLCq5wik3u+SbgAJzKsmdgDCFSWRDqCE9ta9WNlfn1vs0fqZxH
         6D8BbWDM+IULNK2FYHn8/A2WFi1C3/dzaXrAW03y6Cu/pZ113+tpt1HNrkAKUCjNcHBO
         DXdARWtWiO/zDpwkYinY77zJ25qmLswWaNBOOF1ayMJWricGfQ4jGWR/GdQ0gVBDt7Yo
         3PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721814150; x=1722418950;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qg2CS/5HYqF97Wvis6NTrGlBmCqcx9wOTPmg3k+W8gU=;
        b=DNvdgwb0V5HODAF+UM92kXYF/erBZE1WhPmvjegWolATugoWkztqb4MnNOAKyyL85Z
         dwtYZDlaH5QF0RmdEdjU8pNCC/ih6T/apaWk1K/YoY41oOc+ELP44kGKmr0FIRu7xZSn
         2yh07wiUlGbLxis9PXOR3P1+zr0BMoaaV9oOzvu6uqOy2w2pJWK7fItBb2PAk585agHf
         l/QlV3CUThC7iWoo236cewZK+XvqzVvP/w9thZycHSQtHO1M5parz7D3OxkasdCtd3Y0
         V768UUyH/4adaDbxxBjQIJm3++n1pizPZaqSlMP48CJMjxWGOO+Hrm7wCU1qYfsdTzWm
         z93g==
X-Gm-Message-State: AOJu0YyXkQgL8m/wte425iHdKnr3ldVvPho97Ho9V1BlsoI961eB9zGO
	IDmr4wzBmaGdW0M7L2bakDwR+IHuvaePWl2HOWWjhJy7yk1iiJavZKxRcg==
X-Google-Smtp-Source: AGHT+IEeR6VvFGJwwEZDv1O0AWVeWTq924nnk5S+aQZvFPnn3RG8FmXC07G+kCEeaBjQDI2KzjmFxw==
X-Received: by 2002:a05:6358:6223:b0:1aa:d6fe:f424 with SMTP id e5c5f4694b2df-1acc5b0cb92mr1436138755d.13.1721814149428;
        Wed, 24 Jul 2024 02:42:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990792a0sm562268985a.109.2024.07.24.02.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 02:42:29 -0700 (PDT)
Message-ID: <66a0cc85.050a0220.d03af.12db@mx.google.com>
Date: Wed, 24 Jul 2024 02:42:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5137355272875575307=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_nakella@quicinc.com
Subject: RE: [BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request.
In-Reply-To: <20240724074415.17590-1-quic_nakella@quicinc.com>
References: <20240724074415.17590-1-quic_nakella@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5137355272875575307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873454

---Test result---

Test Summary:
CheckPatch                    FAIL      0.77 seconds
GitLint                       FAIL      0.51 seconds
BuildEll                      PASS      24.73 seconds
BluezMake                     PASS      1652.07 seconds
MakeCheck                     PASS      13.37 seconds
MakeDistcheck                 PASS      177.75 seconds
CheckValgrind                 PASS      252.63 seconds
CheckSmatch                   PASS      353.87 seconds
bluezmakeextell               PASS      119.76 seconds
IncrementalBuild              PASS      1401.88 seconds
ScanBuild                     WARNING   1020.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request.
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#105: 
https://lore.kernel.org/linux-bluetooth/CAPm3yA0m0AUyQd04J4H+mQ3NL7XjvkLX3M8R7cKhc8QGGG25hA@mail.gmail.com/

/github/workspace/src/src/13740640.patch total: 0 errors, 1 warnings, 238 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13740640.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (95>80): "[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request."
1: T3 Title has trailing punctuation (.): "[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request."
11: B1 Line exceeds max length (107>80): "https://lore.kernel.org/linux-bluetooth/CAPm3yA0m0AUyQd04J4H+mQ3NL7XjvkLX3M8R7cKhc8QGGG25hA@mail.gmail.com/"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/hcitool.c:3404:13: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        handle = strtoul(optarg, NULL, base);
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3407:10: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        min = strtoul(optarg, NULL, base);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3410:10: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        max = strtoul(optarg, NULL, base);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3413:14: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        latency = strtoul(optarg, NULL, base);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3416:14: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        timeout = strtoul(optarg, NULL, base);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
5 warnings generated.



---
Regards,
Linux Bluetooth


--===============5137355272875575307==--
