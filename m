Return-Path: <cyrus@holtmann.org>
Message-ID: <1389341463.4578.4.camel@x220>
Subject: Re: Last depmod fails with 3.13-rc6
From: Paul Bolle <pebolle@tiscali.nl>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>,  Johan Hedberg <johan.hedberg@gmail.com>
Cc: =?ISO-8859-1?Q?S=E9bastien?= Luttringer <seblu@seblu.net>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 10 Jan 2014 09:11:03 +0100
In-Reply-To: <la50g5$n4j$1@ger.gmane.org>
References: <la4v6a$a94$1@ger.gmane.org> <la50g5$n4j$1@ger.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Adding maintainers and linux-bluetooth.

On Fri, 2014-01-03 at 01:33 +0100, Sébastien Luttringer wrote:
> On 03/01/2014 01:11, Sébastien Luttringer wrote:
> > Hello,
> > 
> > Trying to run depmod (from kmod 16) on the 3.13-rc6, I got this error
> > message:
> > 
> > # depmod 3.13.0-rc6-seblu
> > depmod: ERROR: Module 'hci_vhci' has devname (vhci) but lacks major and
> > minor information. Ignoring.
> > 
> > The message and error code seem to be on purpose[2] but they break tools
> > which rely on depmod return 0 (like kernel-install).
> > 
> > 
> > [1] http://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/?id=6506ddf
> > 
> Forget about the return code and their consequences. I made a mistake.
> 
> The missing informations in hci_vhci is still relevant.
> 
> # depmod 3.13.0-rc6-seblu
> depmod: ERROR: Module 'hci_vhci' has devname (vhci) but lacks major and
> minor information. Ignoring.
> 
> Regards,
> 


Paul Bolle
