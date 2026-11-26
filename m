Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664674;
	b=hu8KNF8QCE79KUdGKrrIga8tLPQk1z1SEGW4QpDpZT/Hi3BVBRZR4zj7MhSbP3LL3YaY
	 3RUdiwLLgfOl093H1jBK2aV4T3dDGuh0XQTxsA7DMsY2PsjNIYgn9/31fwaTFLEJ77SUz
	 dbRxNVzmUQXLVv3q2wg6IquvkZeYycW/a5TfThB9yESzo7ij3lp4/hevD4oRvAez6yDxt
	 O6wn+TwCTayseM9en4YrYu5UFDrC7Q048ImnZBT6z/ErJkrlUj0qoSpruUFn8y4WHewrY
	 VMFKASJi0Ww+I5Yi1dYPeoXWrSnqkZvSyGPdKWhtiFUo9mK9ZMFicLxLBQl74xCq3Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=UfCYIxK2F0av494pepYVZ6qYcnh/rRVtDazPbdEUm8M=;
	b=MPwq6QIeGx4vK2rxavC8yQKfpd88YGQvLGITlSiD1MjRw7MQ2ZLFLI3dWt5hPNNxVcRt
	 KevQh2adhHyrBXEONph9r96uQ210TvLovxyoO2OqHGFZjnddQrRpdPTxR3S+yEAF3IBqk
	 UBudjBx4FZIn4jLmDhQkbQRQlH5vNgLbKffYIiO88P4TxiouPCyjvoTKkgIEvJF1QG563
	 FvLHs6WmZ/aONHU02m/daV4Y/qMAaYQQUB8WKKNfsCMhNNWs1ABjl7CUSxf1z+LvOEypd
	 gky+cZMhJF56jKYeh3/6nOUGPW3eOLh1SYkk8gNZVUI1KfyPO+2hGplmKIJwqcQZp+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyZxXlxf;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B9606A323
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 03:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 960B9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyZxXlxf
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2761c69fbso8566155c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 19:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664672; x=1796269472; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UfCYIxK2F0av494pepYVZ6qYcnh/rRVtDazPbdEUm8M=;
        b=EyZxXlxfl4Iin5rQF3RsJc23FwDAsyGMd5OxGBXQTrdbOAIPS1EX0j1sWPcEU8IyyE
         +WKhMQS1Pp5zgln635No+hS2h92lDvWZPyQe0tXJPRGdBhLrL85KPdI2ek+2yr24osoJ
         6jkmmQhgO7lCJJjBgNTQj9rpMaIayJGHgFJ/8adBrbranxDHs6tQ4xchkQdxQOEMzxSm
         Rrjb8TMtAshDjGs8l+wVijfgUsyYXQJ1eUGGmUH2IHVz9K83ofAsRd4Vr9x3Y6BylN1F
         +kiuRZBpfdF+z+M4OWE8HuMPQnZo7TCSiDsn1ytAW8gnqiC2wdI0c6TQjzEysGJbkvcx
         fySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664672; x=1796269472;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UfCYIxK2F0av494pepYVZ6qYcnh/rRVtDazPbdEUm8M=;
        b=r9NrMnQ+2vhGBkztO0gl6P/cyCHG68amiOBR+GiJd7LunxSJhzzCTM7inghvQFa2kg
         Ybzi+PASGNfLjTF8vgdKGD3c0BHndqBD8Dpu1MwaMZGwshvgu6pdT7Bxem2hehMt7x93
         uPv5EoBIgOhQ/e50KisIG40CVEeJjMfskWzjffbRSEp19Kok+DIN4otQI19TIa5lxVbn
         8xx1PKiOGodoJvnpjIvQaDUk2Z3Szrv7ULfFaa40HCU/2U67DJu/1+u3yDv2C3q2pMLl
         az/BoEXhYnDFw/Nk1GeksMK138BDpCIjwAZMXVCDKyWNXmHbqXLco7mMmsYnhNUlrmaR
         0j9g==
X-Gm-Message-State: APuU4Z+W1Gtzr87N3PRZz825tMfWGmuocqODNduu7z3GjL2c5yQ4Dlez
	YwWG21XJNa9DAwQqeXJMdWGkZx0zRLyOGqy+ZQJTldXUu3pOL84xJK6gNItYTQ==
