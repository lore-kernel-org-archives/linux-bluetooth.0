Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
From: "Christoph Torens" <christoph@torens.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Message-ID: <opr5jsgqtl7p7ahu@debian>
Subject: [Bluez-users] Various questions
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 28 Mar 2004 03:15:52 +0200

Hi,

This mail has become quite long. Therefore I have to thank everybody who  
reads it, though  :-)

I'd like to buy an additional Bluetooth Dongle,
because my Zeevo Chip Dongles don't work properly and I stressed my friend  
to long now by borrowing his CSR Dongle.
So which chipsets exist at all, and is CSR the "all-time-best-solution"  
for linux?
And last but not least, how can I buy a Dongle with the desired chipset?  
You normaly just see the manufacturers as Acer for example, not the  
chipset, don't you? Is it absolutely unimportant at all, if its Acer,  
Belkin, D-Link or what ever?


Now, I just read Marcel's last mail Re: [Bluez-users] PANU and "ACL tx  
timeout"
He says one should try to update the firmware. Thats a faszinating idea,  
because I didn't manage to solve my Bluetooth problems yet. I wonder if a  
firmware update would help me, too. I didn't know this is possible at all.  
But after a short time on google I think its not possible with my Dongles.  
Or are there updates vor the Acer 510 Dongles?

The funny thing is, with time I get more and more different error messages  
regarding bluetooth.
My last error was when trying to connect via pand: "Connection failed.  
Permission Denied 13"
So I guess I make some failure, but I can't find it.
By the way: can I pair two PC's with Linux? Could this be an idea of my  
failure?

Another interessting thing is, that i can connect my viper (PC104) using  
dund to Win2000. But the ppp0 device on the viper doesn't get configuered  
automatically (I thougt this should happen? routing seems to get set  
automatically, though) And I can't ping in any direction. The ppp  
conection produces output every 3 seconds and while doing a ping, hcidump  
produces output parallel to the ppp messages every 3 seconds.


Here comes a lot of output:
++

root@viper root# dund --connect 00:04:3e:c0:9d:79 -n -D debug
dund[311]: DUN daemon ver 1.1
dund[311]: Searching for LAP on 00:04:3e:c0:9d:79
dund[311]: Connecting to 00:04:3e:c0:9d:79 channel 2
dund[311]: Connection established
root@viper root# using channel 1
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
sent [LCP ConfReq id=0x1 <magic 0xff9b94d3> <pcomp> <accomp>]
rcvd [LCP ConfRej id=0x1 <magic 0xff9b94d3> <pcomp> <accomp>]
sent [LCP ConfReq id=0x2]
rcvd [LCP ConfAck id=0x2]
rcvd [LCP ConfReq id=0x1 <asyncmap 0x0> <mru 1600>]
sent [LCP ConfRej id=0x1 <asyncmap 0x0>]
sent [LCP ConfReq id=0x2]
rcvd [LCP ConfAck id=0x2]
...and so on...
sent [LCP ConfReq id=0x2]
rcvd [LCP ConfAck id=0x2]

++

my lan settings in win
++
C:\>ipconfig

Windows 2000-IP-Konfiguration

Ethernetadapter "LAN-Verbindung 2":

         Verbindungsspezifisches DNS-Suffix:
         IP-Adresse. . . . . . . . . . . . : 10.0.0.1
         Subnetzmaske. . . . . . . . . . . : 255.255.255.0
         Standardgateway . . . . . . . . . :

Ethernetadapter "LAN-Verbindung":

         Verbindungsspezifisches DNS-Suffix: dyn.ee
         IP-Adresse. . . . . . . . . . . . : 192.168.0.7
         Subnetzmaske. . . . . . . . . . . : 255.255.255.0
         Standardgateway . . . . . . . . . : 192.168.0.9

++


