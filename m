Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88F83A14
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953443; cv=none; b=LQwm5yZf2GLG0NFkxAGC51a411p7TQoi46zfvA3ncxj36daILrNs2ZbrnR0T0LPz30/tRgA9Jus7lM02T2XVb5Z59OxTwJ2dRV4ga0sgy7qrzB/O7cCDm3a4OD83WLC2S+lMpRIQFfWcctolzTHus+F2fer9Zi3pDp3G+Y7/u14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953443; c=relaxed/simple;
	bh=MOZwDxqh9itO3CktVGzNpNXi9uGTVErXg9dEFwHtfJQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HR8gzebNF9n6F3D74k0P7jnvY9w+EyUY11rrw6P0sFHHq62oFN7dwlrGSd/ITcjztNDl2oOEKt8g9m1l/bHr3SDf1UTip/OpkFbu1cPmB+s7H6/CQ1Lg4cU0lb3DfJ7y/RhKKJ3x+Vtznixp7oZ7xRPFxLxDAYF8gEfEivtZVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3VjAwqO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3VjAwqO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70623ec42c2so1330514b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718953441; x=1719558241; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0h9q/tZcdMqON/e57hw377MNL2znEQ6Ah9EiB1uY1UY=;
        b=W3VjAwqOYH5oc1iUVqS76VD57sGkHN2lCIrV4UMBpdj5rCsED+PLHNb5GbZ3/cMj7/
         tF2tJtSyGegcIx+jvbBd4aw3zT5k5DXEpcX8tyaYpW4PYUiBROg2iOCJ/3RLhcoYRllz
         c9Q7WQtw/ZRvuCrY1VJzITepEQuxPrZPO+RC5y/JiUyTR4JVHpVt2TQEkDdytxFSAREt
         kVup2uhg5GtLHlwd12Vze7MEU5/fzCq6ESn2jdii1jM7ReVXEuevwuztHnDgxvtN7jjW
         HnTataFgUdSHV62aY95AQUfPxYe98h6UXiP4LeMTifPwK0AJ1Hw697oyL3b5HaH+W+QT
         Xgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718953441; x=1719558241;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0h9q/tZcdMqON/e57hw377MNL2znEQ6Ah9EiB1uY1UY=;
        b=ggXhAGG1pVBM613eap8iPuXLpIr7HGzt6GQsT9uat84VC4mUo7vq9mUp1FjPXyVq+H
         LaTUzLq/CJWqoh2TPYEMrCr/du/4PosaOcyfNcn2Y/bmKFNsIIhNa5AfCnF2dWiAzcD7
         B7uE2p4UhvKyoWCOws+cDV1pmvdY4w59KRRWLUCC+HOGogDTiu1g8kWMcacl0rRdedpQ
         cmFmPOVhkfc7Fl+RqBxigvctIDkXGcXLaW8lueHwM+KkzEfwpiP2AINuw+cOMzYgJUNo
         oLk/YQs2QTxtEQXIXlpU4Drw93aQ72HmTbF3yQ5O3DVj7dJhLV/eD3J+1QYsiyH+ZdCD
         LOuA==
X-Gm-Message-State: AOJu0Yz3uOQ0zlpcWFYs3F8i6Dfj0oHqDd8h3j1wc7LO4YYjnv7c1lWb
	gAc4CU8p8v1a3gndmU7gyYgD0UZD+k7IXV2goDb40kLpTyfhySoJwILIwg==
X-Google-Smtp-Source: AGHT+IFnfSbAL0s6BPwafkGU4b5mdb5JocTOpFpcqTsqT9+98Fh7yUyjLAE99Lv0dvnO+CfI4bZ68Q==
X-Received: by 2002:a05:6a20:1590:b0:1af:f50f:cbe5 with SMTP id adf61e73a8af0-1bcaafe3fd3mr15898401637.8.1718953440875;
        Fri, 21 Jun 2024 00:04:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb22d364sm567958a12.87.2024.06.21.00.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 00:04:00 -0700 (PDT)
Message-ID: <667525e0.630a0220.810c8.1584@mx.google.com>
Date: Fri, 21 Jun 2024 00:04:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0603197322840567234=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sarveshwar.bajaj@nxp.com
Subject: RE: shared/util: Fix null pointer dereference in util_ltv_foreach()
In-Reply-To: <20240621053404.13984-2-sarveshwar.bajaj@nxp.com>
References: <20240621053404.13984-2-sarveshwar.bajaj@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0603197322840567234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=864134

---Test result---

Test Summary:
CheckPatch                    FAIL      1.42 seconds
GitLint                       FAIL      0.46 seconds
BuildEll                      PASS      24.68 seconds
BluezMake                     PASS      1661.48 seconds
MakeCheck                     PASS      12.99 seconds
MakeDistcheck                 PASS      181.61 seconds
CheckValgrind                 PASS      254.75 seconds
CheckSmatch                   PASS      357.37 seconds
bluezmakeextell               PASS      120.74 seconds
IncrementalBuild              PASS      1455.15 seconds
ScanBuild                     PASS      1083.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/1] shared/util: Fix null pointer dereference in util_ltv_foreach()
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#116: 
To address this issue added explicit checks for data at the beginning of the

/github/workspace/src/src/13706854.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13706854.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/1] shared/util: Fix null pointer dereference in util_ltv_foreach()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (97>80): "    #7 0x71d33511bc43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)"
26: B1 Line exceeds max length (89>80): "    #9 0x71d33511b2b2 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)"
28: B1 Line exceeds max length (83>80): "    #11 0x5631fc7397b6 in mainloop_run_with_signal src/shared/mainloop-notify.c:189"
30: B1 Line exceeds max length (90>80): "    #13 0x71d334429d8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58"


---
Regards,
Linux Bluetooth


--===============0603197322840567234==--
