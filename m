Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181432;
	b=qgX7/6QV4DiSSurK4YkjNmek2mFWf9fyEPspy/drAlXUBPOauN12++fDL7d8dHV81mbj
	 1kaiXs/AJkcKNdH34pWkx7Luym1rwjI7LB/kGkIxhJ0JDcdYySZTbE25/nBJPYHeH/wy/
	 snjuGQ8h4obKttepLhyjHxS5fwjBeJ5i2Pzr1AbhISyf7iLdQB/Iws3Jc81TANU6YYKRq
	 xN/gUiRmMNXdZeHFnlG/4Djp3NWW/NAB4kmgcap8G+rLDj0+qMQsSeqxqRoywh7aZUfrm
	 rBD/R23y++yNkqFS0NRHhR42xowa6TP060yJbVcYllvAAira2EBnUvMME7AlUZJhsGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=y+9XR3IW13wg6bSjQF5sU+E0GKGlbXe/DPiWIBwUTGk=;
	b=LOjnBdjsomAbpS2lgRTz5amwXMRCXknVmlaxX6vOWUDNoLI9YV3zQmJXsZS2g0fYZpt+
	 IzlWEqHK44PK/sBI/WPtEmXQa1GLusgki+ft124m08j81Wg+9E2zJJgv5zrQdGnA1+L9z
	 slG20cqFJ++L+GSyyQFWgPWwtfk1KOTgwZe7qJ7Zlzb++Y6TsPUjB1NlmqC7Ub2QkEvlz
	 BxeL4M+hrpDcR9adCZowceu9P8ju3ypJ4Efm6cG5bW9O14/sBAgru29H/w7bEoHdmsWnT
	 A19FdGh48t9u6B4xQRnKcuGswUW8XQk44VDUyTnodq4calDjyhQPrVgiRnBJQQwZyaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKstkRDW;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD1606A31C
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 23:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDD1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKstkRDW
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3704d30b84fso382823eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2026 15:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794181431; x=1794786231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y+9XR3IW13wg6bSjQF5sU+E0GKGlbXe/DPiWIBwUTGk=;
        b=LKstkRDWolgKVrIrtxX8SiwMoFUiDDz8BzDZ+iQRfG10jvdH0ALZlY09z2Qup7bSxI
         iKyzChQzhsE5sG6EPtz8jTYdQZMEZjwfXOARpc0DfQ+0Wvz818S/6x2NcNZ8d/qfS6g/
         jbq+Xu4wN2WkAiqSRUQmT2jv8dkM1K6eJeqyCCFr5NKFM04902UxLrVnnfjmpIoQsuEu
         bNHQU69capRHMEj4B3ptfTffhGQB/Y705Mu+FucYartYjxZvgx+lErtVeZw8FsCsEsYK
         gtr/Os0udADidvsQc4/uA1dEP49odpCkyD0kCT7TPQJSS574IbcBBmh3OtOW/X/g8e8H
         Xc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794181431; x=1794786231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y+9XR3IW13wg6bSjQF5sU+E0GKGlbXe/DPiWIBwUTGk=;
        b=Vn9MrHVqe20U3eeJo1pmRjFKJEXPsL3/yTxmZpczhi9SFnjz2IoQNM8UENKQ7OzOXU
         XJ64BmmsdXC8cNtJWBIoyxoAtKwswd6VEnjahnc7sJyYqdHiWQmUtHYBeV5UgGbFYRlT
         Mr6jO9tY8by1jy5HHEMlwe4hDf4EmandasmUrMd2eSfTL507Xc+Rw0wITO9wQdJD1i+q
         Iu3bGMPIK2tnu+u68Rd+7Rl32c6xy+EcdPR1XtUrV+/RucvgnaH2h8S6l4+MeqCDtSTC
         nqK+dW6Xb7Ql2llh9WMqYvc3cB4VTcjaXo+FGkCgRhDO9Y8ieyuKS8PY3Is9vN1QIIPd
         9EOQ==
X-Gm-Message-State: APuU4Z/w8mOlmfckB6DRnoipVnZxQBafbT7GSZN80KcVTFhbSY/W3U2S
	PWt3EdKeee2oiMY7yHxHcBjJ2GqlUmuqB13xii5XOyqRA6wBFxB2oVILtIoVfg==
