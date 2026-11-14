Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675639;
	b=JWpnBxf1UJEnuXalQmqqiqXIQosY+2Q520wydtiKSZCfpBraBPq/GQDy90lGz0N7IRdt
	 8igC2eSyUIpRpSs+qjvDtIAs9jiMg1LTYMGHb10aJm3XDKueADoPmxMhTOUGdTD73q6/p
	 Yc7019FFTV0k5rnJm+7x5sZArjA5IGZ3dkwKfZ/Xdc1VSe2ud45erH/uVNVh1T/5jmsm9
	 xLVQXZqGlmtc4kvCtmw4AsFV9H649CKQyZDnzHQQ9KXhf3W2d7ZEf7mH9eyzbfJrLadkg
	 ERWwrQVRw15jKUMzoDNzyUqqZn9rB74rMZtxvfwDG0gy/9DBjUSx7EevsoAxmGR/U/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=OjTQDDI8N0rYnclEu7zFG8y/MxXvR8XsR+8N1kFUpOA=;
	b=S8RJSU+OL2txgVS3ftllPViECEnxlEE9T/72ZraORYex2CfVJb3r+XwaYWDhGKb6kVim
	 YMXVCxcLBTG+whBT041Tqu5ILqzLGllblZ3HI2lBzVfp44x9didgtEPs2Ji/1hTcqUqBz
	 2G/fMghylF/XiAx+ui7CoyFYvsZ7Go1ykd/UmkbQKC/d2n5H35ap3+wni36tuNRfq/Q6e
	 KOkVH6GZZk42WIqI5pxLF2Hno8GasPS+IYela95eLxkh0GLMQ/vRAUBlMyjUgjdth3Kpk
	 iojrWdztlUW7YSPbxh/XQkY2eIgyU6R1SiRJ419Ew8zmRQbSHxqmCPXnT0ShIrjdoaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zE6cg5Sx;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E220606A329
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 17:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E220606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zE6cg5Sx
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f3c616c84so235242085a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794675638; x=1795280438; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OjTQDDI8N0rYnclEu7zFG8y/MxXvR8XsR+8N1kFUpOA=;
        b=zE6cg5SxcwXLWCySoOJlf9jhhYXy2ApawXtkazP3kltLIOpxlfcozyNXinuoLZH3f2
         x1hyr/MgMpdChDLduEn9ix2KgpG+n0EYpHeun3/TgCs4vN5oz72UxURFaOuziSQf+pmv
         j4xSI4tIHMDUr+vk1hADuKRusI4rKX2EEJKhswFV8RQLHZRtH+G1qPwc66vONqTuHWuk
         O0L3pBuz+NthZumn/i23rKpPu6MsPuu4g5+ds7OaF5E0Xss6eUUxt9ofc7P41PBxKooh
         qtef54Ly9+pGHvSc7xJEddl9Mn+XKLySZs6dI8WMA7cG9NZTE5uQU8ad70Pxe1BhiA8W
         kU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794675638; x=1795280438;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OjTQDDI8N0rYnclEu7zFG8y/MxXvR8XsR+8N1kFUpOA=;
        b=hupRk1wjodEQmHSROUJ5qHdYSKrb4Iv2zfnTs1UWNJQ/OjftqUpT/+Gq5L46MLWFp+
         hXkMITEhr1QaK9tTjMHyRiA/S3YX3xiaMh2qmFpEglwoIy0mpnblyrtNeAs76nD36QHj
         CQYYoQ3m8P/S8m+Jvu3/zJSa7/XO/2ZUyYfRht02PGiH6Xt4MW8BBVmuzBADyCBEVns2
         wc836ntX02aHDT8f7rkkpKIgvNSxyCHM8hhQRRi/8JhsWm0JXmWjUReSwUy3ST/SC2cl
         Vpi92R18DEpwTyOSFLBOn9mKrZ6WejJ+C6cSnPjuFWefEM7AsfkoHN80pk5Ky+1HMF7F
         1UyA==
X-Gm-Message-State: APuU4Z9gQvOVCXqBLCe3Jv1Jfaa6aUeMcUozX2JdrYD7GK3ul1v98uAn
	fRNlXvR/91NUd/MgELnNisrjr6D91d7WMSrnXhLLdxl2yGtX5rYYUAP/D/VkgCBE
X-Gm-Gg: AYBFou1AwYTdHZtpjjKofEdvn2NedbHAhST2YCeZANAFba4yegqRZHavPuSvNf0/O6v
	9GqaBe5Vz+W3eebjg2lsuRNAW0TDtoYWiFkvXAhGDMgpexKwZSGtHZdKd9SRG76MVqU+GPHxRpF
	3eeJnbg4qCSRu55DCvwgIyflrUZGit2bFudIzZl26tGhaSkewUhhihi59xm2hVZsSjS10tChmfo
	R9bEdrjffOuS6TjSrgGYqCkf0Y/yU3Pv6QwvAFs64QYRTDwOca6GDmB+9TupZ0eGFFFEG8S8pXJ
	FkgZzj5fLBMvbJfka6/2o5jtxAy1VUCfVV2b0x+B2W80RkzDM4VbRmd/o+Dsup80IilpGa4RDXM
	pHbRPz9Bj6zY88tRibWPOT5grHKIBzZ2h5VZkrIizrcWXkusnF82NFD8TqrTrCVSQonN1BKDm9d
	0K5sxwbwi6sgccee9jnAPdUlkoPU9wmeyhkSrIxI0+98a2C4TbYJUedEs4/PDJP98/Y9EoMVdBE
	8du+OxTUaxUICQ+9s4Nvzr4Y0b5L3O1kCJukdEAOyd+GXmSYdWllT7t9WAbuB8=
X-Received: by 2002:a05:620a:2987:b0:93f:2a56:2772 with SMTP id af79cd13be357-9494bcbc465mr985507985a.78.1794675638432;
        Sat, 14 Nov 2026 09:00:38 -0800 (PST)
Received: from [172.17.0.2] ([74.235.70.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c803ad1sm443379785a.12.2026.11.14.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 09:00:37 -0800 (PST)
Message-ID: <6af893b5.ced8aaa0.1c61c4.831a@mx.google.com>
Date: Sat, 14 Nov 2026 09:00:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5950773711115334900=="
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
To: linux-bluetooth@vger.kernel.org, nebkat@gmail.com
Subject: RE: [bluez] gatt-client: Fix not emitting MTU on reconnection
In-Reply-To: <20261114-gatt-client-mtu-reconnect-v1-1-a86edc1eb208@gmail.com>
References: <20261114-gatt-client-mtu-reconnect-v1-1-a86edc1eb208@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5950773711115334900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1211415/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       FAIL      0.35 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      312.39 seconds
CheckSmatch                   PASS      315.19 seconds
bluezmakeextell               PASS      101.22 seconds
TestFunctional                PASS      1191.12 seconds
IncrementalBuild              PASS      313.59 seconds
ScanBuild                     PASS      1185.74 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez] gatt-client: Fix not emitting MTU on reconnection

28: B2 Line has trailing whitespace: "--  "


https://github.com/bluez/bluez/pull/2827

---
Regards,
Linux Bluetooth


--===============5950773711115334900==--
