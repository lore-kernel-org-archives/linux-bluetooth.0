Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602101053p1f3c6377n9f89a47a9e0ec574@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
In-Reply-To: <1139596810.26234.73.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12918_24845645.1139597600823"
References: <e1effdeb0602101029v4f1b6e9dw8a0a75a4daf6ba55@mail.gmail.com>
	 <1139596810.26234.73.camel@localhost>
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
Date: Fri, 10 Feb 2006 16:53:20 -0200

------=_Part_12918_24845645.1139597600823
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Sorry, I found a small bug :)
I forgot remove a unused function.

Maybe we should put the error functions in a separated file too.

Regards,
Claudio.


On 2/10/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Here is the first patch based on your last BlueZ D-Bus API document.
> >
> > Let me know if you have some question/suggestion about
> > function/variable names, code standard, ...
>
> wow. These are a lot of changes in one patch. I would personally prefer
> to only get the Manager interface right at the moment and do the Device
> interface stuff after that. However it might make sense to do a clean
> cut and apply this patch and then start from there.
>
> Johan, what do you think?
>
> Should we split the Manager interface and the Device interface into two
> separate files?
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
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_12918_24845645.1139597600823
Content-Type: text/x-patch; name=dbus_redesign02.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejioekgl
Content-Disposition: attachment; filename="dbus_redesign02.patch"

--- bluez-utils-cvs.orig/hcid/main.c	2006-02-07 23:21:16.000000000 -0200
+++ bluez-utils-cvs-dbus/hcid/main.c	2006-02-10 09:33:11.000000000 -0200
@@ -402,9 +402,6 @@
 
 #ifdef ENABLE_DBUS
 		hcid_dbus_register_device(dr->dev_id);
-
-		if (hci_test_bit(HCI_UP, &dr->dev_opt))
-			hcid_dbus_dev_up(dr->dev_id);
 #endif
 	}
 
@@ -475,18 +472,12 @@
 			configure_device(sd->dev_id);
 		if (hcid.security)
 			start_security_manager(sd->dev_id);
-#ifdef ENABLE_DBUS
-		hcid_dbus_dev_up(sd->dev_id);
-#endif
 		break;
 
 	case HCI_DEV_DOWN:
 		syslog(LOG_INFO, "HCI dev %d down", sd->dev_id);
 		if (hcid.security)
 			stop_security_manager(sd->dev_id);
-#ifdef ENABLE_DBUS
-		hcid_dbus_dev_down(sd->dev_id);
-#endif
 		break;
 	}
 }
--- bluez-utils-cvs.orig/hcid/hcid.h	2006-02-08 08:59:19.000000000 -0200
+++ bluez-utils-cvs-dbus/hcid/hcid.h	2006-02-10 09:39:39.000000000 -0200
@@ -124,14 +124,14 @@
 gboolean hcid_dbus_dev_down(uint16_t id);
 void hcid_dbus_request_pin(int dev, struct hci_conn_info *ci);
 
-void hcid_dbus_inquiry_start(bdaddr_t *local);
-void hcid_dbus_inquiry_complete(bdaddr_t *local);
-void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi);
+void hcid_dbus_discover_start(bdaddr_t *local);
+void hcid_dbus_discover_complete(bdaddr_t *local);
+void hcid_dbus_discover_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi);
 void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name);
 void hcid_dbus_remote_name_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
 void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer);
 void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason);
-void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status);
+void hcid_dbus_bonding_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status);
 void hcid_dbus_setname_complete(bdaddr_t *local);
 void hcid_dbus_setscan_enable_complete(bdaddr_t *local);
 #else
@@ -142,7 +142,7 @@
 static inline void hcid_dbus_remote_name_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status) {}
 static inline void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer) {}
 static inline void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason) {}
-static inline void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status) {}
+static inline void hcid_dbus_bonding_created_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status) {}
 static inline void hcid_dbus_setname_complete(bdaddr_t *local) {}
 static inline void hcid_dbus_setscan_enable_complete(bdaddr_t *local) {}
 #endif
--- bluez-utils-cvs.orig/hcid/security.c	2006-02-08 08:59:19.000000000 -0200
+++ bluez-utils-cvs-dbus/hcid/security.c	2006-02-10 09:40:01.000000000 -0200
@@ -389,7 +389,7 @@
 		return;
 
 	if (evt->opcode == cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY))
-		hcid_dbus_inquiry_start(sba);
+		hcid_dbus_discover_start(sba);
 }
 
 static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
@@ -397,7 +397,7 @@
 	evt_cmd_complete *evt = ptr;
 	switch (evt->opcode) {
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY_CANCEL):
-		hcid_dbus_inquiry_complete(sba);
+		hcid_dbus_discover_complete(sba);
 		break;
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME):
 		hcid_dbus_setname_complete(sba);
@@ -442,7 +442,7 @@
 
 static inline void inquiry_complete(int dev, bdaddr_t *sba, void *ptr)
 {
-	hcid_dbus_inquiry_complete(sba);
+	hcid_dbus_discover_complete(sba);
 }
 
 static inline void inquiry_result(int dev, bdaddr_t *sba, int plen, void *ptr)
@@ -456,7 +456,7 @@
 			| (info->dev_class[1] << 8)
 			| (info->dev_class[2] << 16);
 
-		hcid_dbus_inquiry_result(sba, &info->bdaddr, class, 0);
+		hcid_dbus_discover_result(sba, &info->bdaddr, class, 0);
 
 		update_lastseen(sba, &info->bdaddr);
 
@@ -479,7 +479,7 @@
 				| (info->dev_class[1] << 8)
 				| (info->dev_class[2] << 16);
 
