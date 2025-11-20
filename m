Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313F38DD3;
	Thu, 20 Nov 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622746; cv=none; b=pEkqD1LZZ8jSLJ/WtBppQqxWKo9EJPa+F6p7vGfxsci5HgE0Aqw0kVY7B7wqh+f3Tf0Dx5yl+kSFHxnTvuZCFoCwLxfI4TUjfCwWz488fWjt9LCpjfAnDqXbMmbmdtxv+WmADysvQvfjVSGNc1TcAochHhDZ9mnzvHavvEiwEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622746; c=relaxed/simple;
	bh=EQAgnumsg/0/HohGZhlQ7lZ5l81gXXG25tXu/zMDTTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSLaKLVpocVwztdhiQgpSry3Gkp8I+S36YVwluoULq1rCD0RsdM6HTfKSAmyFMeSAN+X646zwVrQt3NsksPr6BU+oNds0+E0X09xnzkCRDBQhg0+daiBE+atyXxqr5oNY7u5ResYa/zBOLhwk1XhZC838tjxYJMqOXlnELqbal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btUsB5fh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btUsB5fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124A5C4CEF1;
	Thu, 20 Nov 2025 07:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763622745;
	bh=EQAgnumsg/0/HohGZhlQ7lZ5l81gXXG25tXu/zMDTTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btUsB5fhDPjSTktDnq3DzzZZd54B9/cGdxkWXeQFdks6o228NwGaJUnKsLivooWZo
	 nznEHs9HKpv1QPdi7ap+eFfheA8tsBbn/BHOFILYDEz4wUcr/K4QajByN3GAUF8EUv
	 Z0ca5yNesER+GfsIOyEUp6DVcSTQKsPIV1ObkKmM=
Date: Thu, 20 Nov 2025 02:12:19 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	incogcyberpunk@proton.me, johan.hedberg@gmail.com,
	regressions@lists.linux.dev, sean.wang@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Bluetooth: btusb: mediatek: Avoid
 btusb_mtk_claim_iso_intf() NULL deref
Message-ID: <2025112007-quit-enable-3fa1@gregkh>
References: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>

On Wed, Nov 19, 2025 at 08:53:55AM -0800, Douglas Anderson wrote:
> In btusb_mtk_setup(), we set `btmtk_data->isopkt_intf` to:
>   usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)
> 
> That function can return NULL in some cases. Even when it returns
> NULL, though, we still go on to call btusb_mtk_claim_iso_intf().
> 
> As of commit e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
> usb_driver_claim_interface()"), calling btusb_mtk_claim_iso_intf()
> when `btmtk_data->isopkt_intf` is NULL will cause a crash because
> we'll end up passing a bad pointer to device_lock(). Prior to that
> commit we'd pass the NULL pointer directly to
> usb_driver_claim_interface() which would detect it and return an
> error, which was handled.
> 
> Resolve the crash in btusb_mtk_claim_iso_intf() by adding a NULL check
> at the start of the function. This makes the code handle a NULL
> `btmtk_data->isopkt_intf` the same way it did before the problematic
> commit (just with a slight change to the error message printed).
> 
> Reported-by: IncogCyberpunk <incogcyberpunk@proton.me>
> Closes: http://lore.kernel.org/r/a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info
> Fixes: e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I have no way to test this commit myself other than to compile it. It
> looks fairly straightforward, though, so I'm hopeful it will fix the
> problem.

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
