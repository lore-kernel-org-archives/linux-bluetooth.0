Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368339;
	b=bIFid+rFsJfF/oWRaW1Pux0nOIAN8Mwe5Jm/HVZCNo8TYv5LTaOdDd5tNSYsAosdWFuq
	 Fsr8jwnMZl2G2ATboXFECx/M2H605C+k4SY/Q3rJK5YE9TOyYb3FFgGQY66VEUByoJPMB
	 FrxyvkBF+3TgbmpHW3z95azsauS7o0FTA67xW+A6fNXQuU3rj/DXAG0u/vP/lFFbBDFCI
	 m6+r74QOID7+pDco4JjyefnSOcGgo5kDKV1tWGHu7N7yuwaIm8AC1eeKNSYxtTUG4rURO
	 vv+/joeUGjnL65qrMtom+1FSARN3N27nOz3hpBuu5tnzsEWMSn6ZATwwt7aHIuZpxmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=szFxzhtzPHrJUeV7l7eV78wafTLXdezHbdBV9lkayxU=;
	b=KayywtUDhtl9abJoPFChMOQIKyAuW0N+o3SW+vb2+qsDFkR+38NbuL/NrYVclshodSM/
	 uRWXMNdT7/owZi05M7D/QhSnrwcsN46m3X1Dh7f9Qdim6VCYnnwCYO0eudb/t/RZFp3NU
	 kIj9qCwfJDxQkgHjBhuYkE5RjbFEbHQ9NbIIEVP78MGv6wKzC7yAZGaxQvNNeFWOrzq0p
	 6R1wnKDkuRnMPe979ACe1exTMeiFK+CdEp0ujlS6WD4kl26PxR4rx+IRTiixJ+/K6v4Cb
	 6SJN9hSVYh38OZBB1US0hnuXYKvReegj3QF7klv7qbosLvPCiM3Ha4iwGQJMr0r90sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVu57D1D;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4E606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 03:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC4E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVu57D1D
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b3acec6677so4297374c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 19:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794368339; x=1794973139; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=szFxzhtzPHrJUeV7l7eV78wafTLXdezHbdBV9lkayxU=;
        b=rVu57D1Dn/ZUyjCtkjMv+ZEGYSo9LaaT2bQ0iFQrOe/qq+Y6hmbti5LNUjqc+JxWtI
         jtNu02M0q3E6rndP5pgG0ZFmP4pQWWjW+P4trYl/P0v5WOMNWtV4c7OqhH2722NrfP8X
         98MWM7CX+YEwYmxtiouVU8IVUtzLjBWvsyZ4rqQ4aANIz55txLYOR2osDf5S9m63I4cj
         TSo7fMB+XpLhFeJ+9gDmtVtzzzshhhMkOx2GPGgms2VwBXSPP077Xxdh8bNdt1uBPS1k
         zprUb1HamkxJBhUT/Fee0znPSPDeduXSPWDXWnV3AQuaQqs8PJ/d9zlcXPjadAOrhe9z
         Sf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368339; x=1794973139;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=szFxzhtzPHrJUeV7l7eV78wafTLXdezHbdBV9lkayxU=;
        b=E76peFKT10AQpfAkqwtyK35+OLzPxOiAmj7kEaaD0cCOSx4Bb+ujA06BtrIfNIhQaM
         ZgK66nBQnIjG/dzmaYV7iENVOCmf2ah+j/8pAcp2HFgb2u9iI6mLXYF/rWVMbaucwRq4
         d3biToxz2lbXw0imtBFtheItcyJSIJFDMpJRkpymDid62/NKKuB1FCEkpZf6ZG2wQEF3
         fgwbzQrtfNEqYrbOhnLffWcMUEjeLMLFRm8RybWqmuEytTzYF1V1SGYkjBdZnCXuFV/G
         E3h1tka/3leO0ZVfwSjefFSqDbamR9UY2PvV5UJFJsz9xvPKWfvk5caleeP8Abbro/Jr
         /5lw==
X-Gm-Message-State: APuU4Z9fsjazYVayTjpmeyQSvBcPVLWLtWXviEM3cp04HRB+DRvpJLGt
	ZVDkf8MAsa+gIlkF9mnsXMYZ/zjmS3G/Em0cOtfieUsmAfo88INnFNyTh1XjPw==
