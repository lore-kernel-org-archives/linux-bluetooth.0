Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD93002A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875904; cv=none; b=sD4aA3bLfAqu4UMHIbhgT9xhTbJcBFBz1WJ0+8Fxm5m7zWc+Hfsluq9RWpHmGXpHsoXPZsDPWZAyDaPy6EE+2BHNcwcMl48TfA/VOWUQX1Nt2eGoZYdHLvf6lTK3InRHtLN1lSuqZ4fnzdovzm+YomQZeSxnc7cAS0E3hft29HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875904; c=relaxed/simple;
	bh=pfaetce+2U1YSPcdUnt+iwq8e6TZpEaMdj4TZG4hKJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWpLhrGc1HVyGb+VNc833qCC10UMuSTmD8QsA0GjHPaFsEIacVSqyOYHnwrINmTjY9gLwhVFeMjdLIloqnX+QI9zJlsmL4bi5umD5MLHfpQJNwCGjGo630J8Supl5U3TwCymlOZN7ioBOO1bEav6t6Ra3bg5dUFB7LREw57idwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1VmoHXF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1VmoHXF"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4870206f73bso27064055e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774875901; x=1775480701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFAusg/VYUVqnXvGPPz4MIRH7KikasmK4jgiIFYP/bc=;
        b=I1VmoHXFl9H/BijO1uScXuRKfwFDuhDVye50lev0qIO8c4IsTCnKxpfwjvWdO6Rlb1
         2P9nlcepR9HdgzFcP7ZL7cTrmusp6/teoCE8oRlDf7IPRvBFY+O/xNQ/vK+Q6g2Qdntz
         73m2ayC5ErPsjdrVDTrjThTvoTiUBUPepMW+mhmsiHxTnLJL89AEpni3QvaMHDu5aeiL
         aiVPiKaCQNkUHvOOBLZTSlcubFkawCxwuxfRkHA7XktZv2IHmbbKiAublL1RHKIhuUgS
         uJ2giu8F3Q1nD0RwtMFmdOcZjSfgeO35DGWUnP94nEspDy+R1ElPIqz+FMMB4GjYYUtD
         Cvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774875901; x=1775480701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFAusg/VYUVqnXvGPPz4MIRH7KikasmK4jgiIFYP/bc=;
        b=G+eDHiHVM3PtpLeRpwzvhr0zk1QihHvVda6hAGJIwvtyGKWTFhWtQgQtcZtAnPqkI1
         vC3FzffvxD+aY7I4/Fuc0Oea8FQxNijRzqqSaDKpkZ19p+c4iMTGBzKX1bkIqUELqkqU
         UBjGcbMk+dSIPULKzIazuIoXwg4ST3MpNS0yRytl/DiBknlsi+9jc68UDWHhI4PhOvwC
         5BHdIwcomt6gJi9UcspavRcsdzu7+OceWfiirlLTB7aXC2Y0W2wqTJIYWQZgJWzd0HSw
         Q3YighV/l6vz2S5uCpYpW7S6cSKsTO7X7BzuFVQW9+cDo/fG7+Uhqy2whjdTdJeNSlBl
         SmPw==
X-Forwarded-Encrypted: i=1; AJvYcCUBNfnocOeq0PXlikOS8E6Tm1JgGkYbgzDVGeqGvZv3z/onepiRz1BcUQ8rHo0w+SsWZGV3sjor6nHPkQgEZE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlfgyjMC6AmV1vauweb2H/B8FSMVzufzoKirCIAe/wSjPXuO7
	nOzQ9Xs5eTaYvgcArNs9Zlkr2KofdkldcBRv+ay2pjuIUUrMqDGU3Uyk
