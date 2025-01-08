Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F038F82;
	Wed,  8 Jan 2025 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339642; cv=none; b=P3Zuy18ddmBWCeNSfWQRbtvPY9oqJ962bgB2NEMGYhY07OMblbPJXF5zSwYNaCd1M3KeBOaB+V5ZbQqaoD7R9jhZRuM5CyzFc+JSr58TTBqqb+ViUnk54bco4cEoIE8R8pXrma50MbWh5qb6vF1troQj4aEzCIjvqC3rPqyMDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339642; c=relaxed/simple;
	bh=sOsTyYPxi9zCvgGo5S58+cHjPJPg0HTDGDoFHT4wzwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0j6ZY1/X2/kvLilQzO64/WKqwH+guzBphJ7CEKkXg1+8SQkuHKtdDfKC7ClFHSllLvY4tP0tnJAWZwf4DNvaTv/3Mqe9ieZf+kqFHvVETiQ/WPntmXWMqsEewrKD8FG1/a6gEfmOhKoG+Rok/y/k36zLIen04TMQQPnxJ8J0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpdFo+/U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpdFo+/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28FEC4CEDD;
	Wed,  8 Jan 2025 12:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736339642;
	bh=sOsTyYPxi9zCvgGo5S58+cHjPJPg0HTDGDoFHT4wzwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpdFo+/U0bdYZSbxkUOmQlo7vbg+2wGT+gRHwDC5XwOLR/UMci2tnlYFZ6nroMcym
	 ow47iwlqsUW79RXNw/Miv5lxt6PXe21ALo2TY7JLTTGW60RgYMhCe37MtqZ7h7FTgL
	 vdIStAGbAgBXS0bbmDNsBhMtk5blzcS6NqSLVU5o=
Date: Wed, 8 Jan 2025 13:33:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-chen Chuang <chharry@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	chromeos-bluetooth-upstreaming@chromium.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow reset via sysfs
Message-ID: <2025010829-used-halves-7342@gregkh>
References: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>

On Fri, Jan 03, 2025 at 11:20:20AM +0800, Hsin-chen Chuang wrote:
> Allow sysfs to trigger reset via the cmd_timeout function in hci device.
> This is required to recover devices that are not responsive from
> userspace.
> 
> Also remove the cmd timeout count in btusb since we only ever allow one
> command in flight at a time. We should always reset after a single
> command times out.
> 
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
> This commit has been tested on a Chromebook by running
> `echo 1 > /sys/class/bluetooth/hci0/reset`

You forgot the required Documentation/ABI/ update for your new sysfs
file :(

thanks,

greg k-h
