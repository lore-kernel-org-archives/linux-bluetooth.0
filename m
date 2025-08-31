Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF5255F53
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Aug 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756638787; cv=none; b=YR614J1mwjIBcv4WNy2tCjh8ZBIlSC8p8+B4raPJtGrHshK7OUJQ8zL+NzhZL82SyvxblA02VIhSxE2bhfzWT85Vdc1Yx7nXXpfY3DPqX7WAU0OVS6zfmp3a1hljzhwU/8dUCFFwZ/gjTUwYnw6n3Z4LSlfV5HzozB17vUNfrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756638787; c=relaxed/simple;
	bh=6KHVTKJMWUZ+afzThiRFgmWVYVeqQo1A4QN3YOuWp0w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Oe5ZOTgPrcLlY3i6C9puTk4/atAQ8+JyyW8rqInuzJIE6e82p/sHRX+slBmi1dGXNKd5FSYX8x3D2aek1ypJMu0oHmMrFXkiFySCro+JvhWJYyeHI2AagdVEee5OnEQSNVXHKJHxJyE7mjJZwqpES7l0IP5ldhXKFoIlWklxAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c05ICKiH; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c05ICKiH"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70a9f5dfa62so31205616d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Aug 2025 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756638784; x=1757243584; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6KHVTKJMWUZ+afzThiRFgmWVYVeqQo1A4QN3YOuWp0w=;
        b=c05ICKiHXIve7Nqmockhn0pTmT4mPsfH/6Loqg1tnwSUclVGkild+xSDt6sKs3Evn1
         qgD56Tc1V9BrCNyNb1DEO3CCTPrnSurfkOBTspphSe2Nfw2D92BZE0H2YmBIwUEXcdzC
         XXCRhy5D9L7gw/xVMomR2ayapWG4np7oJY/HHfgQhWgGNc9QEl4gJtD24dw918d1EDDP
         njrojj0ToCCjQAg6cmPTCi3dnxScRwf5V56iizcWL3zI5SYFLfRaQIsxymk46ahrVZ9g
         7aji1tXZaMZsXyuVykvNnU4fYmM20qCUT97yBmar+4bVUHAmlchWZIqbcylqr/ZgOxdF
         VjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756638784; x=1757243584;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KHVTKJMWUZ+afzThiRFgmWVYVeqQo1A4QN3YOuWp0w=;
        b=QaziZCRpxhnWzfEKDfKTvFxOZJ234JZTLFPNmnzkS5IwXNfNzS+ehgjZ7hUnsngc72
         PIAb9csmbBthYpkpkbeFRhADZ1ObgmWA0xd4FNh/4kVXyX8zI2xUrdnwew7aZp2j/KQ5
         xKj3JczteG1O/HPBnIqDLqY1n0ciit40NmWyy6TLRHkc40ZQ4GUSCM5PKhkLy3ysVt60
         KAXP95OW7oDFZJWqQLp9i3TYTU+AFuaxJeQoazWwrNz7OvCKYRyX91MkN1eUr3ptaiHS
         3bOJHckgTtGhEAayZdr5hAbchWlhwfeVCCrJyhgCb2E70Gxg8j3LSrSECEETdpUO+RZ7
         RMBA==
X-Gm-Message-State: AOJu0YxRKKflCyYIRtQW86dALFQI6UnWaqE2i3klpwchxJMMFDAfRIja
	jOf9aqr4waG5udZnr+E2CLVXKKpDW6yoYnf7z44FjMz7Ht+hmBcp1XRkXGGXnfZg
X-Gm-Gg: ASbGncvdquayCYNwgB3Vh2P20l1HyJA3WxmRn15wRbQ3EpoGAShHw4XWZB4zvEXa447
	NbHzfQMjcBQMHKUnonl8ooc7ZhpreAOWJRIPZtmmznXTiO4ZDYa0PCXYn2/h70zK+emi2CqZLIN
	GK3f2lQw+noLoHvcuekP9zsI5O0c/BFNeFVj2Srg9asheooQhoWub92UbIE8f7HAFZPEvSOFdzh
	ddxiDPaqT8wvJtmRBdTfN/MR6idtGKCgzoplUQrWzDyxU6dniX3+vCuHvqJr6SoiqY2u+DLqFAy
	QkNyI0/2jGSRM0U4VBFuRpyy0tWaI+RzCTXujvsu/wcU6WOe6tfn9r+B0CZ31s0hSCnuWbBeoGu
	/WuQp4xkD7osksKgu7/TtLmYa7RXWsPqbD82IsSo=
X-Google-Smtp-Source: AGHT+IFgSMB6djZIkMjaCwBuo87pscKKPk12sZE+0dwrCnvfqxRXfyQANMipjgTGcZ1fxUcAM/WvGQ==
X-Received: by 2002:a05:6214:240c:b0:70d:6de2:50d3 with SMTP id 6a1803df08f44-70fac97a438mr53653946d6.64.1756638784488;
        Sun, 31 Aug 2025 04:13:04 -0700 (PDT)
Received: from [172.17.0.2] ([48.211.213.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb2452f78sm21206156d6.0.2025.08.31.04.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:13:03 -0700 (PDT)
Message-ID: <68b42e3f.050a0220.565a0.5951@mx.google.com>
Date: Sun, 31 Aug 2025 04:13:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7536521379785179913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, elespink@gmail.com
Subject: RE: Bluetooth: btusb: Add support for Mercusys MA530 Bluetooth adapter
In-Reply-To: <12b048b5-aadd-4b06-a9a7-8480f27c65af@gmail.com>
References: <12b048b5-aadd-4b06-a9a7-8480f27c65af@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7536521379785179913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7536521379785179913==--
