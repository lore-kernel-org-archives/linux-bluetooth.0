Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 4 May 2007 11:41:57 +0200
References: <200705021525.07661.dgollub@suse.de>
	<1178260779.25425.24.camel@violet>
In-Reply-To: <1178260779.25425.24.camel@violet>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_m/vOGqwvlBuYuO2"
Message-Id: <200705041141.58326.dgollub@suse.de>
Subject: Re: [Bluez-devel] [PATCH] Input Service support for phones
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

--Boundary-00=_m/vOGqwvlBuYuO2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 04 May 2007, Marcel Holtmann wrote:
> a subpath == "phone" is fully enough. Don't make it more complicated
> than it needs to be.

full ack. Adapted patch attachted.

best regards,
Daniel

--Boundary-00=_m/vOGqwvlBuYuO2
Content-Type: text/x-diff; charset="iso-8859-1";
	name="bluez-utils_input_phone_major.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bluez-utils_input_phone_major.diff"

Index: input/device.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/device.c,v
retrieving revision 1.43
diff -u -p -r1.43 device.c
--- input/device.c	18 Apr 2007 19:33:34 -0000	1.43
+++ input/device.c	4 May 2007 09:39:22 -0000
@@ -195,6 +195,9 @@ static const char *create_input_path(uin
 	static int next_id = 0;
 
 	switch (major) {
+	case 0x02: /* Phone */	
+		strcpy(subpath, "phone");	
+		break;
 	case 0x04: /* Audio */
 		switch (minor) {
 		/* FIXME: Testing required */
Index: input/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/manager.c,v
retrieving revision 1.22
diff -u -p -r1.22 manager.c
--- input/manager.c	18 Apr 2007 19:33:34 -0000	1.22
+++ input/manager.c	4 May 2007 09:39:22 -0000
@@ -800,6 +800,7 @@ static DBusHandlerResult create_device(D
 
 	switch (cls & 0x1f00) {
 		case 0x0500: /* Peripheral */
+		case 0x0200: /* Phone */
 			if (get_handles(pr, pnp_uuid, pnp_handle_reply) < 0) {
 				pending_req_free(pr);
 				return err_not_supported(conn, msg);

--Boundary-00=_m/vOGqwvlBuYuO2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_m/vOGqwvlBuYuO2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_m/vOGqwvlBuYuO2--
