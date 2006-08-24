Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 24 Aug 2006 18:09:26 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060824150926.GQ8944@null.research.nokia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yVhtmJPUSI46BTXb"
Subject: [Bluez-devel] [PATCH] rfcomm_dev_del is called twice if
	RFCOMM_HANGUP_NOW flag is used
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

I noticed that rfcomm_dev_del() may be called twice if
RFCOMM_HANGUP_NOW flags is used with RFCOMMRELEASEDEV ioctl.

I made a patch that checks if dev is still in the device list before
calling deleting device.

The checking is done now in rfcomm_release_dev. Maybe better place would
be rfcomm_dev_del?

-- 
Ville

--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="20060824_rfcomm_tty_dev_double_del_fix.txt"

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index bd8d671..330760f 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -364,8 +364,13 @@ static int rfcomm_release_dev(void __use
 	if (req.flags & (1 << RFCOMM_HANGUP_NOW))
 		rfcomm_dlc_close(dev->dlc, 0);
 
-	rfcomm_dev_del(dev);
 	rfcomm_dev_put(dev);
+
+	/* dev might be deleted allready by rfcomm_dlc_close.
+	 * Check that device is still on the list. */
+	if ((dev = rfcomm_dev_get(req.dev_id)))
+		rfcomm_dev_del(dev);
+
 	return 0;
 }
 

--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--yVhtmJPUSI46BTXb--