X-Gm-Gg: AZFdTZeMIGM+EAJdnrSUH7Aw2fM0imMn9uguwYeDo7FBPUi5nIFFSN+IE+ASkCEYLPF
	yzRt6nteWX/YP7nlglkEGdh1C08mc8IMmDs2qNJYpBC17NPiP/VTrAgkkS1mGnoxsUMgJaAyDrN
	r2xpHBkLR503nnjR0ADzul/meLh/cghwdqJxTuOgDkGvPSsXQ7mSCQb+gYO4GQlIRZ3t3Q5IE0h
	8GRAc03BjF24LYgEvlvGA+EfbHNlTjH3mtM7WzzICjQ+IsoCjdZz4v6u9oer5YFFKdEyzJkWVZK
	GuIVHG587tRvQp2ryCMFNp76PfBlEnX6rVTbW1FukuII/08KInyzM/4f3/BZa5tG8U8NTqtrqle
	bfJb/OOWyPXY678WCElNyTI243fGdHSqcScEavzyacUoCtFt519BJUSC9vkSCJg7e1i5RexQ8oR
	VzjpT8ooZbfB8hoR3jJKvif/yHvtTcN6DU5M7B/PryDkdOOcOI/6XmwmuxX1h7NUMi1tPFK1tdh
	qyY3r+Vg1SuJg5RedI3cnopR2cKooKeF5apbdlxdiTIt8iAdenMicprNrmiUq4=
X-Received: by 2002:a05:701b:450f:10b0:1a7:78a3:bda8 with SMTP id a92af1059eb24-1b56f87ae87mr12401648c88.27.1795664672526;
        Wed, 25 Nov 2026 19:44:32 -0800 (PST)
Received: from [172.17.0.2] ([52.161.83.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm44140687c88.3.2026.11.25.19.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:44:32 -0800 (PST)
Message-ID: <6b07ab20.0a7c1997.164086.c56e@mx.google.com>
Date: Wed, 25 Nov 2026 19:44:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2769447605107732606=="
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
In-Reply-To: <20261125211210.1955598-2-luiz.dentz@gmail.com>
References: <20261125211210.1955598-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2769447605107732606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222578/

---Test result---

Test Summary:
CheckPatch                    FAIL      3.07 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      0.92 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      23.15 seconds
CheckAllWarning               PASS      26.89 seconds
CheckSparse                   PASS      28.66 seconds
BuildKernel32                 PASS      23.25 seconds
CheckKernelLLVM               PASS      23.95 seconds
TestRunnerSetup               PASS      546.55 seconds
TestRunner_l2cap-tester       FAIL      19.13 seconds
TestRunner_iso-tester         PASS      11.35 seconds
TestRunner_bnep-tester        PASS      2.83 seconds
TestRunner_mgmt-tester        PASS      84.64 seconds
TestRunner_rfcomm-tester      PASS      4.07 seconds
TestRunner_sco-tester         PASS      5.11 seconds
TestRunner_ioctl-tester       PASS      4.26 seconds
TestRunner_mesh-tester        PASS      4.20 seconds
TestRunner_smp-tester         PASS      3.99 seconds
TestRunner_userchan-tester    PASS      2.91 seconds
TestRunner_6lowpan-tester     PASS      4.05 seconds
IncrementalBuild              PASS      31.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v7,1/4] Bluetooth: L2CAP: Fix rejecting all Enhanced Credit channels if one is refused
WARNING: Non-standard signature: Assisted-by:
#138: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#138: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 105 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15023604.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,2/4] Bluetooth: L2CAP: Fix leaking the socket of refused Enhanced Credit channels
WARNING: Non-standard signature: Assisted-by:
#139: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#139: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15023605.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,3/4] Bluetooth: L2CAP: Fix accepting channels with insufficient security
WARNING: Non-standard signature: Assisted-by:
#181: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#181: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 320 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15023606.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,4/4] Bluetooth: L2CAP: Don't offer deferred channels before security is met
WARNING: Non-standard signature: Assisted-by:
#147: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#147: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 35 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15023607.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v7,1/4] Bluetooth: L2CAP: Fix rejecting all Enhanced Credit channels if one is refused

1: T1 Title exceeds max length (87>80): "[v7,1/4] Bluetooth: L2CAP: Fix rejecting all Enhanced Credit channels if one is refused"
[v7,2/4] Bluetooth: L2CAP: Fix leaking the socket of refused Enhanced Credit channels

1: T1 Title exceeds max length (85>80): "[v7,2/4] Bluetooth: L2CAP: Fix leaking the socket of refused Enhanced Credit channels"
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 144, Passed: 143 (99.3%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client SSP - Success 2                  Failed       0.016 seconds


https://github.com/bluez/bluetooth-next/pull/1229

---
Regards,
Linux Bluetooth


--===============2769447605107732606==--