-			hcid_dbus_inquiry_result(sba, &info->bdaddr,
+			hcid_dbus_discover_result(sba, &info->bdaddr,
 							class, info->rssi);
 
 			update_lastseen(sba, &info->bdaddr);
@@ -493,7 +493,7 @@
 				| (info->dev_class[1] << 8)
 				| (info->dev_class[2] << 16);
 
-			hcid_dbus_inquiry_result(sba, &info->bdaddr,
+			hcid_dbus_discover_result(sba, &info->bdaddr,
 							class, info->rssi);
 
 			update_lastseen(sba, &info->bdaddr);
@@ -514,7 +514,7 @@
 			| (info->dev_class[1] << 8)
 			| (info->dev_class[2] << 16);
 
-		hcid_dbus_inquiry_result(sba, &info->bdaddr, class, info->rssi);
+		hcid_dbus_discover_result(sba, &info->bdaddr, class, info->rssi);
 
 		update_lastseen(sba, &info->bdaddr);
 
@@ -583,7 +583,7 @@
 	if (get_bdaddr(dev, sba, evt->handle, &dba) < 0) 
 		return;
 
-	hcid_dbus_auth_complete(sba, &dba, evt->status);
+	hcid_dbus_bonding_created_complete(sba, &dba, evt->status);
 }
 
 
--- bluez-utils-cvs.orig/hcid/dbus.h	2006-02-07 08:31:26.000000000 -0200
+++ bluez-utils-cvs-dbus/hcid/dbus.h	2006-02-10 13:09:54.000000000 -0200
@@ -21,6 +21,9 @@
  *
  */
 
+#ifndef __H_BLUEZ_DBUS_H__
+#define __H_BLUEZ_DBUS_H__
+
 #define __END_SIG__ DBUS_TYPE_INVALID_AS_STRING
 
 #define BASE_PATH		"/org/bluez"
@@ -46,9 +49,6 @@
 /* E.g. /org/bluez/Device/hci0 */
 #define DEVICE_PATH_ID		(DEVICE_PATH_MASK | 0x0001)
 
-/* E.g. /org/bluez/Device/hci0/Controller */
-#define HCI_PATH_ID		(DEVICE_PATH_MASK | 0x0002)
-
 #define INVALID_PATH_ID		0xFFFF
 #define INVALID_DEV_ID		0xFFFF
 
@@ -58,22 +58,19 @@
 
 #define MGR_DEVICE_LIST		"DeviceList"
 #define MGR_DEFAULT_DEVICE	"DefaultDevice"
-#define MGR_INIT		"Init"
 
-/* Enable/Disable services controller, pan, serial, ... */
-#define MGR_ENABLE		"Enable"
-#define MGR_DISABLE		"Disable"
+/* Signals sent in the Manager path */
+#define BLUEZ_MGR_DEV_ADDED		"DeviceAdded"
+#define BLUEZ_MGR_DEV_REMOVED		"DeviceRemoved"
 
-/* Signatures */
+/* Manager Signatures */
+#define MGR_DEVICE_LIST_SIGNATURE		__END_SIG__
+#define MGR_DEFAULT_DEVICE_SIGNATURE		__END_SIG__
 
-#define MGR_GET_DEV_SIGNATURE			__END_SIG__
 
+/*FIXME: should it be moved to a internal header file? */
 /* DeviceList Reply: a(devname, addr, type, up/down, a(flags)) - all types strings */
-#define MGR_GET_DEV_REPLY_SIGNATURE		DBUS_TYPE_ARRAY_AS_STRING \
-						DEV_GET_DEV_REPLY_STRUCT_SIGNATURE \
-						__END_SIG__
-
-#define MGR_GET_DEV_REPLY_STRUCT_SIGNATURE	DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
+#define MGR_REPLY_DEVICE_LIST_STRUCT_SIGNATURE	DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
 						DBUS_TYPE_STRING_AS_STRING \
 						DBUS_TYPE_STRING_AS_STRING \
 						DBUS_TYPE_STRING_AS_STRING \
@@ -83,145 +80,128 @@
 						DBUS_STRUCT_END_CHAR_AS_STRING \
 						__END_SIG__
 
-#define MGR_DEFAULT_DEV_SIGNATURE		__END_SIG__
-
+#define MGR_REPLY_DEVICE_LIST_SIGNATURE		DBUS_TYPE_ARRAY_AS_STRING \
+						MGR_REPLY_DEVICE_LIST_STRUCT_SIGNATURE \
+						__END_SIG__
 
-/* Signals sent in the Manager path */
-#define BLUEZ_MGR_DEV_ADDED		"DeviceAdded"
-#define BLUEZ_MGR_DEV_REMOVED		"DeviceRemoved"
 
 
 /*======================================================================== 
     BlueZ D-Bus Device path definitions "/org/bluez/Device"
  *========================================================================*/
-
-/* Interfaces implemented in the "/org/bluez/Device" path */
-#define BLUEZ_HCI			"Controller"
-#define DEV_HCI_INTERFACE		DEVICE_INTERFACE "." BLUEZ_HCI
-
-/* /org/bluez/Device signals */
-#define BLUEZ_HCI_PROPERTY_CHANGED	"PropertyChanged"
-#define BLUEZ_HCI_SCAN_MODE_CHANGED	"ModeChanged"
-
-/* Control interface signals */
-#define BLUEZ_HCI_INQ_START		"InquiryStart"
-#define BLUEZ_HCI_INQ_COMPLETE		"InquiryComplete"
-#define BLUEZ_HCI_INQ_RESULT		"InquiryResult"
-#define BLUEZ_HCI_REMOTE_NAME		"RemoteName"
-#define BLUEZ_HCI_REMOTE_NAME_FAILED	"RemoteNameFailed"
-#define BLUEZ_HCI_AUTH_COMPLETE		"AuthenticationComplete"
-
-/* Control interface methods */
-#define HCI_PERIODIC_INQ		"PeriodicInquiry"
-#define HCI_CANCEL_PERIODIC_INQ		"CancelPeriodic"
-#define HCI_INQ				"Inquiry"
-#define HCI_CANCEL_INQ			"CancelInquiry"
-#define HCI_ROLE_SWITCH			"RoleSwitch"
-#define HCI_REMOTE_NAME			"RemoteName"
-#define HCI_CONNECTIONS			"Connections"
-#define HCI_AUTHENTICATE		"Authenticate"
-
-/* Control interface methods */
-#define DEV_UP				"Up"
-#define DEV_DOWN			"Down"
-#define DEV_SET_PROPERTY		"SetProperty"
-#define DEV_GET_PROPERTY		"GetProperty"
-#define DEV_SET_MODE			"SetMode"
+#define DEV_GET_ADDRESS			"GetAddress"
+#define DEV_GET_ALIAS			"GetAlias"
+#define DEV_GET_COMPANY			"GetCompany"
+#define DEV_GET_DISCOVERABLE_TO		"GetDiscoverableTimeOut"
+#define DEV_GET_FEATURES		"GetFeatures"
+#define DEV_GET_MANUFACTURER		"GetManufacturer"
 #define DEV_GET_MODE			"GetMode"
-
-/*
- * Scanning modes
- * off: remote devices are not allowed to find or connect to this device
- * connectable: remote devices are allowed to connect, but they are not
- *              allowed to find it.
- * discoverable: remote devices are allowed to connect and find this device
- */
-#define MODE_OFF			0x00
-#define MODE_CONNECTABLE		0x01
-#define MODE_DISCOVERABLE		0x02
-
-
-#define DEV_PROPERTY_AUTH		"auth"
-#define DEV_PROPERTY_ENCRYPT		"encrypt"
-#define DEV_PROPERTY_PSCAN		"connectable"
-#define DEV_PROPERTY_ISCAN		"discoverable"
-#define DEV_PROPERTY_NAME		"name"
-#define DEV_PROPERTY_INCMODE		"incmode"
-#define DEV_PROPERTY_DEV_INFO		"info"
-
-#define DEV_UP_SIGNATURE			__END_SIG__
-#define DEV_DOWN_SIGNATURE			__END_SIG__
-#define DEV_SET_MODE_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING\
-						__END_SIG__
-#define DEV_GET_MODE_SIGNATURE			__END_SIG__
-#define DEV_SET_PROPERTY_SIGNATURE_BOOL		DBUS_TYPE_STRING_AS_STRING \
-						DBUS_TYPE_BOOLEAN_AS_STRING \
-						__END_SIG__
-#define DEV_SET_PROPERTY_SIGNATURE_STR		DBUS_TYPE_STRING_AS_STRING \
-						DBUS_TYPE_STRING_AS_STRING \
-						__END_SIG__
-#define DEV_SET_PROPERTY_SIGNATURE_BYTE		DBUS_TYPE_STRING_AS_STRING \
-						DBUS_TYPE_BYTE_AS_STRING \
-						__END_SIG__
-
-#define DEV_GET_PROPERTY_SIGNATURE		DBUS_TYPE_STRING_AS_STRING \
-						__END_SIG__
-
-#define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
-							DBUS_TYPE_UINT16_AS_STRING \
-							DBUS_TYPE_UINT16_AS_STRING \
+#define DEV_GET_NAME			"GetName"
+#define DEV_GET_REVISION		"GetRevision"
+#define DEV_GET_VERSION			"GetVersion"
+#define DEV_IS_CONNECTABLE		"IsConnectable"
+#define DEV_IS_DISCOVERABLE		"IsDiscoverable"
+#define DEV_SET_ALIAS			"SetAlias"
+#define DEV_SET_CLASS			"SetClass"
+#define DEV_SET_DISCOVERABLE_TO		"SetDiscoverableTimeOut"
+#define DEV_SET_MODE			"SetMode"
+#define DEV_SET_NAME			"SetName"
+#define DEV_DISCOVER			"Discover"
+#define DEV_DISCOVER_CACHE		"DiscoverCache"
+#define DEV_DISCOVER_CANCEL		"DiscoverCancel"
+#define DEV_DISCOVER_SERVICE		"DiscoverService"
+#define DEV_LAST_SEEN			"LastSeen"
+#define DEV_LAST_USED			"LastUsed"
+#define DEV_REMOTE_ALIAS		"RemoteAlias"
+#define DEV_REMOTE_NAME			"RemoteName"
+#define DEV_REMOTE_VERSION		"RemoteVersion"
+#define DEV_CREATE_BONDING		"CreateBonding"
+#define DEV_LIST_BONDINGS		"ListBondings"
+#define DEV_HAS_BONDING_NAME		"HasBonding"
+#define DEV_REMOVE_BONDING		"RemoveBonding"
+#define DEV_PIN_CODE_LENGTH		"PinCodeLength"
+#define DEV_ENCRYPTION_KEY_SIZE		"EncryptionKeySize"
+
+/*FIXME: maybe this section can be moved to a internal header file */
+/* Device service signature */
+#define DEV_GET_ADDRESS_SIGNATURE			__END_SIG__
+#define DEV_GET_ALIAS_SIGNATURE				DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_GET_COMPANY_SIGNATURE			__END_SIG__
+#define DEV_GET_DISCOVERABLE_TO_SIGNATURE		__END_SIG__
+#define DEV_GET_FEATURES_SIGNATURE			__END_SIG__
+#define DEV_GET_MANUFACTURER_SIGNATURE			__END_SIG__
+#define DEV_GET_MODE_SIGNATURE				__END_SIG__
+#define DEV_GET_NAME_SIGNATURE				__END_SIG__
+#define DEV_GET_REVISION_SIGNATURE			__END_SIG__
+#define DEV_GET_VERSION_SIGNATURE			__END_SIG__
+#define DEV_IS_CONNECTABLE_SIGNATURE			__END_SIG__
+#define DEV_IS_DISCOVERABLE_SIGNATURE			__END_SIG__	
+#define DEV_SET_ALIAS_SIGNATURE				DBUS_TYPE_STRING_AS_STRING\
+							DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_SET_CLASS_SIGNATURE				DBUS_TYPE_STRING_AS_STRING\
+							DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_SET_DISCOVERABLE_TO_SIGNATURE		DBUS_TYPE_UINT32_AS_STRING\
+							__END_SIG__
+#define DEV_SET_MODE_SIGNATURE				DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_SET_NAME_SIGNATURE				DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_DISCOVER_SIGNATURE				__END_SIG__
+#define DEV_DISCOVER_CACHE_SIGNATURE			__END_SIG__
+#define DEV_DISCOVER_CANCEL_SIGNATURE			__END_SIG__
+#define DEV_DISCOVER_SERVICE_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_LAST_SEEN_SIGNATURE				DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_LAST_USED_SIGNATURE				DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_REMOTE_ALIAS_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_REMOTE_NAME_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_REMOTE_VERSION_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+#define DEV_CREATE_BONDING_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
 							__END_SIG__
-
-#define HCI_PERIODIC_INQ_EXT_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
-							DBUS_TYPE_UINT16_AS_STRING \
-							DBUS_TYPE_UINT16_AS_STRING \
-							DBUS_TYPE_UINT32_AS_STRING \
+#define DEV_LIST_BONDINGS_SIGNATURE			__END_SIG__
+#define DEV_HAS_BONDING_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
 							__END_SIG__
-
-#define HCI_CANCEL_PERIODIC_INQ_SIGNATURE		__END_SIG__
-
-#define HCI_INQ_SIGNATURE				__END_SIG__
-
-#define HCI_INQ_EXT_SIGNATURE				DBUS_TYPE_BYTE_AS_STRING \
-							DBUS_TYPE_UINT32_AS_STRING \
+#define DEV_REMOVE_BONDING_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
 							__END_SIG__
-
-#define HCI_CANCEL_INQ_SIGNATURE			__END_SIG__
-
-#define HCI_ROLE_SWITCH_SIGNATURE			DBUS_TYPE_STRING_AS_STRING \
-							DBUS_TYPE_BYTE_AS_STRING \
+#define DEV_PIN_CODE_LENGTH_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
 							__END_SIG__
-
-#define HCI_REMOTE_NAME_SIGNATURE			DBUS_TYPE_STRING_AS_STRING \
+#define DEV_ENCRYPTION_KEY_SIZE_SIGNATURE		DBUS_TYPE_STRING_AS_STRING\
 							__END_SIG__
 
-#define HCI_CONNECTIONS_SIGNATURE			__END_SIG__
-
-#define HCI_CONN_INFO_STRUCT_SIGNATURE			DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
-							DBUS_TYPE_UINT16_AS_STRING \
-							DBUS_TYPE_STRING_AS_STRING \
-							DBUS_TYPE_BYTE_AS_STRING \
-							DBUS_TYPE_BYTE_AS_STRING \
-							DBUS_TYPE_UINT16_AS_STRING \
-							DBUS_TYPE_UINT32_AS_STRING \
-							DBUS_STRUCT_END_CHAR_AS_STRING \
-							__END_SIG__
 
-#define HCI_DEVICE_STRUCT_SIGNATURE			DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
-							DBUS_TYPE_STRING_AS_STRING \
-							DBUS_TYPE_STRING_AS_STRING \
-							DBUS_STRUCT_END_CHAR_AS_STRING \
-							__END_SIG__
-
-#define HCI_INQ_REPLY_SIGNATURE				DBUS_STRUCT_BEGIN_CHAR_AS_STRING \
-							DBUS_TYPE_STRING_AS_STRING \
-							DBUS_TYPE_UINT32_AS_STRING \
-							DBUS_TYPE_UINT16_AS_STRING \
-							DBUS_STRUCT_END_CHAR_AS_STRING \
-							__END_SIG__
+/* Signals sent in the Manager path */
+#define	DEV_SIG_MODE_CHANGED		"ModeChanged"
+#define DEV_SIG_NAME_CHANGED		"NameChanged"
+#define DEV_SIG_ALIAS_CHANGED		"AliasChanged"
+#define DEV_SIG_REMOTE_NAME		"RemoteName"
+#define DEV_SIG_REMOTE_NAME_FAILED	"RemoteNameFailed"
+#define DEV_SIG_REMOTE_ALIAS		"RemoteAlias"
+#define DEV_SIG_REMOTE_VERSION		"RemoteVersion"
+#define DEV_SIG_BONDING_CREATED		"BondingCreated"
+#define DEV_SIG_BONDING_FAILED		"BondingFailed"
+#define DEV_SIG_BONDING_REMOVED		"BondingRemoved"
+#define DEV_SIG_DISCOVER_START		"DiscoverStart"
+#define DEV_SIG_DISCOVER_COMPLETE	"DiscoverComplete"
+#define DEV_SIG_DISCOVER_RESULT		"DiscoverResult"
 
-#define HCI_AUTHENTICATE_SIGNATURE			DBUS_TYPE_STRING_AS_STRING \
-							__END_SIG__
+/* FIXME: Change to string
+ * Scanning modes, used by DEV_SET_MODE
+ * off: remote devices are not allowed to find or connect to this device
+ * connectable: remote devices are allowed to connect, but they are not
+ *              allowed to find it.
+ * discoverable: remote devices are allowed to connect and find this device
+ */
+#define MODE_OFF		0x00	
+#define MODE_CONNECTABLE	0x01	
+#define MODE_DISCOVERABLE	0x02	
 
 
 /* BLUEZ_DBUS_ERROR 
@@ -251,3 +231,6 @@
 
 /* BLUEZ_DBUS_ERR_NO_MEMORY */
 #define BLUEZ_DBUS_ERR_NO_MEMORY_STR	"No memory"
+
+#endif /* __H_BLUEZ_DBUS_H__ */
+
--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-09 13:56:37.000000000 -0200
+++ bluez-utils-cvs-dbus/hcid/dbus.c	2006-02-10 13:45:12.000000000 -0200
@@ -86,19 +86,6 @@
 typedef int register_function_t(DBusConnection *conn, uint16_t id);
 typedef int unregister_function_t(DBusConnection *conn, uint16_t id);
 
-const struct service_data *get_hci_table(void);
-
-static int hci_dbus_reg_obj_path(DBusConnection *conn, uint16_t id);
-static int hci_dbus_unreg_obj_path(DBusConnection *conn, uint16_t id);
-
-typedef const struct service_data *get_svc_table_func_t(void);
-
-struct profile_obj_path_data {
-	uint16_t		id;
-	register_function_t	*reg_func;
-	unregister_function_t	*unreg_func;
-	get_svc_table_func_t	*get_svc_table;	/* return the service table */
-};
 /*
  * Utility functions
  */
@@ -113,6 +100,57 @@
 	return textfile_get(filename, addr);
 }
 
