Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Guillaume Bedot <littletux@zarb.org>
To: Ekiga mailing list <ekiga-list@gnome.org>
Content-Type: multipart/mixed; boundary="=-HDKvGpXw2KxuJtinvMiR"
Date: Fri, 20 Apr 2007 10:05:52 +0200
Message-Id: <1177056352.4604.18.camel@littletux>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Using ekiga with bluetooth headset
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


--=-HDKvGpXw2KxuJtinvMiR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I'm currently using ekiga with a USB bluetooth dongle (ASUS WL-BTD202)
and a bluetooth headset (PROF PBH-6W).

It's quite tricky yet (patching kernel, pwlib, and compile several
software from CVS...), but works. thanks to the devs :-)

Here is a simple update of the patch that can be found on plugz's cvs,
to apply on pwlib 1.10.7 (and maybe some previous versions).  

I'd like to enhance the patch with detecting the headset, but don't know
how...

Should pwlib interact with headsetd to ask if a headset is currently
connected ?

Best regards,


Guillaume B.


--=-HDKvGpXw2KxuJtinvMiR
Content-Disposition: attachment; filename=pwlib-1.10.7-btheadset.patch
Content-Type: text/x-patch; name=pwlib-1.10.7-btheadset.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- pwlib-1.10.7.orig/plugins/sound_alsa/sound_alsa.cxx	2007-04-19 18:07:46.000000000 +0200
+++ pwlib-1.10.7/plugins/sound_alsa/sound_alsa.cxx	2007-04-19 18:12:22.000000000 +0200
@@ -284,6 +284,8 @@
       devices += playback_devices.GetKeyAt (j);
   }
   
+  devices += "Bluetooth headset";
+
   return devices;
 }
 
@@ -330,6 +332,10 @@
     real_device_name = "default";
     card_nr = -2;
   }
+  else if(_device == "Bluetooth headset") {
+    real_device_name = "headset";
+    card_nr = -3;
+  }
   else {
 
   if ((_dir == Recorder && capture_devices.IsEmpty ())
@@ -840,10 +846,15 @@
   if (!os_handle)
     return FALSE;
 
-  if (card_nr == -2)
+  if (card_nr == -2) {
     card_name = "default";
-  else
+  }
+  else if(card_nr == -3) {
+    card_name = "headset";
+  } 
+  else {
     card_name = "hw:" + PString (card_nr);
+  }
 
   //allocate simple id
   snd_mixer_selem_id_alloca (&sid);

--=-HDKvGpXw2KxuJtinvMiR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-HDKvGpXw2KxuJtinvMiR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-HDKvGpXw2KxuJtinvMiR--
