Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554D1F9439;
	Wed,  8 Jan 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339704; cv=none; b=lFgDVHJPXS7ORqK1+4ZLYZlia5VIuVVb0OR8jqkBO5/utCJJM/gClUlzr3V4zkiU/AvkEaSQ65z59anUkshUdRjufiA6CMOzkCal7s/Jmmxfx4g2JqiqtqnPjfruOSJJhSdyQdDOc0tmqRoBT28+3Zkt5Rk00JT6t5N2YABYMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339704; c=relaxed/simple;
	bh=XiqgXQSq6h3Ea566q9OSfjNtArqIB3Kkh/iT/oZqjno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6tq5pjcPwAC8Zaz87AqsnN3ydSI2X4ZEtQP5mg/XTNwprbA45oDc/bGstrTH5o9jIZOTLNeI1fhxQqbaAlTZOaMOCiPoPGXBBahKUg0xiokVeoLjE58cZUNvj+nmUdiwQPwhYMbuAy7NmtT4yr3nBuhIAcIbRDCIq5kXRhwK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pjOWrciu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pjOWrciu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C6FC4CEDD;
	Wed,  8 Jan 2025 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736339704;
	bh=XiqgXQSq6h3Ea566q9OSfjNtArqIB3Kkh/iT/oZqjno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjOWrciujK7/fvkiAeuLTVaghuYZny2ojvz8QokV4e7nqAMD9WoFYycW5MX/c7938
	 LyWURbTalRlJ3g5a9AB2BMJxaOEooUPAEta1VOP4aM2cCDCmE3CT4GyoL+Iez/10pG
	 6NZAtEpFm2jGcHOHGDguAJQtkslMe4qnxMFSN4WE=
Date: Wed, 8 Jan 2025 13:35:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	chromeos-bluetooth-upstreaming@chromium.org,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btusb: add sysfs attribute to control USB
 alt setting
Message-ID: <2025010805-frostlike-engorge-fe1a@gregkh>
References: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>

On Fri, Dec 13, 2024 at 12:04:22PM +0800, Ying Hsu wrote:
> When a Bluetooth raw socket is open, the HCI event related to SCO
> connection changes are not dispatched to the hci_event module, and
> the underlying Bluetooth controller's USB Interface 1 will not be
> updated accordingly.
> 
> This patch adds `isoc_alt` sysfs attribute, allowing user space
> to update the alternate setting of the USB interface alternate
> setting as needed.
> 
> Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> ---
> This commit has been tested on a chromebook with AX211.
> 
> Changes in v2:
> - Add check for the existence of a valid USB interface 1.

You forgot a Documentation/ABI/ entry.

Also, the code isn't quite right:

> @@ -4008,6 +4034,10 @@ static int btusb_probe(struct usb_interface *intf,
>  						 data->isoc, data);
>  		if (err < 0)
>  			goto out_free_dev;
> +
> +		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
> +		if (err)
> +			goto out_free_dev;

You just raced with userspace and lost.  Please properly use a device
group instead.  That makes for smaller code, and it works properly.

thanks,

greg k-h
