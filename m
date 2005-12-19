Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051219104250.86508.qmail@web36106.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource temporarily unavailable
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1134986417.24233.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Mon, 19 Dec 2005 02:42:50 -0800 (PST)

Hello Marcel,
The output of "hciconfig -a"
============================================================
hci0:   Type: USB
        BD Address: 00:10:60:A5:A7:61 ACL MTU: 192:8
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:9711 acl:224 sco:0 events:186
errors:0
        TX bytes:1968 acl:57 sco:0 commands:68
errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'localhost.localdomain-0'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1
(0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)
============================================================

The output of "hcitool info 00:10:60:A5:A7:61" (BT
address of the headset)
========================================================
Requesting information ...
Can't create connection: Connection timed out
========================================================

The version of bluez-utils is "2.23" and hcidumps is
"1.28". This info i got when i downloaded the packages
from the bluez.org website.

Regards,
Swathi



--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Swathi,
> 
> > As per your request i have attached the "hcidump
> -X -V" output when i
> > execute the command "btsco 00:08:C6:3E:54:2C 2"
> > 
> > output of hcidump -X -V
> >
>
=====================================================
> > HCI sniffer - Bluetooth packet analyzer ver 1.18
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > < HCI Command: Read Voice Setting (0x03|0x0025)
> plen 0
> > > HCI Event: Command Complete (0x0e) plen 6
> > Read Voice Setting (0x03|0x0025) ncmd 1
> > status 0x00 voice setting 0x0060
> > < HCI Command: Create Connection (0x01|0x0005)
> plen 13
> > bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01
> clkoffset 0x0000
> > Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > > HCI Event: Command Status (0x0f) plen 4
> > Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > > HCI Event: PIN Code Request (0x16) plen 6
> > bdaddr 00:08:C6:3E:54:2C
> > > HCI Event: Connect Complete (0x03) plen 11
> > status 0x22 handle 41 bdaddr 00:08:C6:3E:54:2C
> type ACL encrypt 0x00
> > E rror: LMP Error Transaction Collision
> >
>
=====================================================
> > 
> > I hope i will be able to get a solution for this.
> 
> what does "hciconfig -a" and "hcitool info ..." say?
> What version of
> bluez-utils and bluez-hcidump do you use?
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
> This SF.net email is sponsored by: Splunk Inc. Do
> you grep through log files
> for problems?  Stop!  Download the new AJAX search
> engine that makes
> searching your log files as easy as surfing the 
> web.  DOWNLOAD SPLUNK!
>
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
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
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
