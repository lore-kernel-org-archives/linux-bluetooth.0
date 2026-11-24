Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546138;
	b=M7T5C0BnqsnWTRV7MVTIICmZz3SpIc7c9s30iomlv7URN794iV+ZQhKeXCbByhOCxrag
	 SOcDUwYw7fAWa/xSsZDEG1rWhdxl4kVEFqGkAnnIjjfqUxTq+IzkY9D5BZ9jl5VIOIaGJ
	 1A6dlCG2hMIs3DfW/cNzenSrLMp6H+MSZPOTeX724/J6T7OFnk3N7xEerab3NVa3gQplz
	 X7s0OOJ9fKtf9NrSggHDkjIURNUu04VwZR8UiUd//WHI/RzsG8vvYj5oMZOYzjqTr2vmW
	 YHo1Wz679IiFE6AtPdJG7DqCtChF4ERJFrTWda18wdQKQwrgkWzGbfz4Mvs/j8+Iivg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YszUu/3Vwrbhnhmb5vQH/tdGX/KFhwe/h8nCzsSOWaE=;
	b=Sw8B+TpBVhFyNzcVSCC1EfiPm4PU7aePsstH3u75Ncnz1EILMMlOmsQacdvnm6HVQq8b
	 7onOn+w/PAyoL0859eiKwiZpD+ChJfKF7y2Fg7S+BndNwMUs7zu6L4oCh+zKtFyM/6ec8
	 p4ZPecEe5ssO/FpgMyHiEAsTXUaj3Y0cf1i4JnQ2XXXpttA8vP08Fo/pxcywGCLRYE8Xd
	 FwdTTsM/ApqL5TXmXj6/kJRlt54bvKT1TTixRuiSm0Z9RY0sCIeJJ8u/XNwAi2cMsmujR
	 H/6N6SnjqUabtuu8MrNkirsEdEp9f2le40+y4S2qLVr5ajYTZw+WNg5i/3u8WZWi9GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gRMR2ObK;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BDC606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4BDC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gRMR2ObK
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8c70c2ab5a2so1905874b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795546137; x=1796150937; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YszUu/3Vwrbhnhmb5vQH/tdGX/KFhwe/h8nCzsSOWaE=;
        b=gRMR2ObK6Vr/2vJNHiN0ycLibUWXL7kKCF1qkofGhYT8jCaM2UGUZYJk5e5f/8mebI
         Y4S/4iiplnS3yQ7gVeUnxFD8cLI0oPwB2wZ8bxr+RogGayKfwkcfmtlW99WRDuVJoeCq
         xRtwV86r8hkmArMZSxz1QdhAxVA+FWtSY2l0dMhRRS+xSQ/eZ2gUmNXLOJCvEYVCVUFJ
         cW3QCdON32lPzAE51ib1HOZlr2zFnANohE7J2qPbASbXosx+kb+IN5Y7LTy2Pkrf5Y8A
         2bsVCiQ6NQhtSnA35Vy8IGYKM/vKZDEXpmkcmLKrmvWsBsgDwVwTkDC3N1n25wJJrcvT
         1tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546137; x=1796150937;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YszUu/3Vwrbhnhmb5vQH/tdGX/KFhwe/h8nCzsSOWaE=;
        b=tgx+wp5vlfJSj8ov8z3iTzJiWt6InVxcUiyScSk1HIbLrvfWqZQEsKLFcE1A1SOiWN
         yR6H6ZbJ4Rld6zgS7iZodiGCNmO1Kyl8QTWeCnf1nnssjU+2OE4Qgk5f/fmAfeyb/ESP
         s3AXvXgyu0hxSFraOuf/FDP/cywTC0xRRoVpX0o6rNdZUUWtYk9zUC1N/nVShfwz9M1T
         ojqMV9bGe2zMRgkao83hattk0k0ebQQPdBA9ur6oOdnr8usBy+SOuTnUdJkHNeILOea5
         Xg5t/gYMPdJHa1OteUAIoNbyUGZ/RmfL2o0UlsCdUrq8MpX8CNg+4jbT038/ncgfqcFv
         /FVw==
X-Gm-Message-State: APuU4Z8WqbM7VFEMdPSM/Kox/QNI9R7U+kz0Tm4FHZOTR7M/1TA39Shf
	V6cCsjX5zO/rc9WTyswxQtMZcWR3q2xW3dG0oePYd3xmbWH0s0DqKJ6uCTaPDg==
