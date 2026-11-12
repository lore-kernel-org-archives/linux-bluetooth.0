Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443373;
	b=30O4KNdmjY9gAzIQGxeR6C6zIVcPkW9l7+pgZCtulzdVDxNCgBTS8h73p/8PRRFVSsjQ
	 s4vzLgNmg64Zrmw0M/TMEP/8trLjyDPxYN+sBL+G2NjMF0XcGbgwB5zX6chbMJORSMVRN
	 eIahi3MGPNwcm7zP+AIaBk6+TpdbhVDa7Z+bmot7w1PuDU3v2UIJzE6nxm5DcrkWfAjSG
	 wIlMvRsnXvQAuLx+vWFq3m528s9PsTyq05mRpDKGF9DbBCcK9FMR0EfHjT+uwb3LqC7/7
	 z5fQqGhBaphFti7fJidQGaudVCxu6o1zYI2zMUNsRUEj9FWbtfayt+9Gpw6Oq4NGhdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6vNiiu+jPKTULSoJoPvjni+w13kVarHIPalrkMSuTVg=;
	b=pBU/RlWQCXn4pccVW5tgRQCywJLQ3lR9NPRjae9CzZOcsfI4V10618ciWNSaglqJLYZm
	 V6qwGlaDxzTMI1snfoPKbt6iJMNqE4FWBytDfT/LrKni6QGiCv+miI2P/0s8SxM+QoU1Y
	 H2aP1pbsRin0Rbo/04vy2pxJcJy3vdUQ2TY29PyKfAT3JxDKCAIg220t9HcQneZQFG9No
	 NMYF6o2+kz0JzbuxBgSTjdK9daZ6E4SSdGE3jRzFgGrRSmRaDgPbCHFvN1X910ITvHYKd
	 tNAgQv9G93t8R/QKuAu6spe50DVvGydMGWISHm2UK2KkBhOsknuzeAMWpnhu2mpBBkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EdX4VIuG;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA60606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 00:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EA60606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EdX4VIuG
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so6703685eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443372; x=1795048172; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6vNiiu+jPKTULSoJoPvjni+w13kVarHIPalrkMSuTVg=;
        b=EdX4VIuGowOfCRuIF1BovIt5QjvQAf+1oVrpySG8VxIxaRKfPatHzv78wDMO9El6F9
         spKpKcTmcAvslvyAXWcwj/QiJzZ4/vrSx6RBB0xjl/6RTZzsEJGKyo0O+h0rM3MEjyR+
         a72EZVdtxwRH1/70Y5TGqMkYLhBiq2D6t/CJXeQ2fQIdr0+J6xrsj+cGyYRmdyuWgRU0
         J/KWEfrBeHUC8mTQm3L/EsLGpQzYc5qOWFyG2vbtUQsGTDoEyyULcbB0Wmu80eUNZWhc
         uMf7WFxqo4b/8ufN0AyqEjKrnc4lvOcdu6rhw5uLi1eW0rom+s/SZoXYCuxPeki6WeGg
         FSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443372; x=1795048172;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6vNiiu+jPKTULSoJoPvjni+w13kVarHIPalrkMSuTVg=;
        b=ifSJf5YkELWJP702/sT4CK18wSgKyxTK4DMhWN/BShvPmX3Lx9gKH2jY4XzfCjdNGV
         Bdt2wnNhNixa6rfKrDEumaiguZ8pnhmtBDkHr8jT1nGxuGSZZl6xFgZmol8rCsJ+Z83o
         45xrLY9oQbHAKj3QXgniReEC7ujrrbIEnFtRB+blfhpuqdDn3FAbA0BKo5SSjeC9FtIZ
         2bMj4xFnvcdnIDbPXWD99PZcVMzrmvQAgsfYAZlIzwy2aaHRga2+83CF8HsjLl1xxONr
         NXUYDmKS4CmuQTeWOMGwtYsy43W0XrI9iaaW607sH+o9Z9ofOA/b7zbLLF7yDmdVdohc
         unPA==
X-Gm-Message-State: APuU4Z9qW5wXKWmQ5Fj30c0neDTphdzUezjb2vJ3b+mLs7Tjgk1Xro20
	bSiQ+p3J/4jF74giJcP49W6Ihxm1Gk64Vh99An9aGg5D73QHD+FIDlkANDkO+Q==
X-Gm-Gg: AYBFou1/XUGmkIwpvEFwXURptq0wYDCKr/IEGWjSoolznpjFEw9NNiXxz1yrbjzDMrw
	l1kERyNzHZXCJBpGG7R8jRIG8SCULBD40azAODOhoWA3yxOJPFuzrir7YTnoGL7eXsXz9jZZMtU
	KlH7DcPUxqAXmrz3/QsXHlIsNtA6zCxU+6LDZwORcoYqRyKFe4v+r1OtklVu+uiw9++YZf1LYDy
	zLzDWNORwWyEY1NVhmN3x5Ftaz9BVODI2LqI/POY0jOen0/FT7PJYpSa4cwdqSL7wLSaOgDs2Ho
	S2NYFVyR4riYDEum9oA45cNyw9axLNdPGPwec4kWMn2+GprtxHCjkZWxSaVRCug8UyRVc8Gjku8
	naSTcEGh4eSZsihFZMnvmQEGRt9lZje6cmIqoda74NdKlVGbGF+qIsbLg7Wo/7pO73U12Uuqao+
	UpWglyrDGaitLDN9x+X8VXAf2E/nUf8/rfgNXL3gnUBADodcVHYJK38+5ai0uq2DpUizP1hXriU
	y6QIOO9LmFQwy84IqGxfSA3RNBPQru52lr6U1LXF1IC4Wouix4nlXo1hAo=
X-Received: by 2002:a05:7301:2329:b0:358:3426:d601 with SMTP id 5a478bee46e88-3768366a41amr4055716eec.2.1794443372231;
        Wed, 11 Nov 2026 16:29:32 -0800 (PST)
Received: from [172.17.0.2] ([20.169.93.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm18302977eec.9.2026.11.11.16.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:29:31 -0800 (PST)
Message-ID: <6af5086b.afff5b00.2aa0c8.9b05@mx.google.com>
Date: Wed, 11 Nov 2026 16:29:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6305857928417410623=="
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
To: linux-bluetooth@vger.kernel.org, info@jwillmer.de
Subject: RE: Bluetooth: btusb: Wait for setup to finish before system sleep
In-Reply-To: <VE1PR08MB5247BE2C05F27B1A2675FA25D5712@VE1PR08MB5247.eurprd08.prod.outlook.com>
References: <VE1PR08MB5247BE2C05F27B1A2675FA25D5712@VE1PR08MB5247.eurprd08.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6305857928417410623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208822/

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.84 seconds
GitLint                       FAIL      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.38 seconds
CheckAllWarning               PASS      27.69 seconds
CheckSparse                   PASS      29.20 seconds
BuildKernel32                 PASS      24.21 seconds
CheckKernelLLVM               PASS      25.17 seconds
TestRunnerSetup               PASS      566.29 seconds
IncrementalBuild              PASS      23.29 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Wait for setup to finish before system sleep

41: B2 Line has trailing whitespace: "    "
45: B2 Line has trailing whitespace: "    "
49: B2 Line has trailing whitespace: "    "
55: B2 Line has trailing whitespace: "    "
59: B2 Line has trailing whitespace: "    "
63: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/1117

---
Regards,
Linux Bluetooth


--===============6305857928417410623==--
