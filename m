Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662D21345;
	Tue, 13 Aug 2024 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552722; cv=none; b=BZcE96Ir3IgdXeTL6WRhYaBY3cFl0e7QtP6DdnDZFWnt/lhH31ELUMsCyzpHs8lgRWH34DU91F0/O/wHuYt6sMaZTz6Jfv27wTgYMgIlkiLKm/CFQZm99T2ERhlZgGMTxpcjnlUtG3n23WuVQNwNeIvqm1eD+xI81wFAB0WQxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552722; c=relaxed/simple;
	bh=lPTcntDWAP9ZgrzLsA+hOyT0ui0pqN4m3i/LqJnLmFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+biQcNkkfmqwLgwB25yDzvbPFIcLOzVIZPqvW0ReIjOX4jLZtATA4+JYZ1deraa5TWAJVxwvqC2UDB5vrGx81FWDIJyommuTAuWybYOAFL/XIiI7heHtRHPUrJDTUG+1XFd7ZPL7gntI0d0+sdm+N+poHMCy1nlOFRNWi80kU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0cX+7TfR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0cX+7TfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91123C4AF09;
	Tue, 13 Aug 2024 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723552722;
	bh=lPTcntDWAP9ZgrzLsA+hOyT0ui0pqN4m3i/LqJnLmFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0cX+7TfRqnxA52EUeFcWVvXT1TPDxiTG7r7LUyim58LTr5X/MePsa1u7EigjNb63+
	 OdhvQrKt0NgF8YogQ27Z+ul1zW0o4FoCq7HhcClzAIxPZp+5J1UvFn2EHIYrwsU91R
	 Mar+RDQZBf5IYYqMIR8Sl+iTokzSZBHxEHdpz3vw=
Date: Tue, 13 Aug 2024 14:38:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net,
	skhan@linuxfoundation.org, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: vhci: manage mutex with cleanup helpers
Message-ID: <2024081309-lion-overlying-16a1@gregkh>
References: <20240813121829.6693-1-0xff07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813121829.6693-1-0xff07@gmail.com>

On Tue, Aug 13, 2024 at 08:18:28PM +0800, Yo-Jung (Leo) Lin wrote:
> Use macros in liunx/cleanup.h for automatic resource cleanup.

That says what you do, but not _why_ you want to do it.

> 
> Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
> ---
>  drivers/bluetooth/hci_vhci.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index c4046f8f1985..70f0c28372ec 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -19,6 +19,7 @@
>  #include <linux/errno.h>
>  #include <linux/sched.h>
>  #include <linux/poll.h>
> +#include <linux/cleanup.h>
>  
>  #include <linux/skbuff.h>
>  #include <linux/miscdevice.h>
> @@ -468,9 +469,9 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
>  {
>  	int err;
>  
> -	mutex_lock(&data->open_mutex);
> -	err = __vhci_create_device(data, opcode);
> -	mutex_unlock(&data->open_mutex);
> +	scoped_guard(mutex, &data->open_mutex) {
> +		err = __vhci_create_device(data, opcode);
> +	}

This isn't correct, but also, it's not needed at all :(

greg k-h
