Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dbus pin failure
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1141663646.4110.60.camel@pmac.infradead.org>
References: <1141396234.8699.10.camel@localhost.localdomain>
	 <1141397987.12964.23.camel@aeonflux.holtmann.net>
	 <1141418085.8699.23.camel@localhost.localdomain>
	 <1141532537.4871.9.camel@aeonflux.holtmann.net>
	 <1141663646.4110.60.camel@pmac.infradead.org>
Content-Type: text/plain
Message-Id: <1141666471.4733.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 06 Mar 2006 18:34:31 +0100

Hi David,

> > ok then maybe it is too new. Does bluez-pin or hcid create this error
> > message? I am still at 0.60 on all of my machines.
> 
> It's printed by bluez-pin

so I assume this means that bluez-pin is at fault. Actually that is out
of my responsibility. However you also should already have patches in it
for making it work with 0.36. Maybe these need to be reviewed.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
