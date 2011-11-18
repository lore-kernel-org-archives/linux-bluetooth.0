Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3 bluez 2/2] Add A2MP definitions
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Peter Krystad <pkrystad@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Date: Fri, 18 Nov 2011 06:15:51 +0100
In-Reply-To: <20111117092627.GA2838@fusion.localdomain>
References: <005201cca4e0$e2467680$a6d36380$@org>
	 <20111117092627.GA2838@fusion.localdomain>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321593352.15441.577.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > +++ b/lib/a2mp.h
> > @@ -0,0 +1,137 @@
> > +/*
> > + *
> > + *	BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *	Copyright (C) 2010-2011 Code Aurora Forum.  All rights reserved.
> > + *
> > + *	This program is free software; you can redistribute it and/or modify
> > + *	it under the terms of the GNU General Public License version 2 and
> > + *	only version 2 as published by the Free Software Foundation.
> > + *
> > + *	This program is distributed in the hope that it will be useful,
> > + *	but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *	GNU General Public License for more details.
> 
> I haven't forgotten about these but just been waiting for feedback from
> Marcel about this inconsistent (compared to the rest of the source tree)
> license header that you have (this one is "GPL 2 only" whereas the rest
> (including other files that you add content to) are "GPL 2 or later".

so for userspace we are using "GPLv2 and later" and for kernel we are
using "GPLv2 only". And I prefer to keep it this way. Mainly to keep
myself sane since the BlueZ code is not a small one. So it would be
great if you can just follow the existing license.

Regards

Marcel


