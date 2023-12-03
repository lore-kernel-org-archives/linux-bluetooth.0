Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhdo8hj5"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C42F2
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 Dec 2023 11:56:42 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67ab19339b4so11663076d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Dec 2023 11:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701633401; x=1702238201; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHS6nR2D25YiYP1zMFjFBsC5pJyiKyuf8hq/TYLtPP8=;
        b=hhdo8hj5+fRuE592azSSveXWeBAIuwEWg3l2KUfLT+/rs3hQ7my/erCY2Xms+jYdem
         VQ7RF/oo0wbWtD8u1bZXzl6AzgQHT+l5LpjilJrqLOSG/VVQsjpP9NeICnNRxPBKoSiz
         dkUnJf1FAeinW6Nxkg1nJUs8oTD3mEN+6GCO0Pe1aMvRZMv7gMQAA3rugJqRy/EkVXe9
         I9A/ec/Hoik5fnJFIzN+mu2LzYGSRBU20sFEYncIReMtDqqy0pRwLnuVcfKNOd/KNpMR
         SPBhqQ28rRP7JPn+kpcpiBqAYdw4xmYXMhs+5gbxTj1obiZZRLyDABW8FbvJmJHxOIDW
         VM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701633401; x=1702238201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHS6nR2D25YiYP1zMFjFBsC5pJyiKyuf8hq/TYLtPP8=;
        b=D/1QtK83XajMFNA61jUnQLuXEOiCNMSIjOjNQRQAxgwzM/2EZVRevgAAagp8GFWwxw
         fXqtJbAu2eSqtaU3WOpJlM3vQA09lgch1yUmP4nhpeRFGMc1zXE5QFz86xzQuHFDH+7F
         YJwqs0yjHPUOds3k1wJP1w54dZuUY/ufLAZlmNxvrD/MRX5toP3Qd8R+6Pkm8HJRzoFs
         RpmCZJfaT8qE5yVF/nztmmrA710slcWqno4vux2buDuO0fekV6IX+amW9Gijre1hvVg8
         TMbT+/10kfr/P7GH/tJ3/RMZbPEAQqzr7RXQ9F5LRXE48TSAxTBnDkrttkUFxxBEWqW7
         9J+g==
X-Gm-Message-State: AOJu0YyRx9f6syMvfPUqQHtJT2FCYQLJxeGJDXe70/z0tuwl3PcgNLtT
	Zgna6KRf9LWq5Wjr+Hfwsyr0rZKWb9Q=
X-Google-Smtp-Source: AGHT+IEjjrXl4hX6HNP3UPx1pDaxz4hTIYnTpaLQ9/RTXP0QxNp4zSXPQbDYpOmj1XfWRBZ6L4CjVQ==
X-Received: by 2002:a0c:e847:0:b0:64f:4e64:5962 with SMTP id l7-20020a0ce847000000b0064f4e645962mr4060316qvo.31.1701633401006;
        Sun, 03 Dec 2023 11:56:41 -0800 (PST)
Received: from [172.17.0.2] ([20.55.118.210])
        by smtp.gmail.com with ESMTPSA id a4-20020a0ccdc4000000b0067aa164861dsm2297390qvn.35.2023.12.03.11.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:56:40 -0800 (PST)
Message-ID: <656cdd78.0c0a0220.799ef.6d6f@mx.google.com>
Date: Sun, 03 Dec 2023 11:56:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1599557339595727962=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yury.norov@gmail.com
Subject: RE: bitops: add atomic find_bit() operations
In-Reply-To: <20231203192422.539300-2-yury.norov@gmail.com>
References: <20231203192422.539300-2-yury.norov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1599557339595727962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=806363

---Test result---

Test Summary:
CheckPatch                    FAIL      2.51 seconds
GitLint                       FAIL      1.18 seconds
SubjectPrefix                 FAIL      0.57 seconds
BuildKernel                   PASS      28.39 seconds
CheckAllWarning               PASS      30.04 seconds
CheckSparse                   PASS      35.78 seconds
CheckSmatch                   PASS      99.11 seconds
BuildKernel32                 PASS      26.63 seconds
TestRunnerSetup               PASS      415.33 seconds
TestRunner_l2cap-tester       PASS      23.06 seconds
TestRunner_iso-tester         PASS      46.68 seconds
TestRunner_bnep-tester        PASS      10.39 seconds
TestRunner_mgmt-tester        PASS      174.49 seconds
TestRunner_rfcomm-tester      PASS      10.92 seconds
TestRunner_sco-tester         PASS      14.36 seconds
TestRunner_ioctl-tester       PASS      12.19 seconds
TestRunner_mesh-tester        PASS      8.83 seconds
TestRunner_smp-tester         PASS      9.83 seconds
TestRunner_userchan-tester    PASS      7.44 seconds
IncrementalBuild              PASS      36.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,01/35] lib/find: add atomic find_bit() primitives
WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#269: FILE: include/linux/find.h:35:
+unsigned long _find_and_set_bit(volatile unsigned long *addr, unsigned long nbits);

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#270: FILE: include/linux/find.h:36:
+unsigned long _find_and_set_next_bit(volatile unsigned long *addr, unsigned long nbits,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#272: FILE: include/linux/find.h:38:
+unsigned long _find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits);

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#273: FILE: include/linux/find.h:39:
+unsigned long _find_and_set_next_bit_lock(volatile unsigned long *addr, unsigned long nbits,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#275: FILE: include/linux/find.h:41:
+unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits);

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#276: FILE: include/linux/find.h:42:
+unsigned long _find_and_clear_next_bit(volatile unsigned long *addr, unsigned long nbits,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#303: FILE: include/linux/find.h:490:
+unsigned long find_and_set_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#340: FILE: include/linux/find.h:527:
+unsigned long find_and_set_next_bit(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#369: FILE: include/linux/find.h:556:
+unsigned long find_and_set_bit_wrap(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#398: FILE: include/linux/find.h:585:
+unsigned long find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#434: FILE: include/linux/find.h:621:
+unsigned long find_and_set_next_bit_lock(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#464: FILE: include/linux/find.h:651:
+unsigned long find_and_set_bit_wrap_lock(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#492: FILE: include/linux/find.h:679:
+static inline unsigned long find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#528: FILE: include/linux/find.h:715:
+unsigned long find_and_clear_next_bit(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#587: FILE: lib/find_bit.c:119:
+unsigned long _find_and_set_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#601: FILE: lib/find_bit.c:133:
+unsigned long _find_and_set_next_bit(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#616: FILE: lib/find_bit.c:148:
+unsigned long _find_and_set_bit_lock(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#630: FILE: lib/find_bit.c:162:
+unsigned long _find_and_set_next_bit_lock(volatile unsigned long *addr,

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#645: FILE: lib/find_bit.c:177:
+unsigned long _find_and_clear_bit(volatile unsigned long *addr, unsigned long nbits)

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#659: FILE: lib/find_bit.c:191:
+unsigned long _find_and_clear_next_bit(volatile unsigned long *addr,

total: 0 errors, 20 warnings, 402 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13477429.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,01/35] lib/find: add atomic find_bit() primitives

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
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============1599557339595727962==--