X-Gm-Gg: AYBFou0kAC29bG2b1MbW/qR0zltGj48hg4HUctUAmVC4F2pV1yz9fg8ErMgwN9y0AAA
	GX1EOK0qZZhpDPLq+Y03yWfc1wAEBYoXccNN07+OGVHWpejMfcObVh4FSExLpGIY45qvTNU7HKt
	Ol01xHfSBPEqp5Fo706fB52g1aB2TtDxCsWGnUtsGqgeZc1O3JtgGX+XAD69inWB7otl9xNE+Sd
	+cygGxT9hQZzZbuu5G5LzblfQIAIPwHGvN9BWlg4CT7lOspzi+Vxxj/43VPRZyDpmhb6zqaip55
	LEdpDEnLEiIhWtt3mJoxqgVksqpO0ZuRB8vzpa0DiqCVhX9+xjKN+APUvzfwNalGqiJxnfK7BEE
	5FfjhJjU7JN6QBjx8vsUokZZOBil5zoUa3MyweeuyHFJo5uSYqJwJAsUDBHGmiwmWGVBOLzsaFn
	avmH/j9/AMtaQQblZD+rf/uVXDeFhnbkZzGZXsqhGWuWqT+1lCAnX/hx1xL396Zs1mJ0uD0x9gf
	7cRinJ5GAQhopf+/1vdXX+QWgcZGnPV+uMPsZOqE43BWrDtS6aqdOyUsomH1g==
X-Received: by 2002:a05:7022:ed07:b0:188:ea93:6cf9 with SMTP id a92af1059eb24-1b3c0359347mr1171002c88.43.1794368338322;
        Tue, 10 Nov 2026 19:38:58 -0800 (PST)
Received: from [172.17.0.2] ([52.148.6.187])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm11589268c88.9.2026.11.10.19.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:38:57 -0800 (PST)
Message-ID: <6af3e351.ccc6ed06.225e89.a580@mx.google.com>
Date: Tue, 10 Nov 2026 19:38:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3828343636909998370=="
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
In-Reply-To: <20261111010940.728149-2-weihong.guan@gmail.com>
References: <20261111010940.728149-2-weihong.guan@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3828343636909998370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1207749/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.03 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.79 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      30.54 seconds
CheckAllWarning               PASS      35.27 seconds
CheckSparse                   WARNING   38.33 seconds
BuildKernel32                 PASS      31.28 seconds
CheckKernelLLVM               PASS      35.13 seconds
TestRunnerSetup               PASS      743.16 seconds
TestRunner_l2cap-tester       PASS      12.85 seconds
TestRunner_iso-tester         PASS      10.75 seconds
TestRunner_bnep-tester        PASS      3.16 seconds
TestRunner_mgmt-tester        PASS      88.40 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      5.68 seconds
TestRunner_ioctl-tester       PASS      4.71 seconds
TestRunner_mesh-tester        PASS      5.54 seconds
TestRunner_smp-tester         PASS      4.43 seconds
TestRunner_userchan-tester    PASS      3.24 seconds
TestRunner_6lowpan-tester     PASS      4.43 seconds
IncrementalBuild              PASS      35.94 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/3] Bluetooth: hci_sync: Set an advertising set's random address on its handle
WARNING: Non-standard signature: Assisted-by:
#147: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#147: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 57 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14970766.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/3] Bluetooth: hci_sync: Remove an advertising set by its handle
WARNING: Non-standard signature: Assisted-by:
#151: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#151: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14970767.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,3/3] Bluetooth: hci_event: Find the instance owning a terminated advertising set
WARNING: Non-standard signature: Assisted-by:
#143: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#143: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 74 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14970768.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/3] Bluetooth: hci_sync: Set an advertising set's random address on its handle

1: T1 Title exceeds max length (83>80): "[v2,1/3] Bluetooth: hci_sync: Set an advertising set's random address on its handle"
[v2,3/3] Bluetooth: hci_event: Find the instance owning a terminated advertising set

1: T1 Title exceeds max length (84>80): "[v2,3/3] Bluetooth: hci_event: Find the instance owning a terminated advertising set"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1108

---
Regards,
Linux Bluetooth


--===============3828343636909998370==--
