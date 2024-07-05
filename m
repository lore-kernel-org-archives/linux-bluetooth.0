Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577A148FF7
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176101; cv=none; b=L4deDEw4/XMn21fSsc4+akx3GA4dBAsI8sW/3oX4g0NednMTI9cfaKgub9PrfNtpEpXAsq7drhw9Zf3lGniIa5jyaAWSqvKNKUbrqVzJzi4cO8jvXZ/4I4nSs2OSGuQMGU1fztcF3RU+5LztIfHFW8UIOBCrVPBX8BrDCkN+hHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176101; c=relaxed/simple;
	bh=OPvD2BjLIC91RxQvxlsasYxQZrcG3Rkyo26U+37/+PA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L4hggluuDQHM5ak1nqQDU4UwmeGPfcFPEo1MfzRfgq7yzrXmh5jeBWYhqknrz4AvNHqX8gws4TkjGCXSkvP5kWTjRCa9TaKRH3LYuw3u61zciNuV8pKMU/UsnteFq8VK0Z+IG0BB/uBeLWaJLZxrM+zRg9hMddXzu3+amAn0ZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQvJLdkP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQvJLdkP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb3e9e32ffso6241905ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 03:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176099; x=1720780899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JhHWAElPpkRTVgFy5wlbfnSPuyzDVV/+VtLsrc6ZwRw=;
        b=XQvJLdkPml4/BqY8jbUMvkoRUYwhOAcHHpZheglDhMznO5yDIFxj1sD+aIf66ITeAM
         1lTRtxG1HL6lR3fImZ5SbUCRDDYMTat+GAFz7N1sc2KYY/UrNEZebdZaf/6OXl6hMSw5
         66gmQsHbaAT0V0JQqkrQLqzQTSAvhAZefDMFHVslW2oFgW68Fsd9gGFk9ZVl2IK+EF6J
         93+8tEnLt+qiSsFFeixjRPWzTkQUJIDLHi2gUTOCnJvuAYiCQidDxZS9eIiMVjX80XvT
         pUyXVxq1R2ZRg8+2796LmHC1FW6MNP6YsbAP0+TJc4LG8zWcgMsjGYgO5kOybjxwb38X
         Mx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176099; x=1720780899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhHWAElPpkRTVgFy5wlbfnSPuyzDVV/+VtLsrc6ZwRw=;
        b=nMKTFCquAQVPoXYA/lwFIVl/QHg5g0J5tqpKiWNWSCSRp7o7mi7Cn3IQIqWaN9gh10
         qgTx0tkm4SClKtLyxCO9fFYu+fO5bKS8lMt9FxTyRiizr4jTCW7IfxRCn021FiZqE5Dg
         oCSf0e/GSvEsWoOBF/Ts+ZKxw6pRs4At7WGHaYeyJMI2ETGL3Wr2+nWGYrF3HtJJMUup
         z4lUj0/SeQ5rJrIBzrO76sUiU5JzHWmSR/ohKifbTQ0ppQH1oOBWARRJdfQU46stppA8
         0vBmbzRvDp458cUmvgJVwpmHMmyaWU53ODae30k2MnxbZ9rCmMN1kmEUTJcb9n2/m46g
         f/RA==
X-Gm-Message-State: AOJu0YxafO3VnAxmusKoJJM5u4avqEEemz4GD+SjdBSIdAQ5p+BLLLLN
	uB+RIl6nlT0L19jsOiS7iX43y6pJjafG+HdyInz2bI2pLB2P2ElR+8s+UQ==
X-Google-Smtp-Source: AGHT+IGeSD/dguKNX7xW+R9hIE6F36yuTTqUMLJblB8YMVnqNS6eGoYnzUM2pSg2CI2ISY5QTEIu3Q==
X-Received: by 2002:a17:902:f693:b0:1f9:f217:83d with SMTP id d9443c01a7336-1fb33e1639cmr36423715ad.2.1720176098858;
        Fri, 05 Jul 2024 03:41:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.27.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb167dd71esm49696175ad.238.2024.07.05.03.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:41:38 -0700 (PDT)
Message-ID: <6687cde2.170a0220.5c11b.fea5@mx.google.com>
Date: Fri, 05 Jul 2024 03:41:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7573835314581750782=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gudni.m.g@gmail.com
Subject: RE: [BlueZ] configure.ac: Fix --disable-cups
In-Reply-To: <20240705084216.552838-1-gudni.m.g@gmail.com>
References: <20240705084216.552838-1-gudni.m.g@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7573835314581750782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868696

---Test result---

Test Summary:
CheckPatch                    FAIL      0.47 seconds
GitLint                       FAIL      0.42 seconds
BuildEll                      PASS      24.45 seconds
BluezMake                     PASS      1678.89 seconds
MakeCheck                     PASS      13.38 seconds
MakeDistcheck                 PASS      176.21 seconds
CheckValgrind                 PASS      250.49 seconds
CheckSmatch                   PASS      352.15 seconds
bluezmakeextell               PASS      118.63 seconds
IncrementalBuild              PASS      1428.30 seconds
ScanBuild                     PASS      988.91 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] configure.ac: Fix --disable-cups
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#97: 
https://lore.kernel.org/linux-bluetooth/20240416052603.4373-2-polynomial-c@gmx.de/

/github/workspace/src/src/13724551.patch total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13724551.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] configure.ac: Fix --disable-cups

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (82>80): "https://lore.kernel.org/linux-bluetooth/20240416052603.4373-2-polynomial-c@gmx.de/"


---
Regards,
Linux Bluetooth


--===============7573835314581750782==--