X-Gm-Gg: AZFdTZf2kcZrj1xTt6YGrX/GH8sWLiyjXhEfpHw9+TgEROXlX4eel0W2oaXSXpX8Yfa
	FQgGyl7c5GGj3Mau8jCeITWO9mx+VLXTIxSZDK24CXRTdFe4cdbFexVJfQjPos9OuHc3LAU62zw
	f7XAhSHvqhP9Sqto3DVm4ZYPmX5OIFeWDD03nkOVPYLqgWUTkU7icQR6SYCQIbp+gvB3rAVLZUK
	0vHmJ5ljlE1uL9rdFKKXmd1Wt8TUR3TRy5ImIWSNj7yEtIwLyElUPyIqRGFPyp+1HobuP4f5bej
	pkXIkOKkejcad65+BnT32x8RIZOiQJdbJNFC7gGffSJ/J7bNcA3sG5yAVCTRm/vSWAX2h4ahH1m
	LcuVhPbQubJZkltwCDzaXZSePIOuymYIMeJw/3a6pErlYmVsKNWJhADbT+6F1t7uxGncmPzeElA
	4S+9cPgJu0JYQof5tggCdAcBAbt4/viq950rWOUrdfZz9C0Xf1cpA5+ULqxTGbG4OtHqQ0iE2Gg
	tHLkClN2E8OE49y/vLmYNJk4wAPcD6eR6adsVyFmsykNHmF/Tb0dkWNoUttV7AounJdENI8tgV0
	bEsxy/oWVORntr2IVRGKvpf5ns/Tr9kYA2hfakEg
X-Received: by 2002:a05:6a00:21c8:b0:89d:f19f:5dd1 with SMTP id d2e1a72fcca58-8c87c862aadmr13910444b3a.33.1795546136806;
        Tue, 24 Nov 2026 10:48:56 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-141.us-west-2.compute.amazonaws.com. [3.42.157.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873f11da2sm7326637b3a.55.2026.11.24.10.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:48:56 -0800 (PST)
Message-ID: <6b05dc18.6514f89f.8731f.221e@mx.google.com>
Date: Tue, 24 Nov 2026 10:48:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2020998224769195361=="
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
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: Bluetooth: find an RPA peer's connection parameters by its identity
In-Reply-To: <20261124-for-upstream-le-conn-params-rpa-v4-1-f2dd5eb41f45@podgorny.cz>
References: <20261124-for-upstream-le-conn-params-rpa-v4-1-f2dd5eb41f45@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2020998224769195361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220594/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.22 seconds
VerifyFixes                   PASS      0.04 seconds
VerifySignedoff               PASS      0.04 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      20.13 seconds
CheckAllWarning               PASS      22.73 seconds
CheckSparse                   WARNING   24.24 seconds
BuildKernel32                 PASS      20.04 seconds
CheckKernelLLVM               PASS      21.69 seconds
TestRunnerSetup               PASS      480.48 seconds
TestRunner_l2cap-tester       PASS      13.51 seconds
TestRunner_iso-tester         PASS      11.72 seconds
TestRunner_bnep-tester        PASS      3.12 seconds
TestRunner_mgmt-tester        PASS      84.73 seconds
TestRunner_rfcomm-tester      PASS      4.34 seconds
TestRunner_sco-tester         PASS      5.39 seconds
TestRunner_ioctl-tester       PASS      4.47 seconds
TestRunner_mesh-tester        PASS      4.38 seconds
TestRunner_smp-tester         PASS      4.29 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.33 seconds
IncrementalBuild              PASS      35.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,1/4] Bluetooth: copy the peer's RPA out of its IRK under RCU
WARNING: Non-standard signature: Assisted-by:
#104: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#104: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15015926.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,2/4] Bluetooth: connect to an RPA as to the identity behind it
WARNING: Non-standard signature: Assisted-by:
#118: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#118: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 115 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15015925.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,3/4] Bluetooth: refuse to dial a peer whose connection is under its RPA
WARNING: Non-standard signature: Assisted-by:
#113: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#113: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15015927.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,4/4] Bluetooth: find an RPA peer's connection parameters by its identity
WARNING: Non-standard signature: Assisted-by:
#137: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#137: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 84 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15015928.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1213

---
Regards,
Linux Bluetooth


--===============2020998224769195361==--
