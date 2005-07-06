Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-devel@lists.sourceforge.net, Johan Hedin <sua@home.se>
Subject: Re: [Bluez-devel] HCI reset problem
References: <200507021912.29173.sua@home.se> <20050702211535.3F4B356F@arbetsmyra.dyndns.org> <200507031653.47442.sua@home.se>
In-Reply-To: <200507031653.47442.sua@home.se>
MIME-Version: 1.0
Message-Id: <20050706001104.BBC6A43A@arbetsmyra.dyndns.org>
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
Date: Wed, 6 Jul 2005 02:10:01 +0200


> > Either the chip received an unrecognised RFCOMM (upper interface)
> > command message from the host or the chip ran out of pool memory
> > when processing the message. In either case the message has been
> > discarded. Presuming the fault was issued because of an invalid
> > RFCOMM message, the firmware has survived the problem.
>
> Now that I know that the codes mean something I looked a bit more
> into it. The Panic code is 0x01 before the reset and 0x16 after (I
> guess that 0x01 is the normal value). Also, when I did a few more
> tries this morning, I got Panic code 0x22 and Fault code 0x1f. Since
> it looks that you have some usefull documents, could you look up the
> meaning of 0x22 and 0x1f?


Hi
Ok, here are the descriptions:
	Panic 0x22:
An irrecoverable USB (hardware) error has been detected.

	Fault 0x1f:
Either the chip received an unrecognised SDD/SDP (upper interface) 
command message from the host or the chip ran out of pool memory when 
processing the message. In either case, the message has been discarded. 
Presuming the fault was issued because of an invalid SDD/SDP message, 
the firmware has survived the problem.


Unfortunately panic code 0x01 ain't the normal value, that's 0. And 
when everything is working all right hciconfig won't even show any 
"panic" value at all. It only display non-zero values.

	Panic 0x01:
The useless catchall. Used to indicate an error where no other 
appropriate panic code exists.


> Hmm, I nuked the pre-installed XP since I didn't plan to use it....
> perhaps a mistake. But it is possible to reinstall to check, but then
> I have to remove my current linux installation so I like to try other
> options first.

I'm only guessing but chances are the internal USB transfer might cause 
the errors too. You might want to try with a Knoppix or other live CD 
first but then I think you should make your machine to dual boot 
between Linux/Windows.


> Do any of you have firmware files available? Perhaps any of the HCI
> 18.2 versions listed here:
>
>  http://www.holtmann.org/linux/bluetooth/csr.html

To my knowledge you must get the unique firmware from each respective 
dongle manufacturer, but I'm a bit uncertain of this.


/Ronny



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
