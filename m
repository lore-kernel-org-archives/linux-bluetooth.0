Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAB13777E
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097041; cv=none; b=DjJc+rRCxpCQcyiivmdlUNuRJipxKxLPqz8k3JtM7GOLVTaz4X4rHgjtnMvAVOUvOwN7j+hC94oYjduaVxRu759QOOGfaaUADtSEjO2D0OQbGU+tcSqpdpjasPxthlVcoVK9uhknoQikYCYnQHeNr8bYpuytHkpLZxxkykX5aF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097041; c=relaxed/simple;
	bh=Yp9h0VJJnxMqAuakyebdPJxwxT0kZs0z29wRoVzIq4s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W0Mp4FhXQ/1dpl/Zgz75/sTcErnDtRcaSWNSrGAyM6BaFpsIVHbvcMDvkvbGbiN2xueWbnUPUKuFPDK8lbCjUMdS8AzbVJnuiH/1guDc+GPPAGFH22mZ3SSLZ/svocFTWl7isEA4hVwF42rSzjAQjaVDnLo2ttKTBRpRATcQOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUYyiz5k; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUYyiz5k"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0a81d286so1635241cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 23:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097039; x=1784701839; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=haacLHk5HvNJUNyviarR0rh7HTVC67BzzfbLIyyt/6M=;
        b=OUYyiz5kbhmfmsEx58arSBtNDjion0FLxuGHC9JFUVa92RvkB5SmlBMJEeGx0Tff7n
         0U/HnCu652ikh6E8LlbYfsZyYgdFN7PucMyLT4pJK/vhV3wLZWqr08nQO0hnl96ijmu9
         16DQgYjaww+P23sE2jgpnhuC0tX6sspZLq4EBUnj6uNtBWILMYc+Nmdxq9EBmaVNM+1w
         /ZSJ6Ga2goG77ZhRDqeCjyn2ypRgfZYMBscG9cRZntsJIC7dbzRft2ue7I9F3euKza1g
         f4QiAnq1B5mM3ICEITH8aVtErNmWqByISNlKv+YGQeJxBSHw9q1JvfQwy1arzoJ0IFNN
         vJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097039; x=1784701839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=haacLHk5HvNJUNyviarR0rh7HTVC67BzzfbLIyyt/6M=;
        b=hxrfWf76muGmQF3A+2rZblS0bJMZgW4IAsJQBk3iRwYozQIE700A1Tk74ei8bEYzT9
         9qD5GJc0LIoYCP0a4u/Nc9/2JFMmrHVndgQYwOI74KUUIrV7ZfRHHV+IqBnPh5kNb3uX
         AWKVlY1SNkW5QPNtYD51rSYUMGR5HEyO5gS/iMQK72o1T0kBsV9SR7OgAckLGSUhYY2S
         WDtd6XyKT37OuxIAnplwVVkfU5m88slLepKOR2QYhHK2HilUik4uy4qb1XfDFDwvHPXZ
         P4lhSy0grzTEUHXrU/QPeeSbEI6WJee1s9RiLZ5hYJvOPbiodThOvMl40AbdAq/bs0Ml
         9F6A==
X-Gm-Message-State: AOJu0YwtT6zAr89qhwwOv+8KDNN0MhUDY1ZZAvwE0xqbE9tg4r3KzsDx
	/G8FAUPhDgCPe7yYHnnxDey0mzlDuuPIKpJaXxURO5l5bEqMyY/FgIw5MoOfwQ==
X-Gm-Gg: AfdE7cnUsvLuKgN4/hWDY3S5noifvBfcWWWEp1rNMMm6etWISZIyCyoBNhjKr4KnsXn
	NWCcduvU5muPEs0gjl0RXPqNhyxn8zSzTsiU+5znTFQiSdx/rNp1N2Qq0tUBcb5/K/QtN1Z/Id6
	zJl+FUu81NNjxeq0292ScwiyFZtGaycKhdETz/GbY2AKorWKkSVHVUOfQkZ695JoPsJVdyppLWF
	Mv7iKlREjeuvZe2mMPfXUC8DSpmEnB0EWMNHXrZu+5jh6pOJJAjZZTgD+YbH5EFpVAYjpjn5qfo
	G2syG65DCl8dJutsji49IeT9ZduqMl+5rPlIU4R3PWmaV2xN8ggjA3OjlZK7WiBi3FlRLxtQIQi
	Qx8xd5LDwKttn3JXcqM5kZlg13RyKc4mVsEGUHIW7RVDVFPp1O1YxTzGNgeoqo8CLr9n8SmSBst
	TLuAU7A5A52RhfxkZcZPs=
X-Received: by 2002:a05:622a:4d48:b0:51c:7aa7:e0e8 with SMTP id d75a77b69052e-51cbf96b37fmr155409221cf.37.1784097038663;
        Tue, 14 Jul 2026 23:30:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.158.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf611e5sm126332061cf.23.2026.07.14.23.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:30:38 -0700 (PDT)
Message-ID: <6a57290e.04ac118e.2003eb.b663@mx.google.com>
Date: Tue, 14 Jul 2026 23:30:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3591170416754687056=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: btusb: Build the driver from multiple source files
In-Reply-To: <20260714-btusb_main-v2-1-fd32cf15c26e@oss.qualcomm.com>
References: <20260714-btusb_main-v2-1-fd32cf15c26e@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3591170416754687056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1127870

---Test result---

Test Summary:
CheckPatch                    FAIL      0.90 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.33 seconds
CheckAllWarning               PASS      29.69 seconds
CheckSparse                   PASS      33.10 seconds
BuildKernel32                 PASS      26.41 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      498.56 seconds
IncrementalBuild              PASS      25.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btusb: Build the driver from multiple source files
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#172: 
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0

total: 0 errors, 1 warnings, 6 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14688027.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/440

---
Regards,
Linux Bluetooth


--===============3591170416754687056==--
