Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920371;
	b=DzYrHvj1AjNR9xxR4XR0YMwUKWfmwdC8ltxJhnDQNtsHajNV+CLKgcbs19lzUql82JKI
	 jfTQQ2cavQ7BZET6tXnxdQRhsaMsBrJfU7E42kNq2ubeWbdc+cXi3oF6y4E3fPLkuzgen
	 8tmwUVpkmv7ov9fMHDCXobzoAp7FDrCr9wpFA0xJzcauxtOWGodE4BDW3VsHBmHZzW3c/
	 MuYI/kRJVttPv83bflS33UHd1Dmp5QsjMDbmECZto+3VB7XQH0GgekHGM4k4nUcu/KDSs
	 jw7PhCjflPU0OR/ina+edKNRuO990WzjM7syRM/bmEjy4DSrr5zYMDnU6Egvh027q/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=E99CpdSmP8W1cfiBrS72zvBBIkZ5ZVeDTOshjXnbOQA=;
	b=VgFfGVbdWTPJNHlAmbaFrZgEjdbKfxpnwaJp45H3NIc5OM1F0VJOnbA7d9EoWinQo/Wh
	 KuHsnYj0RZMYkjYrWC1fsxXj1Mx2W0INhK3U7jdoKnhGrc2kDWagpdAl1/P+8/JRwTaD5
	 GtBeDkIieNMbcAmVVpfcKvKOqft1pcSCIl10bapJxBbBjGO7iDA3t0Yn8V/SUUKnvsabi
	 gyWVMiT2m15D2IFY3tnlYmUGSvTctj1dPfDQ+N/wEIiZyNGKZgzD7SfxlLocNef/+smA/
	 iAdc/Wp/GenbnbG+2bnqQrlGiLrWmRzji8yZz6w7a9MLyl0JYnqrOLE5JJq86FxIKSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="J3XyCFr/";
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DAB606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 23:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46DAB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3XyCFr/
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-486f013db83so797903fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 15:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793920370; x=1794525170; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E99CpdSmP8W1cfiBrS72zvBBIkZ5ZVeDTOshjXnbOQA=;
        b=J3XyCFr/kp9kmcL2T/aKQh9EGQ7zFoDZjc0JqWbn/B4PA1lSpnY73KDt/jT6NI7nAE
         1fH6ves10Cbr8mp2IROeXE5NvmSIFpT/aDJwnPRjdLpYOuf8Jdij/0/MNAHbaRuh/nJO
         wmMBPYztV2uzE8GmFdOaMrxW0m/bvMdsfc6/B3mnSyC2cZ582urtYVux5MZPaaP9qoNz
         CyU2OzBYa8YYWAQZwZ7XuRE8iC3KvGuLjvCPZkgDziCUvULUnzljc1VZKeWOYwYb6XX1
         kqFWpTBLhRvDkJlz1m+eDnQsonXp6ETZi8C4W74kJsrvZH9eOvKg9Edg8NZLBgulscxf
         pG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920370; x=1794525170;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E99CpdSmP8W1cfiBrS72zvBBIkZ5ZVeDTOshjXnbOQA=;
        b=YlcqklEOAADM+KQ5iQPo1Xho7QI1W7QQeLq/1/3LHn3pm8yX8smHGVfQodnD40BRyB
         vgSMPjOJ09IjNalcfKp4ZP9NHJbvsh0NIAU4PRL6CZSrKvSfXI2VA7RNHgMtcnSmfnnn
         j0nJXuk3u9XGK42cJyDutvI79QBHytbYdukWtIcbzW7DAZjpW2YFTviVK0e3idkt/GkS
         l6OtjfIPxTcf7zkK1CMfhZ+rhgc9KjjyjawoFmjRJlCgWpZ5MuJIsayVcMOyAO2LlfwQ
         b7g89PO/IUYUzK4p/DhsABxuG+EbNkEKI2zZeLET4qIPDJVartXVFsrZZv4It8ZtXqQy
         OZSw==
X-Gm-Message-State: APuU4Z/dq40yBBeiXfv6Kz6iuRulv2bbZ8rNXX7miXO6T21yFeycfala
	JOUAnXjp/yue6+mBZJchUeJvAx4rh7bRi4QWXyxPBnJwz/PQvtQwxRY5e3cm0A==
X-Gm-Gg: AYBFou2Mb6XAz2ud6ktml3ZpbCZi+qc8LKNwyqkHqBU9nTqij2EtzJTRacENOpIa3ax
	doHYR4FjAMsAjhIUYMFSlRAJATINjy8VM9wRPu7uBkRxXR7r8ZYp9JMus13vqRpOTaJkYIHxfOC
	ZvckBMl6B5fxyHW+p5coZzfcYWCN4s+p+G+todPVN3MRamTdkwoWGmviCBwhoznrVyutKCTvrdH
	5c2mZjevk2r0Rk49zxHPiVoZEXYhBzkR4fjE+xV9syUseowiezVrpk99AtMEv1OY2QGI3286/nV
	ruplba35E55Z+w9c4BnbEdxST/AweddjTXvkP7Osr21Md+Q00DT+c/fSLIfI50k4g+oaijnzAUK
	ldViGy//y1tWPh3f8tnq8pNOTOKZq6u6JrvfkSfuacRsZq5PqQnuo5JVVrjez7BXIuV27tQLNf4
	XiaRTYFJiFBdzXTv1pYgmYaKSI9pPO9s1UYr8v6bz/O+sU7motc0XtmMyksffxLF1limiszz0PX
	YWKyA2JJNLEOw5Fds84YizwhxsKNuc9wgltp6uNcJZ3PxbGLJQdvMKfBCYxOxGf
X-Received: by 2002:a05:6871:4391:b0:448:908d:27e0 with SMTP id 586e51a60fabf-4ad985a6063mr563266fac.4.1793920370119;
        Thu, 05 Nov 2026 15:12:50 -0800 (PST)
Received: from [172.17.0.2] ([172.202.171.82])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ad973fc034sm553845fac.2.2026.11.05.15.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:12:49 -0800 (PST)
Message-ID: <6aed0d71.051c5103.2b98cb.97a9@mx.google.com>
Date: Thu, 05 Nov 2026 15:12:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5722098817770671125=="
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
To: linux-bluetooth@vger.kernel.org, hex@freenixos.com
Subject: RE: Bluetooth: qca: Disable SoC debug logging for WCN3990
In-Reply-To: <20261105201952.1556185-1-hex@freenixos.com>
References: <20261105201952.1556185-1-hex@freenixos.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5722098817770671125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203508/

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.23 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      29.58 seconds
CheckAllWarning               PASS      33.34 seconds
CheckSparse                   PASS      35.53 seconds
BuildKernel32                 PASS      29.84 seconds
CheckKernelLLVM               PASS      30.21 seconds
TestRunnerSetup               PASS      701.08 seconds
IncrementalBuild              PASS      36.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: qca: Disable SoC debug logging for WCN3990

26: B2 Line has trailing whitespace: "    "
38: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/1073

---
Regards,
Linux Bluetooth


--===============5722098817770671125==--
