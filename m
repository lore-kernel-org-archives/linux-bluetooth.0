Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcid dying
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087819464.10134.26.camel@saag>
References: <1087817504.10134.16.camel@saag>
	 <1087818250.4328.1.camel@pegasus>  <1087819464.10134.26.camel@saag>
Content-Type: multipart/mixed; boundary="=-pBAvotwpaGBQBmsVKVhI"
Message-Id: <1087821035.4328.7.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 21 Jun 2004 14:30:36 +0200


--=-pBAvotwpaGBQBmsVKVhI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Edd,

> Debian (so I'm not excluding that this might be an error I introduced
> somehow :).
> 
> For me, 2.6.6-mh3 when it last happened, iirc.
> 
> For the bug reporter I spoke to, 2.4.26-1-686 (from Debian.)
> 
> I asked for diagnostics from the reporter, and he sent me the output of
> hciconfig -a, just after he restarted hcid:
> 
> hci0:   Type: USB
>         BD Address: 00:0A:9A:xx:xx:xx ACL MTU: 339:4  SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1978 acl:60 sco:0 events:53 errors:0
>         TX bytes:1111 acl:32 sco:0 commands:17 errors:0
>         Features: 0xff 0xff 0x3d 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'hactar-0202CC89E0E83C4EC7A99FE7ED3D12E970B...2.c'
>         Class: 0x100100
>         Service Classes: Object Transfer
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x93
>         Manufacturer: Transilica, Inc. (24)
> 
> notice the weird name.  This is with hcid.conf saying:
> 
> 	name "%h-%d";
> 
> which is the default for Debian.
> 
> Looks like there might be some bug in computing the device number.  It
> should be reading "hactar-0".

the device number is fine, but the expand_name() function is maybe
wrong. I don't know if this related somehow, but if it overwrites the
stack everything can happen. Here is a patch that restricts the device
name. It is untested so I don't know if it works.

Regards

Marcel


--=-pBAvotwpaGBQBmsVKVhI
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Index: hcid/lib.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/lib.c,v
retrieving revision 1.4
diff -u -b -w -B -r1.4 lib.c
--- hcid/lib.c	28 Apr 2004 12:09:32 -0000	1.4
+++ hcid/lib.c	21 Jun 2004 12:28:22 -0000
@@ -53,7 +53,7 @@
  * Device name expansion 
  * 	%d - device id
  */
-char *expand_name(char *dst, char *str, int dev_id)
+char *expand_name(char *dst, int size, char *str, int dev_id)
 {
 	register int sp, np, olen;
 	char *opt, buf[10];
@@ -62,7 +62,7 @@
 		return NULL;
 
 	sp = np = 0;
-	while (str[sp]) {
+	while (np < size - 1 && str[sp]) {
 		switch (str[sp]) {
 		case '%':
 			opt = NULL;
@@ -88,6 +88,7 @@
 			if (opt) {
 				/* substitute */
 				olen = strlen(opt);
+				if (np + olen < size - 1)
 				memcpy(dst + np, opt, olen);
 				np += olen;
 			}
Index: hcid/lib.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/lib.h,v
retrieving revision 1.3
diff -u -b -w -B -r1.3 lib.h
--- hcid/lib.h	28 Apr 2004 12:09:32 -0000	1.3
+++ hcid/lib.h	21 Jun 2004 12:28:22 -0000
@@ -30,7 +30,7 @@
 
 #include <errno.h>
 
-char *expand_name(char *dst, char *str, int dev_id);
+char *expand_name(char *dst, int size, char *str, int dev_id);
 
 char *get_host_name(void);
 
Index: hcid/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/main.c,v
retrieving revision 1.15
diff -u -b -w -B -r1.15 main.c
--- hcid/main.c	7 May 2004 23:08:03 -0000	1.15
+++ hcid/main.c	21 Jun 2004 12:28:22 -0000
@@ -227,7 +227,8 @@
 	/* Set device name */
 	if (device_opts->name) {
 		change_local_name_cp cp;
-		expand_name(cp.name, device_opts->name, hdev);
+		memset(cp.name, 0, sizeof(cp.name));
+		expand_name(cp.name, sizeof(cp.name), device_opts->name, hdev);
 
 		hci_send_cmd(s, OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME,
 			CHANGE_LOCAL_NAME_CP_SIZE, (void *) &cp);

--=-pBAvotwpaGBQBmsVKVhI--



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
