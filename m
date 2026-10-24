Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843450;
	b=o8UAmKBXjwaImgILZVrhfr7mKTKHH9R+5HclMXfyn6yU3c9osDQ/jrJnpIPLpx5aogew
	 t0HlOFHynC/u+mKIkp7ud8lcABMZYUFD0PeDcqIC6w4h9XMIczhZWfWsqrtW/uXFa9Nn8
	 Yfx0U6twMoLbjytHy24mCLIz7hYYTSeHG1NgVaawx9gEwBb+zGSG8iuhRDwiSBLaQy/dq
	 l7BguoirYlX0gNj7WEmE/coFQRjg/PHKwLGmgkqFuFgMeyxU/tdymXiY5YiCCrLQah+SG
	 c38FUDsmvwI51pKl8aBPJl9TbcjfTii+GMmJZWpI4UXlPjXcbvGWMo+Q+SEfdJEZ+HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=uai4PUXXFpQaubB6TuCmTUIx8wi2HADHj4/OJDVa+us=;
	b=mNbxXVfv7/C/Tjp0TDkk4PEjmtt/df6tSD9rEST14FazJsn5GeYvJbsgS+SvDTzqY/+a
	 9HIHOLEx1xgHjTFlVo6eI9fZcGKI90FHCg2DWxVZt0Rq9hCqXjBcdOZR4sGktfzRdkLSX
	 1C/DtNGjvm6HbwNVg3NBrULAOL7AGrn1uY8rmi6k2Kt0ZBvBN1s5kMBmlVsMtDGsvymwe
	 uKRJJDrtY6vTDXJ0fvAcqB5VQ6cPzaA1GnqWLfIC5QG1fPF1dSloX94nbIrMQNwIxTkwD
	 MAfQ8ncoif7d1Hh1NnEDO6KqhCreLx+CThj7m7mLgmtQZ33mViWrv8EyMZES/dlKo6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PytqEDmX;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B34606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 12:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B34606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PytqEDmX
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35c76e9614aso2586956eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792843449; x=1793448249; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uai4PUXXFpQaubB6TuCmTUIx8wi2HADHj4/OJDVa+us=;
        b=PytqEDmXG9j7MzYb0OhD8JsIh5jFFc2tRg7W10hQF2QmWzj/2qE172xLPZfI+yhVJe
         VFOHqus4lNb6gUyqfHXUrHQqoPgCZ8BtGxmy1E5M9J4+qnUQTux28BeuyLMX5HauIVLi
         rjsOD3mBy5wMQJxJB8OuPa+4f8cYsObVwssW3O7B2LFGNe12whx0xudEZiQHgyegSkcB
         oEXppfZuxFEG1wb/0CyJ7Y5zBQ1YohrL/VMsrgeHKPtwS39kbPiwo65/Aj6Z/TFGyVRC
         y9juEjbMezR3+gHIk1J98mr84WIOP1Acfo69OVY3SNpZaoQjG1qXKmc3sNs5Tw/8i7mg
         E5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792843449; x=1793448249;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uai4PUXXFpQaubB6TuCmTUIx8wi2HADHj4/OJDVa+us=;
        b=dzk+TiT3pOKYOeE3ONe070ynTLzrlmLIzHcarDN7nhmdRAzN0dYTpnex4zQxPTHE9g
         lHa0x4ulvf/b994dFv/yojtwL6elQ/F8ZGBCkNC5m4wlwHX5syrpNYtwSlKTm72ndq7T
         tVVReKNTf1gsNS1p/eLM+JQpaSqQvDSyIgqDJLOrwB/FdCEL42EhP6VRUMcucI+uRL32
         U1TqeSVHbfBeDRGFYSX5Vze/9yJA24qNHpz0bbcKyiQ0Svpe8WC/owUjzlBVVd3ggXVJ
         YtOlxcyZxmMau1hLAaKfbk3AA3sO9RcZJhLUSDi22Clbiwjv8xH7sje3C2EWkTmn+q3j
         5X4Q==
X-Gm-Message-State: AFq9FYLU4kixB7dpKNM67PlbrhaH2OEV+pes2VA+oFdqAl9KemzOQEJ6
	LwSOBbhM9b9kofF6onKxYKOp0a4Mcawob2uVwzX0l1bLx5lrLAvfpzE0RxE0Jw==
X-Gm-Gg: AYBFou33calMpOgxW7uI8dV6WQeHhz8QgAnp/a/76PGss00q2PKky1zDeG3dJwOqcU2
	a+Q5Vl0IVuC9iyRzdFkrVLQSyJ1Ha/tEcTDdNs3y9cvkgOPRBcN3uQIRldwvFn0KUYhHm5TiqRe
	k+sJ1tWvGShtYzKjg6OIb+W48qTWN/T8J8n1hle846tYwqBMbWvvcBY10oHvAyT4uXMmDOwRxuK
	6FYMRSdrAHJjjWTmrMGilW0nDS5L9Qc3bMvtd1Hbzgst3bgrVx3+7rmu2c3mUxXfsiekkWRksOA
	K25nGYN45I1M/kPlUkh8nI49Og6ZayM6hXPGVdgfRDIbEyDzgHIUsZueBquZiBXtpPfxu84PJDL
	It9HWR+aFDh2NUN9M5XeQ3sPoHgXyx5p6ElpuhBOlQzNxTUCYhJFD5FsWUJnGsZR+63OapLCg2f
	tZorp2RZQcv+OHV7aoyOdJ3mqIfhYgn8jtO+2mqLxw/KxvmUEpkznocNAq9K45xmtUw/jyHFXBK
	bnlbqRR6OqnAK2B4XeusUQPzDJUAoL6P3Ixad4zw1qD3qzVmtzJ15NL5A9bvA==
X-Received: by 2002:a05:7301:c011:b0:358:ec5c:bef1 with SMTP id 5a478bee46e88-369e8620428mr2739421eec.39.1792843448427;
        Sat, 24 Oct 2026 05:04:08 -0700 (PDT)
Received: from [172.17.0.2] ([4.249.21.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm12187434eec.25.2026.10.24.05.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:04:07 -0700 (PDT)
Message-ID: <6adc9eb7.4b6e150d.3aa805.71df@mx.google.com>
Date: Sat, 24 Oct 2026 05:04:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8628728655640738539=="
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
To: linux-bluetooth@vger.kernel.org, 2122295973@qq.com
Subject: RE: Bluetooth: RFCOMM: hold the listener across child teardown
In-Reply-To: <tencent_8E1E52CF977BFA4D99F205853D3A71F1D306@qq.com>
References: <tencent_8E1E52CF977BFA4D99F205853D3A71F1D306@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8628728655640738539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192576/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.55 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      22.77 seconds
CheckAllWarning               PASS      26.51 seconds
CheckSparse                   PASS      28.85 seconds
BuildKernel32                 PASS      23.11 seconds
CheckKernelLLVM               PASS      25.68 seconds
TestRunnerSetup               PASS      530.02 seconds
TestRunner_rfcomm-tester      PASS      7.19 seconds
IncrementalBuild              PASS      22.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: RFCOMM: hold the listener across child teardown
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 4020751fd0df ("Bluetooth: L2CAP: Hold the listener while notifying child teardown")'
#114: 
Same class as 4020751fd0df (L2CAP) and b4a00dedc5cc (ISO): hold the

total: 1 errors, 0 warnings, 0 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14911944.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/994

---
Regards,
Linux Bluetooth


--===============8628728655640738539==--
