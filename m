Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C6168DC
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn8t/zGD"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ca5b61f101so821053a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 03:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703244715; x=1703849515; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cJAzQAMGM2FXEAAzWBdOvrel8dYmwi7CVCYaDRlBVTw=;
        b=nn8t/zGDJjCrpcQNfGI/q2ysAs8Vev+3EkK3ziSCDyz0JYLXHV8WS45+gz8IX+HaZE
         ULuiVcFzZZLw7IBH+JPidgS6TKVGlh5rZ53jN768lpR0ZQ7bWGsRw643zqxrmJTmrVv+
         OvW5CVRVSvdLq0RkZ5f6yVztqkfqsDCMWiuWLTtzYpY/zs+pnUfFUOs6nqdaCnK+QWUS
         tYbQDDhIv5/Jy0pPja6kjw8RSgNYZZrhsATWT9f1qLbRo8sH7OmCmjx+mIOzZEazwRg+
         FVnay/oqqWPPUNgFWJnAdr/6vi/pdwE5TYIrOU+tjI3kmL3WVg8tbIGpfNJng3Apide3
         fioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244715; x=1703849515;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJAzQAMGM2FXEAAzWBdOvrel8dYmwi7CVCYaDRlBVTw=;
        b=v/ZD2CEBEdAWRNv1Y/KzVhGYBLxUPMw7FtNnvcqvK5QFA5WkCrEl2FHytZ9+RHtjKu
         TzJ2YDJWiiQuq4sdNHgg0RWPOlVuN2VNpkE/PYDKLr1WynqScoeYOLj4wyaXdQQ1eXkK
         9MEyA+vJe5l/mzdD+aeqzcQdbfYQnTwnv6dt8LBgxDYXplxOhjnemxCI8+8MCseihrph
         VB1vm4cC2DNZqDJNtkIm0L/huxfVa51n0czYmBiY1iz4uoYEoaSMLiK+npuoWDCuijKY
         ddJNCB5WwT7ra2XJhAaSZdyKRfuvG2RKxzn1nwFzfIgcjNirqsr+svAAwvTLx+BvpDiI
         uG0g==
X-Gm-Message-State: AOJu0Yz4RVYGbOV0gCpyZvHWM4twQvCSFaeG3xEfbPJ0rNUnPTc2pr/j
	CeOL1F6ymA6OsDVfUlPrHfHz8MXerkE=
X-Google-Smtp-Source: AGHT+IGgT+PqvQhEpwTVYwLp237VNnSjKKqHyt5qNx/lxPgrVxRjDGa8hZgsaJ7+wSlpi5sfrERqcQ==
X-Received: by 2002:a17:90a:cc14:b0:28c:1403:541b with SMTP id b20-20020a17090acc1400b0028c1403541bmr226716pju.89.1703244715459;
        Fri, 22 Dec 2023 03:31:55 -0800 (PST)
Received: from [172.17.0.2] ([52.157.5.226])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090aa68300b0028c060d5c59sm1292525pjq.15.2023.12.22.03.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:31:55 -0800 (PST)
Message-ID: <658573ab.170a0220.f17a5.427d@mx.google.com>
Date: Fri, 22 Dec 2023 03:31:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5785720458693241211=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2045gemini@gmail.com
Subject: RE: Bluetooth: Fix atomicity violation in {conn,adv}_{min,max}_interval_set
In-Reply-To: <20231222105526.9208-1-2045gemini@gmail.com>
References: <20231222105526.9208-1-2045gemini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5785720458693241211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812452

---Test result---

Test Summary:
CheckPatch                    FAIL      0.79 seconds
GitLint                       FAIL      4.01 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      28.00 seconds
CheckAllWarning               PASS      30.53 seconds
CheckSparse                   PASS      35.88 seconds
CheckSmatch                   PASS      104.39 seconds
BuildKernel32                 PASS      26.97 seconds
TestRunnerSetup               PASS      434.35 seconds
TestRunner_l2cap-tester       PASS      23.45 seconds
TestRunner_iso-tester         PASS      46.45 seconds
TestRunner_bnep-tester        PASS      7.35 seconds
TestRunner_mgmt-tester        FAIL      168.91 seconds
TestRunner_rfcomm-tester      PASS      11.21 seconds
TestRunner_sco-tester         PASS      14.81 seconds
TestRunner_ioctl-tester       PASS      12.41 seconds
TestRunner_mesh-tester        PASS      9.02 seconds
TestRunner_smp-tester         PASS      9.93 seconds
TestRunner_userchan-tester    PASS      7.40 seconds
IncrementalBuild              PASS      26.56 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Fix atomicity violation in {conn,adv}_{min,max}_interval_set
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: Move LE debugfs file creation into ...")'
#121: 
Fixes: 3a5c82b78fd28 ("Bluetooth: Move LE debugfs file creation into ...")

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#123: 
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>

ERROR: trailing whitespace
#139: FILE: net/bluetooth/hci_debugfs.c:852:
+^I$

ERROR: trailing whitespace
#142: FILE: net/bluetooth/hci_debugfs.c:855:
+^I^Ihci_dev_unlock(hdev);^I$

ERROR: trailing whitespace
#156: FILE: net/bluetooth/hci_debugfs.c:882:
+^I$

ERROR: trailing whitespace
#173: FILE: net/bluetooth/hci_debugfs.c:996:
+^I$

ERROR: trailing whitespace
#176: FILE: net/bluetooth/hci_debugfs.c:999:
+^I^Ihci_dev_unlock(hdev);^I$

total: 5 errors, 2 warnings, 0 checks, 62 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13503199.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3228.
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix atomicity violation in {conn,adv}_{min,max}_interval_set

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B3 Line contains hard tab characters (\t): "	if (val < ... || val > ... || val > hdev->le_{conn,adv}_max_interval)"
5: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
6: B3 Line contains hard tab characters (\t): "	hci_dev_lock(hdev);"
7: B3 Line contains hard tab characters (\t): "	hdev->le_{conn,adv}_min_interval = val;"
8: B3 Line contains hard tab characters (\t): "	hci_dev_unlock(hdev);"
11: B3 Line contains hard tab characters (\t): "	if (val < ... || val > ... || val < hdev->le_{conn,adv}_min_interval)"
12: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
13: B3 Line contains hard tab characters (\t): "	hci_dev_lock(hdev);"
14: B3 Line contains hard tab characters (\t): "	hdev->le_{conn,adv}_max_interval"
15: B3 Line contains hard tab characters (\t): "	hci_dev_unlock(hdev);"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 1, Not Run: 1

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.336 seconds


---
Regards,
Linux Bluetooth


--===============5785720458693241211==--
