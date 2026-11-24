Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503651;
	b=PbcMuI+gunegHHLSLVf81LwiXXg0HlgZDsOUiqe5RogAd4hu9F9D7sNBJ2qq2f+YOyWP
	 lhs5dGie0xnOTMvw6AoFD0U4I/VEezLo0URNAsZ01g6rsZY6KpCSj9jgvmMo4AOTEB3S2
	 RazXU4l+pwMRf1biHxGc8fYIdyoafsuqBOPs6wij6TPFWIrNKHmvTpl7RF/drZ0UEwJbs
	 HZVi9fhbm9YErHMnmcqhGnlZ179GwEGxgvo4a8Rppg3WdEFAysoG0zo8bHrd9ZyrCluoq
	 0xyFQX9fbzULHdmpUjgIUNwPei+lbQAROaEFAcrw5jyQsqKxk7j8/l5FpuCDthCZhYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=zYR1zn9lujIBtrm3WSm2VpeNunvb4KK9Vwjaszjvsx4=;
	b=oQpuTuAe/QotKSl8c9Lf1L6B4Z74290FVdn+0ddzcXNm19lTAOWVcuLlalQqOqq1LsmK
	 M/1Byv0u5e5XpCsthcQC0SB8PUAuCJqULsiXE97Ud8hRVOa9iyUUt5hx7O5pvdu+MRgn2
	 4AWJjoNJw+ToNoZCvNdNkia01CQkbEV8CHGmo7/UVjGDfrTvBhl4vzcvdDAI91azFyUsH
	 ACsyhd7RpJQfYhEQL3QUZtWwKplwOg+DS8JPDEYpUE0NpT3YXhuQp+bJAIwPmb7Hy04Py
	 3o7+JxEW1WnXNyaFO1i5jelFeg8MNxLmsm2Yihz7yMmr0OivnlOybC5uR2vhv/wWi+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJBaGaSB;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9AD606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B9AD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJBaGaSB
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9210f2622ccso51218996d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503649; x=1796108449; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zYR1zn9lujIBtrm3WSm2VpeNunvb4KK9Vwjaszjvsx4=;
        b=eJBaGaSBbfNXLolddt7S8jFWq0X6V109kgJvza7KKTbjYs3r+U8lp9zDNItOTiQ4Pk
         nbMBx4yGb5B2U78NEcNr+FKjuz0XRiB3GHP7jwDkogjtonuKUTS7hpN3wJ/8caex61fW
         Oe/KZBVz8PNdsSBpkFal8E0f51OrSk3yjKa3YaWbqhoSG8dfMYkWex5p1RKzTwCPhRHL
         v1BpYFf6ZB4G3BvLHOgIyZ7bGuLP60htHzr/u4K8rRBr0TD9owJTV/8KHNepsMeA9QXU
         5pHQxiOYlzDUAPJr/BqIaeFEj7Y3iN0x3OWzJdwWEPWBUF2O4SK7wgVDX8BFaq24/4jf
         dZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503649; x=1796108449;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zYR1zn9lujIBtrm3WSm2VpeNunvb4KK9Vwjaszjvsx4=;
        b=UQXjFy2Bi120uoRpXkU0P916IFtXIQcHoOKV7JHjo4Tx7UUPkQftwtIbsS126XJg3m
         t0g/4yh2HVYD0tZ0xl5deo2r4uvz4H4zY2RDAqNMvde/MVJvE5NBxYPnuaTmDJtCCmo1
         /p2V91DMXgLxVYS+zC7T0dQqz1oqwVse+0lrE3rFmmpyfk+2gufaPpiuxrr+ACSUcdVy
         fqGyLcpM7X9PIYrBlDc9LdPE7hW7bv0Z6zs6U73oUspl+H3BYgoosf66tb0OhJIIhIAD
         8+XBc+vgqt5KDjxo/USJBD7zceLqaLiQkla/Iy2Ar5ABwzjeBuVNi8d5JMVK9SNBg5G4
         zRRA==
