Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
Cc: Daryl Van Vorst <daryl@wideray.com>
In-Reply-To: <1106244883.13562.3.camel@pegasus>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092208405.4564.227.camel@pegasus>
	 <1106231454.26551.582.camel@hades.cambridge.redhat.com>
	 <1106232343.8190.187.camel@pegasus>
	 <1106233175.26551.597.camel@hades.cambridge.redhat.com>
	 <1106244883.13562.3.camel@pegasus>
Content-Type: text/plain
Message-Id: <1106295971.783.57.camel@baythorne.infradead.org>
Mime-Version: 1.0
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
Date: Fri, 21 Jan 2005 08:26:11 +0000

On Thu, 2005-01-20 at 19:14 +0100, Marcel Holtmann wrote:
> Your patch is now in (after I reworked the tab vs. space problem). And
> everyone should start testing these on various platforms.

OK. Do you want to apply this one too so we can release bluez-libs-2.15
without changing the soname?

--- bluez-libs-2.14/src/hci.c.compat	2005-01-20 12:21:11.000000000 +0000
+++ bluez-libs-2.14/src/hci.c	2005-01-20 12:21:17.000000000 +0000
@@ -850,6 +850,11 @@ int hci_disconnect(int dd, uint16_t hand
 	return 0;
 }
 
+int hci_local_name(int dd, int len, char *name, int to)
+{
+	return hci_read_local_name(dd, len, name, to);
+}
+
 int hci_read_local_name(int dd, int len, char *name, int to)
 {
 	read_local_name_rp rp;
@@ -891,6 +896,11 @@ int hci_write_local_name(int dd, const c
 	return 0;
 }
 
+int hci_remote_name(int dd, const bdaddr_t *bdaddr, int len, char *name, int to)
+{
+	return hci_read_remote_name(dd, bdaddr, len, name, to);
+}
+
 int hci_read_remote_name(int dd, const bdaddr_t *bdaddr, int len, char *name, int to)
 {
 	evt_remote_name_req_complete rn;
--- bluez-libs-2.14/include/hci_lib.h.compat	2005-01-20 12:21:11.000000000 +0000
+++ bluez-libs-2.14/include/hci_lib.h	2005-01-20 12:21:17.000000000 +0000
@@ -66,8 +66,11 @@ int hci_devinfo(int dev_id, struct hci_d
 int hci_devba(int dev_id, bdaddr_t *bdaddr);
 int hci_devid(const char *str);
 
+/* deprecated: preserve compatibility */
+int hci_local_name(int dd, int len, char *name, int to);
 int hci_read_local_name(int dd, int len, char *name, int to);
 int hci_write_local_name(int dd, const char *name, int to);
+int hci_remote_name(int dd, const bdaddr_t *bdaddr, int len, char *name, int to);
 int hci_read_remote_name(int dd, const bdaddr_t *bdaddr, int len, char *name, int to);
 int hci_read_remote_features(int dd, uint16_t handle, uint8_t *features, int to);
 int hci_read_remote_version(int dd, uint16_t handle, struct hci_version *ver, int to);

-- 
dwmw2




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
