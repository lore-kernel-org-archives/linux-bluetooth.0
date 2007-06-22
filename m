Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 22 Jun 2007 17:41:29 +0200
References: <200706082336.00557.dgollub@suse.de>
In-Reply-To: <200706082336.00557.dgollub@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q2+eGoxlArWK3Qm"
Message-Id: <200706221741.30531.dgollub@suse.de>
Subject: Re: [Bluez-devel] [PATCH] Input Service - Support for hidd
	configuration
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

--Boundary-00=_q2+eGoxlArWK3Qm
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 08 June 2007, Daniel Gollub wrote:
> Hi,
>
> attachted an input service patch which implements support for the hidd
> configuration. This is needed to have a smooth transition from hidd daemon
> to the new shiny input service ...
>
> ( ... and especially this is needed to be able to return from vacation back
> to the office - without getting blamed by Seife for not working bluetooth
> input devices ;P )
>
> The patch reads the entries of hidd and stores it with store_device_info()
> function. The hidd doesn't get modified - this means the transition happens
> on every start of the input service. store_device_info() avoids duplicate
> entries. So there is still the possibility to have a working bluetooth
> input device when falling back to hidd.


Fixed some discussed issues of the hidd config patch:

- Only transfer entry from hidd config to input if there isn't already a entry 
of the device in input config
- Added parsing function for hidd config format (input format changed)

Patch attachted.

best regards,
Daniel

--Boundary-00=_q2+eGoxlArWK3Qm
Content-Type: text/x-diff; charset="iso-8859-15";
	name="bluez-utils-input-hidd-config-v02.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-utils-input-hidd-config-v02.diff"

Index: input/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/manager.c,v
retrieving revision 1.26
diff -u -p -r1.26 manager.c
--- input/manager.c	21 Jun 2007 22:06:33 -0000	1.26
+++ input/manager.c	22 Jun 2007 15:21:02 -0000
@@ -962,6 +962,25 @@ cleanup:
 		g_free(hidp.rd_data);
 }
 
+/* hidd to input transition function */
+static void stored_hidd(char *key, char *value, void *data)
+{
+	struct hidp_connadd_req hidp; 
+	bdaddr_t dst, *src = data;
+
+	str2ba(key, &dst);
+
+	if (input_device_stored(src, &dst) > 0)
+		return;
+
+	memset(&hidp, 0, sizeof(struct hidp_connadd_req));
+
+	if (parse_stored_hidd(value, &hidp) < 0)
+		return;
+
+	store_device_info(src, &dst, &hidp);
+}
+
 static void register_stored_inputs(void)
 {
 	char dirname[PATH_MAX + 1];
@@ -980,10 +999,16 @@ static void register_stored_inputs(void)
 		if (!isdigit(de->d_name[0]))
 			continue;
 
+		str2ba(de->d_name, &src);
+
+		/* move the hidd entries to the input storage */
 		create_name(filename, PATH_MAX, STORAGEDIR,
-						de->d_name, "input");
+						de->d_name, "hidd");
+		textfile_foreach(filename, stored_hidd, &src);
 
-		str2ba(de->d_name, &src);
+		/* load the input stored devices */
+		create_name(filename, PATH_MAX, STORAGEDIR,
+						de->d_name, "input");
 
 		textfile_foreach(filename, stored_input, &src);
 	}
Index: input/storage.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/storage.c,v
retrieving revision 1.10
diff -u -p -r1.10 storage.c
--- input/storage.c	19 Mar 2007 14:58:44 -0000	1.10
+++ input/storage.c	22 Jun 2007 15:21:02 -0000
@@ -59,6 +59,70 @@ static inline int create_filename(char *
 	return create_name(buf, size, STORAGEDIR, addr, name);
 }
 
+int input_device_stored(bdaddr_t *src, bdaddr_t *dst)
+{
+	char filename[PATH_MAX + 1], *str;
+	char peer[18];
+
+	create_filename(filename, PATH_MAX, src, "input");
+
+	ba2str(dst, peer);
+	str = textfile_get(filename, peer);
+	if (!str)
+		return -ENOENT;
+
+	free(str);
+
+	return 1;
+}
+
+int parse_stored_hidd(const char *str, struct hidp_connadd_req *req)
+{
+	char tmp[3];
+	char *desc;
+	unsigned int vendor, product, version, subclass, country, parser, pos;
+	size_t len;
+	int i;
+
+	desc = malloc(4096);
+	if (!desc)
+		return -ENOMEM;
+
+	memset(desc, 0, 4096);
+
+	sscanf(str, "%04X:%04X:%04X %02X %02X %04X %4095s %08X %n",
+			&vendor, &product, &version, &subclass, &country,
+			&parser, desc, &req->flags, &pos);
+
+	len = strlen(desc);
+	if (len <= 0)
+		return -ENOENT;
+
+
+	req->vendor   = vendor;
+	req->product  = product;
+	req->version  = version;
+	req->subclass = subclass;
+	req->country  = country;
+	req->parser   = parser;
+
+	req->rd_size = len / 2;
+	req->rd_data = g_try_malloc0(req->rd_size);
+	if (!req->rd_data) {
+		return -ENOMEM;
+	}
+
+	memset(tmp, 0, sizeof(tmp));
+	for (i = 0; i < req->rd_size; i++) {
+		memcpy(tmp, desc + (i * 2), 2);
+		req->rd_data[i] = (uint8_t) strtol(tmp, NULL, 16);
+	}
+
+	g_free(desc);
+
+	return 0;
+}
+
 int parse_stored_device_info(const char *str, struct hidp_connadd_req *req)
 {
 	char tmp[3];
Index: input/storage.h
===================================================================
RCS file: /cvsroot/bluez/utils/input/storage.h,v
retrieving revision 1.6
diff -u -p -r1.6 storage.h
--- input/storage.h	19 Mar 2007 14:58:44 -0000	1.6
+++ input/storage.h	22 Jun 2007 15:21:02 -0000
@@ -21,6 +21,8 @@
  *
  */
 
+int input_device_stored(bdaddr_t *src, bdaddr_t *dst);
+
 int get_stored_device_info(bdaddr_t *src, bdaddr_t *dst,
 				struct hidp_connadd_req *req);
 
@@ -29,6 +31,7 @@ int del_stored_device_info(bdaddr_t *src
 int store_device_info(bdaddr_t *src, bdaddr_t *dst,
 				struct hidp_connadd_req *req);
 
+int parse_stored_hidd(const char *str, struct hidp_connadd_req *req);
 int parse_stored_device_info(const char *str,
 				struct hidp_connadd_req *req);
 

--Boundary-00=_q2+eGoxlArWK3Qm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_q2+eGoxlArWK3Qm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_q2+eGoxlArWK3Qm--
