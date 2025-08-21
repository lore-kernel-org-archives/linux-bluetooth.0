Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF71322763
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781917; cv=none; b=PBUc8k86yM0UWdbNfupSl77jsYrJh8JAwINgICC9rbagqMHgtag68RSZYSKlTpuyosK5jZvI2uiV+S0VtqGogRnKgUW0tYvKGizeq3dLIWhh3RPyFZRsmTTbdtVXFuM3h9bbFenIz0J8mO6xh10yZHLZZkgRpQVBnGKhruSTWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781917; c=relaxed/simple;
	bh=6sYI+HzQiyeYnKFTCM+ml4CrrY7lluGvUAY0GFBC7sA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dUqAz0CjYLwERTOZIfBdEskYJU8C9OS3E68zOueP2siUfbL1IFOD818DqWBgpsUKpifBh4rgy4qzZ7v2k4ABjtdhQc6+OoTG8PENb/o+G/mJf1is5bg6UWy7ACc41sGXcrlOdrYsfRP6kpxE8XQroPlAUTgmaFQwPc4Kq8r8RNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1834F43369;
	Thu, 21 Aug 2025 13:11:52 +0000 (UTC)
Message-ID: <ef0f1cc955f7147f8f4d280e15e95d0dd7b532c1.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/2] profiles/input: Add cable pairing constants
 for DualSense
From: Bastien Nocera <hadess@hadess.net>
To: Egor Vorontsov <sdoregor@sdore.me>, linux-bluetooth@vger.kernel.org
Date: Thu, 21 Aug 2025 15:11:52 +0200
In-Reply-To: <20250603095617.92785-2-sdoregor@sdore.me>
References: <20250603095617.92785-1-sdoregor@sdore.me>
	 <20250603095617.92785-2-sdoregor@sdore.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepueeviedvteekkefgfefffeethfejieekteffvdetjeehfeeileettddvueeludelnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehsughorhgvghhorhesshguohhrvgdrmhgvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net


On Tue, 2025-06-03 at 12:56 +0300, Egor Vorontsov wrote:
> Sony DualSense & DualSense Edge controllers support cable pairing
> the same way as previous Sixaxis controller generations do.
>=20
> This patch prepares their input profile for its implementation.
> ---
> =C2=A0profiles/input/server.c=C2=A0 |=C2=A0 3 ++-
> =C2=A0profiles/input/sixaxis.h | 25 +++++++++++++++++++++++++
> =C2=A02 files changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/profiles/input/server.c b/profiles/input/server.c
> index c8be445c7..68105d48c 100644
> --- a/profiles/input/server.c
> +++ b/profiles/input/server.c
> @@ -122,7 +122,8 @@ static bool dev_is_sixaxis(const bdaddr_t *src,
> const bdaddr_t *dst)
> =C2=A0
> =C2=A0	cp =3D get_pairing(vid, pid, NULL);
> =C2=A0	if (cp && (cp->type =3D=3D CABLE_PAIRING_SIXAXIS ||
> -					cp->type =3D=3D
> CABLE_PAIRING_DS4))
> +					cp->type =3D=3D
> CABLE_PAIRING_DS4 ||
> +					cp->type =3D=3D
> CABLE_PAIRING_DUALSENSE))
> =C2=A0		return true;
> =C2=A0
> =C2=A0	return false;
> diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
> index ab8831995..ac7e75223 100644
> --- a/profiles/input/sixaxis.h
> +++ b/profiles/input/sixaxis.h
> @@ -17,6 +17,7 @@ typedef enum {
> =C2=A0	CABLE_PAIRING_UNSUPPORTED =3D 0,
> =C2=A0	CABLE_PAIRING_SIXAXIS,
> =C2=A0	CABLE_PAIRING_DS4,
> +	CABLE_PAIRING_DUALSENSE,
> =C2=A0} CablePairingType;
> =C2=A0
> =C2=A0struct cable_pairing {
> @@ -72,6 +73,30 @@ get_pairing(uint16_t vid, uint16_t pid, const char
> *name)
> =C2=A0			.version =3D 0x0001,
> =C2=A0			.type =3D CABLE_PAIRING_DS4,
> =C2=A0		},
> +		{
> +			.name =3D "Sony Interactive Entertainment
> Wireless Controller",
> +			.source =3D 0x0002,
> +			.vid =3D 0x054c,
> +			.pid =3D 0x0ce6,
> +			.version =3D 0x0001,
> +			.type =3D CABLE_PAIRING_DUALSENSE,
> +		},
> +		{
> +			.name =3D "Sony Interactive Entertainment
> DualSense Wireless Controller",
> +			.source =3D 0x0002,
> +			.vid =3D 0x054c,
> +			.pid =3D 0x0ce6,
> +			.version =3D 0x0001,
> +			.type =3D CABLE_PAIRING_DUALSENSE,
> +		},
> +		{
> +			.name =3D "Sony Interactive Entertainment
> DualSense Edge Wireless Controller",

Need to remove the "Sony Interactive Entertainment" prefix from those.

> +			.source =3D 0x0002,
> +			.vid =3D 0x054c,
> +			.pid =3D 0x0df2,
> +			.version =3D 0x0001,
> +			.type =3D CABLE_PAIRING_DUALSENSE,
> +		},
> =C2=A0	};
> =C2=A0	guint i;
> =C2=A0
