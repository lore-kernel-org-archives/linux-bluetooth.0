Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81313B293
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667798; cv=none; b=eWPjzQ94iU5ZjoPOqVKbF0/Zqa5R/wDhJ7AcOdLyXvMIQ0KAIYpTqPsV/XAGuWE8w3nsAGWFQB+miFco9+kDTcae4SJMQOkrowqwyZl792ZkdsO14QP2G2rBJasNtmZEDSDjui5L8JLl5CWcofFJl2ymSMaxY+Kf0DC/DwLqeds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667798; c=relaxed/simple;
	bh=WEOH9Zij855NRo72iOFHZ0pZ8rnJx31sv+Yqu0Mcwmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQfxBgs0/kfmM84kaJbiRfCqICeMJCkvvywdj4qzX4kZR/0Eanp/1tBDO7Xq2uDC3SBcMU2opbDGz6J1pVz4zkToSC+u/6iJidvceU50ym9zYB7jjcaUBWT2vHT5ulQlw6P4LIaow/JtLx678NLEKgVMrtqJBRSE6PuMWfTsOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hWXLpXN/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWXLpXN/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2247e38eso47807305ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 20:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781667796; x=1782272596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKMvxmzWdS3ilWkE9VoEtw0e2IYGWSUEtrr2tn3P3Fk=;
        b=hWXLpXN/MWUO0Wtme1JSHHZl+NrYmmatzqBuMhEGTq5BPtN0v7TQsjJuiQ8YUwVokN
         gdWr3vMUevKFeA5aqkGYxvkbj5fXt2JNGy5N1PYzaqBo5x2PCg1DVa4nMUJ2WvcV1Zve
         T89Hdr2+mngHjZm54sSJKYmU4r9oiKlnTIx4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781667796; x=1782272596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKMvxmzWdS3ilWkE9VoEtw0e2IYGWSUEtrr2tn3P3Fk=;
        b=Q2uPJ0lw54S7MYf1LxZpayk39dc+YLoAWcwigyp9lYQXtenrZfbfPKWuMUpqDgSylv
         sdPJQ25VrMJJBVZqxHQNzOEEqcTbBvo3zQaBZ16h1yAV58j2POzY1vwdzgIj9nyZZIwq
         w/6gqSodEwvWgQh9ANDt/iF515Tw4WC+eWaM012gu4syDlwuSJGzZkKML+cZuSh0L/RP
         cGuXKjxP97zJ/4+5F5z+bBgw08lQz1UFKFrpfGOeZoaqOzmFxAb8xQ6ctCHq/VTc79+r
         mLyhj8g030MraCr7DWPi01MB12ga+Lf1C4A2vF5hI7hA2QtR16cmXYX3NhPr+DsuiX3o
         yPCg==
X-Forwarded-Encrypted: i=1; AFNElJ+uXvIFVVIJMV8N1TWzTNYuv8BNgQbZHgiifFf9KwfBSkJt+iw9hers52Rv7KKLj2kT8GbRLh6S8U3ow9xLdkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwRetvxBchwvMMVV6JfnKLLW7CDmYS4CD/j1Af53lHirP/e+J
	tWAhLuWZ8E+QGaocH1heBOcSCJ8oms57E1+159Vp7Yvf4pY1ihel6HCK4tsdE2szQ7d3aeZfIiH
	/lSY=
X-Gm-Gg: AfdE7cmHVFMLzhnKnuadFFfRoygDsAqXq6EMyiCKhhrxX5or3n2Oan2Sha5y4AQ/IcC
	bwCa8W8OZ6tZ//gRjuEIuMyVDui3hgVh3NoNPBQbwvOC6FeZNS/N9Jqy465MmjwZWGZmMBjE6hU
	OJFTKbEBg8H8vhBatuSrExjzYrMNFTrLESJ5XsbAws2DEYIxWqnJ57Fo3rPr9vrYjAKclSb3U93
	Ij7WmY8HJHHrWQuXYDfhPa/qFxt1We8COEjoh8vsjaS4xTJD0je65u/2fhp3iaxgOWOxOHTqYnL
	jG6/bl1NAQ0gLJHu+lWP61Que0wzpgD+U8erj+iYx/UieH+IcbDG487j63z8ZH0gnfpJYw+ZkHo
	QG+YzqALP7+Rqx//qlomsQCLcVBlfPnu092tOO/HRmaL7JmbPxy9SnqN+XMCR9Q0Ba6Cihj9VIb
	XwYmfkyNYeYouyFTisvmMLMSXiuYYdmcZE4pilX8/2ErgncmaWVGo=
X-Received: by 2002:a17:903:3847:b0:2bf:379b:53f4 with SMTP id d9443c01a7336-2c6bc21f206mr19662105ad.19.1781667796535;
        Tue, 16 Jun 2026 20:43:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a0b:fabb:5b62:b85b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a1878426sm31639145ad.64.2026.06.16.20.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 20:43:16 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:43:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Mark-yw Chen <mark-yw.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Tomasz Figa <tfiga@chromium.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: btmtksdio: correct
 btmtksdio_txrx_work() loop timeout check
Message-ID: <ajIXcLmdakMsDEMY@google.com>
References: <20260616111224.152140-1-senozhatsky@chromium.org>
 <20260616111224.152140-2-senozhatsky@chromium.org>
 <CAGp9LzpCMGr2hyVJRMehs_BD4Rk6mS2jAifWuCgBaANdqgtvqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGp9LzpCMGr2hyVJRMehs_BD4Rk6mS2jAifWuCgBaANdqgtvqA@mail.gmail.com>

On (26/06/16 19:40), Sean Wang wrote:
> > The btmtksdio_txrx_work() loop is expected to be terminated if running
> > for longer than 5*HZ.  However the timeout check is reversed:
> > time_is_before_jiffies(old_jiffies + 5*HZ) evaluates to true when
> > old_jiffies + 5*HZ is in the past i.e. when a timeout has occurred.
> > Using OR with time_is_before_jiffies(txrx_timeout) means that:
> > - before the 5-second timeout: the condition is `int_status || false`,
> >   so it loops as long as there are pending interrupts.
> > - after the 5-second timeout: the condition becomes `int_status || true`,
> >   which is always true.
> >
> > Fix loop termination condition to actually enforce a 5*HZ timeout.
> >
> > Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/bluetooth/btmtksdio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> > index 5b0fab7b89b5..c6f80c419e90 100644
> > --- a/drivers/bluetooth/btmtksdio.c
> > +++ b/drivers/bluetooth/btmtksdio.c
> > @@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
> >                         if (btmtksdio_rx_packet(bdev, rx_size) < 0)
> >                                 bdev->hdev->stat.err_rx++;
> >                 }
> > -       } while (int_status || time_is_before_jiffies(txrx_timeout));
> > +       } while (int_status && time_is_after_jiffies(txrx_timeout));
> >
> 
> This patch has already been merged, so I think the series should be
> respun based on the latest code.

Oh, I see.  Any chance it can be dropped from the tree or updated?
The patch is identical it's the commit message that has changed.
Otherwise, I can drop it from a v3 re-spin.
