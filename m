Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989E1D5154;
	Thu, 13 Mar 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860138; cv=none; b=qhjd2/i3JIPXEUYptBd3rilTwCEr6nF3ZCxYdMg4D8YThJxozSJMJCo72gTxpBH3HXdzFh1QEdXZRlY5I9F38GuEv8w6TusukZWBgrqvpO3SSnDJC9b/6R4tEfqqu1zz+IG5VwJA1NdQQEXXyI6UauxlNHPT6/kB2H73ngp9r6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860138; c=relaxed/simple;
	bh=28SNKFuUKmYECf/xgbAUTfIo4d8ZW3uLsrPe/o/eeUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLuBhhkrSrL+t1xLMLGpSz3V7FlDnve13Zsud3K4sXo/GYEoFKBjvWpgxUuFxlBGCy2wpWXyjTn8RgGevveSURc6Pzl14hyG0zx3OQhhwJkWKopwptcAnlqJkkLwoooj00KS0m0aeGfHCYpLfGnlzt9XuxpcdiOS80tBenS+gm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsOkOSoL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsOkOSoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB7AC4CEDD;
	Thu, 13 Mar 2025 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741860136;
	bh=28SNKFuUKmYECf/xgbAUTfIo4d8ZW3uLsrPe/o/eeUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsOkOSoLSOjEe7s81HwUhQsD7RS3b4Ugw4Wo66gvWXTlKFyL1ugmE1a+8a1dno8BX
	 inrAMn7L7LfCehOHigcJvTChdbgyhbg1WrZmgOEDfqum93WhbrSEF/URw0QPAPueGY
	 mH/v+e4Wwom1zHwm/CU2Bexv264Sl/riefhnE304=
Date: Thu, 13 Mar 2025 11:02:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: fix error handling in hci_register_dev()
Message-ID: <2025031306-distaste-humbling-39b7@gregkh>
References: <20250313083135.307357-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313083135.307357-1-make24@iscas.ac.cn>

On Thu, Mar 13, 2025 at 04:31:35PM +0800, Ma Ke wrote:
> Once device_add() failed, we should call put_device() to decrement
> reference count for cleanup. Or it could cause memory leak.
> 
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 54506918059a ("Bluetooth: Move SMP initialization after HCI init")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/bluetooth/hci_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e7ec12437c8b..c03fd16d3c46 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2641,6 +2641,7 @@ int hci_register_dev(struct hci_dev *hdev)
>  	return id;
>  
>  err_wqueue:
> +	put_device(&hdev->dev);

How was this tested?

