Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2232C3255
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777786222; cv=none; b=Rh1ypPSJeOEaplNoj1xrtxnWZldoEilSPMN5yB1mxUaeyJlwAOuctL9AV++KHJyZwXGFe1M/yY1Fkq9ek/Qh19zQ2dBVUAm4lm70asYgJy2d8pbePUJKfYXru5zdxmJ0S5hDKQ8t02uPwlcuybjDep5K8OCLHHPL0e9MWipOccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777786222; c=relaxed/simple;
	bh=Da7x651shsMoObOmRQT14K3uVQ4+AhJOpyXieheINFI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J6s+W82nYNfE1G2mfPbKdYcYWKi1wsHKuuTZOB05ijVyGmKcy8HN56LVcwiGPq/Kg0VowyBGBc1T/Iv456Y1+pbAEU6u/VHNDTbgP+tXQsbTcydwjgFe3BVdk1zknLrAZVgI/XHhtss4aqGbImtuKcdZ+dPUHXbXyRUXdLNTNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtN6OaKs; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtN6OaKs"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2dee127b3c5so7435942eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 May 2026 22:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777786219; x=1778391019; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tq6vuaGxn49kYymAIKf6uUAO55t05c9by/Zzo4r06WU=;
        b=JtN6OaKsiFCyPTJqh9VDuf44LR1s/PodhsSQkdblA9gp9uH8L/P2Jv7uOosvOC8mix
         bSBGDY604b3wTM6PV71/POSaWq77E/NxGhIwIYNqH4VVReVz7AiqnPcWHUUcQWEKX5aF
         Z75MkPUxjvsi9UGta+/cqTNQTrkdkwR0YCdK55G3Bst3ALldPgURk6H+VrGG2LOwlPDU
         KMHBWArbWqN7yKVsnME0JRQ+/rZzXME+WluiY4RKQ3LjlJGCqMlUxV+pV5sf+x15aKnR
         hEBMZJ1wvq5vkBEUVau7EIBHgEKtRf3racApz6NXE5EOtFzhcdDgypxw9nFeSSAQZoZE
         5kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777786219; x=1778391019;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq6vuaGxn49kYymAIKf6uUAO55t05c9by/Zzo4r06WU=;
        b=FuIjqxNWyxZdxV9iP6yQbg324vS55bGaJH3Uy4cx5rbj1N1lQSm0roWc3FaTJPjsFa
         Z+aTLGJFEsEh2GP880irg+lgU0pU8b4kxVovruqZZOA9+beYWXpe/V81NKKeC0MODDBs
         4ctzB8D4YWDsiEBU+HP/oMrp8FRUiQAyvowG/EserUPeq8S2XZ7dtykzpJXBF4yE2UCd
         T04dUzfQUKVh0oNrKVG66DLNMLx/q3b3SSenDQpzR0xTURU6ZtQkq71tO/GqpnetgUc3
         alN7AeCTFd8704hc1t6s+7+ziFyN2dgGrTFLq5sGqPc7U8JGKL6pPdW6/YXDeQ7ESkBy
         kbqQ==
X-Gm-Message-State: AOJu0YzHWDwmPot2IX+F+t0tYUukAHIT9btg5mg2Gl1ceUWidiU+mCty
	dNGGOGC0hq1Is3K4rn74/RD9egbhUIYJM7Kxg9vmGTBQ/RQ1Aud/cMCq68hDiA==
