Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bug link_key: no connection after AP was once
	accessed with Win XP AVM tools
From: Marcel Holtmann <marcel@holtmann.org>
To: Achim Bohnet <ach@mpe.mpg.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403312212.08249.ach@mpe.mpg.de>
References: <200403310134.14280.ach@mpe.mpg.de>
	 <1080725493.2773.49.camel@pegasus>  <200403312212.08249.ach@mpe.mpg.de>
Content-Type: text/plain
Message-Id: <1080773082.2536.30.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 01 Apr 2004 00:48:49 +0200

Hi Achim,

> > don't enable auth and encrypt, because this means security mode 3. Leave
> > it off and let the AP trigger the security mechanism.
> 
> Right, after commenting out auth and encrypt, stop hcid, reinstalling old
> 'borked' link_key file and starting hcid, ciptool asked for a pin.
> 
> Now I have two ways to workaround a bug, it is a bug isn't it?  At
> least with auth and encrypt enabled and no link_key entry or a valid
> link_key entry, ciptool works. Only with an invalid link_key entry it
> fails.  So for me, who never read any bluetooth spec (sorry), it looks
> like hcid fails to ask for a PIN is the case the link_key is no longer
> valid.

I already talked with the guys from AVM about the problem and this is
part of the link manager of the local Bluetooth dongle. At the moment I
am not quite sure what should be the right behaviour of a link manager
in security mode 3 and a wrong link key. I will test other dongles if I
have more time.

> Thx, for ciptool and your bluetooth work Marcel, beside this trouble it
> served my needs always perfectly.

You are welcome.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
