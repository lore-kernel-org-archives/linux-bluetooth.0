Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB8303C9C
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175928; cv=none; b=t3tiejcXooJS4bsWRvC9CG+voeI7bVCydCgh2HFFqcumkzoICV8uNo0ABlITtv/4di2tAJK9Am7Ie/0K/HPmiv7zdxVetngwdonBZiIwW1mtwXc0J+kZCNGj6PoTaRYgvViFvbjdjHlXscM6+VtqhRIKCiCJsCAQAdCwOIG015w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175928; c=relaxed/simple;
	bh=eNQ7UFbupXD7c52/BvOel5SC/FgEZNDJi8tWPP+y4/A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=joIUeI01/qGjkkTZeHHDkBZHGD306fgaAsuHsHmUtxb4LSKf+0DEXyaRBe4TsUTWvNDroRXCnEJN8rXWJ+dONf+6nuc3LSpDcO+f0UNXiS43B3SZBF8TOPCoJ/a1AWTZ4WViXYHiCOL0dOyWt2XhgogbuYqU/vv9YVSj6fS1iLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwIKbpWQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwIKbpWQ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a226a0798cso151835b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761175924; x=1761780724; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zN4EuI0juel3rSksFmWzqvPtntuY103rJQjOX46aVgA=;
        b=fwIKbpWQvpHBPPt7n+vR4BoouUnevpKj8mDoaPE4oMigiqV9Y99GDmbE5C2kYS8TRh
         tuAnvtIBte4wf+tFGm3ITiOeTP8UQ4Pvi3H/8daDq1PqJwPetaCiH9ih7serEd2qoK3B
         JE+dRwv7qN6kCWeCScM+ZU3ILSZ+nx6Hvgw/WfUdfdMEwO56JgDVJHKAX+X94I4a72VM
         hFMEWfCQE0QIVpLMLT+X1JVMXw6yuENq5vYID7HDUUqiMJZaZ6gn2/5412eFQB0MjkAY
         b9I9Ynr0+hJpKxjOzVwDgllSLfGN6WooxRbAo+ZTtcu1zjFwwEdWl2sU8XgZqUyWrWvJ
         xyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761175924; x=1761780724;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN4EuI0juel3rSksFmWzqvPtntuY103rJQjOX46aVgA=;
        b=t7JqjTlGsj6CQbZYkV3BMUQ1xDKc4nOrgdgoPq/MVOxhfe12ynMsAxOHT851/BRL8i
         XAVEFcrQOwMwmexUz22tBjM3MFZ3R/GVqh0jP47DCKUTX5/OX9FQ4PJ/V3c1+ZSsPHHf
         pl5Z1tH4P0LB9JuDSNVqTNikKedBuTOZQrWpFqRSE/6x97+bhKZty4bGbXQ/RGyYNlSi
         R8o5OJMXNiY3+IBnLahRFSmVzJcjRl8wYfvAVSUfxetA0w12DUp0GqylectZaTJyDQCI
         /dx59OXfyXarODNls06Hlj0alqRhgGtZsRRMi2rs31k1f6at9PEMusF+YLSst8pIwAfC
         JESQ==
X-Gm-Message-State: AOJu0YxIlVe+e8CoHXGZCGyx1ZqQy9pDcJ2myIIMRnjAIhNVSGK2xAoB
	KA0QfgUyt/ksoA4EsT/N7eeHc8QjktsvvQvJDl73MR0ZFb6HVtpTKJLfI4RBjw==
X-Gm-Gg: ASbGncvsSLlYMivyjZGAWT+3cUUGzuLoiH4oz1bspmnGASmUd0QFq7WkkZJIJFu01q0
	YvJGRP/ic1udGFMfE1lve0ySG8LmX+iCtbgwlOB3GVIZgRshiGqjFvKZl8YTTwid4WmOmfOwrtM
	w4haWKMFLtuBpPbfVT1uz+TIyFgiWmt5SOlgHbVNOHYTzZxpgNTiApUFNtY2NRdWgvpCcJXVEMl
	AzPNRwnIawjJPYiiivI68gwyrw8238TheJGscDgbhwER/H7O9JSTD2yiQbY3Tpl9JZbvyiGWEKj
	jToKo1Jq4xZB3q7kwlOZOQr73AD8PhdzT/viDt8qYJbFJiXcKlNAaSLpxWtEFquBwdjaVJSvxT4
	ySyTSOlb9Ir3FASJlB854wqNj+XW9SPPQ8Kfn5T1MVSkv29EphSLG3x1J6H7akJ6yXYfxuIu+x6
	cZrc845J5Q9LOHavSw
X-Google-Smtp-Source: AGHT+IH4AsgOqUQy3Hy3N0wQ7Vehi+Bid39pWdQL6X9mCPE6gYPeuaX2ShyuBH36z8/pGv8J3QH9MA==
X-Received: by 2002:a05:6a00:99a:b0:77e:325b:f614 with SMTP id d2e1a72fcca58-7a220a50280mr26446826b3a.12.1761175924254;
        Wed, 22 Oct 2025 16:32:04 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.163.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9e580sm412433b3a.17.2025.10.22.16.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:32:03 -0700 (PDT)
Message-ID: <68f96973.a70a0220.114d4e.1a6d@mx.google.com>
Date: Wed, 22 Oct 2025 16:32:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4960163588916649074=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rpthibeault@gmail.com
Subject: RE: Bluetooth: hci_event: validate HCI event packet Parameter Total Length
In-Reply-To: <20251022223417.139332-2-rpthibeault@gmail.com>
References: <20251022223417.139332-2-rpthibeault@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4960163588916649074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1014723

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.43 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      22.80 seconds
CheckAllWarning               PASS      25.23 seconds
CheckSparse                   WARNING   28.22 seconds
BuildKernel32                 PASS      23.38 seconds
TestRunnerSetup               PASS      462.08 seconds
TestRunner_l2cap-tester       PASS      24.04 seconds
TestRunner_iso-tester         FAIL      32.30 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      120.11 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         PASS      14.44 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      12.41 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.43 seconds
IncrementalBuild              PENDING   1.01 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.173 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.767 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4960163588916649074==--
