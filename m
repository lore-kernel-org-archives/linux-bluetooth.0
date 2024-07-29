Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655715B97D
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272619; cv=none; b=fGm76GZRSPHI+d/oJu+SrLIVMopv1CpSkujqrBqw61uwt7ezjFv/0ocyS+WydTE+2OODrWzCothN66mWQ5Q8Cqs/FQNMQ+yQL7PfKBPbpzK8FdQNi489WmTpIkADsi6waIGbfCDDCQJpJLO2Ygg8nsAQirgy0XtNIVzdWxR9Eps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272619; c=relaxed/simple;
	bh=BaCBgfJwSmuxAqw9FVTWmwFZOXXm8Ex859td0M6wsfs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qev+SlZzMjH03hQ+hvtTugInxAWR0+fcn+M3+ayg863N2N78vwH+N7QQqqQeEmLbWR1oIPefj7HBFonBg5DQF3eMJWixnvQYPiSd5zL1OcMTkUAb3nPlYcIVCOK0RjhHsiSknT0dKS+lgVimEMnLsbycmv45qhHnxeCB1GZoVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhYFDomO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhYFDomO"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d3959ad5so294151185a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722272617; x=1722877417; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H2l+wpOKW6fBJq+Lr/GnQOs3WLLvEIFEy4MgKtbLmnU=;
        b=BhYFDomOhN4HfhT/oiTiJRFgZAM/RiqcXbvyrXq0qM0JFiw+CsgkF/MoTZXx2Ij4YX
         gUfxejiynOUGUQkSs/glUDW2/K/NQzUDoomCf87o5d9pivlJsxz9h84C4O5B48NxpDnI
         giJa4kwoOusFS0Cxg60ca/xuhXIsJbzowmpBZFvoB/4nebHIHM+GMO6SPfEa8lmWiopP
         GRI3QB85r0nxYeQl6jgOeamICKnjIbDfBqSBgZmOEap0V9s5aKu+tGyI8udQhiSuaOxf
         2KzD7IokjZPEfXSlLRushQvHpcq0W1QSgDvlP0Cd0OgQs6EtmGbOfo3mKWfWHT9laNzu
         3Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722272617; x=1722877417;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2l+wpOKW6fBJq+Lr/GnQOs3WLLvEIFEy4MgKtbLmnU=;
        b=N8suZlhpnMyY363Y3+GtC7kCB4oOL0XeyP5/Wv4P3iOzupLIn27ei/WrsykfrFr1w+
         7j5X5BcrVZlTz+yq7zyEr2ZusvR7jlAlK6TE9ozS2ngHtwIMoTv/Wm0jvDOwHWn3aTa2
         Cofvg4c4JYbdiyejewRYKC20e9n/VU82pudu0QF1qS0oSTnF8baShR+EczNUMJ0GzMie
         AwnA9n9q+ppGOeySF2emaaUN2WqJXRjKX+3UmntvJMq1tR45T5gRwyKea+gbmg6zAM0H
         4OlmsN9sI1MUVHSw23aeOXA9dXyGFsK9pSVFZw20uLzEqLWy5IZ7LLieWt5mc79hUpiT
         /4LQ==
X-Gm-Message-State: AOJu0YzWatQ7ORSu1F4E2EBx+E/6xVOKpnCUIjnL+IygxvDGrX8XPX2y
	Y9oQL3TeBxZh0iMF2W9FlC2lvR9qV/Ke2+sqOwRj4ydYoAOxiR0Dy+rHUQ==
X-Google-Smtp-Source: AGHT+IGKT1XjiXLhaSmdBhkb1Ph5r81/e5KNsqSec9IYtk6w6/sQ633a6MkNwjrx153laMB08y928Q==
X-Received: by 2002:a05:620a:319b:b0:79e:f9c8:a235 with SMTP id af79cd13be357-7a1e553e556mr1350931585a.0.1722272616868;
        Mon, 29 Jul 2024 10:03:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.108.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d72e9e97sm553935485a.0.2024.07.29.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:03:36 -0700 (PDT)
Message-ID: <66a7cb68.050a0220.7f724.ffcc@mx.google.com>
Date: Mon, 29 Jul 2024 10:03:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0485715564516179283=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun_hu@icloud.com
Subject: RE: Bluetooth: hci_qca: [Don't Merge] For QCA6390 regression debugging.
In-Reply-To: <20240730-qca6390_fix-v1-1-e0340a511756@icloud.com>
References: <20240730-qca6390_fix-v1-1-e0340a511756@icloud.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0485715564516179283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874645

---Test result---

Test Summary:
CheckPatch                    FAIL      0.91 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.33 seconds
CheckAllWarning               PASS      32.45 seconds
CheckSparse                   PASS      38.40 seconds
CheckSmatch                   PASS      102.24 seconds
BuildKernel32                 PASS      28.87 seconds
TestRunnerSetup               PASS      526.99 seconds
TestRunner_l2cap-tester       PASS      22.24 seconds
TestRunner_iso-tester         FAIL      35.02 seconds
TestRunner_bnep-tester        PASS      5.04 seconds
TestRunner_mgmt-tester        PASS      113.71 seconds
TestRunner_rfcomm-tester      PASS      7.72 seconds
TestRunner_sco-tester         PASS      15.26 seconds
TestRunner_ioctl-tester       PASS      9.16 seconds
TestRunner_mesh-tester        PASS      6.23 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      5.34 seconds
IncrementalBuild              PASS      28.66 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_qca: [Don't Merge] For QCA6390 regression debugging.
WARNING: Consider removing the code enclosed by this #if 0 and its #endif
#103: FILE: drivers/bluetooth/hci_qca.c:2191:
+#if 0

WARNING: Missing a blank line after declarations
#118: FILE: drivers/bluetooth/hci_qca.c:2427:
+			long x_err = 0;
+			if (IS_ERR(qcadev->bt_power->pwrseq))

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#121: FILE: drivers/bluetooth/hci_qca.c:2430:
+			if (x_err == -ENOSYS ||

total: 0 errors, 3 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13745330.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_qca: [Don't Merge] For QCA6390 regression debugging.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "Bluetooth: hci_qca: [Don't Merge] For QCA6390 regression debugging."
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 116 (95.1%), Failed: 2, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       6.197 seconds
ISO Connect2 Suspend - Success                       Failed       4.227 seconds


---
Regards,
Linux Bluetooth


--===============0485715564516179283==--
