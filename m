Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Fri, 8 Jun 2007 23:35:59 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AvcaG5rcgumBJZ+"
Message-Id: <200706082336.00557.dgollub@suse.de>
Cc: Stefan Seyfried <seife@suse.de>
Subject: [Bluez-devel] [PATCH] Input Service - Support for hidd configuration
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

--Boundary-00=_AvcaG5rcgumBJZ+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

attachted an input service patch which implements support for the hidd 
configuration. This is needed to have a smooth transition from hidd daemon to 
the new shiny input service ...

( ... and especially this is needed to be able to return from vacation back to 
the office - without getting blamed by Seife for not working bluetooth input 
devices ;P )

The patch reads the entries of hidd and stores it with store_device_info() 
function. The hidd doesn't get modified - this means the transition happens 
on every start of the input service. store_device_info() avoids duplicate 
entries. So there is still the possibility to have a working bluetooth input 
device when falling back to hidd.

best regards,
Daniel

--Boundary-00=_AvcaG5rcgumBJZ+
Content-Type: text/x-diff; charset="us-ascii";
	name="bluez-utils-input-service-hidd-config.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-utils-input-service-hidd-config.diff"

--- input/manager.c	9 May 2007 14:53:34 -0000	1.25
+++ input/manager.c	8 Jun 2007 21:16:25 -0000
@@ -959,6 +959,23 @@ static void stored_input(char *key, char
 	device_paths = g_slist_append(device_paths, g_strdup(path));
 }
 
+/* hidd to input transition function */
+static void stored_hidd(char *key, char *value, void *data)
+{
+	const char *path;
+	struct hidp_connadd_req hidp; 
+	bdaddr_t dst, *src = data;
+
+	str2ba(key, &dst);
+
+	memset(&hidp, 0, sizeof(struct hidp_connadd_req));
+
+	if (parse_stored_device_info(value, &hidp) < 0)
+		return;
+
+	store_device_info(src, &dst, &hidp);
+}
+
 static void register_stored_inputs(void)
 {
 	char dirname[PATH_MAX + 1];
@@ -977,10 +994,16 @@ static void register_stored_inputs(void)
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

--Boundary-00=_AvcaG5rcgumBJZ+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_AvcaG5rcgumBJZ+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_AvcaG5rcgumBJZ+--
