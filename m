Return-Path: <cyrus@holtmann.org>
Message-ID: <1325288847.7327.2.camel@sirocco>
Subject: Re: [PATCH BlueZ 3/4] Enable input/sixpair build (but no
 installation)
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Sat, 31 Dec 2011 00:47:27 +0100
In-Reply-To: <20111230224753.6729859cbc78e1c68d8563af@studenti.unina.it>
References: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1325273171-24698-3-git-send-email-anderson.lizardo@openbossa.org>
	 <20111230224753.6729859cbc78e1c68d8563af@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Em Fri, 2011-12-30 às 22:47 +0100, Antonio Ospite escreveu:
> On Fri, 30 Dec 2011 15:26:10 -0400
> Anderson Lizardo <anderson.lizardo@openbossa.org> wrote:
> 
> > "sixpair" is a standalone tool to manage PS3 controllers. It was the
> > only tool not being built by default.
> > 
> > To build it, it is necessary to check for libusb-1.0 (besides the
> > existing libusb 0.1 check). The check is optional, and sixpair will not
> > be built if libusb-1.0 headers are not installed.
> > ---
> > 
> > I personally never used this tool. So I'm not sure if the best approach is to
> > completely remove it instead. If that's the case, let me know so I send a patch
> > removing the .c file instead.
> >
> 
> Hi Anderson,
> 
> I'd say the .c file can be removed if you want to, when I have time I am
> going to resend the playstation-peripheral plugin and the prerequisite
> patches to have it as an _external_ plugin, I hope to do that next
> week.
> 
> In my previous submissions of the playstation-peripheral plugin I was
> removing this .c file just before adding the new plugin, and I am going
> to "revert" this patch anyways, so you can choose to drop this patch
> and let me remove the .c file when I add the plugin, or remove it right
> now. I think there isn't much of a gain enabling the build of the
> sixpair.c currently in BlueZ.
> 
> I am adding Bastien on CC as he was the author of the sixpair currently
> in BlueZ, Bastien what do you think?

Don't care. Been shipping a working-but-not-perfect version of a sixpair
plugin in the Fedora bluez package for at least 2 years. I'd be very
happy to drop that patch in favour of a supported version.

Cheers

