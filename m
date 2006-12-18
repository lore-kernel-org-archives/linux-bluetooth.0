Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Markus Uhr <uhrm@student.ethz.ch>
Date: Mon, 18 Dec 2006 21:04:03 +0000 (UTC)
Message-ID: <loom.20061218T215536-830@post.gmane.org>
References: <4580168C.2060806@aon.at>
	<1166359631.6557.37.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] rfcomm kernel 2.6.19 probs
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Johannes,
> 
> > I am using bluetooth to conntect my laptop and my palm for browsing the 
> > web to my linux workstation. Everything were working perfect untill I 
> > updated to kernel 2.6.19.
> > The devices could not connect to my workstation anymore - got a timeout 
> > error. Currently I am running:
> > Workstation:
> > gentoo-2006.1,
> > kernel 2.6.19-r2
> > bluez-libs 2.25
> > bluez-utils 2.25-r1
> > 
> > In my workstation's log I found:
> > kernel message: rfcomm_tty_ioctl: TIOCGSERIAL is not supported.
> > and the /dev/rfcommX device is not created.
> > 
> > For troubleshooting I had a look at you patch 2.6.18-mh8 and found out 
> > that this patches tty.c. I found out that "reversing" the patch at
> > 
> > net/bluetooth/rfcomm/tty.c
> > In function:
> >     static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
> >     ....
> >     /*tty_register_device(rfcomm_tty_driver, dev->id, 
> > rfcomm_get_device(dev));*/
> >     tty_register_device(rfcomm_tty_driver, dev->id, NULL);
> > 
> > is enough to get everything working again.
> > 
> > So my questions: is this a bug or do I have to change my setup? Is there 
> > any other solution than patching the file each time updating the kernel?
> 
> my guess is that your udev version is too old, because everything works
> fine for me.
> 

Hello

I'm observing the same (or a similar) problem. I'm using the same software
versions as Johannes and udev-103. When I do an udevmonitor, I get the following
output when I dial in:

UEVENT[1166035369.025781]
add@/devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/hci0/acl0016CB124BAF
UDEV  [1166035369.128570]
add@/devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/hci0/acl0016CB124BAF
UEVENT[1166035370.486542] add@/class/tty/rfcomm0
UDEV  [1166035370.595947] add@/class/tty/rfcomm0
UEVENT[1166035370.611817] remove@/class/tty/rfcomm0
UDEV  [1166035370.798743] remove@/class/tty/rfcomm0
UEVENT[1166035394.691062]
remove@/devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/hci0/acl0016CB124BAF
UDEV  [1166035394.709361]
remove@/devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/hci0/acl0016CB124BAF 


Every fifth or so attempt succeeds in creating a ppp connection:

UEVENT[1166035407.563758]
add@/devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/hci0/acl0016CB124BAF
UDEV  [1166035407.627811]
add@/devices/pci0000:00/0000:00:1d.1/usb2/2-2/2-2:1.0/hci0/acl0016CB124BAF
UEVENT[1166035409.038378] add@/class/tty/rfcomm0
UDEV  [1166035409.071071] add@/class/tty/rfcomm0
UEVENT[1166035409.165296] add@/class/net/ppp0
UDEV  [1166035409.196920] add@/class/net/ppp0


With a kernel <=2.6.18 every attempt succeeds.

Regards,
Makrus Uhr


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
