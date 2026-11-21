Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795253466;
	b=Vy6pp4InosRKWQrPglJ9FLK5ehBRuac/9tFxQqSV2qWyHz8RLJdsAM2M+0xwCN2+MfL1
	 FmiFZt6C1ywTpHQisK0d4CWHe0pvYn4eaz6JWhS74B5E6j6jc0HX5xR4I7BuLEJxbwIHi
	 BZ4qvGS9kk7OSESMhATxTTMev5DC8WJnLBVIJm2bkSRymcBW7kxPcZchz/suPbrqll9D7
	 J496hZm1utvthDt3penUm1BSCRHLw7b2HAOrXJmEF5LemqoISN/RNx7G0a/4scQqnpa0k
	 xAsW2P64shpz0ll9EQLRr/ULdyXwyG/m/eErG+KiVUM9aV5fGoRCD/1uydvk0mjRfVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bhMhc+70k+qerq0VulO3exJt7ZKQ9teyZOGnVEbve74=;
	b=Ap9PCjO/ZACBy03aGro0gANWzD+GXBCUxIidoZr5zB0+m5LO6nvysWdo25Yi2U0N5++j
	 yzyMzNB2XaR2PAobASXbCVLT1sq5gAcyh2bGnDF9oxSfAp1aIPXT32mHR3OgTD3lcqH/+
	 OIeIArcAaBDHX8q+qw/uNh9omNs7/xBxeGmEwDaspcMCFP8BjuSIPIg3xrtSGGnRs7/hS
	 X6BmdWai6YzLlyMh/MnMWtMiPPJazzavesMXbcNR+KQiIT4bJ7pS9B9PcuMNFGrCOH53h
	 B9loYg9GlWTDmVVIWkMmtlmyUFUtfKU/QSyPBFcf33vcktYGV+8S2CG2VWUR3kKQQzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a43Jg+xU;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CC606A325
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 09:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B35CC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a43Jg+xU
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-536c8f958d7so12519271cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 01:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795253464; x=1795858264; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bhMhc+70k+qerq0VulO3exJt7ZKQ9teyZOGnVEbve74=;
        b=a43Jg+xUC4PDKAK5x/5CUTR5oO1VEidnsO73MEwDbmurzse881b1HKcA0pQHvrQ/2Y
         ebVsfhac4gNykFgKao8bXe4w5GdmnimMi32iEkZoAM3t8IxqGBUV4tg9CAu8jUXDgW7/
         sqrNBJVzpy8HVmWkg9STtxbLs0sc2pjlcTeJwJWPqxMqaBSZTi43wd5EhFME84uemnnh
         7ZejiUP4s6CbFD8Rn8nhMnzDDTPr8gjKKzOBiHBY5Ra0UL+jYPhBO/SySySmSDADS39n
         rHDFdPw0efFWdPRiPphzyQhAQ83x2wcu0fnvOhYM1vFUAEnIkF9TCJ4bVMyCPdWyhNjG
         j4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795253464; x=1795858264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bhMhc+70k+qerq0VulO3exJt7ZKQ9teyZOGnVEbve74=;
        b=ty8e7X4PWbq9LfQl/AAaJ2I4o0Grmbyd6eKa4hiO5A3mzDgDDASKh5t0aLVidymlsM
         UOM2vWH7gBloMrcFGuXmEIXMRkmQTuSqYzX4QOSRzmrzu9K84bsIp1qjlkwOUWDAfNjS
         XbCEb+fltqN9vJbwxdDamGE5OhdSqFH7blhFyX6b9rVGDykBMZlnR9TEqkdsWuZ/Qfv+
         JmngUsG8B3vPZGXM8zytFBxWt0gjQQ3wzbHw/s/cxYIt+VCJ4m4JfVA1HRz5BtcqFsw/
         65uCJt6JZ/nYQW2HsGOt55kyP+nbAD5oVxaIq1P5RkDi2e8VaLlOpNJLow1TRLfIXlP6
         LW3Q==
X-Gm-Message-State: APuU4Z93Sx7QioJlo8VMevtBTbihrTRLMpVjEzRwt7c45YpZuxOVYuf3
	pPCgg2dWH/U8+8ao8N1uXD+KPSaXL0Fm+ml1iXZ3jLPKqOWKW0S7qnEr6RNhbw==
X-Gm-Gg: AZFdTZcBuTJl3RsJ62LCiG2tPaHJKYbBDRYbL2K+qT2QQfP9yYA0ekB22ZluwPRlFJJ
	NVczSN0PPIZGl1SN8qHhmnrlD7Q9S9eMJletZxggsHcmmjm6zSMto43HAt4LS8OkZa6BSXPmsSo
	fHkId11gHUJY5Mc5xF5kTMbJxDQqDcwoKNutoIN5oZ50XgDk213UUJWILfi4YM2V0jTXuoUAFfH
	kKeMfg/oIIgj+3pripCdphPD7PU4iVSsx7MHt2dPIc2+elqeUr12u3VbN9rPQpL/Wf1jxKI62cu
	QRbO9JP6At4nLRD7q7o/apbfCHB/HFX84NCp59cdMjxIBH22cYcv+eU8B6l9WzpMfU+lzubDcRh
	HOjq3cbb/1rSdQyahsBrrdGLkUwD9Ytoqwps1hnI7P9bho9VYTs70xUSSd1bKY8M9kTVV5n+3bY
	9cNMfUF/1QcDGlaY51gcRLw5N46lEp6e3yk4XRH86c7gCGF3MypJxKAbNz3rHcPpXSvkBROmJfP
	9/5qOVIWu9iMFSQ6cjNss1kZ2718P3EsJYYFlPk5TEzh2j9BuJ0z5VkmYbAwe8Mqqrx1Vp0BnQa
	l21IFd+D7rrgRQHy+/0Ua+LrDfjkwhahELsJdlFyufxh7ZyC+ZavhYU=
X-Received: by 2002:a05:622a:c15:b0:532:af50:8d7d with SMTP id d75a77b69052e-55d769f2c23mr100648981cf.33.1795253464620;
        Sat, 21 Nov 2026 01:31:04 -0800 (PST)
Received: from [172.17.0.2] (ec2-18-233-87-154.compute-1.amazonaws.com. [18.233.87.154])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e2d1sm45243101cf.14.2026.11.21.01.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 01:31:04 -0800 (PST)
Message-ID: <6b0164d8.2aef856b.376868.16f9@mx.google.com>
Date: Sat, 21 Nov 2026 01:31:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2998441576734734627=="
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
Subject: RE: Bluetooth: SMP: Avoid stale pairing key reads
In-Reply-To: <pm-bluetooth-objects-candidate-0132-v9-b93d60723e48169ee3ae-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0132-v9-b93d60723e48169ee3ae-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2998441576734734627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217941/

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.60 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      20.45 seconds
CheckAllWarning               PASS      23.43 seconds
CheckSparse                   PASS      24.73 seconds
BuildKernel32                 PASS      20.39 seconds
CheckKernelLLVM               PASS      21.77 seconds
TestRunnerSetup               PASS      481.22 seconds
TestRunner_smp-tester         PASS      5.55 seconds
IncrementalBuild              PASS      21.11 seconds



https://github.com/bluez/bluetooth-next/pull/1172

---
Regards,
Linux Bluetooth


--===============2998441576734734627==--
