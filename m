Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5256d0b05042604372879b077@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] motorola HS820 headset doesn't work
In-Reply-To: <1114435410.8571.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1114435410.8571.3.camel@localhost>
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
Date: Tue, 26 Apr 2005 12:37:18 +0100

> Hi,
> if I do
>=20
> > modprobe snd_bt_sco
> > esdctl stop
> > hciconfig hci0 voice 0x0060
> > btsco <address_of_my_headset>
> > aplay -B 1000000 -D plughw:Headset <some wav file>
>=20
> I can't hear anything else than a bip in my headset,
> that is properly paired (I checked with 'hcitool con')
> 'dmesg' gives me what follows:

When you type in btsco addr do you then hit the connect button on your
headset this was the problem I was having with the motorola headsets
I've tested (HS-810 and HS-850).
I wasn't using aplay but rather just using gnomemeeting and the
headset just came up in the list of devices.

Regards
Peter


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
