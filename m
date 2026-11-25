Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641980;
	b=3/WQfxcEVtEsDW5NKocPRvv6dT5Vo7cOuDmk2iiAFT+KawdmhMD6dGZUaDMK9wV82SuM
	 3BH8xjvOfey0jn5CuimfFgaHwtTE3nDkKzXzCS37cNG31AUz1uoXarpiPF4E8Kb9XCLWT
	 Sae/k7xQ06hhuFfJ/Am69X/kiVI7DxwLcOPd7KE5domxxNt4+cIQZmVUN/jqUDelD0xMD
	 QRW5yykovudE6deV5N2O6g0jLHpBBjsDVqzTFlgElcLdrRDjqY7fs3u/gGFg65/a5XIBp
	 82oDVHhpyYNi11WOnRnQag3f0mSQb/+ESXqZuly3pg5hcNVcQVY5esRZwN+U9hVQNlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=2+mY4YOusrtrsSakAz1ywvWtMPO24suLkaZLNR9Jmxs=;
	b=y4I/Nferj3sJEhujBUMbTKJXNukf7IoOZKsKm9zL52NPBwc1zTtd3P9AEyCsY8RQLkni
	 +hnu7Akw6ANXCnLFyh0OetS86TTBYAqS9LgUhlbOBlBFOql819lA7E4iD8nYftGUkYsQ8
	 Wg7FZRKY6jKMEPKas6p+uQAFYPKE1oYQ0FzzPPhMIeyHOAt5Fyf1cTliC5tJmMhLyhLpG
	 wjlkx+F+SlN4HbMa9oS1qm9n0Gx+5ifmDIOG12ZKflxywVPsanHg+acKk75C3ALq7Vc1w
	 ZK1M/RRDCkmDv4AbSTYkL2edBb0dpCmVlUNZxjAAYg5wX56Ek5wG2oZz3vpxR/9exyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZCwLn5EJ;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B51606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B51606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZCwLn5EJ
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4ed6d69bdfaso3509665b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641979; x=1796246779; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2+mY4YOusrtrsSakAz1ywvWtMPO24suLkaZLNR9Jmxs=;
        b=ZCwLn5EJ9GqplZVtc0u8Hhuyq1jez62/w+zIwyPCQI+u1/os5/08GkCcVJU7ga4D/e
         beaupgzJecmIzmE6DwbN6AlVnorcJF7usS3JcYPYOq0I5ORtDP90vCO5Fx2V9b2VLO9B
         uNvehStHdl1aZBHzQq2zg/KeCZ0iNLgXhvmbWPsS35+awnVfLVvIDbpzso5dhJlKHVKd
         e8rsEc+3cPZn9RiccEDJ5Bdyp010qA1vNczTugN4rtP/MvxtRqxIdzb/sLZgPzuqq9Lr
         0G3ucNvXYbbZCMNLwK2gcwtMQDlv6l7AmfNOrGw7/o08jEFab6eucbyjveW0PaSqGwcB
         BlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641979; x=1796246779;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2+mY4YOusrtrsSakAz1ywvWtMPO24suLkaZLNR9Jmxs=;
        b=TbXBVT5O8xjorvKcRxlzPM5uimhfehhbQw49M92WQtpQjGn4GIOHonyHTw+ZlRCDVi
         vsNncAl87+MLWIxv44W3g+YLBP9LT/lAgXc1yJqSOq6N4rWFM9yuFDvwAkQYJUF6dCaR
         SjnHbZHYfNV0FcMDabDigVVZrkGVLLur4uTAlfczFtaIbuPhdK36PHXrLrSucSB3JgvQ
         SvzFDN0ZHWJLgKR9QZgDpVrZvHJ/FWhGiUcnp0byvb+3wrzdl+741qup9OX/Ces95N81
         BxJid5ImPgOjOwqmAdsKoU+EVKeiCK2EEHuqO7PdC0v5QcH2KL4lm8h6GSD8705WbtR0
         MqWw==
