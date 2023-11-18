Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw9PYT6e"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA9C5
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Nov 2023 08:34:27 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-677fba00a49so4538026d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Nov 2023 08:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700325266; x=1700930066; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uJxk6KO9o6QfrCNCFh11TB9aiRtMtuN4S9gMVN5d19A=;
        b=lw9PYT6eUacTyKm72QJf1ywqq1mdd+8Xpqz4hA2ozVlwEdioF7Spa7sUFpfAjbKVKd
         gYlmIRsuZyUE4qu9t0ldkoMAX0+NtZxC+ubYi0Lp+zLHhJsWBsJyT8w8A1C8ZJ42mZwv
         OQC5TLyJ5MJlfLAzCNSiMvFvqJbKqiweEotvlhQpyt9gGjnch8YCBobtZBm2AlYhwGFq
         9+MUbhiTyi2fSYp+2oSedz//rDyWb/6JfL/BuAwrDNHKerkENv/DkZTwFS1eyoFM7MFQ
         AspTEI4geIp9/RS6F6b0kb0C37Iqpd3F1p05Nwca9op+JPur1timKGMP/MAgYlIRH9UL
         hMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700325266; x=1700930066;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJxk6KO9o6QfrCNCFh11TB9aiRtMtuN4S9gMVN5d19A=;
        b=TQ397RTjh3ap5VOie7vznmnF79tXma3xhBzyYFvf9a7Xv4nSvQ6KU1dAROVVpN5kIN
         gAme6StEImspSu6AvynF6iW8MqppTqV8qp5Dk/OO6RR4IMDs7r2MtN1iLj9FUVEVVZYM
         xXWAZU1S7rG18yavO+brX11AZGrjTlZpa7ZVFpcdHMvzQNV9uamraRGhJBfFleOI3OmE
         4lGjnNCV4/rDY+FuQDoblr5vEQK7I3Gb6805yDx9mUcsgPXl3pQbTT1LOna0kkG33/Zp
         A5tB8w8inwQJyLDYDXXS6c/ZZo/bmNiNC8tDqgV7ectUsT1iRNb7jYRnfgjg/uLcUVig
         akJg==
X-Gm-Message-State: AOJu0YxnzyE2OTEKSZKPbkPyaDSoo21hQRWz/t2JqNJAWa9gCg8xqTlR
	ebliuSlReNPBpC24PIXYcBd0wBa0zGtjDA==
X-Google-Smtp-Source: AGHT+IG6Bn6o/MzcqD4vu3DiRWDAgkk18zpwX6wqWF8KaSbBu8VWEPycQmJLeCO/p6ehFuM6gRaN8g==
X-Received: by 2002:ad4:558a:0:b0:66d:2d80:800 with SMTP id f10-20020ad4558a000000b0066d2d800800mr12500524qvx.7.1700325265839;
        Sat, 18 Nov 2023 08:34:25 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.65])
        by smtp.gmail.com with ESMTPSA id qd24-20020ad44818000000b0065b21b232bfsm1483170qvb.138.2023.11.18.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 08:34:25 -0800 (PST)
Message-ID: <6558e791.d40a0220.a6a05.6fd2@mx.google.com>
Date: Sat, 18 Nov 2023 08:34:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1406089292867950575=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yury.norov@gmail.com
Subject: RE: biops: add atomig find_bit() operations
In-Reply-To: <20231118155105.25678-2-yury.norov@gmail.com>
References: <20231118155105.25678-2-yury.norov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1406089292867950575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=802169

---Test result---

