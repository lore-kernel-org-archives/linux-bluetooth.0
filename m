Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alvin Lam <alvinlam@shaw.ca>
Subject: Re: [Bluez-users] hcitool returns error 0x11 with RSSI command
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <45a3bf460bd7.460bd745a3bf@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
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
Date: Wed, 24 Mar 2004 10:30:05 -0800

Hello,

Thanks for the replies.  I seem to recall seeing the RSSI feature being available before I re-installed the dtl1_cs driver.  Could it be possible that I have somehow disabled this feature?

I've attached the revision, version, and feature info from the Socket CF BT card.

Thanks,
Alvin

sh-2.03# hciconfig hci0 revision                                                    hci0:   Type: PCCARD
BD Address: 00:E0:03:25:53:02 ACL MTU: 340:4  SCO MTU: 64:0
Unsupported manufacturer                                                    sh-2.03# hciconfig hci0 version                                                     hci0:   Type: PCCARD
BD Address: 00:E0:03:25:53:02 ACL MTU: 340:4  SCO MTU: 64:0
HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.0b (0x0) LMP Subver: 0x104
Manufacturer: Nokia Mobile Phones (1)                                       sh-2.03# hciconfig hci0 features                                                    hci0:   Type: PCCARD
BD Address: 00:E0:03:25:53:02 ACL MTU: 340:4  SCO MTU: 64:0
Features: 0x17 0x00 0x00 0x00 0x00 0x00 0x00 0x00
<3-slot packets> <5-slot packets> <encryption> <timing accuracy>   

----- Original Message -----
From: Marcel Holtmann <marcel@holtmann.org>
Date: Wednesday, March 24, 2004 4:01 am
Subject: Re: [Bluez-users] hcitool returns error 0x11 with RSSI command

> Hi Alvin,
> 
> > I am using BlueZ with two Socket CompactFlash BT card using the 
> dtl1_cs 
> > driver.  I run "sdptool browse &" and when a connection is 
> established I 
> > then run "hcitool <rssi | lq | tpl> <bdaddr>".  This yields the 
> > following errors:
> > 
> > HCI get_link_quality cmd failed (0x11)
> > Read RSSI returned (error) status 0x11
> > HCI read_transmit_power_level cmd failed (0x11)
> > 
> > Since 0x11 is 17 in decimal, looking at errno.h shows that this 
> error 
> > corresponds to "File Exists".  I found several previous messages 
> on the 
> > mailing list referring to a similar error, but a different return 
> value 
> > (0x01).
> > 
> > I am thinking perhaps the Socket CF card does not support these 
> > features?  Any ideas what in particular is failing in 
> hci_send_req()?
> the socket card don't support these features. Check your card features
> with this command "hciconfig hci0 features".
> 
> Regards
> 
> Marcel
> 
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
