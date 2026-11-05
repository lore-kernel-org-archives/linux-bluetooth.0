Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898336;
	b=1NbCBJqoRkED/+NSxIpik+qNOxk5e+FCYkuoxz+mV8LHTzl8QfOZYarYQGG3ykpv24Fr
	 Zyxw5+qSwg91fMK9NypdPXxJr7g+DkVeVanHG/rYE176xKRjrnqG6ZtizXUgReB1osw12
	 DXtW8P1fD2Q6xkK1GBPWFPMzmzxqISxgfWTAvrZTYOT/PwzKf1GhvOFZdZEJGk7AwnRvV
	 FdjNrAio9OKGVD8RHCBev2RJ7W68/R1W2240u5R+ClFbjISsXO1qwaGt6XsvRxmqhtNRR
	 tVmoTftQCMNkXQAyh0XAqW3ygosx1eiHoJe/bPS4dlC0cerRJRVCSTP8sxLntzZvkpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
	b=h2Tk8n2atjQzCXY6br70beEWL9z/F0FKuA4ouqfKqXqwWlDxPV4s07dxDsNRNfyj/0O+
	 VxnUNi/XkUb2A/qD/ETMXH6H9ILIux+hZrdZf9BQzWU0C4wvabMcuXai6sOTmALf8CJLE
	 nDavsSE67wrTr2hZQYwHgAEX6d1WKpfYpVP5Zms1F9/8f5AkEy8boHloWdJ5vLGBWaRWr
	 rXoW7rX6vzvCJyn36jMyZ1zwoP6EtGphmMlsZ45OqYeM+hltItf0tPo5TziiiXNdNkCww
	 ygHVNdOvEqpaScM8Fk5XH2sSF520PI+0A0GDWI6hFxM9wwQUUuK0xrp2kha518Fi7PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezhGUhXo;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E0606D80A
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C5E0606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezhGUhXo
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3516061eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898335; x=1794503135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=ezhGUhXoIUl09y6+rx0VThMrADfNJzLtbjELvheIq2XUjEVn+F/n+Ri2C53TV9L6Aq
         JdGhkEmCnwmkPVTv0OB6x5RGwGBQJHUjt1KyKJv1eSBurgKo52RA3J8/QRIyxJZsDOQU
         n7s5HLJdofzUUsrlUP5HhN1OEHjO1pTWgNUtwsTp5+pkRYp1fI+C+uqlY+LxQRirvNrb
         Ex3MFhTRMHWMTtME2TIEuo7EsT/3ZplABIXud7NOWlPeo0lDAdVbld/IOwaCZ8vfz4uj
         z22wAGLVFJBUWinFMtheNWfoQbFjMbEjptQEjYgl4R/mPdYwQwSpcnETlWlj/Aj3CrCr
         m0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898335; x=1794503135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=x5O8f3gqik0JWkcNjXOb/dQAc8R51nXvyJvsZ1xGkSoxpp08vIC2Sqov2KxFBWNbzt
         I2m4dz9DKfGQRW81kI4cPcw0IrLN5tRCTZBk9JN0uraNoRbyQAAgB1FTdZZ5mfUoJSCs
         uXGZm/JmS073BGRQ2/U7k7BuoBYVEhgcecJ4Onwa5zShzQ8fOz3s2ffNhLAy4ZB1ZctF
         EDxCsjX7+LDZY5iSfkgWYhJCbmJXo04SzhPhnJUdV0g+6K3n3Hfeiu8QvAcLBwunTpk8
         +Bhwg58ziv//0b5KXUVGpSDP1Bxg/ohi1UhUK+I+Xm5AsusBEK7YhM2tEZV0jW0AWOqj
         wjlg==
X-Forwarded-Encrypted: i=1; AKwUvBxyVEd+O6S76YDRyuWJKjtfyyLoS/gFXhIdhuicpJtE7c8CGV2XLSBqTV0Xp3mFVirbzJ6IG3OJPVsbjkzagdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OHlA4gZgWwwL2Ml+9h5ZYwDRz3cW/9uk2EXyiKVGx1Jxu5/Ox
	YWq2GL9FgU3vRGJnUGbxN4lg0rJaaR/9rBYVmQzw43sBYbvFci81g6wB
