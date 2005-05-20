Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth PCMCIA progress...
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <B7A120329D087840A54E2A221FCCE8D074733A@PSCMAIL01.rochester.itsphoenix.com>
References: 
	 <B7A120329D087840A54E2A221FCCE8D074733A@PSCMAIL01.rochester.itsphoenix.com>
Content-Type: text/plain
Message-Id: <1116602022.8819.9.camel@pegasus>
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
Date: Fri, 20 May 2005 17:13:42 +0200

Hi John,

> I wish I could migrate to a 2.6 kernel but the hardware vendor for
> this platform only ships/supports their patched 2.4.27.vrs1 kernel. It
> looks like you had drivers for this card (and a few others) posted on
> holtmann.org but removed them?? Are these possibly still available to
> someone like myself? I came onto this project a few weeks ago and am
> stuck with the H/W platform but still do need to demo Bluetooth
> dial-up networking via the PCMCIA slot of this platform in the next
> couple of weeks. Do you have access to an ARM/XScale PXA255 based
> system with a 16-bit PCMCIA slot? I could FedEx overnight a card to
> you (and yes, you could then keep it ) for driver testing!? This card
> seems to work fine in an x86-based Linux system. Any ideas here?

the driver you are talking about is bt3c_cs and it is included in the
mainline kernel and also my -mh patches. However this driver is only for
the version 2.0 of the 3Com cards and I have one of these for testing at
home.

So you say that the card with version 3.0 is working on your x86 system,
but not on your ARM. Unfortunately I don't have an ARM for testing, but
if it is working on x86 then it must be the serial driver for the ARM
that causes the problem here. We only put a line discipline onto the
UART and let the serial subsystem handle everything else.

Feel free to send me a version 3.0 card anyway. I am happy about any
Bluetooth adapter I have at home for testing, because it is impossible
for me to buy them all.

Are you sure that a 2.6 kernel doesn't already support the platform
without any additional patches. From my experiences people are bound to
a 2.4 kernel without any reasons. Only because some vendors say so. Lots
of ARM patches were merged into the 2.6 kernel series. So you might
wanna give it a try.

You might wanna exchange the Bluetooth PCMCIA card. The newer cards from
Socket should work fine with a 2.4 kernel and they contain the same
chipset as the 3Com.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
