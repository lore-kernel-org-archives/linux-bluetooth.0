Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700D26ED40
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301562; cv=none; b=ctEnMkGUDRFZPAZik/ge0N32WmLkT54iw2dPjtcf7XSNlQU5C06+pXAIiwmmJWWTYybx75Em0usFLmEvzbQZh9iWAP/NndTk/AuGGxHLNfFru0gICyP0sjY5zgKTF5Y00XwTE2y7ppDmLgQJgqUZ/NKc0qZ7AVPrLw+P8lnNV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301562; c=relaxed/simple;
	bh=zEj3MJDOnEfTM3OpbQBrkYvhwaY0sN5FSSe0AqdZnb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxizYWiyStmmtAwxJ/IVqxvUU4aEOxIuBLJOSxDikJzE0GmvG5iWztVf06YPzWiizrowqGk0H5bfokfG3um3kdu8Y6arbLpMUkD1SipS6YytTTu1IT8BeeMw/Ri1Yln+cJeavMkky3JNoz3WcnaaW5QUhEPr9Y/dVg1MecCwIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KGILhShQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGILhShQ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a652535dcso370239b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 22:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785301560; x=1785906360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7/09h4JafWA6BTqjec/Vv8SutmyeV2+BMV1t1G7T10o=;
        b=KGILhShQcMf5djRuGrpuk9fUmHidITKPenXtVZuSmMpGZnAeDAxJZPlG6yZn/i6zPT
         cAI3LyxBwkaIS1+ssAMOUIlqmoxzuvuID1Gmlv1ieUeABanJumXKigaiZgbNy+LiO8Az
         u6cvZs8kIfuCmygy7xZtrwnlhLNSlGsm69vJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785301560; x=1785906360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/09h4JafWA6BTqjec/Vv8SutmyeV2+BMV1t1G7T10o=;
        b=Lks9LA7mYydNvcO19J4WRAvWsWS1ZVeZIw18ksVWINMtFFqRMuBvW3Xp02Lc8B8LJ4
         c6pcxRKmv6uMHeCDg/E4I+FJV5nATnvOii8tScwnEZO+aRGMaGXNqQUdjud8cHcjlNvQ
         2iRQmsJm68O4afwnhGFSfH4GpC6re2/2MrNcqsrjDLhtpECNrInMo/ldQJY2vbCcwMXc
         UsyJckXuP2GXi1xZnPpEYXgtlefJs1GJVMqYbhcDGnHdW908KyuYcO+8WFYetidZFPd4
         b5HKBCks0BrD0o+jm4SEdMEbpznrq+Dm3BUk0upWf6QhGSiYS8V9WI+kmoqID4pZRD/8
         0JfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIoJ6Fwy4l8MOOTJxaOGAotol3++F3G/e4z8I2l/mHd7vPgEix1kqlPJH5ix96Rua/H2gGt4HXXQpdfBrZP3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XoRUeRfJOXbGOFUd2f7Gbzhw2/9/NctEc2RHD7T9LOMmkih1
	81njEMFF4SCdy0v+Lyt96Wt7+DmHfB+RCAaknMo6whTMqbEOoStGFSIURNNApR8xDw==
X-Gm-Gg: AR+sD13h3oJXVBGYWzybM+r8atsY52VXad5l1HouGuJC08KAF/dPkvKDdLlqoEvToYS
	YsBC/IbPUutRd54lbjKClf9rbIcQQ0B6u4fZWxhCqPXmrikp3rbfenMSOcLEzIVoPblX2L9CcCN
	esabI0D9w6mogfMOK+9XFflwqMeBJ0yQvTo7eTpLDlf3v8vXiqt3n8+Q2oFa9DurTLoQKTTFwBJ
	X9+4zFEOukw1QcuskdtGwfF8jvoT8EimzH3QzKW1x/20IQgNsDxQcukwFCEfyBqEzucqGQrcn3z
	R61U4u97Z1WiqQRMwPiFq3UxAOGjytVVw++N04o8ynHKxvGHjOAx4yo4QaCqlE0SD86lEK6Byg0
	/OM5MbhIRkrP+e/3ggosn6IpC2jc1Yny07M1iiTFbcR2QLNsH6JKHWO+JU1QbFL+IP0oCTY8o8A
	fSapS8BR2qIeKgrFWyKNKrShlrc8LZi0iFTJxxbtvDJltnO83JjxdpOAOU01ozM6Rkt1yN01yno
	S/D4EWP8yWRqM6pN8qMFEqjf6U6aP5VmHDIIa0=
X-Received: by 2002:a05:6a00:2daa:b0:842:3a3b:d6e7 with SMTP id d2e1a72fcca58-84e931eeeafmr5750213b3a.23.1785301560519;
        Tue, 28 Jul 2026 22:06:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055dd5sm741877b3a.20.2026.07.28.22.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:05:59 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:05:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 0/2] Bluetooth: btmtksdio: teardown fixes
Message-ID: <ammKA77-UC1Ie5V3@google.com>
References: <20260618031338.1011410-1-senozhatsky@chromium.org>
 <ajtoXTaBEMSyGADX@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajtoXTaBEMSyGADX@google.com>

On (26/06/24 14:19), Sergey Senozhatsky wrote:
> On (26/06/18 12:13), Sergey Senozhatsky wrote:
> > This fixes several teardown issues:
> > 
> >      INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
> >      __cancel_work_timer+0x3f4/0x460
> >      cancel_work_sync+0x1c/0x2c
> >      btmtksdio_flush+0x2c/0x40
> >      hci_dev_open_sync+0x10c4/0x2190
> >      [..]
> > 
> > close/flush can deadlock when run concurrently with btmtksdio_txrx_work().
> > In addition btmtksdio_txrx_work() re-enables interrupts regardless of
> > close/flush being executed on another CPU.
> > 
> > v3 -> v4:
> > - fix commit message linter warnings/errors (tabs, subject line over 80
> >   chars).
> > 
> > Sergey Senozhatsky (2):
> >   Bluetooth: btmtksdio: test for BUS IO errors in btmtksdio_txrx_work()
> >   Bluetooth: btmtksdio: call cancel_work_sync() out of host lock scope
> 
> Do the patches look good enough to pick up?

Gentle ping.
