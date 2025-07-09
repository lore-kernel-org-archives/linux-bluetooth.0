Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1E20468C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091030; cv=none; b=BdtWA9fnTddyAcsCw6fEk7VHM0KTjLIOCGCQoFLO4i+Nx6EkkhPMvLxYiDWmqbvoauFQ5rkNn0wfcVjsue78ylgTKI1o9y0qQBD8QPXo9fTuaB6vyORBeQxi0nR78XpyismooEe04AAdX46IhrBOLnWSpqqWIJf5iwm+ynPKiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091030; c=relaxed/simple;
	bh=gpU87XEdX3l0mQgVT4lH0tCgzK/so5/s9aFlvNjtvI4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U+rJDSgq7Dun5K/CQmEorJaPMlsuI1VP/rD0Rut4R6bQp6Dx7UMdtz1g6Ue4BL47gKxwFj3ESvCNNtLlI+3Q9g91fKXH4hofXeTzjOtLYNuKZ0wfzV+Tg1nzFERps5g/1ZIeCbR+sK64MFjLRqCIxEe7uea9Ic7UahXyUJ6fmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgbVaTS5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgbVaTS5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so367354a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091028; x=1752695828; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Nvjkz2p7I5m46fNZlK7QlNDCQwkvjTaEqCKPkS2tJ4=;
        b=FgbVaTS5sNctWdBI3ZAZW4hIRmV77EULt8vsze/DBYJ+QCzd9lrmXUDLz+ymPjeDpw
         9Tnik1SZn5YxxRuFsPxcDC07KlYEC+o8PM6BVUX//PNO2KNa/unMYQUD3QNgKF498aGx
         84OmaNo63XGQ0wM2N+7phN/tf0xv/CtWDrwvUdUo3m6FA8Qu+K7kLq2u8S0tpNTfBuzM
         DMHm/rpvT7l43VG22lLm9+1CHucabSiQ667lqNLvhkgBrlNy4zpjzGqK8/4V7VGSJa+y
         JblDlgotDojHA4rrsX2GkT7dLyBv8qnEMa9Rc4ek2r8ZdsEW8bDji7NH8NFPoCt/XlsU
         i5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091028; x=1752695828;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Nvjkz2p7I5m46fNZlK7QlNDCQwkvjTaEqCKPkS2tJ4=;
        b=SFrfegZvUdzIVRFPm7xuuBoHmdmGthVNST+NeSuVwr2X/97tbDcXU10wzA+WuO8efI
         3ul3RAcBNsjjnUvYdtLPhswiz7+mz8+ljsgdoWdHnXJwmieO7pLtIXj0pCSTSaA5kph2
         0XMeziYNmMDo+Q7Vcvz60T899aV7TcudgQgU/pwMKzy1Y5oT7URUKn1HQhGDRWFhshto
         4hIPBZ0ceArR9KThhyaZjeCFvfmXwV5k/zvvAjQfG65ZbO1mQ6SJJ5dvx2lUVenEJZV6
         pZcT8LE5M/ffvC9vn/lD5siyVrkSVzdWKzkGLNBUAM4X0wXas2MvfJheF6ktwsdiRQAo
         Cuaw==
X-Gm-Message-State: AOJu0YyslfUwJKi5233LZuEweN6w2iohhuLGlvk5dmVMDBmT5vtjSYwg
	BBcRDZh1U5D5s4VeMLJJzaA4Bn0Y3qtzh3yEuDFP8VYQhv9VWBj+DA0IABsAIw==
X-Gm-Gg: ASbGncuUBUeKefh5P1LBbGDkjqqRUcvJ7a76F9kNI4nFQxuiUg0A5WBtl2XahaTm2wW
	QGcPJApzZgO/JN7it191Gx4zaJAwIlPywqRgJLimOZyiSlYdKZOrzBBX1lRtldU2T2opJbtIoWX
	gKGCjwhKFLjrZqqHA/8PTXQK++PgqrC19wTSIOQTNYxFlrL+lPDTw2j7PIIbnJdRA7Lw/B5mo/K
	/04UDujzZJE2luozc8mm0HLh5h241qBPyA7DtuM73GkEJyrCB9lw69Gt5AMRFN/UQZTcrbZWjD3
	VUDN159Z8Hy2CjnE/Ybq2iWh9pUDIGKDBzIjLifUq4lYR6GMRkB2w3TAQQ81CXfZdus2CHEe1AE
	Ueg==
X-Google-Smtp-Source: AGHT+IGli8inUfpKQ0R3QD1Wk2QkyI+MBNZMZi2Uof8l2r80Z3TwT+H8YNAsboC85Y/ybfmRtj9VUA==
X-Received: by 2002:a17:90b:3e43:b0:311:f684:d3cd with SMTP id 98e67ed59e1d1-31c2fcf431dmr6829551a91.12.1752091027735;
        Wed, 09 Jul 2025 12:57:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.10.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455cfb2sm155464545ad.104.2025.07.09.12.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:57:07 -0700 (PDT)
Message-ID: <686ec993.170a0220.12d334.6a85@mx.google.com>
Date: Wed, 09 Jul 2025 12:57:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6061747863557487114=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: btintel: Check if controller is ISO capable on btintel_classify_pkt_type
In-Reply-To: <20250709191333.3374053-1-luiz.dentz@gmail.com>
References: <20250709191333.3374053-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6061747863557487114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980685

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.88 seconds
CheckAllWarning               PASS      27.05 seconds
CheckSparse                   PASS      29.49 seconds
BuildKernel32                 PASS      23.52 seconds
TestRunnerSetup               PASS      463.59 seconds
TestRunner_l2cap-tester       PASS      25.41 seconds
TestRunner_iso-tester         PASS      36.03 seconds
TestRunner_bnep-tester        PASS      5.96 seconds
TestRunner_mgmt-tester        FAIL      133.27 seconds
TestRunner_rfcomm-tester      PASS      11.23 seconds
TestRunner_sco-tester         PASS      15.16 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.96 seconds
TestRunner_userchan-tester    PASS      6.30 seconds
IncrementalBuild              PENDING   0.64 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.238 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.124 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6061747863557487114==--