root@viper root# ifconfig ppp0 10.0.0.2 netmask 255.255.255.0
root@viper root# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:80:66:10:04:40
           inet addr:192.168.0.50  Bcast:192.168.0.255  Mask:255.255.255.0
           UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:831 errors:8 dropped:0 overruns:8 frame:0
           TX packets:71 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:100
           RX bytes:60695 (59.2 KiB)  TX bytes:8767 (8.5 KiB)
           Interrupt:1 Base address:0x5300

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:8 errors:0 dropped:0 overruns:0 frame:0
           TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:560 (560.0 B)  TX bytes:560 (560.0 B)

ppp0      Link encap:Point-Point Protocol
           inet addr:10.0.0.2  P-t-P:10.0.0.2  Mask:255.255.255.0
           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:3
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
++


and here is the dump while the ppp was running already,
then i pinged the win pc,
stopped ping,
and then i did "dund -K"

++
root@viper root# hcidump -x
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 0x0035 flags 0x02 dlen 25
     L2CAP(d): cid 0x45 len 21 [psm 0]
       13 EF 23 7E FF 7D 23 C0 21 7D 21 7D 22 7D 20 7D 24 B5 5A 7E
       65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
> ACL data: handle 0x0035 flags 0x02 dlen 22
     L2CAP(d): cid 0x41 len 18 [psm 0]
       11 EF 1D 7E C0 21 7D 22 7D 22 7D 20 7D 24 C3 51 7E BF
< ACL data: handle 0x0035 flags 0x02 dlen 171
     L2CAP(d): cid 0x45 len 167 [psm 0]
       13 EF 44 01 FF 7D 23 7D 20 21 45 7D 20 7D 20 54 7D 20 7D 20
       40 7D 20 40 7D 21 26 A7 7D 2A 7D 20 7D 20 7D 22 7D 2A 7D 20
       7D 20 7D 21 7D 28 7D 20 33 C1 4B 7D 21 7D 20 7D 20 5A A3 BB
       38 63 61 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D
       20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D
       20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D
       20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D
       20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D
       20 7D 20 C9 DD 7E 65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
< ACL data: handle 0x0035 flags 0x02 dlen 153
     L2CAP(d): cid 0x45 len 149 [psm 0]
       13 EF 20 01 7E FF 7D 23 7D 20 21 45 7D 20 7D 20 54 7D 20 7D
       20 40 7D 20 40 7D 21 26 A7 7D 2A 7D 20 7D 20 7D 22 7D 2A 7D
       20 7D 20 7D 21 7D 28 7D 20 FF E4 4B 7D 21 7D 21 7D 20 5B A3
       BB 38 DE 8C 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20
       7D 20 7D 20 7D 38 69 7D 25 40 50 52 7D 21 40 7D 34 FC FF BF
       7D 20 7D 20 7D 20 7D 20 40 7D 20 7D 20 7D 20 4C 38 7D 26 7D
       20 7D 21 7D 20 7D 20 7D 20 E0 C6 7D 28 7D 20 38 BD 7D 21 40
       7C FC FF BF 2F 7D 3E 7E 65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
< ACL data: handle 0x0035 flags 0x02 dlen 154
     L2CAP(d): cid 0x45 len 150 [psm 0]
       13 EF 22 01 7E FF 7D 23 7D 20 21 45 7D 20 7D 20 54 7D 20 7D
       20 40 7D 20 40 7D 21 26 A7 7D 2A 7D 20 7D 20 7D 22 7D 2A 7D
       20 7D 20 7D 21 7D 28 7D 20 7D 21 E5 4B 7D 21 7D 22 7D 20 5C
       A3 BB 38 DA 8C 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D
       20 7D 20 7D 20 7D 38 69 7D 25 40 50 52 7D 21 40 7D 34 FC FF
       BF 7D 20 7D 20 7D 20 7D 20 40 7D 20 7D 20 7D 20 4C 38 7D 26
       7D 20 7D 21 7D 20 7D 20 7D 20 E0 C6 7D 28 7D 20 38 BD 7D 21
       40 7C FC FF BF 7D 26 D6 7E 65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
