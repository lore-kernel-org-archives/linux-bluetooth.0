Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421286;
	b=tO+oraEUrNQz2gyqMYeuXWsskObAn97hL3IGwumZml49NpIMURFPNndxUX7J0YhY8FQY
	 XxMn/ZWFg5lJxUVA3FA+Ee2x4pXjlWj7oPvkueCq9VxE/RCxlabWdwta7PZHOYZQBQIkm
	 4OXYnFrfnxaNgYXXlIMP5lpbxNcT3i7JsginEpIj7ss4qgKa9WpgCnzV16dMwDr3NXxJ2
	 849b9fmCF3a54EnHu8oaOXh65tvZe+J9qKCcoWEfQKaqRF0BVEV0BWbTmBsjBAAZRc1zR
	 G0D5baL+0RQFfQo4s2PJtQ+MaqMORRwFCl2KV0YEmzvT6RquzMCWsUriKPAtxo2R1Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=miHNYOiHoBsXOUW0Tp1IpO8bnmJi1QyyYcHYboPtbtY=;
	b=kz1X8SQfpgCFHttNTYx8o7GOmlJ+a0x5TZYS4HNo3E0cPRrIXZg75Uzq64+MJmsTb+W5
	 38+F4MkYv7OzDX0wckVhxuOLQt0HVTSgS3HdTI5PiT0plr4gnqQtcLK6o8JH+I2TgR9RU
	 u2VPmIylTT1z/YT/JEm5lafnaeiYLfQ0/oEd80cZhy5HzujbX9hLoNDcl6uj1IvTBuzzi
	 KGKrov5CjvgC7h6aatvb8Co9lphmuYKxYCx9XOsXXXwYy/RsVgxGXBkilLbxI6EdwWsgt
	 RXOTU0St+tFYEglEzhnKkbZ0JIfrRtzQpungx9Yl1GoOcIFUWVAa8V5Gu+Fuki2hbBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Fzx/kuns";
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0E606A324
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4D0E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fzx/kuns
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91eb5559b34so26098486d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 10:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794421284; x=1795026084; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=miHNYOiHoBsXOUW0Tp1IpO8bnmJi1QyyYcHYboPtbtY=;
        b=Fzx/kunsZNdXKMh/tUXSyVIRcHmMdHkVKLmFbXMCCu61R8LD9nGJ/sm0hAsx/tQ+UX
         0E4ME8AnoWiwRbQBmC3eAxP8KfPmxDcLN1vQVN5jl72X+5IoWp+xRejLxmHoqQgFE12r
         RIR9JoEomGMzEXZ1lzpWVWCyKZmfOLWP7sgpEDg4DeEW2YYYgWdZNPQ7V+n82BvXd1AK
         HCXdVGz5QAA0aBnEBHCnku83+p1Urm5u7T98ignBG2Jsbb2ScvOQ3UPgBa1dVYJO5l+s
         7TdWrmcKtOIdVLP+O/9XVbBFu4fArIzWXRcES9w+4UW+Elg8M4seXj4Q6U07lxKi4tQt
         UvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421284; x=1795026084;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=miHNYOiHoBsXOUW0Tp1IpO8bnmJi1QyyYcHYboPtbtY=;
        b=Qgcm0GgMRFO4O4P6jIfVB2PXGMms3OWzSXBUCbJs40SUWJpgPeY7I3noUtUlD5aVhZ
         bFM+ZQNTBEFKU1XdV3fD+9EEXrKWKdbwzOaN3dc1PXYPOHAmGvGEbPlrfKgxFpP7si2h
         Xygz4YAH3yfmhsrgNltZrIoEuXRYTMeKsNqXC8XPjBf9LQzqL8jmdcek/lXbka+S6N3I
         XVRRu0Ob4ElFWJnGQR2aaG8jG0bArWBY7dJE1qeStbcaxJBUkAgQ5NgkkSyK5oqqHaB2
         iTagSejOc/n923xNgHIOhU3diR9bWPL2jsceaWoEiJhpc0z5Wp/f8lRBqCO3lNOlIYBp
         bv2w==
X-Gm-Message-State: APuU4Z+eFRgkrWWosFlEZ1Y8lUEo+4D8PSORTAtQvmJIEFquF1Blt1tK
	rb/aWgfyiqNbEkBx8eSpOIs9/Bx9lfxha8cIxQm7SKoMLFx0bQn7QZgXNlvtgw==
