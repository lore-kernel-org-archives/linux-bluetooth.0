Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC6168BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKWXYw0H"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-427a7fce552so4900291cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 03:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703244685; x=1703849485; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TD1St7rOsHqJ+L1q0sSkwOQykPfwKVuXKjKKiTXc7c8=;
        b=dKWXYw0HRBPdCeMh+pwFSLlQm6j1icht8/4PxVSP/6Ns54StDDTlgCDSQOPEhDZf0g
         pS8vJWbT3MCwrwbB60cBEMvrCAM/BC+g/mXCBWyDD697HVkPzEkZM0aOs1kIx34G9Dw/
         R/huCkzkxm6Zwd4K158ikZOjOhdwW5PbEo7Vopl0mT2WS6qg6COk0zFeB1xXdwHa/zON
         Gi+cJN45qkvRJhUQYpFWZZLhwy7QxHVn4FcY44Rse9UGipAVWEwmWzGc3IOkn6i3P4/5
         8UpA7bfM3gOA4pILCrYwOMqbq3arb3KPdoWck6EkozvioMNoGZqNLPO7vupXDPmM0dS2
         8BCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244685; x=1703849485;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD1St7rOsHqJ+L1q0sSkwOQykPfwKVuXKjKKiTXc7c8=;
        b=I2Z12MkVB+7YRDKIx5cuMhYEX0GRFR8FkePUGBRdnXsuVSADVN8BI4gEicLF230fQX
         QJc13Gn5m50Kf2mQGRmf8NjLCmqfyf1G+1KU8ew6YNHvoVcD/7GVxSDcPB0VEoDKrjx8
         RIJgB9t02Gcm/ue+ZcgjFlRoLJNJdEoVpPhnddiSF4LWyuV8G04tf3AIuEdnuyV1rpzd
         2h7RI9ZkB+peNTVir94ttvWAHWpNXmxIY5R/AbEzqjjANDE5HU9TwKqmETV5uUz7ND/h
         cWJ9lqe5cGJPpzwXzynuQcBKYJB4kE5aQbUQ/kUGL2Y5aigvNnUuw5/n2cJd9UGFfBKp
         DfSw==
X-Gm-Message-State: AOJu0YzcmJpF/mkI8c3Bnmjw+nsEFs2lq8XOh4ajsD72imByFJcZkfK2
	4UppUC8yPyXtqtvjM3t8un2UF0SNXTk=
X-Google-Smtp-Source: AGHT+IE1wPO0GgA7MmldLVDLyAaa4p7JIFcuKWLaoPzyjdtW6CaeUqUdMCZVIhhU1pNA6rX4jhe2uw==
X-Received: by 2002:ac8:7dc1:0:b0:425:615f:2fc8 with SMTP id c1-20020ac87dc1000000b00425615f2fc8mr1551558qte.61.1703244685440;
        Fri, 22 Dec 2023 03:31:25 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.100])
        by smtp.gmail.com with ESMTPSA id bc14-20020a05622a1cce00b00427a49c4faesm972698qtb.4.2023.12.22.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:31:25 -0800 (PST)
Message-ID: <6585738d.050a0220.18716.48f5@mx.google.com>
Date: Fri, 22 Dec 2023 03:31:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6323491944668037052=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2045gemini@gmail.com
Subject: RE: Bluetooth: Fix atomicity violation in sniff_{min,max}_interval_set
In-Reply-To: <20231222110147.9287-1-2045gemini@gmail.com>
References: <20231222110147.9287-1-2045gemini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6323491944668037052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812454

---Test result---

Test Summary:
CheckPatch                    FAIL      0.87 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.99 seconds
CheckAllWarning               PASS      30.59 seconds
CheckSparse                   PASS      36.70 seconds
CheckSmatch                   PASS      99.88 seconds
BuildKernel32                 PASS      27.27 seconds
TestRunnerSetup               PASS      435.93 seconds
TestRunner_l2cap-tester       PASS      24.38 seconds
TestRunner_iso-tester         PASS      45.43 seconds
TestRunner_bnep-tester        PASS      7.00 seconds
TestRunner_mgmt-tester        PASS      162.68 seconds
TestRunner_rfcomm-tester      PASS      10.90 seconds
TestRunner_sco-tester         PASS      14.56 seconds
TestRunner_ioctl-tester       PASS      12.27 seconds
TestRunner_mesh-tester        PASS      9.95 seconds
TestRunner_smp-tester         PASS      9.78 seconds
TestRunner_userchan-tester    PASS      7.37 seconds
IncrementalBuild              PASS      26.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Fix atomicity violation in sniff_{min,max}_interval_set
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: Move BR/EDR debugfs file creation ...")'
#121: 
Fixes: 71c3b60ec6d28 ("Bluetooth: Move BR/EDR debugfs file creation ...")

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#123: 
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>

ERROR: trailing whitespace
#139: FILE: net/bluetooth/hci_debugfs.c:569:
+^I$

ERROR: trailing whitespace
#156: FILE: net/bluetooth/hci_debugfs.c:599:
+^I$

total: 2 errors, 2 warnings, 0 checks, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13503201.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3228.
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix atomicity violation in sniff_{min,max}_interval_set

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B3 Line contains hard tab characters (\t): "	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)"
5: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
6: B3 Line contains hard tab characters (\t): "	hci_dev_lock(hdev);"
7: B3 Line contains hard tab characters (\t): "	hdev->sniff_min_interval = val;"
8: B3 Line contains hard tab characters (\t): "	hci_dev_unlock(hdev);"
11: B3 Line contains hard tab characters (\t): "	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)"
12: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
13: B3 Line contains hard tab characters (\t): "	hci_dev_lock(hdev);"
14: B3 Line contains hard tab characters (\t): "	hdev->sniff_max_interval = val;"
15: B3 Line contains hard tab characters (\t): "	hci_dev_unlock(hdev);"


---
Regards,
Linux Bluetooth


--===============6323491944668037052==--
