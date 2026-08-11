Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE4431A44
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443304; cv=none; b=XVkhAUM3r06vS+HvCwjPUUos+uwv50DtbCBkLKrIthZ8ZJSori1orGNQKZc7Eqjgakbyfd154KPZnTMdMTa6GS35rTIIOAMsH0xlPWXzxyPhMcfxjR2A7F58BzvWEfpdBJUbVCeVRLrpy9q+bpdwFhYLJRb+9xhBii5ygsFCs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443304; c=relaxed/simple;
	bh=oiGWm7jVaegqirUmyMPLnTqfzP7Pf3PMTMhxPRBjpZ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cA6RTnljbjgo6jfQDvXCgY9soa6MNbg74rkQC6EIRJtiAD+XadHqCvvU1hd7aH1BsGAONi6KZJtVdVtH6voD7VpYgkn39xZRsuqv7AzKeorsrf//gr8lMeL+cNF873+/alavtZRgGLXyDUgwAFVOgdNdQrMMJG4OxOgJdL8m420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBOfNDjW; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBOfNDjW"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-529a1ee0e62so19520191cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786443299; x=1787048099; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=djNG97DQKkP/Z4IT7DF08qNhRHga1k/AALTH/5yR/hE=;
        b=nBOfNDjWZNZmEf8XV8ArLkzuaI7RC3u21uRDtgdJ0jNHSq6/sxGc8cIDeKGbiav21+
         OOrNA/dNNEnp78GYCcUcLT3VfOuhISwKU+Qc92A5Wmexj9YJKdj4JQtxm9ChlbW+Fhw9
         qX1r8gy3YGmk5bSiKCWsdfDjJ79uWe6j3r+3/G/NgEqKu1pewDvwL4Tc/sYMzsBjawoU
         61kWTE6UzT1zLPK1IJKQ8KP+06i+JIIa4pHJap9CBMLRMQO0hLJYUIZYRaG0fkzDV4EX
         R8X3y/LpCAq5Dr0KF2z6YS8A55SlWI0UfQn3BV5rpi0vjs9ARSXC+W9yj8nqanspptx7
         DBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443299; x=1787048099;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=djNG97DQKkP/Z4IT7DF08qNhRHga1k/AALTH/5yR/hE=;
        b=nSnTWJNly6McIxQkqwT0kw1+Y9kM64FT8tACkJzAyewZ60twqt5hhV/g5PPuIek9Kd
         s6UVIMensa/amL/oG5fBvIH2ccIBXCmcJ92eSRJTn8YE6/Q1W/OSvCoa53nqHk7D9amA
         8HHQi5FK/J59K5NvraJ1Wyh9RwmujEXezAJY9UIdUdZFm6GnZgKlUQUDjfsnLawLEaBY
         bO5QrEPb8WLG4qC2GkcVxlsPhTRuxR6efvHJv1Vrpzt48nqzaNCEL1gyq/SCnBHxNoNe
         90jKheAZ1twZ0BGquzbwsKkYf6TuQqvm+vl/yqU5m39gKTcswCgaribaTEf1uKKNHL09
         aYoA==
X-Gm-Message-State: AOJu0Yy6hiYEGzrVYjQh66hMHgCcrdOuP7EsLsxrNyvOSKl5aCaspJmD
	QfePV/BMnUXtaBwbhsnOPujDVWjP+ebU04iVC3PJgiLLNT/iK9R1ripV0Dw/pw==
X-Gm-Gg: AR+sD11aeaJrCdpPtH1b/2brnM6HYm+eiaPL6DHHMtU3myzqZDodOglSmej1aMXRVcH
	2gMKnzTVbR/tTwtWS//xPxQbFWpAglayGMX+w8RJAVDlhEGaSXjbMPUPd1ebDd6qSZOCASIOG93
	rkS5BAUXfGGtDP9lgPyTt3VfxELe1tnorWyJKkqDRyUYtXNh/cXLJ3Q3Tgu4ZjLWWQ9eJig966e
	1ZUQ2l7eHaO3tOVQzlCHl4ykV7X1GQHdHTgK/BxxgikpHX/d6MmrrK7NlsVjp7Et4EeD8eop/hY
	vLG/dfDe4dIsHfDKyB36Po2KaGBt6/V8M8Q9OborXSuanlkMV5bfaK129WlzVprzVJWpE9y3lqX
	yU/kpZzW4ybfwSCBYY+9WWHLO1EbUZY1VLAcbJZgmERL086C/c5IwrDvDsVsWAlEUTiNraY/Pzm
	0w+/eYppBm8go/gFOJUukSG7MiuRvgm1JY601XjW0o5SrEsB4YPQFAZmQImI0A65/TRBw=
X-Received: by 2002:a05:622a:4818:b0:516:dbf6:f8e7 with SMTP id d75a77b69052e-52d58548586mr16342161cf.17.1786443299102;
        Tue, 11 Aug 2026 03:14:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.102.72])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d57a25c80sm7943281cf.11.2026.08.11.03.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:14:58 -0700 (PDT)
Message-ID: <6a7af622.0498835c.1cc72.5803@mx.google.com>
Date: Tue, 11 Aug 2026 03:14:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2308082999688861170=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaojinming@uniontech.com
Subject: RE: Bluetooth: virtio_bt: Fix use-after-free and memory leak in probe error paths
In-Reply-To: <20260811-virtio-bt-fix-probe-errors-v1-1-2f1acfde8336@uniontech.com>
References: <20260811-virtio-bt-fix-probe-errors-v1-1-2f1acfde8336@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2308082999688861170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1143966

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.52 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.53 seconds
CheckAllWarning               PASS      30.50 seconds
CheckSparse                   PASS      29.37 seconds
BuildKernel32                 PASS      26.72 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      507.74 seconds
IncrementalBuild              PASS      26.06 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/570

---
Regards,
Linux Bluetooth


--===============2308082999688861170==--
