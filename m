Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787596;
	b=COpkGs2qpvyVhmiTusffznf4ss6hPG87Kv1VLTOfk77JSceVLJp7rNAUrvLfnv2CBhFx
	 fXLXDnKldiEzWnKHpi62NctLsDpgsgt4l/TQAn27mEOoxQADGP7ab+A6+6lMTK7zEZgpU
	 k7PTX5uoLJ1LVqINPPh82K8eNAeTfP752Eag1rkki0I7WExdfWNdCn2uBf5/KdfIqVLj9
	 cXFslWYPSQc5v3cMabLG8JZhQZOqJvwqJImondQ7pH4gQfnlrywyG9utErhUmV2n6q7Zo
	 /ZZQk/cnq5iIeFjwTZ380dI3FGvKEtPizR5mczbOZlVGnhtgR4VCH+vKCqvUB9C8/cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=FvBYMJI7PS4CyXdel9VmJcLGNqQZ21m6J5X5CYj9LXc=;
	b=AQSaPvRxEPZz0iKuiamrqZuMhq6yIrREMJjxDiW1UoqvdhkWdcy7qxkfE0V35pqfco/z
	 0UiUNTM8fHErIOc6l1jgzv0+lThZPwYVdQDXhHR2C54B6+Gn0UgACXNnZ+U/gtq8iW0+8
	 yo5GTfsewMmBU9n1zAk7LQe25rxFAidUeVUNcdXrzQgqIIUr117SwRe6Le06nqdFZ1AET
	 OdU9JMY9UkRsAXvtoqnYTQR7pg8+j8/HrHKn8maCa0eGAqcf0DE1NWJ5NKMfx/XRbepES
	 QbEyDQMnbeaZhjNwwjXRLMM6b6WwtnJyN8Brk8lnJwrndvj5ttrKL79dK1+geVQnakg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tjcny5D8;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED07606A337
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 13:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BED07606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tjcny5D8
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-71ad047710aso5083943eaf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 05:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795787595; x=1796392395; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FvBYMJI7PS4CyXdel9VmJcLGNqQZ21m6J5X5CYj9LXc=;
        b=Tjcny5D8W+nwe0xv+4rGdAxegzBnwI+tR/jtaE3BgDJQw3hohXgNUCQi2og0dbZeax
         Qt7wdhu1RuN07YID2mU+BQC8MwXqdvBRH8dck3u64k6dlCWsBDFGAxU5LD/0Hfqd+nNe
         sPAAb7rWyZZjjR8UU8l/Hja6awfn1tY/KXu3ZA/geGW2HMv21m/J+YKQ8YcqydnGY4an
         +JB/yQ94xp9j2TDc+FWIxfB80B+y1iv25tGVGYWYIRHe2L/alnRIalVVq/uDHUFDFRL4
         isKV963jgnbRcAnI9Pzcxk17ZlI5giL9rTbfypAf/BWwDNXNidjYToKu+8VdwdcL8XGM
         SOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787595; x=1796392395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FvBYMJI7PS4CyXdel9VmJcLGNqQZ21m6J5X5CYj9LXc=;
        b=jBXi1pwJXEj/FyEDe1Pl2qebI7Vnq4Dq87kXNALNbf2qM6Y+0mdfJxbrzWeQXT3PuL
         kqdPqHIicP522Iog9MmRych1UWXQTiT5Wff4S9xp9rjsvNKAIYV2HLS3fvflL2Xf7RSv
         qDjG3Ebg6xe2RxC5pccCUo8mVSsPNjk1F8YXVe60yMZP3w20i6kI3juLoYYFxx9h6m1b
         fMW/khoDkfBQAetdNtEAC82kET5H4MFnfrOjPbZ69JpH/T8KK2gPcewTlz4OSFMK+H9n
         2G/uXCk0nyQ8D63k/ggE1dd6qNJVElN6HNl111hn2bCxiSJalW3+fiDwxIY5q2lSR0ZR
         Dt4g==
X-Gm-Message-State: APuU4Z+Ca2dnpqmQNKDdcc1VvnOKSIc0QZaZVoDz+0ewKEk0+MVn2GeB
	yh5mxAGfFO64X/OY6bXP2bnXCpXmRWaAOEJuHEu7yxxJMMvmxaduqtdM5IUPEQ==
