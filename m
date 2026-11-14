Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794689181;
	b=HfxrZsSbazLx3dLtDM1nAGIE5MBVCPPtgSMq/ly6OJ4VfTTc05U5xntT6GEj294lSSSn
	 MAmDjgm5UTrjkYY+uoLHfotnkhAV/Hjv88GgzWCU229+9KgctJOGVOAGLz1xwurwt+MFR
	 B5mwkNsUXVoorzl3c7+JWl9I9GPjRxyru5vjGraCdXoIlWt706w35IxVW3W3phkUlNJbg
	 gmvERzPG/VBWaynztyAx9A4ygmXwDmrtOAHrFIZfXT1kJoy+xGabaei/XeCLZnMJmV2Fs
	 RZhbrgbbvIOo70Pg4rVPpgMJv+i4N7Hi7kut0VvX9bHUwpslEQFtkk6GKt8HANuMG5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=oMah1SgZ5haArC3/0lXWWkKNBgcHdR+uZPrIsLr58rk=;
	b=IOntZGPHnhDBuC4nq3Jff/AoWkVaaAbgByElLKvAbkwaE8eQxLafdZh6xlzfh/kgA/7P
	 +3wC2IufrdCVW3L40pmBpUiBTCM6NCP8sXfWO+OPt+PPZzm77Kk6wZdBKl4duALGNVlaL
	 U1kevn6250RiDxsq95KHsT+GvKjoYnq/j8AKjaKeGxP+MVwj+yJU1Erjqo92LqGSzZ1c3
	 2t000fP2sH8dkfQPgkpXkRyR93d3beTT5TGSRz1wpLaoHXlzruobYHK5kzUkpR3v9uUeP
	 FJcTrsvmdSG4ew3MCzdN4dnCo2ZdJ8LrS5A97OHeQ3AxuLwfUkAFo1l2BX/0cSySQVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTdPf0PJ;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325D606A327
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 20:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6325D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTdPf0PJ
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-94961ed97bcso137493885a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 12:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794689180; x=1795293980; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oMah1SgZ5haArC3/0lXWWkKNBgcHdR+uZPrIsLr58rk=;
        b=wTdPf0PJ6d+AAvU42TXkPx7NgUxWQoGHqsX/l4DpEruTRnNGzT60f0CCiylM1fBjy8
         gootbUiQg8ogvU84gyGduFda4Wn42IF1gOSfsz2hYsRsc0qQtnKxHjhzmthLoJR5+o8a
         VdHT88dnDQmEMarC2EJFJ85F7J9UYdC6jV+0rbpU22teBdEZ1qcJWKd8j7rNSbCEuZRq
         jmnaHPkpCmAm0q+aPt6o7v/BPvE2zzrtk2PveTwvDD7x//vtysfwKCBuoQFMXGE9hAWZ
         NWQuwDvsoH39EvOsFJv9mMRWLJqtdH5NpHtlBkT9ayBzZRUstjtzocTAFwf6CfqA/woI
         nM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794689180; x=1795293980;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oMah1SgZ5haArC3/0lXWWkKNBgcHdR+uZPrIsLr58rk=;
        b=DtWQSNrJDJQU3mCEegQov8IphDg4YcG5PSNL9MXo7wmi8SRfcPZO2PpV+maKpQJY/z
         4g06D7umMGzRwpa29ZzZ1hwHQ4/7fogqgu5Z79FY8DTri3uApL+yYE0JS+F1/GjRciK2
         C5UlD63i2QeGN3a8x/mp4pTV+GwpYjy4Ta3MU5EnyaC/XLltRwBHcxYK/Gjatl9tWnqm
         1/gGv7FKaHIVP1fCQEybu4rKmj0u1UrJxTYQUe0VwifFp1/b3yKttu6gM0seGMZwYoPv
         n19uh+jBDTaJGAOnEgkrJaUgBZSIsKznkLY5zXhksW3g0mHY9vZGk1OjE9wGEitODiRQ
         YL0A==
X-Gm-Message-State: APuU4Z8xTiwCD/P2kZR1YEVoqJW9ypfORso7KeDZKsSCeH8pZn3hWt+7
	Gf5gae1VMbGQWh1cDTGzmFt6DpFbcF+hon49AGAAw8zuoOLCWTb3l+iQkVJ17Bim
X-Gm-Gg: AYBFou1rqRsGxTnm4FJBEhjbgCbScfAip2OdvyIRkQj+z+/ShNMmFCb5xUR9s2/Vuji
	SVN2Rye0KEJwe6DEOdxINP3cg0qhpQXtFvMIUB2HlRdXwKjhKkdmaMO3fsuvL1C92bi5ALkAlu0
	m9UOD6XhUm/TtSmopf6EAZETZ3buCciEdHeP+EPqhN9/Gai3g2VZaWrVzZXadljaPPq+O8o4FON
	uGdiqmz8xqbvgbfoiBbi30H2Oi1zogtnmw1PrER5XGzwbazmR0g+5bO+b3yacFQ1jPTqVQWHpbN
	XCSv+pB3Ht5FC7n10tSAAlBpkP6FK/frLehobdFCRan+od4YTFiQNONCYasgmN6cMJ65FUA7Mh0
	H9XdIbl8to1h67MryhzDWKQQotWnFcCrqn8+XPcIFYzUkdHETHxEK0w2uGmily0Xi5ENRhbPu3L
	OLFsLOZaUYp3kL9ttPKDL8AMG4UmtY/4hoS6A9Hp/kq6BRBo/Zubl1/sf/+c/CY3F8Z02bR7XEW
	GAZPScj/198SnG7rJPZ2HFw0ySPRSD+YoNtarpHjccHAEz9otj1CPD22qiy6Xo=
X-Received: by 2002:a05:620a:2619:b0:93f:2463:f784 with SMTP id af79cd13be357-9494bbdd0a4mr1093361585a.66.1794689180284;
        Sat, 14 Nov 2026 12:46:20 -0800 (PST)
Received: from [172.17.0.2] ([20.161.61.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c804f9esm483521585a.11.2026.11.14.12.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:46:19 -0800 (PST)
Message-ID: <6af8c89b.757e2132.f0e74.25ff@mx.google.com>
Date: Sat, 14 Nov 2026 12:46:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5892898297743356073=="
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
To: linux-bluetooth@vger.kernel.org, me@michaelmcallister.org
Subject: RE: [v2,1/4] Bluetooth: hci_serdev: Track whether the serial port is open
In-Reply-To: <179468159400.2456.9911175648212863511.wcn3950-poweroff-v2-1@michaelmcallister.org>
References: <179468159400.2456.9911175648212863511.wcn3950-poweroff-v2-1@michaelmcallister.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5892898297743356073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1211540/

---Test result---

Test Summary:
CheckPatch                    PASS      3.32 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      1.33 seconds
SubjectPrefix                 PASS      0.51 seconds
BuildKernel                   PASS      24.01 seconds
CheckAllWarning               PASS      27.63 seconds
CheckSparse                   PASS      30.16 seconds
BuildKernel32                 PASS      24.23 seconds
CheckKernelLLVM               PASS      24.51 seconds
TestRunnerSetup               PASS      556.91 seconds
IncrementalBuild              PASS      28.40 seconds



https://github.com/bluez/bluetooth-next/pull/1135

---
Regards,
Linux Bluetooth


--===============5892898297743356073==--
