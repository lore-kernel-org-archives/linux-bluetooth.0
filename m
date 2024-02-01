Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D97C6FD
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810228; cv=none; b=kPG1SKLG0izufPQQM/ZVFOfSxz5aYsee11SRAnjhbn+i7trcBs1Hcu3eXQtkeEj5l8ztvUyj+eC23vHhnI5Oh3KQu/nUZ0cYpNH2vxDIf0Jlb7/gYM89ph+55o06fUvVrzrjQPRTK4ZzQOTeKrmzV6Pl0/qUs+DlbdRw3oSj2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810228; c=relaxed/simple;
	bh=lofBoL+sK4uZ65V5lvbTzYYRoR5KULvIypgZ3uJwY2c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=anXXEks+vZfCIGQiqY+0ZRWguuec6+AvTwYehi9iIrK+12R6FChnKHMdKQ/09Y/QsSLL7qsRws8vQd2eBwB/+0KuTNIYhNhD+AgauamgyvDIPlYuDUmvYuI6Mmg+aabwlVvr+PtP+9b/62tIghym64IHI7WpzP6wGK2y/FkDg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esQvoVf/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esQvoVf/"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783fa618997so77475985a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706810225; x=1707415025; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WUaewubviXXLXjFY0ycGFKtleufK45WGsqE4utp3PV8=;
        b=esQvoVf/3TM8uSxEzKCX5b5gi3wumJw75qoZNl2UkWFOk2c08zDzHm4Ib7H0eqncXM
         RXyt9TN1gRpPGcTsT5LaCnqEB0TQyxZLP0qXcZmSLhcFrRkAEraMyQJ2+5e28XRQqQxE
         Y8f7ujNqbxE9xXoi4BPOv2ycs1YNk6yGAPwnjgVHEf1/8oM0GRT1zNqs5OPqNNA5YNil
         WJw2/esULDoY+A68oSpX0LUyq9ji0bhID0nazjq934TCHHxtvzf507d4po6fO8Gq57BV
         qNI5/0kD810hYHZVsVau+eZ1S9N8E9eLdHOyBVrgjRiaiQ0MINbg13U5XGLG7J/1FC8h
         whag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810225; x=1707415025;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUaewubviXXLXjFY0ycGFKtleufK45WGsqE4utp3PV8=;
        b=PM/diPaWahQlfgE/QyyMtXRFV0LSNhW5AtgEfF06OV9TGM0wjbLdCPR+9LiDBvG4+8
         Ymwxe7rqeBBrzKYlnv+tioDv+epNiHXJRGFTGv5Ikzv8b6p4RtJ3IUDHDSi+4lKBdZQ3
         TEp/Z08BbrvpfyZm3ExK8WzPogUk6Mlqp4wrsCFY2pYHOz2ZgWQG6lsP2s8403Zvwtpk
         tXv+lN85D5gVxfsDcTunu1CxbHZQVPG9wX0o7JftVLL0y7fplrU4ytX1l6JV1XOk7oWs
         AHfQkHcyAY/+wbP9q5t6g4xPpjU1QfD7gs/L0BPiT6WlUKDh6V01cl6kEHzR45wvwcuE
         CgXA==
X-Gm-Message-State: AOJu0Yyrn8GP7TlI/jzj5BPpVaCR5zDMgx/egxw/Z0PlTtf82XBKPQKU
	keiu9oVi1VxglTm3W6F57FJYU1bXVaEYXFm+M8UJ3W8jFfDv5Rmge1vEzGO3
X-Google-Smtp-Source: AGHT+IE2G1Vi4SpJgPFeSsqtwktdFKVMh0Cjy0N65N8146cshcDvugeAXbi6YmawGciGClHnAEyFDg==
X-Received: by 2002:a05:620a:cca:b0:783:4037:1923 with SMTP id b10-20020a05620a0cca00b0078340371923mr3156646qkj.64.1706810225576;
        Thu, 01 Feb 2024 09:57:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUg3HYzHFsV+Opz9pn8I4cWT/t9KVTJ/Ry6jh9pOwuTDrBeBkOp8J9wXKEed7pK17py++20EfRy2V+7iv+Id6/XYh1ypA==
Received: from [172.17.0.2] ([172.183.138.51])
        by smtp.gmail.com with ESMTPSA id vr7-20020a05620a55a700b00783f388ff13sm15676qkn.56.2024.02.01.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:57:05 -0800 (PST)
Message-ID: <65bbdb71.050a0220.66677.0273@mx.google.com>
Date: Thu, 01 Feb 2024 09:57:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6219259767733435950=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/5] client/mgmt: Add missing settings strings
In-Reply-To: <20240201153820.1016507-1-luiz.dentz@gmail.com>
References: <20240201153820.1016507-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6219259767733435950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822175

---Test result---

Test Summary:
CheckPatch                    FAIL      2.10 seconds
GitLint                       FAIL      1.59 seconds
BuildEll                      PASS      24.53 seconds
BluezMake                     PASS      727.18 seconds
MakeCheck                     PASS      12.04 seconds
MakeDistcheck                 PASS      169.39 seconds
CheckValgrind                 PASS      230.74 seconds
CheckSmatch                   PASS      328.80 seconds
bluezmakeextell               PASS      106.74 seconds
IncrementalBuild              PASS      3472.31 seconds
ScanBuild                     PASS      942.95 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,5/5] bap: Fix crash when a broadcast strean setup is pending
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#103: 
bluetoothd[37]: #1  g_logv+0x270 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557e3120]

/github/workspace/src/src/13541290.patch total: 0 errors, 1 warnings, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13541290.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,5/5] bap: Fix crash when a broadcast strean setup is pending

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (86>80): "bluetoothd[37]: #1  g_logv+0x270 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557e3120]"
12: B1 Line exceeds max length (84>80): "bluetoothd[37]: #2  g_log+0x93 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557e3403]"
13: B1 Line exceeds max length (108>80): "bluetoothd[37]: #3  g_io_channel_error_from_errno+0x4a (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557cd9da]"
14: B1 Line exceeds max length (94>80): "bluetoothd[37]: #4  g_io_unix_close+0x53 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb55839d53]"
15: B1 Line exceeds max length (101>80): "bluetoothd[37]: #5  g_io_channel_shutdown+0x10f (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557cdf7f]"
16: B1 Line exceeds max length (97>80): "bluetoothd[37]: #6  g_io_channel_unref+0x39 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557ce1e9]"
17: B1 Line exceeds max length (103>80): "bluetoothd[37]: #7  g_source_unref_internal+0x24f (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557db79f]"
18: B1 Line exceeds max length (103>80): "bluetoothd[37]: #8  g_main_context_dispatch+0x288 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557dd638]"
19: B1 Line exceeds max length (109>80): "bluetoothd[37]: #9  g_main_context_iterate.isra.0+0x318 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb5583b6b8]"
20: B1 Line exceeds max length (94>80): "bluetoothd[37]: #10 g_main_loop_run+0x7f (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557dcaff]"
22: B1 Line exceeds max length (96>80): "bluetoothd[37]: #12 mainloop_run_with_signal+0x128 (src/shared/mainloop-notify.c:190) [0x663368]"
24: B1 Line exceeds max length (87>80): "bluetoothd[37]: #14 __libc_start_call_main+0x7a (/usr/lib64/libc.so.6) [0x7feb54e1fb8a]"
25: B1 Line exceeds max length (94>80): "bluetoothd[37]: #15 __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6) [0x7feb54e1fc4b]"


---
Regards,
Linux Bluetooth


--===============6219259767733435950==--
