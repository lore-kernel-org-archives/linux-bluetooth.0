Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hotplug USB dongle problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402281424.55149.pavouk@pavouk.org>
References: <200402281424.55149.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1077976353.2843.82.camel@pegasus>
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
Date: Sat, 28 Feb 2004 14:52:33 +0100

Hi Pavel,

> I have configured Mandrake9.2 desktop with USB dongle.
> I have kernel 2.6.2
> When system is started, script /etc/rc.d/init.d/bluetooth
> is executed and runs "hcid" and "sdpd". It's probably OK
> 
> When I plug in USB dongle, I want to run "pand --listen --role NAP".
> I made /etc/hotplug/bluetooth.agent script, which is executed by hotplug 
> mechanism after inserting bluetooth dongle.
> bluetooth.agent:

don't start pand from bluetooth.agent script. Start it from the init
script.

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