< ACL data: handle 0x0035 flags 0x02 dlen 25
     L2CAP(d): cid 0x45 len 21 [psm 0]
       13 EF 23 7E FF 7D 23 C0 21 7D 21 7D 22 7D 20 7D 24 B5 5A 7E
       65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
> ACL data: handle 0x0035 flags 0x02 dlen 22
     L2CAP(d): cid 0x41 len 18 [psm 0]
       11 EF 1D 7E C0 21 7D 22 7D 22 7D 20 7D 24 C3 51 7E BF
< ACL data: handle 0x0035 flags 0x02 dlen 151
     L2CAP(d): cid 0x45 len 147 [psm 0]
       13 EF 1C 01 FF 7D 23 7D 20 21 45 7D 20 7D 20 54 7D 20 7D 20
       40 7D 20 40 7D 21 26 A7 7D 2A 7D 20 7D 20 7D 22 7D 2A 7D 20
       7D 20 7D 21 7D 28 7D 20 77 E3 4B 7D 21 7D 23 7D 20 5D A3 BB
       38 62 8E 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D
       20 7D 20 7D 38 69 7D 25 40 50 52 7D 21 40 7D 34 FC FF BF 7D
       20 7D 20 7D 20 7D 20 40 7D 20 7D 20 7D 20 4C 38 7D 26 7D 20
       7D 21 7D 20 7D 20 7D 20 E0 C6 7D 28 7D 20 38 BD 7D 21 40 7C
       FC FF BF 4D AE 7E 65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
< ACL data: handle 0x0035 flags 0x02 dlen 153
     L2CAP(d): cid 0x45 len 149 [psm 0]
       13 EF 20 01 7E FF 7D 23 7D 20 21 45 7D 20 7D 20 54 7D 20 7D
       20 40 7D 20 40 7D 21 26 A7 7D 2A 7D 20 7D 20 7D 22 7D 2A 7D
       20 7D 20 7D 21 7D 28 7D 20 22 E4 4B 7D 21 7D 24 7D 20 5E A3
       BB 38 B5 8D 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20 7D 20
       7D 20 7D 20 7D 38 69 7D 25 40 50 52 7D 21 40 7D 34 FC FF BF
       7D 20 7D 20 7D 20 7D 20 40 7D 20 7D 20 7D 20 4C 38 7D 26 7D
       20 7D 21 7D 20 7D 20 7D 20 E0 C6 7D 28 7D 20 38 BD 7D 21 40
       7C FC FF BF 5D 7D 3B 7E 65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
< ACL data: handle 0x0035 flags 0x02 dlen 25
     L2CAP(d): cid 0x45 len 21 [psm 0]
       13 EF 23 7E FF 7D 23 C0 21 7D 21 7D 22 7D 20 7D 24 B5 5A 7E
       65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
> ACL data: handle 0x0035 flags 0x02 dlen 22
     L2CAP(d): cid 0x41 len 18 [psm 0]
       11 EF 1D 7E C0 21 7D 22 7D 22 7D 20 7D 24 C3 51 7E BF
< ACL data: handle 0x0035 flags 0x02 dlen 25
     L2CAP(d): cid 0x45 len 21 [psm 0]
       13 EF 23 7E FF 7D 23 C0 21 7D 21 7D 22 7D 20 7D 24 B5 5A 7E
       65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
> ACL data: handle 0x0035 flags 0x02 dlen 22
     L2CAP(d): cid 0x41 len 18 [psm 0]
       11 EF 1D 7E C0 21 7D 22 7D 22 7D 20 7D 24 C3 51 7E BF
< ACL data: handle 0x0035 flags 0x02 dlen 25
     L2CAP(d): cid 0x45 len 21 [psm 0]
       13 EF 23 7E FF 7D 23 C0 21 7D 21 7D 22 7D 20 7D 24 B5 5A 7E
       65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
