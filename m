Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced05022223273b5bba4c@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net, sebastian.roth@esk.fhg.de
Subject: Re: [Bluez-users] Re: Can't able to send data in both direction
In-Reply-To: <cvh9lh$2b0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <7aa80ced0502222239dd01830@mail.gmail.com>
	 <cvh9lh$2b0$1@sea.gmane.org>
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
Date: Wed, 23 Feb 2005 12:57:16 +0530

Hi,
    
    When the sending program runs on the SiW dongle PC , HCI dump is
not displaying any thing and it is giving the following error.

Error message on the sending side:

[root@localhost ]# ./senddata

L2CAP socket opened successfully.

Can't connect: No route to host (113)
 
Can't send data.
: Bad file descriptor

    When the same program is running on the CSR doungle side PC, I am
getting the following HCI dump and on the other side I can able to
receive data.


HCI dump of send prog on the CSR dongle side:

HCIDump - HCI packet analyzer ver 1.16
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  F9 DA 33 0D 0B 00 18 CC 00 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complete (0x03) plen 11
  00 28 00 F9 DA 33 0D 0B 00 01 00
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 10 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> HCI Event: Max Slots Change (0x1b) plen 3
  28 00 05
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 10]
      7C 01 0A 61 62 63 64 65 66 7C 67 7C 69 7E
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  28 00 13
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete (0x05) plen 4
  00 28 00 16


Regards
Mohan





































































On Wed, 23 Feb 2005 08:03:43 +0100, Sebastian Roth
<sebastian.roth@esk.fhg.de> wrote:
> Hi,
> 
> >              I am trying to send data at L2CAP level.  I am using
> > "Silicon Wave (11)" USB dongle in one PC and "Cambridge Silicon Radio
> > (10)" USB dongle in another PC. Using my program I can able to send
> > data from "Cambridge Silicon Radio" dongle side PC to "Silicon Wave"
> > dongle side PC. But, vice-versa is not working. I am getting the
> > following error when I try to send data from "Silicon Wave dongle".
> >              Can any one tell me why this is happenning.
> You've forgotten to paste the error message. I think no one will be
> able to help you without it. Please capture the packets using
> `hcidump -X' when trying to connect from SiW to CSR dongle and post it
> including the error message(s) you see.
> 
> Best regards,
> Sebastian
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
