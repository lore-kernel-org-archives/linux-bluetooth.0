Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cv50e9$tm3$1@sea.gmane.org>
References: <cv4qgt$8h4$1@sea.gmane.org> <4215FC4A.20504@dark-reality.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <4215FC4A.20504@dark-reality.de>
Subject: [Bluez-devel] Re: mystic AT-Command
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
Date: Fri, 18 Feb 2005 16:11:56 +0100

Hi Lars,

thanks for your answer!

> Looks like the wrong channel is selected.
Can't imagine why this can be a problem with the RFCOMM channel. But
let's give it a try!


# sdptool search --bdaddr 00:0B:2E:02:03:A2 0x1108
Class 0x1108
Searching for 0x1108 on 00:0B:2E:02:03:A2 ...
Service Name: Headset
Service RecHandle: 0x20000
Service Class ID List:
   "Headset" (0x1108)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 6
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100

If I do not specify a channel to btsco it uses 6.
I tried to add channels to the commandline. It connects with channel 1
or 2. But if I tried to establish the SCO channel pressing the button
the headset continuosly peeps, no SCO connection!

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