X-Gm-Message-State: APuU4Z+Aptj5+cGacxdAzr2HEuEn3K8RB36UEK3dZKI8P+aZ08XAWSxI
	pgbrQHHm9IIiQfHWfaxDL41LR9vdbAQyOAqU8MxyfgnfvkOSUSd/t06Zwy8APw==
X-Gm-Gg: AZFdTZcaXV4BTZ43al+j6s8YUDozBImiIu9XNPMAv9kLjk6jvfZbFrvNKTjizRX5AFK
	hiUOuZSqXwhiRk7o4XGG42alFdnoLmZ5Xdi0Xb/BRRs4zDX61ecvQdHtNd+RIgjfpzzPHjoEHGy
	j+UOZG3vFFXL9tLlD7vBKh/Zu4RE4nyVjtaQpq4svp+k04h2TV/c/hoe3QbtHgRV6JsgQjcTDqb
	zSZU1vIUVIsCxNFqZ8ia8ZiMaSweq7DgZz8VnoU+gGRquOrGF1B5hMlGW1xVPXWq80gfhiIng0J
	RqJsbpRHv932SpsBnVOd4XkXR62vTLB5sZHnLtk6Sid7rDvMs4SSFWRlQ0tpICwWLDXvrEO6TbJ
	Gl1GbDQW9a8F06nLAAk/d1F0NNA4EOr4hGVeHRksRZi59GVsSq04C1sSCeSQGSk1Lj5HhdhovJ8
	8XroCOVVoKAnNkVBzxzuPKK0CM1eYo/wEt+SbKOAoe+iuUtTvLrFvbU9klm2kspahY5+BC+6PEV
	LzQUxac7MWL7t5E/FBBZ3wVCsjUv0xnK5KFbBYtYRCRNZ/DyFBjh3Ls1mgVB+552BLf0+EI5rdh
	LVaPXLNCWX2sVUBU6BXhq7hJRjRvN4BSRAkAa8mTx77POqY+IA==
X-Received: by 2002:a05:6214:5297:b0:921:42dc:bf07 with SMTP id 6a1803df08f44-92142dcbf7dmr201317996d6.14.1795503649069;
        Mon, 23 Nov 2026 23:00:49 -0800 (PST)
Received: from [172.17.0.2] (ec2-52-7-11-124.compute-1.amazonaws.com. [52.7.11.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f8c34sm127765566d6.32.2026.11.23.23.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:00:48 -0800 (PST)
Message-ID: <6b053620.31b977b5.172c4c.9a80@mx.google.com>
Date: Mon, 23 Nov 2026 23:00:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2279779046515753264=="
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
Subject: RE: [RFC,v4] Bluetooth: l2cap: prefer compatible local LE intervals
In-Reply-To: <b6847b841127362e423b49f9e48118f97985865d.1795497229.git.cochcoder@proton.me>
References: <b6847b841127362e423b49f9e48118f97985865d.1795497229.git.cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2279779046515753264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220371/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.56 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      20.22 seconds
CheckAllWarning               PASS      23.34 seconds
CheckSparse                   PASS      24.86 seconds
BuildKernel32                 PASS      20.46 seconds
CheckKernelLLVM               PASS      20.87 seconds
TestRunnerSetup               PASS      482.03 seconds
TestRunner_l2cap-tester       PASS      14.09 seconds
IncrementalBuild              PASS      18.87 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v4] Bluetooth: l2cap: prefer compatible local LE intervals
WARNING: Non-standard signature: Assisted-by:
#92: 
Assisted-by: OpenCode:gpt-6.1-sol

ERROR: Unrecognized email address: 'OpenCode:gpt-6.1-sol'
#92: 
Assisted-by: OpenCode:gpt-6.1-sol

WARNING: Non-standard signature: Assisted-by:
#93: 
Assisted-by: Codex:GPT-6

ERROR: Unrecognized email address: 'Codex:GPT-6'
#93: 
Assisted-by: Codex:GPT-6

total: 2 errors, 2 warnings, 0 checks, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15015317.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1210

---
Regards,
Linux Bluetooth


--===============2279779046515753264==--
