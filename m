Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Marcel Holtmann <marcel@holtmann.org>
To: Terence Rudkin <trexx@pobox.com>
Cc: Olivier Bornet <Olivier.Bornet@puck.ch>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075306699.1793.38.camel@localhost.localdomain>
References: <1074457244.3254.17.camel@localhost.localdomain>
	 <1074458664.6070.73.camel@pegasus>
	 <1074480891.2817.10.camel@localhost.localdomain>
	 <1074514935.6070.80.camel@pegasus>
	 <1074568150.7831.5.camel@localhost.localdomain>
	 <20040120081245.GA1871@smartdata.ch>  <1074597908.7088.5.camel@pegasus>
	 <1075234547.3064.13.camel@localhost.localdomain>
	 <1075276833.12766.56.camel@pegasus>
	 <1075306699.1793.38.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1075307541.26729.18.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 28 Jan 2004 17:32:21 +0100

Hi Terence,

> I reviewed the code.  I focused on this section of code in
> switch_logitech(...)
> {
>     char devname[PATH_MAX + 1];
>     int i, fd, err = 0;
>     for (i = 0; i < 16; i++) {
> ...
> 	sprintf(devname, "%s/hiddev%d", hidpath, i);
> 	fd = open(devname, O_RDWR);
> 	if (fd < 0)
> 		continue;
> ...
> It occurred to me that open() could fail the 16 times and not report
> that to the caller.  So i init'ed err to -1.  This is fine because  if
> the open() works then err will be set based on the ioctl() or
> send_report() calls.  But if open() fails all 16 time then the caller is
> advised that something is wrong. 
> 
> Once I confirmed that in fact I was failing when I called hid2hci  I
> went to understand why.  This was I had for dev dirtree. 
>    /dev/usb/hiddev 
> not
>    /dev/usb/hid/hiddev 
> as set in hidpath. So to work on my system I needed to change the
> hidpath.   
> 
> While this works on my system.  What other systems might it break?   A
> dynamic function to pull the correct value? Or is there a naming
> authority, a header file, where this can be found?

I used the devfs path, because my Debian Sid has no default device node
for it. What is your system?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
