Return-Path: <cyrus@holtmann.org>
Message-ID: <479F5488.8030107@access-company.com>
Date: Tue, 29 Jan 2008 17:30:00 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <479E2588.2010403@access-company.com>
In-Reply-To: <479E2588.2010403@access-company.com>
Content-Type: multipart/mixed; boundary="------------060304000005050007050309"
Subject: Re: [Bluez-devel] [patch] check connection before connecting
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

This is a multi-part message in MIME format.
--------------060304000005050007050309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,
>
> This patch checks that a device is already connected before trying to 
> connect. If no device is connected, opening the alsa plugin will fail 
> instead of forcing connection to default device (which is blocking).
> This behavior can be enabled or disabled thanks to an option in 
> .asoundrc.
Updated version, with the mods we talked about on #bluez.

pcm.bt {
   type bluetooth
   autoconnect "yes"
}

Frédéric



--------------060304000005050007050309
Content-Type: text/x-patch;
 name="autoconnect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autoconnect.patch"

diff --git a/audio/ipc.h b/audio/ipc.h
index 3768dcf..68509e1 100644
--- a/audio/ipc.h
+++ b/audio/ipc.h
@@ -117,10 +117,13 @@ typedef struct {
 #define BT_CAPABILITIES_ACCESS_MODE_WRITE	2
 #define BT_CAPABILITIES_ACCESS_MODE_READWRITE	3
 
+#define BT_CAPABILITIES_AUTOCONNECT	1
+
 struct bt_getcapabilities_req {
 	bt_audio_msg_header_t	h;
 	char			device[18];	/* Address of the remote Device */
 	uint8_t			transport;	/* Requested transport */
+	uint8_t			flags;		/* Requested flags */
 } __attribute__ ((packed));
 
 /* BT_GETCAPABILITIES_RSP */
diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index a04f18c..9a523d2 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -122,6 +122,7 @@ struct bluetooth_alsa_config {
 	int has_block_length;
 	uint8_t bitpool;		/* A2DP only */
 	int has_bitpool;
+	int autoconnect;
 };
 
 struct bluetooth_data {
@@ -1268,7 +1269,7 @@ static int bluetooth_parse_config(snd_config_t *conf,
 				struct bluetooth_alsa_config *bt_config)
 {
 	snd_config_iterator_t i, next;
-	const char *addr, *pref;
+	const char *addr, *pref, *autoconnect;
 	const char *mode, *allocation, *rate, *subbands, *blocks, *bitpool;
 
 	memset(bt_config, 0, sizeof(struct bluetooth_alsa_config));
@@ -1283,6 +1284,17 @@ static int bluetooth_parse_config(snd_config_t *conf,
 		if (strcmp(id, "comment") == 0 || strcmp(id, "type") == 0)
 			continue;
 
+		if (strcmp(id, "autoconnect") == 0) {
+			if (snd_config_get_string(n, &autoconnect) < 0) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+
+			if (strcmp(autoconnect, "yes") == 0)
+				bt_config->autoconnect = 1;
+			continue;
+		}
+
 		if (strcmp(id, "device") == 0 || strcmp(id, "bdaddr") == 0) {
 			if (snd_config_get_string(n, &addr) < 0) {
 				SNDERR("Invalid type for %s", id);
@@ -1514,6 +1526,9 @@ static int bluetooth_init(struct bluetooth_data *data, snd_pcm_stream_t stream,
 
 	memset(getcaps_req, 0, BT_AUDIO_IPC_PACKET_SIZE);
 	getcaps_req->h.msg_type = BT_GETCAPABILITIES_REQ;
+	getcaps_req->flags = 0;
+	if (alsa_conf->autoconnect)
+		getcaps_req->flags |= BT_CAPABILITIES_AUTOCONNECT;
 	strncpy(getcaps_req->device, alsa_conf->device, 18);
 	if (alsa_conf->has_transport)
 		getcaps_req->transport = alsa_conf->transport;
diff --git a/audio/unix.c b/audio/unix.c
index d71c420..934d534 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -779,6 +779,9 @@ static void handle_getcapabilities_req(struct unix_client *client,
 	if (!dev)
 		goto failed;
 
+	if (!req->flags & BT_CAPABILITIES_AUTOCONNECT)
+		goto failed;
+
 	start_discovery(dev, client);
 
 	return;

--------------060304000005050007050309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------060304000005050007050309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060304000005050007050309--