X-Gm-Gg: ATEYQzxp1ZydwgnqrGgEzyQRQa7C3dKXaHay8n9w+9Bi1bfCAt5S3Ch09lo8t9j4g3s
	k0Tp00qdWxM1TTGR2UUNDHVDHWZLQKoZOa93W5PxeHTs59jWtH/7q18ou8vEgAJX9U+6T1l4Hzn
	8hXeSgLa73kFn3Qbs45o9MAOtvU/SQE26aFYgxRUqQ+JOl3p1vJ/Uan4r0R6pKOpD9E1rvocHnQ
	LMmLVW+zyjwUikzQWg+F1EqgXQ1bLE+OKOYC6K8GxVSXGFJ7xlW0WrnFqDpmr8n09OWOGg62ChT
	I2pMvs36NeASUkupgiWrftIpfarKjHyDcB6PRRNCb9ceEpChbsN2VthYRgRT1MOMZnzpt4/Z6rG
	POZUHwxvz7HO+ckGdNDWuXe8C77vNon7hL3byGrNFJGg788oyAWszCLvIqH2ESTJhkPl1IBetTy
	EgoPsxgvKgUzvmS1dSaSwZwojZZyQJCLzakUBAYun1nne3eDHjQRB+w7G6NqcYGv/52YDL2KqAh
	fu7xhIiPauSFDwEpFqWDhgSpkVhHsTACegiIyqMv60=
X-Received: by 2002:a05:600c:4fc4:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-48727f3b3bamr212955885e9.15.1774875901179;
        Mon, 30 Mar 2026 06:05:01 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-144-20-233.cust.dsl.teletu.it. [93.144.20.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eba4dsm19835020f8f.11.2026.03.30.06.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:05:00 -0700 (PDT)
Date: Mon, 30 Mar 2026 15:04:58 +0200
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: pierluigi.p@variscite.com, Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_ll: Enable
 BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
Message-ID: <acp0-qWerjms3n5U@Lord-Beerus.station>
References: <cover.1771930508.git.stefano.r@variscite.com>
 <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>

Hi,

On Tue, Feb 24, 2026 at 12:12:35PM +0100, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> TI WL183x controllers advertise support for the HCI Enhanced Setup
> Synchronous Connection command, but SCO setup fails when the enhanced
> path is used. The only working configuration is to fall back to the
> legacy HCI Setup Synchronous Connection (0x0028).
> 
> This matches the scenario described in commit 05abad857277
> ("Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk").
> 
> Enable HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN automatically for
> devices compatible with:
>   - ti,wl1831-st
>   - ti,wl1835-st
>   - ti,wl1837-st
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
> v1->v2:
>  - 
> 
>  drivers/bluetooth/hci_ll.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 91acf24f1ef5..6f060eec3b81 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -68,6 +68,7 @@ struct ll_device {
>  	struct gpio_desc *enable_gpio;
>  	struct clk *ext_clk;
>  	bdaddr_t bdaddr;
> +	bool broken_enhanced_setup;
>  };
>  
>  struct ll_struct {
> @@ -656,6 +657,10 @@ static int ll_setup(struct hci_uart *hu)
>  			hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR);
>  	}
>  
> +	if (lldev->broken_enhanced_setup)
> +		hci_set_quirk(hu->hdev,
> +			      HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
> +
>  	/* Operational speed if any */
>  	if (hu->oper_speed)
>  		speed = hu->oper_speed;
> @@ -710,6 +715,11 @@ static int hci_ti_probe(struct serdev_device *serdev)
>  	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
>  	hci_uart_set_speeds(hu, 115200, max_speed);
>  
> +	if (of_device_is_compatible(serdev->dev.of_node, "ti,wl1831-st") ||
> +	    of_device_is_compatible(serdev->dev.of_node, "ti,wl1835-st") ||
> +	    of_device_is_compatible(serdev->dev.of_node, "ti,wl1837-st"))
> +		lldev->broken_enhanced_setup = true;
> +
>  	/* optional BD address from nvram */
>  	bdaddr_cell = nvmem_cell_get(&serdev->dev, "bd-address");
>  	if (IS_ERR(bdaddr_cell)) {
> -- 
> 2.47.3
> 

I noticed that this patch has not received feedback and is now marked as
archived in patchwork.

I also saw that the CI reported some test failures (e.g. mgmt-tester and
others), and I was wondering if this might be the reason why it has not
been considered.

Could you please let me know if I should address those issues or if any
changes are needed for this patch?

Thanks,
Stefano
