Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Bharat Panda' <bharat.panda@samsung.com>,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>, cpgs@samsung.com
References: <000b01cfe94c$216de430$6449ac90$@samsung.com>
 <CABBYNZKPex1xe0yJQkfOopBWj3QRiwF4cQd=1Jxj=xOLV69QJw@mail.gmail.com>
In-reply-to: <CABBYNZKPex1xe0yJQkfOopBWj3QRiwF4cQd=1Jxj=xOLV69QJw@mail.gmail.com>
Subject: RE: Query regarding creation of multiple MAS Instance ID:
Date: Mon, 20 Oct 2014 18:29:31 +0530
Message-id: <000301cfec65$bdb08cf0$3911a6d0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Friday, October 17, 2014 5:11 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Bharat Panda; Dmitry Kasatkin;
> cpgs@samsung.com
> Subject: Re: Query regarding creation of multiple MAS Instance ID:
> 
> Hi,
> 
> On Thu, Oct 16, 2014 at 4:18 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Hi All,
> >
> > I am working on obexd MAP profile. Is it possible to create multiple
> > MAS Instance in bluez?
> > Because right now bluez has only one MAS Instance support (only one
> > MAS_UUID), which is advertised to MCE based on the XML format
> followed
> > in src/profile.c.
> > When I add one more record to MAS_RECORD XML format by changing the
> > value as 0x01, I am not able see two instances getting loaded.
> >                 <attribute id=\"0x0315\">                               \
> >                         <uint8 value=\"0x01\"/>                 \
> >                 </attribute>                                            \
> 
> How you are doing that? You should be able to call
> ProfileManager1.RegisterProfile if that is what you doing and it is not working
> perhaps we have a bug somewhere. Two very important things you need to
> check:
> 
> 1. It cannot use the same path for both instances 2. Each instance needs a
> different channel
> 
> So if you are register via XML you need to take care of those details, but
> perhaps you are using the default record by just providing the UUID, that
> probably will not work because apparently we have hardcoded the channel,
> if that is the case we should probably add a check if there is another instance
> already register and use a different channel/psm.
> 
> > Do we need to create one more UUID like OBEX_MAS1_UUID and
> > OBEX_MAS2_UUID to support multiple mas instances?
> > Or what could be the possible solutions?
> 
> Each instance has to have the service class set to MAS UUID, otherwise no
> one will be able to discover it.
> 
> >
> > Regards.
> > Gowtham Anandha Babu
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Luiz Augusto von Dentz

Here is what I did exactly after your comments, 

1) Based on the flag, I managed the two MAS Instances in bluetooth.c

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index cf326cc..3a0c022 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -50,6 +50,8 @@
 #define BT_RX_MTU 32767
 #define BT_TX_MTU 32767
 
+gboolean MAS = FALSE;
+
 struct bluetooth_profile {
 	struct obex_server *server;
 	struct obex_service_driver *driver;
@@ -269,7 +271,20 @@ static int register_profile(struct bluetooth_profile *profile)
 	char *xml;
 	int ret = 0;
 
-	profile->path = g_strconcat("/org/bluez/obex/", profile->uuid, NULL);
+
+	if(!g_ascii_strcasecmp(profile->uuid, OBEX_MAS_UUID))
+		if(!MAS) {
+			profile->path = g_strconcat("/org/bluez/obex/MAS1/", 
+							profile->uuid, NULL);
+			MAS = TRUE;
+		}
+		else
+			profile->path = g_strconcat("/org/bluez/obex/MAS2/", 
+							profile->uuid, NULL);
+	else
+		profile->path = g_strconcat("/org/bluez/obex/", profile->uuid, NULL);
+
 	g_strdelimit(profile->path, "-", '_');
 
 	if (!g_dbus_register_interface(connection, profile->path,
@@ -290,6 +305,10 @@ static int register_profile(struct bluetooth_profile *profile)
 
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
 							&profile->path);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
 							&profile->uuid);
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
@@ -346,7 +365,9 @@ static const char *service2uuid(uint16_t service)
 		return "00005005-0000-1000-8000-0002ee000001";
 	case OBEX_SYNCEVOLUTION:
 		return "00000002-0000-1000-8000-0002ee000002";
-	case OBEX_MAS:
+	case OBEX_MAS1:
+		return OBEX_MAS_UUID;
+	case OBEX_MAS2:
 		return OBEX_MAS_UUID;
 	case OBEX_MNS:
 		return OBEX_MNS_UUID;

2) Created one more MAS Instance in mas.c

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index fb97fe3..fb482e2 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -728,9 +728,9 @@ static int any_close(void *obj)
 	return 0;
 }
 
