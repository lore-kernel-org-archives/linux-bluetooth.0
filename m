Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01530F526
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195852; cv=none; b=Kayab2U0McdXCARLSDDadFiHXyeyMCONQJXGWctMyJcwiNR05JW3TX1rzPhEprjJTD09uLMEr1bsM4qpGBMfWwpIhy+AL43d7h/sh0K6ctDErvynHu7x7CX2wFQG1LIChCHG838tmeLzCeWCIPI9Aqo/LG1XddYMCKpynMeSGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195852; c=relaxed/simple;
	bh=TuAwKEBiHvfrO1EGxsuFcYoyf6riO6e6miT0sM5yMLo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cb77ANlqlfye2xusktDvmWAWGrbC5XYDsyR04+Gny/gE8xCohFKO6dnMViQX2CSBNHhPVMQ6/pV+JMd9Gb++uR4mlzIdldlNcCKV96Amdt0wibWyeFnZ9/gpMQf541x5RreiosQf52OdNoTBK8KJ4voDqD3tsV0P9D9dWYDLje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKbDR3rJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKbDR3rJ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-519ff1c8b8bso33643461cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782195841; x=1782800641; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+3PCv/LJgSr0uNo4tjxzo8VTlcCDGSEuqTljsohPlEo=;
        b=TKbDR3rJ/qk+qTYfQwkc9sg48Y+OIIJUW2dofiapDHHvc7vjwhGBNViW0CNr5oSPf6
         RDQ15679vjL1scSSZ4bjbiaZGcsmocaJQSTGtgu9ipUPwzKGYZ+YA1lf8+w0bD2und0u
         wZl3crHeBHJ/sOKw5Xa3G+vAyDtiLnuGPTlhZ2YjZvOLK06hPPN8CC4waPcsJSlvQHzo
         Ths25vSaRK6w+cLarx9QrPVnzpHVTOqQnpTjYZDTF4MsGga1ifwd7RuwNvCJvlAUxc5R
         56a5bpC/EcoFQQwegaYUDrXHpuuYULbkqMAvOHz8tMEQUDprau8zAs7wQdNmsoy9OTkE
         0S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195841; x=1782800641;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3PCv/LJgSr0uNo4tjxzo8VTlcCDGSEuqTljsohPlEo=;
        b=UnE3/R1fAvwfs7YItK5Jw298gWjQZZKYl1+537nBMnSsZ3IVxKbt/mo+YfUijN7M2+
         ffSykPcXvvnlJPIrKE0VcfFUN7XcZdLRLWEHtd9NPLI7grDWHCkgQ5NTuflJhpWHK7b1
         0tRpaEvk/KkjZG3dCiPiTWAait1D8CAMcDX/VWKLxvQvraX+d7shyNjp53aKRaBL6gqk
         ksCI7mJRyPxB3axYOiTBCEvsGCwBUaawzCs97NlHpxOTmYEKeAl3rKLNH/za4VjtgK6S
         TwqJ4+x2q9+cHNpqSL2CWmC7OA/QpJ1kXTZV7tuMbanDqSxkjGNm3Lrq12VFfI69AHby
         sn8A==
X-Gm-Message-State: AOJu0YyJ3np7u9tNhoJ/JBbDyZkBEyhY2GUekxXCWInlIYO91vzBqyM5
	6nipVNxvsNqYA21Y2ToMRfi2LCCKTO2amrCRINHmUD7GOnSnXHreKuTIlWh9Xg==
X-Gm-Gg: AfdE7ckGj5OEnI/F+l6TZhb/qnvwUdrnsXutWHgsBP5dcLysTONusEI5UpYLl+sYjKs
	zBGodbJNuJIjPw7FjSCsbrxBrT6hYcosc1jo8hU6/F8ax60OB/7w+p5DcIQqDfPdaloMnx875yi
	yq8VhK55DPcO2ia0xnKdbKmLMusTv0W9jGMGaoFMNZ5Emesoe+ezMYobHwFkqKpZGitpUswafQd
	PTvg++qUJ4chlycezsKe5Z8XNDV7VrkvRZ00GmJ84+0xydCV7u00X3oWyaRiDrhUthh1rLzlAhx
	ZSU3FvspO7DCTzduhJC28Kl0Bea2hh/2H+slVI9vF+hFDsdZeXei9gmsoEvzRp4vH2tXod/2kCf
	oZps2pO7KEQzdkT5xv/I+qu6Jvw1i/MrsWaafAMoZIVD02mesfZjw1l2ROjmp/C4vAhDjr9fS/O
	3ezFPhIH4NlP/5QmNjmlo=
X-Received: by 2002:ac8:578d:0:b0:517:6a26:43b with SMTP id d75a77b69052e-51a55b1e105mr17142101cf.44.1782195840479;
        Mon, 22 Jun 2026 23:24:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.13.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fa56463dsm201872385a.0.2026.06.22.23.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:23:59 -0700 (PDT)
Message-ID: <6a3a267f.2224c765.33ebb9.faed@mx.google.com>
Date: Mon, 22 Jun 2026 23:23:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3600206297881475411=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260623034121.691031-2-chris.lu@mediatek.com>
References: <20260623034121.691031-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3600206297881475411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115050

---Test result---

Test Summary:
CheckPatch                    PASS      3.11 seconds
VerifyFixes                   PASS      0.26 seconds
VerifySignedoff               PASS      0.24 seconds
GitLint                       FAIL      1.33 seconds
SubjectPrefix                 PASS      0.44 seconds
BuildKernel                   PASS      25.14 seconds
CheckAllWarning               PASS      27.49 seconds
CheckSparse                   PASS      26.91 seconds
BuildKernel32                 PASS      24.72 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      530.49 seconds
IncrementalBuild              PASS      27.44 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,2/2] Bluetooth: btmtk: Add MT7928 support

24: B1 Line exceeds max length (92>80): "[  475.742336] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00"
29: B1 Line exceeds max length (91>80): "[  475.766697] Bluetooth: hci1: CBMCU Version: 0x00000000, Build Time: 20260601T161751+0800"
31: B1 Line exceeds max length (85>80): "[  476.190083] Bluetooth: hci1: HW/SW Version: 0x00000000, Build Time: 20260527000816"
33: B1 Line exceeds max length (115>80): "[  479.073489] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/338

---
Regards,
Linux Bluetooth


--===============3600206297881475411==--