+static int8_t dev_append_signal_args(DBusMessage *signal, int first, va_list var_args)
+{
+	void *value;
+	DBusMessageIter iter;
+	int type;
+	int8_t retval = 0;
+
+	type = first;
+
+	dbus_message_iter_init_append (signal, &iter);
+
+	while (type != DBUS_TYPE_INVALID)
+	{
+		value = va_arg (var_args, void*);
+
+		if (!dbus_message_iter_append_basic (&iter, type, value)) {
+			syslog(LOG_INFO, "Append property argument error! type:%d", type);
+			retval = -1;
+			goto failed;
+		}
+		type = va_arg (var_args, int);
+	}
+failed:
+	return retval;
+}
+
+static DBusMessage *dev_signal_factory(const int devid, const char *prop_name, const int first, ...)
+{
+	DBusMessage *signal = NULL;
+	char path[MAX_PATH_LENGTH];
+	va_list var_args;
+
+	snprintf(path, sizeof(path)-1, "%s/hci%d", DEVICE_PATH, devid);
+
+	signal = dbus_message_new_signal(path, DEVICE_INTERFACE,
+					 prop_name);
+	if (signal == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
+		return NULL;
+	}
+
+	va_start(var_args, first);
+	if (dev_append_signal_args(signal, first, var_args) < 0) {
+		dbus_message_unref(signal);
+		return NULL;
+	}
+
+	va_end(var_args);
+	return signal;
+}
+
 /*
  * D-Bus error messages functions and declarations.
  * This section should be moved to a common file 
@@ -258,22 +296,12 @@
 	return reply;
 }
 
-/*
- * Object path register/unregister functions 
- *
- */
-static struct profile_obj_path_data obj_path_table[] = {
-	{ HCI_PATH_ID, hci_dbus_reg_obj_path, hci_dbus_unreg_obj_path, get_hci_table },
-	/* add other profiles here */
-	{ INVALID_PATH_ID, NULL, NULL, NULL }
-};
 
 /*
  * Virtual table that handle the object path hierarchy
  */
 static DBusHandlerResult msg_func_device(DBusConnection *conn, DBusMessage *msg, void *data);
 static DBusHandlerResult msg_func_manager(DBusConnection *conn, DBusMessage *msg, void *data);
-static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data);
 
 static const DBusObjectPathVTable obj_dev_vtable = {
 	.message_function	= &msg_func_device,
@@ -288,84 +316,109 @@
 /*
  * Services provided under the path DEVICE_PATH
  */
-static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_get_mode_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_set_mode_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_set_property_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_get_property_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_set_property_req_name(DBusMessage *msg, void *data);
-static DBusMessage* handle_device_get_property_req_name(DBusMessage *msg, void *data);
-
-static const struct service_data device_services[] = {
-	{ DEV_UP,		handle_device_up_req,		DEV_UP_SIGNATURE		},
-	{ DEV_DOWN,		handle_device_down_req,		DEV_DOWN_SIGNATURE		},
-	{ DEV_GET_MODE,		handle_device_get_mode_req,	DEV_GET_MODE_SIGNATURE		},
-	{ DEV_SET_MODE,		handle_device_set_mode_req,	DEV_SET_MODE_SIGNATURE		},
-	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_BOOL	},
-	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_STR	},
-	{ DEV_SET_PROPERTY,	handle_device_set_property_req,	DEV_SET_PROPERTY_SIGNATURE_BYTE	},
-	{ DEV_GET_PROPERTY,	handle_device_get_property_req,	DEV_GET_PROPERTY_SIGNATURE	},
-	{ NULL, NULL, NULL}
-};
 
