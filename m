Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373762;
	b=iAqTzSA/pCY8KTcUbl2qqFykGbMvRQ9fcaMCdclj5j47UfKt9FFOEPfVnTdoeKZ7FDBs
	 jwQQOmumjalA+XNXcwNnMCesJezPN+EZY4U9Jve43oqLp/Su/RPok2YuWvVoqLTvRzYfG
	 kHA14ieXII64IyvUZduvcUpV65HN3nb/hCEJvnrgIqAoAX3Y5HwxK8GeGs7VpMLvw935O
	 /5gjfYHXNKjhKr5oA6C0I7+WVv8LEIorKRnFFpMaqOUnpIEUwxJ0wWpBLCjaT510tyIXb
	 lqvDCPRRqnGvQGK07YpR/pen1t7MyiKDwkAhJuf/mT8oLbZsRZJIpGJ/ZQQfzdAxsaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=B1OeMZoPGB4vPsnUmGfeBfuy0742eZXzsE8+v1yWEL4=;
	b=AUZqed4mwvicExq9eAz8NqDtDCFpoTP46KisNIJhDQKdjGGj15zt3LNslz+yjx/kT1iy
	 AmymmzHhzNg7az4lnL/khCxqu5XJreIzgbIkYIvansQMhCzXm3flxEhLwUU/jkPc24wen
	 3K83q0fCf22hHcGVlwlhCdnJUJYvQdSmZZbc+tvOBAyuqNVPqxVFuqtaEo+9rUGjROp64
	 hLIQbwhOukNZn1GIFJ2BSrxTuvh0w9JNQHqgQ9NbLuVODjROz7S1LjGOSehffKI8nxgeL
	 QcwfNcyEVt6uuSFYrTiM0yKPyxqNwuHgsTVoAfU55uPlTUGSLkbj4aO5XO4SD2jJ7Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6dEjQ3u;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80529606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80529606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6dEjQ3u
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91e7af9a67fso16290356d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795373761; x=1795978561; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B1OeMZoPGB4vPsnUmGfeBfuy0742eZXzsE8+v1yWEL4=;
        b=U6dEjQ3ua0Ga6gZLD4IKZkoXiJtz67GwOPbG/YhUunc2EsNmlyxWz3bUEdDM8YwJLC
         EM3XFSKoosZblbtKktau1mRseImY63w42u9rjHn/EytXv3ob2g2rrhlfm28f2Sd06COd
         6PCBJQkjukOyEbJw39bn8wbgsr08aqrWf/711oWdKSZ+nMefnZ3Pl9RoNrFFphU5zdjq
         5saJmusiOkPHFJGjG/O+rczG7jurfIqeuYEoeesUcx5U1kZf8MS/NzYnLGTipEwhN9HE
         iCxKTscw2QY/7Fw2uukdyyWqCP/n/fIctTZgpTaqaxkMNZng3GuNfhCIRdouUjCS6Zm6
         25OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795373761; x=1795978561;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B1OeMZoPGB4vPsnUmGfeBfuy0742eZXzsE8+v1yWEL4=;
        b=cqDU4ZM422DG6f/Vy3YxI1pTy1cb3G+dZ1UuGC2ef7iII/Nfrr3EI4+YJIGm3PQKEe
         7LtYPdRkkJK/IoLXKL3irA438/G/W7VCBIexUcyRpd5dkmGELsBwREFbofofRt/lUX1Q
         mnZ8NKm9iioRKXXH9AUtKOoMtLKHnBcXtGSLxs41uDf6e8WM5EK/nZWmAnaXcMUlHw5G
         1S/+aF4O9P70fOaIBWQPgshFpzd8HDbGTnifOKS0jB1hGVPkQ2M9/+LFxKR6o5YL2nBo
         bUAjc5K0ssq5vGAUlMyDwT/vjrnJtZSWsa1BoU5XREIk/vQX8v2eTaz9F/z7q6H2qAB5
         ILew==
X-Gm-Message-State: APuU4Z9NEhII73AQKKUqIonfuXyZrUj+Jz5oXbzBUY8t5GEvi/n/jDc0
	lmysgrgP9ckvneNzZxtiliANGTjdPeyCMxW3dVC05gYBTHXGviKOFAhTMSGfP6V9
X-Gm-Gg: AZFdTZdcCcWTZ1JOR9Zz+b0/S5qdJWr+7oNwA6PKUYo/Evx3waio5sW42AjBQjCgtKX
	Kp6+N/LTIU3tX6Rs2KEnKUwxQocXsRNcAW5KeMZfPo/6NS0LEwLn/8FCbmguBWxSSxoJatV9KbS
	v8K2uZwQSrdjXXY65CARbYfCZjqubzTEJHAbZKPYJ6xs/RfGXpT1maH2unMBAiqkGwTdSJuegdH
	kctOlvlevfE3d2/6636B+xiugwVz5GOpFkEEFUqbaxmCAo5QbL5C8IvJLmE8RFtA4gxz1S1xNkL
	wRBrtBXxRmuZ4+9SWPs/enrIJ2lNDHOS5eBh7F6hnHyQqTNVIUtENxFfZmYHaapSRSgN65lBPKc
	SN0ocuNGd/h1tlOMtSPtJiW0kT69cdtOZb9H7b4qop79nb62G4Y36un2HfAyz/wqXQRdxBr8Q1W
	Lpc7HoVg2s1UQxUSUsxneMfYLcBYKf18J42uj51mtAPbgVL/QN0VGM+v0fPpKyOAKdFCErm4ElV
	su1q+re5CiMauH4bLPTdUjhMVSrByTohBB2Auo5vUu0dK7ZV8EVmAkerRMTjMo9eJRgxBhr+ldj
	gvv89WqR
X-Received: by 2002:ad4:5dcc:0:b0:91f:12a4:27f2 with SMTP id 6a1803df08f44-9213498449amr173028816d6.6.1795373761409;
        Sun, 22 Nov 2026 10:56:01 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b79sm84615856d6.5.2026.11.22.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:56:00 -0800 (PST)
Message-ID: <6b033ac0.b0b4b201.3d49cb.9053@mx.google.com>
Date: Sun, 22 Nov 2026 10:56:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0372562908763637992=="
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
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: tools/test-runner: Add arm64 host support
In-Reply-To: <20261122-tr_arm64-v1-1-4eccf35daeca@oss.qualcomm.com>
References: <20261122-tr_arm64-v1-1-4eccf35daeca@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0372562908763637992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218567/

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       PASS      1.05 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      313.02 seconds
MakeCheck                     PASS      14.56 seconds
MakeDistcheck                 PASS      146.23 seconds
CheckValgrind                 PASS      349.47 seconds
CheckSmatch                   PASS      316.64 seconds
bluezmakeextell               PASS      100.20 seconds
TestFunctional                PASS      1218.91 seconds
IncrementalBuild              PASS      318.38 seconds
ScanBuild                     PASS      1190.69 seconds



https://github.com/bluez/bluez/pull/2866

---
Regards,
Linux Bluetooth


--===============0372562908763637992==--
