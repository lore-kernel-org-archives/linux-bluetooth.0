Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44CA1039.8040704@gmail.com>
Date: Fri, 28 Jul 2006 15:25:13 +0200
From: Sebastien Henrio <sebastien.henrio@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <99f8b4660607261555t5a297fe1y6df50e93b9517548@mail.gmail.com>
	<44C80C19.80409@xmission.com>
In-Reply-To: <44C80C19.80409@xmission.com>
Content-Type: multipart/mixed; boundary="------------030406040703080906050500"
Cc: Sebastien HENRIO <sebastien.henrio@gmail.com>
Subject: Re: [Bluez-devel] A2DP: signaling channel never closed
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

This is a multi-part message in MIME format.
--------------030406040703080906050500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Brad,

sorry for the patch, you can find in attachement the new patch in the
correct format

Best Regards
Sebastien

Brad Midgley wrote:
> Sebastien
> 
> I'm glad you came across this. Would you mind resending the patch using
> the output from
>  diff -u
> so it's easier to read and apply?
> 
> Which headset did you observe the problem on?
> 
> thanks
> Brad
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


--------------030406040703080906050500
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Index: pcm_a2dp.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/pcm_a2dp.c,v
retrieving revision 1.13
diff -u -r1.13 pcm_a2dp.c
--- pcm_a2dp.c	12 Jul 2006 05:47:07 -0000	1.13
+++ pcm_a2dp.c	28 Jul 2006 12:58:26 -0000
@@ -974,9 +974,6 @@
 
 	a2dp->sbc.rate = io->rate;
 	a2dp->sbc.channels = io->channels;
-	a2dp->sbc.subbands = 8; // safe default
-	a2dp->sbc.blocks = 16; // safe default
-	a2dp->sbc.bitpool = 32; // recommended value 53, safe default is 32
 
 	return 0;
 }
@@ -1210,6 +1207,9 @@
 	if (a2dp->sk > fileno(stderr))
 		close(a2dp->sk);
 
+	if (a2dp->control_sk > fileno(stderr))
+		close(a2dp->control_sk);
+
 	sbc_finish(&a2dp->sbc);
 
 	free(a2dp);
@@ -1343,6 +1343,8 @@
 	snd_config_iterator_t i, next;
 	bdaddr_t src, dst;
 	int err, n, pos = -1, use_rfcomm = 0;
+	long bitpool = -1,subbnd = -1, blklen = -1;
+
 
 	DBG("name %s mode %d", name, mode);
 
@@ -1378,6 +1380,34 @@
 			continue;
 		}
 
+		if (!strcmp(id, "sbc_bitpool")) {
+			if ((err = snd_config_get_integer(n, &bitpool )) < 0 &&
+					( bitpool < 0 || 254 < bitpool))  {
+                                SNDERR("The field for bitpool must be an unsigned integer");
+                                return err;
+                        }
+			continue;
+		}
+
+		if (!strcmp(id, "sbc_blklen")) {
+			if ((err = snd_config_get_integer(n, &blklen)) < 0 &&
+					( blklen != 4 && blklen != 8 && blklen != 12 && blklen != 16)) {
+				SNDERR("The field for blocklen must be either 4, 8, 12 or 16");
+				return err;
+			}
+			continue;
+		}
+
+		if (!strcmp(id, "sbc_subband")) {
+			if ((err = snd_config_get_integer(n, &subbnd)) < 0 &&
+				 ( subbnd != 4 && subbnd != 8)) {
+				SNDERR("The field for subband must be either 4 or 8");
+				return err;
+			}
+			continue;
+		}
+
+
 		if (!strcmp(id, "use_rfcomm")) {
 			if ((err = snd_config_get_bool(n)) < 0) {
                                 SNDERR("The field use_rfcomm must be a boolean type");
@@ -1426,6 +1456,25 @@
 		bacpy(&a2dp->dst, &dst);
 		a2dp->use_rfcomm = use_rfcomm;
 	}
+	a2dp->sbc.subbands = 8; // safe default
+	a2dp->sbc.blocks = 16; // safe default
+	a2dp->sbc.bitpool = 32; // recommended value 53, safe default is 32
+
+	if (bitpool != -1){
+		DBG("sbc : bitpool %d" , (int)bitpool);
+		a2dp->sbc.bitpool = (int)bitpool;
+	}
+
+	if (blklen != -1){
+		DBG("sbc : subbands %d" , (int)subbnd);
+		a2dp->sbc.subbands = (int)subbnd;
+	}
+
+	if (blklen != -1){
+		DBG("sbc : blklen %d" , (int)blklen);
+		a2dp->sbc.blocks = (int)blklen;
+	}
+
 
 	a2dp_unlock();
 

--------------030406040703080906050500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------030406040703080906050500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030406040703080906050500--
