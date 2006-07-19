Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44BEC4AC.4050203@xmission.com>
Date: Wed, 19 Jul 2006 17:47:56 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200607200028.47928.info@david-geiger.de>
In-Reply-To: <200607200028.47928.info@david-geiger.de>
Subject: Re: [Bluez-users] CSR BlueCore4 dongles
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

David

> I was just doing an internet search on USB bluetooth dongles and would be 
> happy to get some feed-back on the results.
> 
> My requirements were:
> - CSR BlueCore4 (as I have heard it is best supported with btsco)
> - Class1
> Are there any other important criteria?
> 
> The only devices I have found are:
> - Level One MDU-0025USB (A2DP, USB 1.1)
> - B-Speech Data speed (A2DP)
> - Cellink BTA-6030 (USB 2.0)
> - EPoX BT-DG07A+ (A2DP?)
> - Bluetake BT007EX (A2DP, USB 1.1)
> 
> Any experiences with one of the devices or additions are welcome! :)

the bt007ex is a nice adapter. it's also just about the only one that is
easy to find in the US but that doesn't necessarily mean you'll find it
in Germany. fwiw, it includes a2dp drivers for xp that we've used for
testing interoperation (the w2k driver wouldn't work for me)

> There are a few questions left, maybe someone can help me here:
> - Does the dongle explicitely have to support A2DP?

when a dongle is advertised to support a2dp, it either means that you
can add a driver that provides a2dp or that such a driver is included
for windows. every dongle should support a2dp as long as it's not
seriously broken, so it really doesn't mean anything.

> - What is an "AV profile"? Almost all websites list the "Advanced Audio 
> Distribution Profile" as an AV profile and say Windows only. Does that mean 
> it doesn't support A2DP on linux?

this only relates to windows drivers. you can drive a2dp from linux
(such as we have it)

> http://www.b-speech.de/en/produkt-information/stereo-headsets-und-adapter/b-speech_data-speed/
> - Does it make sense to buy a dongle with USB 2.0 support? The USB 1.1 
> datarate is already 12mbit/s which should be enough by far.

the only real reason for usb2 is coexistence with other usb2 devices on
the same bus. the bus has to fall back to usb1 speeds when a usb1 device
on the bus is active.

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
