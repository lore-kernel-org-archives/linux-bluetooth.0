Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962064;
	b=Sa0cV2SSnMi58yQrGh3G6dziFt7BXaXoIw8PPOU5yLO0yHwukuBpAbq7kSxmcFIcNlR9
	 94M1iuisQo1W5m+CAquheclZr1gDUy+IwTj5b4jyNSJrh8BT9jtnyFwA5z+oMAXcM+Gd2
	 Hla231uE5Tgx225PdRMXPMAT4EKf2DfSvwgbacP0NsjsFK9boQuEeSVOt9CbqYWFBZJD0
	 SdBSFXf60siCc4Res9GqSW1k170+V27/QikcH/VVQUF4ytkLjw317KoTjufkSxoQttraa
	 KnLyhdwOe96l255Dha7yZOoeXg0vIDPJ+j5ZWuDRlmRyg9FADPVMFyTej4pQNBhRGxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=r9FJAKzgi31BRGshSame/MCEKjjW5/onPS1Abw5QLKw=;
	b=pPViPmF8pk1REoHTLE2EZ9gdTrz93BkGAJL5IRbnYEvwxIDFyQ7xj3w4zZawez7Lrv80
	 Hq4VQ0ATB6x3B0Xf0GZ/f6Cnljm0mU/Gac0wDBS4iXOVtmqzb1dQNN5SqKgzJTLaI5Cww
	 2tulr4J10aJKXCql1/cKI91KKZgEqc2rBlITP9vj3wxSRl8ACI0hmdfH378cne15LVjTG
	 le9TgFAC0b8fCoQhdkezarO8zgdO38xWXMMefbkbgU2U10YBejSE9pBnqbtsBVTINLwlk
	 Rc/IYdHlJ2ZwFvdDcjM1Ka4QdzMYHJeLKE8tAgIB8VfGM65scLoxlRf/lIqlhw8LLsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vQ55FeUl;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226D606EE92
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 10:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C226D606EE92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vQ55FeUl
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36f8cdd30beso276932eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 02:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793962063; x=1794566863; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r9FJAKzgi31BRGshSame/MCEKjjW5/onPS1Abw5QLKw=;
        b=vQ55FeUlNH80mZO/YtzuJmXeKtUXminS5V1J+0NohNuVFxk7mJQxxClgUszz1MgD/P
         tSrl5R1KzueSPruTCQYhg4FslSXg1D/A45RdR9OpGeSuamTam6Zrp6RRZHBJF0rmc7Gb
         jD4cA5EQotTVnObkFJM3SyRZ5YdsoKfvS+DIZZKVAQd1fWWpfvDjKm+IFRqQVUDw3wN2
         OzjIE9dR/cPXe0wzY7mtRWPbSMvOGsAzgjWZK5RdXgwxK3uW91LZVRUgIryjwa/mmskG
         3k3zWqTSzvwomjX/8uvOvY54FgekP4ZXGR9VMPSIkMVkJEOcgDcgPBg5ZkT5+OPmsooq
         N8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962063; x=1794566863;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r9FJAKzgi31BRGshSame/MCEKjjW5/onPS1Abw5QLKw=;
        b=ZaSnXeC0Ry9Y8VT0ZbjOkTbem2SOHXUvLEj1mhUWrY9dbdyTQp+x5+Oy3elhOnkq6z
         kvuZUOFPwIqxx1awrGnGVDuZE40Y3+wBiqOHC8m8zHg9gJKL9XbHB6VLK4nbSHFw587Z
         V4Nn43Sw5xQj/KMECBd6inrq7qt5jYOpGJ2kKyhllcaiMdz9w1chySD1JBqhH+lv6nzP
         VYb1WmqvewaK7OHY5e7t9vOys9CnYVuIcZIEvp/+9X3oVCaWjn2/PdreWhNBmN5GNSKT
         7FGkl69TUT8/f0jhdODOm4XclNpPA6y8fjIp8H6b5TDFZJMqu7fmVC4wln4oXW2BzLU3
         Ax5A==
X-Gm-Message-State: APuU4Z9NWgYKJArnJWxPa/ptOwgUTeZXTRxhu7MgnLphOYzA5p8wAuyU
	/G+ffnjGP7kTWmBR7eZNWVXV/QP4HW0PCaOsFVT34kZxUMnEecVQONXNeyBWow==
X-Gm-Gg: AYBFou0Lpg1tYZ0m2Z4I+kOaDc8vTDO+pJnwO9SiDq23RIpWdgApZaN59I3odC6Gsz9
	42z1eSONjK1abQjpV087Ny59voV31ILDSuM+uphCgkOi9AufaDdSj44OY5Nu0YyiVr0RbtaDzrq
	lOJiHl6o39x18YIUm0Qq6k6LaBfmV6TuEAp7L/O1ARMncs/HM5/wev2V0IWQyJOSQBhvVVExBpJ
	Zk2rcTdVMvSH04vY79VDMXop20qPrpjI9vCyUVmGnOYi6HjJ6vxruf+eJgJTRgNfuPMAJGJQEw0
	w/QkGYedt2wlCUh/Da7M4nEUe5fKJzLEs6V/QKxTOdlIDGUTDtQF44XOj0rVCp2TXrhgNTCMIFL
	mOUvnHjyJXKI4JIPelm4dpOVvSnjSPp0iU4JnEpHWwPLu1im+0BY5AATXk+/IzS50YMA8MC0nFj
	XmFgCgdFViX68h+OtZt9dPs085RlImxGhQVMPK+7yETq123lAx2vldOWN2t5pajcJEyJ/S2gA6x
	nHv1rHSMCy+N6mgxcEdRXVwqwf6wJsABDaA61YPkaNm8WLXHCEOZLFXe0xEMeko
X-Received: by 2002:a05:693c:66cc:20b0:351:2958:1740 with SMTP id 5a478bee46e88-36f778f4a83mr2748543eec.37.1793962062771;
        Fri, 06 Nov 2026 02:47:42 -0800 (PST)
Received: from [172.17.0.2] ([172.215.218.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm11967333eec.3.2026.11.06.02.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:47:41 -0800 (PST)
Message-ID: <6aedb04d.a5690e37.58594.aa73@mx.google.com>
Date: Fri, 06 Nov 2026 02:47:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4880821798915354214=="
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
To: linux-bluetooth@vger.kernel.org, kaichuan.hsieh@canonical.com
Subject: RE: mpris-proxy: Fix possible crash on OBEX transfer
In-Reply-To: <20261106080515.2296-2-kaichuan.hsieh@canonical.com>
References: <20261106080515.2296-2-kaichuan.hsieh@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4880821798915354214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203891/

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      18.18 seconds
BluezMake                     PASS      273.85 seconds
CheckSmatch                   PASS      239.94 seconds
bluezmakeextell               PASS      89.60 seconds
TestFunctional                PASS      1071.05 seconds
IncrementalBuild              PASS      270.98 seconds
ScanBuild                     PASS      960.31 seconds



https://github.com/bluez/bluez/pull/2770

---
Regards,
Linux Bluetooth


--===============4880821798915354214==--
