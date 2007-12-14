Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200712141119.40846.denis.kenzior@trolltech.com>
References: <200712141119.40846.denis.kenzior@trolltech.com>
Content-Type: multipart/mixed; boundary="=-zcaMAoDJGy60b0mjpKs8"
Date: Fri, 14 Dec 2007 20:51:13 +0530
Message-Id: <1197645673.28907.22.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel]  [PATCH] Fixes in headset_send
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-zcaMAoDJGy60b0mjpKs8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello, 

The following patch fixes headset_send(). It uses write() instead of
g_io_channel_write().

Let me know if anything needs to be changed. 

-Alok.

--=-zcaMAoDJGy60b0mjpKs8
Content-Disposition: attachment; filename=headset_send.patch
Content-Type: text/x-patch; name=headset_send.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff --git a/audio/headset.c b/audio/headset.c
index 446c1eb..2b9bfc8 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -136,7 +136,8 @@ static int headset_send(struct headset *hs, char *format, ...)
 {
 	char rsp[BUF_SIZE];
 	va_list ap;
-	gsize total_written, written, count;
+	ssize_t total_written, written, count;
+	int fd;
 
 	va_start(ap, format);
 	count = vsnprintf(rsp, sizeof(rsp), format, ap);
@@ -151,14 +152,12 @@ static int headset_send(struct headset *hs, char *format, ...)
 	}
 
 	written = total_written = 0;
+	fd = g_io_channel_unix_get_fd(hs->rfcomm);
 
 	while (total_written < count) {
-		GIOError io_err;
-
-		io_err = g_io_channel_write(hs->rfcomm, rsp + total_written,
-						count - total_written,
-						&written);
-		if (io_err != G_IO_ERROR_NONE)
+		written = write(fd, rsp + total_written,
+				count - total_written);
+		if (written < 0)
 			return -errno;
 
 		total_written += written;

--=-zcaMAoDJGy60b0mjpKs8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--=-zcaMAoDJGy60b0mjpKs8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-zcaMAoDJGy60b0mjpKs8--
