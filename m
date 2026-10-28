Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204716;
	b=qbb1sG22Zsw7/lWDIFk8vHNNgENTKUaIef5CzNK55oFQyhZ4wK1gn/HAZxV1TiDxhBzB
	 FyQWDM5z6VXH2UY0qo5D5W3MmVDrnsReCH7uOFlNvZbT3ghJAKowU+asFbavuJVfOdRGG
	 yXrz8ARf6VYUVoLE2K77QL/wyWTv2v52qp0dG3PwivTVkIxrgtxOSyNz8oAM5PRL0+YOm
	 quGDCusKpjhLODR4f/BO25FH8NpooaZrKWaW1xSWIMQTPVSE6uJfDkWtn3nJTU1Vo5Xsx
	 ak1+yNUEgQWWSJOgKee6tvyEi5LJgT6WADnJZVPM1vRaZpiDWtiGRL1vZ9mc7/Y4wKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=WozTaUVEQcZeXsTDTppSYoT/N7Op4FKKDYGrddkWO1k=;
	b=LG1bojaaRDEWU3uluQkeN2VmaCufotYfCURs4fkr4adcAVAwn4IVcaWcRoAZN8U/cpYN
	 /2D70d1H9p/tpHdC8Rm/tUi0L4vk2vjPOmJrr4XXdUSKaBQnYkZXMCcNtm6UUEVBFTx/o
	 zibJzifnK2QGG5N3Xg5WTJ5hsu9+SXBlYcSdGGoPpbXb3mk0vYPTTY+IvLcaSefYiS3l2
	 HJtX39nLRvAJge4vwIBX5hfme32Pky+psfg+CEbGgMwM/7hC0QCxzs8/3m7bqalEsBG7x
	 1x26I3QnIaH09jpbBL2PnAlMTbwG2UYkwTuL+4+VvY9cuDWTmsHrrnSCe3uiaa1OyQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLT0GnhJ;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EE606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 16:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 549EE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLT0GnhJ
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91c76540d0bso13503426d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793204715; x=1793809515; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WozTaUVEQcZeXsTDTppSYoT/N7Op4FKKDYGrddkWO1k=;
        b=DLT0GnhJyf+SiMcc9W0M9EF23SQHfjwvdQ64z53gFx4KTehA+Er4FwscSyK6NXSfAy
         7tyCbGnlkcvOUYSO+UK+lj9y4iAcSXBxmPMYe+WIxE347JKSkGgmpw1HGZCIS2jjXska
         MotGBSTEmSszcS/hJ8rO7ikUOOKlb0F0JGNlKdwQKh/M7k7NoWs+x4d+19Vs/MFPALAp
         T4p3xYkkwsNEMp0u/5WjAZHkIaJTseibmndgPM8eY94zc86fCICzcp/XXTMinXWkCBBf
         tJxrRr6GBtgn7ElQsN/SXFGa5mXyd2MtgKq6ENo972TBDIMwU3ZmjHFbBnshwv4XQWFF
         oeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204715; x=1793809515;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WozTaUVEQcZeXsTDTppSYoT/N7Op4FKKDYGrddkWO1k=;
        b=jMwH14/25J5XUkOchQR1Krwe3eFlsiyeXUbCB1uyvWhmIYXWUgH4ecBgR8jn9sik2V
         /G9e1FXKl2hnWhbuDc8vx9ea/oUPLBI8JLt0exXpTwQnnKWG4d5ipYWUZg3V1fqAkV/g
         OB5TIi5o0Hsx7lNPk/JyFTrCETgZpJMmhdaqDeOpnWXFRZgy9Wqri20zxuChBzQ0w64Y
         iDRczSa2MVCiWGLrJKi6bWiIcr54EWSPcToLD/wj9nVX9v43jFDqvUCCKMI35VDmNVXg
         FHXnJB4L/7fPsdgLz8CwOg8hzqQSG12MXEpvOf3Yn0hwVsQzxD/JpotuwfGasv31E+zO
         9maQ==
X-Gm-Message-State: AFq9FYI/hP2XXUetcXqQOKQAgVp8qQ4kqAyO15c8Q3wdEtcHsXj3tDfi
	dfNxKbc3DJMF5BTZ3/GdkYTVdFEyRWWrAho3N8VPvBE2wWWNv1u+Ml7yTlcu74Ri
X-Gm-Gg: AYBFou2gsZx+txvnToOq2FrUz39htMVX8PdHmatXBf6JDQdzXq280e/DkNdDRfm7Slr
	E14VW3ftyUMKVPS4+zAEfQyYba+jxRBHy3cIOi5/PUb+YycIa5m6IpT6lz9Jx9l5OJc7FMOu9eh
	in8zmHc4poKIz3EyWTMoSob/fHMAvE8s8Vmx+vD+sw/fVFk6BAJjGlTTc0seOfHltkE8G0Btxjm
	weNwEVFgvzh5iXe3PO9p5h/tQIbTnYWALpXwbSaobfzJETnNDJtPWO3OERh5tjd4s8gk59BZ4rb
	3K018mTySGpVY2GgSTeJj0oz45teS6yzjbel2SCb2Ue6wYpmRpc85jRoPcWmm6uWBoQoyORXhQE
	ylgFRhaiipSU2D/LWh9yXrFWdga1TZmNFA8X9LapWMHMCye8KUI80yeWtiuW5Ro2wPOD6CI+9xI
	A7woEMFkgElSO7lNDepLxewO17vifge2q2TdFcFrq5rOj6nrF24s5PrO445/I1bD+8izfBIU66J
	c48ls6uBySi20TpwAdVPwNYM/iC9goWrHdom/6ivdQd9W0WqmNBDxNhBP+mLY4=
X-Received: by 2002:a05:6214:8610:b0:919:aaa7:d3eb with SMTP id 6a1803df08f44-91c7cf4cd83mr42640476d6.17.1793204715105;
        Wed, 28 Oct 2026 09:25:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.95.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c7e272e35sm22256576d6.1.2026.10.28.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:25:14 -0700 (PDT)
Message-ID: <6ae221ea.b427277e.3cbf65.a728@mx.google.com>
Date: Wed, 28 Oct 2026 09:25:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5105559973402526218=="
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
Subject: RE: [RESEND] shared/asha: prime volume before starting audio
In-Reply-To: <20261028133131.262033-1-cochcoder@proton.me>
References: <20261028133131.262033-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5105559973402526218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195451/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.52 seconds
BluezMake                     PASS      302.95 seconds
MakeCheck                     PASS      14.47 seconds
MakeDistcheck                 PASS      150.15 seconds
CheckValgrind                 PASS      242.31 seconds
CheckSmatch                   PASS      300.28 seconds
bluezmakeextell               PASS      99.29 seconds
TestFunctional                PASS      1171.55 seconds
IncrementalBuild              PASS      310.32 seconds
ScanBuild                     PASS      1165.65 seconds



https://github.com/bluez/bluez/pull/2728

---
Regards,
Linux Bluetooth


--===============5105559973402526218==--
