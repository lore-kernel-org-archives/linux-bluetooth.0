Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 17:21:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Michael Schmitt <tcwardrobe@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
Message-ID: <20111121152111.GA15633@fusion.localdomain>
References: <4EC679A0.7050309@gmail.com>
 <20111118153652.GA3647@fusion.localdomain>
 <4EC67E88.6060202@gmail.com>
 <20111118162111.GA4680@fusion.localdomain>
 <20111121085704.GB32261@aemeltch-MOBL1>
 <1321866829.2011.5.camel@aeonflux>
 <20111121103547.GA9093@fusion.localdomain>
 <1321880678.2011.12.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321880678.2011.12.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Nov 21, 2011, Marcel Holtmann wrote:
> > That doesn't help much with this particular dongle though since the LMP
> > and HCI versions are the same. What I'd propose is the patch which I
> > already attached to an earlier email in this thread and then either a
> > quirk for this adapter or just generally ignoring the
> > HCI_Read_Local_Commands failure status.
> 
> using lmp_ver instead of hci_ver is still a bug, but fair enough it is a
> different bug.
> 
> I am fine just allowing Read_Local_Commands to fail. However that will
> serious limit some features since we have to be using the result more
> often in the future. But luckily that does not matter for 1.2 controller
> at all.

Ok. I just sent two patches for this. I have a hunch these might also
fix the recently reported "resume takes longer due to increased timeout"
regression report.

Johan
