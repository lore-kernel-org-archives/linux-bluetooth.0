Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] profiles: Fix crash due to invalid param
Date: Fri, 06 Jun 2014 17:05:06 +0530
Message-id: <1402054506-8807-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check if the size parameter passed to g_malloc/g_malloc0
are non-zero. In case of invalid size allocation it returns
NULL and aborts.

Signed-off-by: Bharat Panda <bharat.panda@samsung.com>
---
 profiles/audio/a2dp.c  |    7 ++++++-
 profiles/audio/avdtp.c |   10 ++++++++++
 profiles/health/hdp.c  |    4 +++-
 profiles/health/mcap.c |    2 ++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c9dac9a..eb38e95 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -522,6 +522,8 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
 	length = a2dp_sep->endpoint->get_capabilities(a2dp_sep, &capabilities,
 							a2dp_sep->user_data);
 
+	if(!(sizeof(*codec_caps) + length))
+		return -EINVAL;
 	codec_caps = g_malloc0(sizeof(*codec_caps) + length);
 	codec_caps->media_type = AVDTP_MEDIA_TYPE_AUDIO;
 	codec_caps->media_codec_type = a2dp_sep->codec;
@@ -1346,12 +1348,15 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 		goto done;
 	}
 
+	if (!(sizeof(*cap) + size))
+		return -EINVAL;
+	cap = g_malloc0(sizeof(*cap) + size);
+
 	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
 						NULL, 0);
 
 	setup->caps = g_slist_append(setup->caps, media_transport);
 
-	cap = g_malloc0(sizeof(*cap) + size);
 	cap->media_type = AVDTP_MEDIA_TYPE_AUDIO;
 	cap->media_codec_type = setup->sep->codec;
 	memcpy(cap->data, ret, size);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 8a7d1c0..88ea28b 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1299,6 +1299,10 @@ static GSList *caps_to_list(uint8_t *data, int size,
 			break;
 		}
 
+		if (!(sizeof(struct avdtp_service_capability) + length)) {
+			error("Memory allocation failed");
+			return NULL;
+		}
 		cap = g_malloc(sizeof(struct avdtp_service_capability) +
 					length);
 		memcpy(cap, data, 2 + length);
@@ -2732,6 +2736,8 @@ static int send_request(struct avdtp *session, gboolean priority,
 
 	req = g_new0(struct pending_req, 1);
 	req->signal_id = signal_id;
+	if (!size)
+		return -EINVAL;
 	req->data = g_malloc(size);
 	memcpy(req->data, buffer, size);
 	req->data_size = size;
@@ -3285,6 +3291,8 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 	if (category < AVDTP_MEDIA_TRANSPORT || category > AVDTP_DELAY_REPORTING)
 		return NULL;
 
+	if (!(sizeof(struct avdtp_service_capability) + length))
+		return NULL;
 	cap = g_malloc(sizeof(struct avdtp_service_capability) + length);
 	cap->category = category;
 	cap->length = length;
@@ -3444,6 +3452,8 @@ int avdtp_set_configuration(struct avdtp *session,
 		caps_len += cap->length + 2;
 	}
 
+	if (!(sizeof(struct setconf_req) + caps_len))
+		return -EINVAL;
 	req = g_malloc0(sizeof(struct setconf_req) + caps_len);
 
 	req->int_seid = lsep->info.seid;
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 48dad52..6745230 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1470,11 +1470,13 @@ static void destroy_create_dc_data(gpointer data)
 	hdp_create_data_unref(dc_data);
 }
 
-static void *generate_echo_packet(void)
+static uint8_t *generate_echo_packet(void)
 {
 	uint8_t *buf;
 	int i;
 
+	if(!HDP_ECHO_LEN)
+		return -EINVAL;
 	buf = g_malloc(HDP_ECHO_LEN);
 	srand(time(NULL));
 
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 102ec85..2a0969f 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -360,6 +360,8 @@ static int mcap_send_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 
 	sock = g_io_channel_unix_get_fd(mcl->cc);
 
+	if (!(sizeof(mcap_rsp) + len))
+		return -EINVAL;
 	cmd = g_malloc(sizeof(mcap_rsp) + len);
 	cmd->op = oc;
 	cmd->rc = rc;
-- 
1.7.9.5

