Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC948DF53
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Dec 2023 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOK4MPgj"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-35fe456b94cso11691835ab.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Dec 2023 13:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703452307; x=1704057107; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5tvRFmlXtj9goxnpYQWLbG68v4f47f8rANaAP6Stjcg=;
        b=YOK4MPgjE+wyTKC2TGBEwgGf8rZgAmE3GvmzjSKbT3WD1MnwZhtwuEMSn42O7SHR80
         Zi4VI8miQfHVV0+YHpnJ9fBBnme3agbdCyxUssd4eigE771lZMQyQ6yE0F/JIiw2RD8H
         9hA2VJW1Ac9dhCtI8mdKo1At8KjP6mOwEFAwlhszUD61cKBAuSRJhBUwCHF/5WkcBb0/
         IOj94bArXe3Kpg/ynMEzpFiAv2/ednk9z18FPQ+ovfg0hnaCN+NdQiQatsdH7In4FCZI
         uaedSndIbexZMrGi8WBZqv6RVX9b0K6sVQLgJAtjsvbdpw6O2whufBHv1aBqpuDhAy4f
         HT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703452307; x=1704057107;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tvRFmlXtj9goxnpYQWLbG68v4f47f8rANaAP6Stjcg=;
        b=faVs6Lvl0DhQsiNS/Src++dqhM0NB2XLP8bx9NK2AMbvqxs+Kc1udVgoRgTPshkIpt
         x7/xnmnFQqlGWl3J+vFWzCMYV3LiOfMb8dt7XxpnZ66/mnsvv/s3+FO+dnKKuVncuj1j
         AETU1vmsFdLT+UsrpqSw/0T36Dv49m35vJYcxAlZ/xQQd87WjpLA9Dm1wVRTMlqKQ034
         XFdgzpm6iS42KUFUh1uHsOP1idotUev19jIcMS2BfTEH0+n1MWCboTf2cN9Urg9TkT7h
         oOr4aq1AoJta8KRtunVtble9sHRgxOw6EZp1Rt2XkiEHrAx9YEPjuZCXFvgkYbimN32e
         ND9g==
X-Gm-Message-State: AOJu0YxtvsVbxgwmESH7BGcP60Eiop0jQJZoJP6y3tcNGbSC+2wxIEVF
	P3cdsWhouTh0BcFUumipnP0NwpJLX90=
X-Google-Smtp-Source: AGHT+IEJlkIuWFcD64gmrTdL7RpYfC0ox8tWhIzP412PJbPaY/6BoUdQ0tOXGMOdwZzUS1+NA1OFwA==
X-Received: by 2002:a05:6e02:388d:b0:35f:e7f9:ba9e with SMTP id cn13-20020a056e02388d00b0035fe7f9ba9emr6287430ilb.6.1703452306715;
        Sun, 24 Dec 2023 13:11:46 -0800 (PST)
Received: from [172.17.0.2] ([20.172.6.170])
        by smtp.gmail.com with ESMTPSA id bn13-20020a056a02030d00b005cde84ab215sm2035019pgb.38.2023.12.24.13.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:11:46 -0800 (PST)
Message-ID: <65889e92.050a0220.30fad.339d@mx.google.com>
Date: Sun, 24 Dec 2023 13:11:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6917658322995700730=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mrman@mrman314.tech
Subject: RE: [v2] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
In-Reply-To: <05aa1755970796d5a250660e42ee85ad@mrman314.tech>
References: <05aa1755970796d5a250660e42ee85ad@mrman314.tech>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6917658322995700730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch fragment without header at line 6: @@ -2465,6 +2467,7 @@ static const struct bcm4377_hw 
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6917658322995700730==--
