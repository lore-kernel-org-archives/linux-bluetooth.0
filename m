Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCFB19F471
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Nov 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731184599; cv=none; b=jJpk+528cNJqbuxDK8gZGFwLdNpNpScm4YGEg8qkSjVQxQ4e/3/VZysMyq57fTp7AG6i6BU24ts7stnPgw0S51BbCqhPMFsu/4/Xru66gjRmLdEvyKiMfC1Br1UAKYa418zJMwhe7u5tqW22CagzRnnVUJtm9+VXAK4pFnQ53pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731184599; c=relaxed/simple;
	bh=SiJctle5NMN3lxbe+nBfrquC6MWuvXl8sn00m39a/Gk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BWGl+adQv3RNlsmPSilRkokVtotKRZtaqYCbgaA6dBBjtFO0XvZKGP+3CaGPvcUFkGBvqEP3xXY9dMv4Ps1GfZjLANUR5SNRumx07EX+4eeZjcqdW85TRL9OVMkgozWoRlCKulSI4KcXvjF6OtGTML2xGupM7drQzWdTMYFt2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEn4Hun/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEn4Hun/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so3349126a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Nov 2024 12:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731184597; x=1731789397; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NAMjUS9PCMRRkNyAUlseBymgIEV0eI9f+aO1kWU2EAc=;
        b=GEn4Hun/11WyeGKPhGwAldGAw7nNdore3gk4NwIJ+jR1KehlMA6TtVWguq7exzDYHB
         m8eCewgNxWvf6mn8tUij0wvJrQDICTk92pr3WnSF7v+Ng9dMrbcbT4P5L1u2xkSITRrL
         VPl/sC7+dab+bp7DDg7j9VffVCLTXl10yQwS0SZsVhYiXBZDcqRAom7D+DfuzXJ3HdVl
         Inhh1fh8N5Ylc0p84tQNLcJtgeaVa3TS/b0eTuxuY3hBSuJzyz5smBuDtF8lNvUdGmck
         BTGoQ94j3BGg4Xqb0QMVqvBcTvyMzr3cvzgzaAgjVEHglnPpBI8vbYaR1Eb/bKHiZ7BG
         XDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731184597; x=1731789397;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAMjUS9PCMRRkNyAUlseBymgIEV0eI9f+aO1kWU2EAc=;
        b=dcYDapIZTSxfxVynVtc5gKE9Qqnn2ip5n5HIOZ2A9v6bqqIC3C5iIYwo19Oj78C8Lz
         r8uTEjPPkPtXAyx+NOLzRiA9hBIJzALaBQPOzf149D6Jv86RNQA8eLfEfj0FoDkimanb
         wno1JAynXRMIRDObO2eC7cNzH14S7Zs9+QeBUMgyp1Y9cvq82yK0g7FHzjU6LFdDaSjJ
         7ikq3jbE9e6kgSDkMyvi7ZuUkA9OmlNElfquuLncdMZ3gBQ/kK8AegFJ4f8PbOVc7mh7
         BWLGsAv+YCN3q2D4jhjd2rtNpTV/21paSy2ilHzb7XHKVFvuly9oGZVAEOiFGQ1Dydre
         wD1Q==
X-Gm-Message-State: AOJu0YzUeY1MbdcsjkyBcSj9DIs4ek7wixnC209Ua7/Z7MiMDCqCCuGZ
	ufLdnpFYfeCMO7LMeFt3cfZeF0JcC3eULRDBVVLvXWQ3oOD2eX0M/3PPNw==
X-Google-Smtp-Source: AGHT+IG0HxOIaWBLAN6R2+Yvt7KgYwyKLIxqH/W8yXzyGTWSvwbRWI6w3uMxUkzuOgH5fJ/trfEM1g==
X-Received: by 2002:a17:90b:1a91:b0:2e2:c225:4729 with SMTP id 98e67ed59e1d1-2e9b0a3325emr11613569a91.8.1731184597060;
        Sat, 09 Nov 2024 12:36:37 -0800 (PST)
Received: from [172.17.0.2] ([52.157.4.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5c9af3sm5602219a12.31.2024.11.09.12.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 12:36:36 -0800 (PST)
Message-ID: <672fc7d4.630a0220.21b026.add5@mx.google.com>
Date: Sat, 09 Nov 2024 12:36:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2104582385856445657=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] transport: fix AVRCP volume in reconfigured transports
In-Reply-To: <9dc80086204f29041b29570575df9112c6988955.1731177363.git.pav@iki.fi>
References: <9dc80086204f29041b29570575df9112c6988955.1731177363.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2104582385856445657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=908094

---Test result---

Test Summary:
CheckPatch                    FAIL      0.51 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.70 seconds
BluezMake                     PASS      1658.88 seconds
MakeCheck                     PASS      12.87 seconds
MakeDistcheck                 PASS      179.41 seconds
CheckValgrind                 PASS      253.43 seconds
CheckSmatch                   PASS      356.85 seconds
bluezmakeextell               PASS      120.57 seconds
IncrementalBuild              PASS      1410.07 seconds
ScanBuild                     PASS      1002.89 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] transport: fix AVRCP volume in reconfigured transports
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '469a75ae182a', maybe rebased or not pulled?
#90: 
Fixes: 469a75ae182a ("sink: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle")

/github/workspace/src/src/13869699.patch total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13869699.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2104582385856445657==--