X-Gm-Gg: AYBFou3GmquXblskjyTcPRasUFVZfV8UMx2KeOAcOEBuIQVpib0H1ZTmAppr9X8koaG
	8rC295atvLDTyPU//YWaOe/ncXBJ6cPHK4KkpJkgK42BKQk4jnN3+F8Ol7W1peRiCUymJy8d0Gy
	rFrUAAd0WvDugMzu+zMYkYkeoHcC+6QflhOYbubZKvqYfm2C6Zcgn+Omy7HyeqrPOkmQbVgUEtU
	PIsUWmLlGPNZmvOQg526/gfDDVfYiA+P4aYx57RBT6BWJIEC/IelC8Wz7JO9JtVKad51F5nFK29
	ul5fHfvKfpllDV2sVMmwnF1irA3gEyqi7PeY32pB6ZC6sn1AOQjxnP80kCpHCaIoR0Qs7OdZZal
	uXQ4yPyshn8KlmdGdHSuPBhnjAgGbd6v+xChS+d9tQ1scxtx695DX1V39GUB3XTBeiV0umED3M9
	FRd4Pdv0FuaiACHwu54w6huF7f/5AfrIOOXciG+H4HvtJ86Jh2Bvx2AmX3F85QDHaTvNQl+U39W
	vq5P5Gg6Dst2N0TGJnIjoexTYpdvegINaKDtKNbFDVOYOmm7Dtv13lgQEOsiIZX
X-Received: by 2002:a05:7022:7f0d:b0:18a:8164:ce4 with SMTP id a92af1059eb24-1b39fdada62mr3695383c88.0.1794181431116;
        Sun, 08 Nov 2026 15:43:51 -0800 (PST)
Received: from [172.17.0.2] ([172.208.153.16])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375728f8bsm7552549c88.15.2026.11.08.15.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:43:50 -0800 (PST)
Message-ID: <6af10936.8af4976c.3b0cdb.a757@mx.google.com>
Date: Sun, 08 Nov 2026 15:43:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5965262201538526675=="
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
To: linux-bluetooth@vger.kernel.org, NoahWeinberger2003@proton.me
Subject: RE: Bluetooth: btusb_qcom: check reassembly bounds and pull results
In-Reply-To: <y1Xe58FtZGhXfycy9vp3QaGjUElg-vc5EA5FocwznmudOVTgFiYfbqilI4Lj0CRpayllrrY66pkMv9TlGOeq83VQIdL6PEjDbDIEwi28Yk8=@proton.me>
References: <y1Xe58FtZGhXfycy9vp3QaGjUElg-vc5EA5FocwznmudOVTgFiYfbqilI4Lj0CRpayllrrY66pkMv9TlGOeq83VQIdL6PEjDbDIEwi28Yk8=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5965262201538526675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1205531/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.30 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.76 seconds
CheckAllWarning               PASS      34.87 seconds
CheckSparse                   PASS      37.50 seconds
BuildKernel32                 PASS      30.68 seconds
CheckKernelLLVM               PASS      32.45 seconds
TestRunnerSetup               PASS      745.24 seconds
IncrementalBuild              PASS      28.81 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb_qcom: check reassembly bounds and pull results
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#104: 
Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), drivers/bluetooth/btusb_qcom.c:4387-4462 (recv_intr), 2624-2628 (recv_vendor_pkt), 4258-4262 (send_frame).

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#114: 
Reported-by: Noah Weinberger <noahweinberger2003@proton.me>


ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 2 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14962631.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb_qcom: check reassembly bounds and pull results

1: CC1 Body does not contain a 'Signed-off-by' line
25: B1 Line exceeds max length (205>80): "Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), drivers/bluetooth/btusb_qcom.c:4387-4462 (recv_intr), 2624-2628 (recv_vendor_pkt), 4258-4262 (send_frame)."
29: B1 Line exceeds max length (124>80): "mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); every code path cited below was re-verified by the"


https://github.com/bluez/bluetooth-next/pull/1091

---
Regards,
Linux Bluetooth


--===============5965262201538526675==--
