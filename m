Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Victor Shcherbatyuk <victor@win.tue.nl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Connection with a phonestaysopenafterclosingRFCOMM
 channel
Message-ID: <Pine.LNX.4.44.0503022328530.31250-100000@antilope>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 2 Mar 2005 23:58:47 +0100 (MET)

Hi Marcel,

2.6.10-mh4  - did not help

lsmod - /proc/modules is empty, but i have no modules (everything i 
need is compiled into kernel)...

l2cap:
72:FF:28:C6:10:00 42:E4:11:DE:0F:00 1 3 0x0040 0x0043 1024 251 0x0
00:00:00:00:00:00 00:00:00:00:00:00 4 19 0x0000 0x0000 48 48 0x0
00:00:00:00:00:00 00:00:00:00:00:00 4 17 0x0000 0x0000 48 48 0x0
00:00:00:00:00:00 00:00:00:00:00:00 4 1 0x0000 0x0000 672 0 0x0
00:00:00:00:00:00 00:00:00:00:00:00 4 3 0x0000 0x0000 1024 0 0x0

Am I missing something?

Regards,
    Victor Shcherbatyuk.

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, March 02, 2005 22:52
Subject: Re: [Bluez-devel] Connection with a 
phonestaysopenafterclosingRFCOMM channel


> Hi Victor,
> 
>> The /proc/bluetooth/rfcomm/{dlc,sock} are empty upon completion of the 
program. hcitool con gives:
>> > ACL 00:0f:de:11:e4:42 handle 41  state 1 in SLAVE
> 
> and what does /proc/bluetooth/l2cap show?
> 
> In general if there are no more open RFCOMM channels, the DLCI 0 should
> be closed and this should close the L2CAP connection on PSM 3. Seems
> like we have a bug or a wrong reference counting somewhere. Please also
> check lsmod for the "Used by" numbers. Do you see something unexpected.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
