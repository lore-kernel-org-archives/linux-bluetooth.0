Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS Optical Desktop Elite for BT; can't reconnect
	after idle
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0502111319140.26906@frodo.dd.chalmers.se>
References: <Pine.GSO.4.58.0502111319140.26906@frodo.dd.chalmers.se>
Content-Type: text/plain
Message-Id: <1108125316.18099.36.camel@pegasus>
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
Date: Fri, 11 Feb 2005 13:35:16 +0100

Hi Tomas,

> I just got the MS Optical Desktop Elite for BT and I'm now trying it on
> Fedora Core 3 (2.6.10). I'm having some small problems with the extra
> buttons on both the mouse and keyboard but my largest problem is that it
> won't reconnect after being idle.
> 
> I guess it shuts down to save batteries but isn't it supposted to
> reconnect automaticly when you start using the gear again?
> 
> Sure I can always reconnect the keyboard by typing the commands
> manually on the keybo... well... never mind ;-)

is this the second version of Microsoft Bluetooth desktop? Is yes, is
the transceiver working?

Show us the output of "hciconfig -a" and check with "sdptool" for the
service record of HID. Run "hcidump -x" while it disconnects.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
