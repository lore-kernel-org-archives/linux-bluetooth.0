Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech MX900 oddities and solutions
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078916559.6886.5.camel@pc-04.ycom.ch>
References: <1078912919.32148.356.camel@metal.cisco.com>
	 <1078915401.2537.14.camel@pegasus>  <1078916559.6886.5.camel@pc-04.ycom.ch>
Content-Type: text/plain
Message-Id: <1078917101.2537.21.camel@pegasus>
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
Date: Wed, 10 Mar 2004 12:11:41 +0100

Hi Alexandre,

> > I never said that I include the multi-byte patch into -mh4. It seems
> > that some people assume this, but this is not true. Use diffstat to
> > check the patch and you will see that it only changes Bluetooth stuff.
> 
> Strange ... with my 2.6.3 I don't use any other path for this .. :-)

you must used another one. At least the -mm patch.

> > I add your device ID to the CVS.
> 
> Huh, Logitech has many device ID for same hardware ?
> Maybe we need some clarification from Logitech .. :-)

This is normal stuff ;)

> > If you start the hcid it will modifiy your link policy settings and it
> > is important that RSWITCH and SNIFF is on.
> 
> Mine is working fine ... without any mod or blood :-)

What does "hciconfig hci0 lp" say?

> Maybe the next thing to do is to have a correct encryption link, of
> course for the keyboard ( I don't think that mouse mouvements are very
> important ...).

If the HID device is a keyboard we must simply send and authentication
request and then activate the encryption. Patches are welcome.

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
