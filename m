Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C32EBB89
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009380; cv=none; b=qxZbRbuhml7rIcOWZ3VNT0fmvHXw8cUq3djy09h7ZzXxY8m4hdzDL9srIaitUAm7vWVhBouXIP5twogm5u33EqXDJgrNgf8WzoOafQitpDsx2Q+jktSjgurgny0wqSIQ9nl1Se02FAMBSt4MCmV3+X1HIP0FakiJb6oDbVcmxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009380; c=relaxed/simple;
	bh=PdmmdTodcpY/dhQgyJOjnWIXl4OABIi0Kn0lRLQdPHs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lhmF/mtygcB80r5gjm8m++IIICUb2TmqKlWFeW63Lg/2uEbSsAJNNtfXvQ/xU+48QVQxhD+NrYZVTL0e8Ago3RMq8H1rNoddFCFX8eLcExa+iMkdF/H9ij9QVXUKuqkEKtwO4ghMgn9EXd+LuhrXMFKcms+KhMV2NRTpJKzxYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWa0j9rO; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWa0j9rO"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e55b170787so5279295ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755009376; x=1755614176; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i0g/qD6aHUDkSlZlcasSdbtme1XsM4kyX3x+9slLXxU=;
        b=FWa0j9rOZgVlgNwzfqJlMCJE5zjTF8qxTYZeBH0hFhL6qWZfuc7s9eBnXu1oh/lROG
         ld58xNy1Pb7lzYXsoVeyzOQqpJtxYUlt4U3CaRAzT8t2Kf4hN3xwRgi9jCsqXGlPXFzH
         56UFaKNpVMQNzuirg0XCYB+Oe/27zq2Mmrsge1IpKgL2sIhSpWA6Bxc73Icbj6ujV0Sx
         +YxVdeEqtywVi5hjQehxWkKFv4eUWpeAb1eSBVZWtrcCElsLuOWpHU/bTi1b75iQ+ZF4
         331prD7FqyEMSgLBgDlb7TXjl5IXWcaYlAEkleK1II30VJJBrkeM4VEpR1GASI0eSh0U
         wcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009376; x=1755614176;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0g/qD6aHUDkSlZlcasSdbtme1XsM4kyX3x+9slLXxU=;
        b=XQVlusqkXlVR8VeHQCQsS8vv8ry289C2yrVcmiBe8SIeGroAmuSIi1z1Rvmq0Py710
         FKhu5Tp2KlV1QuFRZxoSdKpMJSPg7uvi+0eQ6Zg5Jl87sFXIRxNNoYzgGQFVmxC9nXgE
         lBU8CD+vw4O2ZQWC0HSZ29YCax0r3CjpHiQwB6l1f3aBrkgA7mANXFYnGdIcjlx4xf/Z
         Zo9euxpoNVNqmMkei1IlKwv7EnUqfkcozEi5xjG+XDUx7YzmhClXEEmrQkEd+2cGYSEb
         zD4gRMTmyez2FWeBCAxDKywLy1Xcf6zkx3+LX9L8uIfh+nFhnzPoX9d9odmYevSBL9tj
         H/7g==
X-Gm-Message-State: AOJu0YynB3zbgpRMtxuOdebJmge0TQ9kEHoQRYS87NYEsD11UCWtEwgL
	CUFKkIlZ+qJ+Kq7LH/cmGwyrwC1NaG1VrZDu6DtDcSX+BdMacrs9k3ZMz2MUKg==
X-Gm-Gg: ASbGnctCEUN1k0ih1g8ZqLh9CdD/kDVodgj0ntZv4qaVD3zJbW70Qq1IP+SpUfGg8Ex
	LeakohtmoXOTfjyMjUlzh3aBUcYH4kz5lFQ+0u4M7z5ZPVwuEsoczX29a6vBktbLgxo2oYhASqT
	HojM3F35nAtgxfFJoCCz7n8EXtUL3R6rzS91e7bXWjVUjUdDF0zyJdEG33MpM3SXps3snRW7sQa
	/WG1vQD0jtGIUi2M0XXSkDf9/q2rgp21bUntZgjlmYOUn8aBK/VCmR3vbm0GfWuWePSYDVccxTg
	s6FEdHoFuaziEY8Ryte0UbSE7nzSpqvrx8OrNj8i2HTtYQKdwVbCzTf4JdWv8/s9JV7mXtCfChl
	t7G0fjkWtXuMsuyeuWBTyHSTCHrYwDA==
X-Google-Smtp-Source: AGHT+IESLykBD2IhWC/rV7SEtVW0lEdDl2wg74a2yFyRXRB40IRhuwYVdQR1l0LWK/xMVoWABI1CWw==
X-Received: by 2002:a05:6e02:c8f:b0:3e3:e633:ce03 with SMTP id e9e14a558f8ab-3e55ace11b2mr52534915ab.9.1755009375594;
        Tue, 12 Aug 2025 07:36:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.237.211])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e5535f6e9csm17452225ab.20.2025.08.12.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:36:15 -0700 (PDT)
Message-ID: <689b515f.050a0220.30bf0e.2b47@mx.google.com>
Date: Tue, 12 Aug 2025 07:36:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3785551809722258420=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ludovico.denittis@collabora.com
Subject: RE: Bluetooth: hci_event: Fix connection state issues during suspend/resume
In-Reply-To: <20250812141028.509783-2-ludovico.denittis@collabora.com>
References: <20250812141028.509783-2-ludovico.denittis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3785551809722258420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990596

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      24.51 seconds
CheckAllWarning               PASS      27.11 seconds
CheckSparse                   WARNING   30.90 seconds
BuildKernel32                 PASS      24.41 seconds
TestRunnerSetup               PASS      488.03 seconds
TestRunner_l2cap-tester       PASS      25.51 seconds
TestRunner_iso-tester         PASS      42.81 seconds
TestRunner_bnep-tester        PASS      6.11 seconds
TestRunner_mgmt-tester        FAIL      133.96 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         PASS      15.07 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.36 seconds
TestRunner_smp-tester         PASS      8.70 seconds
TestRunner_userchan-tester    PASS      6.32 seconds
IncrementalBuild              PENDING   0.53 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.132 seconds
Set Device ID - Power off and Power on               Failed       0.129 seconds
Set Device ID - SSP off and Power on                 Failed       0.131 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.988 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3785551809722258420==--