X-Gm-Gg: AeBDietSC04rLVI98nk68nLoN5MUprC2VfqvE9mjYPvDE5sokYARtfArnlQH2HiPrAo
	12o1J9Afk4Tozj+IJFgJBHYbmonZ2euBMxzoQPtliAyk1VL1KEd6Q7+bpN5rFnQGFwelZZBpf7b
	POso4dinoFLvlHAWq3RSttg7qYVbD8642LpOI/qucAeFgapnB4dnJfOOcy1NjBc3pplyaHoh7EW
	p4DALxRzNFhYHrc4rQVJ4a8/9dNQ+I5gy1r29Bu8yxlZ4NhneKbHHFbIEXkLUHxCLhngowTZSXA
	xSdIn4C17DHKGn5LdwFYgP7XDcORVObVImDEj9LIMTMyEivHLrfVIA8UJFBX6QcuCmCfGo7zl1f
	AH1l5tyzP17wCuhoh1f9MHg5coYKg4YIMAQryuKw/0eRsLOIS8ayoQ4WRe9XqtyrK6u9gAoFqBb
	XBrQ5ftCpviZjyLkjHapjDPGJqeqEF59vHThJvqzUxkw==
X-Received: by 2002:a05:693c:2d83:b0:2ed:e16:6b4b with SMTP id 5a478bee46e88-2efba5a5b73mr2305842eec.33.1777786219270;
        Sat, 02 May 2026 22:30:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.226.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm14246283eec.1.2026.05.02.22.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 22:30:18 -0700 (PDT)
Message-ID: <69f6dd6a.050a0220.1e1a19.d4b9@mx.google.com>
Date: Sat, 02 May 2026 22:30:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5366170216803827139=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enelsonmoore@gmail.com
Subject: RE: [bluetooth-next,v2] bluetooth: remove all PCMCIA drivers
In-Reply-To: <20260503033201.19719-1-enelsonmoore@gmail.com>
References: <20260503033201.19719-1-enelsonmoore@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5366170216803827139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1088873

---Test result---

Test Summary:
CheckPatch                    FAIL      2.54 seconds
GitLint                       FAIL      0.23 seconds
SubjectPrefix                 FAIL      0.08 seconds
BuildKernel                   PASS      26.12 seconds
CheckAllWarning               PASS      29.00 seconds
CheckSparse                   PASS      27.51 seconds
BuildKernel32                 PASS      25.41 seconds
TestRunnerSetup               PASS      573.71 seconds
TestRunner_l2cap-tester       FAIL      6.60 seconds
TestRunner_iso-tester         PASS      295.80 seconds
TestRunner_bnep-tester        FAIL      6.69 seconds
TestRunner_mgmt-tester        FAIL      8.93 seconds
TestRunner_rfcomm-tester      PASS      29.00 seconds
TestRunner_sco-tester         PASS      66.20 seconds
TestRunner_ioctl-tester       FAIL      37.46 seconds
TestRunner_mesh-tester        PASS      27.03 seconds
TestRunner_smp-tester         PASS      6.68 seconds
TestRunner_userchan-tester    FAIL      6.77 seconds
TestRunner_6lowpan-tester     PASS      23.02 seconds
IncrementalBuild              PASS      25.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[bluetooth-next,v2] bluetooth: remove all PCMCIA drivers
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#135: 
[1] https://lore.kernel.org/all/c5b39544-a4fb-4796-a046-0b9be9853787@app.fastmail.com/

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#309: 
deleted file mode 100644

total: 0 errors, 2 warnings, 109 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14551781.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluetooth-next,v2] bluetooth: remove all PCMCIA drivers

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (86>80): "[1] https://lore.kernel.org/all/c5b39544-a4fb-4796-a046-0b9be9853787@app.fastmail.com/"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 0 (0.0%), Failed: 11, Not Run: 17

Failed Test Cases
Device List                                          Timed out  -30.832 seconds
Device Info                                          Timed out   -6.180 seconds
Reset Stat                                           Timed out   -6.183 seconds
Set Link Mode - ACCEPT                               Timed out   -6.186 seconds
Set Pkt Type - DM                                    Timed out  -14.376 seconds
Set Pkt Type - DH                                    Timed out  -14.379 seconds
Set Pkt Type - HV                                    Timed out  -14.382 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.385 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.389 seconds
Set Pkt Type - ALL                                   Timed out  -14.392 seconds
Set ACL MTU - 1                                      Timed out  -14.395 seconds
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/141

---
Regards,
Linux Bluetooth


--===============5366170216803827139==--
