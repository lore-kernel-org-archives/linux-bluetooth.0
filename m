Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498641F2380
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706091; cv=none; b=uLi4nGoLb/9PzUsiVI8Kc2btLE3GdOQic5WnQf82Cjonfw5jhnlZ+gEmbhHFgQxPpmHBz208nwt5D6NpF3oDxyzNXFRcU43r7hnuEXTSd7m9dqlrdZzuxVU/WtLMwOC3j8pThfH5ptZ0wYEEO9pZ9TNzUPYXgWz1G54hJvHlwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706091; c=relaxed/simple;
	bh=T2El3FgS07VliVLnP7fxEM3f/lf4hsIkh4dO/ZG9tCE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fy24qu6oVRSOP9pVRlt4sUdb6NM9XYKZ9sb+40+5ccTbuWD8hfhCaRDwPgD62LrXDlRc0JuDvFFACoYtgUay6mkTiAacSUpcWoeULsDV93eDSEzHZ9qSaRxj2ADCadlGT4JwL2cZ6tD2YXPEvXKVO8EteBh7UkfYDe9y1FNsatg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA7Fme4W; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA7Fme4W"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90b2fcf90a0so475285685a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778706089; x=1779310889; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T2El3FgS07VliVLnP7fxEM3f/lf4hsIkh4dO/ZG9tCE=;
        b=FA7Fme4WkcovFdw856vbXTZkzDxax2lYIAGmytMTbRTqfRH7qoSWXmaYKYXUVJ0kZr
         6vZR2xeIHwF2aMI2+UCt5Pl3ycEleBzeteD4ChhrJz8pX0QpxyVTUVeG8s6vZigyEQWd
         6hBrrHhKKfJQT4nS/6GRcVJtY379w+dGIv/WKhSvU+RpPTAWIW+xo0xIkD87IlCCSx2a
         Yrg0B7Z17PZivdWY5j06JIeCf9sfrK7q+l5RNTvwZGgYwBMOEcVvGfmiRlI2mdKqvM41
         GUUmINp1SuhQ1cv7nHUnlExsnENSUVxAcs8zs73I0UUNxYef2rMXZxWyuI9o0s1d6pMg
         T/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706089; x=1779310889;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2El3FgS07VliVLnP7fxEM3f/lf4hsIkh4dO/ZG9tCE=;
        b=b9K52VaRh1i2aHspNUh4dh5WZ9TvNPQkdL2d7VPMBDAqYa7HG5Ih4BF1v4ANXAyZdG
         77IWzX42pPp7jSiBF0JIGqAvY1jM6KCB2hsxnmFHRRspPqn7l59GBLR10X93g56Ic8VY
         VYVd/vlX69Z2Z0DBrpdqCSlPs6gQnZB1POMP7HZQiEtU1leE0CrqqnjH1QuMkx/zTaMx
         E4/uwApmqfiLmuLqoT9wLgwSCqfVZBysoNX7HZwMTqG1XO6PgleGqAaHc1xMwqntdOIw
         YiZ3nSwv6JndCiSnsNCqim8uX6Mekkba2425d4fhDlSkAYIgsxD36L4gX25xnLHCezql
         GueA==
X-Gm-Message-State: AOJu0Yw8MOW8Axm/5wg/HpHVUccl/yI8AKUkRy3ZrSFg7xjOXVyoRDiC
	HfkH1eLr+aFTzlN8KPsmepjoA44n65wO9S1/Aq7ThvKGthhRVpkys24Dd/a2XA==
X-Gm-Gg: Acq92OEnBFe+YM/Bq3MHtshMITcwifaYZ1101M9izOy4rPN8iWqwU+o4/ROEMuFOPy/
	ii74qy8DHxLMvjA6/fGRCVeBuGZ903RB2kzQpctfp7pNJCOqrr5ilvtm/xHI+LeVWlDooXRrLCQ
	mpdcsFFydLp4biMWRrNalma7d4xMvFj9HKjwHQYDWIzJWk+mXjOzMMQnqu8RPKtKWNHBko0zENO
	lABBrV6aydLKApUOmUVlc8TP2Mccca7wM+Tf4edlRmiFllR9Qeemd0d95vwNFl7oZoDS4+PMjkh
	5uhW6RvZiPaRFbrhm1JXGJ5CIQhTOjlzYwPeJvoHbQcjF7HWWxB+ZR3pYpdWeOWjMOXaTnKKbP8
	jA6rDuHWM9BJ0wfKp9qFF7WanVsalG8J1QY0LLtId3KncwAtVvis5A8rE0CeLNbjfBk8JngO7Hf
	Ti1eFu55RgiKGLEmqCfpn1kqBWuTj5Otw=
X-Received: by 2002:a05:620a:128f:b0:90f:786c:4a82 with SMTP id af79cd13be357-910b14f8d14mr123301785a.39.1778706087377;
        Wed, 13 May 2026 14:01:27 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.232.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc936407sm60702785a.22.2026.05.13.14.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:01:26 -0700 (PDT)
Message-ID: <6a04e6a6.738433cb.3acb61.7ed3@mx.google.com>
Date: Wed, 13 May 2026 14:01:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2887184847195117468=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, makro-kernel@proton.me
Subject: RE: Bluetooth: btusb: always reload QCA firmware regardless of chip-reported statu
In-Reply-To: <aD_Lix2EVXOHmbZ4L1CunlWiLqfiKlU_1_FcVh4CBuIgud4kmE_544xjW2zFKsmh4pNAo9yIQ7q8_GZ4YcmgAXPp8LgW9rfWKqnu06WSjgk=@proton.me>
References: <aD_Lix2EVXOHmbZ4L1CunlWiLqfiKlU_1_FcVh4CBuIgud4kmE_544xjW2zFKsmh4pNAo9yIQ7q8_GZ4YcmgAXPp8LgW9rfWKqnu06WSjgk=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2887184847195117468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:3646
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2887184847195117468==--
