Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Till Harbaum <till@harbaum.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Little Hexdump-Patch for hcidump
References: <50BF37ECE4954A4BA18C08D0C2CF88CB2364EC@exmail1.se.axis.com> <200408261844.20194.harbaum@beecon.de> <1093539822.2581.32.camel@pegasus>
In-Reply-To: <1093539822.2581.32.camel@pegasus>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_t1iLBtYo4N+eOOk"
Message-Id: <200408262035.25412.till@harbaum.org>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 26 Aug 2004 20:35:25 +0200


--Boundary-00=_t1iLBtYo4N+eOOk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 26 August 2004 19:03, Marcel Holtmann wrote:
> please send me a patch (diff -u) and adjust a little bit your coding
> style to match the other sources of hcidump.
Sorry ... of course .. here you go

Ciao,
  Till

-- 
Dr.Ing. Till Harbaum, till@harbaum.org

--Boundary-00=_t1iLBtYo4N+eOOk
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hexdump.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hexdump.patch"

--- bluez-hcidump-1.10/parser/parser.c	2004-08-26 20:22:06.000000000 +0200
+++ bluez-hcidump-1.10-t/parser/parser.c	2004-08-26 20:23:45.000000000 +0200
@@ -99,23 +99,36 @@
 
 void hex_dump(int level, struct frame *frm, int num)
 {
-	unsigned char *buf = frm->ptr;
-	register int i,n;
+        unsigned char *buf = frm->ptr;
+        register int i,n,b2c;
 
-	if ((num < 0) || (num > frm->len))
-		num = frm->len;
+        if ((num < 0) || (num > frm->len))
+                num = frm->len;
+
+        n = 0;
+        while(num>0) {
+                p_indent(level, frm);
+                printf("%04x: ", n);
+
+                b2c = (num>16)?16:num;
+
+		for(i=0;i<b2c;i++) 
+		        printf("%02x ", buf[i]);
+
+		for(i=0;i<(16-b2c);i++) 
+		        printf("   ");
+
+		printf("  ");
+
+		for(i=0;i<b2c;i++) 
+		        printf("%c", isprint(buf[i])?buf[i]:'.');
 
-	for (i = 0, n = 1; i < num; i++, n++) {
-		if (n == 1)
-			p_indent(level, frm);
-		printf("%2.2X ", buf[i]);
-		if (n == DUMP_WIDTH) {
-			printf("\n");
-			n = 0;
-		}
-	}
-	if (i && n!=1)
 		printf("\n");
+
+		buf  += b2c;
+		num  -= b2c;
+		n    += b2c;
+        }
 }
 
 void ascii_dump(int level, struct frame *frm, int num)

--Boundary-00=_t1iLBtYo4N+eOOk--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
