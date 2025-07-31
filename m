Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E218E25
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753925747; cv=none; b=CrVG4Nhc+6DLuMHRn35Nunhn+jRKACIw5iVuhKsny0XsiK3x6hmVCP2Uu0c3hsT326qrxAfm21s+IS+QKLU7OCA/iETohJV29NsQNeYTW52SC1Y65gMKqQAq1vsmHP+pB5w+nQ6tKC/TVRHNqNu66tqhahT/CSQVFoN612GhF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753925747; c=relaxed/simple;
	bh=ETgzqItCpkbCi0klOiDXKr/zT3WlRXXCnUd7zybEVUg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LgCB3O0PcteJn7w4G8KDvsto73v5ljcUmtuyBZQPvyvJ7/AyfMCt8vVdUWW0EXKNhYmCjhj5j5xlMQd7kaaRzBdl0FN/lmif83p8ouIeNTR2cNA0g0Gyc7dZ7xUO/OY86unQwZr4h41Lsms1kPcXu1Wr10RxVsabDjIs1xzopno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wih0tMI5; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wih0tMI5"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e3d7b135c2so4611385ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 18:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753925745; x=1754530545; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+k+mZHjYQUTGNg4UBS/N5HNJKmdjDbLMtzpaLTLw7rk=;
        b=Wih0tMI5uwacr2/Ch7939yfzDMjy5iQjEiiOut1fCNDHnteG+0UrE/b7z0VRjlk/a8
         7skZnVPADqjoYuMtnI62ssID6hc26IxA2T0ndllPP+nYra1xkKbLP0TKzHOpD2CKgr0+
         Evh2zcJ2eDVj2HOUpOIngWcBGPrrg4c/w2b3tVxE+mjkd+BW4EXLkHb10JLZ0lzvkKtQ
         p89PlcYRdCQVfXUJN9kiHKJg0Pc5Tcikynj3tW+NdcQkaNVBmN1vB+ODaObpC9zKMovg
         Jp3k1O+P4PbjLGPSo2ZNdrSIj6dYKuH/SkUQZmAYCiMRdKcHdMuhLmE1gWLKRKV+YOmk
         +ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753925745; x=1754530545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+k+mZHjYQUTGNg4UBS/N5HNJKmdjDbLMtzpaLTLw7rk=;
        b=ce8PtjgpzY5rbmP3K37PWaXmaGT+xlZ8ix5GGvUYjv7zlWfmbASp+R2wL1LEON6+aN
         x4UBjelTxon3PNjVGe5e+FkQDoUHUTj4fNZpglAac/wTScUshnoWMFBzjxh8AcfLZ2dZ
         9wR8iTL8oGWCvheuwCYi1rbQu22l5fhvoNeeDyXZ0YBLNwg4oXPGQYGR/DifFqGl32ev
         CSTCFbhc0Ra6yYOQ5OLUk5/e7on58tquLa01KPHyeSHi5T2hecbklFeCGc+Lt2xjGiVD
         7CRHABzBub8x3SOKSxqckaSocMuon/0hXc1zeK/bgj728N0mDuyvJrBUUhYDqpicpq7R
         6p8Q==
X-Gm-Message-State: AOJu0Yw4CWhUCR/G346I5NrviT/MW9VqOKppuyyvnIn9ImOMiEALwxoa
	JJy3MlQUF0DE82nlZCCJd3bI05eEb7WibeWoDYBiAbBdIjWPIsAT86JiHR4Yfw==
X-Gm-Gg: ASbGncsIDkAz6X/sMiV4Q/bpkL9gW6pkgYCzB81Uy+KCdd5Lm6xzilRDWTfWhf/ikxk
	TWusoiMFOfPEKGLPbGV3lChUL4QZ/vYLnqNnJcrRKWR56EJsPe/Tf9/cJwqapZu5RqM8Qg3MEE3
	ICsdB0GkK0+MooceI6VE1MugrOr3+VX3uUWAvjeIS3uKlhvAc4EjahP3X+Ats4G37tdcoyttbou
	OHGbIVwVPAYpFmWrsuh6+eJKz/mf3zSmWq5+/GOg232/sj0o37ve5z/eGWM7+E5SMrtzIUEWY66
	9a2SV2ZD4Kh5FhTbNkrIlt91XrfbkBnyhwQdIPR7hmjUc3i5F7Zph7DVx8bnScLBbkrwqS09ap3
	UteO9PJNQFjP4T+HFPAcfmp+u2j/yZQ==
X-Google-Smtp-Source: AGHT+IG8T2jj06L430zD2e+1/Wc/9ZPxL4ep3UIpPUxHNsgwTchN/R9Ko4Ty/ZHrH7EvJ0nSYADKJA==
X-Received: by 2002:a05:6602:380f:b0:87c:4496:329d with SMTP id ca18e2360f4ac-881378184f8mr865052139f.5.1753925744847;
        Wed, 30 Jul 2025 18:35:44 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.177])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b873e7sm182339173.48.2025.07.30.18.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 18:35:44 -0700 (PDT)
Message-ID: <688ac870.050a0220.113ae8.0760@mx.google.com>
Date: Wed, 30 Jul 2025 18:35:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5942915887138252178=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, salah.triki@gmail.com
Subject: RE: [V2] Bluetooth: bcm203x: Fix use-after-free and memory leak in device lifecycle
In-Reply-To: <aIrBu8VK8FgYm7bV@pc>
References: <aIrBu8VK8FgYm7bV@pc>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5942915887138252178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=987202

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      23.90 seconds
CheckAllWarning               PASS      26.58 seconds
CheckSparse                   PASS      29.86 seconds
BuildKernel32                 PASS      24.01 seconds
TestRunnerSetup               PASS      474.20 seconds
TestRunner_l2cap-tester       PASS      24.61 seconds
TestRunner_iso-tester         PASS      37.69 seconds
TestRunner_bnep-tester        PASS      5.97 seconds
TestRunner_mgmt-tester        FAIL      133.54 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.67 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.19 seconds
IncrementalBuild              PENDING   0.57 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.187 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.133 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5942915887138252178==--