X-Gm-Gg: AYBFou1Fr2WMVT8/uCnIhDjnl39KAWf8GwlsHy4P0qKqQWFfHkugqVTsIdCelz5Pbr6
	u63Qk/Q1VFWZRi3qs2Z3b5jCG+AsfVgKgbu05ZsVWAJbP+JCjkEcTeDus1lv7wRJGrdFSq30jqB
	EVSs5hKtgmwQ0HDb0zvd/j3y2Wve/6S3zA3doILO9imoH6wwTl5RUqvnL72G2TrZuoV+1RMQgvI
	qBkfwuztZFOFcuHUQJfAG0nlYMURIzdddqKaZPRIBEkrtnrzjv70J83R5EjPT0KjYA2+t/LOn4G
	kHhKVYi9Eu+axmNi6/wW8RMpbeO1vRqTt8EPQXEoE4EXdYsPWUZpWV2ScKezu0ydla+HioGiUnM
	zgr7a8Fmp5AEnG5Wq0R/IGTFr2+mKhz5T6FCY9yM7wWmnSYEEtpNGeg45LZR16dIof4Xp7udRSZ
	uIKHCmArajBHxg5l5NlviGX9/Vhe5dRI6zg8HDudo+XZJEAb/SCuDK6xeOXH7Lu3UCukWVb5lP7
	Jclr9R1u51ytAs3YlvYFpmtU6gS5YS1q8nt7NRJhgu+tWc55HwpnbGu2dcaSlk=
X-Received: by 2002:a05:6214:3986:b0:917:949d:1cfa with SMTP id 6a1803df08f44-91f040e82ccmr54254546d6.33.1794421284474;
        Wed, 11 Nov 2026 10:21:24 -0800 (PST)
Received: from [172.17.0.2] ([20.109.71.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f09531a3csm17068296d6.5.2026.11.11.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:21:24 -0800 (PST)
Message-ID: <6af4b224.b0b4b201.1d9e8.638a@mx.google.com>
Date: Wed, 11 Nov 2026 10:21:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6374774344164737247=="
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
Subject: RE: Bluetooth: Advertising sets on a single-set controller
In-Reply-To: <20261111165133.827594-2-weihong.guan@gmail.com>
References: <20261111165133.827594-2-weihong.guan@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6374774344164737247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208570/

---Test result---

Test Summary:
CheckPatch                    FAIL      8.49 seconds
VerifyFixes                   PASS      6.43 seconds
VerifySignedoff               PASS      1.36 seconds
GitLint                       PASS      14.44 seconds
SubjectPrefix                 PASS      17.47 seconds
BuildKernel                   PASS      23.98 seconds
CheckAllWarning               PASS      27.11 seconds
CheckSparse                   WARNING   29.23 seconds
BuildKernel32                 PASS      24.75 seconds
CheckKernelLLVM               PASS      26.34 seconds
TestRunnerSetup               PASS      559.69 seconds
TestRunner_l2cap-tester       PASS      13.34 seconds
TestRunner_iso-tester         PASS      9.70 seconds
TestRunner_bnep-tester        PASS      2.91 seconds
TestRunner_mgmt-tester        PASS      84.50 seconds
TestRunner_rfcomm-tester      PASS      4.18 seconds
TestRunner_sco-tester         PASS      5.20 seconds
TestRunner_ioctl-tester       PASS      4.35 seconds
TestRunner_mesh-tester        PASS      5.23 seconds
TestRunner_smp-tester         PASS      4.05 seconds
TestRunner_userchan-tester    PASS      3.02 seconds
TestRunner_6lowpan-tester     PASS      4.19 seconds
IncrementalBuild              PASS      43.26 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/4] Bluetooth: hci_sync: Set random address on the set's handle
WARNING: Non-standard signature: Assisted-by:
#147: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#147: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 57 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14973062.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,2/4] Bluetooth: hci_sync: Remove an advertising set by its handle
WARNING: Non-standard signature: Assisted-by:
#151: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#151: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14973063.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,3/4] Bluetooth: hci_core: Add hci_free_adv_instance()
WARNING: Non-standard signature: Assisted-by:
#130: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#130: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 45 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14973064.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,4/4] Bluetooth: hci_event: Find the owner of a terminated adv set
WARNING: Non-standard signature: Assisted-by:
#144: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#144: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 74 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14973065.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1113

---
Regards,
Linux Bluetooth


--===============6374774344164737247==--
