Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25C35BDAD
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145580; cv=none; b=ldkyDWpl668iCAlBxGfEFvGCz7mfKbk1mr4K1tGGiVUefy3V8yY7R2Bnu921JSDC7U/EanGiyG8rhSmSmJ7lZVfOtwPTXXsn7m/DWmGPeb6WVmdn6VC4nppi3v7SDqQ+kP/fxGoqC8KsoNOwd15bxl/D54dwgWS1gUotuP4yXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145580; c=relaxed/simple;
	bh=9OxOfADjrKjPuCvJNY5JbEdB2ElLaggIKysD5bNGbl0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sL7VJpak/0a49Ptjp58fOFQzPmcK3HiaRr0ptwDcEylE8R3VEv6+DdNopl2i+XHazZXBbaccNEzVVQ9to3hyPSDxtjMY1mw+TBDKkdMWfUOxDH74V6PS3zQHUVn8PnhRM7wthzpO9C5q41b0xQeUdmyH1OPCadoWE4hLdIyyOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y66BTEag; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y66BTEag"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so90637985ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761145578; x=1761750378; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=srn997ZmZfRV4KDMw3rbzZpz3NI8LDrzk3oUzIMx9Bc=;
        b=Y66BTEag6dsdvqk3ywyiYxr7UaYEz+gi0WOkRwDEDDL8UkpoxNbMyuAreulAZqi40v
         BkUFBRZmonR382DCtzgHmtwFU/oXL7TugmCHSAE1SgcCfSQ3Z/IQoCGdwuS0MElUCEp2
         oCKhpyq75WqinYQvnBT1DZJOzwcBldGh9PkXK0Gfd5+U4Y3fLgjRNICGAbmYMxHm/cLh
         U5wSFvQGCtfZrke24rZRtV7fpOviSJ8zZ7/WCfdwPGTxiluFnTXo2jZOfEt3je6LA8ji
         nhuHSyZknTVmJ8xSCC4m8xdw92CFaRHJe+Kr9SSNizVv6Go66hy6l4e6qj7sGRzGmBDe
         gN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145578; x=1761750378;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srn997ZmZfRV4KDMw3rbzZpz3NI8LDrzk3oUzIMx9Bc=;
        b=KKPtI3I2HDBhpM2wNMKAX6FOFZ618bEn3ULIsQh4DZVxB5UFa1SyqpvA51oH7qjfn8
         vbq9ErbRbqk+n1MCUQT1eR1ljF8VDajJwqQLUEuyW1zPXIXT6Hmzcl8sNpVCDbU6pPef
         QPOQstXNRpARyitfmeG9B3GBlMx+ppaej0U7Vfbi+tQacLxMkyqgobkR5aathU9dqTGZ
         8UEIoapPM6an96mFTMvvk/KIvHekmNgNINBJTyjbU7pu20+OfPBGbieV4v+n5N3nOK+e
         CKY0RL6UaGc5FAa5vtXYEzVLEdZD0ONEAEl9R/lO7vfnoq7OfmmlFQEJZ/DjnNZ16QDD
         3piQ==
X-Gm-Message-State: AOJu0YwJZLElhg3m+iDud6igbodXy9Fgpw14wuNYDUVcSsIuS9fkfo3i
	kCT3J9kpvEPTh+hhSX4rDrdjPSp9VEKefGxhcDXVSKUS/1Wh7KoxbKIQIP3Ltw==
X-Gm-Gg: ASbGncsxOUHw7dEsgaI9OXvoWUbRDIGd40pLSH938XfhPkROrCvGETQEixMlAd3nkEp
	+NtUGG5+Tk0SgAafFMo4sYMX1qCN2aJ1nBXZwrriAE/dA/Q/66NW/vuCUvNHbX6T3UWaBgO5ufN
	Wwdd575i2CEWBXCcqqxeQY40wR4aWg3bHSSKlQMykCMHO+ukEHC2C/ndG09y2BMIKxT+zXGGyGP
	1dm5gK0pfde4Iu7MXZ0w9WM4S9EgYc2hKS7NMd8d34IkPyfRI9Mkr4QIJOUzBApFOWGzEkfciZz
	GbAU+aA3vT9h8XnTdzfI4ExeGHyXcEzAnHNHmvjEfkOJOOiv7Y+PtXLRyE8eVKqm3TUS2kM5zFM
	nHXUZ6J0r2d2aMaC8+WgYHNMrOC7aCb4VMGSN2su3G9jGAudOiTcE5HefG0vWweU0DvMTkFZLCV
	ng5W9byS87UQWgZ4g=
X-Google-Smtp-Source: AGHT+IFZMk7/UIvZVf1Br4yBUy3NvM34iGnmT7Mpplfr7hlw359Z+uMvo6B4+MThgGVzGvNEunCikQ==
X-Received: by 2002:a17:902:ce07:b0:290:a3b9:d4c7 with SMTP id d9443c01a7336-290ca121944mr260703405ad.30.1761145577211;
        Wed, 22 Oct 2025 08:06:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.41.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2c2sm141440365ad.79.2025.10.22.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:06:16 -0700 (PDT)
Message-ID: <68f8f2e8.170a0220.c7830.19f0@mx.google.com>
Date: Wed, 22 Oct 2025 08:06:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1205414755912539089=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] ioctl-tester: Fix handle value
In-Reply-To: <20251022133814.1404453-1-luiz.dentz@gmail.com>
References: <20251022133814.1404453-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1205414755912539089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1014533

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      2846.49 seconds
MakeCheck                     PASS      20.57 seconds
MakeDistcheck                 PASS      189.78 seconds
CheckValgrind                 PASS      241.87 seconds
CheckSmatch                   PASS      313.59 seconds
bluezmakeextell               PASS      130.81 seconds
IncrementalBuild              PENDING   0.43 seconds
ScanBuild                     PASS      961.75 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1205414755912539089==--
