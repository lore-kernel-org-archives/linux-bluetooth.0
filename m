Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid and battery condition and syslog
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403171320.24816.cijoml@volny.cz>
References: <200403171259.22015.cijoml@volny.cz>
	 <1079525750.3301.14.camel@pegasus>  <200403171320.24816.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1079527136.3301.21.camel@pegasus>
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
Date: Wed, 17 Mar 2004 13:38:56 +0100

Hi Michal,

> I better prefer to be bthid abble receive tcp connections a reports via it and 
> not into syslog.
> It would be used then with some kind of graphical output like mrtg or rrdtool
> as soon as I monitor UPS battery

the full plan is to have a kernel integration into hiddev and then you
can hook up to specific HID reports and do what you want with it. But I
don't think this would ever be possible with the current bthid.

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
