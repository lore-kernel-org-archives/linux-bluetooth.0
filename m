Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sEt+DaC2BnwJq2D"
Message-Id: <200602211837.00121.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] Possible Patch: list paired devices
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
Date: Tue, 21 Feb 2006 18:36:59 +1000

--Boundary-00=_sEt+DaC2BnwJq2D
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

I noticed that there is no way to list paired devices from hcitool/hciconfig, 
at least I couldn't find a way to do so.   Here is a proposed patch to 
hcitool which will show a list of paired devices.  

I'm not sure if this is the right solution, since it requires hcitool to be 
run with effective permissions to access the linkkeys file (e.g. root on my 
system).  If there is a better way let me know.

Also, will the patch for 128 bit UUID searching in sdptool get merged into 
CVS, or did I mess something up again?

Regards,
-Denis

--Boundary-00=_sEt+DaC2BnwJq2D
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bluez-hcitool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-hcitool.patch"

Index: tools/hcitool.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hcitool.c,v
retrieving revision 1.85
diff -u -r1.85 hcitool.c
--- tools/hcitool.c	18 Jan 2006 17:45:51 -0000	1.85
+++ tools/hcitool.c	21 Feb 2006 08:25:45 -0000
@@ -1865,6 +1865,70 @@
 	free(cr);
 }
 
+static int dev_paired(int dd, int dev_id, long arg)
+{
+	void print_key(char *key, char *value, void *data)
+	{
+		printf("%s\n", key);
+	}
+
+	struct hci_dev_info di = { dev_id: dev_id };
+	char filename[PATH_MAX + 1];
+	char addr[18];
+	
+	if (ioctl(dd, HCIGETDEVINFO, (void *) &di))
+		return 0;
+
+	ba2str(&di.bdaddr, addr);
+
+	snprintf(filename, PATH_MAX, "%s/%s/linkkeys", STORAGEDIR, addr);
+
+	printf("Devices paired to %s:\n", addr);
+	textfile_foreach(filename, print_key, NULL);
+	printf("\n");
+
+	return 0;
+}
+
+/* List pairings */
+
+static struct option paired_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static char *paired_help =
+	"Usage:\n"
+	"\tpaired\n";
+
+static void cmd_paired(int dev_id, int argc, char **argv)
+{
+	int dd, opt;
+
+	for_each_opt(opt, cc_options, NULL) {
+		switch (opt) {
+		default:
+			printf(paired_help);
+			return;
+		}
+	}
+
+	if (dev_id < 0) {
+		hci_for_each_dev(HCI_UP, dev_paired, 0);
+		return;
+	}
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		perror("HCI device open failed");
+		exit(1);
+	}
+
+	dev_paired(dd, dev_id, 0);
+
+	hci_close_dev(dd);
+}
+
 /* Read clock offset */
 
 static struct option clkoff_options[] = {
@@ -2051,6 +2115,7 @@
 	{ "auth",   cmd_auth,   "Request authentication"               },
 	{ "enc",    cmd_enc,    "Set connection encryption"            },
 	{ "key",    cmd_key,    "Change connection link key"           },
+	{ "paired", cmd_paired, "Show paired devices"                  },
 	{ "clkoff", cmd_clkoff, "Read clock offset"                    },
 	{ "clock",  cmd_clock,  "Read local or remote clock"           },
 	{ NULL, NULL, 0 }

--Boundary-00=_sEt+DaC2BnwJq2D--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
