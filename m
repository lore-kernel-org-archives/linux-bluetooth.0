Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378595;
	b=vH8WAzZnztNOhGjMsqkzquUljJInLvhKV4AlHgvPB7fW2IzSwfkjMdnGNk4+tqcgCOL5
	 IOZC03Uiir8rctIPmMCUDz+80dTc4akrxj0xjazd5lhjWUPcuSasXdACag389/qytwZ6s
	 Z5y/tmjgpM3MjbsEyq0AYDxLKKRYLxXdl6LYKB31+xRXD/+BTiv5gupNBclBFJFZTqCw3
	 vPjk6uIsGTDFv8BJVtnFblumJ2owFXRn4boGuqjmRYguYekPFgGokQT3mg1suyR3NX20o
	 pYuVg3E2DnHLvuBY51saXSJWaIUjjstxAKhHtBsEKrvZ6LN/PesMC69UbWpObdoKuKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bdUqs3GidMhDInHaspmuPgCTn9yYjWNmku+Kfhci3vw=;
	b=gLp3be7+E3bSPHTqmjWhgA1RVGcOK/fHwheKcToqOgTi8r696mC6cng07TWQ/t90Nhjc
	 ++RXRLBgYFyaVv0+m3PzKE7x5E8Tod2bRVV5Q0inFdqpkfohjan4PNd1jXzmbyoXr5gWi
	 L0PYvNhnRwKucV3CZR4RzTHf/XgT0QdGtwqfyqu9OwFXW6WqsK1djtlohwi+kteeCrgAV
	 uwKZqG0atrThG6Fx7CDv5LBqRAiPQVs4cZV5zQPZcdZhLTWfeJY0VXzPODXqTl78gysNL
	 fIla2QJMy7QCAoHqIMn9mxS9R26GlpMiA1QuP5gpfwOyigvjdPz0UZHhYtg74OuHiyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMnn5AvV;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E06606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 16:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E06606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMnn5AvV
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso465817a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793378594; x=1793983394; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bdUqs3GidMhDInHaspmuPgCTn9yYjWNmku+Kfhci3vw=;
        b=mMnn5AvVuLjpKO96/IRliLKS+9X93o5WSBnc6sXeeWn2WcIuni5CvIvL7iJ+rljT34
         dUREJSHPL49mv4KiJx/K9Es1aQW0ysbnPSHirXD7pMA7uh/6yNrqmWoX+2nudl5NoBt4
         i1adGQwMH7I645bvHysqMyGc69HGCrIjBVoqxdb94XgPHAiZBl7WMBiYhyTFqX4vUzM/
         bIvcFMXDxF86A8Hykf2q+BYfzMpyoiGH011sM+/Y1XuRYcnRmc/3YL9Cmv7oklK/KP72
         piirvzCR1KeK+jGVBgyZSqCW+ZEi03vDgqjW31Vru4o3iTn+LsiDh6LyxDk3mjkJ8c2F
         OkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378594; x=1793983394;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bdUqs3GidMhDInHaspmuPgCTn9yYjWNmku+Kfhci3vw=;
        b=luSx/3TNdQS4BAHL5lSUAoCdT0WEJKgD0UME6wrwuOt+L6gyyxUo595DyOqSEVAc9b
         oADsdtGQ6NHsfpVV8g7QVPE2ChmPZry3tpLt7ZbAfRFcawu18eXdeTwZNckwI2cHw2oT
         h9JwArPaw+yFFweRNLGHYTVw3MdyBhEANQl6S+pefJEsSztTzeez5zM1Kos250X/ZjRT
         SDtxvNMHINQn6T+EIlj/ER48EDgbtMcFeQ40WvSXaF6ie+KOtwJ7vaeyfXeVE1OntOeT
         iFgfr2JGH6jWFvtfbBVFFOfbOBQTIC2uvEn2wH7N9WYMg0yTc1Vku6Fzaq89sqzDvQSF
         a1xA==
X-Gm-Message-State: AFq9FYJ8HC0JnPlGRp8sjLv1Mgaq+rcbScQYQoKUXpPrf7SRLyVi/1Rf
	XdwlUjkDRRJUkRxdmvCj4XAOfMAI8LEA6T33GzAehr8WOowCOxtTw6s4wtw0h8b5
X-Gm-Gg: AYBFou2rjO8c91ksCbLCVhZuUzM3ABdq7WCEbE1Yjas6ZU9X5u6qNPYwPzUMGtuJf9y
	CoxujsyOrcG/tg9DJE5aWGTMpEwGUnDO1BNh9K6apE2o5fHuZ6vjEMpdAKeEI1vj16d9JB8A1lS
	MxgTTELyK/tXGFHdJm6NKMlMaYRhowUrgh51aJPsQc/xV02sf0+6twfisbZOmcclbcAzIMD6H4t
	wAoncumySkfoOxc1SW5G8WvNARAj/uWwADJ7kO18sXi2wJRRH0PcfSQTlHTLjMYNIy70BXsuO7F
	/tJAApN6Nqlyrv7B57tts9Zn7tzw2h4TyqIyahYzcly1eJoswOd6yEUqnjJcxG03rH8RIDOZjZO
	2f6JwQSaX1VKz8AeLs17vvlh8p1cuOvOTKmelTzsTxKhw/20XyEHzZmKQl9jVOPysfs/50DB/oR
	5BT0+zAT85WTXaAfkP3393CeyWq46fdZDVDg3chaWwA98BGiUoPECFPDGg4O+I5DvmUSqed3GVL
	qNA4ZepqCQQaywEzZm/PVvFnFgwmwotjH210f3N5dswl19lddK9hkQ+UMcSTg==
X-Received: by 2002:a17:90b:518c:b0:3ae:2961:14d5 with SMTP id 98e67ed59e1d1-3ae8979807emr2166829a91.42.1793378593965;
        Fri, 30 Oct 2026 09:43:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.131.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87ee7765sm2278215a91.2.2026.10.30.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:43:13 -0700 (PDT)
Message-ID: <6ae4c921.225db338.34a29.1968@mx.google.com>
Date: Fri, 30 Oct 2026 09:43:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3807306589618100909=="
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
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add UEFI BRDS and BPMO for PeP
In-Reply-To: <20261030115033.115060-1-catherine.l@intel.com>
References: <20261030115033.115060-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3807306589618100909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197122/

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      39.89 seconds
CheckAllWarning               PASS      36.52 seconds
CheckSparse                   PASS      39.57 seconds
BuildKernel32                 PASS      32.24 seconds
CheckKernelLLVM               PASS      37.42 seconds
TestRunnerSetup               PASS      753.35 seconds
IncrementalBuild              PASS      30.05 seconds



https://github.com/bluez/bluetooth-next/pull/1029

---
Regards,
Linux Bluetooth


--===============3807306589618100909==--
