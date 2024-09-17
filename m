Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE1200A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726572684; cv=none; b=Oq+tmaATP1H4dkif02uREstX7ppxV+5bD7DYWCOlddbUTuHBsp326qfdSpWlIB85wud/12wlJqkMHab2MYUmrkYnteKYR4xlh/HK5i7aYlkLmyzM1e9Zvzftt57gQUyB3eypE0KnjR25wHnbmoM9VFQ7G2p84deldwPtP/3eqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726572684; c=relaxed/simple;
	bh=66QgM/EACc6syaw9J6TlvF88SBLVQln80C+8D0CStfE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tz38gPYOq3XUxiA5YDPrwJKX86tuz0TOGlKC9kLCNvKOq9D497R473R5cEvS09IJQXzZrwEc2umvo6RCqUPSlCBaQ+puOlQKjHunOTF9XHDZdcWJO5EkcyBss+UhnSmV1uVy3QHSFAtgFyb8H1biIkvqV+xN/0toQC66oU6eSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlH4RNM2; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlH4RNM2"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e1da3677ca7so4476798276.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 04:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726572681; x=1727177481; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RpIg75GQT4pqfjczKDCdBD0wfBIRXnFW5K/e8zellcM=;
        b=XlH4RNM2/h6cOJn6GpC8R0mUuUquJ/S2kzlM/Xdgf96hkL+N0wM8Rw56JCmJpqYSrd
         0J89JKu0y1uL2ya1o9qW2HTRKY+OZRx9vK+Zo0J3xEv4f+6IQNLXfbeo5WPOaLz4a/mv
         FhyjI8IbWrOm6XbWisZx+1NfL7qgV9/qPcrCyVJUHVXuhL4osIgk4tuQIKBXUwSECMj9
         vG8BVa8fh31WGFNUVlLovAzf5+aotfLq6LhwgzRJjqe8BwvHgz/pHoTXpoyItWX1HRlx
         sSjO7s7iL7XPRxGKRafq1tQt1xIAvtiGVseSeX/cAWZT94dInQh+ub/q1lkgmiABSD5R
         LiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726572681; x=1727177481;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpIg75GQT4pqfjczKDCdBD0wfBIRXnFW5K/e8zellcM=;
        b=bCe7BqrL7kCG1uvncP7zTUNhiI/8rf8C3gSpEcsLK7OXVulrO7sF6wdSzwdYmA885P
         sBCG06upoK4TiwU8X6NcbmZtKKwPHGyVVcGJRb5KhLq189KMtDkGs//IzyLtrBmATSJq
         skxd45/QFpygfpUAsjLm7PktvHMBfKqG7yhfyb6S5dLSAyJHSBncNHszPikc77XFiI4W
         cAKfE5LeCHKGHJcGcAtoB9wI+k8EUmdf3jS7NrYMWrBpegFl7Y8P7PZYPcD6od6d7Q4l
         qDLqwBaWcSivXAVTgP1gYfkwpqnkoSJzuHL4+oU6vLO3UaxssvrJsSuCExmLGvh6iBTT
         qU2Q==
X-Gm-Message-State: AOJu0YxDH0Mz6+U/SY0sflkPh3LIwlv4ZYBHnCCSnogwpzvLQ8Pr5/SV
	1ZPpj1DjMv2Ek43zXdUmPEYXQXbT7Zus48yCQYRSxEEdmljGCsHKQnEcbg==
X-Google-Smtp-Source: AGHT+IFRnCPEiuSualKorbNzJpwpmYP3prKIhPheSCHqbWmQAyDO2pfmQjVHXOTL3Od0sAnhdlTBSg==
X-Received: by 2002:a05:6902:727:b0:e20:19b7:3bc1 with SMTP id 3f1490d57ef6-e2019b73dc1mr793420276.37.1726572681102;
        Tue, 17 Sep 2024 04:31:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.214.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c691ad9sm33121336d6.77.2024.09.17.04.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 04:31:20 -0700 (PDT)
Message-ID: <66e96888.0c0a0220.1cc49d.ba24@mx.google.com>
Date: Tue, 17 Sep 2024 04:31:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2749686421873092619=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Add BIP for AVRCP covert art OBEX client
In-Reply-To: <20240917074217.231677-2-frederic.danis@collabora.com>
References: <20240917074217.231677-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2749686421873092619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890843

---Test result---

Test Summary:
CheckPatch                    FAIL      3.73 seconds
GitLint                       FAIL      1.90 seconds
BuildEll                      PASS      25.04 seconds
BluezMake                     PASS      1673.62 seconds
MakeCheck                     PASS      13.15 seconds
MakeDistcheck                 PASS      191.11 seconds
CheckValgrind                 PASS      266.53 seconds
CheckSmatch                   PASS      360.24 seconds
bluezmakeextell               PASS      121.89 seconds
IncrementalBuild              PASS      7709.01 seconds
ScanBuild                     WARNING   1033.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,2/5] obexd: Add Properties to org.bluez.obex.Image
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#78: 
[2] https://github.com/enkait/Basic-Imaging-Profile-in-obexd/blob/gsoc_final/plugins/bip_util.c

/github/workspace/src/src/13805953.patch total: 0 errors, 1 warnings, 926 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13805953.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v4,2/5] obexd: Add Properties to org.bluez.obex.Image

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (95>80): "[2] https://github.com/enkait/Basic-Imaging-Profile-in-obexd/blob/gsoc_final/plugins/bip_util.c"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/avrcp.c:1942:2: warning: Value stored to 'operands' is never read
        operands += sizeof(*pdu);
        ^           ~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2749686421873092619==--
