Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540837;
	b=K+kyaNVp25FGjkWUCxsH49D4F5ZqTKqF3EOXPRDATg5BuXl3zB3lptLdnwLTIc3PDNqS
	 4+vqAcv6DN2NuGRDy6WjLtzeyRYBsglFRrEVoiTc987qOf4eEwUH9xXsiOfh4C8WoC+Lc
	 BQdRHEJ+2BGUaJXXlVCWKgdjEtGW8T2aVSJQFkgCT/efJgbLUDrA8emvveAKrUsiBD+0W
	 BHe0Ts0J6WvjrIAHeGWMGewl60evBY6+U2U1/QUjinmHlycwlLEYB7wACpgsg/fzODNZz
	 q3v3SLc1pxZJVfHZSS7QZMeSdr2kf/sQwLDbUYUmeIVx7wuGM0b0kg/6SHgs3bAKyJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=GnfRfnv1RtjRbpwvkjyqR1QZiHAsImHjhibbwx0NWQA=;
	b=xypn00aAHyJ3lrHkBdxM5UwFAJ7SRyBl0CgzNn6kYa9JIG3rh8aOtaNy9RYBqDJmSHcO
	 EMoLwN2FOEDrX/wSN+om79KPK1xMEIH8p3/XLeGJbrXFEZLmWMSzjpUYU2d5bT2WLmk2n
	 mtyiK9Pl0FDgHGrc+TP4s70Wu6B/Es1ITxZAP55WUVE9UJIiRrtjK5O+9JPJXrqqoRfXW
	 cz68dIodlES39yJIUEyHSt8UV6gs+QzttHPcNBtaoziSZB7BEIMfitX6FyLBe/8O3k+uD
	 Ohq5VC4qf9WQ8ju2EZEPXSiLkSeBRP56GNbOIiIw2qjIilNbdxBnAy61jBnEuyWN/rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORzzs5Qn;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35375606A321
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 03:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35375606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORzzs5Qn
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3791619605cso1159049eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 19:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794540836; x=1795145636; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GnfRfnv1RtjRbpwvkjyqR1QZiHAsImHjhibbwx0NWQA=;
        b=ORzzs5QnbCgTntGRYscpssAXN4MA2EsbCc8yokdtRCSjLWxxfYZM161jQX7vB6AeHM
         epmUo8vZ5KZLJrBIRH6gy7miDqauap2UBnuvlN3bcSdtE7gH7D3DeJsoBxuf5gRM89QF
         MLgrFJnSKHiXmORsneosNZTakourUFN6i7AsYacBTtVksWtvEdd7FP21z+z9DKGh0JzY
         GIjyDbuCdSVosPAvHuGFg5MyXToEwYWmq8IRrgRoM2k4Txx/Jw7nGbgOS6b8w5aaH1qg
         asYjdBRrE5AV870KhU6Md2iwWyA1WTrflLJ1ExQAkGY2FDcx9zn78ZnmCTwyQs0l0sia
         arQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794540836; x=1795145636;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GnfRfnv1RtjRbpwvkjyqR1QZiHAsImHjhibbwx0NWQA=;
        b=kX3kU43N5Nq4NNJl8KAnziUNqgd7EkfdJkN5nvBI7WdXvIKuSx0xJbPXnXKeZvxzvT
         l6Q0eSCgvdMASX4tHuXavO5Wac7o93wL+i1uatewyXjk96aKt5u0W3HV25QZWe+P3WUU
         AAXGdOU8+U29URRikd9uZwqQ2ufm94ZeYtNpHIoVkOnoLkNFx0xK3kFCjACx937tBGVF
         EtflhZR8zdiR2Wl0HKnRwg25DPwXAWtIR709u5U7+V8zaRY8bT9/172OuUcnirtV4qCp
         3XxTcDUiaKCi37nBav2jYgdsqJHqawgVHlikVy/Ca+iBFVh2CyY5DG5q5Jcw9xcHekUP
         uUSg==
X-Gm-Message-State: APuU4Z/ZUf8DsSznR1bMwW4+tgjI0rtwsMUjQ0/dQVNEh95xkknHf9Sf
	4pUKGDcT8e8HjNSl8GUgViCe3dR7wY5gNPqoAtUTVEm8BhgEYguPrdOiojdjBA==
X-Gm-Gg: AYBFou0WT68loOWMHKXywxN+NqKCl/oR5GoDnFW2+t6NsFBJMeysFKhFdMOHnfUBU5i
	bQgPqFCfaE/n45FL26rYeGfcp1MqC4uRuH1lwKZ2FRfhDeCVdYOjX5hNRVoP0OazYccrWk+8YCe
	0ngQjjXfVbrcyS69JHqB4fsMSg0mDTOGlzF3mLCDPW/24dZHFru4RvtIQrXlH831ipxqVlGbDmY
	3Qkv1MZrYjgGjrGthuefEi1jPhL1t79geWQXeIRKda/JKVwyOOAn8dTpbcPvYeIpRKx+LXP+n3P
	p84hLp1hevw5JEn3dAm35ZADEJRrsO8ZhPEj7U8jRXWeTXB3X00DuPpDF1xl3/3QNM+iCHGrsRG
	6Z9LflzXp3GRj2O2QXbVliIlQLgQa2Z9aqJDlt2bSyfsxnPz/PP8n8XqMnCuycKXUs5NOyCyqbo
	WDc0OrzkPPiSdA5UZMA+N7RswSQtS1tbGxCFIX6SwpWC6Wr9NDzl9IV3omCPh/preFMNl3USDVf
	MlmWflSYjx+W09Pl2OVKunSwDyMAKX9zm0L0lNkpA7DZL9hBzuCzabVqdjXugw=
X-Received: by 2002:a05:7300:6da8:b0:36f:14ef:ad08 with SMTP id 5a478bee46e88-37965abb5bbmr1387060eec.9.1794540836160;
        Thu, 12 Nov 2026 19:33:56 -0800 (PST)
Received: from [172.17.0.2] ([40.75.163.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm2809243eec.12.2026.11.12.19.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:33:55 -0800 (PST)
Message-ID: <6af68523.7736d04f.37fcfe.5d50@mx.google.com>
Date: Thu, 12 Nov 2026 19:33:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2582347914044002714=="
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
To: linux-bluetooth@vger.kernel.org, pvbozhko@salutedevices.com
Subject: RE: advertising: Fix double-free in client_free
In-Reply-To: <20261112170355.22011-2-pvbozhko@salutedevices.com>
References: <20261112170355.22011-2-pvbozhko@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2582347914044002714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1209793/

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      18.15 seconds
BluezMake                     PASS      272.18 seconds
CheckSmatch                   WARNING   250.94 seconds
bluezmakeextell               PASS      91.05 seconds
TestFunctional                PASS      1107.06 seconds
IncrementalBuild              PASS      279.60 seconds
ScanBuild                     PASS      960.47 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capability


https://github.com/bluez/bluez/pull/2816

---
Regards,
Linux Bluetooth


--===============2582347914044002714==--
