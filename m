Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041207173232.87804.qmail@web52008.mail.yahoo.com>
From: sagasola uyeoldum <sagasolauyeoldum@yahoo.com>
Subject: Re: [Bluez-users] bluez nap problems
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1102364164.8447.0.camel@pegasus>
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
Date: Tue, 7 Dec 2004 09:32:32 -0800 (PST)

Ok here it goes:

NAP hciconfig -a:

hci0:   Type: USB
        BD Address: 00:02:72:03:D3:F2 ACL MTU: 192:8 
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1591 acl:0 sco:0 events:162 errors:0
        TX bytes:1302 acl:0 sco:0 commands:70 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1
(0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

PANU hciconfig -a:

hci0:   Type: USB
        BD Address: 00:0D:18:01:19:3B ACL MTU: 192:8 
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN INQUIRY
        RX bytes:122 acl:0 sco:0 events:15 errors:0
        TX bytes:304 acl:0 sco:0 commands:13 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'miniscule-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1
(0x1) LMP Subver: 0x36f
        Manufacturer: Cambridge Silicon Radio (10)

NAP side hcidump -x:

HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
  01 14 0C 00 42 6C 75 65 5A 20 28 30 29 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00
< HCI Command: Read Class of Device (0x03|0x0023) plen
0
> HCI Event: Command Complete (0x0e) plen 7
  01 23 0C 00 00 01 00
< HCI Command: Read Local Version Information
(0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
  01 01 10 00 01 0D 02 01 0A 00 0D 02
> HCI Event: Connect Request (0x04) plen 10
  3B 19 01 18 0D 00 00 01 00 01
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
  3B 19 01 18 0D 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  21 29 00 3B 19 01 18 0D 00 01 00
> HCI Event: Connect Request (0x04) plen 10
  3B 19 01 18 0D 00 00 01 00 01
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
  3B 19 01 18 0D 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  21 2A 00 3B 19 01 18 0D 00 01 00
> HCI Event: Connect Request (0x04) plen 10
  3B 19 01 18 0D 00 00 01 00 01
< HCI Command: Accept Connection Request (0x01|0x0009)
plen 7
  3B 19 01 18 0D 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  21 2C 00 3B 19 01 18 0D 00 01 00


--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi,
> 
> > I have problems setting up NAP.
> > 
> > Here are my configurations:
> > 
> > This is the NAP side
> > Linux version 2.4.27 (root@goner) (gcc version
> 3.3.4
> > 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2,
> > pie-8.7.6)) #1 Fri Dec 3 13:09:59 EET 2004
> >   
> > This is the PANU side
> > Linux version 2.4.26 (root@Knoppix) (gcc version
> > 2.95.4 20011002 (Debian prerelease)) #1 SMP Sa Apr
> 17
> > 19:33:42 CEST 2004
> > 
> > My Steps to setup NAP side:
> > root@goner ~ # hcid
> > root@goner ~ # hcitool dev
> > Devices:
> >         hci0    00:02:72:03:D3:F2
> > root@goner ~ # sdpd
> > root@goner ~ # pand --listen --master --nodetach
> > pand[11105]: Bluetooth PAN daemon
> > 
> > PANU side:
> > root@miniscule ~ # hcid
> > root@miniscule ~ # hcitool dev
> > Devices:
> >         hci0    00:0D:18:01:19:3B
> > root@miniscule ~ # sdpd
> > root@miniscule ~ # pand --search --persist --role
> PANU
> > --service NAP --nodetach
> > pand[1703]: Bluetooth PAN daemon
> > pand[1703]: Inquiring
> > pand[1703]: Searching for NAP on 00:02:72:03:D3:F2
> > pand[1703]: Failed to connect to the SDP server.
> > Function not implemented(38)
> > 
> > and this goes on and on...
> > If I run hcidump on the NAP side i get these:
> > > HCI Event: Connect Request (0x04) plen 10
> > < HCI Command: Accept Connection Request
> (0x01|0x0009)
> > plen 7
> > > HCI Event: Command Status (0x0f) plen 4
> > > HCI Event: Connect Complete (0x03) plen 11
> > 
> > I cant run hcidump on PANU side because i dont
> hcidump
> > on the laptop, and i dont have a means to tranfer
> > hcidump binary (at least not an easy means) to it.
> > This whole thing is really weird because I got
> bnep0
> > working twice. Now I can't. 
> 
> do it with "hcidump -x" and show us the output of
> "hciconfig -a".
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
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
