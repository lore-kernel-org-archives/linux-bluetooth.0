Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1897C1607BB
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590934; cv=none; b=ZRuGNk4/IspJwgxXKLTRycA3IzSwm7Rhev+aYOdisGP+m5kujKX7leGCxGsd0WXb0yYV2YZouOZpctUl8PTLwkWtYjUQyzqSpy9rafs1JOw7uGesqztGbhtHM/LlGOpSF1FH0eyLCWG2mLL5r4pm/9kuyOs90Nv079pAm4mqBPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590934; c=relaxed/simple;
	bh=FjDFufbsvnrKVpq/d3f57SbbkDccuVf6Mo7zLPWNI0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXAatIXNGwFEJ7rQKS2EPmB8BuJ4kKjsr2lAYE58VY1cUu9jxRy6e1+wsaMsCLsHwdaKxSlItRhVVgPIbV5O0PC/muAiWEbp0zYPTtoINPcKaR1MZcMv6Dl8nG+09JpDI87AcSGau7gVi5lcHqSVhvkKdXSZxXNJxo9z8YvwaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JmhrKOGP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JmhrKOGP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed627829e6so8414662b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714590932; x=1715195732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrKZAQFL0Kmixa3h9nt3N8Wwlmo9DHZavjvoHsUvpdY=;
        b=JmhrKOGPNOqzHr8k2ATuVWV9FcWJ5q0nf6hFu8OGHjzWNdlwoQZs60KS6TQCNuqRw3
         iNooqKTSGhjXNpn+4/uw5iJgXQe6vOLFZXXxa9eZHKE/FB6B2PCYJ/tlvS+mnB0mGtV2
         ca2z7FQT16EvzATAzO0PKBAfY6PFOlohuX2D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714590932; x=1715195732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrKZAQFL0Kmixa3h9nt3N8Wwlmo9DHZavjvoHsUvpdY=;
        b=typ1D2fljMHrMGc9MgAHhMWCmnKyTakJDHFebnx/6YL520/MSUvJDwZ3KRB8X9XU5B
         zdGcHPh4Mx56DrAFUQETVGdCctwaIoDTg+dEMVMskmblphmHDIHoZ3NKOT1tekOM+cH4
         GbObCGVvOoO/dZKyqai2OzQSkGU2enGJh4HPugo6fChE/kR8T4Fvzu8LrJazcBf2m4+0
         HHnPxS5WiERpHTSwoE8u1BeEK6zTWP03SMQ8TG7dNqMQIxVHwMpHsZAEpzk8ZvHiK3X6
         Im4KCRA36sNHzB0oj1WclvAVPKgbru+6pQlIBXqZl9hUspEE4ADAsfxRnbXjgMMTXUrU
         wwDA==
X-Forwarded-Encrypted: i=1; AJvYcCWTGg4mYXCKB9eSKmqxh2eE/3nWrzaF+xamxsc7NBbhHztZ58frETxMskJLCIUd8mDbOL9maMHq1IcZRMSu8HAWMooz4UaaUJYDXMCXP4dm
X-Gm-Message-State: AOJu0Yz7Ma+2o8ESFdjLPrMO0q8aZ9LPs/x4ExUmwO22v5ECKketu8kT
	tm75ffjcnj044OSv/iTa+yEU0obgqNeqy2Ztd8j3U7XBaYw7yE8xFNsH0ywkAg==
X-Google-Smtp-Source: AGHT+IEha+gO+FpGkm9o8MQRL+GDzeOY8CJgsWHInozyoylrwPFagTvr8PCPZBBqlxdqKOVB+3C9lA==
X-Received: by 2002:a05:6a21:606:b0:1a9:c80a:bdcf with SMTP id ll6-20020a056a21060600b001a9c80abdcfmr3454424pzb.2.1714590932324;
        Wed, 01 May 2024 12:15:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b006eac2a25631sm22896185pfm.129.2024.05.01.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:15:31 -0700 (PDT)
Date: Wed, 1 May 2024 12:15:31 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Bluetooth: hci_sync: Use cmd->num_cis instead of
 magic number
Message-ID: <202405011214.EB46DAB416@keescook>
References: <ZjKAyg2bZNyTcT+C@neat>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjKAyg2bZNyTcT+C@neat>

On Wed, May 01, 2024 at 11:50:02AM -0600, Gustavo A. R. Silva wrote:
> At the moment of the check, `cmd->num_cis` holds the value of 0x1f,
> which is the max number of elements in the `cmd->cis[]` array at
> declaration, which is 0x1f.
> 
> So, avoid using 0x1f directly, and instead use `cmd->num_cis`. Similarly
> to this other patch[1].
> 
> Link: https://lore.kernel.org/linux-hardening/ZivaHUQyDDK9fXEk@neat/ [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 6e15594d3565..af9513f3c451 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6559,7 +6559,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
>  		cis->cis_handle = cpu_to_le16(conn->handle);
>  		aux_num_cis++;
>  
> -		if (aux_num_cis >= 0x1f)
> +		if (aux_num_cis >= cmd->num_cis)
>  			break;
>  	}
>  	cmd->num_cis = aux_num_cis;

Yeah, good idea. No need to repeat a hard-coded value.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
