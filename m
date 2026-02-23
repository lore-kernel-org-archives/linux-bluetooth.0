Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723534D391
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848965; cv=none; b=loF+avh2fyxJKgI/ezbfRyrZMawlknmexdlZ0cka5qqREA+phH+G3C8os3gvJDs/QyXwYdryYzaP78QcmXH5rGF5TMfDdF8Zcp7yJSUutWxigooqB9GA7r04LzS/fX8/DoeAsubG4Gk7m95v+YQgupWJt44cxQs6VnC+ci7Oe4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848965; c=relaxed/simple;
	bh=1PBTJcbxdrzYQvPiFSi53oe6XZEeWPFTEREfJJP/dlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/4aO5ZkpU6nDXrCrTr80mrGvu6/jMTdE5Q+xfc8/32zeVeZDzIunCTXup4BmGagrv1Oj6CmCTnHLKcsiygQ01YmOJ3QudrE20BhQBv3W2BW7xRjpive8AcJawWm/pMhwdp0WfhiLeEgBdZveoYb7jR3RCeZH/H8Mi4UTUwgWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dji4vIBl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dji4vIBl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48375f1defeso29950195e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 04:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771848962; x=1772453762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=277rMcw8kS5ArMiSvCyfzkh6h/qmIKxeYvWi7CCtUrU=;
        b=Dji4vIBlz0B52Jhx0T+82/D7AyCU+A74ATyVCFrSxLZOHuefIkZFqYdiFtfFX55BS2
         1UqeB/E6oCv2vUwEZMSRRDtrlQimW4zdVasuJJreDg5EOpd6KctpJCc8rRQEp6uC2QFz
         OMo66hrmc96gmn+szmHMO5MfbEICv3zaVYOaNiLOP4Nt/xkdIznfcqb04qWIBXP+WKqs
         7hRGzNBVioST3yCAlZIrFwnkCAlwqnHMU9huTGf/KcGBLgeZMSswxfoWR4QTKoPVjRqd
         jYKhHcNeiuy2QbLe1NDgOzDIyh2wht3QeFoUx51mPyYbtLiBlAvXxUAoxGu4qs3EGGch
         kuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771848962; x=1772453762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=277rMcw8kS5ArMiSvCyfzkh6h/qmIKxeYvWi7CCtUrU=;
        b=FUA9eBUKNidyolPnYSxFAUgHisJ4B4y1b/dfcS0mbJO2aM1edoENsXPLbQoiceCNGv
         apnwDIie591FM77cqkPEkf2e8pQb5l2f61nr0RS6LwJZh9oUfdmuQg4Kx/7FJ8dFX8ul
         5pxdHsi7foO27YF/dWuYAhiu7iJjb94XLbVfYkUXR75VI4zBEfKBHDYdpDUM1a6RyVlz
         FiZeuSCEHNUUMIJ9gjl6yRpzYtCKyy45xbkgqH+duWe64TvVHygvMfwInOMBkCLd0nBK
         6/7MH+bH2FVx+duQFrKZal7Q67K1xpXwuU+zjFu+0kKZA/FxeW86S1JR2pexS8jO8oie
         4uPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp0CeV3I1set9nvU86UUrCR20qIQEGMkvAoeenWKW7MsnBJTXD/eaINHAFlq/hwfgcfA9wegaZ2y5qo23v1ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNM+4w6C5px7UXciWYnHK2vXB9SY8M+AKOHjY95qq5B+vUtWW
	u8NQN1aU5xl1ADn5CvoTBJjCc6QWjSjATF72f5IkHVyQ6Dkb5AKVR3X/
X-Gm-Gg: AZuq6aLHAsT5tTnqgzFV0hyDqEzilDHl1vak5NNafUaxQyCr1XJUbTFAD6pn5Md9piF
	t1LvFELEP7Gplb0kMQEGBBHkKprOjqaKZxaWMdlFYCkq5hsUIPVlLOe5mvIfNEx2Io+Aj4AlpTt
	aUPZ+Kk1lIpU2wx51bZPME17Mghe/98GskYf4b/SwL8rvRLp/dL34dZH9wBNK+fXMnAwbfwdnOn
	EFxSO7psYNT8xyTzujl1nl+P5XjzmkEBO1rpRy66vQKozoD6T3dv3k1Fq0BxwvVEUAZWN5es1YC
	nCkb1wkwN7Yqzl8HIRUn+jNAnnkzB50tcv1nEG6ZkPd4A8PJrRFLylsnR2PlDNW4wnXAWPIVq4/
	FDlf59I0hrjg2m+5ro3XiyaKpfau1IPChV9uncIblpHOZ5SN5P0TfyNJtJbBvetASMLBoVhhSQ9
	LVpF8VuVa3+jb4NGQtZfnYMLn77pbhzrHPmxDWovUkAKMMDpqiPwkTubNoHUauNzSpGonp5BvUX
	FzuSV39Gb2ZMFzvdoAIpYaDZHlzh3YlIKxeOjWTBxnHciM=
X-Received: by 2002:a05:600c:1f8f:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-483a962e459mr162439725e9.16.1771848962174;
        Mon, 23 Feb 2026 04:16:02 -0800 (PST)
Received: from Lord-Beerus.station (net-188-152-100-94.cust.vodafonedsl.it. [188.152.100.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm242454895e9.5.2026.02.23.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:16:01 -0800 (PST)
Date: Mon, 23 Feb 2026 13:15:59 +0100
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <david@lechnology.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: net: bluetooth: ti: Add property for
 enhanced SCO setup erratum
Message-ID: <aZxE__Ybg5p2DaFM@Lord-Beerus.station>
References: <cover.1771847350.git.stefano.r@variscite.com>
 <db4c7eab9d0c2f71eb61baff240957596f099401.1771847350.git.stefano.r@variscite.com>
 <a5d4ebf0-9d99-494c-b46b-a6140610c9e2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d4ebf0-9d99-494c-b46b-a6140610c9e2@kernel.org>

On Mon, Feb 23, 2026 at 01:03:27PM +0100, Krzysztof Kozlowski wrote:
> On 23/02/2026 12:52, Stefano Radaelli wrote:
> > From: Stefano Radaelli <stefano.r@variscite.com>
> > 
> > Some Bluetooth controller/firmware combinations advertise support for the
> 
> Which ones?
> 
> 
> This looks a lot like controller issue, thus deducible from the
> compatible. And even if particular firmware has problem, how do you see
> changing static DTS on linux-firmware update?
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

thank you for your review!

We have observed this behaviour specifically on TI WL1831 modules.

When using the HCI Enhanced Setup Synchronous Connection command,
SCO setup fails even though the controller reports the command as
supported. The only working path for this controller is to fall back
to the legacy HCI Setup Synchronous Connection (0x0028).
The behaviour matches the scenario described in commit 05abad857277,
which introduced HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for that
reason.

We are using the latest firmware available from TI for the wl18xx
family (from the official TI repository), so this is not related to
an outdated firmware version.

The reason for proposing a DT property was to keep the workaround
flexible and avoid forcing the quirk on all TI controllers handled
by hci_ll without confirmation.

However, since this may be considered deducible from the compatible,
would you prefer enabling
HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN automatically for
"ti,wl1831-st" instead of using a DT property?

Thanks for the feedback.

Best regards,
Stefano
