Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7C2367B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029171; cv=none; b=K6j0kOpVXSTnksj5A2JlHnXexyYwDlvNZVgTw0/hQj1G1P5kQjRt0XFAWSlwC9g+bNr3tYngoycKfMXrluIC4ykXxOOxDEeKrNrouTtYqQ9rXdCWy7gyMCBTlzSnGoIV2bvpGxURPlpGo+/tEMyzszcWADrmkAn1EjeOo7XBuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029171; c=relaxed/simple;
	bh=IIcd3B6Z6cGtkC0gU4zNYopTfxoN452OhFDOuhGVVA8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xhh50Hpv+2SIds3KZ/bpQ/KPwLs8/QkeR5zu/UtD/hPzo6Pfw4AIkzzwFbSI0wTMcHYWkCyYd1DahUz5n+xpqyZgFx/MIohSIZzkxXMnHTP7nNqjrpETW7EDPm++/jkFe2WdAcNP04pJRChOBOhhHPH2nM9atJEOcIlXhu9T4Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPC4bS6h; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPC4bS6h"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91b83459526so41363936d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 18:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792029169; x=1792633969; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qn/QsGAWqPsvpEPdX/CU2VtQ2J8qpnsEyHVO3t7i0HU=;
        b=LPC4bS6h3rt17SOwm0iBC5PKjXmTJTGfE0eWLwUEJVpF3XqdtNImQaxERBsm7yFnVY
         Qs95EsytVruIwlUzacep/2pvwsMDD008O3FBMxtTrFQ8WgMGb9QrA2TaeaRZFYG1Ke6L
         4dUsafZEpL7jNp4RwZWh6df9SfEZ0zOaCnc9EIcAzK+1qbDY6XGVAWoxCL8QsHXcH5QC
         i6Wv/O2QGTe2IDa+qC3H+EgJoOt7zGCUgnoNldb38kzS3F95fZrvw7sFgl39xhAQphZa
         nCdVwrDvjRkDrNxNyiGKTXCMeQvH/CZQ/2xLYZ9FCMrZT1PPoolIYjvy1hTPAUqWsad8
         kq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792029169; x=1792633969;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qn/QsGAWqPsvpEPdX/CU2VtQ2J8qpnsEyHVO3t7i0HU=;
        b=hCSZyl7QHStt+g0uYTTq/JbM73rxKJMHBdw0UHBpsNNS2H0nQ4r5OaNtStCreqFsYb
         um6Od9+cpfn0tThWeh//4sPLxmNDw6izIx8eu36+1pofgkoxzxz5eCBTlUEq7+IdQHWy
         0nQaIGuFk4b2Rq5LxwL0wDClEAXOe/J8uPVWf+OJyXwYe0UZLYasZKL4EEq7kfRm0D74
         dAPXkws8ulzeUcSfBgFVUQgMbUtA11GeB89WwKI2yfs8QRVDMDxvXXxCisSUXk/xpTbg
         3v+sazsLFyZDipgEDaRrGpm+7ZEvUskBgp/ZSNfw2bDNlwTe37HyA9nzgBmLYTjBEiLh
         oMQw==
X-Gm-Message-State: AFq9FYI4h9A6AsUPEz177vfPLfccpMic5FgQhUsCsr4UK0opZQSIGuLP
	99Z808e/taVu4yvvPCEnF2nRgFXirJsmHSIDdleQsfwbkhbJjyz/eatfryzUjg==
X-Gm-Gg: AYBFou21UTdw7yHNe4AY2rJn3L6IAjp07m773F2bIqU76SpB1pWrXuZ/6z1LsfHkQd9
	6rcA2dfuBF6Hf8+5vwaft8c7ffM6dZd6e4LbT9x4qNKOa2CcLWped0vgR9RfnEpiK7AfBILiN8W
	UyAkKBQCXogFsUUE4r37aDLlLZS1jQGwoc8l7qT9IMsjQxkc7xsWQ67a7SRyJvDWsshveDK1UH5
	vtCS9z2zegMK9LPVBQqRkc8Q2T0ECdrAqw0F98AJyDk/tqqJ54aGS+Wv4WdaX9wJfW0YZBGx8fA
	9FndJD1blch+dWNEFEWiMqqmxkNAvEb64QZOet+zFrOyR2LJ7yS2CPzzKluWsHUDyCC8P7ZX9JA
	18V3fceormheIGMbwaCn4J3FWUswFTfF25y2dBYXBhcCt9T7vj4JIPB18B53Kq41JS0LQFzKZh0
	6liWFpboZxX//o/hxsClq4j//NHwXapM+JtF6IZyN5jBKnoW4NZ3EKqx4lGHYY7PWH8WKH6gOJz
	FYJajBsvVgejew9
X-Received: by 2002:ad4:5aee:0:b0:917:9ce0:b6d6 with SMTP id 6a1803df08f44-91b557bf438mr308639486d6.42.1792029168738;
        Wed, 14 Oct 2026 18:52:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.44.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b38700sm68188476d6.11.2026.10.14.18.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:52:47 -0700 (PDT)
Message-ID: <6ad031ef.9405625f.16e127.0317@mx.google.com>
Date: Wed, 14 Oct 2026 18:52:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0509472745244842441=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,vRFC] doc: Add functional-hfp documentation
In-Reply-To: <20260923203105.264648-1-luiz.dentz@gmail.com>
References: <20260923203105.264648-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0509472745244842441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,vRFC] doc: Add functional-hfp documentation
   Pull Request: https://github.com/bluez/bluez/pull/2608
   Created:      2026-09-30 01:41:26+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0509472745244842441==--
