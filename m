Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F91643A;
	Mon, 20 May 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202944; cv=none; b=OxmpgkwL6mwBQ+GSEm5W6GhTChOrdtiDj4T6Uj4AnrWy4tbCrXAEsc7vwqdBqZyR8Kul6y6BaBseqVhbd3y2as3epukca/80y0H9LhcqslzLno7CzW9P2Q/y7oEW4Oyigfxe9qI5VC9NXjnZh1//5GJoR6eZm+FxVsM/KJXK+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202944; c=relaxed/simple;
	bh=fBMRsCfYJyR6hIrSKyh6obRGMiWNwGySypQNPgZYSl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgeiBdN8YJ67UsBqyHCZINrIL2bBbY14hOe3rpEEzF/s0/k5AlpY43/od6CB4oGwh8u1exoDmHD0t+SelWDXboitRSJHE/xZHtib2OW68RD0pbRshkC0m96HblqIOVCeSA8FLwZbMmPVIwdCfsRD2P4EFhNydWlJ92zUVFwyAo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y76dXG6F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y76dXG6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CF6C2BD10;
	Mon, 20 May 2024 11:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716202943;
	bh=fBMRsCfYJyR6hIrSKyh6obRGMiWNwGySypQNPgZYSl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y76dXG6Ff9lU0BseLExi/9Goan23DJwqM6QOWeL9VrauQ1i65KbvD2B7xRGnzJIRV
	 c7iZLWDvaQAi9T46TWXS/chVnyHoRXS1UtoSh+xBXJjokGvwcxb8aN5tkIqakxaZ4m
	 X1RL6xx5vDTWiJ0FnvEwIHgQWPg3Fe0UAtmWImTePIoPF1/805iDB5w0H54KD1+qG8
	 HgTSoOKYMT6QKZ+78TF6cRznbBFLe1O8DdeskLvn64kLH2d8QQLxPHbJRnkldDQAmA
	 MZ+n+z8GrIkUyvbBAki/9hXnltYr35GW/nUXxy67F3izkKlOeJ/ukglEFNi7HSvAkG
	 hv2boHYgq8JUw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s90mZ-000000003iD-1MbO;
	Mon, 20 May 2024 13:02:19 +0200
Date: Mon, 20 May 2024 13:02:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>, Kiran K <kiran.k@intel.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Fix the error handling path of
 btintel_pcie_probe()
Message-ID: <Zkstu34CQYwKdtfr@hovoldconsulting.com>
References: <692b4749f4267436363a5a8840140da8cd8858a1.1716190895.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692b4749f4267436363a5a8840140da8cd8858a1.1716190895.git.christophe.jaillet@wanadoo.fr>

On Mon, May 20, 2024 at 09:41:57AM +0200, Christophe JAILLET wrote:
> Some resources freed in the remove function are not handled by the error
> handling path of the probe.
> 
> Add the needed function calls.
> 
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> Maybe incomplete.
> ---
>  drivers/bluetooth/btintel_pcie.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 5b6805d87fcf..d572576d0dbc 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1280,17 +1280,17 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>  
>  	err = btintel_pcie_config_pcie(pdev, data);
>  	if (err)
> -		goto exit_error;
> +		goto exit_destroy_worqueue;

typo: workqueue

[...]

>  	bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
>  		   data->cnvr);
>  	return 0;
>  
> -exit_error:
> +exit_free_pcie:
> +	btintel_pcie_free(data);
> +
> +exit_free_irq_vectors:
> +	pci_free_irq_vectors(pdev);
> +
> +exit_destroy_worqueue:
> +	destroy_workqueue(data->workqueue);
> +

Please use an 'err_' prefix which is shorter and clearly indicates that
these are error paths.

I'd also drop the newlines.

>  	/* reset device before exit */
>  	btintel_pcie_reset_bt(data);

Johan