Test Summary:
CheckPatch                    FAIL      2.01 seconds
GitLint                       FAIL      0.82 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      27.26 seconds
CheckAllWarning               PASS      30.11 seconds
CheckSparse                   PASS      35.59 seconds
CheckSmatch                   PASS      98.12 seconds
BuildKernel32                 PASS      26.55 seconds
TestRunnerSetup               PASS      413.64 seconds
TestRunner_l2cap-tester       PASS      22.93 seconds
TestRunner_iso-tester         PASS      40.07 seconds
TestRunner_bnep-tester        PASS      6.98 seconds
TestRunner_mgmt-tester        PASS      160.00 seconds
TestRunner_rfcomm-tester      PASS      10.93 seconds
TestRunner_sco-tester         PASS      14.47 seconds
TestRunner_ioctl-tester       PASS      12.11 seconds
TestRunner_mesh-tester        PASS      8.92 seconds
TestRunner_smp-tester         PASS      9.74 seconds
TestRunner_userchan-tester    PASS      7.23 seconds
IncrementalBuild              PASS      29.81 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[01/34] lib/find: add atomic find_bit() primitives
WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#266: FILE: include/linux/find.h:35:
+unsigned long _find_and_set_bit(volatile unsigned long *addr, unsigned long nbits);

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#267: FILE: include/linux/find.h:36:
+unsigned long _find_and_set_next_bit(volatile unsigned long *addr, unsigned long nbits,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#269: FILE: include/linux/find.h:38:
+unsigned long _find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits);

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#270: FILE: include/linux/find.h:39:
+unsigned long _find_and_set_next_bit_lock(volatile unsigned long *addr, unsigned long nbits,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#272: FILE: include/linux/find.h:41:
+unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits);

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#273: FILE: include/linux/find.h:42:
+unsigned long _find_and_clear_next_bit(volatile unsigned long *addr, unsigned long nbits,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#300: FILE: include/linux/find.h:490:
+unsigned long find_and_set_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#337: FILE: include/linux/find.h:527:
+unsigned long find_and_set_next_bit(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#366: FILE: include/linux/find.h:556:
+unsigned long find_and_set_bit_wrap(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#395: FILE: include/linux/find.h:585:
+unsigned long find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#431: FILE: include/linux/find.h:621:
+unsigned long find_and_set_next_bit_lock(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#461: FILE: include/linux/find.h:651:
+unsigned long find_and_set_bit_wrap_lock(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#489: FILE: include/linux/find.h:679:
+static inline unsigned long find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#525: FILE: include/linux/find.h:715:
+unsigned long find_and_clear_next_bit(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#580: FILE: lib/find_bit.c:119:
+unsigned long _find_and_set_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#594: FILE: lib/find_bit.c:133:
+unsigned long _find_and_set_next_bit(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#609: FILE: lib/find_bit.c:148:
+unsigned long _find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#623: FILE: lib/find_bit.c:162:
+unsigned long _find_and_set_next_bit_lock(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#638: FILE: lib/find_bit.c:177:
+unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#652: FILE: lib/find_bit.c:191:
+unsigned long _find_and_clear_next_bit(volatile unsigned long *addr,

total: 0 errors, 20 warnings, 398 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13460133.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[01/34] lib/find: add atomic find_bit() primitives

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B3 Line contains hard tab characters (\t): "	for (idx = 0; idx < nbits; idx++)"
9: B3 Line contains hard tab characters (\t): "		if (test_and_clear_bit(idx, bitmap))"
10: B3 Line contains hard tab characters (\t): "			do_something(idx);"
14: B3 Line contains hard tab characters (\t): "	do {"
15: B3 Line contains hard tab characters (\t): "		bit = find_first_bit(bitmap, nbits);"
16: B3 Line contains hard tab characters (\t): "		if (bit >= nbits)"
17: B3 Line contains hard tab characters (\t): "			return nbits;"
18: B3 Line contains hard tab characters (\t): "	} while (!test_and_clear_bit(bit, bitmap));"
19: B3 Line contains hard tab characters (\t): "	return bit;"
24: B3 Line contains hard tab characters (\t): "	for_each_test_and_clear_bit(idx, bitmap, nbits)"
25: B3 Line contains hard tab characters (\t): "		do_something(idx);"
28: B3 Line contains hard tab characters (\t): "	return find_and_clear_bit(bitmap, nbits);"
69: B3 Line contains hard tab characters (\t): "	find_and_set_bit(addr, nbits);"
70: B3 Line contains hard tab characters (\t): "	find_and_set_next_bit(addr, nbits, start);"
71: B3 Line contains hard tab characters (\t): "	..."
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============1406089292867950575==--