X-Gm-Gg: AYBFou0Zhqw2nzhk7v1pNTZAVsH24AWcDpiOzQ2DG627pk8Hl/Li9LSSTz+e/LAK+KH
	C1baySXiF7ethZaQoO335RJ8m9gGVDW++C7NppN/2bVLLLT85UJebA32k4iOu+qyFXnDRgY7Slm
	TNpsn2uwCmm/GAtTWFLebd7aoWYJWfHoUAhEjDxJC8VA8b5bun82MTZRXbC057BPgQ4nX5sdOqr
	xv7ohDNo4S59kF/LmllD+DfaqGqxQe0ODOAeoDlES81g6MME33PFtTlH2pI0nDDq41v0pLiJaqg
	jjo5v11p11fH2yqYL4Jk5NumPVoC/V6gDGuOJDKHvLbXFa3LSFuAOZCHmSCJb1ZUSkzJcoPxs0O
	yuJb7YrisuVtqz0DbohFHlHNWVwNWeA5UsBzACo3qGF2rZ1ch4L9xJnjQexPfz4MvOvRgqT1BjM
	yF0VuUt4RMVPbKXMZyqZbolL1ZddWgm2W4BYqtrFrKHQvgzUgIp7aEjNaZ6ezRWJMOaJkGW0w4r
	jbNTv/JqtTfyIbu5o5v3nh03fKOgDSU+7Kzt/Y5qKO8q8Ql1xZSU9nevjTqwPIDc7Wi2Vu1wVKN
	bgHYPHEtQMOFxsAlczk1updC9JuriKq/AzZ7nGW461XwR2f0TmpR8bk6GF4UNOGJj/QR8n8oKjZ
	XtM9UfujtQHDS35s=
X-Received: by 2002:a05:7300:fa0d:b0:36d:7feb:8bd3 with SMTP id 5a478bee46e88-36d7feb8e1amr5835338eec.11.1793898334471;
        Thu, 05 Nov 2026 09:05:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm23943795eec.25.2026.11.05.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:05:33 -0800 (PST)
Date: Thu, 5 Nov 2026 09:05:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, linux-input@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 02/17] Input: serio - attach manual drivers through the
 driver core
Message-ID: <auy2plYVi723Qt42@google.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:15PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Manual serio binding connects a driver before driver core can admit the
> device. A rejected binding therefore arrives after functional setup.
> 
> Keep the port ID check and use device_driver_attach() for the existing bus
> probe path. Driver core then serializes admission and handles probe failure
> before publishing the binding.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/input/serio/serio.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 54dd26249b027..604440244c1ca 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
>  
>  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
>  {
> -	int error;
> -
> -	if (serio_match_port(drv->id_table, serio)) {
> -
> -		serio->dev.driver = &drv->driver;
> -		if (serio_connect_driver(serio, drv)) {
> -			serio->dev.driver = NULL;
> -			return -ENODEV;
> -		}
> +	if (!serio_match_port(drv->id_table, serio))
> +		return 0;
>  
> -		error = device_bind_driver(&serio->dev);
> -		if (error) {
> -			dev_warn(&serio->dev,
> -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> -				 serio->phys, serio->name,
> -				 drv->description, error);
> -			serio_disconnect_driver(serio);
> -			serio->dev.driver = NULL;
> -			return error;
> -		}
> -	}
> -	return 0;
> +	return device_driver_attach(&drv->driver, &serio->dev);

I am not sure how safe it is, serio (and gameport) have pretty elaborate
structure and locking rules because they can recurse into themselves (to
support case of Synaptics touch-pads with pass-through PS/2 ports).

But this call is for user-initiated probing anyways, I am not sure if it
even needs "trust" handling.

... And I even thinking if we really need to keep these custom
attributes or if I can rip them out in the future ...

Thanks.

-- 
Dmitry
