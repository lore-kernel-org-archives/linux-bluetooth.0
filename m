Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050323184658.95418.qmail@web50709.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] cannot connect to pm-325
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
Date: Wed, 23 Mar 2005 10:46:58 -0800 (PST)

 Not been prompted to enter pin, keep getting 
 
 Can't connect RFCOMM socket: Connection refused
 
 despite scan finding the device.
 
 put those lm and lp entries in hcid.conf, and even
 tried(afterward)putting the following in rfcomm.conf
 
 rfcomm0 {
 bind no;
 device    08:00:37:12:C4:B1;
 channel   1;
 comment   "PM325 by LG";
 }
 
 
 any ideas?



> --- Daniel Würfel <d.wuerfel@imail.de> wrote:
> 
> > Have you been told to enter a pin?
> > Check /etc/bluetooth/hcid.conf
> > lm accept,master;
> > 
> > lp hold,sniff,park,rswitch;
> > 
> > 
> > Check if there is an entry "BlueZ0" in your handy
> > and delete it.
> > Then try again.
> > 
> > 
> > -
> > ---- Original Message -----
> > From: "John H." <mistamaila@yahoo.com>
> > To: "D.W." <sword@gmx.de>;
> <bluetooth-dev@axis.com>
> > Sent: Wednesday, March 02, 2005 10:21 AM
> > Subject: Re: [bluetooth-dev] how to get bluetooth
> to
> > emulate comport?
> > 
> > 
> > > /etc/rc.d/init.d/bluetooth status
> > > hcid (pid 21924) is running...
> > > sdpd (pid 21930) is running...
> > >
> > > hci0:   Type: USB
> > >         BD Address: 00:02:72:81:AB:C4 ACL MTU:
> > 192:8
> > > SCO MTU: 64:8
> > >         UP RUNNING PSCAN ISCAN
> > >         RX bytes:1486 acl:35 sco:0 events:97
> > errors:0
> > >         TX bytes:1594 acl:35 sco:0 commands:42
> > > errors:0
> > >
> > > hcitool scan
> > > Scanning ...
> > >         08:00:37:0F:84:35      
> John@PM325(PHONE)
> > >
> > >
> > >  rfcomm connect 0 08:00:37:0F:84:35
> > > Can't connect RFCOMM socket: Connection refused
> > >
> > >
> > >
> > > --- "D.W." <sword@gmx.de> wrote:
> > >
> > > > Have you been told to enter a pin? Normally a
> > window
> > > > opens in Linux when
> > > > executing rfcomm where you can enter it.
> > > > Then you have to enter the same pin in your
> > phone
> > > > when asked for.
> > > >
> > > > Oh sorry, I forgot something: After "hciconfig
> > hci0
> > > > up" you have to execute
> > > > "hcid". Then run rfcomm ...
> > > >
> > > >
> > > > ----- Original Message -----
> > > > From: "John H." <mistamaila@yahoo.com>
> > > > To: <sword@gmx.de>; <bluetooth-dev@axis.com>
> > > > Sent: Tuesday, March 01, 2005 4:33 AM
> > > > Subject: Re: [bluetooth-dev] how to get
> > bluetooth to
> > > > emulate comport?
> > > >
> > > >
> > > > > ok, hciconfig hci0 up works
> > > > >
> > > > > I tried the second part and, despite telling
> > my
> > > > pm-325
> > > > > to be visible, and telling it waiting for
> > pairing,
> > > > got
> > > > > this...
> > > > >
> > > > >
> > > > > rfcomm connect 0 08:00:37:0f:84:35
> > > > > Can't connect RFCOMM socket: Connection
> > refused
> > > > >
> > > > >
> > > > > --- "D.W." <sword@gmx.de> wrote:
> > > > >
> > > > > > Try this:
> > > > > >
> > > > > > hciconfig hci0 up
> > > > > > rfcomm connect 0 <bt-address from your
> > handy>
> > > > > >
> > > > > > Then you shoulfdhave a com port
> /dev/rfcomm0
> > > > > > Daniel
> > > > > > ----- Original Message -----
> > > > > > From: "John H." <mistamaila@yahoo.com>
> > > > > > To: <bluetooth-dev@axis.com>
> > > > > > Sent: Thursday, February 24, 2005 3:55 AM
> > > > > > Subject: [bluetooth-dev] how to get
> > bluetooth to
> > > > > > emulate comport?
> > > > > >
> > > > > >
> > > > > > > i want to use my cell phone in linux as
> i
> > can
> > > > in
> > > > > > > windows, with bluetooth emulation, to
> > connect
> > > > to
> > > > > > > internet via dialing #777.
> > > > > > >
> > > > > > > I have zonet zub6110 usb adapter, which
> I
> > have
> > > > > > read
> > > > > > > works in linux.
> > > > > > >
> > > > > > > I am on fedora core 3.
> > > > > > >
> > > > > > > How do I get the com port emulation in
> > order
> > > > to
> > > > > > use it
> > > > > > > as a modem?
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > __________________________________
> > > > > > > Do you Yahoo!?
> > > > > > > Read only the mail you want - Yahoo!
> Mail
> > > > > > SpamGuard.
> > > > > > > http://promotions.yahoo.com/new_mail
> > > > > > > -
> > > > > > > To unsubscribe from this list: send the
> > line
> > > > > > "unsubscribe bluetooth-dev"
> > > > > > in
> > > > > > > the body of a message to
> > majordomo@axis.com
> > > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > __________________________________
> > > > > Do you Yahoo!?
> > > > > Read only the mail you want - Yahoo! Mail
> > > > SpamGuard.
> > > > > http://promotions.yahoo.com/new_mail
> > > > > -
> > > > > To unsubscribe from this list: send the line
> > > > "unsubscribe bluetooth-dev"
> > > > in
> > > > > the body of a message to majordomo@axis.com
> > > > >
> > > >
> > > >
> > >
> > >
> > >
> __________________________________________________
> > > Do You Yahoo!?
> > > Tired of spam?  Yahoo! Mail has the best spam
> > protection around
> > > http://mail.yahoo.com
> > > -
> > > To unsubscribe from this list: send the line
> > "unsubscribe bluetooth-dev"
> 
=== message truncated ===




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
