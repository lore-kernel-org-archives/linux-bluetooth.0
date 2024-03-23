Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A73FE4
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Mar 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711180652; cv=none; b=IffUvy24yCL5Bl+g+NANw0GoxxVbtr5g8dlPoG0VqaMHZZaJ1Z4lSlbUloUMeqHGNOxxFZxkQoQyJ5zyMebybmbGm/7gGk3kxyuesBJSEVnqhnXZvD8IkFMoOnaEbPWUO6ns65q4dq55PkqcE8FVKVlQGsTbzcwIm+fOz+bwD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711180652; c=relaxed/simple;
	bh=55qT0sukY3hGROYpmDai6aOAJqMSyicBBB90fmFvdCw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JiUAEusmdKnfvu2mR7PXGapr9y/FGAJCpxAWQIi8VZjlrCpMCKj+hb/IyE0bftwmioK6GsuWdFyDhdT1e6RLg+Az9wdcwS4JK0QWmMYOEmmqMYl5iWehLmkBpl6vMuWmVUisnkqpxB5pdI3VQcz9huMWrWzqYfWsj8CXDG3INDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7/erhn6; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7/erhn6"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c39cc7083dso1553339b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Mar 2024 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711180650; x=1711785450; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IYoU2KjKropQT1zNo2ZUwG0wRjXsiJxMlPzMjsw6HR4=;
        b=J7/erhn6xGiRGSXx5LiBC+SUJgdViF+Zx1x27Z37T9Qdz5gsdp7tsQQUscghmzaybf
         F5imDJ4bf/d/37kmweFDQZB+h590hL5doKFk1JVHdlATvuWtEniWCEJvhsHQDLTcu5lB
         Apu93Q3mO65lu2NiGVwIZTwm3p4NQMiZjLP2S05Qgq8aWgboKEVDoio7MMpn3zQFBoSo
         +kzKQxCV+mTUlOR2EMFhK5H8vVMITTX4YWhAzGjDoJlpWNRhJz97gNDQ+xsa63c3RzU/
         CWve2Gix5UpMXgcPI4tP37ddlWRrUk7g1Nug75VoRv0F50XwchbTC33HG0nUW1/jCB+F
         2A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711180650; x=1711785450;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYoU2KjKropQT1zNo2ZUwG0wRjXsiJxMlPzMjsw6HR4=;
        b=XYmzwaB+NJQcYIn3DQK945/+Ka3g/zoHZSaDLjm2f6RepanNCYErftrOnuX25LXMJM
         AVeJHWenLJGfBfZ5GU76TkycX7HaSy+Z12PrZVpIfVnYMie88XwRjdXmdyrVq9GkHyGV
         IqANKk87uQl+yAQU7EYpFbYD9gso+9WN8kjklAL/3yNM2gwWSPDKh6EGiM2jkjhGHYCs
         w7ZpG9sv+gS/qrwrGH7eQe5bhMcKzXQ5Zd6jOX1o0bBtEGfohJWoMunm4F/LBaFXUnj2
         cwE6IX9BzAD3/yrn1L+e7np7fSgCP1lndgxOekxEL5aW7o0mbXeWEy1UjW2heNUjWrVq
         KGjw==
X-Gm-Message-State: AOJu0YyRr1TynbdScoLmlP6A5ZfTxMaz88A+CZUjJIK+v1KS5Fg+wcGh
	Ww+/atq5XDnbdOJPC5aayRMUt268GTMsmIEqa+jDsui0E6NHuh//8cve8LkH
X-Google-Smtp-Source: AGHT+IF0u6DD2qBFB5i95x49XS/OZ0DUAkOwXVGsLv3rMJwwBpPvdcdxwv2vDiwnDiUUF6nmZOvgjQ==
X-Received: by 2002:a05:6808:1406:b0:3c3:723d:d21f with SMTP id w6-20020a056808140600b003c3723dd21fmr2486988oiv.19.1711180650204;
        Sat, 23 Mar 2024 00:57:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.46.75])
        by smtp.gmail.com with ESMTPSA id r16-20020a056a00217000b006ea6d1d3134sm903774pff.119.2024.03.23.00.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 00:57:29 -0700 (PDT)
Message-ID: <65fe8b69.050a0220.c10e0.290f@mx.google.com>
Date: Sat, 23 Mar 2024 00:57:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1815589542015714615=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bharathsm.hsk@gmail.com
Subject: RE: Bluetooth: Fix unused value warning in sco_sock_connect
In-Reply-To: <20240323072253.40816-1-bharathsm@microsoft.com>
References: <20240323072253.40816-1-bharathsm@microsoft.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1815589542015714615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837516

---Test result---

Test Summary:
CheckPatch                    FAIL      0.86 seconds
GitLint                       FAIL      5.92 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.45 seconds
CheckAllWarning               PASS      30.47 seconds
CheckSparse                   WARNING   35.92 seconds
CheckSmatch                   WARNING   98.49 seconds
BuildKernel32                 PASS      26.98 seconds
TestRunnerSetup               PASS      507.22 seconds
TestRunner_l2cap-tester       PASS      19.19 seconds
TestRunner_iso-tester         FAIL      34.61 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      115.96 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.84 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      25.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Fix unused value warning in sco_sock_connect
WARNING: From:/Signed-off-by: email address mismatch: 'From: Bharath SM <bharathsm.hsk@gmail.com>' != 'Signed-off-by: Bharath SM <bharathsm@microsoft.com>'

total: 0 errors, 1 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13600542.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix unused value warning in sco_sock_connect

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B3 Line contains hard tab characters (\t): "	err = -EINVAL;"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       6.228 seconds


---
Regards,
Linux Bluetooth


--===============1815589542015714615==--
