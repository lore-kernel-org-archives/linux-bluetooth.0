Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898345;
	b=yHYmp4cS1H/0TcXf7bKAEhuMoOhQpgzYtvG27qSwpaPzcldu5lAlQPvIesPjFDGBxTDE
	 PbvVcwIiAiGvkdTL66La2ct6ajJiK+N737FiGC+2EB5xetcs7k/8vL0RABiZ/qAfCcQHN
	 OGzf1CTCIC0wICW6WrPAHLaFzOR1m8uKv7aLNPJrW7Cljk/QjSuE9WU9RNQGNkcY8FI62
	 t0blzmmqTRiVBIoHtUAWqP/e2cbTAUBse+edK2YG2vvSCPqnBLXXRKR6+Yc+DpcDBW04n
	 9OV1JYPLa5jJof1twmW7Em9tt4wiiWpPWIOVbLY8Dv2S7rhFFyskAXIxQhFigzPT9sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ooqsdr78/rmfCXZ/X1czeA69DBb204fgQs5YEY672eA=;
	b=BMh3ZBWqhT+cA4eClWsGBTsKuxT8qepuzrA5Ua19xuG66cI3I6475B4y2B3LU8yqB+Ef
	 hj7R7nhr1h+cMg+RGiBtXBSOYr5hCn6AhmXeFw7UL5X25buOg22H01RXVBW/6xuiFpHAD
	 dSq8FoX22v4FUgorDVP3ueC81thrqJJ5wUjZhXRrIOjnHJYFNyebh8v8FEGd0X2Aiy3NC
	 /Jyw7En4FgRpZ2JRvJzWk3J6CSJwV1SIZxoY/ZjP/8iko/jltw6B5WaZd5nG4BXPBXBA3
	 eBcnXBYjnjmuvJZA6zdI8TovqrDBPkxeJ2gn3+g3hMcZCRbV5wRXjudwlh7ka+LDVJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbjP4XaW;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B88606A330
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6B88606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbjP4XaW
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53397554beaso20031501cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898344; x=1794503144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ooqsdr78/rmfCXZ/X1czeA69DBb204fgQs5YEY672eA=;
        b=PbjP4XaWN9NN2J4v1U+Xh5JGX0RxDz8Pc7WCC1V7/6H4zDiQXanEs48M0wuNB3QYKT
         E01plgPBgmo6x2WTF9OZXxEo+iZ5YkkYw9SdmsIWbiCH35k1yOuKgZsM94tn92o2eEJj
         kq6Ibrtua0nbNjvgf0EQzKSSJYAz+1QTUZ06PUx+gANayvMbS8AsxmL4GCBTpC2wljrm
         kPJ68sSAiqrAiCtqEGSYeqqJGrMSSbGWABZf4t/AHphAUW8vxX8fiM6OKuQHryr/9uvn
         PB4JDoDIz9K0Iq7FffnzVAIUCriZ97tFWtEFny82nu7TJonbAjisrYAuQQQE82hiRTit
         vTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898344; x=1794503144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ooqsdr78/rmfCXZ/X1czeA69DBb204fgQs5YEY672eA=;
        b=VkwVThm0SI1R45cxHnqrojtI5EjZXSPAi4tOPwE5tyZGolYxiVJI459q71F7Nzt7iY
         qds5m9y/wJvWhWrhnNdhOthyhqj2VTKDnSEdB/Z+jWk7jFpq8/wOJ5bPaQzdxeuSk7/j
         u0IItGsVcXV5YaUlSJ6rM0sUXDg9oQ/DyZE+jLpD8bxTzc0+cbRP8Gvn0IJkN61acy75
         79grzvlJZQBCvWIKIpj9e02GkvNcL34nx59V4B2YZ/HFIKEpZ1c0AJv6ZUPSzTmDCa9o
         u9a50fLzWuWe4EWvM5myqxT5XZ1HwASUOIMYWBY18uInaqvv87s/FvdCW9O73A/Lb6Az
         D82g==
X-Gm-Message-State: APuU4Z95LLzV7X7gnmDLLnNQ7vONdQtXG7QW5zvHOdgqcvuiiW7VT95g
	2viA0/VpL4yzDr3ua+Bnx7lJXXTX54t8dgIyIR4Dhp+HCV/oQBpqtfTvIEw3Wg==
X-Gm-Gg: AYBFou1Bi/8nkF5VNhW+jBErzSTfpvtfgBqKt5mLEKE8CdcnaWwxf5vj56YmHuedAPG
	aXl0Desp7ngqRThM6et85hyJ26XwbA4KU64t+hoYleYY4sKs/pDS1B3igbZe9W4I9sMVsoTq+FX
	S1p3AS5mSAngsOAtzRRMKACJMAk0jwV4k+bQcpRu/xXU7Fj479thi2/uDeyqJn4yfeg3Zps90IA
	zvHQQOpPEBt6j21AKl2lDF0/ZC8c0+Zpcxj/FAGBjxPR+cx4/qOddYsnzH0BpeQTas3RrtE/4gF
	+pOkp//tsiO3hnt86g//rv4niPMy9+J4xpJ2No3um6SjJgOm0gj9FiqUpKnmaasxPECiA8pcvg9
	2NsdHThAUOPygVfcaD8pDjUv3g5bm3Mxx321yk2LiBlqdYkJEf7x1D7ZlIVKzFDolLC7IW1adwJ
	0SHFK6lmXxSrKKrMup6EvLh+2oy3UCCjU75ooCKibctPZ3VBJsz0DgkdFFrdVt0GuB2Xh7sdsn0
	l6qKoleFsPqPHaJTBo276b+YvEStaU0pYk4f9c7ZcT0BsSfXe8K0NApXxbwJM7pP9mJZzapjTMe
	a+1/UgE=
X-Received: by 2002:a05:622a:5147:b0:533:9381:7603 with SMTP id d75a77b69052e-542b6d5f76emr312024441cf.12.1793898343506;
        Thu, 05 Nov 2026 09:05:43 -0800 (PST)
Received: from [172.17.0.2] ([20.49.14.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm55996821cf.20.2026.11.05.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:05:42 -0800 (PST)
Message-ID: <6aecb766.55d9540d.3d664.2eb2@mx.google.com>
Date: Thu, 05 Nov 2026 09:05:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0615413381295685793=="
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
To: linux-bluetooth@vger.kernel.org, leon@kernel.org
Subject: RE: driver core: Authorize device trust before driver binding
In-Reply-To: <20261105-device-trust-core-v1-1-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-1-1e536825b4eb@nvidia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0615413381295685793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/linux/pci.h:616
error: include/linux/pci.h: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0615413381295685793==--
