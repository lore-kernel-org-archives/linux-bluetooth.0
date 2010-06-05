Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 2/3] Fix redundant null check on calling free()
Date: Sat,  5 Jun 2010 07:14:29 -0300
Message-Id: <1275732870-15889-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275732870-15889-2-git-send-email-gustavo@padovan.org>
References: <1275732870-15889-1-git-send-email-gustavo@padovan.org>
 <1275732870-15889-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issues found by smatch static check: http://smatch.sourceforge.net/
---
 input/device.c     |    6 +--
 lib/sdp.c          |   89 +++++++++++++++++----------------------------------
 src/sdp-xml.c      |    8 +---
 src/sdpd-request.c |   12 ++-----
 src/storage.c      |    6 +--
 test/ipctest.c     |    6 +--
 6 files changed, 42 insertions(+), 85 deletions(-)

diff --git a/input/device.c b/input/device.c
index 8daf8b2..f06b229 100644
--- a/input/device.c
+++ b/input/device.c
@@ -596,8 +596,7 @@ failed:
 	close(req->ctrl_sock);
 
 cleanup:
-	if (req->rd_data)
-		free(req->rd_data);
+	free(req->rd_data);
 
 	g_free(req);
 }
@@ -662,8 +661,7 @@ static int hidp_add_connection(const struct input_device *idev,
 	err = ioctl_connadd(req);
 
 cleanup:
-	if (req->rd_data)
-		free(req->rd_data);
+	free(req->rd_data);
 	g_free(req);
 
 	return err;
diff --git a/lib/sdp.c b/lib/sdp.c
index ca3b4c4..79f4ae5 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2915,11 +2915,8 @@ int sdp_device_record_register_binary(sdp_session_t *session, bdaddr_t *device,
 	}
 
 end:
-	if (req)
-		free(req);
-
-	if (rsp)
-		free(rsp);
+	free(req);
+	free(rsp);
 
 	return status;
 }
@@ -3025,11 +3022,8 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 		status = -1;
 	}
 end:
-	if (reqbuf)
-		free(reqbuf);
-
-	if (rspbuf)
-		free(rspbuf);
+	free(reqbuf);
+	free(rspbuf);
 
 	return status;
 }
@@ -3133,10 +3127,8 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 		status = -1;
 	}
 end:
-	if (reqbuf)
-		free(reqbuf);
-	if (rspbuf)
-		free(rspbuf);
+	free(reqbuf);
+	free(rspbuf);
 	return status;
 }
 
@@ -3472,10 +3464,8 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 	} while (cstate);
 
 end:
-	if (reqbuf)
-		free(reqbuf);
-	if (rspbuf)
-		free(rspbuf);
+	free(reqbuf);
+	free(rspbuf);
 
 	return status;
 }
@@ -3649,12 +3639,9 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 	}
 
 end:
-	if (reqbuf)
-		free(reqbuf);
-	if (rsp_concat_buf.data)
-		free(rsp_concat_buf.data);
-	if (rspbuf)
-		free(rspbuf);
+	free(reqbuf);
+	free(rsp_concat_buf.data);
+	free(rspbuf);
 	return rec;
 }
 
@@ -3777,9 +3764,8 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 
 	t = session->priv;
 
-	/* check if the buffer is already allocated */
-	if (t->rsp_concat_buf.data)
-		free(t->rsp_concat_buf.data);
+	/* clean possible allocated buffer */
+	free(t->rsp_concat_buf.data);
 	memset(&t->rsp_concat_buf, 0, sizeof(sdp_buf_t));
 
 	if (!t->reqbuf) {
@@ -3825,10 +3811,8 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 	return 0;
 end:
 
-	if (t->reqbuf) {
-		free(t->reqbuf);
-		t->reqbuf = NULL;
-	}
+	free(t->reqbuf);
+	t->reqbuf = NULL;
 
 	return -1;
 }
@@ -3881,9 +3865,8 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
 
 	t = session->priv;
 
-	/* check if the buffer is already allocated */
-	if (t->rsp_concat_buf.data)
-		free(t->rsp_concat_buf.data);
+	/* clean possible allocated buffer */
+	free(t->rsp_concat_buf.data);
 	memset(&t->rsp_concat_buf, 0, sizeof(sdp_buf_t));
 
 	if (!t->reqbuf) {
@@ -3939,10 +3922,8 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
 	return 0;
 end:
 
-	if (t->reqbuf) {
-		free(t->reqbuf);
-		t->reqbuf = NULL;
-	}
+	free(t->reqbuf);
+	t->reqbuf = NULL;
 
 	return -1;
 }
@@ -3996,9 +3977,8 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 
 	t = session->priv;
 
