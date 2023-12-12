Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0uE6ct3"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F829C
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 19:04:43 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77f48aef0a5so152536085a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 19:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702350282; x=1702955082; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G4vSyb/T/YLbyegoXgGkg8hzDxDDgBjU1u7Khxz1EDU=;
        b=f0uE6ct3Ahy3VdLGgpfrvufNnGdb868J+oIkjpvOv4U19ACe3MtIp/oqQus5UiMzWU
         XtVRBf14Rc73zLvlB/hP52AGsvJMyuQoiC/Hqn06GVsC/SZa4i7TlaG6qtrXnoAwBnOh
         +hC0aLxnNrNzSqDiQfOHO9bBLB+RGfK1M7fzh7jP5WcksmI2SCwDW2oPHQVKkCCJdHWn
         SmwQddWPDHeR9tD9/NTljSoq9bG72mgvsum3/h91hyQcVkx6GBOsNakKmH9pNIpDR805
         xLY+/76QmmAUdjB/WUyOtatMiOYJqUCwf/6OX+DlrE0iWcEGMRABWQHwLXUXnvkKbhP/
         z+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702350282; x=1702955082;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4vSyb/T/YLbyegoXgGkg8hzDxDDgBjU1u7Khxz1EDU=;
        b=fIGn/EjfLTiZuownH26QgFh4aQDFiQCf8U0NoWaw0AcxwVEANGG8BzVHm2y1xavdQA
         EVPm2er2wKJZYF86a6Fh2aIlL0Z2Bl6L8daX5SamJcEazBaaAGD3nC5tdW2eUVHUmffc
         pIZzFcziXCzp2E/9jYHpygJIynD2PWtJSqs8Ad3cdbNMjK3/IoGm9g03fU3+CWOV/EYY
         EeH6kZrka2Frg+Trg0hxRcTc9VY7utuhD+d/g89K/1EJSiIH7TeWnNROGd9LKWdWo4YZ
         mcgtIpgxUlOU5A0prc68Bk1KLz39ho8P2hji0jjh1OiTAiAe7FHbbGX6r35SfoZutYjD
         s+Cg==
X-Gm-Message-State: AOJu0YyzwjAFwJYk1aD0IHQe66FHlbNYXgjGLoWacJ4kyI/28+tKW0tI
	+h0yBjzLr1LI/8KA4tUlfH08g4dWfs4=
X-Google-Smtp-Source: AGHT+IGBnl3nsl6Q+pAnX8UJy1Jk0XMr21KboSxD8YgujkevSUe6UVSId+QaCYtZ6DH1zNr77Qnsmg==
X-Received: by 2002:a05:620a:6282:b0:77e:fba3:a7a9 with SMTP id ov2-20020a05620a628200b0077efba3a7a9mr3526908qkn.135.1702350282302;
        Mon, 11 Dec 2023 19:04:42 -0800 (PST)
Received: from [172.17.0.2] ([74.249.21.242])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a228100b00775bb02893esm3398754qkh.96.2023.12.11.19.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 19:04:42 -0800 (PST)
Message-ID: <6577cdca.050a0220.47ef7.fbcd@mx.google.com>
Date: Mon, 11 Dec 2023 19:04:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7762689212530653112=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yury.norov@gmail.com
Subject: RE: bitops: add atomic find_bit() operations
In-Reply-To: <20231212022749.625238-2-yury.norov@gmail.com>
References: <20231212022749.625238-2-yury.norov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7762689212530653112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=809012

---Test result---

Test Summary:
CheckPatch                    FAIL      2.67 seconds
GitLint                       FAIL      1.21 seconds
SubjectPrefix                 FAIL      0.62 seconds
BuildKernel                   PASS      27.52 seconds
CheckAllWarning               PASS      30.11 seconds
CheckSparse                   PASS      35.89 seconds
CheckSmatch                   PASS      99.23 seconds
BuildKernel32                 PASS      27.75 seconds
TestRunnerSetup               PASS      421.35 seconds
TestRunner_l2cap-tester       PASS      23.04 seconds
TestRunner_iso-tester         PASS      47.01 seconds
TestRunner_bnep-tester        PASS      7.02 seconds
TestRunner_mgmt-tester        PASS      164.21 seconds
TestRunner_rfcomm-tester      PASS      11.00 seconds
TestRunner_sco-tester         PASS      14.50 seconds
TestRunner_ioctl-tester       PASS      12.14 seconds
TestRunner_mesh-tester        PASS      8.87 seconds
TestRunner_smp-tester         PASS      9.78 seconds
TestRunner_userchan-tester    PASS      7.37 seconds
IncrementalBuild              PASS      34.07 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,01/35] lib/find: add atomic find_bit() primitives
WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#286: FILE: include/linux/find.h:35:
+unsigned long _find_and_set_bit(volatile unsigned long *addr, unsigned long nbits);

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#287: FILE: include/linux/find.h:36:
+unsigned long _find_and_set_next_bit(volatile unsigned long *addr, unsigned long nbits,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#289: FILE: include/linux/find.h:38:
+unsigned long _find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits);

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#290: FILE: include/linux/find.h:39:
+unsigned long _find_and_set_next_bit_lock(volatile unsigned long *addr, unsigned long nbits,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#292: FILE: include/linux/find.h:41:
+unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits);

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#293: FILE: include/linux/find.h:42:
+unsigned long _find_and_clear_next_bit(volatile unsigned long *addr, unsigned long nbits,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#320: FILE: include/linux/find.h:490:
+unsigned long find_and_set_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#357: FILE: include/linux/find.h:527:
+unsigned long find_and_set_next_bit(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#386: FILE: include/linux/find.h:556:
+unsigned long find_and_set_bit_wrap(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#415: FILE: include/linux/find.h:585:
+unsigned long find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#451: FILE: include/linux/find.h:621:
+unsigned long find_and_set_next_bit_lock(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#481: FILE: include/linux/find.h:651:
+unsigned long find_and_set_bit_wrap_lock(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#509: FILE: include/linux/find.h:679:
+static inline unsigned long find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#545: FILE: include/linux/find.h:715:
+unsigned long find_and_clear_next_bit(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#604: FILE: lib/find_bit.c:119:
+unsigned long _find_and_set_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#618: FILE: lib/find_bit.c:133:
+unsigned long _find_and_set_next_bit(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#633: FILE: lib/find_bit.c:148:
+unsigned long _find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#647: FILE: lib/find_bit.c:162:
+unsigned long _find_and_set_next_bit_lock(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#662: FILE: lib/find_bit.c:177:
+unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#676: FILE: lib/find_bit.c:191:
+unsigned long _find_and_clear_next_bit(volatile unsigned long *addr,

total: 0 errors, 20 warnings, 402 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13488365.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,01/35] lib/find: add atomic find_bit() primitives

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
89: B3 Line contains hard tab characters (\t): "	find_and_set_bit(addr, nbits);"
90: B3 Line contains hard tab characters (\t): "	find_and_set_next_bit(addr, nbits, start);"
91: B3 Line contains hard tab characters (\t): "	..."
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7762689212530653112==--
