Return-Path: <cyrus@holtmann.org>
Message-ID: <1337853929.15105.84.camel@aeonflux>
Subject: Re: [RFC] Reorganizing the BlueZ source tree
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 24 May 2012 12:05:29 +0200
In-Reply-To: <1337852769.2115.47.camel@novo.hadess.net>
References: <20120524081405.GA30941@joana>
	 <CABBYNZLhWfS6Ff0S8SkCwSXxzt61NzNCBH-K78hQB6dtpPvJ6Q@mail.gmail.com>
	 <1337852769.2115.47.camel@novo.hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > The last profiles addition to BlueZ increased a lot the number of folders we
> > > have in the root dir of the project and it looks like more profiles (and more
> > > folders) are expected to come.
> > >
> > > I talked a bit with Johan about changing the hierarchy of the BlueZ tree and
> > > the following proposal where 2 new folders are created, 'profiles' and 'libs'
> > > and things are moved to them.
> > >
> > > compat          -> /dev/null (will be removed on 5.0)
> > > alert           -> profiles
> > > audio           -> profiles
> > > cups            -> profiles
> > > deviceinfo      -> profiles
> > > health          -> profiles
> > > input           -> profiles
> > > lib             -> profiles
> > > network         -> profiles
> > > proximity       -> profiles
> > > sap             -> profiles
> > > serial          -> profiles
> > > thermometer     -> profiles
> > > time            -> profiles
> > > btio            -> libs
> > > gdbus           -> libs
> > > sbc             -> libs
> > > emulator        -> tools
> > > mgmt            -> tools
> > > monitor         -> tools
> > > attrib
> > > doc
> > > plugins
> > > scripts
> > > src
> > > test
> > > tools
> > > unit
> > 
> > Sounds good, the only problem are gdbus and btio, if we merge obexd
> > into BlueZ btio will no longer be shared but for gdbus we would have
> > to align with other projects as well.
> 
> While you're at it, change gdbus' name to something that doesn't clash
> with the GIO GDBus.

why would we? This code predates GIO GDBus.

Regards

Marcel