-static const struct service_data set_property_services[] = {
-	{ DEV_PROPERTY_AUTH,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_ENCRYPT,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BOOL		},
-	{ DEV_PROPERTY_NAME,		handle_device_set_property_req_name,	DEV_SET_PROPERTY_SIGNATURE_STR		},
-	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_SET_PROPERTY_SIGNATURE_BYTE		},
-	{ NULL, NULL, NULL}
-};
+static DBusMessage* handle_dev_get_address_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_get_alias_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_get_company_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_get_discoverable_to_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_get_features_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_get_manufacturer_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_get_mode_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_get_name_req(DBusMessage *msg, void *data);
+
+static DBusMessage* handle_dev_get_revision_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_get_version_req(DBusMessage *msg, void *data);
+
+static DBusMessage* handle_dev_is_connectable_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_is_discoverable_req(DBusMessage *msg, void *data);
+
+static DBusMessage* handle_dev_set_alias_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_set_class_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_set_discoverable_to_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_set_mode_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_set_name_req(DBusMessage *msg, void *data);
+
+static DBusMessage* handle_dev_discover_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_discover_cache_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_discover_cancel_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_discover_service_req(DBusMessage *msg, void *data);
+
+static DBusMessage* handle_dev_last_seen_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_last_used_req(DBusMessage *msg, void *data);
+
+static DBusMessage* handle_dev_remote_alias_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_remote_name_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_remote_version_req(DBusMessage *msg, void *data);
+
+static DBusMessage* handle_dev_create_bonding_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_list_bondings_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_has_bonding_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_remove_bonding_req(DBusMessage *msg, void *data);
+
+static DBusMessage* handle_dev_pin_code_length_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_dev_encryption_key_size_req(DBusMessage *msg, void *data);
+
+
+static const struct service_data dev_services[] = {
+	{ DEV_GET_ADDRESS,		handle_dev_get_address_req,		DEV_GET_ADDRESS_SIGNATURE		},
+	{ DEV_GET_ALIAS,		handle_dev_get_alias_req,		DEV_GET_ALIAS_SIGNATURE			},
+	{ DEV_GET_COMPANY,		handle_dev_get_company_req,		DEV_GET_COMPANY_SIGNATURE		},
+	{ DEV_GET_DISCOVERABLE_TO,	handle_dev_get_discoverable_to_req,	DEV_GET_DISCOVERABLE_TO_SIGNATURE	},
+	{ DEV_GET_FEATURES,		handle_dev_get_features_req,		DEV_GET_FEATURES_SIGNATURE		},
+	{ DEV_GET_MANUFACTURER,		handle_dev_get_manufacturer_req,	DEV_GET_MANUFACTURER_SIGNATURE		},
+	{ DEV_GET_MODE,			handle_dev_get_mode_req,		DEV_GET_MODE_SIGNATURE			},
+	{ DEV_GET_NAME,                 handle_dev_get_name_req,                DEV_GET_NAME_SIGNATURE                  },
+	{ DEV_GET_REVISION,		handle_dev_get_revision_req,		DEV_GET_REVISION_SIGNATURE		},
+	{ DEV_GET_VERSION,		handle_dev_get_version_req,		DEV_GET_VERSION_SIGNATURE		},
+
+	{ DEV_IS_CONNECTABLE,		handle_dev_is_connectable_req,		DEV_IS_CONNECTABLE_SIGNATURE		},
+	{ DEV_IS_DISCOVERABLE,		handle_dev_is_discoverable_req,		DEV_IS_DISCOVERABLE_SIGNATURE		},
+
+	{ DEV_SET_ALIAS,		handle_dev_set_alias_req,		DEV_SET_ALIAS_SIGNATURE			},
+	{ DEV_SET_CLASS,		handle_dev_set_class_req,		DEV_SET_CLASS_SIGNATURE			},
+	{ DEV_SET_DISCOVERABLE_TO,	handle_dev_set_discoverable_to_req,	DEV_SET_DISCOVERABLE_TO_SIGNATURE	},
+	{ DEV_SET_MODE,			handle_dev_set_mode_req,		DEV_SET_MODE_SIGNATURE			},
+	{ DEV_SET_NAME,			handle_dev_set_name_req,		DEV_SET_NAME_SIGNATURE			},
+
+	{ DEV_DISCOVER,			handle_dev_discover_req,		DEV_DISCOVER_SIGNATURE			},
+	{ DEV_DISCOVER_CACHE,		handle_dev_discover_cache_req,		DEV_DISCOVER_CACHE_SIGNATURE		},
+	{ DEV_DISCOVER_CANCEL,		handle_dev_discover_cancel_req,		DEV_DISCOVER_CANCEL_SIGNATURE		},
+	{ DEV_DISCOVER_SERVICE,		handle_dev_discover_service_req,	DEV_DISCOVER_SERVICE_SIGNATURE		},
+
+	{ DEV_LAST_SEEN,		handle_dev_last_seen_req,		DEV_LAST_SEEN_SIGNATURE			},
+	{ DEV_LAST_USED,		handle_dev_last_used_req,		DEV_LAST_USED_SIGNATURE			},
+
+	{ DEV_REMOTE_ALIAS,		handle_dev_remote_alias_req,		DEV_REMOTE_ALIAS_SIGNATURE		},
+	{ DEV_REMOTE_NAME,		handle_dev_remote_name_req,		DEV_REMOTE_NAME_SIGNATURE		},
+	{ DEV_REMOTE_VERSION,		handle_dev_remote_version_req,		DEV_REMOTE_VERSION_SIGNATURE		},
+
+	{ DEV_CREATE_BONDING,		handle_dev_create_bonding_req,		DEV_CREATE_BONDING_SIGNATURE		},
+	{ DEV_LIST_BONDINGS,		handle_dev_list_bondings_req,		DEV_LIST_BONDINGS_SIGNATURE		},
+	{ DEV_HAS_BONDING_NAME,		handle_dev_has_bonding_req,		DEV_HAS_BONDING_SIGNATURE		},
+	{ DEV_REMOVE_BONDING,		handle_dev_remove_bonding_req,		DEV_REMOVE_BONDING_SIGNATURE		},
+
+	{ DEV_PIN_CODE_LENGTH,		handle_dev_pin_code_length_req,		DEV_PIN_CODE_LENGTH_SIGNATURE		},
+	{ DEV_ENCRYPTION_KEY_SIZE,	handle_dev_encryption_key_size_req,	DEV_ENCRYPTION_KEY_SIZE_SIGNATURE	},
 
-static const struct service_data get_property_services[] = {
-	{ DEV_PROPERTY_DEV_INFO,	handle_not_implemented_req,		DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_NAME,		handle_device_get_property_req_name,	DEV_GET_PROPERTY_SIGNATURE 	},
-	{ DEV_PROPERTY_INCMODE,		handle_not_implemented_req,		DEV_GET_PROPERTY_SIGNATURE 	},
 	{ NULL, NULL, NULL}
 };
 
 /*
  * Services provided under the path MANAGER_PATH
  */
-static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_default_device_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_mgr_device_list_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_mgr_default_device_req(DBusMessage *msg, void *data);
 
-static const struct service_data manager_services[] = {
-	{ MGR_DEVICE_LIST,	handle_device_list_req,		MGR_GET_DEV_SIGNATURE		},
-	{ MGR_DEFAULT_DEVICE,	handle_default_device_req,	MGR_DEFAULT_DEV_SIGNATURE	},
-	{ MGR_INIT,		handle_not_implemented_req,	NULL				},
-	{ MGR_ENABLE,		handle_not_implemented_req,	NULL				},
-	{ MGR_DISABLE,		handle_not_implemented_req,	NULL				},
+static const struct service_data mgr_services[] = {
+	{ MGR_DEVICE_LIST,	handle_mgr_device_list_req,		MGR_DEVICE_LIST_SIGNATURE	},
+	{ MGR_DEFAULT_DEVICE,	handle_mgr_default_device_req,		MGR_DEFAULT_DEVICE_SIGNATURE	},
 	{ NULL, NULL, NULL }
 };
 
 /*
  * HCI D-Bus services
  */
-static DBusHandlerResult hci_signal_filter(DBusConnection *conn, DBusMessage *msg, void *data);
-
-static DBusMessage* handle_periodic_inq_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_cancel_periodic_inq_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_inq_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_cancel_inq_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_display_conn_req(DBusMessage *msg, void *data);
-static DBusMessage* handle_auth_req(DBusMessage *msg, void *data);
-
-static const struct service_data device_hci_services[] = {
-	{ HCI_PERIODIC_INQ,		handle_periodic_inq_req,	HCI_PERIODIC_INQ_SIGNATURE		},
-	{ HCI_PERIODIC_INQ,		handle_periodic_inq_req,	HCI_PERIODIC_INQ_EXT_SIGNATURE		},
-	{ HCI_CANCEL_PERIODIC_INQ,	handle_cancel_periodic_inq_req,	HCI_CANCEL_PERIODIC_INQ_SIGNATURE	},
-	{ HCI_ROLE_SWITCH,		handle_role_switch_req,		HCI_ROLE_SWITCH_SIGNATURE		},
-	{ HCI_INQ,			handle_inq_req,			HCI_INQ_SIGNATURE			},
-	{ HCI_INQ,			handle_inq_req,			HCI_INQ_EXT_SIGNATURE			},
-	{ HCI_CANCEL_INQ,		handle_cancel_inq_req,		HCI_CANCEL_INQ_SIGNATURE		},
-	{ HCI_REMOTE_NAME,		handle_remote_name_req,		HCI_REMOTE_NAME_SIGNATURE		},
-	{ HCI_CONNECTIONS,		handle_display_conn_req,	HCI_CONNECTIONS_SIGNATURE		},
-	{ HCI_AUTHENTICATE,		handle_auth_req,		HCI_AUTHENTICATE_SIGNATURE		},
-	{ NULL, NULL, NULL }
-};
+static DBusHandlerResult hci_dbus_signal_filter(DBusConnection *conn, DBusMessage *msg, void *data);
 
 static void reply_handler_function(DBusPendingCall *call, void *user_data)
 {
@@ -434,6 +487,8 @@
 	gboolean ret = FALSE;
 	struct hci_dbus_data *data = NULL;
 
+	syslog(LOG_INFO, "[%s,%d] path:%s, fallback:%d", __PRETTY_FUNCTION__, __LINE__, path, fallback);
+
 	data = malloc(sizeof(struct hci_dbus_data));
 	if (data == NULL) {
 		syslog(LOG_ERR, "Failed to alloc memory to DBUS path register data (%s)", path);
@@ -468,6 +523,8 @@
 {
 	void *data;
 
+	syslog(LOG_INFO, "[%s,%d] path:%s", __PRETTY_FUNCTION__, __LINE__, path);
+
 	if (dbus_connection_get_object_path_data(connection, path, &data) && data)
 		free(data);
 
@@ -479,6 +536,126 @@
 	return TRUE;
 }
 
+/*****************************************************************
+ *
+ *  Section reserved to HCI commands confirmation handling and low
+ *  level events(eg: device attached/dettached.
+ *
+ *****************************************************************/
+
+gboolean hcid_dbus_register_device(uint16_t id) 
+{
+	char path[MAX_PATH_LENGTH];
+	char *pptr = path;
+	gboolean ret;
+	DBusMessage *message = NULL;
+	int dd = -1;
+	read_scan_enable_rp rp;
+	struct hci_request rq;
+	struct hci_dbus_data* pdata;
+
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
+	ret = register_dbus_path(path, DEVICE_PATH_ID, id, &obj_dev_vtable, FALSE);
+
+	dd = hci_open_dev(id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", id);
+		rp.enable = SCAN_PAGE | SCAN_INQUIRY;
+	} else {
+		memset(&rq, 0, sizeof(rq));
+		rq.ogf    = OGF_HOST_CTL;
+		rq.ocf    = OCF_READ_SCAN_ENABLE;
+		rq.rparam = &rp;
+		rq.rlen   = READ_SCAN_ENABLE_RP_SIZE;
+	
+		if (hci_send_req(dd, &rq, 500) < 0) {
+			syslog(LOG_ERR, "Sending read scan enable command failed: %s (%d)",
+								strerror(errno), errno);
+			rp.enable = SCAN_PAGE | SCAN_INQUIRY;
+		} else if (rp.status) {
+			syslog(LOG_ERR, "Getting scan enable failed with status 0x%02x",
+										rp.status);
+			rp.enable = SCAN_PAGE | SCAN_INQUIRY;
+		}
+	}
+
+	if (!dbus_connection_get_object_path_data(connection, path, (void*) &pdata))
+		syslog(LOG_ERR, "Getting path data failed!");
+	else
+		pdata->path_data = rp.enable; /* Keep the current scan status */
+
+	message = dbus_message_new_signal(MANAGER_PATH, MANAGER_INTERFACE,
+							BLUEZ_MGR_DEV_ADDED);
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
+		goto failed;
+	}
+
+	/*FIXME: append a friendly name instead of device path */
+	dbus_message_append_args(message,
+					DBUS_TYPE_STRING, &pptr,
+					DBUS_TYPE_INVALID);
+
+	if (!dbus_connection_send(connection, message, NULL)) {
+		syslog(LOG_ERR, "Can't send D-BUS added device message");
+		goto failed;
+	}
+
+	dbus_connection_flush(connection);
+
+failed:
+	if (message)
+		dbus_message_unref(message);
+
+	if (ret && default_dev < 0)
+		default_dev = id;
+
+	if (dd >= 0)
+		close(dd);
+
+	return ret;
+}
+
+gboolean hcid_dbus_unregister_device(uint16_t id)
+{
+	gboolean ret;
+	DBusMessage *message = NULL;
+	char path[MAX_PATH_LENGTH];
+	char *pptr = path;
+
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
+
+	message = dbus_message_new_signal(MANAGER_PATH, MANAGER_INTERFACE,
+							BLUEZ_MGR_DEV_REMOVED);
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
+		goto failed;
+	}
+
+	/*FIXME: append a friendly name instead of device path */
+	dbus_message_append_args(message,
+					DBUS_TYPE_STRING, &pptr,
+					DBUS_TYPE_INVALID);
+
+	if (!dbus_connection_send(connection, message, NULL)) {
+		syslog(LOG_ERR, "Can't send D-BUS added device message");
+		goto failed;
+	}
+
+	dbus_connection_flush(connection);
+
+failed:
+	if (message)
+		dbus_message_unref(message);
+
+	ret = unregister_dbus_path(path);
+
+	if (ret && default_dev == id)
+		default_dev = hci_get_route(NULL);
+
+	return ret;
+}
+
 void hcid_dbus_request_pin(int dev, struct hci_conn_info *ci)
 {
 	DBusMessage *message = NULL;
@@ -529,15 +706,16 @@
 	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, &ci->bdaddr);
 }
 
-void hcid_dbus_inquiry_start(bdaddr_t *local)
+void hcid_dbus_bonding_created_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status)
 {
 	DBusMessage *message = NULL;
-	char path[MAX_PATH_LENGTH];
-	char *local_addr;
+	char *local_addr, *peer_addr;
 	bdaddr_t tmp;
+	char path[MAX_PATH_LENGTH];
 	int id;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
+	baswap(&tmp, peer); peer_addr = batostr(&tmp);
 
 	id = hci_devid(local_addr);
 	if (id < 0) {
@@ -545,28 +723,37 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-	message = dbus_message_new_signal(path, DEV_HCI_INTERFACE,
-						BLUEZ_HCI_INQ_START);
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+						DEV_SIG_BONDING_CREATED);
 	if (message == NULL) {
-		syslog(LOG_ERR, "Can't allocate D-BUS inquiry start message");
+		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
 	}
 
+	/*FIXME: create the signal based on status value - BondingCreated or BondingFailed*/
+	dbus_message_append_args(message,
+					DBUS_TYPE_STRING, &peer_addr,
+					DBUS_TYPE_BYTE, &status,
+					DBUS_TYPE_INVALID);
+
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
-		syslog(LOG_ERR, "Can't send D-BUS inquiry start message");
+		syslog(LOG_ERR, "Can't send D-BUS remote name message");
 		goto failed;
 	}
 
 	dbus_connection_flush(connection);
 
 failed:
-	dbus_message_unref(message);
+	if (message)
+		dbus_message_unref(message);
+
 	bt_free(local_addr);
+	bt_free(peer_addr);
 }
 
-void hcid_dbus_inquiry_complete(bdaddr_t *local)
+void hcid_dbus_discover_start(bdaddr_t *local)
 {
 	DBusMessage *message = NULL;
 	char path[MAX_PATH_LENGTH];
@@ -582,17 +769,17 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-	message = dbus_message_new_signal(path, DEV_HCI_INTERFACE,
-						BLUEZ_HCI_INQ_COMPLETE);
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+						DEV_SIG_DISCOVER_START);
 	if (message == NULL) {
-		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
+		syslog(LOG_ERR, "Can't allocate D-BUS inquiry start message");
 		goto failed;
 	}
 
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
-		syslog(LOG_ERR, "Can't send D-BUS inquiry complete message");
+		syslog(LOG_ERR, "Can't send D-BUS inquiry start message");
 		goto failed;
 	}
 
@@ -603,18 +790,15 @@
 	bt_free(local_addr);
 }
 
-void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi)
+void hcid_dbus_discover_complete(bdaddr_t *local)
 {
 	DBusMessage *message = NULL;
 	char path[MAX_PATH_LENGTH];
-	char *local_addr, *peer_addr;
-	dbus_uint32_t tmp_class = class;
-	dbus_int32_t tmp_rssi = rssi;
+	char *local_addr;
 	bdaddr_t tmp;
 	int id;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
-	baswap(&tmp, peer); peer_addr = batostr(&tmp);
 
 	id = hci_devid(local_addr);
 	if (id < 0) {
@@ -622,23 +806,17 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-	message = dbus_message_new_signal(path, DEV_HCI_INTERFACE,
-						BLUEZ_HCI_INQ_RESULT);
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+						DEV_SIG_DISCOVER_COMPLETE);
 	if (message == NULL) {
-		syslog(LOG_ERR, "Can't allocate D-BUS inquiry result message");
+		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
 		goto failed;
 	}
 
-	dbus_message_append_args(message,
-					DBUS_TYPE_STRING, &peer_addr,
-					DBUS_TYPE_UINT32, &tmp_class,
-					DBUS_TYPE_INT32, &tmp_rssi,
-					DBUS_TYPE_INVALID);
-
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
-		syslog(LOG_ERR, "Can't send D-BUS inquiry result message");
+		syslog(LOG_ERR, "Can't send D-BUS inquiry complete message");
 		goto failed;
 	}
 
@@ -646,16 +824,16 @@
 
 failed:
 	dbus_message_unref(message);
-
 	bt_free(local_addr);
-	bt_free(peer_addr);
 }
 
-void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
+void hcid_dbus_discover_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi)
 {
 	DBusMessage *message = NULL;
 	char path[MAX_PATH_LENGTH];
 	char *local_addr, *peer_addr;
+	dbus_uint32_t tmp_class = class;
+	dbus_int32_t tmp_rssi = rssi;
 	bdaddr_t tmp;
 	int id;
 
@@ -668,36 +846,36 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-	message = dbus_message_new_signal(path, DEV_HCI_INTERFACE,
-						BLUEZ_HCI_REMOTE_NAME);
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+						DEV_SIG_DISCOVER_RESULT);
 	if (message == NULL) {
-		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
+		syslog(LOG_ERR, "Can't allocate D-BUS inquiry result message");
 		goto failed;
 	}
 
 	dbus_message_append_args(message,
 					DBUS_TYPE_STRING, &peer_addr,
-					DBUS_TYPE_STRING, &name,
+					DBUS_TYPE_UINT32, &tmp_class,
+					DBUS_TYPE_INT32, &tmp_rssi,
 					DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
-		syslog(LOG_ERR, "Can't send D-BUS remote name message");
+		syslog(LOG_ERR, "Can't send D-BUS inquiry result message");
 		goto failed;
 	}
 
 	dbus_connection_flush(connection);
 
 failed:
