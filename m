Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050227082859.31822.qmail@web50706.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <50BF37ECE4954A4BA18C08D0C2CF88CB0104037E@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] how to get bluetooth to emulate comport?
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
Date: Sun, 27 Feb 2005 00:28:59 -0800 (PST)

I have zonet usb dongle, pm-325 sprint phone.

hciconfig hci0 up

Can't open HCI socket.: Address family not
supported by protocol

I thought i installed the necessary modules?

Also, pin link is broken.


> > 
> > --- "D.W." <sword@gmx.de> wrote:
> > 
> > > Try this:
> > > 
> > > hciconfig hci0 up
> > > rfcomm connect 0 <bt-address from your handy>
> > > 
> > > Then you shoulfdhave a com port /dev/rfcomm0
> > > Daniel


		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
