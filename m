Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4A4594A
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jan 2026 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768740659; cv=none; b=GrVr/sznvThbyWoIha6hxjyjl4W0BwRdXl6Iz+0LOp63kyGTykGitBg+gvPyncdjgNr/+rzJAigZWCEPas9doecDQ3qN503S1lumfvwqV2+MlYXGwjY3WDDcSVg9AF/gnSYJrSXhyTR8HtIdjly7e8uTyMHl9SfIslkuQhqVyTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768740659; c=relaxed/simple;
	bh=ZVFkNzLIKoQcVVGLMEx8hHuZbaLMrQYW1VcP+YKX0Vk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pw0FF+ypcbmIZfCNLNobTzh/hlIdLcadt/k7CAUo7lEFW3LwFJyZj3DVI+IVxyvEKDiHnnyHetQwB+1ggg4cWWwVIn+ILXUSHTQp6EiOLzOtkPcYFXoNE2so++pRLuwA0ut4n2qEr6QRgpVHFEbKv2ea7HjAxZ2ZVE9ZkLjsM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLmnAWxU; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLmnAWxU"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so38112346d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jan 2026 04:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768740657; x=1769345457; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hqdiARRbh7ZOwbd4gIpLZih9U8/C6XQAooM5yb3kShs=;
        b=gLmnAWxUnGk1dFiphD8E9CLP/KPC4rREPpK0cfXAIvFzHR7Ljr072UfOuKZpd2icAc
         SwdcPuP+byxM4LVDxlslMc21ZP+W7PC5SEZ/bcqvw/Rum39/6bzyGn6+WAL2gVi9wiNg
         wKIb2ZCrSixnIwfxKCLpnZKweZem06m00XPV1gIQrJbuvYfYhWYncIWxtouVsc/E4JGI
         gWeHwiN501c+37xiCqEO2jckhUh4+QtoCVas2iInvOwCwIojriAbfOILk2WuPQqIvVe8
         0HDf/rcBrVd2rEIfD56WY8a9SVkr5mthKhsXdQXuMhCcZDcPohF7K/CAaJcJHmqePqD8
         oJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768740657; x=1769345457;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqdiARRbh7ZOwbd4gIpLZih9U8/C6XQAooM5yb3kShs=;
        b=Pf61x6D3sIONC8mDSPBGiYzf/qZ8piPuQNE8ElMw9gR9eOhVTaGH0MGPYhqjujoxZ7
         2tScfGTOpzbtRJmd7qj9+fth+ozwL2vvJlDREOEMLdoPFKLbNypWjAHWwLYinu27EN6O
         YnywekFc/OLkt8JLnl5hG6T7vGZll6dIC4u8ZXRnKJbv6HwG6RQsE6zap3Tia1YoKW+4
         v1dhT/eB7c6d+qM2cm9HW39QL35DUbs9Hxh4ouE343PTjr0SZJsNKdVNdM9fgTVd8U/C
         ZCYg0WKKsB1saL0eNlQQFIKDhPvkTIkcxUDMks8SA3SZ1MTJGT1+8hgR7fVdurSmgQY3
         zPTA==
X-Gm-Message-State: AOJu0YxP3mJKvgd40mJFYvoTlJLt1B+KlzNUzbZGRBheZDwoBBYNhGqN
	rbicUa2WlvfhuRUiTdXd2MRb+FVi8xrl2uGNXC5gU2cAGgr+J/ASNLTlkC4Ke90n
X-Gm-Gg: AY/fxX6KvTKPGAZkjZxNwae2XGMOlu3XJUdMDKUjiKKz4HZ+jD6rohh40eZpLW9XYAT
	3xFxsnSNwH7NoLm9cOqntWb+8mciKWWWBPE/FQdILMI1BhbOP0jKJUsKtIf8APHqGK+Mlz7LZ6f
	4gx+wH7a9PyfXK3Vpyi2coVfUtofVMvbKPOkgS+pY7rh8DsBi71QpMWgI4zKMLHkxn9OBepgaZA
	DCCU73T3sO9ZKM/iucdIbEXGc2pLrMR/h8oAn1ofY3fMjmxzsWgXNGROwc46EusnuQBwyYGf6HP
	W28fAhrfeAN0EepI22jeNSScdaMK4rH9M8XuW7Hm2FjZmwV1uJ1K/YTpRFwT1aOV36y3OcjaUQp
	timPlKO7PVzKOFpGy3RgSI7jDXS9vSKhhH2yLJJLMRVW72nM4jOZfSxH5jc3acI0o4g6/e4lnPo
	7eMMZlDAP9s881AwzW5w==
X-Received: by 2002:a05:6214:c49:b0:87c:2967:fd32 with SMTP id 6a1803df08f44-8942dbfc023mr114671996d6.22.1768740656960;
        Sun, 18 Jan 2026 04:50:56 -0800 (PST)
Received: from [172.17.0.2] ([64.236.140.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6cd63esm60634896d6.49.2026.01.18.04.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:50:56 -0800 (PST)
Message-ID: <696cd730.050a0220.1f890c.f0fb@mx.google.com>
Date: Sun, 18 Jan 2026 04:50:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5335792847559481732=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, s11242586@gmail.com
Subject: RE: Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work
In-Reply-To: <20260118120859.83680-1-s11242586@gmail.com>
References: <20260118120859.83680-1-s11242586@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5335792847559481732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1043777

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.04 seconds
CheckAllWarning               PASS      27.60 seconds
CheckSparse                   PASS      31.89 seconds
BuildKernel32                 PASS      25.09 seconds
TestRunnerSetup               PASS      552.87 seconds
TestRunner_l2cap-tester       PASS      28.40 seconds
TestRunner_iso-tester         PASS      73.56 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      116.30 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         FAIL      14.45 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.75 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.870 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5335792847559481732==--
