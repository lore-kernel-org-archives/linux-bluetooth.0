Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DB1E485
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107978; cv=none; b=ABejyjDpkVWk3547zNFOTIjrbGrJRfyNT+JriHTU7Lgw5wxY1e4LDjy9xVThQYmrGspHKZTCIN8WBhZ1txX7kdpWhfGe/8pyd5zislxdrWvWjgaL2z4NrOH5S5vOoYvSv0PLXIB3XAwMs/l5T/su7ji7zBAlNu1zWQ9KP1bjBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107978; c=relaxed/simple;
	bh=atfjPC9croxQD7rqxvZPnz8C2CRf3CbQF1RA7dnOmT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEkH/F4ACWDNO1FAxeg4mMzsxU/FQ6atYNKgBpft6hsSbhd9fgdi4n8MgSoc4/Nlt7Vm+NjWVhiquvKyjdzBmXsXf5F9RNzvEF37//AZk43n/6p2BiNw29Jf971y9nRUURfnR5cZ5K4m4RwYSJpJ74nRm9lb+jgjcO2rGKRerio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E4AE1BF209;
	Thu,  4 Jul 2024 15:46:13 +0000 (UTC)
Message-ID: <a152556f7fd550ef564cae217a01f59c2a366f88.camel@hadess.net>
Subject: Re: [bug report] Reproducible pairing loss after reboot / Mediatek
 RZ616 [partly resolved / probably not a Bluez bug]
From: Bastien Nocera <hadess@hadess.net>
To: usul@gmx.li, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 04 Jul 2024 17:46:12 +0200
In-Reply-To: <8BF9EC88-361A-430B-857F-AD19F03134EA@gmx.li>
References: <4cb7ecc4-2bf0-4403-a995-7ca3817be4cc@gmx.li>
	 <CABBYNZK2xgDZ-bkxE6L-5Yt9x3PDKT_swDpN1=HAD9PC_6QpVA@mail.gmail.com>
	 <c0b60ec6-08ef-4391-856d-14f60f33af9e@gmx.li>
	 <CABBYNZLrATLZaE756Guu9K3nGxGc3aVzSuxOiLw9icsO5+QXww@mail.gmail.com>
	 <d7c41cc6422da3e024280c055661833411c6e847.camel@hadess.net>
	 <CABBYNZLkQh-Lb9P-ZwDgXkQJPpxVSRE0wTEFGEG6nUQ9HQkboA@mail.gmail.com>
	 <8BF9EC88-361A-430B-857F-AD19F03134EA@gmx.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Thu, 2024-07-04 at 16:30 +0200, usul@gmx.li wrote:
>=20
>=20
> Am 4. Juli 2024 16:17:32 MESZ schrieb Luiz Augusto von Dentz
> <luiz.dentz@gmail.com>:
> > Hi Bastien,
> >=20
> > On Thu, Jul 4, 2024 at 4:20=E2=80=AFAM Bastien Nocera <hadess@hadess.ne=
t>
> > wrote:
> > >=20
> > > On Wed, 2024-07-03 at 13:31 -0400, Luiz Augusto von Dentz wrote:
> > > > <snip>
> > > > @Bastien Nocera do you happen to know why gnome not register a
> > > > pairing
> > > > agent? Ive seem quite a few reports of things not working after
> > > > rebooting lately which hints to No-bonding pairing happening or
> > > > perhaps fedora uses main.conf:AlwaysPairable?
> > >=20
> > > There hasn't been a pairing agent in GNOME outside the Bluetooth
> > > Settings panel for more than 10 years.
> > >=20
> > > I've never seen this being a problem before.
> > >=20
> > > Fedora uses the main.conf shipped by bluez with no changes
> > > (except
> > > AutoEnable to true, which does nothing as it's already the
> > > default):
> > > https://src.fedoraproject.org/rpms/bluez/blob/rawhide/f/bluez.spec#_1=
96
> >=20
> > Hmm, so if you got a incoming pairing request there is nothing to
> > respond to authentication? Well even in that case it doesn't
> > explain
> > why there was no agent while setting up a new device, or perhaps
> > that
> > is not how setting up new devices works nowadays? Jonas, did you
> > use
> > the gnome setting panel to set it up or did you use something else?
> >=20
>=20
>=20
> When initial pairing was done with the gnome settings, I would not be
> able to reconnect after reboot. Now that I did the pairing with
> bluetoothctl, it survives a reboot.

I have no idea what the difference could be between pairing with GNOME,
or pairing with bluetoothctl, there really shouldn't be any difference.

Would be good to capture both cases to see whether there's any
difference, checking the /var/lib/bluetooth files after pairing in each
case might also show some differences.

The device looks like it supports pairing to multiple computers (look
at the channel display at the bottom:
https://www.cherry-world.com/gentix-bt
Maybe that's part of the problem?

Cheers

> The connection still breaks once in a while (about 5x per day) and
> then needs a few seconds to repair itself. But that might be a
> different problem. I'll try to capture a log of this as well.
> (Sorry, re-sending because my mobile phone didn't accept answer-to-
> all)

