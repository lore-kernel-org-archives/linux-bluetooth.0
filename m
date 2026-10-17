Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD83D6CD9
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792265415; cv=none; b=BCDYFw/fx4otzFdI8hqYgG8gZzGM3VnWX2WEWDa0YVaeXeDoA9jV9Mn9Lkthry1D8HOkN1ovYUNlWczpsaECz9oZv7eMmiLenBLcArzNBaZH7KU2DyaXPqGkN9EfP6s/Cp/+/gP5jURdlhp7R8bM/EvjbiL4obqKTdLsEKlKDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792265415; c=relaxed/simple;
	bh=h3b3KtyBxL7zcQtgB51rhIndSTAxkcP3HfUkV21+17w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ytqu4Nug7zWSTuX2X0Puwvu/EaWP5vPb8WnS02PgS9pbhqnqy+muoDkBi5fNngBnNzbD3bQLY33cagV8yMOmKOs2WJVP662MZJHjiUZ6kOqJXmH92FneJCuBEUbvzawl4lA03f8z7hVzwBMaX1Yph870W260qVJT5qzDIAhKRes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROooRRU4; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROooRRU4"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-17bc533fda3so1081197c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792265410; x=1792870210; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NfS7cFgTRj+avKvdLMFRTiza9vMSd1QNu50nvX2O5yA=;
        b=ROooRRU4tf4wLOFPnP3Hqhr4eqZ+QuTAUMgEFNVaY58xa/ieZJ+S7YqNK4RY6qF8rO
         M0F2U1mZh+GHWfUbKKA8Z0gd/hzPQJNx7syw1ElagfCIPnWWMMq9XxTB/5kU+oAjw2pE
         myjTrXx0hj5RfODR5fkrtosNQuVB/cjowkTBq1BlxK9JhkSXHMfykAFMh8IjvD7F40/m
         mCwDrL3BifqAV6cV3FO74RIkf+h3o9NgRoaOHFfUwVhysNE6Ya8B74AWUY7ttP1x1W7h
         mISER1bK/TEGEWOUJygz5WWTwOFn5ah2Fy5cruNcGHpQiuTtfTGyE3NPDZirFUCY5sTL
         9eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792265410; x=1792870210;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NfS7cFgTRj+avKvdLMFRTiza9vMSd1QNu50nvX2O5yA=;
        b=ZYVznL3S07uhUV9iAcfiBcoyWfTNbKNW2W9nAiffCsemp0vJx3fryQoEqUTcAHuiZF
         Wz0zyKEWS911TAzKTMTvMVeoXzcuc1oAKCj+d+Z/q9yQLcCvWXMldIxW6Hyg5TfjAzL7
         2z2rkU32TeXmYJxiMDe3p+Lsq5nF32M7yJA1ovip8G99v2ShJ99d4o7dbpj0rRkuFQhw
         rK7tOesGPOaXkcHVJcQUd82+dOVMlgiSh6VsgJS2FlmbMzZ9I7TtbCVpLz893K6ssWVC
         VLf3zp8ogPvslK6GqPYHueCz/kp+HX1MJJeO3JXK0NbGDQmJucq3eQfAJ3jvujtPKKEz
         mM8g==
X-Gm-Message-State: AFq9FYJMnXcIOqeg/emHRpkIGauOvdskhHnV+Emtlz4FfZES8yg/ey1i
	kCM3zQS5MNqkazlYYAkpWiLiOR8BbeSb6bNrQxbBfjtv8O4NBE7YGMwRLPck8g==
X-Gm-Gg: AYBFou3u86XAZ0Q2cup4v7qbLnX/z/wmEBoa9uaTJ5ZZBa9MH6lb6zM7FMGNfIHNIUQ
	tdg371FsP+t+Q3Y7zMf9tg2lWM3MkFlvl0vOWJyrm3NcfYpLgPU4J4Q9jLicVzFG6kEnL6l7c3z
	Zpgy7MRQT+PwwoEjvbP/Ar5w74udXlKo36MLZ4/F9Pvh/qOkKV6CEyGBCK6D3KbmhbV0cUo1u9/
	WDCMbelN3x2zgGxOqTme45osT0dOZv9BGa7pdMsUKaJYjna7oVcrOCP5mycSYUPvmy49SJS3uBK
	AcqNbKp2ObROmfmcp4BKldRHqa+P7YX/GQ0wrkOS/IhY4lpA2YvOdi2EBzL9umYNe0gN80C1B1r
	au+k4HnYrWPI68WlpB7aORgiICD66wk93mnpvbWLgwhKE2oXmbEIwz696kZgeO2bGK4vfI4sck2
	jsAal34uwXy5yPMbvUEMYZOzkIxSvk2AdoZSGrl1qEt7ln3wE7NHRstiU8sv/4nvWg/CCv7kjEs
	p5DAcOP8kQGBTl/gQ==
X-Received: by 2002:a05:701a:c90a:b0:167:4198:2cb3 with SMTP id a92af1059eb24-18512c384cemr4913617c88.18.1792265409565;
        Sat, 17 Oct 2026 12:30:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.47.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm20962677c88.16.2026.10.17.12.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:30:09 -0700 (PDT)
Message-ID: <6ad3ccc1.a0fc269c.3330b1.02fe@mx.google.com>
Date: Sat, 17 Oct 2026 12:30:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4401349681406784652=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nbryskin@gmail.com
Subject: RE: Bluetooth: hci_qca: Reprobe QCA6390 after hibernation
In-Reply-To: <20261017174310.22484-1-nbryskin@gmail.com>
References: <20261017174310.22484-1-nbryskin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4401349681406784652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1188025/

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      6.18 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      30.00 seconds
CheckAllWarning               PASS      34.61 seconds
CheckSparse                   PASS      37.13 seconds
BuildKernel32                 PASS      30.04 seconds
CheckKernelLLVM               PASS      34.22 seconds
TestRunnerSetup               PASS      719.60 seconds
IncrementalBuild              PASS      27.51 seconds



https://github.com/bluez/bluetooth-next/pull/961

---
Regards,
Linux Bluetooth


--===============4401349681406784652==--