-	if (message)
-		dbus_message_unref(message);
+	dbus_message_unref(message);
 
 	bt_free(local_addr);
 	bt_free(peer_addr);
 }
 
-void hcid_dbus_remote_name_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status)
+void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 {
 	DBusMessage *message = NULL;
 	char path[MAX_PATH_LENGTH];
@@ -714,10 +892,10 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-	message = dbus_message_new_signal(path, DEV_HCI_INTERFACE,
-						BLUEZ_HCI_REMOTE_NAME_FAILED);
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+						DEV_REMOTE_NAME);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
@@ -725,7 +903,7 @@
 
 	dbus_message_append_args(message,
 					DBUS_TYPE_STRING, &peer_addr,
-					DBUS_TYPE_BYTE, &status,
+					DBUS_TYPE_STRING, &name,
 					DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
@@ -743,20 +921,12 @@
 	bt_free(peer_addr);
 }
 
-void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer)
-{
-}
-
-void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason)
-{
-}
-
-void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status)
+void hcid_dbus_remote_name_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status)
 {
 	DBusMessage *message = NULL;
+	char path[MAX_PATH_LENGTH];
 	char *local_addr, *peer_addr;
 	bdaddr_t tmp;
-	char path[MAX_PATH_LENGTH];
 	int id;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
@@ -768,10 +938,10 @@
 		goto failed;
 	}
 
-	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-	message = dbus_message_new_signal(path, DEV_HCI_INTERFACE,
-						BLUEZ_HCI_AUTH_COMPLETE);
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
+						DEV_SIG_REMOTE_NAME_FAILED);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
@@ -797,6 +967,20 @@
 	bt_free(peer_addr);
 }
 
+void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer)
+{
+}
+
+void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason)
+{
+}
+
+
+/*****************************************************************
+ *
+ *  Section reserved to D-Bus watch functions
+ *
+ *****************************************************************/
 gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	DBusWatch *watch = (DBusWatch *) data;
@@ -869,29 +1053,7 @@
 		remove_watch(watch, data);
 }
 
-static gboolean unregister_device_path(const char *path)
-{
-	char **children = NULL;
-
-	if (!dbus_connection_list_registered(connection, path, &children))
-		goto done;
-
-	for (; *children; children++) {
-		char child_path[MAX_PATH_LENGTH];
-
-		snprintf(child_path, sizeof(child_path), "%s/%s", path, *children);
-
-		unregister_dbus_path(child_path);
-	}
-
-	if (*children)
-		dbus_free_string_array(children);
-
-done:
-	return unregister_dbus_path(path);
-}
-
-gboolean hcid_dbus_init(void)
+gboolean hcid_dbus_init(void)
 {
 	DBusError error;
 
@@ -926,7 +1088,7 @@
 				&obj_mgr_vtable, FALSE))
 		return FALSE;
 
-	if (!dbus_connection_add_filter(connection, hci_signal_filter, NULL, NULL)) {
+	if (!dbus_connection_add_filter(connection, hci_dbus_signal_filter, NULL, NULL)) {
 		syslog(LOG_ERR, "Can't add new HCI filter");
 		return FALSE;
 	}
@@ -953,7 +1115,7 @@
 
 		snprintf(dev_path, sizeof(dev_path), "%s/%s", DEVICE_PATH, *children);
 
-		unregister_device_path(dev_path);
+		unregister_dbus_path(dev_path);
 	}
 
 	if (*children)
@@ -966,240 +1128,6 @@
 	dbus_connection_close(connection);
 }
 
-gboolean hcid_dbus_register_device(uint16_t id) 
-{
-	char path[MAX_PATH_LENGTH];
-	char *pptr = path;
-	gboolean ret;
-	DBusMessage *message = NULL;
-	int dd = -1;
-	read_scan_enable_rp rp;
-	struct hci_request rq;
-	struct hci_dbus_data* pdata;
-
-	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
-	ret = register_dbus_path(path, DEVICE_PATH_ID, id, &obj_dev_vtable, FALSE);
-
-	dd = hci_open_dev(id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed: hci%d", id);
-		rp.enable = SCAN_PAGE | SCAN_INQUIRY;
-	} else {
-		memset(&rq, 0, sizeof(rq));
-		rq.ogf    = OGF_HOST_CTL;
-		rq.ocf    = OCF_READ_SCAN_ENABLE;
-		rq.rparam = &rp;
-		rq.rlen   = READ_SCAN_ENABLE_RP_SIZE;
-	
-		if (hci_send_req(dd, &rq, 500) < 0) {
-			syslog(LOG_ERR, "Sending read scan enable command failed: %s (%d)",
-								strerror(errno), errno);
-			rp.enable = SCAN_PAGE | SCAN_INQUIRY;
-		} else if (rp.status) {
-			syslog(LOG_ERR, "Getting scan enable failed with status 0x%02x",
-										rp.status);
-			rp.enable = SCAN_PAGE | SCAN_INQUIRY;
-		}
-	}
-
-	if (!dbus_connection_get_object_path_data(connection, path, (void*) &pdata))
-		syslog(LOG_ERR, "Getting path data failed!");
-	else
-		pdata->path_data = rp.enable; /* Keep the current scan status */
-
-	message = dbus_message_new_signal(MANAGER_PATH, MANAGER_INTERFACE,
-							BLUEZ_MGR_DEV_ADDED);
-	if (message == NULL) {
-		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
-		goto failed;
-	}
-
-	dbus_message_append_args(message,
-					DBUS_TYPE_STRING, &pptr,
-					DBUS_TYPE_INVALID);
-
-	if (!dbus_connection_send(connection, message, NULL)) {
-		syslog(LOG_ERR, "Can't send D-BUS added device message");
-		goto failed;
-	}
-
-	dbus_connection_flush(connection);
-
-failed:
-	if (message)
-		dbus_message_unref(message);
-
-	if (ret && default_dev < 0)
-		default_dev = id;
-
-	if (dd >= 0)
-		close(dd);
-
-	return ret;
-}
-
-gboolean hcid_dbus_unregister_device(uint16_t id)
-{
-	gboolean ret;
-	DBusMessage *message = NULL;
-	char path[MAX_PATH_LENGTH];
-	char *pptr = path;
-
-	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
-
-	message = dbus_message_new_signal(MANAGER_PATH, MANAGER_INTERFACE,
-							BLUEZ_MGR_DEV_REMOVED);
-	if (message == NULL) {
-		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
-		goto failed;
-	}
-
-	dbus_message_append_args(message,
-					DBUS_TYPE_STRING, &pptr,
-					DBUS_TYPE_INVALID);
-
-	if (!dbus_connection_send(connection, message, NULL)) {
-		syslog(LOG_ERR, "Can't send D-BUS added device message");
-		goto failed;
-	}
-
-	dbus_connection_flush(connection);
-
-failed:
-	if (message)
-		dbus_message_unref(message);
-
-	ret = unregister_device_path(path);
-
-	if (ret && default_dev == id)
-		default_dev = hci_get_route(NULL);
-
-	return ret;
-}
-
-gboolean hcid_dbus_dev_up(uint16_t id)
-{
-	char path[MAX_PATH_LENGTH];
-	struct profile_obj_path_data *ptr = obj_path_table;
-	DBusMessage *message = NULL;
-
-	if (!connection)
-		return FALSE;
-
-	for (; ptr->id != INVALID_PATH_ID; ptr++) {
-		if (ptr->reg_func(connection, id) < 0)
-			goto failed;
-	}
-
-	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
-
-	message = dbus_message_new_signal(path, DEVICE_INTERFACE, DEV_UP);
-
-	if (message == NULL) {
-		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
-		goto failed;
-	}
-
-	if (dbus_connection_send(connection, message, NULL) == FALSE) {
-		syslog(LOG_ERR, "Can't send D-BUS added device message");
-		goto failed;
-	}
-
-	dbus_connection_flush(connection);
-
-failed:
-	/* if the signal can't be sent ignore the error */
-
-	if (message)
-		dbus_message_unref(message);
-
-	return TRUE;
-}
-
-gboolean hcid_dbus_dev_down(uint16_t id)
-{
-	char path[MAX_PATH_LENGTH];
-	struct profile_obj_path_data *ptr = obj_path_table;
-	DBusMessage *message = NULL;
-
-	if (!connection)
-		return FALSE;
-
-	for (; ptr->id != INVALID_PATH_ID; ptr++) {
-		if (ptr->unreg_func(connection, id) < 0)
-			syslog(LOG_ERR, "Unregistering profile id 0x%04x failed", ptr->id);
-	}
-
-	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
-
-	message = dbus_message_new_signal(path, DEVICE_INTERFACE, DEV_DOWN);
-	if (message == NULL) {
-		syslog(LOG_ERR, "Can't allocate D-BUS device removed  message");
-		goto failed;
-	}
-
-	if (dbus_connection_send(connection, message, NULL) == FALSE) {
-		syslog(LOG_ERR, "Can't send D-BUS removed device message");
-		goto failed;
-	}
-
-	dbus_connection_flush(connection);
-
-failed:
-	/* if the signal can't be sent ignore the error */
-
-	if (message)
-		dbus_message_unref(message);
-
-	return TRUE;
-}
-
-/*
- * @brief HCI object path register function
- * Detailed description: function responsible for register a new hci 
- * D-Bus path. If necessary the default path must be registered too.
- * @param conn D-Bus connection
- * @param id hci device identification
- * @return (0-Success/-1 failure)
- */
-static int hci_dbus_reg_obj_path(DBusConnection *conn, uint16_t id)
-{
-	char path[MAX_PATH_LENGTH];
-
-	/* register the default path*/
-	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
-	if (!register_dbus_path(path, HCI_PATH_ID, id, &obj_dev_vtable, FALSE))
-		return -1;
-
-	return 0;
-}
-
-/*
- * @brief HCI object path unregister function
- * Detailed description: function responsible for unregister HCI D-Bus
- * path for a detached hci device. If necessary the default path must 
- * be registered too.
- * @param conn D-Bus connection
- * @param unreg_dft register the default path(0 or !0)
- * @param id hci device identification
- * @return (0-Success/-1 failure)
- */
-static int hci_dbus_unreg_obj_path(DBusConnection *conn, uint16_t id) 
-{
-	char path[MAX_PATH_LENGTH];
-
-	snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, id, BLUEZ_HCI);
-	if (!unregister_dbus_path(path))
-		return -1;
-
-	return 0;
-}
-
-const struct service_data *get_hci_table(void)
-{
-	return device_hci_services;
-}
-
 /*****************************************************************
  *
  *  Section reserved to re-connection timer
@@ -1247,14 +1175,9 @@
 	/* reset the default device */
 	default_dev = -1;
 
-	for (i = 0; i < dl->dev_num; i++, dr++) {
-
+	for (i = 0; i < dl->dev_num; i++, dr++)
 		hcid_dbus_register_device(dr->dev_id);
 
-		if (hci_test_bit(HCI_UP, &dr->dev_opt))
-			hcid_dbus_dev_up(dr->dev_id);
-	}
-
 failed:
 	if (sk >= 0)
 		close(sk);
@@ -1285,11 +1208,11 @@
 }
 
 /*****************************************************************
- *  
- *  Section reserved to HCI D-Bus services 
- *  
+ *
+ *  Section reserved to D-Bus signal/messages handling function
+ *
  *****************************************************************/
