Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C914D719
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805002; cv=none; b=X8RkN1Mz7ENW0BiuTiHVrnh+E6ahlH425BTtUUZjtH1QVEFToZc6I+qOgIJLOgmQaokl6Kpao0DBNpfNdEzmQ8iK/By9FgdtpZnLWEos0wTflntBlEJhSbERSjYJkHvAHnLEgwFnJbJMo2RQu3H47dZGJ0xIEHhYy+85lYBebF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805002; c=relaxed/simple;
	bh=mLW+O/JXMnS1aFNHfXTcPDC5XxZqSkj4z40yIBYP9ck=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HCKL2OQ/biKRnKo1SAygcyalErDvrYR3Pu08GXlShVEUAJFVUbLV696ROnIzHZvX0vz8Y40Cmv+lWaY67nvSV6GNEX8ngQVvq39WcNc5Q9uSVJOLcmFH1A0M+1bR15vAuig89X4sitSsZ+IUdFkwgjWMC6kzYp1hsjr3ZnX8BAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ftes0aKg; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ftes0aKg"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-795fb13b256so67753385a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718804999; x=1719409799; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h9GdCelu/NZ6A+JGLkgh+9izq/Q8GzNmeaQ7oUPBvtc=;
        b=Ftes0aKg4pm1/ds9BFSIVg07wmOy7NL4mqPkCsKdrv6vuYFCD6lak718ILc5u9457a
         uCZSf+v9p+IeAgfEfZ4HTR4g/fBGQzR7Qw9psUXo3P70uFz33sAUOmItWZKhT+n3cpDq
         FctjAx/j6MOzttqMmjWvkII5A5NQqaMoUwX7Sl19Ms0pG90cPDM4OYb3Kb9VuPEM2Scy
         27A4Bff1R2HOo/Mg5ViebQGklUjQ6BDw2jnvv1PZ1XRobMb9sHlqntO9Idz1mSpAD+Dw
         otRZI5FirGx+4rCAnakwKBnecMNtN8M8aJksRdGP5/F9niN8wcs8iDp/0qo7i2z9Xhqt
         66DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718804999; x=1719409799;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9GdCelu/NZ6A+JGLkgh+9izq/Q8GzNmeaQ7oUPBvtc=;
        b=btDNq+GpF81bUGuySLK8OaHPLi3uHKKH3juqUhR3w7ATDZlxJyDuqrTmsEBRqidnd/
         TOLqeLF1bfqN0l1RnfEaCZDwAWFza/jqaX9kVcDMmtY5YV5E8q4WhJCfRJSp2Kk1tzH3
         jAB4DA617b7ILrLFwQruQoGPlmLErXsAKdhjNDUBnSXnPkMILDYM6ARpDs+rZ+XXSLeI
         ZaEwgtgElKODL78NQcBIVqohHiPxF8r7WrkE7zNpTPAg7XMEECsYM13gqejmbEacyuOO
         yaXrqD28//+C3qTS9LtXm6U5e8zw/rvxRD/vvjsDiBg06qz6o+9FibsKkeBdbFn6Dv2a
         h4Sg==
X-Gm-Message-State: AOJu0YwCNyL2dLMA0co6HqQZn9EPM91d+1gqRUr8qssGMWXWrpnVzeEe
	SHuJw7WXCSb+VdKJjfGKrmmvEORKjUYagqjXzGfOFFbOd44La7L2upKkdg==
X-Google-Smtp-Source: AGHT+IHIwj7pU8W6+Muf5FRc8jparmM0huO92MjohmffVCZofryFCc0xwx5NDy2pGzoE8bMyJy5iog==
X-Received: by 2002:a05:620a:178e:b0:794:abaa:5fcb with SMTP id af79cd13be357-79ba76b56c3mr903603585a.2.1718804999343;
        Wed, 19 Jun 2024 06:49:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe40512sm609771085a.105.2024.06.19.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:49:59 -0700 (PDT)
Message-ID: <6672e207.050a0220.e8447.38c2@mx.google.com>
Date: Wed, 19 Jun 2024 06:49:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2955745893054866280=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: [RFC,BlueZ] doc: Add initial MediaSetup rst
In-Reply-To: <20240619113520.7617-1-iulia.tanasescu@nxp.com>
References: <20240619113520.7617-1-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2955745893054866280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=863411

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.70 seconds
BluezMake                     PASS      1578.93 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      177.76 seconds
CheckValgrind                 PASS      250.88 seconds
CheckSmatch                   PASS      353.95 seconds
bluezmakeextell               PASS      119.94 seconds
IncrementalBuild              PASS      1404.89 seconds
ScanBuild                     PASS      998.96 seconds



---
Regards,
Linux Bluetooth


--===============2955745893054866280==--
