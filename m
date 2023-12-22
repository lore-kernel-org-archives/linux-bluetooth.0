Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08472171B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK6OAp4y"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f47b15fa3so10663626d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 03:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703244731; x=1703849531; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n1DKOgp6ePWYM18Bv3Jgn5ahOvJZV5pD944HVzgSxEA=;
        b=VK6OAp4yA0Zokkc+xD2gYEO2q8rrxZ7LC9djYGBsxenc0aStgxCVTShbtPbDbVuQQA
         9tpEpQthQHu8wqAfSNNn09WxFRnQgRIgbsYIzgIK9wrZMC3WBcw9t6dzXSdenOSwaeyu
         1S0GdPOYFCq0jzI8R0veKfRuXASVLksss4IOe7E7h/tcJ2pFoICU/873kZZXw1Qa4zsq
         CST5srb7MsyGMF5tWogk8VK0nkupRsTPZI9/APHlfUYUeRqBUYpHichkx6K9FBAWwmYb
         +iTFBB40iGOHmrVOGG5WMu/EjYRBdkckhzGfNsSoHZpaQfE8EHDdYq2uf6G8Mz7d6b2p
         vVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244731; x=1703849531;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1DKOgp6ePWYM18Bv3Jgn5ahOvJZV5pD944HVzgSxEA=;
        b=jmW9fPTh7wKSD9w5Bsv9Vm2VbA+BgmNzzLt0p7+sDb5hOHgxo5oQEuiMfMugZNAHlh
         sgkV3hbWm4XSK6r+iroljF8Oi+F21HXrCG6Bpox00+8kdp8TnwdwvArKtyYMcpSAwz6x
         krNbbB58Z5uC2mBQ6LU38Fh8YF+kOnYdfXBCdrAjIDgUZtZjNNF4q+booasg33gVvS76
         9vnnA5SuQGkw2fEkinoAKLwAXn3x5/rw8N1gGPi8vlK5guJVUcHWb2V+Y4bIU/O9d5tH
         tcTSZpfEoNIlcpO6sxZQpNNWJi2dDew3GcUxFseolxv7LqrnymebOnuncr/n7yeQyaPK
         lcHw==
X-Gm-Message-State: AOJu0YwovxIRlXveCAkmgbLAX6h5HECfQWlawt3YJcPDBH+tKWJ1vUeW
	fSWV3br+p6Eku29I+6pwOysg58+oDpTI4g==
X-Google-Smtp-Source: AGHT+IH969mqLEAn0I/Yo82F3EwtUWp0HcgDCgwepSatB+TKNhjmoO21PXEPnDBFPnaGd3TBFItPWw==
X-Received: by 2002:a05:6214:20c4:b0:67a:a6c5:eed4 with SMTP id 4-20020a05621420c400b0067aa6c5eed4mr1961598qve.1.1703244730804;
        Fri, 22 Dec 2023 03:32:10 -0800 (PST)
Received: from [172.17.0.2] ([20.55.214.240])
        by smtp.gmail.com with ESMTPSA id bt10-20020ad455ca000000b0067f30a6c145sm1318002qvb.38.2023.12.22.03.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:32:10 -0800 (PST)
Message-ID: <658573ba.d40a0220.d1c04.63fa@mx.google.com>
Date: Fri, 22 Dec 2023 03:32:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4297132853013298442=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2045gemini@gmail.com
Subject: RE: Bluetooth: Fix atomicity violation in conn_info_{min,max}_age_set
In-Reply-To: <20231222110401.9322-1-2045gemini@gmail.com>
References: <20231222110401.9322-1-2045gemini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4297132853013298442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812456

---Test result---

Test Summary:
CheckPatch                    FAIL      2.32 seconds
GitLint                       FAIL      1.55 seconds
SubjectPrefix                 PASS      0.76 seconds
BuildKernel                   PASS      27.54 seconds
CheckAllWarning               PASS      30.21 seconds
CheckSparse                   PASS      35.96 seconds
CheckSmatch                   PASS      102.31 seconds
BuildKernel32                 PASS      26.85 seconds
TestRunnerSetup               PASS      439.29 seconds
TestRunner_l2cap-tester       PASS      23.27 seconds
TestRunner_iso-tester         PASS      44.49 seconds
TestRunner_bnep-tester        PASS      7.46 seconds
TestRunner_mgmt-tester        PASS      175.71 seconds
TestRunner_rfcomm-tester      PASS      13.18 seconds
TestRunner_sco-tester         PASS      15.27 seconds
TestRunner_ioctl-tester       PASS      12.95 seconds
TestRunner_mesh-tester        PASS      9.61 seconds
TestRunner_smp-tester         PASS      10.60 seconds
TestRunner_userchan-tester    PASS      7.78 seconds
IncrementalBuild              PASS      29.06 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Fix atomicity violation in conn_info_{min,max}_age_set
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: Move common debugfs file creation ...")'
#121: 
Fixes: 40ce72b1951c5 ("Bluetooth: Move common debugfs file creation ...")

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#123: 
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>

ERROR: trailing whitespace
#139: FILE: net/bluetooth/hci_debugfs.c:220:
+^I$

ERROR: trailing whitespace
#156: FILE: net/bluetooth/hci_debugfs.c:250:
+^I$

total: 2 errors, 2 warnings, 0 checks, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13503203.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3228.
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix atomicity violation in conn_info_{min,max}_age_set

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B3 Line contains hard tab characters (\t): "	if (val == 0 || val > hdev->conn_info_max_age)"
5: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
6: B3 Line contains hard tab characters (\t): "	hci_dev_lock(hdev);"
7: B3 Line contains hard tab characters (\t): "	hdev->conn_info_min_age = val;"
8: B3 Line contains hard tab characters (\t): "	hci_dev_unlock(hdev);"
11: B3 Line contains hard tab characters (\t): "	if (val == 0 || val < hdev->conn_info_min_age)"
12: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
13: B3 Line contains hard tab characters (\t): "	hci_dev_lock(hdev);"
14: B3 Line contains hard tab characters (\t): "	hdev->conn_info_max_age = val;"
15: B3 Line contains hard tab characters (\t): "	hci_dev_unlock(hdev);"


---
Regards,
Linux Bluetooth


--===============4297132853013298442==--
