Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80512010855v46eeb99dk3a53094238800621@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
In-Reply-To: <1132949177.10237.5.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_21680_2009206.1133456113799"
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <1132805822.5982.15.camel@blade>
	 <3013cac80511241050o2f3d67aele639b2c69de41360@mail.gmail.com>
	 <1132872886.3170.3.camel@blade>
	 <e1effdeb0511250547o16e60b21y5c3a81a5639102cc@mail.gmail.com>
	 <1132942092.5577.21.camel@blade>
	 <3013cac80511251034s23d549cbs8a951d64562627b1@mail.gmail.com>
	 <1132944074.5577.28.camel@blade>
	 <e1effdeb0511251152k3bafca4n21125fd1c9f9179@mail.gmail.com>
	 <1132949177.10237.5.camel@blade>
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
Date: Thu, 1 Dec 2005 13:55:13 -0300

------=_Part_21680_2009206.1133456113799
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

here is a patch for scan SetProperty of /org/bluez/Device/hciX and to
correct some function names.
Johan said on an early email that would be nice to have each changed
property to send a "PropertyChanged" signal with "Property name" and
"property specific info" params. But for "discoverable" and
"connectable" properties, how can we know what changed as both of them
trigger a command_complete event with HCI_write_scan_enable OCF?  Or
should we trigger a unique signal for pscan and iscan, sending the new
scan status?

BR,
Eduardo.


On 11/25/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > I think we are confusing some D-Bus concepts.
> >
> > Currently, hcid is connected to the "system" bus, because the
> > Bluetooth adapter is a shared resource and it can be used by any
> > logged-in user or remote users. As long as I known the "system bus"
> > should be used for notification from the system to user sessions(it's
> > accessible to all applications on the system). The "session bus"
> > should be used to implement desktop environments communication. The
> > address of the per-session bus daemon is automatically discovered by
> > reading an environment variable. A login session message bus is
> > started each time a user logs in.
>
> this is my understanding, too.
>
> > If we choose use the session bus, probably it will required huge code
> > modification in order to support multiple bus session connection or
> > start a new BlueZ D-Bus daemon for each user session. In my opinion,
> > this approach is not feasible.
>
> This will simply not work, because there can be only one daemon at a
> time and it must run all the time.
>
> > If you want provide BlueZ D-Bus services only for the logged-in user,
> > we can try analise the modifications required to control the D-Bus
> > connections and its drawbacks.
>
> The D-Bus services are available in general, but I wanna restrict the
> methods that are actually modifying settings to the root user and/or the
> currently logged in user. The hal.conf uses "<policy at_console=3D"true">=
"
> to provide this (if I am not mistaken).
>
> Remember that we are talking about the default configuration. We don't
> need to provide the best security model, but at least a decent one. For
> me this means that the root user and the currently logged in user have
> full control over the device. All other users are restricted.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_21680_2009206.1133456113799
Content-Type: text/x-patch; name=dbus_device_scan.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_device_scan.patch"

--- utils.01122005.orig/hcid/dbus.h	2005-11-24 01:10:46.000000000 -0300
+++ utils.01122005/hcid/dbus.h	2005-12-01 13:14:01.000000000 -0300
@@ -227,6 +227,7 @@
 #define BLUEZ_EDBUS_NO_MEM   		(0x05 + BLUEZ_EDBUS_OFFSET)
 #define BLUEZ_EDBUS_CONN_NOT_FOUND	(0x06 + BLUEZ_EDBUS_OFFSET)
 #define BLUEZ_EDBUS_UNKNOWN_PATH	(0x07 + BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_NOT_IMPLEMENTED	(0x08 + BLUEZ_EDBUS_OFFSET)
 
 /* D-Bus error code, class BLUEZ_ESYSTEM_OFFSET */
 #define BLUEZ_ESYSTEM_ENODEV		(ENODEV + BLUEZ_ESYSTEM_OFFSET)
--- utils.01122005.orig/hcid/dbus.c	2005-11-24 01:10:46.000000000 -0300
+++ utils.01122005/hcid/dbus.c	2005-12-01 13:22:23.000000000 -0300
@@ -132,6 +132,7 @@
 	{ BLUEZ_EDBUS_NO_MEM,		"No memory"			},
 	{ BLUEZ_EDBUS_CONN_NOT_FOUND,	"Connection not found"		},
 	{ BLUEZ_EDBUS_UNKNOWN_PATH,	"Unknown D-BUS path"		},
+	{ BLUEZ_EDBUS_NOT_IMPLEMENTED,	"Method not implemented"	},
 	{ 0, NULL }
 };
 
