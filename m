Return-Path: <trexx@pobox.com>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Terence Rudkin <trexx@pobox.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Olivier Bornet <Olivier.Bornet@puck.ch>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1074597908.7088.5.camel@pegasus>
References: <1074457244.3254.17.camel@localhost.localdomain>
	 <1074458664.6070.73.camel@pegasus>
	 <1074480891.2817.10.camel@localhost.localdomain>
	 <1074514935.6070.80.camel@pegasus>
	 <1074568150.7831.5.camel@localhost.localdomain>
	 <20040120081245.GA1871@smartdata.ch>  <1074597908.7088.5.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075234547.3064.13.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Tue, 27 Jan 2004 13:15:47 -0700
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

I finally had a chance to patch kernel and try hid2hci  with this patch
kernel.   I still got success. but hcitool dev never reported any
devices.   I looked at the code in hid2hci, my diff is below. 

I first made the change at 204.  And found that the /dev/usb/hid was not
opening.  Finding me /dev to be /dev/usb I changed line 79 to match my
file structure.   

Now I get
hciconfig
hci0:   Type: USB
        BD Address: 00:07:61:07:ED:A9 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:131 acl:0 sco:0 events:14 errors:0
        TX bytes:32 acl:0 sco:0 commands:13 errors:0

But not input from mouse and keyboard.


 #> cvs diff  hid2hci.c
Index: hid2hci.c
===================================================================
RCS file: /cvsroot/bluez/utils2/hid/hid2hci.c,v
retrieving revision 1.3
diff -r1.3 hid2hci.c
79c79
< static char hidpath[PATH_MAX + 1] = "/dev/usb/hid";
---
> static char hidpath[PATH_MAX + 1] = "/dev/usb";
204c204
<       int i, fd, err = 0;
---
>       int i, fd, err = -1;


On Tue, 2004-01-20 at 04:25, Marcel Holtmann wrote:
> Hi Olivier,
> 
> > Look at the thread:
> > 
> >    http://sourceforge.net/mailarchive/message.php?msg_id=6881178
> > 
> > You need to patch your kernel for having hid2hci working. Note also that
> > at this time, you can only switch from hid to hci, and not from hci to
> > hid.
> 
> at the moment nobody is quite sure if this patch is really correct and
> don't break any other devices, but it is working for our needs and I
> included it into my latest -mh patches for the 2.4 series.
> 
> Regards
> 
> Marcel
> 
-- 
