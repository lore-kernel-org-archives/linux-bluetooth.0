Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963089;
	b=4+6euCF5PBJAsujNHGgDhSEq9gUrFlpsWLkgEZ3qYgFznNHp3WM8X3go5PBM9j4Wpp9q
	 U0QgPve5Xnx94bBJxaXyg87cdmdXZ5yxGhkTB+m/LoBsjFHn842KuP9wIZLTRfWfC7M/N
	 Pe8MctL5BS3qZDS+zTPgMu1NGaXoPx+YeSzKmnl5OT19MH0zQrqLXhLpllF0GyvMuE73N
	 oZRGYpabDay4Uw+86wz5CzHyoe8h96m8iNqfSHrfA8Vp7wO4dtVMm2ISxa+PXe45Ff46d
	 AQsPE6PQIIqCo1cWdLWNAhxk/XdmzzWk5KBpp0GsTgqdc8n0NE6MsUNASyFZLBtUhIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=p5rcHdzvYlXcHGU8jG0wQTXpF4tpuL2TL+Yp8hMJxLo=;
	b=WZIEibuRaWytkePJ0P5Ipdz3hWTgathfqvjMYjuB6lvljsg65fFRKZt7hizFsTYoHb8w
	 CIng558qqQdWU58y5cYOhWdGEsaCZpZ/7ZMBCqpcPrNzENkt5vLnQOM6l894+CDwTq6T3
	 05qAm6wWCl6Vh64f1x+Nl23SRckvYXq6yWpZqhQc7qDgCqjIxBeIzzzKD+zZCeO0KOjxQ
	 DWOuo7e0Nh8C2k9Hnw65U1ipGrPcLARWMZcbwPR4bh35hWm/QqvIsXIwQADVERm9SbD2I
	 1Fqx0ClvqxE9/a/6T+sSVtKxI4hcc9Axt+u/pOGtLOUWCv+K/BVZMg5Uynoa0/z5tnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbMMariK;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73295606A333
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 11:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73295606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbMMariK
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so706206c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793963088; x=1794567888; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p5rcHdzvYlXcHGU8jG0wQTXpF4tpuL2TL+Yp8hMJxLo=;
        b=SbMMariK9Qqtp66jm5VvGmILokjYL2VthNPf1pClaoEyveJGPgXDssvRCD9Jn8EC/K
         aXVR3BqV8uWije1FLRNuuNTlFy4vx51O0UOJJHRkdr/T8ombe4Oe4SbcLPtURNjoW1l7
         T/YNxchGnvHhRrVjR0YhN3WeOOmdvtgAQRpTRyH1pKgcTngUl/Br+eGVlBZlODQX1B8H
         A5/wqnaqNjNnQOOIFIn7jiNzpk2v9lQPcRT9iCHMJO/m+nIySiVPmxQXyA4Ly1t5MB7p
         bbZY5FUlkvh1LIGDQUnZYmytKF5r81MHDqNoz/d1Dv099iF2PtvDNFQBBfrEjqZN47eL
         QyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793963088; x=1794567888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p5rcHdzvYlXcHGU8jG0wQTXpF4tpuL2TL+Yp8hMJxLo=;
        b=MJGK+jdjS5/zBq+6d4T/Eby/zTHCG6f0uiCrC/kIpu8/NxFkESWsuSOhUsOP21E6aL
         DukTFISUbRUyIZvk1uvHAxyZMO4AOTJQ/xWkM/uPAHAb6xckAAP6DfKEsdpnevbHXtEG
         NmwOiJ9Cp1ZBLGqY1MT48kQLrlO2L3QfnGiaB6G6bNGHr8plGclhUtp4VB0NjTyU+AlC
         jit5ngMR8SHXv9xOWfZI1NvV069pRgUU2zWFN6ImEUl5EIBmHozdHX31qYPrMx+0fy/n
         8nEpJ8ZNDWvnPHe11zjD513cAW/ibhxNv2BtzLSO1jf+L34VM6ift5kzhkuyorOFlOfe
         STdg==
X-Gm-Message-State: APuU4Z+vDIwNylKc/96FekYOE82R8LwCYqO1EXFnbGt5ZCIJEBQTWnWN
	fwUl9sZ32rIn8SQizhRtmHnEU50OtcACE7JhGK0m5anQx+k7gCNEGmDIjk3/dw==
X-Gm-Gg: AYBFou2jBzfe7EqqSSaGQrWSUtUKyTK0MHlgggClE2RJhItnA9cuFm3ySlNfHBnaaqF
	/Jppq8bTBGtdMQzrMPLY0tJ/dFsGzP5lkKQZF8gL5JBFl2S1Fh0gNtVEjA4GZ87OYFICAfchYJy
	aNR8ZpsFj8AZS+gs5+FNFanPk+5n1yAAYJqoO+0TR3bcalA++N5Eoblq5wDNfFrmxh4ca5NyoVj
	cKgZKe/inC2eoTEGIIls3Grz+FWMpY5FloqB6c0kzOq5tg3Fyy8UdkRbiJTYilLOvaaCJjy6nT5
	ZCt/+t+ld06gd3ivhHHA9hCa87AUEE0Lhf1dsd2chIKkmyoMTLa8WFNtD1QAWJZ2tnR/SAM3eyc
	oJ7O+EDaQafmEjL5uBqB9p8CIUSdKekLSmt7acz82xFClHfrX2KXl/Utg7DkfIXRfoQC3Zgjgek
	7Q2remNZk5vqFJPyU45EltkNx16LpCxZtbj5tsJ8Po9PyzxhKS0pTtIl7Wbp1WHNJkbsmGzU11e
	0QP+S+FU35QWnbjkx4UDTq8au9YlwZm5sMPgvYJ14fG15AQd8FU2pygFd01pw==
X-Received: by 2002:a05:7022:ef07:b0:143:2701:9198 with SMTP id a92af1059eb24-1b25d34a7ffmr2992064c88.36.1793963088178;
        Fri, 06 Nov 2026 03:04:48 -0800 (PST)
Received: from [172.17.0.2] ([52.225.97.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm4894940c88.7.2026.11.06.03.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:04:47 -0800 (PST)
Message-ID: <6aedb44f.bdce4de1.179353.c4a6@mx.google.com>
Date: Fri, 06 Nov 2026 03:04:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3460135077849090690=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: shared/timeout: Keep callback data alive during removal
In-Reply-To: <20261106042339.811655-1-cochcoder@proton.me>
References: <20261106042339.811655-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3460135077849090690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203742/

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      20.57 seconds
BluezMake                     PASS      313.57 seconds
MakeCheck                     PASS      24.95 seconds
MakeDistcheck                 PASS      146.74 seconds
CheckValgrind                 PASS      349.87 seconds
CheckSmatch                   PASS      303.95 seconds
bluezmakeextell               PASS      102.86 seconds
TestFunctional                PASS      1193.44 seconds
IncrementalBuild              PASS      306.99 seconds
ScanBuild                     PASS      1186.81 seconds



https://github.com/bluez/bluez/pull/2769

---
Regards,
Linux Bluetooth


--===============3460135077849090690==--
