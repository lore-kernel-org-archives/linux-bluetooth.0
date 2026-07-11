Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7C376A13
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783758887; cv=none; b=hK4MWYovj9FGawZuMM83EdoJ7Jbvy6qPqDT0+EhpC+EDOM47e6kCz7mMK77aptGMXI9iis6aIXyYBSHqc4O8ktN9/MSr0/r0sD8t+/h9kWJqvrPRTzWH10PiQELm1EUTGokvCipfiEEofdVErsNIwA19B07k0HIEoiSXuUFl2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783758887; c=relaxed/simple;
	bh=bdHsRsbJYiLc8W4eGCgDHyZOLl/lj6MMMLUUpq4eo/Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yrx+3OOjIOXuBhtItaQvarp0xu0XTlV6birwlJGCzZQ7Jz5UEby/L1zr5HWFGOZb/6wnctkZC9e16DUFWvZn4KO3rZod90Q5fRW1wxfVYS7FTqts+l2PwInixssA9SkDajBo76aTmzebc6aNAaFxBOWuqDp2oz7bdD8VJyPV6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBjZ89L5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBjZ89L5"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8eff5ce3b95so13812776d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783758883; x=1784363683; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JXs8FFM1OWOLLCCtUt0T0zM4rlvqn14Arm9ygQDGnNM=;
        b=mBjZ89L5IEip5szseKxnR8qUV9R1WMqx+HwKrtLvEBaIfY4PkuSeuSlmcgQbDjfNqI
         eFjYkToat439Bo5HuVRLoM+Vlw5SpxqCTeELkrSDPulcgfCpVj2nWdRCjq3aEJclzIWZ
         vmsP3uWkNPOBryOSEZaekZZAjy6kwwvP9QeAF0dLsAnmVFkH4HYMEV+RX/11MKfyxpig
         QiHsBDFqDbo47lICu9EByEx7jrI9gC8db59RQB63HaPzXUj4RtG2yTHlvzEe+RuyczIp
         MbjLJwrRl5//7QYxVwP02FaLuCSp297HLiEmlJsrfweemsZ9D3Y4niawp3g/Ip5uoScx
         T8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783758883; x=1784363683;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JXs8FFM1OWOLLCCtUt0T0zM4rlvqn14Arm9ygQDGnNM=;
        b=q/ESYGyp6Jg8XHNrprQQlNtulAM3nPCK0G9GDTv/NKEAzb537bveefvpJKYiBwfiTt
         JLN+V/qtpwlkcgXZtEH5VK+0aRfgdDTeNNC1iwBKdA42TvChtVQa0w2Fk+dy92GWtRxR
         yY+msCJEF7fFb10ZweevFUG3/5PKYWtFcRIZ0nreNbS7eKGemN8QoalTAXpPa74YoGEg
         KzQBEZxIT8JI4y6Ca4FxWdT0mYYBuJmlJYvl8xBOwIMkNGVqjrC5QnxxIsAvXXi6oOgm
         Zr4GyytVVbriegDBqTudKCYw+PpQbkgfduyHLeONPesLkn14UePiMfCT+bLo+YyQ3wHc
         kXIw==
X-Gm-Message-State: AOJu0Yy/Rm3R+ohJUxSBjySZhtlBM0JtKLJFuzOX7gWdxM0SVQJGIoAF
	d4jzKYZfVh6IG/5BxwBtcyDqktMgLB6YGloATxt2n18n2Qf/v5cPIScdVxkiKA==
X-Gm-Gg: AfdE7cnl4JlWn/F33tgRYdrOUNJB3BtrwjeeU99VIilPFpjmHfBN5A8dfeN/1wcXbbg
	XwmtuW05HfRDoJaSRIAeIt31oryTvj5bhE6vMd2etWqe4dVVOr8ENNJ5KzZcQpzXz5ClPZoajuo
	cELJ0gP0+6iE0lqPy10MlW6JdlVfZIkTcPNhzuqsturFPRVmMxVWynsUhklUmmW69SlL2/CVcLN
	RqDpPLksVA0XMp6Fd81pVV06iSRx6hRCpuML7MX09bTF6SFrrgmig6ETXczBfEr/hPaIqTJjczR
	Qx2UKNLFQZKyZmvYESkITWZ4bNds6m8d7zhvhyuQlh17che+bIHgjxLnNZBvUd6NirnMEw9ns9W
	lo/QVETznCgNnY1VCOOtXXQr3LhEIz2n/KD3neTJTG4ucatMVbIsuIw84+YHSKUIiHZ2DqiBxpk
	rLLIrCchnhmGnYbYXAkDAa2A==
X-Received: by 2002:a05:6214:2422:b0:8f5:c166:b418 with SMTP id 6a1803df08f44-90400b8a734mr28091516d6.11.1783758883553;
        Sat, 11 Jul 2026 01:34:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.207.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50df5e2sm62361206d6.4.2026.07.11.01.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 01:34:43 -0700 (PDT)
Message-ID: <6a520023.3c73b6eb.25c305.eca8@mx.google.com>
Date: Sat, 11 Jul 2026 01:34:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3616820644158848132=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ferose2@gmail.com
Subject: RE: [BlueZ] shared/bap: Fix rejecting re-attach of the same fd
In-Reply-To: <20260711070230.26553-1-ferose2@gmail.com>
References: <20260711070230.26553-1-ferose2@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3616820644158848132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125740

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      542.83 seconds
MakeCheck                     PASS      12.74 seconds
MakeDistcheck                 PASS      157.54 seconds
CheckValgrind                 PASS      204.16 seconds
CheckSmatch                   WARNING   306.24 seconds
bluezmakeextell               PASS      100.48 seconds
IncrementalBuild              PASS      538.46 seconds
ScanBuild                     PASS      964.22 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2298

---
Regards,
Linux Bluetooth


--===============3616820644158848132==--
