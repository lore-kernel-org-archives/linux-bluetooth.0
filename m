Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050330082943.59563.qmail@web50710.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
Subject: Re: [Bluez-users] cannot connect to pm-325 phone w/bluez
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Wed, 30 Mar 2005 00:29:43 -0800 (PST)

says -V is invalid on 1.11.


here is with -X

HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: b1 c4 12 37 00 08 18 cc 01 00 d1 a2 01        
   ...7.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                   
   ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2a 00 b1 c4 12 37 00 08 01 00              
   .*....7....
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
  0000: 2a 00 0f 00                                   
   *...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                
   .*...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 2a 00                             
   ....*.
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 05                                      
   *..
> ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040
result 0 status 0
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0042 flags 0x0000
clen 0
> ACL data: handle 0x002a flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000
clen 8
    MTU 256 FlushTO 65535
< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x0000
result 0 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                
   .*...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                
   .*...
> ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000
result 0 clen 0
< ACL data: handle 0x002a flags 0x02 dlen 24
    L2CAP(d): cid 0x0042 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1103 (DUN)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                
   .*...
> ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          cnt 0x2
          cont 00
< ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                
   .*...
> ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2a 00 13                                   
   .*..



--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi John,
> 
> > well, I need to use DUN(dial up networking) and
> dial
> > #777 to use the internet.
> 
> then do "sdptool search --bdaddr 08:00:37:12:C4:B1
> dun" and run the
> "hcidump -X -V" as root in another terminal. What
> does they show?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now.
>
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
