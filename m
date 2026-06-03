Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869E3D6462
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454437; cv=none; b=uq6+Hr9wPIn/PaU/t1gk9N5X00Ty++S5+QiPT+icfRwyvoQTvCRWeXwRqvy/cgXF6cdssMF4Y0/Y32NGjLKblRoK7Zf87/tV0jNAR8YWhICeo2tP/xFiJZJzB3DbtHiuL4jvnekH4VimGjEqcbcNKlBEPEY1KXouD9TYD4w4L5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454437; c=relaxed/simple;
	bh=th+kXXVwiCuUkgLJPrFWV1S71Eu00z5UicgaPR0jz48=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Pal6bfi8Zf/xaD1zSRysf5QAOsxPStQT+cyL+4kM4Bah2gkTYbYyWou8e0eaFPdubyT+1EKariAQwGgKozXIBDt72D76Lzs9RpvvS4tDz8L7M8e8jfM3vq+AYE8sRg0eG0x6CXvEhNOnpanEHWrL623ufWj/PheXF+qz50zb6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG4HW597; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG4HW597"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516e1525aa3so122646231cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 19:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780454435; x=1781059235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=91Gqp0LZlSeSNnXHXIz89eYhqATda164jihseKLGwho=;
        b=JG4HW597njs/BHd3jjXdH6nWnKaEbo4KC+0bg6+SO01oQ2drTopFR/YCcnxPT25+Gd
         7vklzZ1/DQZjwUMnYExdxB93XmN5igWOFiWb3qHNrSmsawtjRCpMCUWYtiJSOd3rM1I5
         MKi2V7qm4sL19RX/dhcBs8ETJtJWBPRZc9WuMVNxRdCYfcz1Ju7GSSnaTWvbzroQn3SK
         BOmBvR3BCZJgMLa+kbvgTzLRjVdOlXTrK/AtgYqumYGkVq1cMLY2UgRwcOwtEkYHlcxB
         w9TKzRaMNvi/DM6L1atLzzq7OFx32xfXjtj2EKcEv9HS+Y89ABS6lC5X5j8riiWoTQot
         WYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780454435; x=1781059235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91Gqp0LZlSeSNnXHXIz89eYhqATda164jihseKLGwho=;
        b=B3IjJp4OPj1p4TypX9023JbSbGmLUP+b81VhPl59lcaiJKh44RFnUz1oOqmIZoCnu5
         DFgwxhNZpC7IUN0SZudLwGmK4G1abUgsIfUcp7Of/KA83/foCkzHZCkhDhJeKt2lwovj
         z1JvzvKLGKTumJZPRi48ruyEmYljEHdnGvbcar4fjkZ7if1PZRryFYxT1Ako/RMVifFl
         6HQoeYGiRpZuggtQDWoWOREEw7cTtMv5ElMj2y4kwnDECCk3HaxJ8/W1IJO15yE+EhOY
         nmFbEa7GCPBDPM7KAkQBtgYfeMjLQzMNGJxpEA0ERXfvpyNeeFrloeFqtIkbcAM/qN92
         s7Ow==
X-Gm-Message-State: AOJu0YzlPJpLeIogFeITKrHjDuCA2XfL9mM9Wfgeb8bP79i/vvNaSmXz
	rBHKMPMqz3fXa85rf7EKx29vdT53/hSUoz9Svt3FCZiaf6YMDMHaGb8u6hW6Pw==
X-Gm-Gg: Acq92OEYywflfkT0mDWT+cTvu/nbiO2lPoJ1QKHh3BuGR3Tmq6CyN3edNox9EYg1rIS
	ROF9dYDLDh76RDGaRhCPmGR2TDkxI7aWhY3Duuz0aQ4n8yI4sabvtt+yEruQBa5XUiODXB7An79
	BCacn5SDzNWgNv2sF2Xxfd9pVsYIllCg2xMvuy5FHfpMoqsTNo/dDarsG1TuFWvKRGPxytt24pk
	APeKopfDbL1Kkms2kvpSgGecp9XBF4vPYWYOzZMRnqv3azK7n9CuJp84vIycYaKuknSgANIVbTe
	c7HNF1o9VnkYOoqnW+ifMcSpKRBTQjN2tcpEqyRT1JUAZc2DdKpSy8mOOQ6tMcHYUI+s1iTvMnp
	FXlcoylyunlJmSIPo6WMPtJwsXYbg7dpQ4Jb1rMo4FnpfIk7cEF7HksAznf0fMx8KF1hH3/4DJ+
	ZHRVivEasopVk3B8bkVdQ3Mw03Yfb3rcevvDL0VJgVQP4=
X-Received: by 2002:a05:622a:151:b0:516:ef49:f6f5 with SMTP id d75a77b69052e-5177873f64emr27071411cf.39.1780454435337;
        Tue, 02 Jun 2026 19:40:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.212.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd051d61sm8493616d6.29.2026.06.02.19.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:40:34 -0700 (PDT)
Message-ID: <6a1f9422.9338f4ca.20ce1.1f16@mx.google.com>
Date: Tue, 02 Jun 2026 19:40:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8142938414638823586=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jaggyaur@gmail.com
Subject: RE: Bluetooth: Fix Use-After-Free in hci_unregister_dev
In-Reply-To: <20260602233414.209730-1-jaggyaur@gmail.com>
References: <20260602233414.209730-1-jaggyaur@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8142938414638823586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104912

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.42 seconds
CheckAllWarning               PASS      27.84 seconds
CheckSparse                   PASS      27.29 seconds
BuildKernel32                 PASS      25.11 seconds
TestRunnerSetup               PASS      528.65 seconds
TestRunner_l2cap-tester       PASS      61.14 seconds
TestRunner_iso-tester         PASS      81.68 seconds
TestRunner_bnep-tester        PASS      19.35 seconds
TestRunner_mgmt-tester        FAIL      212.14 seconds
TestRunner_rfcomm-tester      PASS      25.82 seconds
TestRunner_sco-tester         PASS      32.74 seconds
TestRunner_ioctl-tester       PASS      26.06 seconds
TestRunner_mesh-tester        FAIL      26.17 seconds
TestRunner_smp-tester         PASS      23.85 seconds
TestRunner_userchan-tester    PASS      20.29 seconds
TestRunner_6lowpan-tester     PASS      22.90 seconds
IncrementalBuild              PASS      25.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Fix Use-After-Free in hci_unregister_dev
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#94: 
The hci_unregister_dev() function fails to disable the cmd_timer and ncmd_timer

WARNING: From:/Signed-off-by: email address mismatch: 'From: Jordan Walters <jaggyaur@gmail.com>' != 'Signed-off-by: Jordan Walters <gloambit@gloam.sh>'

total: 0 errors, 2 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14608047.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix Use-After-Free in hci_unregister_dev

8: B1 Line exceeds max length (81>80): "This patch adds the necessary disable_delayed_work_sync() calls to securely flush"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.239 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.518 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds


https://github.com/bluez/bluetooth-next/pull/278

---
Regards,
Linux Bluetooth


--===============8142938414638823586==--
