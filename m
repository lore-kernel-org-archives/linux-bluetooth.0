Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080109002828.GB5883@ps.ms.mff.cuni.cz>
References: <20080109002828.GB5883@ps.ms.mff.cuni.cz>
Content-Type: multipart/mixed; boundary="=-hV5oJaSL6fnssgi0pXVS"
Date: Wed, 09 Jan 2008 16:07:44 +0530
Message-Id: <1199875064.6463.4.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] HFP - Rejecting a call
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


--=-hV5oJaSL6fnssgi0pXVS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan, 

Here is a patch which handles the "Call Rejection" use case.
Let me know if anything needs to be changed. 

Alok. 

--=-hV5oJaSL6fnssgi0pXVS
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.155
diff -u -5 -p -r1.155 headset.c
--- audio/headset.c	9 Jan 2008 03:00:22 -0000	1.155
+++ audio/headset.c	9 Jan 2008 10:05:54 -0000
@@ -250,19 +250,21 @@ static int terminate_call(struct device 
 
 	dbus_connection_emit_signal(device->conn, device->path,
 			AUDIO_HEADSET_INTERFACE, "CallTerminated",
 			DBUS_TYPE_INVALID);
 
+	err = headset_send(hs, "\r\nOK\r\n");
+	if (err < 0)
+		return err;
+
 	if (hs->ring_timer) {
 		g_source_remove(hs->ring_timer);
 		hs->ring_timer = 0;
+		/*+CIEV: (callsetup = 0)*/
+		return headset_send(hs, "\r\n+CIEV:2, 0\r\n");
 	}
 
-	err = headset_send(hs, "\r\nOK\r\n");
-	if (err < 0)
-		return err;
-
 	/*+CIEV: (call = 0)*/
 	return headset_send(hs, "\r\n+CIEV:2, 0\r\n");
 }
 
 static int signal_gain_setting(struct device *device, const char *buf)

--=-hV5oJaSL6fnssgi0pXVS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--=-hV5oJaSL6fnssgi0pXVS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-hV5oJaSL6fnssgi0pXVS--
