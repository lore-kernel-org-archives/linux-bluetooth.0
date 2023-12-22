Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682617730
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYbtP76j"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77f8308616eso113638185a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 03:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703244710; x=1703849510; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KINTt+PsvRJrLN1XLRheHafGqUNTGv9MhjuJV9m3Bx8=;
        b=DYbtP76jFub2zPJad0C0zdy8VQLV9ytDlrfl0QSXvACZ3e1WPgG2lirNpTAosmXqEI
         42KZCvB8MyekJqqbLuf5ge8Px6sV10s8Du8N9VVieoTUpyDUV9ONwQ7fPJh6hRi8j/Nn
         na6emNXnIYxbDQAZ0Bpt31CBSmRxGzHK5bkvbsYKSljyvi09iNQbG5DBH4Gn/cfzvQW+
         R8ozzBtPWk7w+1EIPlZ/1FvTwe+ovPJIbrP8S+QEP6WcVLJ3NcdRb/bhFrFFFxtJMeHn
         evlbGWm3O3RBTEsRNlG7S/T0AZ5/j6MVjFe8Sf1cJZ2Bb0DZv4StWX+m7znGX499NVIA
         5drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244710; x=1703849510;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KINTt+PsvRJrLN1XLRheHafGqUNTGv9MhjuJV9m3Bx8=;
        b=H8a6IEBDVFWKCVXMBMkow0DfLTBlHEUajb2QpfbC3NZeWCth/O4zwgPocha5CGMWCw
         ey7H2RbNgiwNULsP2VMJRH1LHUaALju9DZMCT16JpCPc0L1ZDMtv+0+fIIThJNRcV8m2
         rUWSPKF5V3c34Jsnkkys+/pPnncO+Ozdlw10YWAkGfglhHFfe8hV+EEeV4pFuvEWmbHs
         QIsdkVlF7PAitqISJz1lxYHV4IkouxDk4vHCt51D4oZHnYTWwqd34f5pGgW1C55TDR+8
         MHFMwf2ed5AakZUmCR2rD0KYtbg+I3N7IwlJq5I79dFqusoXGPol4kTlTwu5xpOg8kmL
         gnhA==
X-Gm-Message-State: AOJu0Yx/EKG8TDnRaIcaW4/3pf53erq4LMw5AIyJmt2eT8kdbZgW/t6J
	OVCqZCRTArTRGecxxIXJXKdecFbmspI=
X-Google-Smtp-Source: AGHT+IE57yuix4pLNmgGeXhUtL5C7recAGXyt5in4AvfPMtDE7J19M0oFRaMSvpfbiycbh1hWHXotw==
X-Received: by 2002:a05:620a:27d0:b0:781:214c:afb6 with SMTP id i16-20020a05620a27d000b00781214cafb6mr1379353qkp.78.1703244709831;
        Fri, 22 Dec 2023 03:31:49 -0800 (PST)
Received: from [172.17.0.2] ([20.109.60.245])
        by smtp.gmail.com with ESMTPSA id b7-20020a05620a126700b0077703f31496sm1297732qkl.92.2023.12.22.03.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:31:49 -0800 (PST)
Message-ID: <658573a5.050a0220.458fa.703e@mx.google.com>
Date: Fri, 22 Dec 2023 03:31:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6310606963758158082=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2045gemini@gmail.com
Subject: RE: Bluetooth: Fix atomicity violation in {min,max}_key_size_set
In-Reply-To: <20231222105813.9245-1-2045gemini@gmail.com>
References: <20231222105813.9245-1-2045gemini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6310606963758158082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812453

---Test result---

Test Summary:
CheckPatch                    FAIL      0.86 seconds
GitLint                       FAIL      4.55 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      28.09 seconds
CheckAllWarning               PASS      30.56 seconds
CheckSparse                   PASS      36.39 seconds
CheckSmatch                   PASS      104.63 seconds
BuildKernel32                 PASS      27.69 seconds
TestRunnerSetup               PASS      437.81 seconds
TestRunner_l2cap-tester       PASS      23.23 seconds
TestRunner_iso-tester         PASS      43.32 seconds
TestRunner_bnep-tester        PASS      7.37 seconds
TestRunner_mgmt-tester        PASS      164.45 seconds
TestRunner_rfcomm-tester      PASS      11.13 seconds
TestRunner_sco-tester         PASS      14.89 seconds
TestRunner_ioctl-tester       PASS      12.20 seconds
TestRunner_mesh-tester        PASS      8.92 seconds
TestRunner_smp-tester         PASS      10.32 seconds
TestRunner_userchan-tester    PASS      7.44 seconds
IncrementalBuild              PASS      26.40 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Fix atomicity violation in {min,max}_key_size_set
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: Move {min,max}_key_size debugfs ...")'
#120: 
Fixes: 18f81241b74fb ("Bluetooth: Move {min,max}_key_size debugfs ...")

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#122: 
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>

ERROR: trailing whitespace
#138: FILE: net/bluetooth/hci_debugfs.c:1048:
+^I$

ERROR: trailing whitespace
#155: FILE: net/bluetooth/hci_debugfs.c:1078:
+^I$

total: 2 errors, 2 warnings, 0 checks, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13503200.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3228.
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix atomicity violation in {min,max}_key_size_set

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B3 Line contains hard tab characters (\t): "	if (val > hdev->le_max_key_size || val < SMP_MIN_ENC_KEY_SIZE)"
5: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
6: B3 Line contains hard tab characters (\t): "	hci_dev_lock(hdev);"
7: B3 Line contains hard tab characters (\t): "	hdev->le_min_key_size = val;"
8: B3 Line contains hard tab characters (\t): "	hci_dev_unlock(hdev);"
11: B3 Line contains hard tab characters (\t): "	if (val > SMP_MAX_ENC_KEY_SIZE || val < hdev->le_min_key_size)"
12: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
13: B3 Line contains hard tab characters (\t): "	hci_dev_lock(hdev);"
14: B3 Line contains hard tab characters (\t): "	hdev->le_max_key_size = val;"
15: B3 Line contains hard tab characters (\t): "	hci_dev_unlock(hdev);"


---
Regards,
Linux Bluetooth


--===============6310606963758158082==--
