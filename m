Return-Path: <cyrus@holtmann.org>
From: Christian Hoene <hoene@uni-tuebingen.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100810300846j79b94bf8h4d8974ed50b1ac23@mail.gmail.com>
References: <001d01c93a9f$6f2c8710$4d859530$@de>
	<1225380052.4626.8.camel@hoene-desktop>
	<2d5a2c100810300846j79b94bf8h4d8974ed50b1ac23@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-seaYr5lxhuPxrx/IzaPg"
Date: Thu, 30 Oct 2008 17:07:24 +0100
Message-Id: <1225382844.4626.13.camel@hoene-desktop>
Mime-Version: 1.0
Cc: Frans de Bont <frans.de.bont@philips.com>
Subject: Re: [Bluez-devel] FW: REALLY Bad encoding performance of Linux
	SBC	audio codec
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-seaYr5lxhuPxrx/IzaPg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2008-10-30 at 12:46 -0300, Luiz Augusto von Dentz wrote:
> Could you please send it as a real patch, I mean in diff format, or
> even better if you could configure a git repository so we could pull
> from.
> 
> Thank you for the contribution.

patch is attached.

--=-seaYr5lxhuPxrx/IzaPg
Content-Disposition: attachment; filename=sbcdec_buffer.patch
Content-Type: text/x-patch; name=sbcdec_buffer.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/sbc/sbcdec.c b/sbc/sbcdec.c
index 555ace5..2464c42 100644
--- a/sbc/sbcdec.c
+++ b/sbc/sbcdec.c
@@ -157,7 +157,7 @@ static void decode(char *filename, char *output, int tofile)
 		}
 	}
 
-	count = 0;
+	count = len;
 	while (framelen > 0) {
 		/* we have completed an sbc_decode at this point sbc.len is the
 		 * length of the frame we just decoded count is the number of
@@ -179,15 +179,15 @@ static void decode(char *filename, char *output, int tofile)
 			exit(1);
 		}
 
-		/* increase the count */
-		count += len;
-
 		/* push the pointer in the file forward to the next bit to be
 		 * decoded tell the decoder to decode up to the remaining
 		 * length of the file (!) */
 		pos += framelen;
 		framelen = sbc_decode(&sbc, stream + pos, streamlen - pos,
 					buf + count, sizeof(buf) - count, &len);
+
+		/* increase the count */
+		count += len;
 	}
 
 	if (count > 0) {

--=-seaYr5lxhuPxrx/IzaPg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--=-seaYr5lxhuPxrx/IzaPg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-seaYr5lxhuPxrx/IzaPg--