-static DBusHandlerResult hci_signal_filter (DBusConnection *conn, DBusMessage *msg, void *data)
+static DBusHandlerResult hci_dbus_signal_filter (DBusConnection *conn, DBusMessage *msg, void *data)
 {
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	const char *iface;
@@ -1324,19 +1247,19 @@
 
 static DBusHandlerResult msg_func_device(DBusConnection *conn, DBusMessage *msg, void *data)
 {
-	const struct service_data *handlers = NULL;
+	const struct service_data *handlers = dev_services;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
 	const char *method;
 	const char *signature;
-	const char *path;
 	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
-	path = dbus_message_get_path(msg);
 	method = dbus_message_get_member(msg);
 	signature = dbus_message_get_signature(msg);
 
+	syslog(LOG_INFO, "[%s,%d] path:%s, method:%s", __PRETTY_FUNCTION__, __LINE__, dbus_message_get_path(msg), method);
+	       
 	if (dbus_data->path_id == DEVICE_ROOT_ID) {
 		/* Device is down(path unregistered) or the path is wrong */
 		ret = DBUS_HANDLER_RESULT_HANDLED;
@@ -1344,21 +1267,7 @@
 		goto failed;
 	}
 
-	if (dbus_data->path_id == DEVICE_PATH_ID)
-		handlers = device_services;
-	else {
-		struct profile_obj_path_data *profile;
-		for (profile = obj_path_table; profile->id != INVALID_PATH_ID; profile++) {
-			if (profile->id == dbus_data->path_id) {
-				handlers = profile->get_svc_table();
-				break;
-			}
-		}
-	}
-
-	if (!handlers)
-		goto failed;
-
+	/* It's a device path id */
 	for (; handlers->name != NULL; handlers++) {
 		if (strcmp(handlers->name, method))
 			continue;
@@ -1398,19 +1307,19 @@
 	const char *iface;
 	const char *method;
 	const char *signature;
-	const char *path;
 	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
-	path = dbus_message_get_path(msg);
 	iface = dbus_message_get_interface(msg);
 	method = dbus_message_get_member(msg);
 	signature = dbus_message_get_signature(msg);
 
+	syslog(LOG_INFO, "[%s,%d] path:%s, method:%s", __PRETTY_FUNCTION__, __LINE__, dbus_message_get_path(msg), method);
+
 	if (strcmp(iface, MANAGER_INTERFACE) != 0)
 		return ret;
 
-	for (handlers = manager_services; handlers->name != NULL; handlers++) {
+	for (handlers = mgr_services; handlers->name != NULL; handlers++) {
 		if (strcmp(handlers->name, method))
 			continue;
 
@@ -1436,80 +1345,125 @@
 	return ret;
 }
 
-static DBusMessage* handle_periodic_inq_req(DBusMessage *msg, void *data)
+/*****************************************************************
+ *
+ *  Section reserved to device D-Bus services implementation
+ *
+ *****************************************************************/
+static DBusMessage* handle_dev_get_address_req(DBusMessage *msg, void *data)
 {
-	periodic_inquiry_cp inq_param;
-	struct hci_request rq;
-	uint8_t status;
-	DBusMessage *reply = NULL;
-	struct hci_dbus_data *dbus_data = data;
-	uint8_t length, num_rsp = 0;
-	uint16_t max_period;
-	uint16_t min_period;
-	uint32_t lap = 0x9e8b33;
-	int dd = -1;
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
 
-	dd = hci_open_dev(dbus_data->dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed");
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto failed;
-	}
+static DBusMessage* handle_dev_get_alias_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+static DBusMessage* handle_dev_get_company_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+static DBusMessage* handle_dev_get_discoverable_to_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+static DBusMessage* handle_dev_get_features_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+static DBusMessage* handle_dev_get_manufacturer_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
 
-	if (dbus_message_has_signature(msg, HCI_PERIODIC_INQ_EXT_SIGNATURE))
-		dbus_message_get_args(msg, NULL,
-						DBUS_TYPE_BYTE, &length,
-						DBUS_TYPE_UINT16, &min_period,
-						DBUS_TYPE_UINT16, &max_period,
-						DBUS_TYPE_UINT32, &lap,
-						DBUS_TYPE_INVALID);
-	else
-		dbus_message_get_args(msg, NULL,
-						DBUS_TYPE_BYTE, &length,
-						DBUS_TYPE_UINT16, &min_period,
-						DBUS_TYPE_UINT16, &max_period,
-						DBUS_TYPE_INVALID);
+static DBusMessage* handle_dev_get_mode_req(DBusMessage *msg, void *data)
+{
+	const struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	const uint8_t hci_mode = dbus_data->path_data;
+	uint8_t scan_mode;
 
-	/* Check for valid parameters */
-	if (length >= min_period || min_period >= max_period
-					|| length < 0x01 || length > 0x30
-					|| lap < 0x9e8b00 || lap > 0x9e8b3f) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
-		goto failed;
+	switch (hci_mode) {
+	case SCAN_DISABLED:
+		scan_mode = MODE_OFF;
+		break;
+	case SCAN_PAGE:
+		scan_mode = MODE_CONNECTABLE;
+		break;
+	case (SCAN_PAGE | SCAN_INQUIRY):
+		scan_mode = MODE_DISCOVERABLE;
+		break;
+	case SCAN_INQUIRY:
+	/* inquiry scan mode is not handled, return 0xff */
+	default:
+		/* reserved */
+		scan_mode = 0xff;
 	}
 
-	inq_param.num_rsp = num_rsp;
-	inq_param.length  = length;
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply,
+					DBUS_TYPE_BYTE, &scan_mode,
+					DBUS_TYPE_INVALID);
+
+	return reply;
+}
 
-	inq_param.max_period = htobs(max_period);
-	inq_param.min_period = htobs(min_period);
+static DBusMessage* handle_dev_get_name_req(DBusMessage *msg, void *data)
+{
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	int dd = -1;
+	read_local_name_rp rp;
+	struct hci_request rq;
+	const char *pname = (char*) rp.name;
+	char name[249];
 
-	inq_param.lap[0] = lap & 0xff;
-	inq_param.lap[1] = (lap >> 8) & 0xff;
-	inq_param.lap[2] = (lap >> 16) & 0xff;
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
 
 	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_PERIODIC_INQUIRY;
-	rq.cparam = &inq_param;
-	rq.clen   = PERIODIC_INQUIRY_CP_SIZE;
-	rq.rparam = &status;
-	rq.rlen   = sizeof(status);
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_READ_LOCAL_NAME;
+	rq.rparam = &rp;
+	rq.rlen   = READ_LOCAL_NAME_RP_SIZE;
 
 	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Sending periodic inquiry command failed: %s (%d)",
+		syslog(LOG_ERR, "Sending getting name command failed: %s (%d)",
 							strerror(errno), errno);
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
-	if (status) {
-		syslog(LOG_ERR, "Periodic inquiry failed with status 0x%02x", status);
-		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + status);
+	if (rp.status) {
+		syslog(LOG_ERR, "Getting name failed with status 0x%02x", rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + rp.status);
 		goto failed;
 	}
 
 	reply = dbus_message_new_method_return(msg);
+	if (reply == NULL) {
+		syslog(LOG_ERR, "Out of memory while calling dbus_message_new_method_return");
+		goto failed;
+	}
+
+	strncpy(name,pname,sizeof(name)-1);
+	name[248]='\0';
+	pname = name;
+
+	dbus_message_append_args(reply,
+				DBUS_TYPE_STRING, &pname,
+				DBUS_TYPE_INVALID);
 
 failed:
 	if (dd >= 0)
@@ -1518,36 +1472,161 @@
 	return reply;
 }
 
-static DBusMessage* handle_cancel_periodic_inq_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_dev_get_revision_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+static DBusMessage* handle_dev_get_version_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+
+static DBusMessage* handle_dev_is_connectable_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+static DBusMessage* handle_dev_is_discoverable_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+
+static DBusMessage* handle_dev_set_alias_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+
+static DBusMessage* handle_dev_set_class_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+static DBusMessage* handle_dev_set_discoverable_to_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+
+static DBusMessage* handle_dev_set_mode_req(DBusMessage *msg, void *data)
 {
+	const struct hci_dbus_data *dbus_data = data;
 	DBusMessage *reply = NULL;
 	struct hci_request rq;
+	int dd = -1;
+	const uint8_t scan_mode;
+	uint8_t hci_mode;
+	uint8_t status = 0;
+	const uint8_t current_mode = dbus_data->path_data;
+
+	dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_BYTE, &scan_mode,
+					DBUS_TYPE_INVALID);
+
+	switch (scan_mode) {
+	case MODE_OFF:
+		hci_mode = SCAN_DISABLED;
+		break;
+	case MODE_CONNECTABLE:
+		hci_mode = SCAN_PAGE;
+		break;
+	case MODE_DISCOVERABLE:
+		hci_mode = (SCAN_PAGE | SCAN_INQUIRY);
+		break;
+	default:
+		/* invalid mode */
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+		goto failed;
+	}
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+
+	/* Check if the new requested mode is different from the current */
+	if (current_mode != hci_mode) {
+		memset(&rq, 0, sizeof(rq));
+		rq.ogf    = OGF_HOST_CTL;
+		rq.ocf    = OCF_WRITE_SCAN_ENABLE;
+		rq.cparam = &hci_mode;
+		rq.clen   = sizeof(hci_mode);
+		rq.rparam = &status;
+		rq.rlen   = sizeof(status);
+
+		if (hci_send_req(dd, &rq, 100) < 0) {
+			syslog(LOG_ERR, "Sending write scan enable command failed: %s (%d)",
+							strerror(errno), errno);
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
+			goto failed;
+		}
+		if (status) {
+			syslog(LOG_ERR, "Setting scan enable failed with status 0x%02x", status);
+			reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET | status);
+			goto failed;
+		}
+
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+
+	return reply;
+}
+
+static DBusMessage* handle_dev_set_name_req(DBusMessage *msg, void *data)
+{
 	struct hci_dbus_data *dbus_data = data;
-	uint8_t status;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	char *str_name;
 	int dd = -1;
+	uint8_t status;
+	change_local_name_cp cp;
+	struct hci_request rq;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &str_name);
+
+	if (strlen(str_name) == 0) {
+		syslog(LOG_ERR, "HCI change name failed - Invalid Name!");
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+		goto failed;
+	}
 
 	dd = hci_open_dev(dbus_data->dev_id);
 	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed");
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 		goto failed;
 	}
 
 	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_EXIT_PERIODIC_INQUIRY;
+	strncpy((char *) cp.name, str_name, sizeof(cp.name));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_CHANGE_LOCAL_NAME;
+	rq.cparam = &cp;
+	rq.clen   = CHANGE_LOCAL_NAME_CP_SIZE;
 	rq.rparam = &status;
 	rq.rlen   = sizeof(status);
 
 	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Sending exit periodic inquiry command failed: %s (%d)",
+		syslog(LOG_ERR, "Sending change name command failed: %s (%d)",
 							strerror(errno), errno);
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
 	if (status) {
-		syslog(LOG_ERR, "Exit periodic inquiry failed with status 0x%02x", status);
+		syslog(LOG_ERR, "Setting name failed with status 0x%02x", status);
 		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + status);
 		goto failed;
 	}
@@ -1559,9 +1638,10 @@
 		close(dd);
 
 	return reply;
+
 }
 
