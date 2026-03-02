Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711B363C47
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451785; cv=none; b=Ax7JhwE4yARGB/YfXAXJ30Hkcc9J4slSYVottyWzdr9x0tJD8YV3kmOLnH7qCDktrC3uSLjfs/yR3l+/GAwTtvLsPag6swX7IiR4V7BS3ELBzUGAAbhyFWOVhzjXwMEdGj75gwKUxcGYqG5mLwEF0b+HasqcpA6dGWVyC9i1zzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451785; c=relaxed/simple;
	bh=+zqkGqvOxikKQpkzJUdjVbQvb6Jkz4g1TsvTuJQl09Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4opCP++NEtmxfYPkBAv5mJpnFNy3W6BS6BpCyac6reSeY3ZKm736kM77M56aDMXsSfC23ho3ZYIlLZFWvoxGeCtGrhpBgqD3gkpKGN0FQ6NjuG04DDo1bvFG6pyICuw29YQ+pzSMNqSWBtqAZpOLSGgBLApfeGjZ2kjO21qRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F21F043938;
	Mon,  2 Mar 2026 11:42:56 +0000 (UTC)
Message-ID: <5a10786eb628b0d5b45df88c844024f94c2c9fe2.camel@hadess.net>
Subject: Re: [PATCH BlueZ 4/5] dbus-common: Add Gaming appearance class
 (0x2a)
From: Bastien Nocera <hadess@hadess.net>
To: Martin BTS <martinbts@gmx.net>, linux-bluetooth@vger.kernel.org
Date: Mon, 02 Mar 2026 12:42:56 +0100
In-Reply-To: <20260301152930.221472-5-martinbts@gmx.net>
References: <20260301152930.221472-1-martinbts@gmx.net>
	 <20260301152930.221472-5-martinbts@gmx.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedvvefhveduieegtefftdekhfelgfdukeefleelfffggfeiudeftdefvdevfefhfeenucffohhmrghinhepsghluhgvthhoohhthhdrtghomhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupefhvdduhfdtgeefleefkedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepmhgrrhhtihhnsghtshesghhmgidrnhgvthdprhgtphhtt
 hhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

On Sun, 2026-03-01 at 16:29 +0100, Martin BTS wrote:
> Bluetooth 5.0+ defines appearance category 0x2a for gaming devices
> (generic gaming, handheld game console, game controller, etc.).
> Map it to "input-gaming" so the correct icon is exposed over D-Bus.
> ---
> =C2=A0src/dbus-common.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/src/dbus-common.c b/src/dbus-common.c
> index 5e2c83d52..04d8a21c4 100644
> --- a/src/dbus-common.c
> +++ b/src/dbus-common.c
> @@ -144,6 +144,8 @@ const char *gap_appearance_to_icon(uint16_t
> appearance)
> =C2=A0			return "scanner";
> =C2=A0		}
> =C2=A0		break;
> +	case 0x2a: /* Gaming (BT 5.0+): generic, handheld console,
> controller */
> +		return "input-gaming";
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;


Looks good, but could you please link to:
section 2.6.2 in
https://www.bluetooth.com/specifications/assigned-numbers/
?

For the record, what appearance do the Switch 2 joypads advertise?
Hopefully not one that corresponds to a console.

0x02A 0x00 0x0A80 Generic Gaming
      0x01 0x0A81 Home Video Game Console
      0x02 0x0A82 Portable handheld console

Cheers
