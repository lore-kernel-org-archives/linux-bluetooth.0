Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018762;
	b=GmXa/eZJptHL4g6M3Vbp9LXAiTvUMWF9iodk3F5O9EC71yRXCzuoBPtwV8Ap6v1Drmqn
	 UUoJjXL44Zz2WK6Nf9SsieXVsfY61zj4/b/g+aUBIethorcr4dbHtptuBGfrl8hSkBmjk
	 8iALpLJ33VJ8JnB+NUXsW79VpVB4kcdMAyQTzqSkFXbfX/QdY5m5yIt1iE8F8fTfWJD/d
	 Y9moq8FwJdjvfZpZC3VwgFIwa2bqIABm9/PAiKMFeIQoPOcSl7HywDwdtR0pYJmNuZ7i/
	 /ubYHbE6S/b7YCpOLXpjX23hMYQ293py6UQxQNQVnmcab0/TfkXLxXsp0vbOl0ePAnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=yU5TwzyriqKx+Z3VCtaneB/3E6PVWECjXsFVIDoWFRs=;
	b=cgAHQbcUB1bwSsfXAh9L8mdGnhBkm69AK1D9+LIHcY5UF5VuBe2J1LxtYECrOG2sHO7m
	 1/cwVq2Ov+e7W06uT+HhPA6I/HUdyNLaIIEExN0bBurZ0NZWDiF/coGtF3omwIK7qU7Ta
	 24QKPFAEE3IKr9hupSmlk43HyHadN+X49UIQ7P/Iged4lSS0Lt2k6DJ/hSAfThyE4DHL7
	 YjkAH/W2UQVIN1g97hXQBqm1X2LQixb2doLjXtI52DPx9CsfBc/GhA5QR5A1283oiQi4Z
	 TFymO+hjBDKFfCmJFBflFFmbexYMXECLbI5bnLTmsopPCEKNUH2FfQgHTSlRm31y8JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="phMrHVR/";
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A70606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 02:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A70606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phMrHVR/
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4af173320f9so770866b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 18:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794018761; x=1794623561; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yU5TwzyriqKx+Z3VCtaneB/3E6PVWECjXsFVIDoWFRs=;
        b=phMrHVR/4dDcusWthH3/DMCrrdtuFnZJzgcni4cba3Dc0y/7QC5LAEpHDwO/NNl2Az
         5XCqLVsRKx3UdkzqaHKcmnWtgaAXcAYvUFmu0md2trCcP3Uy6fFGcm0MMbtEcyCxSKaR
         Z/Zzn+4i8zZYYwcc9FtwAIodEw1z/aBJUJ2yeLhwwdX2yjTnPur2Sr45OTK9GAZhLCQP
         Ox1ng2JKq7H+vriVN87GmsP+UzKjuckYbf8Io8w2C6sUkH8YLE/hq2mtf1f/hSaX86X9
         xZBqK4QG2FyCsEqEDHHEndDZMF8T4/4sR3yqVlRh6xpImNUAf1Dvh8d+J5/yG4eFkm3k
         ppvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018761; x=1794623561;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yU5TwzyriqKx+Z3VCtaneB/3E6PVWECjXsFVIDoWFRs=;
        b=h+/FSzmU7WAY0rp5A1DZ+V/hADBk4qXZ4rV1mUxucVdl0jqkdltb1D/EtpOjoJYlF3
         NL4qb/q24jUu8qxrM07XA+VGemrct2wJl0qciUwCFFVNFi0BCtociP8/NKL/YnECw9eT
         JOrX4UiLTet1O5kz7B2cCwx4bLmKyzif/HBlNnQGJrqX8/F3lDLeEcQRIO3Hg9WJgOzC
         2tuNd9PF4gJcRBTOwo0Z7on3gXcnwqdrnFgeWVFOWD5XNKYGAvydSZayGAKlqYiWJqiy
         OVxnb8CFGUkB6iffnp/MsS57+f+sljvTzjuD9ptPm6gS2bPtLfkVjMVC/9f9O3QuRyHO
         WVGw==
X-Gm-Message-State: APuU4Z8k6TzAf6VCb251FGaHrTFpESadK8ktpQ1/9lxuILqb42LRZ/xp
	vdrrz/yd1Cusiqao77YXGwj04qb4NNezwOnGY4ypW1EqAZNd/AGerhqm4Nc1nw==
X-Gm-Gg: AYBFou39ueb/eYYfSKPQy1xw5v/vVPEMjvn0h1/O3mFUUzl9r42sHvg9XP0iNaMKqtI
	QntuNzOaNKPN4MPEOz8muZvyGPWpKNy67j1TepltXTcDU2wzSRR+Tbm4vPUdPA53rNO4cs80XHC
	eWWoqztNgRd5nIGdVI4MeOmcS7srDe5sYfkggeE+sa1ZDxojucKFeU67A1jgnAweuDPvcT30tLu
	OikUsPuOafdkB0tc84H3qC5nc3vCr1PAAA1WgTHi2erj9ftpqmtZVI/y43Ge1qz3bR8o5SKD7fG
	YZtwslC8GcjhL4ymwSomaKT1TQP70K6TChOdzaLK8o3xjb4gcw3XjUZ5VO4d0IrV5CM9CZchvZ3
	0SByHcjgNLtcG/aZ7wFOtaLNHmJxFpNPUaIAoZlcrVHGSg71Ge8G9r2sPPdR3yrgbKHqqnrCzYW
	fwnlw87TveTom9jVena+KXziThk+eNht1jP3NV1WlfxNfab1eHt8m/J7s0Bi8pKOT3VDjyz9cBI
	nSlkakUIb4MuY5QWaZURJrVwp3Wtf0SVdM/+WPBDm2Kdr9orwUXWGkfv7W02ynEew==
X-Received: by 2002:a05:6808:4f0f:b0:538:d44:aaaa with SMTP id 5614622812f47-567e142bd5amr3745074b6e.63.1794018760978;
        Fri, 06 Nov 2026 18:32:40 -0800 (PST)
Received: from [172.17.0.2] ([172.212.206.143])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7ddc155sm2921525b6e.7.2026.11.06.18.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:32:40 -0800 (PST)
Message-ID: <6aee8dc8.29ad0bcc.319609.f0ad@mx.google.com>
Date: Fri, 06 Nov 2026 18:32:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5386272757372195686=="
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
Subject: RE: [RFC,v2] asha: Defer BR/EDR inquiry while streaming
In-Reply-To: <20261107014841.1452698-1-cochcoder@proton.me>
References: <20261107014841.1452698-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5386272757372195686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204674/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.43 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      13.16 seconds
BluezMake                     PASS      172.69 seconds
MakeCheck                     PASS      4.37 seconds
MakeDistcheck                 PASS      97.45 seconds
CheckValgrind                 PASS      99.01 seconds
CheckSmatch                   PASS      167.41 seconds
bluezmakeextell               PASS      63.27 seconds
TestFunctional                PASS      849.21 seconds
IncrementalBuild              PASS      171.57 seconds
ScanBuild                     PASS      583.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v2] asha: Defer BR/EDR inquiry while streaming
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#134: FILE: profiles/audio/asha.c:76:
+		btd_adapter_le_audio_unref(device_get_adapter(asha_dev->device));

WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 80 columns
#292: FILE: src/adapter.c:2077:
+		/* Reject new requests; retain accepted sessions until audio stops. */

/home/runner/work/bluez/bluez/src/patch/14959730.patch total: 0 errors, 2 warnings, 244 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14959730.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2776

---
Regards,
Linux Bluetooth


--===============5386272757372195686==--
