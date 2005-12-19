Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051219114133.92866.qmail@web36113.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource temporarily unavailable
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1134990464.24233.21.camel@localhost>
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
Date: Mon, 19 Dec 2005 03:41:33 -0800 (PST)

Hello Marcel,

The output of "hcitool info 00:08:C6:3E:54:2C" (BT
address of the headset)
========================================================
Requesting information ...
 BD Address:  00:08:C6:3E:54:2C
 Device Name: Nokia HS-11W
======================================================

Regards,
Swathi

--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Swathi,
> 
> > The output of "hciconfig -a"
> >
>
============================================================
> > hci0:   Type: USB
> >         BD Address: 00:10:60:A5:A7:61 ACL MTU:
> 192:8
> > SCO MTU: 64:8
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:9711 acl:224 sco:0 events:186
> > errors:0
> >         TX bytes:1968 acl:57 sco:0 commands:68
> > errors:0
> >         Features: 0xff 0xff 0x0f 0x00 0x00 0x00
> 0x00
> > 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
> HV2
> > HV3
> >         Link policy: RSWITCH HOLD SNIFF PARK
> >         Link mode: SLAVE ACCEPT
> >         Name: 'localhost.localdomain-0'
> >         Class: 0x000000
> >         Service Classes: Unspecified
> >         Device Class: Miscellaneous,
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver:
> 1.1
> > (0x1) LMP Subver: 0x20d
> >         Manufacturer: Cambridge Silicon Radio (10)
> >
>
============================================================
> > 
> > The output of "hcitool info 00:10:60:A5:A7:61" (BT
> > address of the headset)
> >
>
========================================================
> > Requesting information ...
> > Can't create connection: Connection timed out
> >
>
========================================================
> 
> according to your hciconfig output, this is your
> local address and not
> the address of the headset. Use the headset address.
> 
> > The version of bluez-utils is "2.23" and hcidumps
> is
> > "1.28". This info i got when i downloaded the
> packages
> > from the bluez.org website.
> 
> These are fine.
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