X-Gm-Gg: AZFdTZcl37UGctlWqKmnCo8H2Odyf60VIwJkBpNNeuaLmfY/dhOLPvhPzpJzN1Wff64
	UweYo/HG82Ll/mTRtmeSToKySdGwUJOIIvJksooSR6Pi9pF91hMq4dKqLZAW2qncb44klwObDbi
	XEqdKwZ0VCz9hkMV5bx2PgY4aQhbNf1D4hFLJPPGVsoamtyA37YfwB4E07S7x9fg+L21aQOy/Vy
	PXt4fUiRaShqynpPmnKXklwW3jOKmG5VfbYxVF809t6tjjN4ZFq9MZg36ogHA/wW6sLDIZTQvAO
	evddTbt2vOixxu9dwg0BNdTYNiPziCxAYDFZx89jmcaJr3UnQfNqIYTg5mUYmH94djnOdf8t8Ye
	ey01Je6GTxyxGLgG2xViKIzIKxT7sR5gBz35DbsCuXSqzSRqx06cVWFYOkZRRIzzcUXMUe9nIW0
	rQ7SFNiUAW6bXrlDOu8rgQA1orgyr2o/wTe+6YXxiwXOFxosEugVsD+mLDRbqjts3Y6NWvaD2Rv
	An8ajGO5Q8EQayYiQtPXWnhzAM59mXXWrOfTAUowh9+jFfl0TWR1Uyse7x1wQXSfCQ9zWi8/Q37
	RkhEqbU=
X-Received: by 2002:a05:6820:c3c4:10b0:71a:f211:9526 with SMTP id 006d021491bc7-71b39261a01mr13432306eaf.9.1795787594520;
        Fri, 27 Nov 2026 05:53:14 -0800 (PST)
Received: from [172.17.0.2] ([20.64.17.110])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d9asm18223627a34.17.2026.11.27.05.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:53:14 -0800 (PST)
Message-ID: <6b098b4a.85e15926.314535.e47f@mx.google.com>
Date: Fri, 27 Nov 2026 05:53:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5855357236077560248=="
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
To: linux-bluetooth@vger.kernel.org, weihong.guan@gmail.com
Subject: RE: Bluetooth: hci_sync: Unfiltered scan for peers outside resolving list
In-Reply-To: <20261127054519.3146135-1-weihong.guan@gmail.com>
References: <20261127054519.3146135-1-weihong.guan@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5855357236077560248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223969/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.52 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      18.06 seconds
CheckAllWarning               PASS      20.93 seconds
CheckSparse                   PASS      22.39 seconds
BuildKernel32                 PASS      18.21 seconds
CheckKernelLLVM               PASS      18.45 seconds
TestRunnerSetup               PASS      413.90 seconds
TestRunner_l2cap-tester       PASS      14.45 seconds
TestRunner_iso-tester         PASS      10.33 seconds
TestRunner_bnep-tester        PASS      2.83 seconds
TestRunner_mgmt-tester        FAIL      86.29 seconds
TestRunner_rfcomm-tester      PASS      3.99 seconds
TestRunner_sco-tester         PASS      4.95 seconds
TestRunner_ioctl-tester       PASS      4.02 seconds
TestRunner_mesh-tester        PASS      3.94 seconds
TestRunner_smp-tester         PASS      3.87 seconds
TestRunner_userchan-tester    PASS      2.79 seconds
TestRunner_6lowpan-tester     PASS      3.93 seconds
IncrementalBuild              PASS      17.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: Unfiltered scan for peers outside resolving list
WARNING: Non-standard signature: Assisted-by:
#139: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#139: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15028060.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 529, Passed: 525 (99.2%), Failed: 4, Not Run: 0

Failed Test Cases
LL Privacy - Scan RPA - Auto-connect with IRK        Failed       0.016 seconds
LL Privacy - Scan RPA - Background report with IRK   Failed       0.016 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Timed out    2.006 seconds
LL Privacy - Add Device 3 (AL is full)               Timed out    2.008 seconds


https://github.com/bluez/bluetooth-next/pull/1238

---
Regards,
Linux Bluetooth


--===============5855357236077560248==--
