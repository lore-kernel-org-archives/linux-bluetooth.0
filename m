Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350019E83E
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754329; cv=none; b=RNOTb/CHmRcCy19NIrDecGVSfvZTa0yr6M3tQsqDYExkOBp6x1wnWHqaJfZ42t85l2973rGBp9JPUO1dgPagccMQafcCIkw9fX12yfCXFaEv+O1KtrRk03iaM0263eJdnbICezePVoevCJEalj/Qp2F6879QCXG0VPhCxoX5QQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754329; c=relaxed/simple;
	bh=PJBk4wsomWJbtlAPJK2tBZQlLetzGg+uA1pb7cQbYr0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SMaU0QqT5f9wzZCcnD2XXKYS7bnLhqLAcKWpJpO09OdHsS0JojcKTFkFbic0Lq7b36+Jxmdcxx2YukhzzxnNsRQXL3Xy4vK3Dw1p5FnVkbJDy18R3Auhu+n/zgnGqlHOwkdfeNmdMZvKiQK2A2/8Yv9XV75REEaVFGC/xrjQXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R20PqHWW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R20PqHWW"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20688fbaeafso10571715ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726754327; x=1727359127; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M7zI09oC+GMogjtd/3dtx+FdUPTQI/DdHiB2vTyhLDM=;
        b=R20PqHWWij+xRYyujrWWC+YTJiOGMLKO7+BE+/eu8CDvZlwYBYtiST8E+TpF3nGGW1
         fpDNbE7wRCBWEMoJi0m3Hv8UV2bx+v7hInpr+qUu6vGifwv8uO9AzVAlmcuN4/VwL9Ad
         FPb3TJmZf9O5GT3jJkRCa4chdlTWdi92TfrGMhrA50HcJkg2uq8bUp0n1U5Zqx/ejqCq
         Cj7COZvTiqS68Fp9MQfr0+Kext2hq4DKg63SO9vTuek9NrtcgRUIk5u2qoKs/fo/oyKO
         FbxKwkGbKJ9GlF+PLK6S/YtW6t4WzNcmjZr5ybJjq3SYwzHKHCIgrjVZWEJk7gklyWRF
         3G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726754327; x=1727359127;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7zI09oC+GMogjtd/3dtx+FdUPTQI/DdHiB2vTyhLDM=;
        b=Tl5bi1d37WQUKfAy70o/zq3jkKOFu+u7+IOm5ypbhuBdC+NEHnHLkIJJIT9Pe4AbKI
         JWvKo7LNkYbwOvwNmZ1izKE97hgQlV2tROQxnoSu5Ltgy/tmg8+DWekb5BWQ7o51Zoy6
         weSqHazgry/8QxnjjC/uGRmBkyZWyYJ5SvBkKaFTTPfJKquiNtsaOphsdwQi/UxLzG1H
         98jVwLpxp6RwSBPDRUcTE1Kogy0RC+qitpkBMIepm2oy0sH2PnuV5imh1X8UKyyjlxjV
         3YHkdbLMRqLWscEb55cU+QR5kyquorLgh9t5knQMV8SxIJYA+q57ALueA2rdZQPV4aAQ
         Kjyw==
X-Gm-Message-State: AOJu0Yzv8tXdioi/mTai1uCz4aCifTAY1rXeMZNf90V39/GCzld5pL9J
	LLrLtF57V3AAS+e3nHqCoEZrDmshHjgpKIawLTd9ylz7oisFUdbS+schHg==
X-Google-Smtp-Source: AGHT+IHLl+a+BZ1whG690aESiws3iHWoQepKle6P/jQAMJ54eYtjuyGn0or//4/Wlvadd+dpQk460A==
X-Received: by 2002:a17:902:dad1:b0:205:8407:6321 with SMTP id d9443c01a7336-20781b4740dmr330010725ad.9.1726754326988;
        Thu, 19 Sep 2024 06:58:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.78.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794735719sm80184025ad.275.2024.09.19.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:58:46 -0700 (PDT)
Message-ID: <66ec2e16.170a0220.98932.081f@mx.google.com>
Date: Thu, 19 Sep 2024 06:58:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6249382569173557590=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ismael@iodev.co.uk
Subject: RE: [v3] Replace the usage of non-standard GNU-basename with strrchr
In-Reply-To: <20240919120252.25086-2-ismael@iodev.co.uk>
References: <20240919120252.25086-2-ismael@iodev.co.uk>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6249382569173557590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=891413

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
GitLint                       FAIL      0.47 seconds
BuildEll                      PASS      25.70 seconds
BluezMake                     PASS      1722.67 seconds
MakeCheck                     PASS      12.84 seconds
MakeDistcheck                 PASS      192.27 seconds
CheckValgrind                 PASS      266.30 seconds
CheckSmatch                   WARNING   368.16 seconds
bluezmakeextell               PASS      120.80 seconds
IncrementalBuild              PASS      1505.35 seconds
ScanBuild                     PASS      1041.61 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Replace the usage of non-standard GNU-basename with strrchr
ERROR:TRAILING_WHITESPACE: trailing whitespace
#103: FILE: tools/hex2hcd.c:307:
+^I^I$

/github/workspace/src/src/13807662.patch total: 1 errors, 0 warnings, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13807662.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Replace the usage of non-standard GNU-basename with strrchr

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:136:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============6249382569173557590==--