-	/* check if the buffer is already allocated */
-	if (t->rsp_concat_buf.data)
-		free(t->rsp_concat_buf.data);
+	/* clean possible allocated buffer */
+	free(t->rsp_concat_buf.data);
 	memset(&t->rsp_concat_buf, 0, sizeof(sdp_buf_t));
 
 	if (!t->reqbuf) {
@@ -4058,10 +4038,8 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	return 0;
 end:
 
-	if (t->reqbuf) {
-		free(t->reqbuf);
-		t->reqbuf = NULL;
-	}
+	free(t->reqbuf);
+	t->reqbuf = NULL;
 
 	return -1;
 }
@@ -4286,8 +4264,7 @@ end:
 			t->cb(pdu_id, status, pdata, size, t->udata);
 	}
 
-	if (rspbuf)
-		free(rspbuf);
+	free(rspbuf);
 
 	return err;
 }
@@ -4521,12 +4498,9 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 		}
 	}
 end:
-	if (rsp_concat_buf.data)
-		free(rsp_concat_buf.data);
-	if (reqbuf)
-		free(reqbuf);
-	if (rspbuf)
-		free(rspbuf);
+	free(rsp_concat_buf.data);
+	free(reqbuf);
+	free(rspbuf);
 	return status;
 }
 
@@ -4557,11 +4531,9 @@ int sdp_close(sdp_session_t *session)
 	t = session->priv;
 
 	if (t) {
-		if (t->reqbuf)
-			free(t->reqbuf);
+		free(t->reqbuf);
 
-		if (t->rsp_concat_buf.data)
-			free(t->rsp_concat_buf.data);
+		free(t->rsp_concat_buf.data);
 
 		free(t);
 	}
@@ -4668,8 +4640,7 @@ fail:
 	err = errno;
 	if (session->sock >= 0)
 		close(session->sock);
-	if (session->priv)
-		free(session->priv);
+	free(session->priv);
 	free(session);
 	errno = err;
 
diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index fbe608c..4b0520d 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -728,12 +728,8 @@ void sdp_xml_data_free(struct sdp_xml_data *elem)
 	if (elem->data)
 		sdp_data_free(elem->data);
 
-	if (elem->name)
-		free(elem->name);
-
-	if (elem->text)
-
-		free(elem->text);
+	free(elem->name);
+	free(elem->text);
 	free(elem);
 }
 
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 8c88d6e..d56ffc2 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -526,8 +526,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 	}
 
 done:
-	if (cstate)
-		free(cstate);
+	free(cstate);
 	if (pattern)
 		sdp_list_free(pattern, free);
 
@@ -745,8 +744,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	buf->buf_size += sizeof(uint16_t);
 
 done:
-	if (cstate)
-		free(cstate);
+	free(cstate);
 	if (seq)
 		sdp_list_free(seq, free);
 	if (status)
@@ -929,10 +927,8 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	}
 
 done:
-	if (cstate)
-		free(cstate);
-	if (tmpbuf.data)
-		free(tmpbuf.data);
+	free(cstate);
+	free(tmpbuf.data);
 	if (pattern)
 		sdp_list_free(pattern, free);
 	if (seq)
diff --git a/src/storage.c b/src/storage.c
index ed1e5ec..07c1ac2 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -763,8 +763,7 @@ int write_trust(const char *src, const char *addr, const char *service,
 	/* If the old setting is the same as the requested one, we're done */
 	if (trusted == trust) {
 		g_slist_free(services);
-		if (str)
-			free(str);
+		free(str);
 		return 0;
 	}
 
@@ -784,8 +783,7 @@ int write_trust(const char *src, const char *addr, const char *service,
 
 	g_slist_free(services);
 
-	if (str)
-		free(str);
+	free(str);
 
 	return ret;
 }
diff --git a/test/ipctest.c b/test/ipctest.c
index 1a7543b..9fdfac4 100644
--- a/test/ipctest.c
+++ b/test/ipctest.c
@@ -1029,8 +1029,7 @@ static gboolean input_cb(GIOChannel *gin, GIOCondition condition, gpointer data)
 		if (sscanf(line, "%*s %as", &address) != 1)
 			DBG("set with bdaddr BDADDR");
 
-		if (u->address)
-			free(u->address);
+		free(u->address);
 
 		u->address = address;
 		DBG("bdaddr %s", u->address);
@@ -1049,8 +1048,7 @@ static gboolean input_cb(GIOChannel *gin, GIOCondition condition, gpointer data)
 			DBG("set with profile [hsp|a2dp]");
 		}
 
-		if (profile)
-			free(profile);
+		free(profile);
 		DBG("profile %s", u->transport == BT_CAPABILITIES_TRANSPORT_SCO ?
 			"hsp" : "a2dp");
 	}
-- 
1.7.1

