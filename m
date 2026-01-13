Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205843876BB
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296513; cv=none; b=rFU2eTcgVJHn5r0lWUV3Zs43tTMCyuZtxYxtAiSPwzRrrdZhLYMJTGTUqfQYF3pjFdw5VMqevzvHeJYMwMBY56X/CYCZHZk5Wtx2DZIw1VmUK2MQS6Hgup6BmuqhG48ceNM1KM3D758nnjqDHPr0HYisr5zxbISgihXkdhAHURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296513; c=relaxed/simple;
	bh=EOx/sO8epeqCXXEQHt3ku4XDnaMbvqYSSSKHiOA0S+g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fn2P3Il5oz3XS1kyAlBZhsQs8pfmX5Cj+ELxc3DVR7IC6puP/vLWBCxVTUmQsPYTRNs66jc/63ctHW9Ppq+/4iYJb6clex5uHKhfG5AL1VFHTMkuNTb2hb1vcHqTDmhV0KZKL9Jdh2SdWn6Yk9hKvBJYYcxeyITvTcvHpJIDvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 452B041DDA
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 09:28:18 +0000 (UTC)
Message-ID: <815c465ba9f92718b92cd35391238a2948cbb994.camel@hadess.net>
Subject: Re: [PATCH v2] Bluetooth: btusb: Use pm_ptr instead of #ifdef
 CONFIG_PM
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 13 Jan 2026 10:28:17 +0100
In-Reply-To: <20260113090128.244709-1-hadess@hadess.net>
References: <20260113090128.244709-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepueeviedvteekkefgfefffeethfejieekteffvdetjeehfeeileettddvueeludelnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgeehvdeutdegudffffetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

On Tue, 2026-01-13 at 10:01 +0100, Bastien Nocera wrote:
> This increases build coverage and allows to drop an #ifdef.
>=20
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

I see v1 landed. What's the best course of action, revert v1 and apply
v2, or should I send a "Fixes" patch?

> ---
> Changes since v1:
> - Fixed build
>=20
> =C2=A0drivers/bluetooth/btusb.c | 8 ++------
> =C2=A01 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ded09e94d296..67ee2b869852 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4462,7 +4462,6 @@ static void btusb_disconnect(struct
> usb_interface *intf)
> =C2=A0	kfree(data);
> =C2=A0}
> =C2=A0
> -#ifdef CONFIG_PM
> =C2=A0static int btusb_suspend(struct usb_interface *intf, pm_message_t
> message)
> =C2=A0{
> =C2=A0	struct btusb_data *data =3D usb_get_intfdata(intf);
> @@ -4616,7 +4615,6 @@ static int btusb_resume(struct usb_interface
> *intf)
> =C2=A0
> =C2=A0	return err;
> =C2=A0}
> -#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_DEV_COREDUMP
> =C2=A0static void btusb_coredump(struct device *dev)
> @@ -4633,10 +4631,8 @@ static struct usb_driver btusb_driver =3D {
> =C2=A0	.name		=3D "btusb",
> =C2=A0	.probe		=3D btusb_probe,
> =C2=A0	.disconnect	=3D btusb_disconnect,
> -#ifdef CONFIG_PM
> -	.suspend	=3D btusb_suspend,
> -	.resume		=3D btusb_resume,
> -#endif
> +	.suspend	=3D pm_ptr(btusb_suspend),
> +	.resume		=3D pm_ptr(btusb_resume),
> =C2=A0	.id_table	=3D btusb_table,
> =C2=A0	.supports_autosuspend =3D 1,
> =C2=A0	.disable_hub_initiated_lpm =3D 1,
