Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE1277818
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355692; cv=none; b=qnxImFirZlY5VKDkWHHJxdp5o8VlzMHBArpXqw1HpDgZKaOZ8VS7RCoRCKJdqSVJFWcxSfx7I9tfk7J+f2KBfriaZ0X+0xuGtZr0Azf2SS0xScKwGqpAzli15kYr4i9BvBbChkJfFKbH06aHd4CcBe7cYHNVAZ7g3FvktNsvoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355692; c=relaxed/simple;
	bh=dT+aty0WaZ6p2kBpQ/aSDAbuLe9GJ0r1vewol8pCijs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jx4yEIW7MX7QFjtE6dmnVN0mlnSyg6Orp0i7UI1OcVVNbvKCYSNsN8507gAhwkgilj0V9C/cyXq0fv0ZvFgnxot4dtIeV4mfPlOyHc7ljEIVOaTFAsV9PxdS8cdh4b2AliHkPhcd2jSUFH7g7JxM3sdelHz994jSPx9HZca9T6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiIGEfWC; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiIGEfWC"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acb3dab8dfso30581706d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776355690; x=1776960490; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dT+aty0WaZ6p2kBpQ/aSDAbuLe9GJ0r1vewol8pCijs=;
        b=EiIGEfWCyfcCMsgurKlLcBQ/vtBFEEbLlsVZMFGtOOZxXdWlutro8iFFDYEbYE0iSo
         HGWBIfyzdCRp6Q/EEBOPaCKFddU4dyr9P8Ct6q/CWIaTdQpD1FVbG4/1JIsYCDZOn5bZ
         pRj3vrgXy/HeJ0dg9xakL8vneBAlAgqk3K4HQpbIFFR2n5qQh6mjaRqoy9aal8/IOUjk
         bduRYJE7uYNqlYBa8lyOLlL+6YayEq0sHsrgV5s9O0e4Cdy/l36vVy8QXcTm4vr8NxZF
         LfybBqJZJ6tOfBYQMoVN/LbAzz0le4UxQTzfLUiqHsFnTX9S9II5vcRaRYWS2lDTHdoj
         6v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776355690; x=1776960490;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT+aty0WaZ6p2kBpQ/aSDAbuLe9GJ0r1vewol8pCijs=;
        b=QlZVVfqzQOEWqGJKSSw2tgtFEvoEeJhtA77z0Md+GHdIHGnFFJFYQKnGSsPg9H2hvK
         tJbzc5qjx3zMU5zVRaSNKIS9nNtHZcJdIW7oVwM/uTAwtuncQZ2Ld0N8KkyMY0YfcWDl
         WX8mzmjRySaB2tUQ5Ob8ySAhcS/heNqaWGCqcRxq8B5VW0i3AibZcQsoSmf/Qz03CxdE
         0yz8NT79JbZ4N4AGhfq2tpacjURvRL8Tj+BQDck4JNouUODLmHz6+JWaclMZ4xW5BUwo
         FmZusk8RHIAMCqLm/ZIV98wR/gqT6vRvZTIkWupv20Oi48pBckm/qSiYHuF6nUWLgZ0U
         tPdw==
X-Gm-Message-State: AOJu0YxL6HpMHvQhyN8FvCh0QtLuSt691BTMe8gBsptS6JYacBL8i8XD
	Qd070pR87aDcaOaAe52IhWPAH7OLYRHzhr+4McuWU+7bilYg//T+/Z8/q8HqOA==
X-Gm-Gg: AeBDiesbNTETX+Qjqoa2u5jMTOTkbK7+x0bbaQXS2Lbp+itOhRPj1wNABKqbBRNZavD
	QJaS1BaOm1LHX/C54xHWwo1WUs3NKE2EVZRbN6vV+SoiX+fCLmSxlAMyipulyI78usFYPKGJiND
	cY74KcwOhW4Hj62VmFDoqwqjf5p85SAFqm0dUUgh60KD2r5cwjFrQWkc5ZcbaOKI94p+dbtiTab
	5y9V9pqBW3Kqql9uHnp9PzEy8jKgEAn/YWTAgYINWgVeP1Y19HjNIGsqhjBeHcfxHFIG1d6pT26
	3dH1GRTHLPu64tlrOfIclb6BD03TTukpC5TmL00T6K0O6z8rKJruiX5kkdnKjSDyzNRaw3fKyCq
	09LfPqdA6XA88CZ7Wb+bqitShrYOejVdykztwdo97S+OWpMrm8ARayU+Cx3EVpKBzLhUQPL65LJ
	RROZ3gJK/ugXl2rm8wn0NIkroM8eTrBrBl1+hKCb7lU1EYl+hHpzo4
X-Received: by 2002:a05:6214:411a:b0:8ae:655f:28a4 with SMTP id 6a1803df08f44-8ae655f2ab5mr150553106d6.40.1776355689881;
        Thu, 16 Apr 2026 09:08:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.86.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c976a5asm40734216d6.20.2026.04.16.09.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:08:08 -0700 (PDT)
Message-ID: <69e10968.0c0a0220.28b12b.2539@mx.google.com>
Date: Thu, 16 Apr 2026 09:08:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4086227996858642716=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Fix build error when CONFIG_ACPI is disabled
In-Reply-To: <20260416153524.1405955-1-chandrashekar.devegowda@intel.com>
References: <20260416153524.1405955-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4086227996858642716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2280
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4086227996858642716==--
