Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <423F5B7F.9060200@rz-zw.fh-kl.de>
From: Timo Veith <tv@rz-zw.fh-kl.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problem with BlueLogic WingKey Keyboard
References: <200503202301.49376.tv@rz-zw.fh-kl.de> <1111408373.22872.54.camel@pegasus>
In-Reply-To: <1111408373.22872.54.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Tue, 22 Mar 2005 00:40:47 +0100

Marcel Holtmann wrote:
> can you try a 2.6.11-mh2 kernel first and see if that works. Otherwise I
> need the "hcidump -X -V" for your connection.

I chose the hcidump alternative first :). -X and -V are no recognized 
options with my hcidump version. So I only used -x assuming that you 
meant that. I typed "1" , "2", and so on as you can see and after the 
"6" the mentioned behaviour started.

If this isn't enough I will get your patchset and try again.

Here is the hcidump:

tristan root # hcidump -x
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Mode Change (0x14) plen 6
   00 29 00 00 00 00
 > ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 1E 00 00 00 00
1> ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 00 00 00 00 00
 > HCI Event: Mode Change (0x14) plen 6
   00 29 00 02 20 00
 > ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 1F 00 00 00 00
2> ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 00 00 00 00 00
 > HCI Event: Mode Change (0x14) plen 6
   00 29 00 00 00 00
 > HCI Event: Mode Change (0x14) plen 6
   00 29 00 02 A0 00
 > HCI Event: Mode Change (0x14) plen 6
   00 29 00 00 00 00
 > ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 20 00 00 00 00
3> ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 00 00 00 00 00
 > HCI Event: Mode Change (0x14) plen 6
   00 29 00 02 20 00
 > ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 21 00 00 00 00
4> ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 00 00 00 00 00
 > ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 22 00 00 00 00
5> ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 00 00 00 00 00
 > ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 23 00 00 00 00
6> ACL data: handle 0x0029 flags 0x02 dlen 13
     L2CAP(d): cid 0x41 len 9 [psm 0]
       A1 01 00 00 00 00 00 00 00
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm> HCI Event: Mode 
Change (0x14) plen 6
   00 29 00 00 00 00
mm> HCI Event: Mode Change (0x14) plen 6
   00 29 00 02 A0 00
mmmmmmmm> HCI Event: Mode Change (0x14) plen 6
   00 29 00 00 00 00
 > HCI Event: Mode Change (0x14) plen 6
   00 29 00 02 20 03

Hmm, I don't know if this is of importance but I just noticed that if I 
start bluetoothd I get an error for hid2hci. It says: No devices in HCI 
mode found.

Kind regards and TIA,

Timo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
