Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049D44604E
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321667; cv=none; b=RFL4Si6/qkhqqBmekA7VmZlT+A4GjIBLENL+aI6uihcomAdpRMsS0UrAzgdUzjr6bT1BSGYtA7c1BleW0jLv6KYfITMS7Ek5ZqU83ytREY99XNSjRkfc5MP9Mape3GgTbhHJ17xdMmUgYyFXGn1sSsFvpPZQfXyL291U/jwGXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321667; c=relaxed/simple;
	bh=JmE1geSY5NnyTBDzJR82sSa6hofB4C6ZlQM5VzVyWBg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WW3paL6i6aRdI6sFBhY5Baa8CO2F7wC1X77jZyuoeJ3F5zF0wKAGZvqovSbQqWFK0nyKgUUYxvd3ylXdEbSf/TzJ3rFsmyETFpKxm5XzB1gNOm+M1ED2bf7ebim0OLllHqnYabsbqwPkciPAsiAS29cD1GGh2tVumjC4n+2OtBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGvKhR6i; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGvKhR6i"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84864086bfeso769460b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321665; x=1785926465; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mJbGQ1v/Y05MS6xFXfNAjMtDTYmXCTF90RybzSO8jN4=;
        b=nGvKhR6iSxEWJDp9AjrXUg7ImajevO8G4rFlm2YieFLHWmMf2yW/KrstE3Q1giSFhx
         IeaNk27sKoGYgOGLUvVqu6s63r+IpP12UeLldA+xyvC7Tli7aLYK07E1OO4h/+BsFgrn
         tHJxFEUJqtbce+axYjtUhPmIMXLBBAloMNrr6rnBruZ9Y19f80NKWUiWL0Sy418u99CN
         wpGs65GwqnDnyHeEe9oBJP9KP9CRzlL6cmwKEoCzeyMO6nLasB+dWFbjhzA0i5Z1UJjt
         zKCRl/9WQUaiT1ZY/PD5XG+I0rgNed428tSOZNGbwPYOcSkoRWT6QilQYQCoi/5Qeufb
         22Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321665; x=1785926465;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mJbGQ1v/Y05MS6xFXfNAjMtDTYmXCTF90RybzSO8jN4=;
        b=KckSID3wDkOGnZ0W1kn/De+xXJ2lO/uhLFoY7zE/+3iNmOu+QREMTetPEQNExJTY9F
         TX1k+RpeRx1k9E5MkBJIq1yp5YFMmiDSafKm0qysSIIksDr1O2g98HitJG/DIeqrJNuf
         qGuuAJgV8hpsqoa22AMEMd/9UtnQXv+YHrrHWAIQjPPO9yZryjTvMLKR729R8XNwnkzI
         djpvANwQDg51YRvkEnleBE3fnRS0c7ISu6kZLku2WSkk83eFuo60DNDKDSBpfm4qrly+
         c+DSIymtZXwEETS2RhRFZCGBgwxNJBW4lbCJp6r3+1XQssHCT7l3HRtV9AIGV2ABxXMW
         1yEw==
X-Gm-Message-State: AOJu0Yx9QAHfIfYgIFq6oNcOH2PqiD0KkbIEl2a2yutBZNJ3Vg0BNMRh
	fQ+W48UplOoiVLajo1iMY4DXxkc6RY0FsF52e7xt8161whEwS0k7fYjWp06JcA==
X-Gm-Gg: AR+sD12Zpxbo5WFV/K3Cvg93ds7h+lCpQ1KLo31670ouzkYbZnODk+BRMAaZ19x54ES
	P7D7zz43ramKdp1vuzvBI+VTOEmqW9bWOj/779aXFkaZ0TRmmXvLu1gvF4iyCkO73GUnblBiTGT
	8tOCBln7HXyDNWcgs2O+bZk4u5ezRtLFOz0OK35h6ZIGDWLG4l2vOTz5fvrzxmRuIlXMHuSPILN
	jq9dEzs2oaHzhnvnbirMftai2oQSsWMhwB8jBJqHG/YVgrszPl+qfevz+jCbhOcP5u/5oenw87A
	Z0SZIznEAszUYjiTCJH+DKI1cvbvf1t83wWcJEI/KO60TGDcDSwduEOzV1PcT76LW6XE6fCTNzA
	0n9HtoVRFn+BA6NalUCQCCWwx5d0lXD8b9FuZz/lGwtKmq+Sa8cUOz1D7FsGeQYRUd8XkCHWSzf
	Zz4UJ88Yt2MGx3I5WRyVnn+XNUTCSk1JMuzr5AXKGpfOfD1wt4ZF3/2XHdnUIdnGW/F0Y=
X-Received: by 2002:a05:6a21:4d05:b0:3bf:ba48:ca88 with SMTP id adf61e73a8af0-3c8aaf293c3mr8457536637.15.1785321665421;
        Wed, 29 Jul 2026 03:41:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.55.198])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm9409185eec.14.2026.07.29.03.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:41:05 -0700 (PDT)
Message-ID: <6a69d8c1.0c05e68e.21ca65.b1d4@mx.google.com>
Date: Wed, 29 Jul 2026 03:41:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4970538084061160471=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: [v3] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures
In-Reply-To: <20260729094857.331366-1-zhangchen200426@163.com>
References: <20260729094857.331366-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4970538084061160471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136529

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.86 seconds
CheckAllWarning               PASS      29.42 seconds
CheckSparse                   PASS      27.95 seconds
BuildKernel32                 PASS      25.88 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      497.07 seconds
TestRunner_l2cap-tester       PASS      60.00 seconds
TestRunner_iso-tester         PASS      87.54 seconds
TestRunner_bnep-tester        PASS      19.06 seconds
TestRunner_mgmt-tester        FAIL      218.50 seconds
TestRunner_rfcomm-tester      PASS      25.38 seconds
TestRunner_sco-tester         PASS      31.12 seconds
TestRunner_ioctl-tester       PASS      26.56 seconds
TestRunner_mesh-tester        FAIL      25.88 seconds
TestRunner_smp-tester         PASS      23.50 seconds
TestRunner_userchan-tester    PASS      19.88 seconds
TestRunner_6lowpan-tester     PASS      23.10 seconds
IncrementalBuild              PASS      25.19 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures

1: T1 Title exceeds max length (90>80): "[v3] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.250 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.977 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/508

---
Regards,
Linux Bluetooth


--===============4970538084061160471==--
