Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3B10A1F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961928; cv=none; b=iyvt7YrVW+6nFAAazVamVvz0VcOrT8ZZBcEeM+oEqE7fZELi4CRk7ZxYzIaZUMtVFGuqUkks1a59zuUs/G3zM4DtdKwAQq47c0yrvlEdY5gxzHgI8QkR2hkElI4MpjgWGSIQ08oUbfeq79ZrurKjrAt0uUhxhyp/RZr84x8ASV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961928; c=relaxed/simple;
	bh=WNOVQMp+PY7RyWDLzwloX8pN5iPnAj546YGeGcf5TnU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oAIt69p6mZ2ZGM+MAJ0RUuBpF71m/xEbyqR1ejfCfKieUEH03rPJPH2abIVZL/13/DQqSvZDJpn/D7Hx2zHw/WHl0P93c5r3eqqMTfRFow27Asc/cwdQ9MwLED/KXrmPrVIt8rWgntPVepG+JaD1Mwct4rPSQnyLSH+0QdRiQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A76444279;
	Tue,  8 Jul 2025 08:05:18 +0000 (UTC)
Message-ID: <3afadd606d45927b75941cb94526327802fcab19.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2 0/5] audio/avrcp: Fix crash with invalid UTF-8
 item name
From: Bastien Nocera <hadess@hadess.net>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@collabora.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 08 Jul 2025 10:05:17 +0200
In-Reply-To: <20250708070822.185375-1-frederic.danis@collabora.com>
References: <20250708070822.185375-1-frederic.danis@collabora.com>
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
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepueeviedvteekkefgfefffeethfejieekteffvdetjeehfeeileettddvueeludelnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehfrhgvuggvrhhitgdruggrnhhishestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

On Tue, 2025-07-08 at 09:08 +0200, Fr=C3=A9d=C3=A9ric Danis wrote:
> As stated in AVRCP 1.6.2 chapter 6.10.2.3 Media element item, for the
> Displayable Name Length property, the target device may truncate the
> item name:
>=20
> =C2=A0 Length of Displayable Name in octets. The name shall be limited
> such
> =C2=A0 that a response to a GetFolderItems containing one media player
> item
> =C2=A0 fits within the maximum size of PDU which can be received by the
> CT.
>=20
> This truncatation may occur in the middle of a multi-byte character,
> at least with Samsung Music app, which triggers a DBus assertion and
> crashes bluetoothd:
>=20
> =C2=A0 profiles/audio/player.c:media_folder_create_item() Din Dhal Jaye
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Haye with lyrics | "=E0=A4=A6=E0=A4=BF=E0=
=A4=A8 =E0=A4=A2=E0=A4=B2 =E0=A4=9C=E0=A4=BE=E0=A4=8F
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E0=A4=B9=E0=A4=BE=E0=A4=AF" =E0=A4=97=E0=
=A4=BE=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=87 =E0=A4=AC=E0=A5=8B=EF=BF=BD typ=
e audio uid 1
> =C2=A0 profiles/audio/player.c:media_folder_create_item()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /org/bluez/hci0/dev_24_24_B7_11_82_6C/play=
er0/NowPlaying/item1
> =C2=A0 profiles/audio/player.c:media_player_set_metadata() Title: Din Dha=
l
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Jaye Haye with lyrics | "=E0=A4=A6=E0=A4=
=BF=E0=A4=A8 =E0=A4=A2=E0=A4=B2 =E0=A4=9C=E0=A4=BE=E0=A4=8F =E0=A4=B9=E0=A4=
=BE=E0=A4=AF"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E0=A4=97=E0=A4=BE=E0=A4=A8=E0=A5=87 =E0=
=A4=95=E0=A5=87 =E0=A4=AC=E0=A5=8B=E0=A4=B2 | Guide | Dev Anand, Waheeda Re=
hman
> =C2=A0 =E2=80=A6
> =C2=A0 arguments to dbus_message_iter_append_basic() were incorrect,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assertion "_dbus_check_is_valid_utf8 (*str=
ing_p)" failed in
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file dbus-message.c line 2775.
> =C2=A0 This is normally a bug in some application using the D-Bus library=
.
>=20
> v1->v2:
> =C2=A0 - Introduce new strtoutf8() util function to truncate a string
> before
> =C2=A0=C2=A0=C2=A0 the first non UTF-8 character.
> =C2=A0 - Use strtoutf8() for AVRCP media element name
> =C2=A0 - Use strtoutf8() for MCP player name and track title
> =C2=A0 - Use strtoutf8() for Audio GAP device name
> =C2=A0 - Use strtoutf8() for EIR device names

Would be great to have a test case for that new function, with a bunch
of the problems you ran into tested for.

>=20
> Fr=C3=A9d=C3=A9ric Danis (5):
> =C2=A0 shared/util: Add strtoutf8 function
> =C2=A0 audio/avrcp: Fix crash with invalid UTF-8 item name
> =C2=A0 audio/mcp: Use strtoutf8 for player name and track title
> =C2=A0 audio/gap: Use strtoutf8 for GAP device name
> =C2=A0 eir: Use strtoutf8 for device names
>=20
> =C2=A0profiles/audio/avrcp.c |=C2=A0 4 +++-
> =C2=A0profiles/audio/mcp.c=C2=A0=C2=A0 | 11 +----------
> =C2=A0profiles/gap/gas.c=C2=A0=C2=A0=C2=A0=C2=A0 | 11 +----------
> =C2=A0src/eir.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 +----------
> =C2=A0src/shared/util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42
> ++++++++++++++++++++++++++++++++++++++++++
> =C2=A0src/shared/util.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A06 files changed, 49 insertions(+), 31 deletions(-)
