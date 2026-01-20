Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53943A89D1
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946455; cv=none; b=pwn/Ca78gjAP3SFRQol4kHz6HLVi+a5f0AmRy6MSwf5vK8SwXaRWtfbNrPGB28Ite52L1HBrFWWIuYCucDFYuypRgPzzA74cENjPjugcsDryakhEYom4sMel3arP3Y+gYxkgADKApw4egA6vuW7SrWkl9yyAFVSZJze5s2TDgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946455; c=relaxed/simple;
	bh=bkwTmc3t59B1CRnLqZGN+9XNpuTqLrElFEGSvfz6OpA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWssFiZEHc7wQLgQohic+IadUO+20IPoUpnz7PN4Dsttt+It+HqXSCoPUsbZdFs0rukKVhsU4EncMVE4SExulqLN2814Qe3BcQ9dgOxM1J31J6RaUZbvA5syiPF+w6Ny910xX9kUYVtqhQuhR6DOszC+K3DGw2kdX9qqkKBbVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 81BF05801A2
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 21:41:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A278A443B8;
	Tue, 20 Jan 2026 21:41:25 +0000 (UTC)
Message-ID: <a7ca31e78a187d6912dde7a3cb9dbddace349fc4.camel@hadess.net>
Subject: Re: [PATCH v1] fixup! Bluetooth: btusb: Use pm_ptr instead of
 #ifdef CONFIG_PM
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 20 Jan 2026 22:41:25 +0100
In-Reply-To: <20260120181717.2321998-1-luiz.dentz@gmail.com>
References: <20260120181717.2321998-1-luiz.dentz@gmail.com>
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
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeefleefkeejhfekffeltdetheekkeelhefhtdffkefgjeffudelgedugfelfffhudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugeptedvjeekteeggeefueekpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehluhhiiiguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhto
 heplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

NAK, see explanation at:
https://patchwork.kernel.org/project/bluetooth/patch/20260116125803.598552-=
3-hadess@hadess.net/#26748187

On Tue, 2026-01-20 at 13:17 -0500, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> ---
> =C2=A0drivers/bluetooth/btusb.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 759def260ed0..f9fba78f0a4a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4468,7 +4468,8 @@ static void btusb_disconnect(struct
> usb_interface *intf)
> =C2=A0	kfree(data);
> =C2=A0}
> =C2=A0
> -static int btusb_suspend(struct usb_interface *intf, pm_message_t
> message)
> +static int __maybe_unused btusb_suspend(struct usb_interface *intf,
> +					pm_message_t message)
> =C2=A0{
> =C2=A0	struct btusb_data *data =3D usb_get_intfdata(intf);
> =C2=A0
> @@ -4557,7 +4558,7 @@ static void play_deferred(struct btusb_data
> *data)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static int btusb_resume(struct usb_interface *intf)
> +static int __maybe_unused btusb_resume(struct usb_interface *intf)
> =C2=A0{
> =C2=A0	struct btusb_data *data =3D usb_get_intfdata(intf);
> =C2=A0	struct hci_dev *hdev =3D data->hdev;
