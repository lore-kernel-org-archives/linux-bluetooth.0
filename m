Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760249;
	b=OO5Y0J4MpPvRGTr9Ry6VIj5tnWT/tJXcbs7O/pJP9NVlSy9SPGyVQaHptSBElOcCUYbZ
	 FnMTbu8h9J3iDBoqjbUSUCAI+wVI+04SPgVGDs2iF3TrQ9yO/8nVRkAxKa/ooc8Hr1mBI
	 2msDwQXIC+LbC0+6Dfe2V+ddSga6YPR3I2yhQvK57i/1E1vHgrGhDz0EQS9SOY47eNvUq
	 gFQIu9tXSjnPV75WtUEXWAq+DYEJgIPjob6+mGT3cFRgONrlOnoBk58ghIvIHWhXvRadL
	 //CyVliBUbtyjxpboGEQ+tg3R1pV9OX5qmpm3PJNHs7GOpZ7Vaa0vqMwZ+At3HnGwOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6bbFXkAH3A/zKokgTiK4ysIprDuTo1FRv6Icwz2CHjI=;
	b=EJrt9dcYj0Dmm9DQT3d4C8ITXxYZm4Q72AzbYXBrjTNCCnXAPOH+txVzHO0njwKNCg1B
	 wdClHZU06xJhgBT8V77Li2EsoO0+lo1RY1fbGeYzaYTMsY3saIjRGbW1ew6xfMbxRQ/G6
	 f0QBxmXBlUyEdl8j05eAs6vcf5hUSBVo8g8VT2PbpRv3HgEVHki44lASJp3BCeFlgxDHT
	 phqGcyCD+i14jd+H788B7a4gTxiDtgB4emzUv0UBQviTLszHTAeYlSeiow/0SgbClzLI7
	 bSf65ylYJiERAHOHSlICMzewY1vIaJkFGMQ+4iR6aDnf4k4WMHS1QVDKF3TXliDHbtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NI7wK1rH;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FCA606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 12:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1FCA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NI7wK1rH
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-539a57a0b1fso355212b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792760247; x=1793365047; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6bbFXkAH3A/zKokgTiK4ysIprDuTo1FRv6Icwz2CHjI=;
        b=NI7wK1rHR8TMvEAaAUURRyMU9072LGo8WMg3gebX2FHOukkkZdQ/C63h1cgufuWS26
         tJEX/4MRhjc5h860/JEG423XNbGefWkFM2hfB3IP+z3+0sND7ghOK/qqVKSffRogMSx5
         KgK4hT/dHxcp5aOSFzpqUQVPPsquu8Onrlf/MaZeQlm23hehB27gETaLPHvue9/fSxrA
         iF1/wygEuUUOW63nEEbJXwql0qPX6u08231FO5uvisQzBheVzd+UHenj1yqfF38y+b2b
         U00OEAlsCnToNT5RHWrK7vjPSVGqvTuPOio+CIFKrbTYVbhdoPRFZYT4wnStVjygheef
         4vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760247; x=1793365047;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6bbFXkAH3A/zKokgTiK4ysIprDuTo1FRv6Icwz2CHjI=;
        b=DMR8oorrnjWwJ+MUWH/LX0ZXuFyGGNWtIaIuWuiV0E/Imdyghq6n6iNAsGwRQuGVjb
         C8JiRnSyAAOAclrmuF69CtiTbtlJ0ueXJAifDSdFrC7qkGA8ANRmUv14nGtNV8RahpmL
         DmzRDttOT0RdewQNTErCwvjObx16S68IMWA4rRq38K0THcaXeQaxe599Nly1+rYMpUMF
         748UB1IawkRSXddOJaSnZnXhFXwO4QpQNUw8a8Z0vC/IZGMCuNiO/GJUMfkvRRlwr8ZR
         62LrsP7tUyAWWRKMynOtIkXiIHXJQp9ikLnm8HUxfgef2UDWkeJmxH+ddVjBOKfdC5lQ
         klXg==
X-Gm-Message-State: AFq9FYKC8WTnIwf5YFraxGsEkk6RI1UIrV00a19QW6UbZV5X/4l9V5zS
	BmM/fXqZ0ND3eVTBepU9dulaA0qaYwzTK6XFtTYNbFgaFSR04UjoWrwrWwiJWA==
X-Gm-Gg: AYBFou3R5xiKUNCkKCDobbl2+x9PNYq9Ge391ipjkSXwXcsQ3pMAoa5uQOZmo2W98V5
	U32HNFakKrTa9osix8pRpZkXyhnyGVudfC9ml0wv6kuLhH0hhmrkMU2luMCmq7ZhDCYVYCO5CRe
	+CKr+fUd1HwxmnFla5KPOtk1QuaboMtx9QB9S45ImJ/y2yeIjp59BTbe5nfSVyO/4WZY0GCijwc
	ruI/wIitwqVveLEsWlg5XaFR8669y77k9ckh3HJalVvYw2/4OVRbp00fDeloRhje4KcOqFquPmv
	gDzMyP3MhwniqzwBlx5evfJAhS+zUKaHAfpnX0EVoOf54F5ay+KCPUHnj+Ikiye1XfhHn9HRXID
	XA77YpEU/v9UwGC4uxHfHuaRG+ppRzthZw1vOhxnrzXJONCz/0TkDPegtp2FLrjmWm6pJseinG8
	fV5DJvlVyXvza9faoT8ufDN9KqlayQmTfV/WH9EgEDfYXFGU7/Lk+gXyWZrlAI4ulbH47uiDztc
	Tg475PITKuNngMkpl9eaOCg5soLiHYsKpO3YmfKYvCQ05jypa6ERzW5DKhTQ/YE
X-Received: by 2002:a05:6808:f08:b0:4b1:bc2e:3f60 with SMTP id 5614622812f47-55be80bbd58mr1159085b6e.16.1792760247564;
        Fri, 23 Oct 2026 05:57:27 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.185.18])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55be98201c6sm1401258b6e.9.2026.10.23.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:57:27 -0700 (PDT)
Message-ID: <6adb59b7.08f94d98.1959f1.1072@mx.google.com>
Date: Fri, 23 Oct 2026 05:57:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1606493088675720043=="
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
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v2,1/2] Bluetooth: btintel: Add TOP silent reset hooks
In-Reply-To: <20261023094033.212251-1-chandrashekar.devegowda@intel.com>
References: <20261023094033.212251-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1606493088675720043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192001/

---Test result---

Test Summary:
CheckPatch                    PASS      2.29 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.90 seconds
GitLint                       PASS      0.66 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      28.99 seconds
CheckAllWarning               PASS      33.66 seconds
CheckSparse                   PASS      36.28 seconds
BuildKernel32                 PASS      29.45 seconds
CheckKernelLLVM               PASS      34.28 seconds
TestRunnerSetup               PASS      674.22 seconds
IncrementalBuild              PASS      28.97 seconds



https://github.com/bluez/bluetooth-next/pull/987

---
Regards,
Linux Bluetooth


--===============1606493088675720043==--
