Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Marcel Holtmann <marcel@holtmann.org>
To: Terence Rudkin <trexx@pobox.com>
Cc: Olivier Bornet <Olivier.Bornet@puck.ch>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075315567.1793.44.camel@localhost.localdomain>
References: <1074457244.3254.17.camel@localhost.localdomain>
	 <1074458664.6070.73.camel@pegasus>
	 <1074480891.2817.10.camel@localhost.localdomain>
	 <1074514935.6070.80.camel@pegasus>
	 <1074568150.7831.5.camel@localhost.localdomain>
	 <20040120081245.GA1871@smartdata.ch>  <1074597908.7088.5.camel@pegasus>
	 <1075234547.3064.13.camel@localhost.localdomain>
	 <1075276833.12766.56.camel@pegasus>
	 <1075306699.1793.38.camel@localhost.localdomain>
	 <1075307541.26729.18.camel@pegasus>
	 <1075315567.1793.44.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-0IHA1tXhONX+2+tBSWV/"
Message-Id: <1075317417.26729.37.camel@pegasus>
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
Date: Wed, 28 Jan 2004 20:16:57 +0100


--=-0IHA1tXhONX+2+tBSWV/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Terence,

> > I used the devfs path, because my Debian Sid has no default device node
> > for it. What is your system?
> The most recent is Fedora, with the 2.6.1 kernel  

please try this patch.

Regards

Marcel


--=-0IHA1tXhONX+2+tBSWV/
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Index: hid2hci.c
===================================================================
RCS file: /cvsroot/bluez/utils2/hid/hid2hci.c,v
retrieving revision 1.3
diff -u -r1.3 hid2hci.c
--- hid2hci.c	6 Jan 2004 17:45:11 -0000	1.3
+++ hid2hci.c	28 Jan 2004 16:35:45 -0000
@@ -76,7 +76,7 @@
 #define USB_DIR_OUT		0x00
 
 
-static char hidpath[PATH_MAX + 1] = "/dev/usb/hid";
+static char hidpath[PATH_MAX + 1] = "/dev/usb";
 
 struct hiddev_devinfo {
 	unsigned int bustype;
@@ -211,8 +211,12 @@
 
 		sprintf(devname, "%s/hiddev%d", hidpath, i);
 		fd = open(devname, O_RDWR);
-		if (fd < 0)
-			continue;
+		if (fd < 0) {
+			sprintf(devname, "%s/hid/hiddev%d", hidpath, i);
+			fd = open(devname, O_RDWR);
+			if (fd < 0)
+				continue;
+		}
 
 		memset(&dinfo, 0, sizeof(dinfo));
 		err = ioctl(fd, HIDIOCGDEVINFO, &dinfo);

--=-0IHA1tXhONX+2+tBSWV/--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
