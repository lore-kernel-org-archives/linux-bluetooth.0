Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1154042299.16913.6.camel@localhost>
References: <1154042299.16913.6.camel@localhost>
Content-Type: multipart/mixed; boundary="=-P4IEboEv/jUq4uSuquVe"
Date: Fri, 28 Jul 2006 03:32:40 +0200
Message-Id: <1154050360.7650.13.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a	Belkin dongle in Debian
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--=-P4IEboEv/jUq4uSuquVe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alastair,

> I'm also experiencing the same behaviour as Felix with a Belkin dongle
> (Broadcom) with bluez-libs-3.2, bluez-utils-3.2. This is where ISCAN is
> not set even though it is enabled in hcid.conf. I've compiled from
> source on a Gentoo Linux box.
> 
> One additional thing that I would like to add is that I see this in my
> syslog:
> 
> Jul 28 00:10:15 qoo hcid[23009]: HCI dev 0 registered
> Jul 28 00:10:15 qoo hcid[23009]: Device hci0 has been added
> Jul 28 00:10:15 qoo hcid[23009]: Register path:/org/bluez/hci0
> fallback:0
> Jul 28 00:10:15 qoo hcid[23009]: HCI dev 0 up
> Jul 28 00:10:15 qoo hcid[23009]: Starting security manager 0
> Jul 28 00:10:16 qoo hcid[23009]: Can't write inquiry mode for hci0:
> Connection timed out (110)

the attached patch might help. If we have a Bluetooth 1.0b or 1.1 device
without a quirk to enable inqmode, we shouldn't even try to change the
inquiry mode. Seems that the Broadcom dongles are really sensible if you
try to send a command they don't support.

Regards

Marcel


--=-P4IEboEv/jUq4uSuquVe
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: hcid/device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/device.c,v
retrieving revision 1.14
diff -u -r1.14 device.c
--- hcid/device.c	26 Jul 2006 13:42:10 -0000	1.14
+++ hcid/device.c	28 Jul 2006 01:30:41 -0000
@@ -189,6 +189,7 @@
 	if (hci_read_local_version(dd, &ver, 1000) < 0) {
 		error("Can't read version info for hci%d: %s (%d)",
 					dev_id, strerror(errno), errno);
+		hci_close_dev(dd);
 		return -errno;
 	}
 
@@ -200,19 +201,24 @@
 	if (hci_read_local_features(dd, features, 1000) < 0) {
 		error("Can't read features for hci%d: %s (%d)",
 					dev_id, strerror(errno), errno);
+		hci_close_dev(dd);
 		return -errno;
 	}
 
 	memcpy(dev->features, features, 8);
 
 	inqmode = get_inquiry_mode(dev);
+	if (inqmode < 1)
+		goto done;
 
 	if (hci_write_inquiry_mode(dd, inqmode, 1000) < 0) {
 		error("Can't write inquiry mode for hci%d: %s (%d)",
 					dev_id, strerror(errno), errno);
+		hci_close_dev(dd);
 		return -errno;
 	}
 
+done:
 	hci_close_dev(dd);
 
 	info("Device hci%d has been activated", dev_id);

--=-P4IEboEv/jUq4uSuquVe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-P4IEboEv/jUq4uSuquVe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-P4IEboEv/jUq4uSuquVe--
