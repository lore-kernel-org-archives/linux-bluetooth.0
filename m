Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C258206
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335403; cv=none; b=r87aYFytVjn1Pg54Da0v6z/D517mRioHcSq8hIR6/vfLXrsSP3webatKIwkpoUqMqvNWWDrspQ+DCMuKyTQ54tz/rb/gPUbswLgs0l34BGOTrFfyIKhNB94192aeaiZ0AfhXIbVtFCyTLyFC6+AdJz9unWVT8tZPXJgTf6kUIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335403; c=relaxed/simple;
	bh=689Ks9or6xLaFd02V40xCazLUDeU4WRLQmtkU7eFdAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFF6fASsfyuhrtXHgW8U9BP5GdfSEWIiVSroD89aXHx9TSLssakHQ4gEALrbWcQFZR3ABKGTDNPhj5aaY3am5Ic8zWKV59JVxbCy8XI/7febxbutZTrMkYRwVxPhdYXOE6lkEq7Yed3sg0k1A8DineFXDtyR428e5Ie0VHtYzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apYyWL+d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apYyWL+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD9C2BD11;
	Wed, 17 Apr 2024 06:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713335402;
	bh=689Ks9or6xLaFd02V40xCazLUDeU4WRLQmtkU7eFdAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apYyWL+dMUGUc5Q9SVr9QEnovTzhVxEpP7Yq0SlqOjHMf4RC7ueP5uPw/7BEKYtqq
	 s08uYcfukRFmdnKDZE8qRAx2j9KoPUmdzRKdTbeNOfPaB9uEvUgUMtp/EzHFtw83m8
	 HF8jh1ap8y+5D9Wa7QEgJ19UG3aHTlRh/ErL7CmfawbIhjIOuA4FeH6lXRwpo9hLiu
	 QRkfVQoKTbB16SVBVOV5mgrQe/a8vF16imu76HQSN1Fg2w6IItFqyLBbhlnLOCDw6o
	 vOW+ltVjA0j2m5dlB9sHcmVzqcwyO+mRD0S2okhb3Ntd9ct8X9cbnfHCF6jQKiSBXv
	 7jQtOJi0Bn9iw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwynw-000000001p6-2y7i;
	Wed, 17 Apr 2024 08:30:01 +0200
Date: Wed, 17 Apr 2024 08:30:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH] Bluetooth: qca: Fix nullptr dereference for non-serdev
 devices
Message-ID: <Zh9saGbOl-fXP6SD@hovoldconsulting.com>
References: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>

On Wed, Apr 17, 2024 at 11:49:52AM +0800, Zijun Hu wrote:
> hu->serdev is nullptr and will cause nullptr dereference if qca_setup()
> is called by non-serdev device, fixed by null check before access.

No, this patch is not correct.
 
> Fixes: 77f45cca8bc5 ("Bluetooth: qca: fix device-address endianness")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 92fa20f5ac7d..9c6573c727e1 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1905,10 +1905,11 @@ static int qca_setup(struct hci_uart *hu)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> -		qcadev = serdev_device_get_drvdata(hu->serdev);

Non-serdev controllers have type QCA_ROME (see qca_soc_type()) so will
never end up in this path.

I verified this when I wrote the patch and also fixed up a couple of
real non-serdev bugs here:

	https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@kernel.org/

> -		if (qcadev->bdaddr_property_broken)
> -			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
> -
> +		if (hu->serdev) {
> +			qcadev = serdev_device_get_drvdata(hu->serdev);
> +			if (qcadev->bdaddr_property_broken)
> +				set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
> +		}
>  		hci_set_aosp_capable(hdev);
>  
>  		ret = qca_read_soc_version(hdev, &ver, soc_type);

Johan
