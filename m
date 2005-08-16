Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Whoopie" <whoopie79@gmx.net>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002D_01C5A2C9.AA43BF60"
Message-ID: <E1E5AiB-0000wJ-Dw@mail.sourceforge.net>
Subject: [Bluez-devel] Patch for btsco kernel module (index parameter)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Aug 2005 01:19:06 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_002D_01C5A2C9.AA43BF60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
I made a small patch for the btsco kernel module, so that it doesn't grep
the ALSA device 0. And you can specify any index parameter.
I think that it's important because the soundcard should be device 0. Now, I
can load the module in /etc/modules at startup.

It's based on the ALSA modem drivers, so it was just a copy&paste work.

Regards,
Whoopie

------=_NextPart_000_002D_01C5A2C9.AA43BF60
Content-Type: text/x-patch;
	name="btsco.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="btsco.c.patch"

--- btsco.c.orig	2005-08-16 23:12:56.000000000 +0200
+++ btsco.c	2005-08-17 00:19:59.000000000 +0200
@@ -63,6 +63,11 @@
=20
 static char *mod_revision =3D "$Revision: 1.6 $";
=20
+static int index[SNDRV_CARDS] =3D {[0 ... (SNDRV_CARDS - 1)] =3D -2}; =
/* Exclude the first card */
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for Bluetooth SCO Headset =
Soundcard.");
+
 #undef dprintk
 #if 1
 #define dprintk(fmt...) printk(KERN_INFO "snd-bt-sco: " fmt)
@@ -964,7 +969,7 @@
 	snd_hwdep_t *hw;
=20
 	card =3D
-	    snd_card_new(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+	    snd_card_new(index[dev], SNDRV_DEFAULT_STR1,
 			 THIS_MODULE, 0);
 	if (card =3D=3D NULL)
 		return -ENOMEM;

------=_NextPart_000_002D_01C5A2C9.AA43BF60--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
