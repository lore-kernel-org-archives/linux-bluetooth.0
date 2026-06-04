Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9EF3947AB
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596678; cv=none; b=edippM8iLGgb7paX1JI4Ez2mDyNAsomBLvCDWblgBUCrQfJwSc2qjMCMGlQD15+WD2JQwbncYmQunu6HM2YMQLfHsdybNDCKd8no1EMiKE0dTxUuRs0PnHqitEDQSHV4TNgpYIDTmW03b7jy4Z9xDw6sDgfHWXhtNoT6dqeYYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596678; c=relaxed/simple;
	bh=Xgwx1AQgnZut+Y6K5A3rqZh637k9Tr8fKSOPmMs2mqA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QQCgPnDSOHbuLUbQNEzsIqdADswF0P1tJISqq/RguIku+LzhgowRwIK7G9lefL7oQfqksDvnQz+fBL446DZBIFGrhcese+yhhY7zPEowcvClztKj8wwWowup8TXU+JlC2vbgpkGdO4PeEx3uF48mXQtBf1dI63JAmuhaX1+SSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4OABMzJ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4OABMzJ"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69e4ac3b37fso794583eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596677; x=1781201477; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h5iTrzAwfrYrm3CJ2p3K3mb4fs03QtpQ36dcOd4XBU0=;
        b=U4OABMzJHligqSDsQNGQgmcYwlrkDIcQrM/D9sNui+g0BuU2mkmeMDBKAabFJK5JLv
         ppM8jnzJhF6onTXRBel8BcEq9isDvacJpK/AHehHeW64htonx8Fgr1cPPdPUwg/2KC5R
         djmB4NgzdSDLNXn3uke+kmmWLyosQVcbDfGm8cfcdXHzFerPvFOdO/nXenPJkFv5co+c
         i8ZF6MF66wjzNrIFMhfxMrN/kbYfYuPdJttQSVzAFr5D0kLh9MQfxc+5cvIFnC+fKT7V
         cAVGyWe02YdwKTp5ywYwJjIh2gMVIomNuDoQXJyEMI5INXqR/Ird22XN4tUyLAdlK07u
         ldyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596677; x=1781201477;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5iTrzAwfrYrm3CJ2p3K3mb4fs03QtpQ36dcOd4XBU0=;
        b=iqHvqvo41cU+rjNiuWTYLdhOyNXfWrdkATwlz3Z/0xxYNB8khBxxSF4k2dPyrIVfjP
         PFMbLP+f0LwdWAPgH8sktsAOJHqqv/CKYzIOHoBwOsDgPLw/aYvLTzQLQH7DycgaBRO3
         ywzG9iUtDi1MxujkfBDmwhSLMUcMr7b6D0p31jfVSU/OXVMatX0XhheJNVVZKp4BqHM0
         MgmpIuE6XRLymwes+XMJlwi5mv5KJj5vQ/32jE+j5XSi8aI1ODsgkxHc5zDCQqRIeGAw
         zC8uDUYFfxMedlhJeDfiFwLQtJ5Vh/Mo+jy4A88c6G3XjQMBIpaEt+TQQ4L40xhY6nmi
         6LJQ==
X-Gm-Message-State: AOJu0YyavYwUQRE9h/bJwi9di9vUJwmHmBlYEIHPxga4l3zdtJkg17tq
	C9Bq4NBaMGFE7rNeUAHyniwgn0VfPoa6ERfpcPqIeYlTuRn5bn5jCOaujOXKPg==
X-Gm-Gg: Acq92OE8dfLppmZIOVByQflzk+42hM77THCp0LuyIl33JYjRqFH1nx+XoFBWE3+13YB
	ONUlD1DEysIrg1mKS/yeYyPzhBdKWfCOMVt3MMyJzHTnhx8nu38lzmEJZpiyBUsI1heY3DUP5vD
	xfFL5q/GF1dId6moV7YheIpIcTucpIfgsoS5pkH7pYm2ioZvqPte92SmZtTIi5IhsTYRI0CUHWl
	Ji+8owV08Xa5sjUDKIEBocMGC3JX8+W0uS7ZywU3vmW1tSjh6iXOYLrQww0QST76RucBdAC7zos
	xMTcNWjW+thMKrnh4VGPLrE0GI4iWH0U9zVr5lYrUMoWRFJXzwanrSltZkI+IZV9W0r/3/60Tk4
	rAHhPaLX6FvngVIpXifneZm0oK0rm5ugHvQ402bEkEbPx/EOnj/4HurbkNVCk0x9qg/vvM4DZdU
	YAzWfvKjrAlvpgkOmLuefq72Pp1yOPzLOVs5cp2KIY
X-Received: by 2002:a05:6820:a514:10b0:69e:31fc:d134 with SMTP id 006d021491bc7-69e68cb0644mr93328eaf.49.1780596676598;
        Thu, 04 Jun 2026 11:11:16 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.19.225])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8295b38sm5973776fac.10.2026.06.04.11.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:11:16 -0700 (PDT)
Message-ID: <6a21bfc4.7d41c1ae.12faac.1245@mx.google.com>
Date: Thu, 04 Jun 2026 11:11:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5645106016105789339=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] adapter: Fix using case sensitive strncmp for pattern match addresses
In-Reply-To: <20260604171933.129638-1-luiz.dentz@gmail.com>
References: <20260604171933.129638-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5645106016105789339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1106123

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      21.08 seconds
BluezMake                     PASS      670.27 seconds
CheckSmatch                   PASS      352.24 seconds
bluezmakeextell               PASS      185.15 seconds
IncrementalBuild              PASS      665.77 seconds
ScanBuild                     PASS      1030.44 seconds



https://github.com/bluez/bluez/pull/2179

---
Regards,
Linux Bluetooth


--===============5645106016105789339==--
