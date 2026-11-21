Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795253939;
	b=tZIwXik5Vytz79266vQRdeYSNysZSga7dkp+iL79rnkGPhiQ+FEVxlDdpTtEfePtkvqg
	 yZmp9pWud/Srsq9s4RCv0pcSbgzP+f/hymWsKvyYUKM4G370VxkmogkfFYcnSOPn0DN/0
	 C8Sglily59hwDsDUUWMEiN4oisLlPSVYHlIX14b/Srs2p7e937j0ctoqdEp95S/7LHK7w
	 Vq4VuODGCLElyTYdrsM0R5SHYJ49gIpq4JvnNyzwvb7CvtG1rRayK1fftCthZ4/RU15Oz
	 CCwhZOkjLeQX07rrJjJiYn66ZZGoSKyd62G1lEb7zG2Gt3eVtqhJY8Ya3u0Qb362gVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=gpJx8/isQhbIVOJapabUGCYM+Vl2UJ43ygY9MulsnAc=;
	b=haeJdBTa9hFM8YNBwNKmZ8FqI/1aQqTOG2oIwmSIKTVK64nF/TCNf7KzAe+BIPMzII7d
	 gfTKTwt+vfHaqM1TgTmlYTCRy0k96/06MMtGwdvIidtLPoQ+5gi7wZ1lJX7VlfwO+IZUy
	 1fmqpZXNRyuQKbblVPA/lvym/X4iFyKw3odtxT3mvN25Zle+wvHEJuxkBJxuLbYzBRs2d
	 rFQEpOedaWAYKmUKru9gLx28wOdtUaNIJusVKOGMDCoScWI4uahiIux5lqYO+0Lo/X4e/
	 aT6q2jaBLP6b1SqOIMQeltm4S3QXwaPIhHylr95XFjvOj8cyAHdz7F3y0dLTdJOYLIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gedp9k2a;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E2606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 09:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620E2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gedp9k2a
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-949680e6d83so163978685a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 01:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795253938; x=1795858738; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gpJx8/isQhbIVOJapabUGCYM+Vl2UJ43ygY9MulsnAc=;
        b=Gedp9k2axkdXbiBa4haOe9SMI7BJFIKq4w2ZNXgHG64v4chBOzS+kx42cbh7NmOZb8
         eho0ZNTyw1JuQaf3cGQBWUZWcwVIA1hE2l9uB7J0oVroQ+eB1BJMDj5bi7BiPNbPUNv6
         7MVyvfB1WVuWRjSIDTSGxdoB+Eq/A37JV/gmT15tgy5hPXhDhzsbjMsMEEOZLkBMyPhR
         ELeqt52nBgAtJI4tc6Qm7Ya1NTUNK8+hgSppbVpkP2+QddlL3AZ2c/4VqDdeGX02qEbr
         2hXAxRQxL9qllJJ9SFhCU5shcFiuSXGuaNURfHmffz2QFvStynpoNYOsth6tcZEfAypR
         7tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795253938; x=1795858738;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gpJx8/isQhbIVOJapabUGCYM+Vl2UJ43ygY9MulsnAc=;
        b=sVOT3XlftuX+n/4XGNsKH4AXcRLv0vwnOlsamdFlGwwRHwG4JxEN9bKaJ2tGdtwoLL
         ae2vPT1pGYjoikyeSoPcD/m3CMGD9kRPj9k3rXfXtzljOostzD9tpcaIDhHVsM1FzXZc
         V42AK4Q5afMpyxMEgLb2nSjSftpJbCKsYEiXLcNMAy6RZ2lZzYJf/HsrwryYf8pssHUU
         DjElk/bFitv6caDvupSSih+CZTfsDGaqNRLzegarhLa7urExCGejzfMzeu0wd7Z4LKLl
         B16gto4XlWwCojOtpvV0nQ1t9aUMCufhd5dr02F6my+Yz7A/zXRRMdaTZcCeoh/xvy6v
         3KSg==
X-Gm-Message-State: APuU4Z8VVZSEY8ukgjz2y9sqP2Efvpsebfzrr5DOsMReWKLTWpifU8KD
	Z6JyJ/7dwXakwtUHK5H7X42NIqyzvcmaLTxuj34ExssNVMRaMBw8R8exdAftnDhd
X-Gm-Gg: AZFdTZeqJ9YaSkajax5Zp3BeXspUYTZBEEQgBKRr2Qsp2lpturH8paFGpojESGAROzQ
	YodJtzKqB3GF5CanIV98DOnFwxpW1LPUW4hJlWv8+cY6mUAfnEm8hqx9npMQrHcuyLm4R0FEQmb
	so1bDSMPTj6YtoRfGqsLKL8LxdWArX+B1vwU7l/YMN76bZuC03rEu2j7bBnqrrtzzkFf+mm2I/F
	8n7mPc4Vln1FS6Og9kGbzL8bR8aBYFG6+UNyFfvkqd9gyilEbC0fQRVuFb3EOG/Ko03BTWzkNks
	/hJhDPI4WWOKFQGyDmd9qrVIgZ4QwomsZ9a5JE8vXM1/xI/PrHHSfH5VooAg5lG2cXiPVR+JvCs
	skObR+4lcjdgYS14jeB7yFaSuK2yC6K2Hd4/sMHQqAdGPz4sRqBryVc8NGVxWHoAJWjtbeA6Sdc
	aHqR3wCI5o0VG8TDqBzMtRv1ngLPkh9Um3OQM4WuIksbRIoo+wQotyuapCj42MUj9NZS+Qndu+T
	2SG9maQEhhuwEj2UXMYzFQxyy2ZL2sFulYsPFZ+bH1X1u7FG1p0ZweV6bXBFOzohU8tjQjcqU63
	4FbwrDCL
X-Received: by 2002:a05:620a:414c:b0:949:2ac0:2a32 with SMTP id af79cd13be357-949ba96e760mr1006014785a.26.1795253938259;
        Sat, 21 Nov 2026 01:38:58 -0800 (PST)
Received: from [172.17.0.2] ([48.217.36.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb424fa6sm380419385a.40.2026.11.21.01.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 01:38:57 -0800 (PST)
Message-ID: <6b0166b1.2ba6c529.114857.140e@mx.google.com>
Date: Sat, 21 Nov 2026 01:38:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3799690218305765664=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: RFCOMM: Protect sockets during teardown and TTY handoff
In-Reply-To: <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3799690218305765664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217946/

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.69 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      31.31 seconds
CheckAllWarning               PASS      35.37 seconds
CheckSparse                   PASS      37.75 seconds
BuildKernel32                 PASS      30.85 seconds
CheckKernelLLVM               PASS      34.69 seconds
TestRunnerSetup               PASS      749.93 seconds
TestRunner_rfcomm-tester      PASS      5.64 seconds
IncrementalBuild              PASS      30.60 seconds



https://github.com/bluez/bluetooth-next/pull/1173

---
Regards,
Linux Bluetooth


--===============3799690218305765664==--