> ACL data: handle 0x0035 flags 0x02 dlen 22
     L2CAP(d): cid 0x41 len 18 [psm 0]
       11 EF 1D 7E C0 21 7D 22 7D 22 7D 20 7D 24 C3 51 7E BF
< ACL data: handle 0x0035 flags 0x02 dlen 25
     L2CAP(d): cid 0x45 len 21 [psm 0]
       13 EF 23 7E FF 7D 23 C0 21 7D 21 7D 22 7D 20 7D 24 B5 5A 7E
       65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
> ACL data: handle 0x0035 flags 0x02 dlen 22
     L2CAP(d): cid 0x41 len 18 [psm 0]
       11 EF 1D 7E C0 21 7D 22 7D 22 7D 20 7D 24 C3 51 7E BF
< ACL data: handle 0x0035 flags 0x02 dlen 37
     L2CAP(d): cid 0x45 len 33 [psm 0]
       13 EF 3B 7E FF 7D 23 C0 21 7D 25 7D 23 7D 20 7D 30 55 73 65
       72 20 72 65 71 75 65 73 74 79 7B 7E 65
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 9
     L2CAP(d): cid 0x41 len 5 [psm 0]
       11 FF 01 01 A3
> ACL data: handle 0x0035 flags 0x02 dlen 22
     L2CAP(d): cid 0x41 len 18 [psm 0]
       11 EF 1D 7E C0 21 7D 26 7D 23 7D 20 7D 24 F3 79 7E BF
< ACL data: handle 0x0035 flags 0x02 dlen 12
     L2CAP(d): cid 0x45 len 8 [psm 0]
       03 EF 09 E3 05 13 89 70
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 12
     L2CAP(d): cid 0x41 len 8 [psm 0]
       01 EF 09 E1 05 13 89 AA
< ACL data: handle 0x0035 flags 0x02 dlen 8
     L2CAP(d): cid 0x45 len 4 [psm 0]
       13 53 01 77
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 35 00 01 00
> ACL data: handle 0x0035 flags 0x02 dlen 8
     L2CAP(d): cid 0x41 len 4 [psm 0]
       13 73 01 5D
< ACL data: handle 0x0035 flags 0x02 dlen 8
     L2CAP(d): cid 0x45 len 4 [psm 0]
       03 53 01 FD
< ACL data: handle 0x0035 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0045 scid 0x0041
++

But connecting to Linux doesn't work at all. The connection seems to be  
established, but I get only send events on ppp and therefore I get a  
timeout soon.
++
debian:/# dund --listen --nodetach
dund[670]: DUN daemon ver 1.1
dund[671]: New connection from 00:60:57:0C:88:1A
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
LCP: timeout sending Config-Requests
Connection terminated.
++

++
root@viper root# dund --connect 00:04:3e:c0:9d:79 -n -D
dund[310]: DUN daemon ver 1.1
dund[310]: Searching for LAP on 00:04:3e:c0:9d:79
dund[310]: Connecting to 00:04:3e:c0:9d:79 channel 1
dund[310]: Connection established
root@viper root# using channel 1
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
sent [LCP ConfReq id=0x1 <magic 0x380889ad> <pcomp> <accomp>]
LCP: timeout sending Config-Requests
++

Why is win working and linux not?? I think I still make a big failure!?

My last question for now:
Dund says it is a ppp over rfcomm connection. Connecting to Windows the  
"Lan Access service" answers.
Doing a rfcomm connection by hand, the "serial port" answers.
But there also exists a "dial up service"
So I'm a bit confused about what connects to what and why.

sdptool knows LAN DUN PAN. Is it unimportant which service it is, that a  
dund connects to?
Can it connect to dund AND lan? is this the same?

*confused*

Thanks for reading tthis long email
And thank you for any help.

-- 
Regards,
Christoph Torens


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
