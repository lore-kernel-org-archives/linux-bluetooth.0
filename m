Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671029;
	b=4HCxjGBQBQdbB9WleSI8/OaDaPYmhUQJZTeyKJRepp1R6gVyY5oXPD+UoVALO09ZMns7
	 xb3ytwIIc4llXlPbHKA6DBCRBmmJWykCvIy0Awn8vX+kurgzqezU5nX/8kdL7kQ042NaO
	 1ZqLk3tTq1YKWJp5miCrI7og/w2gTZEUetFgioYk+yTxKGjsDSDiMHhP4fa+OqvukKZMM
	 4svaH4+HF2pX3kTbkaduGaQ6bW+OLeJ2ydHEodXfuxyErATgyhVPFLdIWXB7OOlJX4Vmc
	 B/HyVBAQAA6cujJE6o/CQNyvg3Qul4siwA2AfI+NMVBH3KFooejLWryelWIDHE82xkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=hzTBCfXOlJaSXoDWWcXVq+vgnRCHA7Y1XvoMNspDphY=;
	b=BQX+b8GlwirS8i0QPzHFsvuSPgtRSQfgeZbra//JoL0EqsVy7f3JmpQgvTQ9BTzhzQCi
	 OU5Kc+VgEQKU3esODkuD0iRSQt9oST2agbK4AfeRNCjTmMOs2kQN29Rud7nhzUa6v8Ezn
	 0nw4OCWQgTTqXM2j8O1XvIAiTMIB7pUOVrV1S7I9332whKI9rS0nnME0jDMww16HwAMYK
	 RVzpI1GfYRAeXfRitbO+/ZWI/a8Dv+eui2RQfJ7A/5i9JsfYE4ebdXVk2kKyDe63fQ0Me
	 Vwp+v6yk5Sqpook1vHly5G5iafzRyOiRXBPZoh/v5IuBnzOwPZ2IS9PXNsYvibn1hnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ew8fvEeW;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD9606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 01:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FBD9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ew8fvEeW
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4e4a4d77e5bso149468b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 17:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793671027; x=1794275827; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hzTBCfXOlJaSXoDWWcXVq+vgnRCHA7Y1XvoMNspDphY=;
        b=ew8fvEeWEUkm5QqpI9EceRZNGlusHfh1epQ/r4LPHDipyju7qf3zV5b7OyROthjWwg
         5/9TaCn04WFeGjcx3rRpeiD7REBvJuxkOD0BxBFhMss4T2sZbH4OC4uJwkjaHhVN4uX9
         reTPrZkAnvgrzR4vaWMss2dSErLU9W4lG2Ud5MqiUkrjWPMRnTSJandX486ZbPJUgan6
         OO46WX2ZNlvQrsICvy7mvSL2WoUKSCALRnBuCi1a1RkPqleC/IvtD/0QI/eG1adMvSCO
         1I1m0IRj7T5syqz9Bzsij0eA/8z6pffeNU0Iy8ZRex/8ub03VIFlYeBaLuQehqbZ4IF1
         p4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793671027; x=1794275827;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hzTBCfXOlJaSXoDWWcXVq+vgnRCHA7Y1XvoMNspDphY=;
        b=Lq+uiy4RstskKU/qsc5vOoq/b2ZcR5icm3lUu6cu8oQDc4rt5m/LCAdSUfesY/L7Hh
         +cfRIl6s5/vLGXxExj5MnRha3gPZd7ozxnsdamIrwCp9GqCY4b77sM4AJZKhi63flE+S
         Pq9nPEiKLnnol7dhYAQJNbZBkX1N/m9g4t6NpQmbhwNv/Y1BKwd5pS1fXI0hmyFL7xjr
         X0NwbcpgvSvdBkS2S08tUTl555SbQ6V5k8D6HUoY4RU5lzLz6dybh7bPHswWpt2bxbMb
         y9LQMv3dfxhgRccdXZblqRT3EZboG30DfUTLOz9DsrQbXISvHMkEEslaXP4mN6/K5NmE
         cObA==
X-Gm-Message-State: AFq9FYIeWHF6SQG+rq4tmLxqAWaH8Hcc/mstGJFjnGLdTnpgiNQ8Y9TP
	XY8+1LdzBPzcQYQ40FTbg+tSxjmDDyL+9ysETSKQUOICQYZ8vd9I783gMxqtqC2s
X-Gm-Gg: AYBFou2MuD+1eprvWIu+aC4F0bOD4iDyuTThQkA9NNZXH7bdlkAorJFobslM50GX3Dc
	TSlDEAwR13ivhnHSr284jYeO0AmjgnnOHTHZfVaP1Sgl5pPEqb65Uc3w/lEMNWHcR2BdaubtVHn
	bi0O9ugOB14opjrLRMDXCZ6PtFC0CaMV31xsW5MX+3e22hpdz3PfKGragxrQ0271j4NwTEMPLMH
	Ue2DdHj37ayowEoWrq/0XWF9JJxwWgk0QffxYvw+uRDyc87htEADYVlj+HZ8T8ATHkHQZTrK4FF
	0tZmdCIvmK+2mJCJgnA8dcm74Zk+CD63LcGpd769OMVXFjlligJLCkkeasUfO7SFoABVMlU5itl
	Q/rudNTxiZZjbSo8621BglKX9ZBCzT54KYWBTZqW996kAELCbApE7a03/fmN/a4AQtbSXbEDHq4
	adAQLeNuhPxMaMOeTFdBLNcK5/4SqonrStmoKkoNrGCjbApBblXFEFrr/3o0t+G6mM+A87GQGd4
	uBIszoVugnlKppL8Eh1DdFMefpQYvOJABcZNmcAUKQWRhtqcj+fkGxDR52nhw0=
X-Received: by 2002:a05:6809:35c:20b0:564:3072:3827 with SMTP id 5614622812f47-56430726d00mr2326443b6e.18.1793671027536;
        Mon, 02 Nov 2026 17:57:07 -0800 (PST)
Received: from [172.17.0.2] ([20.40.223.123])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe0fda0sm9925926b6e.13.2026.11.02.17.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:57:06 -0800 (PST)
Message-ID: <6ae93f72.dd457072.1d5ea8.2edb@mx.google.com>
Date: Mon, 02 Nov 2026 17:57:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4804123102759788553=="
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
To: linux-bluetooth@vger.kernel.org, rasmusml0501@gmail.com
Subject: RE: [BlueZ,1/2] profiles/midi: Fix running status across channels
In-Reply-To: <20261102221223.16079-1-rasmusml0501@gmail.com>
References: <20261102221223.16079-1-rasmusml0501@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4804123102759788553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199554/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.51 seconds
BuildEll                      PASS      14.55 seconds
BluezMake                     PASS      193.26 seconds
MakeCheck                     PASS      13.40 seconds
MakeDistcheck                 PASS      110.90 seconds
CheckValgrind                 PASS      168.74 seconds
CheckSmatch                   PASS      192.40 seconds
bluezmakeextell               PASS      67.73 seconds
TestFunctional                PASS      846.42 seconds
IncrementalBuild              PASS      185.30 seconds
ScanBuild                     PASS      646.37 seconds



https://github.com/bluez/bluez/pull/2750

---
Regards,
Linux Bluetooth


--===============4804123102759788553==--
