Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E11527B5
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605646; cv=none; b=VszkMGhGfW4KFNij4KC1zuzKKAuvkUP9BcFw361CWWh5a3xOG+u6ylueSujtxpU67HgT5KPxEqdSxqLDmaCLGTeO3JH5NNB5N/9DhzMkHmfWkH3Hgg0jQSMO+NZ/0qVHCnAnAQUFUuczfnC9r+DFGZJ3pWnAv/32OxhVSwe3kg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605646; c=relaxed/simple;
	bh=M3PPVVDAIC2pNkMAsdkjJfALps4mCN2Mk5yvdm6pJQY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bFFahAwCJG/B4uGimXKaTCiVVd1Q8lcYCTNNjtCFGwZR/UwPkjuWonXnVNa/6HQJjKcKcsJ3P/o492IFbTuRXGwH4Md+a3L2FOkBsXkklkUdkg/ZUnDXpd4mZYS66LfiwUfGjlpEYHlqRfbl00Pb8xmovAQPEqbQ9CmSyrFFibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWGd6dhA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWGd6dhA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47f07acd3so621345ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jun 2024 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717605644; x=1718210444; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EP37Bi9FBxaJLC/sX2kMIpkhBgTIlwLQ/zPsQbwqMWI=;
        b=NWGd6dhAyaoLPw8Sl45XH3FV9cgET2QHwbpAE1eu9Nu2Jv2WwDvdjPlOUy3i8urqlX
         FC4UIem1987epCY9E31kOlrTZrJQfKxsV3edCwLzpWmx3k62orIjd4HiyHb9PUPt6Usy
         okmw/RFVUwoIW8FUBAFRWg302Rjt7XgNsFsWfXG0G5U0WdhuAYfKjEEXFgwxSxGx63Qt
         nT8NjJCsA3fwfr2S1elQ2zJGoXyA0Y83ru+cKKgPmX62OwqT1Np6/MJEfH40ciVtT8OD
         go/aUWUynlJAWY6zgJpqWkrKBqUiCewGucXhZ3pcWkz9X93JomvPZ4/Ag/DNkttjwUm4
         fw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717605644; x=1718210444;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EP37Bi9FBxaJLC/sX2kMIpkhBgTIlwLQ/zPsQbwqMWI=;
        b=CCHEemHdDwyBEf1BCvFg9qmadu4m9p7PatROWjA6nNTOUX5+8J04wRuLU4C45nsEeZ
         WS44ADZdctVhN13jxvcyTUfV8qdZOr4+bH5ir7etIU8FZhkVpVKPBPZLhFFxnAf59+Fv
         KHBUv+495VCEBIcjgRfF/8YVZb8UPvugyI77bhsXzssOEnY68/nCBkfvzsz1Ms1HAdXq
         Gxl/695aNUHPxNj7oZvX0UIJhvT+ARZEJZx0CcBw2ZLcoK+3ppcXzYCBSC4g/fSwRqT5
         TBt5H0ygrscYvrW5+7jpYjXTMrpcAJ4HWneroU4X488e9b+w/+XYCN40DpbJzSCd2cUe
         teqg==
X-Gm-Message-State: AOJu0YwiTWANtO4E4IanRgXwoR/y7VGLYZiViy0on8P5g6h4UVdfLClm
	+t3RGDqnE7PDy2g3LoeJp5kudiE6eqZ75+nlSlss5i9F6hOYkmZp8CVABA==
X-Google-Smtp-Source: AGHT+IG0XnwQckSK47X6FVA2Q4ub3ts9GBvL/CQbQRGEsYVr0xbJml8ZS+GSk/4XjSUpZHuERsj68w==
X-Received: by 2002:a17:903:41d1:b0:1f6:344a:4915 with SMTP id d9443c01a7336-1f6a5a0526dmr38427865ad.6.1717605643909;
        Wed, 05 Jun 2024 09:40:43 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.99.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241f3e4sm104803905ad.306.2024.06.05.09.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:40:43 -0700 (PDT)
Message-ID: <6660950b.170a0220.36c52b.cb0a@mx.google.com>
Date: Wed, 05 Jun 2024 09:40:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6375498472085704892=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] Revert "adapter: add support for setting POLL_ERRQUEUE experimental feature"
In-Reply-To: <20240605143920.498159-1-luiz.dentz@gmail.com>
References: <20240605143920.498159-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6375498472085704892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859116

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
GitLint                       FAIL      0.54 seconds
BuildEll                      PASS      24.78 seconds
BluezMake                     PASS      1693.15 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      177.19 seconds
CheckValgrind                 PASS      251.24 seconds
CheckSmatch                   PASS      352.67 seconds
bluezmakeextell               PASS      119.47 seconds
IncrementalBuild              PASS      1472.06 seconds
ScanBuild                     PASS      999.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] Revert "adapter: add support for setting POLL_ERRQUEUE experimental feature"
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e1c178f96a07fc43ad7523fdd4c93967843e4f60', maybe rebased or not pulled?
#92: 
This reverts commit e1c178f96a07fc43ad7523fdd4c93967843e4f60 as the

/github/workspace/src/src/13687020.patch total: 0 errors, 1 warnings, 126 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13687020.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] Revert "adapter: add support for setting POLL_ERRQUEUE experimental feature"

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[BlueZ,v1] Revert "adapter: add support for setting POLL_ERRQUEUE experimental feature""


---
Regards,
Linux Bluetooth


--===============6375498472085704892==--
