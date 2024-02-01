Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14A3F8C2
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824284; cv=none; b=fP2X/uwKmg2sUlP2Nwud26LU9wlqcN3J6mXDSbStKd40+ToEqEWXVonfxPjdvG7NhdN8uXZIuitYga8CVfhREfTYuqzLSx0vjpeGTyIe7f+4859ylCXn2hYLlYj+HyMN8Dk+EcajePI52P8Q0ktUPQz95ulxN1WKZF5Gp1Vtkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824284; c=relaxed/simple;
	bh=hiTAOb2eNlbSCGZLOv3f4bPfZX6oXOzrqqCgwxnYd3w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MFRQUHf2MM+AT+D7uLS4A/Ar8UoeBSB20+2YoWRFzMJ4PxtY+fCZ2AiTvOuB7hx6cIa/+SZp9rQy/Ornxs4ZUOPPlx6t2y1Yg4/fT2XAAF/1AJ+rFvsCTHqDDdqwtBh0hH9GKIdHsEFmFTPw2XoGAJ6OZoGO8NAFKbS4N1QsGws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJS5bR7F; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJS5bR7F"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a8a398cb2so10297481cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 13:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706824281; x=1707429081; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B2nXD7MSxfJhHXdex9mLnKvNd1QJjuxvahLHy1v7kd0=;
        b=WJS5bR7FG7xMvFVGVWE4xylLvQx4NQtEQXL+FfOU+O1bGumWyL3753OaOzgTFPec47
         evIrfS/zNbiceAW0nPHZwVGZ/jH4QHjSX3CBSl/WhAmO9xSjLZ2/LRI0c4qrzd95jY9n
         9NYqDRVUU6vulQl7KPguhP7OqliRZ+LBk2zq88TkCpmsnf6ErIRTiO8cCSCNvy67ioaf
         VmlZSP6egMhB1CeaVeWLqDmx8+r1MqgTAsewCI0CB2upioxQkhDFWp1kp44kEsokAZHV
         gR/GQec2zREpIW05KEu9ym4CGUYa7CuKGI4UABUzUbWmAR0Ml/4IO9Qr319ve+s4vS9P
         mapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824281; x=1707429081;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2nXD7MSxfJhHXdex9mLnKvNd1QJjuxvahLHy1v7kd0=;
        b=cQ368AgbNOxrUj5SVR6PIvY+6UmKCmBnr7Vy0Pwnaid35Ks8ZU25msQSIQeX/9YX2G
         udHvM2yvsNn1NOSgbfFcIs6NLQ9UqTS5n6Jf9wFCJYmGmDiE+ImwnkzmBwC3QIkW5sIi
         BrRzihotS9DDhSdVAjMJJumCqV68bMJZr5RPS0blWGAdwEku8CdYn0F6jdHb4MiBwKDh
         apFULco/e4iRwLypVeASCcwEm6pShnUlAD+clTJNylDgerM9Qx5JKPwA1101OVNf+22e
         gkIZFTH/uArGQBxU/ZpHXwX+WV8zmvtZ+QEQn7tSkmjwaMk5ybc4+uaxZj+26DgLPxkI
         mK4A==
X-Gm-Message-State: AOJu0YxzELHPoD7JhYVW6kc5l6IrfuZ5zqaAo8xaXlnXI2Or2H5S3vDe
	+qDhBNZ024XSrQOvxoXJLt7KeGJxTyrX9V/s+LTxYJoJfvBtKWELDwXRr9tb
X-Google-Smtp-Source: AGHT+IFwjqBm+n5bEJxzuedWfy85PFdqnb2gFlqRY21cqU8LNzIgsOVb7E0w8KmQ9ogr06byoUfbxA==
X-Received: by 2002:ac8:5816:0:b0:42b:f088:14ce with SMTP id g22-20020ac85816000000b0042bf08814cemr217110qtg.10.1706824281036;
        Thu, 01 Feb 2024 13:51:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYoFlB4BB+50njvZqE3ggU+c3poQfdq0sz7uYgMdSy9BdnEN5uHimndGtZa1sIJ2wODU8chRAEhGM2y9FAOZzwQyxY+w==
Received: from [172.17.0.2] ([172.183.138.56])
        by smtp.gmail.com with ESMTPSA id e7-20020ac81307000000b0042a729d17dcsm166273qtj.86.2024.02.01.13.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:51:20 -0800 (PST)
Message-ID: <65bc1258.c80a0220.61618.1827@mx.google.com>
Date: Thu, 01 Feb 2024 13:51:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0526472480301847233=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/8] client/mgmt: Add missing settings strings
In-Reply-To: <20240201191016.1122194-1-luiz.dentz@gmail.com>
References: <20240201191016.1122194-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0526472480301847233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822251

---Test result---

Test Summary:
CheckPatch                    FAIL      3.56 seconds
GitLint                       FAIL      2.70 seconds
BuildEll                      PASS      24.43 seconds
BluezMake                     PASS      722.71 seconds
MakeCheck                     PASS      11.91 seconds
MakeDistcheck                 PASS      166.66 seconds
CheckValgrind                 PASS      230.68 seconds
CheckSmatch                   PASS      336.62 seconds
bluezmakeextell               PASS      109.02 seconds
IncrementalBuild              PASS      5507.46 seconds
ScanBuild                     PASS      954.89 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,5/8] bap: Fix crash when a broadcast strean setup is pending
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#103: 
bluetoothd[37]: #1  g_logv+0x270 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557e3120]

/github/workspace/src/src/13541679.patch total: 0 errors, 1 warnings, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13541679.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,5/8] bap: Fix crash when a broadcast strean setup is pending

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


--===============0526472480301847233==--