-static DBusMessage* handle_inq_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_dev_discover_req(DBusMessage *msg, void *data)
 {
 	DBusMessage *reply = NULL;
 	inquiry_cp cp;
@@ -1572,19 +1652,6 @@
 	uint8_t length = 8, num_rsp = 0;
 	uint32_t lap = 0x9e8b33;
 
-	if (dbus_message_has_signature(msg, HCI_INQ_EXT_SIGNATURE)) {
-		dbus_message_get_args(msg, NULL,
-						DBUS_TYPE_BYTE, &length,
-						DBUS_TYPE_UINT32, &lap,
-						DBUS_TYPE_INVALID);
-
-		if (length < 0x01 || length > 0x30
-					|| lap < 0x9e8b00 || lap > 0x9e8b3f) {
-			reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
-			goto failed;
-		}
-	}
-
 	dd = hci_open_dev(dbus_data->dev_id);
 	if (dd < 0) {
 		syslog(LOG_ERR, "Unable to open device %d: %s (%d)",
@@ -1623,9 +1690,16 @@
 		hci_close_dev(dd);
 
 	return reply;
+
+}
+
+static DBusMessage* handle_dev_discover_cache_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
 }
 
-static DBusMessage* handle_cancel_inq_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_dev_discover_cancel_req(DBusMessage *msg, void *data)
 {
 	DBusMessage *reply = NULL;
 	struct hci_request rq;
@@ -1669,56 +1743,32 @@
 	return reply;
 }
 
-static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data)
-{
-	DBusMessage *reply = NULL;
-	char *str_bdaddr = NULL;
-	struct hci_dbus_data *dbus_data = data;
-	bdaddr_t bdaddr;
-	uint8_t role;
-	int dev_id = -1, dd = -1;
-
-	dbus_message_get_args(msg, NULL,
-					DBUS_TYPE_STRING, &str_bdaddr,
-					DBUS_TYPE_BYTE, &role,
-					DBUS_TYPE_INVALID);
-
-	str2ba(str_bdaddr, &bdaddr);
-
-	dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
-
-	if (dev_id < 0) {
-		syslog(LOG_ERR, "Bluetooth device failed");
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto failed;
-	}
-
-	if (dbus_data->dev_id != dev_id) {
-		syslog(LOG_ERR, "Connection not found");
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
-		goto failed;
-	}
 
-	dd = hci_open_dev(dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed");
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto failed;
-	}
+static DBusMessage* handle_dev_discover_service_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
 
-	if (hci_switch_role(dd, &bdaddr, role, 10000) < 0) {
-		syslog(LOG_ERR, "Switch role request failed");
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
+static DBusMessage* handle_dev_last_seen_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
 
-	reply = dbus_message_new_method_return(msg);
+static DBusMessage* handle_dev_last_used_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
 
-failed:
-	return reply;
+static DBusMessage* handle_dev_remote_alias_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
 }
 
-static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_dev_remote_name_req(DBusMessage *msg, void *data)
 {
 	DBusMessage *reply = NULL;
 	DBusMessage *signal = NULL;
@@ -1750,10 +1800,10 @@
 
 		reply = dbus_message_new_method_return(msg);
 
-		snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, dbus_data->dev_id, BLUEZ_HCI);
+		snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, dbus_data->dev_id);
 
