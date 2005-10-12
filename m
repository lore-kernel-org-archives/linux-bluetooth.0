Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid patch (remote name and connections)
Message-ID: <20051012193811.GA5505@localhost.localdomain>
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com> <1129053693.8229.1.camel@localhost.localdomain> <20051011192801.GA12571@localhost.localdomain> <434C164E.5090805@csr.com> <20051011195531.GA12935@localhost.localdomain> <1129070919.6487.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <1129070919.6487.4.camel@localhost.localdomain>
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
Date: Wed, 12 Oct 2005 22:38:11 +0300


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I missed one place in the code where hci_dbus_data should be allocated
(thanks to Claudio for noticing). Here's a patch to fix it.

Johan

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="segfault.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.21
diff -u -r1.21 dbus.c
--- hcid/dbus.c	11 Oct 2005 22:45:38 -0000	1.21
+++ hcid/dbus.c	12 Oct 2005 19:13:14 -0000
@@ -774,7 +774,13 @@
 
 		syslog(LOG_INFO, "registering dft path:%s - id:%d", path, DEFAULT_DEVICE_PATH_ID);
 
-		if (!dbus_connection_register_object_path(conn, path, &obj_vtable, (void *) DEFAULT_DEVICE_PATH_ID)) { 
+		data = malloc(sizeof(struct hci_dbus_data));
+		if (data == NULL)
+			return -1;
+
+		data->id = DEFAULT_DEVICE_PATH_ID;
+
+		if (!dbus_connection_register_object_path(conn, path, &obj_vtable, data)) { 
 			syslog(LOG_ERR,"DBUS failed to register %s object", path);
 			/* ignore, the default path was already registered */
 		}

--TB36FDmn/VVEgNH/--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
