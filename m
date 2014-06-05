Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] profiles: Fix crash due to NULL pointer access
Date: Thu, 05 Jun 2014 16:31:45 +0530
Message-id: <1401966105-31223-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

NULL pointer check is added after memory allocation
to prevent core dump due to NULL pointer access.

Signed-off-by: Bharat Panda <bharat.panda@samsung.com>
---
 profiles/audio/a2dp.c  |    8 ++++++++
 profiles/audio/avctp.c |    4 ++++
 profiles/audio/avdtp.c |   16 ++++++++++++++++
 profiles/health/hdp.c  |    4 +++-
 profiles/health/mcap.c |    2 ++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c9dac9a..580cb60 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -523,6 +523,8 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
 							a2dp_sep->user_data);
 
 	codec_caps = g_malloc0(sizeof(*codec_caps) + length);
+	if(!codec_caps)
+		return -ENOMEM;
 	codec_caps->media_type = AVDTP_MEDIA_TYPE_AUDIO;
 	codec_caps->media_codec_type = a2dp_sep->codec;
 	memcpy(codec_caps->data, capabilities, length);
@@ -1346,6 +1348,12 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 		goto done;
 	}
 
+	cap = g_malloc0(sizeof(*cap) + size);
+	if (!cap) {
+		DBG("Failed to allocate memory");
+		return -ENOMEM;
+	}
+
 	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
 						NULL, 0);
 
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 74d3512..347bfb8 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1169,6 +1169,8 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 	browsing->imtu = imtu;
 	browsing->omtu = omtu;
 	browsing->buffer = g_malloc0(MAX(imtu, omtu));
+	if (!browsing->buffer)
+		goto fail;
 	browsing->watch = g_io_add_watch(session->browsing->io,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) session_browsing_cb, session);
@@ -1223,6 +1225,8 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	session->control->imtu = imtu;
 	session->control->omtu = omtu;
 	session->control->buffer = g_malloc0(MAX(imtu, omtu));
+	if (!session->control->buffer)
+		return -ENOMEM;
 	session->control->watch = g_io_add_watch(session->control->io,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) session_cb, session);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 8a7d1c0..989d5c4 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1301,6 +1301,10 @@ static GSList *caps_to_list(uint8_t *data, int size,
 
 		cap = g_malloc(sizeof(struct avdtp_service_capability) +
 					length);
+		if (!cap) {
+			error("Memory allocation failed");
+			return NULL;
+		}
 		memcpy(cap, data, 2 + length);
 
 		processed += 2 + length;
@@ -2378,6 +2382,10 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		DBG("AVDTP imtu=%u, omtu=%u", session->imtu, session->omtu);
 
 		session->buf = g_malloc0(MAX(session->imtu, session->omtu));
+		if (!session->buf) {
+			DBG("Buffer allocation failed");
+			goto failed;
+		}
 		avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTED);
 
 		if (session->io_id)
@@ -2733,6 +2741,8 @@ static int send_request(struct avdtp *session, gboolean priority,
 	req = g_new0(struct pending_req, 1);
 	req->signal_id = signal_id;
 	req->data = g_malloc(size);
+	if (!req->data)
+		return -ENOMEM;
 	memcpy(req->data, buffer, size);
 	req->data_size = size;
 	req->stream = stream;
@@ -3286,6 +3296,10 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 		return NULL;
 
 	cap = g_malloc(sizeof(struct avdtp_service_capability) + length);
+	if (!cap) {
+		DBG("Failed to allocate memory");
+		return NULL;
+	}
 	cap->category = category;
 	cap->length = length;
 	memcpy(cap->data, data, length);
@@ -3445,6 +3459,8 @@ int avdtp_set_configuration(struct avdtp *session,
 	}
 
 	req = g_malloc0(sizeof(struct setconf_req) + caps_len);
+	if (!req)
+		return -ENOMEM;
 
 	req->int_seid = lsep->info.seid;
 	req->acp_seid = rsep->seid;
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 48dad52..6faf048 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1470,12 +1470,14 @@ static void destroy_create_dc_data(gpointer data)
 	hdp_create_data_unref(dc_data);
 }
 
-static void *generate_echo_packet(void)
+static uint8_t *generate_echo_packet(void)
 {
 	uint8_t *buf;
 	int i;
 
 	buf = g_malloc(HDP_ECHO_LEN);
+	if (!buf)
+		return -ENOMEM;
 	srand(time(NULL));
 
 	for(i = 0; i < HDP_ECHO_LEN; i++)
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 102ec85..bb30875 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -361,6 +361,8 @@ static int mcap_send_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 	sock = g_io_channel_unix_get_fd(mcl->cc);
 
 	cmd = g_malloc(sizeof(mcap_rsp) + len);
+	if (!cmd)
+		return -ENOMEM;
 	cmd->op = oc;
 	cmd->rc = rc;
 	cmd->mdl = htons(mdl);
-- 
1.7.9.5

