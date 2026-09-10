Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938A38E11A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065764; cv=none; b=tZu1ExFs45i1s/Tckd3e5PqorjmDOHerbq5u2ZpTeOqwWc1jzCfs2qA38tIgsQqKpYWKen4y5f4kBI1iqoCFcPaEtDHIK3UD3xnTHXlZYuWeBG7SOmlkSADqx92TGJGYSf00NSKlQgMLEwcgISDvAgpn/DDtTFAjX8mRv/85hxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065764; c=relaxed/simple;
	bh=UzXmgI+gZZmVe+CfPr9F4YoTwyALdwVWhZrVmcFXaBY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jnZB1XN4OdE5uXzfLUnrk+2gJVoAytAsIxT1tyTRFsdes/MLok0+6FzYBoviFLfq0HCplEdRJ5y4D8p30lLqKRGBrtgdwif+McakyR/4REIjR6lhypjpo6QBy74CSXY+MY948dRfJonTIYr1bSUa7jnnZxv9rtykJqv30HPFhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXOgrNNF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXOgrNNF"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so137850a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065761; x=1789670561; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4b0qCOl1oJUZDjlH3eBgaQ7fe4ODotDZxKJxAElCuew=;
        b=gXOgrNNFPbsdHisJNbw9/IkVU1rtSt9u3rIaQLP+P1C/4L0Q0n4CvwnxGUSGfZ7xx5
         BWrgc9UBQvpIzMMsIuCUKsbat3jqCQZzyV74JJP6Xy/dB9EITAAhttiEYC5ilczMA86E
         OdI2on3hRHmyrCYPDlr6eG57ZfmMGIm1Ha3J9l/5r72pk/Ur5QHiLfru446oT9Otsu9h
         193sCPNS+xwkcUQukh3rnmEH2eQSoGKWQCUAyghh0d2A/vxkRK8Yac+vQx/c9LSCOWi3
         tnxicxTphuQeMxx33ps17TMdjR/NJr8PAQpndr0fshQjRHZweYnEQuR0yb0hgG+V6uyG
         Ng9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065761; x=1789670561;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4b0qCOl1oJUZDjlH3eBgaQ7fe4ODotDZxKJxAElCuew=;
        b=ED/rcOsFsVMC49xMUd1YSNT6BID/ZLP19nucGaptT5PpxF1h601b6JF337hBloSITS
         rprAGKVtII/dcav2PMF6cZdiQIcd0drFx9cPRrxDnpP8SxNPL4/UZbAQGaOdXmExB1gj
         q2/if8pDcTKssuP6/EQP16wg7YRMAQI2L2gEknTAxS/5F0duTBW6Qw2sqFzTOUDi9aip
         0+t4uzSdnsu13N3mlAxLtWkpXQZBdHjdMKquqT+t9E1cGsdCst5gBO0Ywcwel10rsPJi
         Yj4KofKiMC/I68BGyQFHV99ZG138gB9OXpy/WjzLynB4F11y4WAUa8mekC0dyqBuh+kV
         qlsA==
X-Gm-Message-State: AFuF++l+3Ud3E6hwuuDLfkJFr51GLmt4NzckarZ8CK7FNkiVajZl/l6l
	/HX79WmqqzpVa5nBaixH/lqce2CnZ+W1O42ey9pCNC/QXPhZ7nQFinAFkjVFOA==
X-Gm-Gg: AYBFou12O1HPg8DjRN3jYeavy1oydZO2RBW8KFoAKWCVcyz7alpc00CdC1EuR17To8N
	hpMj+wFY93zdAOsRHhTXenJkSBw70PRFgGuRgtRAa/N7sNGkbFX7U1E/WHAeYHebNFttW2XZFHC
	DASE7Ybfx0jorx3JtYUbdFj1lSZHaE/fk/q8Gd1Zf6lBr+K8+wMFg+zh/y7zQmjlfiU89GEW+5h
	KS4cMfLAW38KYfJVVeT6dezYeTzQk2ZM84ZjD/BYqHbReeeLk+VbfIFzRO7J6812qRpIoCnghaB
	YODQuDs17jU/XMWqmhLrmsxcP5PomtnFbyZsuhkabHR7PRMYXz3cerK8jDOdxlTIGe6Fqp8VsCk
	xdufByPGj7c18Bqrtx6GBSin/jPMXM1vYnJYerVm3qOaK/VK19Y9duE7bsT69ZIzQq9D+6y/8xf
	5bGSupZAmQXs1YidOKmdJ8cc7G47rc+RZ5bF4rf9BJaceGBKNebSqX58a3ex0lDmCUoyL9RLgfs
	sKnmiQ=
X-Received: by 2002:a05:6a20:be8f:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3daed424d01mr424188637.26.1789065761447;
        Thu, 10 Sep 2026 11:42:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a59b18sm535557c88.2.2026.09.10.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:42:40 -0700 (PDT)
Message-ID: <6aa2fa20.8e75e0cb.126d4f.8780@mx.google.com>
Date: Thu, 10 Sep 2026 11:42:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3629121842131535860=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lijun01@kylinos.cn
Subject: RE: [v5] Bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
In-Reply-To: <20260820055003.1204188-1-lijun01@kylinos.cn>
References: <20260820055003.1204188-1-lijun01@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3629121842131535860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1148824/

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.16 seconds
CheckAllWarning               PASS      33.28 seconds
CheckSparse                   PASS      36.30 seconds
BuildKernel32                 PASS      29.53 seconds
CheckKernelLLVM               PASS      32.84 seconds
TestRunnerSetup               PASS      806.92 seconds
IncrementalBuild              PASS      27.05 seconds



https://github.com/bluez/bluetooth-next/pull/737

---
Regards,
Linux Bluetooth


--===============3629121842131535860==--