@@ -270,34 +271,36 @@
  */
 static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_set_propety_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_get_propety_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_set_propety_req_name(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_get_propety_req_name(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_property_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_get_property_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_property_req_name(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_get_property_req_name(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_property_req_pscan(DBusMessage *msg, void *data);
+static DBusMessage* handle_device_set_property_req_iscan(DBusMessage *msg, void *data);
 
 static const struct service_data device_services[] = {
 	{ DEV_UP,		handle_device_up_req,		DEV_UP_SIGNATURE		},
 	{ DEV_DOWN,		handle_device_down_req,		DEV_DOWN_SIGNATURE		},
-	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_BOOL	},
-	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_STR	},
-	{ DEV_SET_PROPERTY,	handle_device_set_propety_req,	DEV_SET_PROPERTY_SIGNATURE_BYTE	},
-	{ DEV_GET_PROPERTY,	handle_device_get_propety_req,	DEV_GET_PROPERTY_SIGNATURE	},
+	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_BOOL	},
+	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_STR	},
+	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_BYTE	},
+	{ DEV_GET_PROPERTY,	handle_device_get_property_req,	DEV_GET_PROPERTY_SIGNATURE	},
 	{ NULL, NULL, NULL}
 };
 
 static const struct service_data set_property_services[] = {
 	{ DEV_PROPERTY_AUTH,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
 	{ DEV_PROPERTY_ENCRYPT,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_PSCAN,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_ISCAN,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_NAME,		handle_device_set_propety_req_name,	DEV_SET_PROPERTY_SIGNATURE_STR		},
+	{ DEV_PROPERTY_PSCAN,		handle_device_set_property_req_pscan,	DEV_SET_PROPERTY_SIGNATURE_BOOL		},
+	{ DEV_PROPERTY_ISCAN,		handle_device_set_property_req_iscan,	DEV_SET_PROPERTY_SIGNATURE_BOOL		},
+	{ DEV_PROPERTY_NAME,		handle_device_set_property_req_name,	DEV_SET_PROPERTY_SIGNATURE_STR		},
 	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BYTE		},
 	{ NULL, NULL, NULL}
 };
 
 static const struct service_data get_property_services[] = {
 	{ DEV_PROPERTY_DEV_INFO,	handle_not_implemented_req,		DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_NAME,		handle_device_get_propety_req_name,	DEV_GET_PROPERTY_SIGNATURE 	},
+	{ DEV_PROPERTY_NAME,		handle_device_get_property_req_name,	DEV_GET_PROPERTY_SIGNATURE 	},
 	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_GET_PROPERTY_SIGNATURE 	},
 	{ NULL, NULL, NULL}
 };
@@ -1934,7 +1937,7 @@
 	return reply;
 }
 
-static DBusMessage* handle_device_set_propety_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_device_set_property_req(DBusMessage *msg, void *data)
 {
 	const struct service_data *handlers = set_property_services;
 	DBusMessageIter iter;
@@ -1968,7 +1971,7 @@
 	return reply;
 }
 
-static DBusMessage* handle_device_get_propety_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_device_get_property_req(DBusMessage *msg, void *data)
 {
 	const struct service_data *handlers = get_property_services;
 	DBusMessageIter iter;
@@ -1994,7 +1997,7 @@
 	return reply;
 }
 
-static DBusMessage* handle_device_set_propety_req_name(DBusMessage *msg, void *data)
+static DBusMessage* handle_device_set_property_req_name(DBusMessage *msg, void *data)
 {
 	struct hci_dbus_data *dbus_data = data;
 	DBusMessageIter iter;
@@ -2127,7 +2130,7 @@
 	bt_free(local_addr);
 }
 
-static DBusMessage* handle_device_get_propety_req_name(DBusMessage *msg, void *data)
+static DBusMessage* handle_device_get_property_req_name(DBusMessage *msg, void *data)
 {
 	struct hci_dbus_data *dbus_data = data;
 	DBusMessage *reply = NULL;
@@ -2183,6 +2186,107 @@
 	return reply;
 }
 
+static DBusMessage* write_scan_enable(DBusMessage *msg, void *data, gboolean ispscan)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	int dd = -1;
+	read_scan_enable_rp rp;
+	uint8_t enable;
+	uint8_t status;
+	struct hci_request rq;
+	gboolean scan;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, &scan);
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_READ_SCAN_ENABLE;
+	rq.rparam = &rp;
+	rq.rlen   = READ_SCAN_ENABLE_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending read scan enable command failed: %s (%d)",
+							strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if (rp.status) {
+		syslog(LOG_ERR, "Getting scan enable failed with status 0x%02x",
+								 	rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + rp.status);
+		goto failed;
+        }
+
+	if (ispscan) {
+		if (scan && !(rp.enable & SCAN_PAGE))
+			enable = (rp.enable & SCAN_INQUIRY) | SCAN_PAGE;
+		else if (!scan && (rp.enable & SCAN_PAGE))
+			enable = (rp.enable & SCAN_INQUIRY);
+		else {
+			reply = dbus_message_new_method_return(msg);
+			goto failed;
+		}
+	} else {
+		if (scan && !(rp.enable & SCAN_INQUIRY))
+			enable = (rp.enable & SCAN_PAGE) | SCAN_INQUIRY;
+		else if (!scan && (rp.enable & SCAN_INQUIRY))
+			enable = (rp.enable & SCAN_PAGE);
+		else {
+			reply = dbus_message_new_method_return(msg);
+			goto failed;
+		}
+	}
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_WRITE_SCAN_ENABLE;
+	rq.cparam = &enable;
+	rq.clen   = sizeof(enable);
+	rq.rparam = &status;
+	rq.rlen   = sizeof(status);
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending write scan enable command failed: %s (%d)",
+							strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+	if (status) {
+		syslog(LOG_ERR, "Setting scan enable failed with status 0x%02x", rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + rp.status);
+		goto failed;
+	}
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+	return reply;
+
+}
+
+static DBusMessage* handle_device_set_property_req_pscan(DBusMessage *msg, void *data)
+{
+	return write_scan_enable(msg, data, TRUE);
+}
+
+static DBusMessage* handle_device_set_property_req_iscan(DBusMessage *msg, void *data)
+{
+	return write_scan_enable(msg, data, FALSE);
+}
+
 static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;
@@ -2328,5 +2432,5 @@
 	syslog(LOG_INFO, "Not Implemented - path %s iface %s method %s",
 							path, iface, method);
 
-	return NULL;
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
 }

------=_Part_21680_2009206.1133456113799--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
