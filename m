Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Thinkpad 560x with pnpbios and bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <48456.194.59.120.11.1102056209.squirrel@194.59.120.11>
References: <36763.194.59.120.11.1101982344.squirrel@thalreit.dyndns.org>
	 <1101987478.15615.112.camel@pegasus>
	 <48456.194.59.120.11.1102056209.squirrel@194.59.120.11>
Content-Type: text/plain
Message-Id: <1102057135.7350.66.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 03 Dec 2004 07:58:55 +0100

Hi Volker,

> > is a vanilla 2.4.22-ac working for you?
> Yup. That's OK for the PNP Bios (but will not incorporate the mh patches,
> of course )

is patching the problem or do the kernel not work?

> Why don't you try a 2.4.28
> The 2.4.28 will not support PNP Bios :-(
> 
>  or a
> > 2.6 kernel.
> I had very bad experience with an 2.6 Kernel which completely crashes the
> system when connecting to the laptop over irda :-( maybe I will try that
> later, currently 2.6 is for me an unstable option.
> 
> About what kind of patch for non-standard Thinkpad BIOS are
> > we talking?
> See CONFIG_PNPBIOS in $kernelpath/Documentation/Configure.help
> http://tpctl.sf.net probably better explains that than I can.

you should start looking at the ACPI PNP support.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
