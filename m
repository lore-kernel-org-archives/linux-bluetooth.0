Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D4224B07
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854142; cv=none; b=At9YNEenPrNDhmXckAYPf6tSiV9TRvV0TbRODoVjuU+wSa4+6qa5gZYnqXIDPKaYYFRiiO5pRJkehPw9UarAFKBtGaxYWAhl+zftbuUveIo7kIK34jjVGDRRHol4UIXS2ofRl7jYqy6PLfV83tP2NOKc1YTMqC1/yPJZTZV8rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854142; c=relaxed/simple;
	bh=6ZFmGSYqlxUWnC1/gKOkeuI5g54WJ8zWsqfxeHvpQ9c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XhXZ0f57OPyYv/4wNO/13zUS9lqNzmU2CcDGBIzrv/sNsJ7QvAtz3BliGPHFu9qtpcurBq8aohCt8Zzmg3ItKa33Ei7p3BZ1vROmJiRT6PgMadJiUyNzRWnu5WXtvX+cnCq0IrnJwM3Y71/k7YwAriMToAbVw2ZCsfBwIoXYM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SV8OUpB1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV8OUpB1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2167141dfa1so93520795ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 03:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854140; x=1737458940; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NvOJMPIkvyU9d/tnmu4HPJFUMOvFIPXlyxLvolkAkOQ=;
        b=SV8OUpB1iwGdht5t1RcmpucofsyAOPFsPJqRQQMjjle62vx0LR+0vR6XsuCjyL58rb
         IKOgA9Ep7ZXaJPEjjIJuadUE3ITAVFgUnz/FoNvX2Wl8Jlsy/1MeFStlJykh8l4fOgbk
         rj8v4MsR66NgN9jQA5i+YhrGlsgARgBWI3yYo1zCc0+vZfiuoOWXVN4K/1dKsFGIEKL3
         nD3cMjOK+yAK16ZIJ0KHsScFxzGqD9YSkZKmuLaZV5BUonbiIw0NxkNH09ODFdnGusHp
         ZK/AV/sSr1ajD84sH79UiCsGFQKBwh/lmCvOKuV4KA4Fak3GHqhCsROOC95j5rFgaoa9
         eEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854140; x=1737458940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvOJMPIkvyU9d/tnmu4HPJFUMOvFIPXlyxLvolkAkOQ=;
        b=oqCmHPg4QQwC7xRYtpju/cYC9tXyUxsVvlAjbuIwzyfJ8vkeGiFrkGj7wvmos9kGaw
         27pr6iXvlhcQybKEbG1tz7ce3NHjndrzsoDr8acckmpjYUhf1mzxurx8BbQzN67Z59kp
         w7U22FV3R6A0uSxyWDATKAlpqzAzx4kplE53STfGiL6Rc4ceUdgv0qcP5m+3IyyuG2so
         JW8mv/21PW32qcmfNWWONwdw/5dStzZvlEqJLOP+jfOEqfiIczxRg1SgRoQfeQ7ulq0w
         7Kcu2RVq+E214v0ERV6grrn2EWLu8U0fkvcCFy07gI1u9LUxFRSwUPgMxOP6tQbmYj4R
         pSow==
X-Gm-Message-State: AOJu0YwiuFzD2f5Kyt1DPmUBBUM8RF7ABqKn5qPtLt2moOoiWFA2z0Hb
	iQEP1swQcsBmK6we2XaimCuxpqXx3IqlAnEREERAuvpHFDBd61iy+CdNpA==
X-Gm-Gg: ASbGnctwfsGOb59+69aPUG+T2En7HrMYnhxbhINr4ci3xPI9FG/Ut9knS4s9tq6hrGk
	CeS6RZQl++2wP0XpjOhFuzMljllBtGvCBVWoKTSEqeRdh8wYYMmalId1kVubCI2iznZOkTB23Rk
	qa9c7/ytn502KesLskdNiGo3R+TSzZ5mqlqB5FYRfKpMqaVLD/bhCV/sN/hSX20fgR22KQ9/8dz
	H6Ixfky9QkdY9VMeep8Ki9ACu9uSfxXPSZSST0EDTARYy7GUBSbxuvrCOJKFAU=
X-Google-Smtp-Source: AGHT+IE4uDlAyTGM5dcKOjlI9YrTJxlccbmf6IFlgUNqXC1QNsGFj/yxYpcsoodtWLMJaX8EuEC/TQ==
X-Received: by 2002:a17:902:d50d:b0:216:6284:8a00 with SMTP id d9443c01a7336-21a8d6335d2mr286119825ad.2.1736854140053;
        Tue, 14 Jan 2025 03:29:00 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21c3ecsm66406615ad.111.2025.01.14.03.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:28:59 -0800 (PST)
Message-ID: <67864a7b.170a0220.250715.0f8d@mx.google.com>
Date: Tue, 14 Jan 2025 03:28:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6018214976158886752=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
In-Reply-To: <20250114104033.2324297-1-neeraj.sanjaykale@nxp.com>
References: <20250114104033.2324297-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6018214976158886752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925213

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 FAIL      0.37 seconds
BuildKernel                   PASS      24.86 seconds
CheckAllWarning               PASS      27.25 seconds
CheckSparse                   PASS      30.62 seconds
BuildKernel32                 PASS      24.29 seconds
TestRunnerSetup               PASS      429.66 seconds
TestRunner_l2cap-tester       PASS      20.97 seconds
TestRunner_iso-tester         PASS      32.71 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        FAIL      124.86 seconds
TestRunner_rfcomm-tester      PASS      7.66 seconds
TestRunner_sco-tester         PASS      9.61 seconds
TestRunner_ioctl-tester       PASS      8.22 seconds
TestRunner_mesh-tester        FAIL      6.46 seconds
TestRunner_smp-tester         PASS      7.09 seconds
TestRunner_userchan-tester    PASS      5.19 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.148 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76c/0x7d0
WARNING: CPU: 0 PID: 65 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.114 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6018214976158886752==--
