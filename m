Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] sdptool browse fails with ISSC dongle and Nokia
	6630 in Ubuntu Breezy
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.61.0601110004590.8744@vipunen.hut.fi>
References: <Pine.GSO.4.61.0601082205170.8744@vipunen.hut.fi>
	 <1136909841.7200.13.camel@localhost.localdomain>
	 <Pine.GSO.4.61.0601110004590.8744@vipunen.hut.fi>
Content-Type: text/plain
Message-Id: <1136968254.26114.2.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Wed, 11 Jan 2006 09:30:54 +0100

Hi Jukka,

> >> When I do "sdptool browse 00:11:9F:C8:D9:36" (that's the
> >> address of my Nokia 6630) sdptool gives the error:
> >>
> >>    Service Search failed: Connection timed out
> >>
> >> The following error appears in syslog:
> >>
> >>    sdptool: sdp_read_rsp: Client timed out
> >
> > what module is in your laptop (hciconfig -a)?
> 
> It's not a laptop, it's a desktop. The laptop was a separate 
> machine I just browsed for testing purposes. On the desktop 
> that says:
> 
> hci0:   Type: USB
>          BD Address: 00:11:67:00:3A:5E ACL MTU: 678:12 SCO 
> MTU: 48:5
>          UP RUNNING PSCAN ISCAN
>          RX bytes:250069 acl:1993 sco:0 events:2976 errors:0
>          TX bytes:107334 acl:1737 sco:0 commands:464 errors:0
>          Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'decoud-0'
>          Class: 0x3e0100
>          Service Classes: Networking, Rendering, Capturing
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x172 LMP Ver: 1.1 (0x1) 
> LMP Subver: 0x172
>          Manufacturer: Integrated System Solution Corp. (57)

not again this ISSC dongle. They seem to be really problematic and I
have no idea why.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
