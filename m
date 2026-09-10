Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337DF577E4B
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062172; cv=none; b=aQiV6PLfDI0wdaBheEDyUZDNe7iA31EKPFXpeYpvuB5PTOdily/QVFLMMI/D2zGeAd56iZfHMhDWDO2a0uPfGBQTzem8aAirxNb1TQDJKeQA57JjTWtC+VD5+pYr/90kPcQpwISA/hPi+HKIYnxm47ajfsgpAQuC9avjE85HrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062172; c=relaxed/simple;
	bh=iUsdu7hlMTOdkW/S5TLwwWc/e2DSnR7a2CMreYkJWMo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dfy7cwIWFHT5d5g3H54GGyA3cIgIGm//ma8eHpyuPSYjGP/+7zH7uoCHav/8Q5NGFaRgU3V7IixtAL5mh/SaR/6VlBREL3mFZPHcK0mIpyxmP8Ifq1PV75s4vz3oCYMF87Iw5nO6kKtu6hpcNe2zK2kAANNdo91o+UbRsl9Zcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYe6GRFm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYe6GRFm"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so108346a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062158; x=1789666958; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7ubjC1JTeylAH/I77DS0dkt+xeEXd1ObINSsBjaXgiI=;
        b=sYe6GRFmlS9nxV06iGuHiQfLXDkztxZFwrZWhCbDGiEdpfZ30LEVR6EqdPTq5gKDU9
         hFhSjgAH3pKxfTT1DfyOfuq2E0jFKibIxQjvbx6jWsb7tuB05xL5VmE5/RGePG2JyTPq
         x3TV+fFWyv2obmCuk/X8EemsJSaoLVajX9XTzf9M0dQCdh7mYNLhi0YYBddGmgOISaMc
         oW/Atu2at/r0ihxReF/P4qDsqZ/mrKcSt2t1DEwTxQOBy5IBc8iZdTd9+ZBPTs3/HFCf
         R/MVvZlSg60uHjZbU5f8iNVGmKLyYHgHlQGCNGVaEE41vp2y2hzMyIoAwHv0zkDeZgd2
         SGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062158; x=1789666958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7ubjC1JTeylAH/I77DS0dkt+xeEXd1ObINSsBjaXgiI=;
        b=gVY1Vjs/Tr2dhLuaeW3oIwPYkdA6RdebhWiWOoWc6bUG+Xl/zUSmXnGktfY8wMSCVo
         o4a1lcfquFTYC/hkGhUoPBaprhjjqcXhVxXziXj4Lk61Yc3iuhzGSsHyqfkZG6kKmeCr
         GgBdIBk2wgenlggv0G5xRMhHjzsCGiccOqKU3xsscCr16ptDQ3FxHCZ5nc0I3Fn5uhPL
         RhWOvuOrpiqnGKfmGeU2Nct2MlOx8KD70y2JRVmxKr2kJk5hmkZvnbv+oZ7ks0jn6uNV
         TwlFFee3kP9LAAS+7Fb++KiUzbiJgYF5AGKOeFQQUtEJNg201NoJtUoBXwmQI+aPQQHI
         bR0w==
X-Gm-Message-State: AFuF++lqjlvkdBfHoJg1TddFftTp+W4Lf4Z0qPgSeZoFwR8H0uHN+mQl
	faxicGqXsbtjHCy+/hqiGapHRHh/aAL0tTpg2eU409qH530IRObazjR35kTw7g==
X-Gm-Gg: AYBFou1shwxB9KXN2f17HvGPfrZ2E2Lc0sUQkmAwyaWxbPo8YVaE70d4mN/6S839x11
	+WvLhdxDsbSl5TYSkewCRATGn9eccmuGCYhLDD8BuHkSolYos1gm+7eNds59stf+fD84aludiF4
	qQCaP9/a30+aubh+LjPTywxOSfac40j5KxOrPG9Diq+m8sKZgjjTZeLTOyYpzUDBSLB/At/J7UX
	pjIrr6WbmyslXCXZm0BDqXGIgC8mnJB5+h5kNpliGrMhEnae+1td0Gjp0jOXNN4OGfbn+QPniNr
	v6jZTH041adrnQxySIeDpVPJG0Y8wcHw3LqpxgDSrvHIWuates4NNAJu3usihXvyZ/zMkXL32u7
	JgxJirBKyiIZyuOG5bRKaADrAyi7D+GHVeERAakX+HOgJSCuGQHq9oNlYV5ipXptHG1f6EGt+uw
	V30HPlxrFrYNglkXbYqUJ6Eo/ndXRiLmK7K3LPH6+ewpim+jqrWH3+V18wziOphEjIv6jhQehN/
	+IYsA==
X-Received: by 2002:a05:6a21:38c:b0:3d3:ae1f:d7f8 with SMTP id adf61e73a8af0-3da3a0cc91cmr68450342637.24.1789062158138;
        Thu, 10 Sep 2026 10:42:38 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b5e1edsm237619c88.6.2026.09.10.10.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:42:36 -0700 (PDT)
Message-ID: <6aa2ec0c.abe55a58.39b5eb.6130@mx.google.com>
Date: Thu, 10 Sep 2026 10:42:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8962727341330373360=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: 3 SDP XML security fixes
In-Reply-To: <20260812080410.2116906-2-hadess@hadess.net>
References: <20260812080410.2116906-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8962727341330373360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       3 SDP XML security fixes
   Pull Request: https://github.com/bluez/bluez/pull/2396
   Created:      2026-08-12 08:52:51+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8962727341330373360==--
