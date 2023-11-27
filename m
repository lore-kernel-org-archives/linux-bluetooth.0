Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF729D28D
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lQjqsSBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B359BC433C7;
	Mon, 27 Nov 2023 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701073549;
	bh=32wd1LcJrhba6MmZdU1Ep6DLsF6PtYHOka5p4OoEN7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQjqsSBDpVX8/Pudoyw1tQTn/zeDfj8cwIRL7M5zy5QQCKAlm7tGi0OFB8NbASVyg
	 gzBapnMQxC4ymPkoEV2OQFbY7XheY0eQOYH+8f4mntH4YsAt54m8JXUDwPFEqeNB+1
	 JbM7nfZ1wPJQlIZMsav9sWugi5ljcuR+SbrlSo/w=
Date: Mon, 27 Nov 2023 08:25:46 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	johan@kernel.org, arnd@arndb.de, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
	Tony Lindgren <tony@atomide.com>,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org
Subject: Re: [RFC PATCH 3/3] drivers: misc: ti-st: begin to deorbit
Message-ID: <2023112729-qualify-relearn-6a72@gregkh>
References: <20231126191840.110564-1-andreas@kemnade.info>
 <20231126191840.110564-4-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126191840.110564-4-andreas@kemnade.info>

On Sun, Nov 26, 2023 at 08:18:40PM +0100, Andreas Kemnade wrote:
> The TI-ST driver seems not to be used anymore. For bluetooth needs
> there is hci_ll.c which has device tree support and can work without
> this one. Also firmware download support is there, so it is also not needed
> here. GPS can also reuse parts of the framework in hci_ll
> 
> Contrary from this driver, device tree support has been removed.
> 
> So start deorbiting it by marking it as broken.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/misc/ti-st/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ti-st/Kconfig b/drivers/misc/ti-st/Kconfig
> index 1503a6496f632..6bf9cc845745c 100644
> --- a/drivers/misc/ti-st/Kconfig
> +++ b/drivers/misc/ti-st/Kconfig
> @@ -7,7 +7,7 @@ menu "Texas Instruments shared transport line discipline"
>  config TI_ST
>  	tristate "Shared transport core driver"
>  	depends on NET && TTY
> -	depends on GPIOLIB || COMPILE_TEST
> +	depends on GPIOLIB || COMPILE_TEST || BROKEN

Why not just delete it?  Why have it stick around any longer?

thanks,

greg k-h
