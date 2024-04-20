Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938A4317E
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713652313; cv=none; b=X3gTae2T3+/Nl4d2B33YtJnfUbz7LS3P3ChTudrNTFMnzX5fbqwtpRmkJTQLb+T9VTXuWLAu0K2WJjk5cXwKphbq9gNkQBk5rWku62Ny1tPG9O29svovZCrP3dkFPG2rnbVGamavy0e70g8+JApfGnyFLl0BCACiEFQwjCQBAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713652313; c=relaxed/simple;
	bh=2FjA4sj7jesWdKJEsLr5nqWmKlAAXNUP9BMqA1T8YkA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mwRboKANpPRC3cOKv9E7WckbsHVKg+69H3gQScaWGe5ruXUmiU28h3X8L94e7zX4R1JL2Uu5F35S/XiAgJ28ZTyRS/9jtnyIt1drYItxPJjVIMd+DzsU8D+nGrjvnLUeTmRwbihgyGHKv3rxi33R/iTv+lK/pkjlkOpZ4hGfsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwG5umTy; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwG5umTy"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c7498041cfso1042245b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 15:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713652311; x=1714257111; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pcEqo7J+OWv1rpIK1WpJwi8j9fSdtyKWzh4W6GldN0E=;
        b=HwG5umTyATMY4yDANJ7DrMn5oCvVMgpHC93jVm+dIMcCH5+LLRJZXKolu84XO4p4+S
         fDYNvy30flKe0wndDr/R4cbxqnQkGT2FhgrCN+unLsXxB1/lnu+RH+U+tkDH/mZ5DeSG
         ncFgGPI2++kCgxDIy6hSreZ/CV6fgZ4ey3yi7OYQ8M0UGJfqjVrl7ISogVcn+B/vMSgU
         JjR3jlDJwPkGS/GmVfyjhQ3ZunOFQk9qZeMAsUYIhZ4pppeH1UVUd2eD1ZwoXHxivKob
         m0mrvL/EQLFSfsFx7DDC0lg+++MbJbZLZOGg92jm6LiXndsAvGNq8TaKzq5d/kXUN+w/
         G6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713652311; x=1714257111;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcEqo7J+OWv1rpIK1WpJwi8j9fSdtyKWzh4W6GldN0E=;
        b=LkI9lRp0sFJQLBvDbhtZVssH4inQVNwNHm7TswdyLqHmZJ8+uoJNYlM6DAcnV7vjCj
         hGJt6Ilxvkbw365BLdl7PbJ5gYRn/F3G25YFHBieOdZ+WRg391+NYTqDHhGTwtOuViJu
         mnQ71m0IwNosNYoucbp4tmEkuQV9FH+JuUOW7G7QC14AaU48AYne35bL1cQpKIJ7kSK+
         eBaJyLfuEaBTuNItlr6k4b9JkuDxuSRPfBpkRLGeLH5MwhOf7kUGy66KkusZpI4kEbvA
         QnBmC6UU4+HOuk4u3g+uHC0q1j/KlT6GXSV7c66cAemkdiMzauKVHM3Zu9t08UmWd/4L
         qCsA==
X-Gm-Message-State: AOJu0Yzm10g0fhXaQlxsjGGyxNagJD5I2ZHb4CQd9alyRLSsNqg0Z8xp
	0QLLdLS/vDpNhgjCjkbV+c9ZD8Jf/Gxvn5ton0aOTOR9KVoMzOoTAVgL5g==
X-Google-Smtp-Source: AGHT+IFNhpL7mtgQ8GmwVLBxZXmgS53j8eAOHwl/d4MpLm7bZWmXgOfQHdUOWCeDy1fJD++NS5O1IA==
X-Received: by 2002:a05:6808:1156:b0:3c7:5162:353b with SMTP id u22-20020a056808115600b003c75162353bmr3377018oiu.18.1713652310957;
        Sat, 20 Apr 2024 15:31:50 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.5.190])
        by smtp.gmail.com with ESMTPSA id v17-20020ac85791000000b004364ee6909esm286673qta.83.2024.04.20.15.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 15:31:50 -0700 (PDT)
Message-ID: <66244256.c80a0220.1c0c7.166b@mx.google.com>
Date: Sat, 20 Apr 2024 15:31:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2431004172958042089=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Fix two regression issues for QCA controllers
In-Reply-To: <1713650800-29741-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1713650800-29741-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2431004172958042089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846372

---Test result---

Test Summary:
CheckPatch                    FAIL      1.49 seconds
GitLint                       FAIL      0.79 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      29.58 seconds
CheckAllWarning               PASS      32.85 seconds
CheckSparse                   PASS      38.06 seconds
CheckSmatch                   FAIL      34.71 seconds
BuildKernel32                 PASS      28.63 seconds
TestRunnerSetup               PASS      516.90 seconds
TestRunner_l2cap-tester       PASS      18.30 seconds
TestRunner_iso-tester         PASS      28.64 seconds
TestRunner_bnep-tester        PASS      4.65 seconds
TestRunner_mgmt-tester        PASS      109.46 seconds
TestRunner_rfcomm-tester      PASS      7.21 seconds
TestRunner_sco-tester         PASS      14.88 seconds
TestRunner_ioctl-tester       PASS      7.57 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.82 seconds
IncrementalBuild              PASS      32.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,1/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#112: 
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13637223.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,1/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
17: B1 Line exceeds max length (139>80): "Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f"
[v4,2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (93>80): "[v4,2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot"
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============2431004172958042089==--
