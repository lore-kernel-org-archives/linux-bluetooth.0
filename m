Return-Path: <trexx@pobox.com>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Terence Rudkin <trexx@pobox.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Olivier Bornet <Olivier.Bornet@puck.ch>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075276833.12766.56.camel@pegasus>
References: <1074457244.3254.17.camel@localhost.localdomain>
	 <1074458664.6070.73.camel@pegasus>
	 <1074480891.2817.10.camel@localhost.localdomain>
	 <1074514935.6070.80.camel@pegasus>
	 <1074568150.7831.5.camel@localhost.localdomain>
	 <20040120081245.GA1871@smartdata.ch>  <1074597908.7088.5.camel@pegasus>
	 <1075234547.3064.13.camel@localhost.localdomain>
	 <1075276833.12766.56.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075306699.1793.38.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Wed, 28 Jan 2004 09:18:20 -0700
List-ID: <bluez-users.lists.sourceforge.net>

On Wed, 2004-01-28 at 01:00, Marcel Holtmann wrote:
> Hi Terence,
> 
> > I finally had a chance to patch kernel and try hid2hci  with this patch
> > kernel.   I still got success. but hcitool dev never reported any
> > devices.   I looked at the code in hid2hci, my diff is below. 
> > 
> > I first made the change at 204.  And found that the /dev/usb/hid was not
> > opening.  Finding me /dev to be /dev/usb I changed line 79 to match my
> > file structure.   
> 
> be more specific and make a unified diff.

I reviewed the code.  I focused on this section of code in
switch_logitech(...)
{
    char devname[PATH_MAX + 1];
    int i, fd, err = 0;
    for (i = 0; i < 16; i++) {
...
	sprintf(devname, "%s/hiddev%d", hidpath, i);
	fd = open(devname, O_RDWR);
	if (fd < 0)
		continue;
...
It occurred to me that open() could fail the 16 times and not report
that to the caller.  So i init'ed err to -1.  This is fine because  if
the open() works then err will be set based on the ioctl() or
send_report() calls.  But if open() fails all 16 time then the caller is
advised that something is wrong. 

Once I confirmed that in fact I was failing when I called hid2hci  I
went to understand why.  This was I had for dev dirtree. 
   /dev/usb/hiddev 
not
   /dev/usb/hid/hiddev 
as set in hidpath. So to work on my system I needed to change the
hidpath.   

While this works on my system.  What other systems might it break?   A
dynamic function to pull the correct value? Or is there a naming
authority, a header file, where this can be found?






 $> diff -dur hid2hci.c.orig hid2hci.c
--- hid2hci.c.orig      2004-01-27 12:57:42.000000000 -0700
+++ hid2hci.c   2004-01-27 12:59:29.000000000 -0700
@@ -76,7 +76,7 @@
 #define USB_DIR_OUT            0x00
  
  
-static char hidpath[PATH_MAX + 1] = "/dev/usb/hid";
+static char hidpath[PATH_MAX + 1] = "/dev/usb";
  
 struct hiddev_devinfo {
        unsigned int bustype;
@@ -201,7 +201,7 @@
 static int switch_logitech(struct device_info *dev)
 {
        char devname[PATH_MAX + 1];
-       int i, fd, err = 0;
+       int i, fd, err = -1;
  
        for (i = 0; i < 16; i++) {
                struct hiddev_devinfo dinfo;



> 
> Marcel
> 
-- 
