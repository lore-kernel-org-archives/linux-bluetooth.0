Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bluez-devel] Maintain Bluetooth Connections
Message-ID: <6EF58BF68042DF4AA46A54994117D64F0253E93B@mercury.mtctech.com>
From: "Williams, Richard" <Richard.Williams@mtctechnologies.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Thu, 10 Feb 2005 14:16:17 -0500

Peter raises some interesting possibilities:

>What happens if one of the remote devices wants to send some data to
the PDA ??=20
>Or can you make sure that this will not happen ?? If it can happen you
need some=20
>sort of wakeup on your host. If the host can wake up on serial line
activity this=20
>is fine, but as far as I remember this is not possible with an X-scale.

- suppose the master has suspended and its BT radio is still awake
maintaining=20
the network integrity. If another new device does something as simple as
hci scan,=20
how will the BT device of the suspended processor behave? I suspect that
the BT=20
device will be unable to handle this and will probably do something
ugly.


>If you are sure that the above will not cause you problems you could
put=20
>all active connections into park mode, which will allow the BT chip to
save=20
>a lot of power. However, you have to remember the state of each active=20
>connection to unpark it once your host wakes up. Because you have to
remeber=20
>te connections states a bluetooth stop / start is not an option. You
have to=20
>add (I don't know if there already is something, but from Marcels
answer I=20
>think it is not) power management at least to the HCI layer which parks
the=20
>slaves if you enter low power state and unparks them when you come
back.

Your idea to park the connections is worth pursuing. My applications can

park/un-park during the X-scale suspend/wakeup sequence. All of my
applications=20
"know" about that a system-wide suspend is taking place, so they can do
what's=20
necessary. I'm not sure that this is what I would ultimately want to do,
but
Its worth hacking something together to see if it works at all.
I'm not sure if my peripheral devices support park mode, but that's=20
worth looking into.

Thanks for the idea.

Rich
----------------------------
Richard B. Williams
Vitronics, Inc.
An MTC Technologies Company
3 Corbett Way
Eatontown, NJ 07724-2262
732-389-0244 x29
Richard.Williams@mtctechnologies.com





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
