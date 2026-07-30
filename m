Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66720D4FC
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440764; cv=none; b=GSRsRhYg7bWgIzjU3+R2Mtzt9DDvWrtvpfoqAL8MwTpBeQiwwzm8nTZ0JCbZNdLHWSjnD9M3JmffzkTG4MlLFOgA9Kv3VsYJWOG7FeVZ9AtPF2Ir7tFPoh9Gyr1EPg+gw4ew4mNMAYM6Z+8fAkexHt1ejn4EUQgPN7Qk5g8zlrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440764; c=relaxed/simple;
	bh=q9pXI1ETtEYdcFmdRSsCmxk53ZZ95JGG2oJ45ujt14I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eX1pyVMTiXQmm0Hs39PxDy+1oq1mhAsdJxQ6rRu9wUKatr8ns314i9C36Ilos0xljqYmrOw/77G+ILX+KZYcVcS9MUDKXrOrZd7yy5IleML8eDoVVqH99LBTyZOoPM1qAbzffj3/9ihq+x9TO4v1q4ADU8QaozcaDlsc++oFxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TisJG8l7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TisJG8l7"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e6391b114so17824985a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 12:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785440756; x=1786045556; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vx8HQB1k9n4Z/v4z62XYau4y+gHh/pV8KxvPcrBA94A=;
        b=TisJG8l7SCgA3Xrkw00aM9Z6dBeU2KJRsbbGrd9c8xB3cIih92x0OoYTtH3fJ7Ana3
         m5FcPQoNVkidu/9IIoDS2D5dfh1gcZq/8TeAcADgKW4L8QbGgD7xcT6tGr1cxLc2dB0C
         lyIgEGGKXeEbk3M53Evd57nfpK3Kz1hXp/NMPMqDnnu6X1X397qReojq7x696xa3cMQV
         4/Nwxfsm+S5KBm+wVIfKsWk70Sp56pP05xKTA8j+CaHeRrkTs/Hfn8TH6VIRvQEDkslt
         SbMJjkoolllIXajvfNklDc2sQWi3n2jQvLJpZPTYZvmNDH9fa2S5jZtiAs7SSEZBfDyl
         1fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440756; x=1786045556;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vx8HQB1k9n4Z/v4z62XYau4y+gHh/pV8KxvPcrBA94A=;
        b=h+if3EmsBurcPKmr1h7WB+WgdHAcOSP1WDWuwrg8z0Byh6AkrGTMPZs8yZLE4t1Xg+
         gVTb8Fv9DWL9Ao8rXPvnWWP06dk9VjfXqp8RMbrw6UehX4MRhoVZvXoXmmD56ZqaqLxN
         0Km5JslOUDJxtuFbYmgIqdt5b6OPWJXUt07m9ampuE930fot2P7/A6PnBKKrVT0XSDEh
         y2/xq/53e/Zw4sljo7gdxxTLxk7lfz9hIntu0k0GH0OMGz7PKRpV371HBk0lkswnivKX
         2yjymEzKrLxC3uH3GPybxAv78a3Q6AIMAyZEOcgRhQmA7p0bwoszSWRezS2ulskwZBYm
         oubw==
X-Gm-Message-State: AOJu0Yxtjp5nmw7mUnjSyLm7/3rl6rxgPRUYOE6u+11BRqmYIwWAcJsw
	MQ5wLHuW6j25Wpl9Dy8jPUp6WXfj877YLPk8MunvU5Gx7NK5DqvYALm9IajrMQ==
X-Gm-Gg: AR+sD12iWxZdVcinfebkIk7Kk27syZyA2Uu4bCmfPCz/zMXoil5oN7o5n57uV/YFCEL
	uVY9VQhY1MCANuTEAg2miYfI66xFGmgqSnYAB0URoPWnOXFzWqd9oleY6ar9hNlAPWf2Er+uras
	NIGqlfKXGYx88I6c9jecIYaFVb12KI3GKUqQKriktWN19vRzevOVkx8SI5Eoyj8ktiEYDV7LiL7
	xUVEpCgEMWSe1FrILBzCGdMXfomqM3M+vIMfzmabw+YYouWrajhIo+/yjazRP5olx9tI0C251jL
	Y3cSlHPV60E/BHmpR6n6227zylsrtqSrSH5Clkx0s8VlNjTT4ADel+wpUYfqI6qZfKSOFCXIYoH
	xiySkDGn1R4AhzJhe9cDdNSGNJx0Uq7M9Q5gvXgOT68c4mJBhiMatPl5Nf88Xm8q6z2ant46c01
	NjTf5YvpubUHIkuAja5YO7gqP5+sGcCDR+3cHCbw2VtYsZuvL7LmTLSAbbjUskHDRGuVAmfPHbM
	SHU
X-Received: by 2002:a05:620a:a0db:20b0:92e:5137:2830 with SMTP id af79cd13be357-93486ee9d03mr329554385a.72.1785440756278;
        Thu, 30 Jul 2026 12:45:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.87.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e733f4ffsm495518185a.38.2026.07.30.12.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:45:55 -0700 (PDT)
Message-ID: <6a6ba9f3.3d6d24e4.3347ce.79be@mx.google.com>
Date: Thu, 30 Jul 2026 12:45:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1195625794806809625=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Decode Intel DDC LE extended features
In-Reply-To: <20260730175135.2865308-1-luiz.dentz@gmail.com>
References: <20260730175135.2865308-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1195625794806809625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137629

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.14 seconds
BluezMake                     PASS      513.53 seconds
MakeCheck                     PASS      0.96 seconds
MakeDistcheck                 PASS      154.32 seconds
CheckValgrind                 PASS      145.77 seconds
CheckSmatch                   PASS      296.87 seconds
bluezmakeextell               PASS      96.29 seconds
IncrementalBuild              PASS      518.94 seconds
ScanBuild                     PASS      900.58 seconds



https://github.com/bluez/bluez/pull/2364

---
Regards,
Linux Bluetooth


--===============1195625794806809625==--
