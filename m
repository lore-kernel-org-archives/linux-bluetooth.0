Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Chiverton <thomas.chiverton@bluefinger.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402131211.38367.thomas.chiverton@bluefinger.com>
References: <20040210175802.GA17705@mail.gmx.de>
	 <20040213113749.GA13481@mail.gmx.de> <1076673365.2671.30.camel@pegasus>
	 <200402131211.38367.thomas.chiverton@bluefinger.com>
Content-Type: text/plain
Message-Id: <1076674949.2671.41.camel@pegasus>
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
Date: Fri, 13 Feb 2004 13:22:29 +0100

Hi Thomas,

> > sure replace it with a simple executable shell script.
> > 	#!/bin/sh
> > 	echo "PIN:0000"
> 
> Is that /usr/bin/bluepin to /etc/bluetooth/pin ?

the /etc/bluetooth/pin is the PIN for incoming connections and the PIN
helper script from hcid.conf is executed on everything else.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
