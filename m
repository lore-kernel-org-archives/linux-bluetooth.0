Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] hotplug USB dongle problem
References: <200402281424.55149.pavouk@pavouk.org> <1077976353.2843.82.camel@pegasus>
In-Reply-To: <1077976353.2843.82.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200402281549.59370.pavouk@pavouk.org>
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
Date: Sat, 28 Feb 2004 15:49:59 +0100

Hello,

> > I have configured Mandrake9.2 desktop with USB dongle.
> > I have kernel 2.6.2
>
> don't start pand from bluetooth.agent script. Start it from the init
> script.

Thanks for help, it works now.
I start hcid, sdpd, pand from init script.

What is the right sequence for killing these daemons?
Original script kills hcid and sdpd.
I'am killing in reverse sequence:
pand, sdpd, hcid.

Best regards,

Pavel Ruzicka



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
