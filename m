Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-d8SqVMIgf3dNfLW4T+IV"
Date: Thu, 28 Feb 2008 16:20:47 +0530
Message-Id: <1204195848.25999.40.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [Patch][HFP] no_hfp and DisableHFP
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


--=-d8SqVMIgf3dNfLW4T+IV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan, 

Here is the patch to replace no_hfp with hfp and DisableHFP with
EnableHFP. 

Let me know.

Thanks, 
Alok.

--=-d8SqVMIgf3dNfLW4T+IV
Content-Disposition: attachment; filename=patch1
Content-Type: text/x-patch; name=patch1; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/audio.conf
===================================================================
RCS file: /cvsroot/bluez/utils/audio/audio.conf,v
retrieving revision 1.5
diff -u -5 -p -r1.5 audio.conf
--- audio/audio.conf	23 Jan 2008 13:27:30 -0000	1.5
+++ audio/audio.conf	27 Feb 2008 15:22:16 -0000
@@ -16,11 +16,11 @@
 # service interacts with remote headset devices)
 [Headset]
 
 # Set to true to only support HSP
 # Defaults to false
-DisableHFP=true
+EnableHFP=false
 
 # HFP Gateway features
 # Defaults to false
 3WayCalling=false
 EchoCancelNoiseCancel=false
Index: audio/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/manager.c,v
retrieving revision 1.90
diff -u -5 -p -r1.90 manager.c
--- audio/manager.c	19 Feb 2008 08:20:22 -0000	1.90
+++ audio/manager.c	27 Feb 2008 15:22:18 -0000
@@ -1538,11 +1538,11 @@ static GIOChannel *server_socket(uint8_t
 
 static int headset_server_init(DBusConnection *conn, GKeyFile *config)
 {
 	uint8_t chan = DEFAULT_HS_AG_CHANNEL;
 	sdp_buf_t buf;
-	gboolean no_hfp = FALSE;
+	gboolean hfp = TRUE;
 	GError *err = NULL;
 	uint32_t features;
 
 	if (!(enabled.headset || enabled.gateway))
 		return 0;
@@ -1567,20 +1567,20 @@ static int headset_server_init(DBusConne
 
 	g_io_add_watch(hs_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				(GIOFunc) ag_io_cb, NULL);
 
 	if (config) {
-		no_hfp = g_key_file_get_boolean(config, "Headset", "DisableHFP",
+		hfp = g_key_file_get_boolean(config, "Headset", "EnableHFP",
 						&err);
 		if (err) {
 			debug("audio.conf: %s", err->message);
 			g_error_free(err);
 			err = NULL;
 		}
 	}
 
-	if (no_hfp)
+	if (!hfp)
 		return 0;
 
 	chan = DEFAULT_HF_AG_CHANNEL;
 
 	hf_server = server_socket(&chan);

--=-d8SqVMIgf3dNfLW4T+IV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-d8SqVMIgf3dNfLW4T+IV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-d8SqVMIgf3dNfLW4T+IV--