-static struct obex_service_driver mas = {
-	.name = "Message Access server",
-	.service = OBEX_MAS,
+static struct obex_service_driver mas1 = {
+	.name = "Message Access server 1",
+	.service = OBEX_MAS1,
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.connect = mas_connect,
@@ -740,6 +740,18 @@ static struct obex_service_driver mas = {
 	.disconnect = mas_disconnect,
 };
 
+static struct obex_service_driver mas2 = {
+        .name = "Message Access server 2",
+        .service = OBEX_MAS2,
+        .target = MAS_TARGET,
+        .target_size = TARGET_SIZE,
+        .connect = mas_connect,
+        .get = mas_get,
+        .put = mas_put,
+        .setpath = mas_setpath,
+        .disconnect = mas_disconnect,
+};
+
 static struct obex_mime_type_driver mime_map = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
@@ -838,10 +850,14 @@ static int mas_init(void)
 			goto failed;
 	}
 
-	err = obex_service_driver_register(&mas);
+	err = obex_service_driver_register(&mas1);
 	if (err < 0)
 		goto failed;
 
+	err = obex_service_driver_register(&mas2);
+	if(err < 0)
+		goto failed;
+
 	return 0;
 
 failed:
@@ -857,7 +873,8 @@ static void mas_exit(void)
 {
 	int i;
 
-	obex_service_driver_unregister(&mas);
+	obex_service_driver_unregister(&mas1);
+        	obex_service_driver_unregister(&mas2);
 
 	for (i = 0; map_drivers[i] != NULL; ++i)
 		obex_mime_type_driver_unregister(map_drivers[i]);
@@ -865,4 +882,5 @@ static void mas_exit(void)
 	messages_exit();
 }
 
-OBEX_PLUGIN_DEFINE(mas, mas_init, mas_exit)
+OBEX_PLUGIN_DEFINE(mas1, mas_init, mas_exit)
+OBEX_PLUGIN_DEFINE(mas2, mas_init, mas_exit)
diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
index 42c3c4d..59de70e 100644
--- a/obexd/src/obexd.h
+++ b/obexd/src/obexd.h
@@ -28,7 +28,8 @@
 #define OBEX_IRMC	(1 << 5)
 #define OBEX_PCSUITE	(1 << 6)
 #define OBEX_SYNCEVOLUTION	(1 << 7)
-#define OBEX_MAS	(1 << 8)
+#define OBEX_MAS1	(1 << 8)
+#define OBEX_MAS2	(1 << 10)
 #define OBEX_MNS	(1 << 9)
 
 gboolean plugin_init(const char *pattern, const char *exclude);

3) Assigned different channel and path for both instances 
4)Added one more SDP record (XML) in profile.c

diff --git a/src/profile.c b/src/profile.c
index 7aca3be..ab5b5c2 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -62,7 +62,8 @@
 #define HFP_AG_DEFAULT_CHANNEL	13
 #define SYNC_DEFAULT_CHANNEL	14
 #define PBAP_DEFAULT_CHANNEL	15
-#define MAS_DEFAULT_CHANNEL	16
+#define MAS1_DEFAULT_CHANNEL	16
+#define MAS2_DEFAULT_CHANNEL	18
 #define MNS_DEFAULT_CHANNEL	17
 
 #define BTD_PROFILE_PSM_AUTO	-1
@@ -395,7 +396,7 @@
 		</attribute>						\
 	</record>"
 
-#define MAS_RECORD							\
+#define MAS_RECORD1							\
 	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
 	<record>							\
 		<attribute id=\"0x0001\">				\
@@ -441,6 +442,52 @@
 		</attribute>						\
 	</record>"
 
