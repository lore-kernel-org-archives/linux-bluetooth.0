Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebiroth@web.de>
Message-ID: <cvad1d$8tb$1@sea.gmane.org>
References: <Pine.LNX.4.61.0502191116450.10610@block.bubble> <cv89g9$399$1@sea.gmane.org> <Pine.LNX.4.61.0502200852440.15784@block.bubble>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <Pine.LNX.4.61.0502200852440.15784@block.bubble>
Subject: [Bluez-users] Re: strange btsco error
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
Date: Sun, 20 Feb 2005 17:18:16 +0100

Hi Florian,

I think your answer is a bit confusing.

> 1. No, it isn't. However, this should not matter, as I stated that this
>    error happens _before_ any bluetooth specific code is executed, in
>    btsco.c, line 356: snd_hwdep_open().
> 
> 2. cat /proc/asound/cards:
> 
> 0 [CK8            ]: NFORCE - NVidia CK8
>                      NVidia CK8 with ALC650F at 0xe8000000, irq 21
> 1 [U0x46d0x8b0    ]: USB-Audio - USB Device 0x46d:0x8b0
>                      USB Device 0x46d:0x8b0 at usb-0000:00:02.0-2.4, full speed
> 2 [Headset        ]: Bluetooth SCO - BT Headset
>                      BT Headset 1

As your output of 2. shows it _is_ in the list. That's good!

I found a thread in the mailing list:
http://thread.gmane.org/gmane.linux.bluez.devel/4000

Are you able to open the device using alsamixer as suggested by Lars
Grunewaldt?

Best regards,
Sebastian




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
