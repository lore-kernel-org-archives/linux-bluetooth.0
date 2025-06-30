Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA74241CA8
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272873; cv=none; b=BlPiREcJbqfcxZ8PW5wjpwPNgdyAboOcIme53beMvmJD4/WlQvEQp/U6HpskW2/h9+W15QIuJQmNiAaYNzGUaBXCVqqiMG6v+ZGi+8Awh7V63cqZcSX/2F6EnMFMXp/iPvi7Me+Yp1wvuRFfV++ab5DFO6GGfJzF4NizWnKsemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272873; c=relaxed/simple;
	bh=QtYwqDUgWqjYUG3Ars5UsaWDoa22BPft6BuFjNEiulg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ShfoZn77nyU2jCbdiYYYDbv6WIfp5Jt+80xlSTA2MBsTTcUdef/H6+Iz2lNbkjHpIrV3P9TFs94ct2+bjMt6xe4JnVVdRrcI23pH+5ta9Zerb6tmY3giTafN/NJssyl1tIJYOqUvDXG6FSDPvHrCO6AfaeTV7gLhaCA0/ZqII+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klPJU9Se; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klPJU9Se"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a823b532a4so1499091cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272870; x=1751877670; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UyxEtBjfv3OSZxMtTu3lynohqCRL7/G2z2txWY5fUJk=;
        b=klPJU9SeFZVvr4/ke3/eS4hjZoxMy6CMdOhSy/ef284ddnvNvQoqeM8lhCQuO+a/cE
         rdu4siAzbAeUjORImh898wLAVgdeb9UfUQw53P2jzfGXrI9+4Hl83pyguUGwSgVOmKHQ
         GQMyq+IsOv8tI5VpFE7qJxKhAkSz5GEoBPC64h+sGNB5aiq7LWMTiTaU8mt5qOc+1/TS
         1r1dlQBS/4nrN+bt3idPl+UlThkCEZZkQUwf8qSSL/oH5eIu2qrz1y9WmzPOfv5ot1FA
         pXcrT3KfcqZ3l7LH33KCSYDSlYt6Av6/HBh9kO45k5PgcBqfw8rmwkHbU90ObVSN4bsg
         tbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272870; x=1751877670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyxEtBjfv3OSZxMtTu3lynohqCRL7/G2z2txWY5fUJk=;
        b=leO/mZYb1KYcIJy/Aup9m56BDJWTKXQnol84UMCcHqB0knCpAe5PiJTaJmfQHGI8qE
         6lKaAH1OHmx8FNWmiSQNkypmURVsXeAEMK9m1VTt3YzxVpm8WFxRgIN6EmsRHn7FKcC7
         qnYZ8QaqsCl2st4JYFlnCmZGy03I30/TCx/HoEAvDZticUTG1i22/16Ma4Myyc3/NuOD
         uln5taCQMcz/c0IA4gftb9ZcRH8qYEjPuOS1zrJ0IPnI+f+8EER6DbiBTkxMUEQKpIhz
         np2VRpyIIeIb8RxsEn5lNMYI7d8hEGOuB3Cl2bxsidedFrBpthqEYjc2PDysHu20me/5
         Ltxw==
X-Gm-Message-State: AOJu0YwZYqx3boYBc7L75yB3Q8aU2H//axBoWU2wGFRwWVPgizq9tphc
	LfX1Lir4SrlWpkB+orYoEAjnWPhzjSCWDd46txV+GMaFf9uvZ9DI/jVG8cA70A==
X-Gm-Gg: ASbGncvO5/m15loDzi/NG7vLn58UfXTDAebiDhULirb0Ax4ealYp/J30KOr6jdR2wrZ
	qjJzuYS1wZDXol4F1n9uTnXFOEZoRZtlWxo/5JKNio+fubID97Dm5DWByimrb8xz13re48VwTuG
	Zidq5W2nTzn3lRNrhvmR0x/w9UsrnJk3JKBTQOjY1NE9PPe7IpsrAhWdFHTCZaVEiwIh0mVfWYV
	jGb8Tp/SLekl8wtSeggg4BXmRgCXnHaDGSb1+J9du530EkqcZ1fp/WvV6SOkUqP616nNgWpKVSk
	kWN34pMWLMFQeRMRRRRACPSTj1zXcDU+cIvSz458hZm8Oo9iuW5zbfrNx3bf1UpZEHFPRdKu/ab
	fbObA
X-Google-Smtp-Source: AGHT+IGkOGMRh7/+i0THtUJyfy57DokDDFdQ4hiUXCuSnzo8KgZZFay+kKYJnmg6USotbNDXoSVSiw==
X-Received: by 2002:a05:622a:58c8:b0:476:9847:7c6e with SMTP id d75a77b69052e-4a7fca24993mr221921541cf.19.1751272870100;
        Mon, 30 Jun 2025 01:41:10 -0700 (PDT)
Received: from [172.17.0.2] ([128.85.161.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc10620dsm55378891cf.7.2025.06.30.01.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:41:09 -0700 (PDT)
Message-ID: <68624da5.050a0220.250d4b.db51@mx.google.com>
Date: Mon, 30 Jun 2025 01:41:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0132747665496435245=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shpakovskiip@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Introduce minimum limit of rx_credits value
In-Reply-To: <20250630075656.8970-1-shpakovskiip@gmail.com>
References: <20250630075656.8970-1-shpakovskiip@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0132747665496435245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977196

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.68 seconds
CheckAllWarning               PASS      26.93 seconds
CheckSparse                   PASS      30.34 seconds
BuildKernel32                 PASS      24.09 seconds
TestRunnerSetup               PASS      471.10 seconds
TestRunner_l2cap-tester       FAIL      25.49 seconds
TestRunner_iso-tester         PASS      36.43 seconds
TestRunner_bnep-tester        PASS      5.94 seconds
TestRunner_mgmt-tester        FAIL      131.35 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.79 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      9.37 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.22 seconds
IncrementalBuild              PENDING   0.81 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 68, Passed: 64 (94.1%), Failed: 4, Not Run: 0

Failed Test Cases
L2CAP LE Server - Success                            Failed       0.112 seconds
L2CAP Ext-Flowctl Server - Success                   Failed       0.132 seconds
L2CAP LE EATT Server - Success                       Failed       0.142 seconds
L2CAP LE EATT Server - Reject                        Failed       0.133 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.189 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.201 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
WARNING: CPU: 0 PID: 66 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.144 seconds
Mesh - Send cancel - 2                               Timed out    2.014 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0132747665496435245==--