-		signal = dbus_message_new_signal(path, DEV_HCI_INTERFACE,
-							BLUEZ_HCI_REMOTE_NAME);
+		signal = dbus_message_new_signal(path, DEVICE_INTERFACE,
+							DEV_SIG_REMOTE_NAME);
 
 		dbus_message_append_args(signal,
 						DBUS_TYPE_STRING, &str_bdaddr,
@@ -1775,7 +1825,7 @@
 		if (dd < 0) {
 			syslog(LOG_ERR, "Unable to open device %d: %s (%d)",
 						dbus_data->dev_id, strerror(errno), errno);
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
 			goto failed;
 		}
 
@@ -1790,504 +1840,160 @@
 		rq.clen   = REMOTE_NAME_REQ_CP_SIZE;
 		rq.rparam = &rp;
 		rq.rlen   = EVT_CMD_STATUS_SIZE;
-		rq.event  = EVT_CMD_STATUS;
-
-		if (hci_send_req(dd, &rq, 100) < 0) {
-			syslog(LOG_ERR, "Unable to send remote name request: %s (%d)",
-						strerror(errno), errno);
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
-			goto failed;
-		}
-
-		if (rp.status) {
-			syslog(LOG_ERR, "Remote name request failed");
-			reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET | rp.status);
-			goto failed;
-		}
-	}
-
-	reply = dbus_message_new_method_return(msg);
-failed:
-	if (dd >= 0)
-		hci_close_dev(dd);
-
-	return reply;
-}
-
-static DBusMessage* handle_display_conn_req(DBusMessage *msg, void *data)
-{
-	struct hci_conn_list_req *cl = NULL;
-	struct hci_conn_info *ci = NULL;
-	DBusMessage *reply = NULL;
-	DBusMessageIter iter;
-	DBusMessageIter array_iter;
-	DBusMessageIter  struct_iter;
-	char addr[18];
-	const char array_sig[] = HCI_CONN_INFO_STRUCT_SIGNATURE;
-	const char *paddr = addr;
-	struct hci_dbus_data *dbus_data = data;
-	int sk = -1;
-	int i;
-
-	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (sk < 0) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	cl = malloc(MAX_CONN_NUMBER * sizeof(*ci) + sizeof(*cl));
-	if (!cl) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
-		goto failed;
-	}
-
-	cl->dev_id = dbus_data->dev_id;
-	cl->conn_num = MAX_CONN_NUMBER;
-	ci = cl->conn_info;
-
-	if (ioctl(sk, HCIGETCONNLIST, (void *) cl) < 0) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	reply = dbus_message_new_method_return(msg);
-	if (reply == NULL) {
-		syslog(LOG_ERR, "Out of memory while calling dbus_message_new_method_return");
-		goto failed;
-	}
-
-	dbus_message_iter_init_append(reply, &iter);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
-
-	for (i = 0; i < cl->conn_num; i++, ci++) {
-		ba2str(&ci->bdaddr, addr);
-
-		dbus_message_iter_open_container(&array_iter, DBUS_TYPE_STRUCT, NULL, &struct_iter);
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT16 ,&(ci->handle));
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING ,&paddr);
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_BYTE ,&(ci->type));
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_BYTE ,&(ci->out));
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT16 ,&(ci->state));
-		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT32 ,&(ci->link_mode));
-		dbus_message_iter_close_container(&array_iter, &struct_iter);
-	}
-
-	dbus_message_iter_close_container(&iter, &array_iter);
-
-failed:
-	if (sk >= 0)
-		close(sk);
-
-	if (cl)
-		free(cl);
-
-	return reply;
-}
-
-static DBusMessage* handle_auth_req(DBusMessage *msg, void *data)
-{
-	struct hci_request rq;
-	auth_requested_cp cp;
-	evt_cmd_status rp;
-	DBusMessage *reply = NULL;
-	char *str_bdaddr = NULL;
-	struct hci_dbus_data *dbus_data = data;
-	struct hci_conn_info_req *cr = NULL;
-	bdaddr_t bdaddr;
-	int dev_id = -1;
-	int dd = -1;
-
-	dbus_message_get_args(msg, NULL,
-					DBUS_TYPE_STRING, &str_bdaddr,
-					DBUS_TYPE_INVALID);
-
-	str2ba(str_bdaddr, &bdaddr);
-
-	dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
-
-	if (dev_id < 0) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
-		goto failed;
-	}
-
-	if (dbus_data->dev_id != dev_id) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
-		goto failed;
-	}
-
-	dd = hci_open_dev(dev_id);
-	if (dd < 0) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto failed;
-	}
-
-	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
-	if (!cr) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
-		goto failed;
-	}
-
-	bacpy(&cr->bdaddr, &bdaddr);
-	cr->type = ACL_LINK;
-
-	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	memset(&cp, 0, sizeof(cp));
-	cp.handle = cr->conn_info->handle;
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_AUTH_REQUESTED;
-	rq.cparam = &cp;
-	rq.clen   = AUTH_REQUESTED_CP_SIZE;
-	rq.rparam = &rp;
-	rq.rlen   = EVT_CMD_STATUS_SIZE;
-	rq.event  = EVT_CMD_STATUS;
-
-	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Unable to send authentication request: %s (%d)",
-							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	reply = dbus_message_new_method_return(msg);
-
-failed:
-	if (dd >= 0)
-		close(dd);
-
-	if (cr)
-		free(cr);
-
-	return reply;
-}
-
-/*****************************************************************
- *  
- *  Section reserved to local device configuration D-Bus Services
- *  
- *****************************************************************/
-static DBusMessage* handle_device_up_req(DBusMessage *msg, void *data)
-{
-	DBusMessage *reply = NULL;
-	struct hci_dbus_data *dbus_data = data;
-	int sk = -1;
-
-	/* Create and bind HCI socket */
-	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (sk < 0) {
-		syslog(LOG_ERR, "Can't open HCI socket: %s (%d)",
-							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	if (ioctl(sk, HCIDEVUP, dbus_data->dev_id) < 0 && errno != EALREADY) {
-		syslog(LOG_ERR, "Can't init device hci%d: %s (%d)",
-					dbus_data->dev_id, strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	reply = dbus_message_new_method_return(msg);
-
-failed:
-	if (sk >= 0)
-		close(sk);
-
-	return reply;
-}
-
-static DBusMessage* handle_device_down_req(DBusMessage *msg, void *data)
-{
-	DBusMessage *reply = NULL;
-	struct hci_dbus_data *dbus_data = data;
-	int sk = -1;
-
-	/* Create and bind HCI socket */
-	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (sk < 0) {
-		syslog(LOG_ERR, "Can't open HCI socket: %s (%d)",
-							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	if (ioctl(sk, HCIDEVDOWN, dbus_data->dev_id) < 0) {
-		syslog(LOG_ERR, "Can't down device hci%d: %s (%d)",
-					dbus_data->dev_id, strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	reply = dbus_message_new_method_return(msg);
-
-failed:
-	if (sk >= 0)
-		close(sk);
-
-	return reply;
-}
-
-static DBusMessage* handle_device_get_mode_req(DBusMessage *msg, void *data)
-{
-	const struct hci_dbus_data *dbus_data = data;
-	DBusMessage *reply = NULL;
-	const uint8_t hci_mode = dbus_data->path_data;
-	uint8_t scan_mode;
-
-	switch (hci_mode) {
-	case SCAN_DISABLED:
-		scan_mode = MODE_OFF;
-		break;
-	case SCAN_PAGE:
-		scan_mode = MODE_CONNECTABLE;
-		break;
-	case (SCAN_PAGE | SCAN_INQUIRY):
-		scan_mode = MODE_DISCOVERABLE;
-		break;
-	case SCAN_INQUIRY:
-	/* inquiry scan mode is not handled, return 0xff */
-	default:
-		/* reserved */
-		scan_mode = 0xff;
-	}
-
-	reply = dbus_message_new_method_return(msg);
-
-	dbus_message_append_args(reply,
-					DBUS_TYPE_BYTE, &scan_mode,
-					DBUS_TYPE_INVALID);
-
-	return reply;
-}
-
-static DBusMessage* handle_device_set_mode_req(DBusMessage *msg, void *data)
-{
-	const struct hci_dbus_data *dbus_data = data;
-	DBusMessage *reply = NULL;
-	struct hci_request rq;
-	int dd = -1;
-	const uint8_t scan_mode;
-	uint8_t hci_mode;
-	uint8_t status = 0;
-	const uint8_t current_mode = dbus_data->path_data;
-
-	dbus_message_get_args(msg, NULL,
-					DBUS_TYPE_BYTE, &scan_mode,
-					DBUS_TYPE_INVALID);
-
-	switch (scan_mode) {
-	case MODE_OFF:
-		hci_mode = SCAN_DISABLED;
-		break;
-	case MODE_CONNECTABLE:
-		hci_mode = SCAN_PAGE;
-		break;
-	case MODE_DISCOVERABLE:
-		hci_mode = (SCAN_PAGE | SCAN_INQUIRY);
-		break;
-	default:
-		/* invalid mode */
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
-		goto failed;
-	}
-
-	dd = hci_open_dev(dbus_data->dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto failed;
-	}
-
-	/* Check if the new requested mode is different from the current */
-	if (current_mode != hci_mode) {
-		memset(&rq, 0, sizeof(rq));
-		rq.ogf    = OGF_HOST_CTL;
-		rq.ocf    = OCF_WRITE_SCAN_ENABLE;
-		rq.cparam = &hci_mode;
-		rq.clen   = sizeof(hci_mode);
-		rq.rparam = &status;
-		rq.rlen   = sizeof(status);
+		rq.event  = EVT_CMD_STATUS;
 
 		if (hci_send_req(dd, &rq, 100) < 0) {
-			syslog(LOG_ERR, "Sending write scan enable command failed: %s (%d)",
-							strerror(errno), errno);
+			syslog(LOG_ERR, "Unable to send remote name request: %s (%d)",
+						strerror(errno), errno);
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
 			goto failed;
 		}
-		if (status) {
-			syslog(LOG_ERR, "Setting scan enable failed with status 0x%02x", status);
-			reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET | status);
+
+		if (rp.status) {
+			syslog(LOG_ERR, "Remote name request failed");
+			reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET | rp.status);
 			goto failed;
 		}
-
 	}
 
 	reply = dbus_message_new_method_return(msg);
-
 failed:
 	if (dd >= 0)
-		close(dd);
+		hci_close_dev(dd);
 
 	return reply;
 }
 
-static DBusMessage* handle_device_set_property_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_dev_remote_version_req(DBusMessage *msg, void *data)
 {
-	const struct service_data *handlers = set_property_services;
-	DBusMessageIter iter;
-	DBusMessage *reply = NULL;
-	const char *signature;
-	char *str_name;
-	uint32_t error = BLUEZ_EDBUS_WRONG_PARAM;
-
-	signature = dbus_message_get_signature(msg);
-
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_get_basic(&iter, &str_name);
-
-	for (; handlers->name != NULL; handlers++) {
-		if (strcasecmp(handlers->name, str_name))
-			continue;
-
-		if (strcmp(handlers->signature, signature) == 0) {
-			reply = handlers->handler_func(msg, data);
-			error = 0;
-			break;
-		} else {
-			error = BLUEZ_EDBUS_WRONG_SIGNATURE;
-			break;
-		}
-	}
-
-	if (error)
-		reply = bluez_new_failure_msg(msg, error);
-
-	return reply;
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
 }
 
-static DBusMessage* handle_device_get_property_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_dev_create_bonding_req(DBusMessage *msg, void *data)
 {
-	const struct service_data *handlers = get_property_services;
-	DBusMessageIter iter;
+	struct hci_request rq;
+	auth_requested_cp cp;
+	evt_cmd_status rp;
 	DBusMessage *reply = NULL;
-	char *str_name;
-	uint32_t error = BLUEZ_EDBUS_WRONG_PARAM;
-
-
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_get_basic(&iter, &str_name);
-
-	for (; handlers->name != NULL; handlers++) {
-		if (!strcasecmp(handlers->name, str_name)) {
-			reply = handlers->handler_func(msg, data);
-			error = 0;
-			break;
-		}
-	}
-
-	if (error)
-		reply = bluez_new_failure_msg(msg, error);
+	char *str_bdaddr = NULL;
+	struct hci_dbus_data *dbus_data = data;
+	struct hci_conn_info_req *cr = NULL;
+	bdaddr_t bdaddr;
+	int dev_id = -1;
+	int dd = -1;
 
-	return reply;
-}
+	dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_STRING, &str_bdaddr,
+					DBUS_TYPE_INVALID);
 
-static void send_property_changed_signal(const int devid, const char *prop_name, const int prop_type, void *value)
-{
-	DBusMessage *message = NULL;
-	char path[MAX_PATH_LENGTH];
+	str2ba(str_bdaddr, &bdaddr);
 
-	snprintf(path, sizeof(path)-1, "%s/hci%d", DEVICE_PATH, devid);
-	path[MAX_PATH_LENGTH-1]='\0';
+	dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
 
-	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
-						BLUEZ_HCI_PROPERTY_CHANGED);
-	if (message == NULL) {
-		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
+	if (dev_id < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
 		goto failed;
 	}
 
-	dbus_message_append_args(message,
-				DBUS_TYPE_STRING, &prop_name,
-				prop_type, value,
-				DBUS_TYPE_INVALID);
-
-	if (dbus_connection_send(connection, message, NULL) == FALSE) {
-		syslog(LOG_ERR, "Can't send D-BUS PropertChanged(%s) signal", prop_name);
+	if (dbus_data->dev_id != dev_id) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
 		goto failed;
 	}
 
-failed:
-	if (message)
-		dbus_message_unref(message);
-}
-
-static DBusMessage* handle_device_set_property_req_name(DBusMessage *msg, void *data)
-{
-	struct hci_dbus_data *dbus_data = data;
-	DBusMessageIter iter;
-	DBusMessage *reply = NULL;
-	char *str_name;
-	int dd = -1;
-	uint8_t status;
-	change_local_name_cp cp;
-	struct hci_request rq;
-
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_get_basic(&iter, &str_name);
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
 
-	if (strlen(str_name) == 0) {
-		syslog(LOG_ERR, "HCI change name failed - Invalid Name!");
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
+	if (!cr) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
 		goto failed;
 	}
 
-	dd = hci_open_dev(dbus_data->dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+	bacpy(&cr->bdaddr, &bdaddr);
+	cr->type = ACL_LINK;
+
+	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cr->conn_info->handle;
+
 	memset(&rq, 0, sizeof(rq));
-	strncpy((char *) cp.name, str_name, sizeof(cp.name));
-	rq.ogf    = OGF_HOST_CTL;
-	rq.ocf    = OCF_CHANGE_LOCAL_NAME;
+	rq.ogf    = OGF_LINK_CTL;
+	rq.ocf    = OCF_AUTH_REQUESTED;
 	rq.cparam = &cp;
-	rq.clen   = CHANGE_LOCAL_NAME_CP_SIZE;
-	rq.rparam = &status;
-	rq.rlen   = sizeof(status);
+	rq.clen   = AUTH_REQUESTED_CP_SIZE;
+	rq.rparam = &rp;
+	rq.rlen   = EVT_CMD_STATUS_SIZE;
+	rq.event  = EVT_CMD_STATUS;
 
 	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Sending change name command failed: %s (%d)",
+		syslog(LOG_ERR, "Unable to send authentication request: %s (%d)",
 							strerror(errno), errno);
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
 	}
 
-	if (status) {
-		syslog(LOG_ERR, "Setting name failed with status 0x%02x", status);
-		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + status);
-		goto failed;
-	}
-
 	reply = dbus_message_new_method_return(msg);
 
 failed:
 	if (dd >= 0)
 		close(dd);
 
+	if (cr)
+		free(cr);
+
 	return reply;
 }
 
+static DBusMessage* handle_dev_list_bondings_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+
+
+
+static DBusMessage* handle_dev_has_bonding_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+
+static DBusMessage* handle_dev_remove_bonding_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+
+
+static DBusMessage* handle_dev_pin_code_length_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+
+static DBusMessage* handle_dev_encryption_key_size_req(DBusMessage *msg, void *data)
+{
+	/*FIXME: */
+	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+}
+
+
+/*****************************************************************
+ *  
+ *  Section reserved to device HCI callbacks
+ *  
+ *****************************************************************/
 void hcid_dbus_setname_complete(bdaddr_t *local)
 {
+	DBusMessage *signal = NULL;
 	char *local_addr;
 	bdaddr_t tmp;
 	int id;
@@ -2335,73 +2041,25 @@
 	name[248] = '\0';
 	pname = name;
 
-	send_property_changed_signal(id, DEV_PROPERTY_NAME, DBUS_TYPE_STRING, &pname);
-	dbus_connection_flush(connection);
-
-failed:
-	if (dd >= 0)
-		close(dd);
-
-	bt_free(local_addr);
-}
-
-static DBusMessage* handle_device_get_property_req_name(DBusMessage *msg, void *data)
-{
-	struct hci_dbus_data *dbus_data = data;
-	DBusMessage *reply = NULL;
-	int dd = -1;
-	read_local_name_rp rp;
-	struct hci_request rq;
-	const char *pname = (char*) rp.name;
-	char name[249];
-
-	dd = hci_open_dev(dbus_data->dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto failed;
-	}
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_HOST_CTL;
-	rq.ocf    = OCF_READ_LOCAL_NAME;
-	rq.rparam = &rp;
-	rq.rlen   = READ_LOCAL_NAME_RP_SIZE;
-
-	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Sending getting name command failed: %s (%d)",
-							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
-	}
-
-	if (rp.status) {
-		syslog(LOG_ERR, "Getting name failed with status 0x%02x", rp.status);
-		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + rp.status);
-		goto failed;
-	}
-
-	reply = dbus_message_new_method_return(msg);
-	if (reply == NULL) {
-		syslog(LOG_ERR, "Out of memory while calling dbus_message_new_method_return");
+	signal = dev_signal_factory(id, DEV_SIG_NAME_CHANGED, DBUS_TYPE_STRING, &pname, DBUS_TYPE_INVALID);
+	if (dbus_connection_send(connection, signal, NULL) == FALSE) {
+		syslog(LOG_ERR, "Can't send D-BUS %s signal", DEV_SIG_NAME_CHANGED);
 		goto failed;
 	}
 
-	strncpy(name,pname,sizeof(name)-1);
-	name[248]='\0';
-	pname = name;
-
-	dbus_message_append_args(reply,
-				DBUS_TYPE_STRING, &pname,
-				DBUS_TYPE_INVALID);
+	dbus_connection_flush(connection);
 
 failed:
+	if (signal)
+		dbus_message_unref(signal);
+
 	if (dd >= 0)
 		close(dd);
 
-	return reply;
+	bt_free(local_addr);
 }
 
+
 void hcid_dbus_setscan_enable_complete(bdaddr_t *local)
 {
 	DBusMessage *message = NULL;
@@ -2475,7 +2133,7 @@
 	}
 
 	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
-						BLUEZ_HCI_SCAN_MODE_CHANGED);
+						DEV_SIG_MODE_CHANGED);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
 		goto failed;
@@ -2503,8 +2161,13 @@
 
 	bt_free(local_addr);
 }
-
-static DBusMessage* handle_device_list_req(DBusMessage *msg, void *data)
+ 
+/*****************************************************************
+ *  
+ *  Section reserved to Manager D-Bus services implementation
+ *  
+ *****************************************************************/
+static DBusMessage* handle_mgr_device_list_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;
 	DBusMessageIter array_iter;
@@ -2513,7 +2176,7 @@
 	struct hci_dev_req *dr      = NULL;
 	int sk = -1;
 	int i;
-	const char array_sig[] = MGR_GET_DEV_REPLY_STRUCT_SIGNATURE;
+	const char array_sig[] = MGR_REPLY_DEVICE_LIST_STRUCT_SIGNATURE;
 
 	/* Create and bind HCI socket */
 	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
@@ -2610,12 +2273,7 @@
 	return reply;
 }
 
-/*****************************************************************
- *  
- *  Section reserved to Manager D-Bus services
- *  
- *****************************************************************/
-static DBusMessage* handle_default_device_req(DBusMessage *msg, void *data)
+static DBusMessage* handle_mgr_default_device_req(DBusMessage *msg, void *data)
 {
 	char path[MAX_PATH_LENGTH];
 	char *pptr = path;
@@ -2641,14 +2299,3 @@
 	return reply;
 }
 
-static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data)
-{
-	const char *path = dbus_message_get_path(msg);
-	const char *iface = dbus_message_get_interface(msg);
-	const char *method = dbus_message_get_member(msg);
-
-	syslog(LOG_INFO, "Not Implemented - path %s iface %s method %s",
-							path, iface, method);
-
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
-}

------=_Part_12918_24845645.1139597600823--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
