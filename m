Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005665;
	b=cK/wK1XPj71vdJfIsPRLKpiRtmEW4mo3mbAr26fO7Cfy7e75nbqrTF7nKBPnJm7JXmtm
	 gaoIz1ofdie5dvgU4MO2huXJj1qoomfve2JOhYrQoaQSo8sJKxKiBEOc/bAOFaOsDS5Kz
	 EGHKwU8thKe0u9zEYkvVNcgzroaHOR2kaLiIBUvTy9D6Y47xUhdZ7owtcAJjPCOI/KGFA
	 2/iD3qgcWgvSRoOlEcab/jKimrQtGOGV2b1LkiI+lCEwg+VJ5/h5hToIf0tRz+7dM7jhM
	 HSHBHufEDdG9cJprAxcR3REjKPppsJz544rKqKBfwjsKTyqr7TIu7193qah52nXWlnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=O2LgCOIxW0Yvda0Up+GPTfleHxXbXeXC4lQ/kvHf8QU=;
	b=jm3R0y5s4RGJcEFCnIARxab3gCjK75dwROmSUSr7dYAlvxixRv1+ovGvPaAuo+5fjrt/
	 kAt0+ujyoqSiIXEtdLEdTeocr5Etv6OkQxRaY63faI1LSBQFzxGE6NoUEC8+d14oBT30O
	 d8SFISTOCcypMhVqqtXJHwpn557+GRuavz6narGZCi/xFpwRNi7xQQCw2AGiB/j6ZG2//
	 m1RGPceqkcg6OPCv0dIZ+dlD5iR7RhrHVz9+NEDIvg4IXubHwDZ51dllEciUNm5fo4y6i
	 AKu07u3FI/9FcbeAiA2zaNY+VMCyFpV6fyT4tfpfHVheD3scS6+5SHNNj5XFGfKVGgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHFlF06q;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21F606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 22:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F21F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHFlF06q
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1438d9363fbso106642c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 14:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794005664; x=1794610464; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O2LgCOIxW0Yvda0Up+GPTfleHxXbXeXC4lQ/kvHf8QU=;
        b=JHFlF06qWvpr+cpBVXzLyvQiyF8JIqMzVMUdhcCMQwvjuZGyDfBj+IDG0z47jmyG6f
         Jm6MNSm490MigZs92gc2OY6egGZL2kZ/7n8OKnUs+n9kN9sVBF/yqTNp/fSnSD88Mb5M
         wI0AL/xPQejFKX9Vnt9dKCknSXwIA/ZfOCYUunp3Ko0O7TMxSTtOwvemUs7lxv2M60i5
         sGujokK8WE0sd511CaHBeLjTjwkvANzqavW0iGF8cQMdI86OeZfBhBTxEffrpdQCqWte
         1opNbk0Dmv+wcNtQTAmkFVhHvAhND8X6N84Oa+vDPxec8wiozhq+4LY/DUY+wcHCWjOA
         sfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794005664; x=1794610464;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O2LgCOIxW0Yvda0Up+GPTfleHxXbXeXC4lQ/kvHf8QU=;
        b=pd69Jr1eH60tre507nk8TU75y5vIKH5Dr36sLkSj19Co1zvpdxiR5kgsiQ7XsC5+It
         3kObK4Y10sL6BThIFqF8MVlLm3icTFv6di6dSC+P4sUuKQwBm7pYp24BGW3SZXlxtDHu
         aTjnlGZL91ufg/1uR6hLgJoaUmU4r51UT+r8M1DxzErcyPRegO8e63J8lQ963CrpQJtD
         pmRqgh09cvcEwdsiax37rhK49ZA6Pz+LB1aTbZsN6y8G44M503bF6IpV7kFfoNPTvJDr
         BYrKTgOPAPNFGQtN+US3aBOAndxF3i3NYxAFR/K4hSWsVpZBsti1P2pryXK3bSTDr9vJ
         7+bg==
X-Gm-Message-State: APuU4Z9hTiPs2KK0kqIIGSj8fObevRIRvqvt8OMRZQAmDqz3AWnzqKD8
	BCtJvwmPUjb3/47LHSEQsZO28/13w2toj+2zS5VPbae/Ej7PChmZcPbdz3YdBA==
X-Gm-Gg: AYBFou2c3R9688D9DnW42KHECwe9t+gAaHGowz43DGPXQw8wtu4og9PZsN8cyUgXm4a
	1PPDRlklhm1FTx95P5UKt0ZOuWN2wmPU/VVFz+MuydLp2WKCZAr2hKei98uXdVZbgtI/eMvZgth
	1UTvAy4froxh7bp08Yhe7sE+XMzKBPGp9QEwieBaB+qghRB5zumOAvKwLqoSctuvLOVu1Lrr7Bg
	uruis5IhNYFfHVI1wrRxADVaL8BDGgsB02g5PTuOvKVlJjeoY+AaMC0Krf04MONoSdA20cpjAF5
	si1efOdQ3fJLCWsoOVOx8C7cw1wXpvuiPEf349VBDDkIzNu+KYdcgNp2PCeTR9PxEoSeMmlVPOf
	Biw4GvsFm8jn89YYxn3B8p4FzuLh+zO9em1EVouZRNvuUIfAScU3TeAEyWV4nJI1omM2TS+zi8P
	tMGT/1VjtHm/8zIjPeBz5N2h2nLdtVOCRx4qRJJJWNBSsS/4z0SmOpnzO1J1abSgcmlpZcVOB/k
	rLw6HiBo0SV6lUEG9cKyVTVT+v0ZQoYa6K/jnQcFqtvq+DgIEbVU3e7a+o+0Os=
X-Received: by 2002:a05:7022:b043:20b0:1b2:581d:5dc7 with SMTP id a92af1059eb24-1b269b3a18amr523266c88.25.1794005663430;
        Fri, 06 Nov 2026 14:54:23 -0800 (PST)
Received: from [172.17.0.2] ([20.168.139.27])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a63f6sm11290858c88.9.2026.11.06.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:54:22 -0800 (PST)
Message-ID: <6aee5a9e.ccc6ed06.248315.5e28@mx.google.com>
Date: Fri, 06 Nov 2026 14:54:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1827643543245676144=="
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
Subject: RE: [RFC,v6,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
In-Reply-To: <20261106173948.596166-1-cochcoder@proton.me>
References: <20261106173948.596166-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1827643543245676144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204403/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.10 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.44 seconds
CheckAllWarning               PASS      36.82 seconds
CheckSparse                   PASS      39.32 seconds
BuildKernel32                 PASS      32.47 seconds
CheckKernelLLVM               PASS      35.58 seconds
TestRunnerSetup               PASS      760.04 seconds
TestRunner_l2cap-tester       PASS      12.91 seconds
TestRunner_smp-tester         PASS      4.42 seconds
IncrementalBuild              PASS      43.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v6,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
WARNING: Non-standard signature: Assisted-by:
#106: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#106: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 452 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14958622.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,v6,2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
WARNING: Non-standard signature: Assisted-by:
#102: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#102: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14958623.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1080

---
Regards,
Linux Bluetooth


--===============1827643543245676144==--
