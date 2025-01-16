Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B317BD3
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990188; cv=none; b=U1errE5nQO5/KaST5FQK4/rgYEXLgCpN3dgTylRGAD/T4T7InykKq82uNowbwUs8AKrtJfxZwkSQa/yGOG8s+ieBpqVmG7mC4+PWM0jPbIPNaeg9w3H3HkyyLZA7EDoD6rC/N6dx7ZXjcSUafzKmzRPoRL6eX67qVfeqwPzUJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990188; c=relaxed/simple;
	bh=6ZyilhLj0OEsTvq9R8sPh/uLN0mVHDQMnmlZ+8jzXA4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HfCSxOZHvDaPN0weppGy1nm3qrn+tPi9wmc5/mHXZ0GSTQ0WJGqF9BrITc7htHA6EgzDdhb+D+L+XGXpz9kH7GSU1nWWWfwdEV6+zMvj3C3kwuzvqnDj/81nEvuXGLKHOgHEwjBINHm6lxljNC6/6cywNX4OwGwQJkEw7md4EDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEXhforn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEXhforn"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467b086e0easo2821031cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 17:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736990185; x=1737594985; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk/T4y7wWvw0cJ6XBiHALrh9ACvwuVpI5US6Mygl39s=;
        b=YEXhfornwv/TyPJu9UWngkp5ZVDQQ8PvrDTti2pK7IevhWGzV9NHZRyOyqM4x55VXO
         MTRbeZ/slkxijm7O5OOWZjvkiVj2LR38dQbZZ6dm3JZ2AZd4BCqBWtuKGjwU4V/8+yRF
         gKcPG0iQhHmkvyEMmilEyB7Sf8M+uDq4lffYwt6quYFg/oa4yHda84tijpXtAfRy43+X
         sKrZ2IqRz69GK/hfLrsQK+WzeYgzbdQYk3M+3UuLo1cNLQE8MBxvCaePfQwX6rwGObin
         7Dcf66XXDlkfzuBL+sjUjCGUHBRcSjtFhAHmETTgHZXKx0xyYhMPV1L8gVBbQ3kd54hJ
         +9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736990185; x=1737594985;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pk/T4y7wWvw0cJ6XBiHALrh9ACvwuVpI5US6Mygl39s=;
        b=c+/lyOtG1zd0ycScEcWLSpx33pJT98ujiIWIuwPJ+HZIHRhWu+pFfh7P9uF6xI+/hV
         YzRaAxFiG3uScp+E2cYWHVbDHc+o7YXaLW8m7xE6VpgHUtivK2d4fBBk8rLNofwFjJ5h
         YEbiA11lg2m5TO2Nr+BZcVBTsZni2dmTF93Q0Tc4RaJf2CsNhbZuT0v43BDhreuxOIF4
         W4dEx6ZuTKsuH3KiXncwMuCS06IoUZXB0L7ZWdPgPr5FGfyih3meSgGyxv26XuRr/cpC
         87DzZTQlMPUkxK1ELQQ/TaDWUVa98Iz5ZPespCjszSvNMyzNegSqHR9BbCTxCj8MFxdD
         hfWw==
X-Gm-Message-State: AOJu0YzrS4DH39jBhgk1ckBP6B6qaB3DfYvqvNJaUlKhwvsDD5Od1+z3
	qmLMIC2zdPm+73SBhQK8wGhzkkJoQuaJX6gXk5WFOBtNcVIVuGcXD5AqWb4v
X-Gm-Gg: ASbGncvdnWWsWthxuZU29nCWsjO3UB4V1ty4FbQHUTgsnBbfMEJMZqgtbwj5t8Sqrp+
	6WbrkHw6uhCBdJyYTyX1JYarMO9EHN2m9352nefPL4mbCuXLTGBEqnjTenrb6URgKztZ3v0bZ34
	qPQc/qonKJRcrkp3fYjuruxYnq4XleUJ3OWzDT+nTSYtUpFB5HIhldtZrZdrT04IW/+ZIDY+Yxf
	lIhlQrNn/2cswpudPXcDpl4u8wwzuF1yG/6QhUzPAFtdHNOagUNNaGDEVfAwQ==
X-Google-Smtp-Source: AGHT+IFV7twy9div0eFK2pbhcQdBRBvs9zYZFHJaxyrwhSy/W0+Wf8qglDP50Ul/zlNbWbDBGQRLyQ==
X-Received: by 2002:a05:622a:58c:b0:467:70ce:75e9 with SMTP id d75a77b69052e-46c710a9234mr456917191cf.23.1736990184996;
        Wed, 15 Jan 2025 17:16:24 -0800 (PST)
Received: from [172.17.0.2] ([20.42.17.121])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c87340bbesm70182981cf.39.2025.01.15.17.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 17:16:24 -0800 (PST)
Message-ID: <67885de8.050a0220.b0fce.b1be@mx.google.com>
Date: Wed, 15 Jan 2025 17:16:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2662328511730120379=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, doriancruveiller@gmail.com
Subject: RE: Bluetooth: btusb: Add new VID/PID for WCN785x
In-Reply-To: <20250115233449.59046-1-doriancruveiller@gmail.com>
References: <20250115233449.59046-1-doriancruveiller@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2662328511730120379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925875

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      26.14 seconds
CheckAllWarning               PASS      28.44 seconds
CheckSparse                   PASS      32.32 seconds
BuildKernel32                 PASS      25.76 seconds
TestRunnerSetup               PASS      453.19 seconds
TestRunner_l2cap-tester       PASS      21.12 seconds
TestRunner_iso-tester         PASS      33.01 seconds
TestRunner_bnep-tester        PASS      5.13 seconds
TestRunner_mgmt-tester        FAIL      127.62 seconds
TestRunner_rfcomm-tester      PASS      9.74 seconds
TestRunner_sco-tester         PASS      9.73 seconds
TestRunner_ioctl-tester       PASS      8.49 seconds
TestRunner_mesh-tester        FAIL      6.39 seconds
TestRunner_smp-tester         PASS      7.20 seconds
TestRunner_userchan-tester    PASS      5.23 seconds
IncrementalBuild              PENDING   0.76 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 4 (RL is full)                Failed       0.262 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 34 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.109 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2662328511730120379==--
