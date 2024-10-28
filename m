Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA471EE021
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152413; cv=none; b=o9RuxeSwZBwvUyX9EALNbFs8y8MnSAKcE8dA4tLoHrI9BGKwrCWkn/MQxCMH2mIsYMmE5boNt17bcsRYTRc9SWsOSLB7Y3aqSblq0O2KTCnrrSMUAgcZs1sRwbXBeR6tHr2HmopBdv6qBErRbI6rwDhynSIWswnRYUoH8JkJZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152413; c=relaxed/simple;
	bh=BCL7A0zNArd6tdV6Y98BkPOfnvwIUMuK3ro4YcQR+cw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFVlHbdrmL4LFE1jA3fiXSe2unyJ0z++PYDMRtEiCA1+/4NZUZXD4aOg+BQDHbZGFSXqK/aBowvU3e0RkHoLaqHGiVsSSS20EBOBv8KImmrQJcP1KqOL6GGeaiu9H7Td6j31LiuN0WbK73Kmt2XRfs3zePRnQz9W0mRt0iofzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 443A6FF803;
	Mon, 28 Oct 2024 21:53:27 +0000 (UTC)
Message-ID: <11654905883ae9c832b30005391ef647fd395e46.camel@hadess.net>
Subject: Re: [BlueZ v3 7/7] client: Fix --help hanging if bluetoothd is not
 running
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 28 Oct 2024 22:53:26 +0100
In-Reply-To: <CABBYNZKRBwdP_R6yKwcXNEg+O5HXDDd3NZ+bncWecvRUmQqfLg@mail.gmail.com>
References: <20241022141118.150143-1-hadess@hadess.net>
	 <20241022141118.150143-8-hadess@hadess.net>
	 <CABBYNZ+aMaDp0BC6F0yG+mJU9hgkeNtbOxNwYx1D7Yj3rU8bzw@mail.gmail.com>
	 <2d19a91da040a9298402303377ddc8c02a6a2c9a.camel@hadess.net>
	 <CABBYNZKRBwdP_R6yKwcXNEg+O5HXDDd3NZ+bncWecvRUmQqfLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Mon, 2024-10-28 at 11:54 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Mon, Oct 28, 2024 at 11:35=E2=80=AFAM Bastien Nocera <hadess@hadess.ne=
t>
> wrote:
> >=20
> > On Thu, 2024-10-24 at 12:08 -0400, Luiz Augusto von Dentz wrote:
> > > Hi Bastien,
> > >=20
> > > On Tue, Oct 22, 2024 at 10:11=E2=80=AFAM Bastien Nocera
> > > <hadess@hadess.net>
> > > wrote:
> > > >=20
> > > > Exit after printing all the main and submenu commands.
> > > > ---
> > > > =C2=A0client/main.c | 2 ++
> > > > =C2=A01 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/client/main.c b/client/main.c
> > > > index f60bef1a6d3a..f5ed9f9f5297 100644
> > > > --- a/client/main.c
> > > > +++ b/client/main.c
> > > > @@ -3193,6 +3193,8 @@ int main(int argc, char *argv[])
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assistant_add_submenu();
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_shell_set_prompt(PROM=
PT_OFF, NULL);
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_shell_handle_non_interacti=
ve_help();
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (agent_option)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 auto_register_agent =3D g_strdup(agent_option);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > --
> > > > 2.47.0
> > > >=20
> > >=20
> > > Having some thoughts about how to do this is more clean way,
> > > perhaps
> > > we should do this as part of bt_shell_run and then introduce .run
> > > callback to bt_shell_menu so it is called as part of
> > > bt_shell_run,
> > > under the .run callback the menu can place e.g. DBUS connection
> > > setup,
> > > etc, but before it reaches that we can check if it just a help
> > > pending.
> >=20
> > We need to:
> > 1) set the top menu
> > 2) populate the submenus without any D-Bus IO
> > 3) turn off the prompt
> > 4) print the help and exit if that's what was requested
> > 5) setup IO for submenus
> > 6) run the mainloop
> >=20
> > I guess I could do 2) with a callback from bt_shell_set_menu()
> > and then do 4) and 5) from a bt_shell_run() callback.
>=20
> Yep.
>=20
> > Is that what you expected?
> > Do you have preferred names for the callback functions?
>=20
> Id call it .run since it should be the result of bt_shell_run
>=20
> > I think that we can still use the function split from 3/7, did you
> > have
> > a better name for the functions?
>=20
> Not sure I follow, there will be a split between adding submenus and
> .run to achieve the 2 stages, or are you talking about some other
> split?

We still need to split the functions called in .run between the bits
that populate the submenu, and the bits that will make D-Bus I/O, so
patch number 3 still needs to be exist.

Is assistant_add_submenu() and assistant_enable_submenu() OK, or did
you want a different name?
