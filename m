Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476853;
	b=o+7RFIeqilOUSykIBMwjy9TMQTIwHON4QJyT5ZbSxQfJMt4hiBpqZCykwoOYzGkr9eSG
	 0Y+kLAeLnqpujvzLu5xUGmTpYMOe0ziChL/rBZVgg5PuQR5RNmTR49UxBYhTHiLXlxh9e
	 IjIxUDazdnrW9Q1c9Ff5Ka027MDAS/z2SjeR/I/A/iGEZC9LUpBZjdx5d9X6tRoHn0Tnx
	 sUbiZ5EmG2Cd66ADwBb6yHZ5XT9aijffUiZnDLpu0wknSNcU8bK//KtwVRYCGsa6Uob0U
	 4txE0t/V5jORnsx49sUsZCpjXpTfk8TZ6DffwXyX1KBJSF2DO0+BwQ0Oj4XkJwH8TaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=kOzfV9cAbwwo9FPMGUn8pP4/gLVlZMax8nmF2iCxq8g=;
	b=ayh30TPYF4m8N8RqhNO07dDecpGJoe6jbVuLFiprjx3bX1cDNVK6ByzQynoZEW1DTPxZ
	 ly5VM61mQE7SU1DYdQlVO1/H0il58OxGd1ViYN4bMWmaKa+RSTiQEmexbD+8zVsMa1nZv
	 G7M5+XVxCT4mh7dphpVBcr+jDeWrf8PhsAZxSzfunvDsQDYRVdPb1WgPU85vifnIiih8i
	 sLXx+2PIg3NJc2KoYUo15he7B4xvFtGBYq4B1SdSWkn9ydF66uCPf+gxXnOgOkwhl4vI/
	 G7A5OH/Y6BEFp23RZvVNfztaFkiZKhhEiF1ljBD1ggj4KXPgbhqvKMfPqxz+NohcRHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNns9aPo;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B8606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5B8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNns9aPo
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-38644aedba1so5916390eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795476852; x=1796081652; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kOzfV9cAbwwo9FPMGUn8pP4/gLVlZMax8nmF2iCxq8g=;
        b=lNns9aPokczWdMRF85tjLPdsLOROyI8Bb/ZXYv52NTayMz3FAWGMrPGGDvap/wYt03
         GSYX0SPNHIa84daZRvmeXzAf9eee76/PcpP4pr2XrFQDbWDLg8sfJf/a0dqcEbUmhfAW
         AbqRf+eHepaGfWx1+T+lVEvT44CBF06fwgocp2llB4WjzWxDfUYR8JhPL2zyyVYqgGZ3
         5LIYo9EH+igXnp3Bpwyt+x5T7fJi4l6nM/5TW/IU2RKaJeMcCoqOVklF6TXkyXY7a5g7
         O6YIrl1151lHfGlYiVnGOAGXUMsgNJ+18VYLdN5aj5oOOtbA46sgo1h7QvAmabcgOQOu
         5EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476852; x=1796081652;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kOzfV9cAbwwo9FPMGUn8pP4/gLVlZMax8nmF2iCxq8g=;
        b=dry5A/rzSKr7U7Xxi6+CDEj3ZXj5Mq4YyiRJ/g3x+3pnawaLrpBvQBLKJNXqjkpPRB
         5CKFAqxsaUnir63a448eeNN1JxXNaLD5wuFdZ2xS6jl1AOpAR+j4rXDi/rG6OeBsDKeR
         xK+eANT/ICEurIYol8b6WuM0sU9B0yRsYbaEnsO8nHcC5wyUlDpY0TB/SHjFGSYoR5Ej
         WQtt4AUgg7v6o/JlKDMT1MniPYZNKBTeqnpZRdpRYCtnfXMQUZ6/K6UK8NbHiBA4tdMH
         UC4XrTvlGS+pRiGkQKTbhWZ7336bo1SMfuisWR0vIZQvBHpRgR94sBeD7I4PgtljB1Hu
         9NaA==