+#define MAS_RECORD2							\
+	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
+	<record>							\
+		<attribute id=\"0x0001\">				\
+			<sequence>					\
+				<uuid value=\"0x1132\"/>		\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0004\">				\
+			<sequence>					\
+				<sequence>				\
+					<uuid value=\"0x0100\"/>	\
+				</sequence>				\
+				<sequence>				\
+					<uuid value=\"0x0003\"/>	\
+					<uint8 value=\"0x%02x\"/>	\
+				</sequence>				\
+				<sequence>				\
+					<uuid value=\"0x0008\"/>	\
+				</sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0005\">				\
+			<sequence>					\
+				<uuid value=\"0x1002\" />		\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0009\">				\
+			<sequence>					\
+				<sequence>				\
+					<uuid value=\"0x1134\"/>	\
+					<uint16 value=\"0x%04x\" />	\
+				</sequence>				\
+			</sequence>					\
+		</attribute>						\
+		<attribute id=\"0x0100\">				\
+			<text value=\"%s\"/>				\
+		</attribute>						\
+		<attribute id=\"0x0315\">				\
+			<uint8 value=\"0x01\"/>				\
+		</attribute>						\
+		<attribute id=\"0x0316\">				\
+			<uint8 value=\"0x0F\"/>				\
+		</attribute>						\
+	</record>"
+
 #define MNS_RECORD							\
 	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>			\
 	<record>							\
@@ -562,6 +609,8 @@
 
 struct ext_io;
 
+gboolean MAS = FALSE;
+
 struct ext_profile {
 	struct btd_profile p;
 
@@ -1734,10 +1787,17 @@ static char *get_pse_record(struct ext_profile *ext, struct ext_io *l2cap,
 								ext->name);
 }
 
-static char *get_mas_record(struct ext_profile *ext, struct ext_io *l2cap,
+static char *get_mas_record1(struct ext_profile *ext, struct ext_io *l2cap,
+							struct ext_io *rfcomm)
+{
+	return g_strdup_printf(MAS_RECORD1, rfcomm->chan, ext->version,
+								ext->name);
+}
+
+static char *get_mas_record2(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
-	return g_strdup_printf(MAS_RECORD, rfcomm->chan, ext->version,
+	return g_strdup_printf(MAS_RECORD2, rfcomm->chan, ext->version,
 								ext->name);
 }
 
@@ -1949,10 +2009,17 @@ static struct default_settings {
 		.version	= 0x0101,
 	}, {
 		.uuid		= OBEX_MAS_UUID,
-		.name		= "Message Access",
-		.channel	= MAS_DEFAULT_CHANNEL,
+		.name		= "Message Access 1",
+		.channel	= MAS1_DEFAULT_CHANNEL,
+		.authorize	= true,
+		.get_record	= get_mas_record1,
+		.version	= 0x0100
+	}, {
+		.uuid		= OBEX_MAS_UUID,
+		.name		= "Message Access 2",
+		.channel	= MAS2_DEFAULT_CHANNEL,
 		.authorize	= true,
-		.get_record	= get_mas_record,
+		.get_record	= get_mas_record2,
 		.version	= 0x0100
 	}, {
 		.uuid		= OBEX_MNS_UUID,
@@ -1981,8 +2048,21 @@ static void ext_set_defaults(struct ext_profile *ext)
 		struct default_settings *settings = &defaults[i];
 		const char *remote_uuid;
 
+		DBG("%s ==  %s",ext->uuid, settings->uuid);
+
 		if (strcasecmp(ext->uuid, settings->uuid) != 0)
 			continue;
+		
+		if(!strcasecmp(ext->uuid, OBEX_MAS_UUID))
+			if(MAS) {
+				MAS = 0;
+				continue;
+			}
+		
+		if(!strcasecmp(ext->uuid, OBEX_MAS_UUID))
+			MAS = TRUE;
+
+		DBG("MATCHED  %s ==  %s MAS = %d",ext->uuid, settings->uuid, MAS);
 
 		if (settings->remote_uuid)
 			remote_uuid = settings->remote_uuid;
@@ -2022,6 +2102,8 @@ static void ext_set_defaults(struct ext_profile *ext)
 
 		if (settings->name)
 			ext->name = g_strdup(settings->name);
+		
+		return;
 	}
 }


After this changes I am able to load the two MAS Instances successfully. Is it fine? What do you think?

Regards,
Gowtham Anandha Babu 

