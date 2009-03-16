Return-Path: <cyrus@holtmann.org>
Message-ID: <49BDADA8.4030909@trolltech.com>
Date: Mon, 16 Mar 2009 11:38:48 +1000
From: Bea Lam <bea.lam@trolltech.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add "Class" property to org.bluez.Adapter
References: <49ADD4C8.8040705@trolltech.com> <1236200642.6670.13.camel@localhost.localdomain> <49AF1BB6.7070104@trolltech.com> <20090312150947.GA10037@jh-x301>
In-Reply-To: <20090312150947.GA10037@jh-x301>
Content-Type: multipart/mixed;
 boundary="------------060909020109080707070009"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060909020109080707070009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Johan,

> I can apply the patch but could you first create a proper version of it
> with git format-patch so that I don't have to start manipulating
> GIT_AUTHOR_NAME etc. myself. (I realize this isn't much work for myself
> either but it'd be good to get everyone submitting patches into this
> habit since otherwise the workload on our (me & Marcel) side starts
> accumulating pretty quickly.) Thanks.
Here's the formatted patch, without the unnecessary
update_ext_inquiry_response() call.

Thanks,

Bea
 

--------------060909020109080707070009
Content-Type: text/x-patch;
 name="0001-Add-Class-property-to-org.bluez.Adapter-interface.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Add-Class-property-to-org.bluez.Adapter-interface.patch"

>From 6d1e1d52effae8ac1e2d9210267b6e85b86a7dbd Mon Sep 17 00:00:00 2001
From: Bea Lam <bea.lam@nokia.com>
Date: Mon, 16 Mar 2009 11:32:06 +1000
Subject: [PATCH] Add "Class" property to org.bluez.Adapter interface.

---
 doc/adapter-api.txt |    4 ++++
 src/adapter.c       |   13 +++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index eb973ec..1e03b4e 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -210,6 +210,10 @@ Properties	string Address [readonly]
 			The Bluetooth friendly name. This value can be
 			changed and a PropertyChanged signal will be emitted.
 
+		uint32 Class [readonly]
+
+			The Bluetooth class of device.
+
 		boolean Powered [readwrite]
 
 			Switch an adapter on or off. This will also set the
diff --git a/src/adapter.c b/src/adapter.c
index 52b58c4..821fd2b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1192,6 +1192,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	char str[249], srcaddr[18];
+	uint32_t class;
 	gboolean value;
 	char **devices;
 	int i;
@@ -1224,6 +1225,12 @@ static DBusMessage *get_properties(DBusConnection *conn,
 
 	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &property);
 
+	/* Class */
+	class = adapter->dev.class[0] |
+			adapter->dev.class[1] << 8 |
+			adapter->dev.class[2] << 16;
+	dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
+
 	/* Powered */
 	value = adapter->up ? TRUE : FALSE;
 	dict_append_entry(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
@@ -2326,6 +2333,7 @@ int adapter_get_class(struct btd_adapter *adapter, uint8_t *cls)
 int adapter_set_class(struct btd_adapter *adapter, uint8_t *cls)
 {
 	struct hci_dev *dev = &adapter->dev;
+	uint32_t class;
 
 	if (memcmp(dev->class, cls, 3) == 0)
 		return 0;
@@ -2334,6 +2342,11 @@ int adapter_set_class(struct btd_adapter *adapter, uint8_t *cls)
 
 	write_local_class(&adapter->bdaddr, cls);
 
+	class = cls[0] | (cls[1] << 8) | (cls[2] << 16);
+
+	emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
+				"Class", DBUS_TYPE_UINT32, &class);
+
 	return 0;
 }
 
-- 
1.6.1


--------------060909020109080707070009--