X-Gm-Message-State: APuU4Z+hn9mUPHxcIbpQX0tzB435S8ujwRjtJitXuS03ssjfeC9wp4y/
	SXRWytaOzCizTWPlCQTYVPWNfiXgDrw9OT1dtTa9buQ4Scd8H6PltaXgiFcCBQ==
X-Gm-Gg: AZFdTZfTZzx2rZVefSX6DYzE3uEolwluzgqodg25wxl1rdLAaS7u43QH2Qkn1fqPdnw
	MDnzk3oLr5loaKGRdjlEa6X3LGeePedQLigNy+wBkjR7SBdSX/qcanBLd24NyeKIRQHd4RU/Y8N
	SDwt/fGC0n0csy+0fHJtzSDj0svugp/WzF/ghsYvAwZmQ+EyFnEoBEydxvorj3tcOxzlpHmZhB/
	lgx9RW3X/h3XL2F0MT4bfdibzXC4440CotO22SS0gEPqTTxM4wbx/biVy3fxTCNnOqHdYF0yH37
	e7DUi6DpEUhX8fA6DN7sFpe1uVLrqdbjY0BoS2oe4IXS4cn/jogchvNkVSjbobJ/JFe/zpb/b8T
	Kdo2s/vQb8SbQqT49OImGOp98MbYI/jfNn9eQ1o0nYfZ/DjWf+U9kHeSGKBSCtEF9UmnRdjZXLJ
	KLhy/AYnmqqTeT/zQehMaQN2pFV7FQHyQhLYfTCaddGHRfO52YShx60O/wL+YWizfW5cVmgVkaz
	9hUnE6PV6tNcR0isJ8JW9fRC/QbPcFgy3pYA1wRdQXOv1r+5Xkjl+Xw6hAwGau/xo5F9zyi6kFU
	ZhLPO7NB
X-Received: by 2002:a05:7300:ce93:b0:36c:a44c:1763 with SMTP id 5a478bee46e88-386bbfa6402mr1659717eec.32.1795476851543;
        Mon, 23 Nov 2026 15:34:11 -0800 (PST)
Received: from [172.17.0.2] ([52.159.243.30])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm42531111eec.14.2026.11.23.15.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:34:11 -0800 (PST)
Message-ID: <6b04cd73.f2313814.3bef54.b723@mx.google.com>
Date: Mon, 23 Nov 2026 15:34:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7359521892921734246=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v2] Bluetooth: request LE data length for MT7922
In-Reply-To: <20261123221218.215154-1-cochcoder@proton.me>
References: <20261123221218.215154-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7359521892921734246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220149/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.57 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       FAIL      0.22 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      31.10 seconds
CheckAllWarning               PASS      35.08 seconds
CheckSparse                   WARNING   38.01 seconds
BuildKernel32                 PASS      30.75 seconds
CheckKernelLLVM               PASS      34.15 seconds
TestRunnerSetup               PASS      739.31 seconds
TestRunner_l2cap-tester       PASS      14.60 seconds
TestRunner_iso-tester         PASS      14.98 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      88.79 seconds
TestRunner_rfcomm-tester      PASS      4.43 seconds
TestRunner_sco-tester         PASS      5.58 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        PASS      4.41 seconds
TestRunner_smp-tester         PASS      4.34 seconds
TestRunner_userchan-tester    PASS      3.18 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      28.52 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: request LE data length for MT7922
WARNING: Non-standard signature: Assisted-by:
#113: 
Assisted-by: OpenCode:gpt-6.1-sol

ERROR: Unrecognized email address: 'OpenCode:gpt-6.1-sol'
#113: 
Assisted-by: OpenCode:gpt-6.1-sol

WARNING: Non-standard signature: Assisted-by:
#114: 
Assisted-by: Codex

ERROR: Unrecognized email address: 'Codex'
#114: 
Assisted-by: Codex

total: 2 errors, 2 warnings, 0 checks, 103 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15014629.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: request LE data length for MT7922

3: B2 Line has trailing whitespace: "Hi Luiz, "
6: B2 Line has trailing whitespace: "ahead and prepared this v2 quirk patch that "
8: B2 Line has trailing whitespace: "Thanks, "
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1205

---
Regards,
Linux Bluetooth


--===============7359521892921734246==--
