Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1381FFC51
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338291; cv=none; b=EOQRMXK44RQeFjwdetrOPbu+YUuLVeWTvSgm2EDPy2+D3EJL4yBjWiptthr6V3iUkcW4YykWAw5Sho/KnlfVZZvIhYfJsOEmkHRaHz3PDR49VW3Yt+AUmgFGoC3Df0Hh92h/E1Duw6iVkepvhYqwUTqoOkiYmg53p/ZsqV8gg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338291; c=relaxed/simple;
	bh=MM3xhQvljroKXzstMV3n0pOmHMM3KuYMQtIo4Wa3q14=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UaH1jkUZpO4fBBZOWriq0drUULuiflXCB3P44ODcH1Rn6KewI9TY4LrwoYxjGkVKgEROAtIXIRNHEoUcSJPvemmmZQmO42IrOO8rMKh1lGoKXwQXqTh0SJx7jqWl8dYI0pbCy87KsO7zaBQUD04dvnN8Fh0D6hLBJi+SERNDXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0V7fTwE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0V7fTwE"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728d1a2f180so2761382b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 00:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734338289; x=1734943089; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zDatzOVdaylDp+8wLYRBwtZ6GfpiEPTmuXkK5auXig0=;
        b=Q0V7fTwEOlZ7ZhCTgtA0pT3iP99fK0VvVg+wGJpqu1n+1GwHqMmh58xloP3IF8jZVz
         jR3JOfw5h9GdPHdwTwMD/VJdYRBl/r+fXwo/VOUwl4sdUAxU9YdGyOhqg2UP4yH7UpoQ
         8o/poLNf68ZbtN1w3I1HhDzZUHV+cwha0CGvvxQ5NYKHl46U6PlwGs5LcAulKCDVTOHH
         Zr/AZdsEoo+aIag2wFz7nLZvQsecqx78cvPyahb4qgQqJ1+zn815H/HWN5AjdU2xjndz
         Xz/JGFP0wXH9kZ351+d7YYt5TpRJ13rdFgY6Uqk4AySUAu9v39G6RR4pTDuY+wYnA1Qh
         hG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338289; x=1734943089;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDatzOVdaylDp+8wLYRBwtZ6GfpiEPTmuXkK5auXig0=;
        b=OC1il7ZZfma5t9lqU8QaGkUt7kr1ZHvaw9cWfRlWFfic7AGo2aS8TkOmXDDlSkCrjx
         8PgmqpKEPG99C3vcHwO11Ko9d19YMV2oHc2IqjoEQOvJ9M4BuNFQY+CqiY9XfgK2fY2v
         d9i9TrCl4wgFJBwrjfjr4fsRK3Io4TvhN2Gr0VVcsK+7gQXV8tS8Splw82bblSeYhPlH
         KfZDW2qIaqdE1RPQ5GKPtNK/Vgyg9owwMHSVZSvgDTneva/HrRGSPY4BWMPqAbZphrxV
         7HggT61apF0PXMZtPX/qwYUvZhr5Zd5x1Q+B5qDB+JMMW+Oig5MOVHx2Q8+B9RbRC29V
         FPqA==
X-Gm-Message-State: AOJu0YyeP/3SCj5M1C9wNWcMEPwz1ZcLJl+tDDNJbf93rTqBCJD25HKl
	5YZWFu5iDpIicnDq/Ti1XOfwD/xHPVzxism/KteV8rae4IxMWQQP59wXyA==
X-Gm-Gg: ASbGncs3weFkSpm1G7bf/cTf220iRIRRgfkVzsVIjuqkZTL0dq3H5E6pB4BfJ2EheMa
	hhjRpKLJ/dEbd/hCQBWHgmAuIp3IV1ONzULfvX5khy+HZ5pY8lD4+mxrIvRrW2/iFzPy2oEbg4l
	VpjuaMPbXu0NDmnNQvUfLoQDk9yhMS/AKoTyJVJ8/5ScINrL/pjCG6VL2u9FDavB9hqqH5weXya
	2uQgJL5d59FmZDiH56rLe3OtxCOGa3ecfMwKyTf+kwwUA07x4U8yhYYh19LmQ==
X-Google-Smtp-Source: AGHT+IHDJwUD4v3f86XSm1V71I4FZsGWX+HR9aOfaETXQhabpgamfDiHI+p7P8OFS/DzntJ96lAzKg==
X-Received: by 2002:a05:6a21:b8d:b0:1e1:adcd:eadb with SMTP id adf61e73a8af0-1e1e000c365mr14555449637.11.1734338288634;
        Mon, 16 Dec 2024 00:38:08 -0800 (PST)
Received: from [172.17.0.2] ([20.172.2.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78f7dsm4193978b3a.97.2024.12.16.00.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:38:08 -0800 (PST)
Message-ID: <675fe6f0.050a0220.2b4856.a3cc@mx.google.com>
Date: Mon, 16 Dec 2024 00:38:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7567931763256384223=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix disconnect complete event timeout issue
In-Reply-To: <20241216080758.3450976-1-quic_chejiang@quicinc.com>
References: <20241216080758.3450976-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7567931763256384223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=918106

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.14 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   WARNING   30.84 seconds
BuildKernel32                 PASS      24.66 seconds
TestRunnerSetup               PASS      437.78 seconds
TestRunner_l2cap-tester       PASS      20.72 seconds
TestRunner_iso-tester         PASS      30.18 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        FAIL      122.69 seconds
TestRunner_rfcomm-tester      PASS      7.66 seconds
TestRunner_sco-tester         FAIL      9.40 seconds
TestRunner_ioctl-tester       PASS      8.14 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.72 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.153 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.169 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.187 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in hci_abort_conn_sync+0xc92/0xf30
Total: 15, Passed: 14 (93.3%), Failed: 0, Not Run: 1
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7567931763256384223==--
