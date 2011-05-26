Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v2] Remove unnecessary jumps
Date: Thu, 26 May 2011 09:17:40 +0200
Message-Id: <1306394260-23293-1-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1306393705-12839-1-git-send-email-lkslawek@gmail.com>
References: <1306393705-12839-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avdtp.c         |    9 ++++-----
 audio/ctl_bluetooth.c |    6 ++----
 audio/headset.c       |    3 +--
 tools/hciattach_ti.c  |    9 ++++-----
 tools/sdptool.c       |    3 +--
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index e6407bb..59c544f 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2239,22 +2239,22 @@ static uint16_t get_version(struct avdtp *session)
 
 	adapter = manager_find_adapter(&session->server->src);
 	if (!adapter)
-		goto done;
+		return ver;
 
 	ba2str(&session->dst, addr);
 	device = adapter_find_device(adapter, addr);
 	if (!device)
-		goto done;
+		return ver;
 
 	rec = btd_device_get_record(device, A2DP_SINK_UUID);
 	if (!rec)
 		rec = btd_device_get_record(device, A2DP_SOURCE_UUID);
 
 	if (!rec)
-		goto done;
+		return ver;
 
 	if (sdp_get_access_protos(rec, &protos) < 0)
-		goto done;
+		return ver;
 
 	proto_desc = sdp_get_proto_desc(protos, AVDTP_UUID);
 	if (proto_desc && proto_desc->dtd == SDP_UINT16)
@@ -2263,7 +2263,6 @@ static uint16_t get_version(struct avdtp *session)
 	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
 	sdp_list_free(protos, NULL);
 
-done:
 	return ver;
 }
 
diff --git a/audio/ctl_bluetooth.c b/audio/ctl_bluetooth.c
index 2981385..d941421 100644
--- a/audio/ctl_bluetooth.c
+++ b/audio/ctl_bluetooth.c
@@ -213,11 +213,9 @@ static int bluetooth_read_integer(snd_ctl_ext_t *ext, snd_ctl_ext_key_t key,
 	*value = 0;
 
 	ret = bluetooth_send_ctl(data, key, 0, rsp);
-	if (ret < 0)
-		goto done;
+	if (ret == 0)
+		*value = rsp->key;
 
-	*value = rsp->key;
-done:
 	return ret;
 }
 
diff --git a/audio/headset.c b/audio/headset.c
index 4540c34..e7a4ea4 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1771,7 +1771,7 @@ static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
 
 	if (ag.ring_timer) {
 		DBG("IndicateCall received when already indicating");
-		goto done;
+		return reply;
 	}
 
 	err = headset_send(hs, "\r\nRING\r\n");
@@ -1784,7 +1784,6 @@ static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
 	ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL, ring_timer_cb,
 						NULL);
 
-done:
 	return reply;
 }
 
diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index e107a65..6269181 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -119,7 +119,7 @@ static FILE *bts_load_script(const char* file_name, uint32_t* version)
 	fp = fopen(file_name, "rb");
 	if (!fp) {
 		perror("can't open firmware file");
-		goto out;
+		return NULL;
 	}
 
 	if (1 != fread(&header, sizeof(struct bts_header), 1, fp)) {
@@ -135,13 +135,12 @@ static FILE *bts_load_script(const char* file_name, uint32_t* version)
 	if (NULL != version)
 		*version = header.version;
 
-	goto out;
+	return fp;
 
 errclose:
 	fclose(fp);
-	fp = NULL;
-out:
-	return fp;
+
+	return NULL;
 }
 
 static unsigned long bts_fetch_action(FILE* fp, unsigned char* action_buf,
diff --git a/tools/sdptool.c b/tools/sdptool.c
index 140a46a..aea4954 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -4116,10 +4116,9 @@ static int cmd_records(int argc, char **argv)
 			context.handle = base[i] + n;
 			err = get_service(&bdaddr, &context, 1);
 			if (err < 0)
-				goto done;
+				return 0;
 		}
 
-done:
 	return 0;
 }
 
-- 
1.7.4.1

