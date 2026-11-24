Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520307;
	b=brGfuBtbC+9gSAO9xphvx4YU6rpgfQLmVgw3I2fmB2vRiFfTMhoOFybhArfSCaMsh4tr
	 nxtfPpFuzgZ+iD61tDouHNCTIy9mPPrc7iQR9RjNVBlnBB2hwXRqdpJ8P4vG4kIB76sNn
	 /k177ervePSAcwh37B8FNuSgQUiH50tIc1gXiZg1q/nuENuR3gUZeUUimJBLEKcYxSlzx
	 TMtvTo08ZZCn3a8m4JG1o+4qhQ6qlWLg5cgW1U/Q+ez1pe4kDY/TO3TQJEpyhK9U1+BHU
	 mUCm0fmdfj7i1Cac4H06TVyoeB0FLY17Ca9/rrK9xf/L+gHTbh6905Jz/viC2GBTs2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=EJfYz4amTibJmCtXxsl4gLDpzMCdUt6f1ZxF6CJpVfs=;
	b=DuWLDZ49Fsg5D1ybBpWWwLD8wBifh2Q/FCeEplnnC2q/dU09/YnFVlL4CEAWsA9r1qzo
	 /nG15fQQuDPT5snpY6FwgGusTvRKaNIT3pTODcX5spw0O9kPdTgvLC3cRP1dGOWMh5jta
	 ddf7JA4adzjhFHEaIJVtOwEp3SduhaMTch3sOdHbS3LpdlUtCp89JIFtJ3ExnkSznYBl0
	 4ZqWwtR2pv927UIRBAdutcCoGaHVWmPr+SqOcLGze2dc7rnGAc8oxJrcJtbIhGT2cv0Xt
	 lI7csbyN70SBial+sYuvmkJlTinXtTnaz0yysJW9O4Iwoz27NV6XAYneyIa15HyaELw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U4IoHELA;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947B606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0947B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U4IoHELA
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so1177257c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795520306; x=1796125106; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EJfYz4amTibJmCtXxsl4gLDpzMCdUt6f1ZxF6CJpVfs=;
        b=U4IoHELA/l+iJ2nDlMVPwBs+Lrb9pju44kjZy1iFZA3TI4DAHmeK4x2vldJDNuMf2S
         GtOwiczjSX2x1KMe4tIQVtjrrVtuYucnaf9tEIMVwDfGjkpVcQA+33kUUrid83VUbVAi
         aU5NOPBxny91yL+pNji0g59G6L3O6HibRABx1GM8ZSuSFS6a1Qji6FxZu8E3fEuRL8mn
         rKetWQYCKuhLa++0PGsJtmDKej8luDRj9VDU9ZBgY8XgYY3O5FWpMeX29arWqIqfwUKj
         tfxaC/cHq1inrxiLVVT4oCRlqSxbvK3j7DPHWuSscfFg4ODn5A8Sz/KXG/Pi4ZxYfgSs
         HbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520306; x=1796125106;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EJfYz4amTibJmCtXxsl4gLDpzMCdUt6f1ZxF6CJpVfs=;
        b=xfO2EqvWbTr1b+MdaTAlxKrtaq5bam7AV4+OJ2vk2S1qTDGSCN6cnRLxu8tJFvxEOq
         VW1aOFlYE1L236UqAx/CIIna3LIbkLV+cdl5WA22lrXb823NPO2xv4mLT67EV8QDQucQ
         gJOpX/Fp4KTwomPImUvPfOqwglRtAM+Abzk+ORfJEVYLM0/BKq4MYDI7Oz+EHWPCzF7e
         WKdkVQQzv2ZTPUeY4ZicyW1yFmlnH5ajtFCwfXuTERZBtGWwSCrc3R7ZL9W4zfGsWgWk
         V3C0irPm6Tf6leLkgWNFIH5WCNoY7DkSxGx1qFWeKP8H9ZhQIfCF56ZBCDPR5uioZ7Zy
         dZmw==
X-Gm-Message-State: APuU4Z8l/Atr9TkFIzaCfeyF5mg+xcVVGKsnUeksOGg8vJ/ZcYc4S5qF
	GO35pmZae4zQr4Bn/nDhVHYqub3wX61IZSIRDDiMeihnQCTZyuyweBr6zRtyUQ==
X-Gm-Gg: AZFdTZdYmPJOy5hxTM9ma9+SkBzDRhWe0JIlrb82ySXwBe7siR6623XTN6pEci4l+0Z
	llyEOqX+7OHHO389YutXakIrsn/IP5bRXB9jNXC0Wm42cnl4cmcWx9kYJxUdewq3+966Av9NZaC
	1Aeq2/JQ7NJFl9iRgWtgLSDNSSfCec3Q2wh2WUmGZzikx7mHQdpkARQnYQ7taG62EQbcFTMDUWo
	WMmPZ2nWAX9jOCA4gQ79xBjnpKubcSVpCluKf68ANoajtOVZnUyKCT2HV5J6ByxQisKd9Ej+L3K
	3rmxGRQ5r+stlU5fIfJzG46Qvi/3P9V3ERAUWXPX2CdQUiZ2uVv16cTS7yO/QV+GBO0aiZpjFtk
	qie9XcmfInKhJQmKOq4v2caW4BmxcI6PTRODBVVfAbGtbuI/2d4i08AH7Ll5bWKdugcZoT85E1j
	05mqHLmzdGRbEIv68VlYOCs5LOc9SNZfhsTcIUxghCYlX/O+vMC12FmdEcStjkYzwRpY97E+E7b
	ERcBp6XQz+426zzJwDnyuk2yiB5KypdDduJn8XE4+Xt4DdqAGUUSESqE2YpAg==
X-Received: by 2002:a05:7022:3f0d:b0:1b5:58d:fd9b with SMTP id a92af1059eb24-1b5568f03b6mr15828362c88.31.1795520305926;
        Tue, 24 Nov 2026 03:38:25 -0800 (PST)
Received: from [172.17.0.2] ([4.249.23.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm34024954c88.15.2026.11.24.03.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:38:25 -0800 (PST)
Message-ID: <6b057731.8af4976c.1dde1b.b277@mx.google.com>
Date: Tue, 24 Nov 2026 03:38:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5780478473908871241=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: monitor: Add an OBEX protocol decoder to btmon
In-Reply-To: <20261124092248.207565-2-frederic.danis@collabora.com>
References: <20261124092248.207565-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5780478473908871241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220590/

---Test result---

Test Summary:
CheckPatch                    PASS      3.38 seconds
GitLint                       PASS      1.47 seconds
BuildEll                      PASS      18.77 seconds
BluezMake                     PASS      274.31 seconds
MakeCheck                     PASS      13.60 seconds
MakeDistcheck                 PASS      138.16 seconds
CheckValgrind                 PASS      331.04 seconds
CheckSmatch                   WARNING   246.73 seconds
bluezmakeextell               PASS      90.10 seconds
TestFunctional                PASS      1103.80 seconds
IncrementalBuild              PASS      325.79 seconds
ScanBuild                     PASS      969.37 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2293:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2894

---
Regards,
Linux Bluetooth


--===============5780478473908871241==--