X-Gm-Message-State: APuU4Z8zivFafYAm7bE9eY0HoyrUlaYXL9Ehux9boSOaRBl0vboin7vb
	+fSHOtqRIjg2uS0YIOIbXQmEHOe8I+J9Uruu+HashTBnr7W2Yi/0fHl4K0rpTg==
X-Gm-Gg: AZFdTZdOQ+9Rnr1o5nWNCvTREc24Pt4dKAGaXfziDVcP991dqoYfa6kquIRXTdMdiS8
	ofwjI26em45W17PYvDK5eB1DZi8s+G+pqFDj0URcxbm0m+Jj5RRktV5w/MTdU2b59kc1EPWwqE4
	hpmh4UtMn2ZAHpDblfwONl5+KMSBWkO85nM6Qc7yHUZOWaQpKK1af3qJy/JsYkry3l8GlrhukI4
	raDb39BoNmvq+uHQOupffrX/FuGFtIu9a1Lx6sX9kaZZjRxePEVehbv3Wk7PbmfQ/4O5S8+GqvY
	COHQvmvnLq3HoP79lJfuuz0PaRoREdC8aq8P/jsUsHd/KqoBYtw/R8EX/BObYcHLnRr8t1gLf4T
	h77SC9ETNtyJiRFDs+rGysDJVT6mFK42uEUCMegQ2J9fnKwCgF002CJafK08AtHOfPUxc2wnpoz
	FwihN/Qp0hHI2Ltz0dpnI9CxDOfLg/+fEQ9uH4I4X53rGr0xgKNyCdizLlVJ3ymPB62+lKXPbjI
	bBTdwIo8eHDwZTrmvRLu86TgpZDdQya2YFy8qvw6+cPJqU+xSItwIokyLNIAPB5
X-Received: by 2002:a05:6808:5396:b0:4f6:3401:1c79 with SMTP id 5614622812f47-57a0c09be39mr19496879b6e.49.1795641979033;
        Wed, 25 Nov 2026 13:26:19 -0800 (PST)
Received: from [172.17.0.2] ([52.173.182.172])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35655a5bsm14869298b6e.13.2026.11.25.13.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:26:18 -0800 (PST)
Message-ID: <6b07527a.a6fa7752.23d37b.4240@mx.google.com>
Date: Wed, 25 Nov 2026 13:26:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4893631608485634201=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: L2CAP: Fix channels being established with insufficient security
In-Reply-To: <20261125185857.1666852-2-luiz.dentz@gmail.com>
References: <20261125185857.1666852-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4893631608485634201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222483/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.48 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      31.59 seconds
CheckAllWarning               PASS      35.99 seconds
CheckSparse                   PASS      38.99 seconds
BuildKernel32                 PASS      31.99 seconds
CheckKernelLLVM               PASS      35.41 seconds
TestRunnerSetup               PASS      764.13 seconds
TestRunner_l2cap-tester       FAIL      15.10 seconds
TestRunner_iso-tester         PASS      13.28 seconds
TestRunner_bnep-tester        PASS      3.19 seconds
TestRunner_mgmt-tester        PASS      89.52 seconds
TestRunner_rfcomm-tester      PASS      4.48 seconds
TestRunner_sco-tester         PASS      5.65 seconds
TestRunner_ioctl-tester       PASS      4.71 seconds
TestRunner_mesh-tester        PASS      4.51 seconds
TestRunner_smp-tester         PASS      4.38 seconds
TestRunner_userchan-tester    PASS      3.22 seconds
TestRunner_6lowpan-tester     PASS      4.47 seconds
IncrementalBuild              PASS      31.89 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6,2/2] Bluetooth: L2CAP: Don't offer deferred channels before security is met
WARNING: Non-standard signature: Assisted-by:
#147: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#147: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 35 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15023286.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 144, Passed: 143 (99.3%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client SSP - Success 2                  Failed       0.025 seconds


https://github.com/bluez/bluetooth-next/pull/1228

---
Regards,
Linux Bluetooth


--===============4893631608485634201==--
