Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1F3BF694
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150640; cv=none; b=djq+m/owzTsQsWpvpssnyysVx1kTF18lMdvSOnwWxFsEL3Ahmnf448/OIZ/LuwvkaJxPKYlXz8bgwb8v4AhTjRqLTgQXipasEVnZXYkvWDDmr6wG17ms6HfsZvyYK/ymJt5A4vGL4NCYJmUlJ1EXhvx/umtRQ3pFFnezktUdwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150640; c=relaxed/simple;
	bh=4iiR96Az290a6tIGBmKOMcH5ExE/9/axIEt9hkYPScc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCGF8r/I4XWVwm7vqyeDgaNO+Yeg6PGsIi+cGi3ej6ZJepcF5jaiQ5Pql8MOu7ll3/ND5uTYf0S106Tj2rw1YX+u+g2C2qZoVaVPjKAZBO3LnN2ZErjX/jWLjIEDQxcm31W5TObM0jfV1PF1aG+0KR/6jlB13cL2Pzad1Znr9xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q1/Xc1aF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q1/Xc1aF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787150629;
	bh=4iiR96Az290a6tIGBmKOMcH5ExE/9/axIEt9hkYPScc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q1/Xc1aFFrlhU8FyzaXN/3ZNdXB7bKknTm2w6RNLQ4TRIypmK8LFFh0jH2deA0fo2
	 78RgEvS2isHRZVHbnVwcuMgRrelocNl92jgnbdCCljrLSM4dVNmUIzkp4lt2tnjYDF
	 3LTIml2j6nIq7QR7D97tL2Ft2zlW7bUUWb9fo1CN/IDUZwGLwB7MM0PsyNWadSHCIa
	 ++WHV8g0HlnuH+qEa81qqiV1P7j9gd/mwM59QDXgEZHMizwxJz4KXgJvlmtJECT41m
	 TFZbcWuYFlFtmUFC7PAPzGkJ6suXLwlob/Sox75SQE5UHzaIxSDwXmN9gHwEJcb6Rp
	 3Xmh6ZrE4/0sw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E4E0917E0FEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:43:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 7/7] profiles/audio: make A2DP admin allowlist enforcement role-safe
Date: Wed, 19 Aug 2026 16:43:37 +0200
Message-ID: <20260819144337.889893-8-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819144337.889893-1-frederic.danis@collabora.com>
References: <20260819144337.889893-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Unify audio-side allowlist enforcement so A2DP behavior remains correct
across dynamic policy updates, reconnects, and role-specific endpoint
negotiation.

Why:
- Dynamic allowlist reapply could leave stale A2DP role state and dangling
  role lists, leading to invalid reuse and instability during subsequent
  signaling/SEP handling.
- Policy enforcement happening late (at SetConfiguration time) allowed
  blocked roles to remain visible during capability negotiation, which caused
  retry/disconnect behavior until session managers were restarted.

What changed:
- Harden A2DP server role removal bookkeeping:
  - clear source_enabled/sink_enabled flags on remove
  - clear server->sources/server->sinks list heads after free
  - unregister shared server only when both roles are disabled
- Enforce admin policy at SEP negotiation boundaries:
  - add role-aware helper mapping local SEP type to policy UUID
  - reject blocked roles in Get_Capability path
  - reject blocked roles early in Set_Configuration path
- Keep endpoint registration resilient when partial allowlists block specific
  A2DP records, so allowed endpoints continue to register.

Result:
- A2DP policy decisions are consistent with local role semantics.
- Blocked roles are filtered earlier and more predictably.
- Runtime policy transitions are stable, without requiring daemon/session
  manager restarts to recover expected reconnect behavior.

Assisted-by: GPT:GPT-5.3-Codex
---
 profiles/audio/a2dp.c  | 38 ++++++++++++++++++++++++++++++++++----
 profiles/audio/media.c |  7 +++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a4ba1dacf..0d4b8cc32 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -811,6 +811,20 @@ static void reverse_discover(struct avdtp *session, GSList *seps, int err,
 	DBG("err %d", err);
 }
 
+static bool a2dp_sep_policy_allowed(struct avdtp *session,
+					const struct a2dp_sep *sep)
+{
+	struct btd_adapter *adapter = avdtp_get_adapter(session);
+	const char *uuid;
+
+	if (sep->type == AVDTP_SEP_TYPE_SOURCE)
+		uuid = A2DP_SOURCE_UUID;
+	else
+		uuid = A2DP_SINK_UUID;
+
+	return btd_adapter_is_uuid_allowed(adapter, uuid);
+}
+
 static gboolean endpoint_setconf_ind(struct avdtp *session,
 						struct avdtp_local_sep *sep,
 						struct avdtp_stream *stream,
@@ -827,6 +841,9 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 	else
 		DBG("Source %p: Set_Configuration_Ind", sep);
 
+	if (!a2dp_sep_policy_allowed(session, a2dp_sep))
+		return FALSE;
+
 	a2dp_stream = a2dp_stream_get(a2dp_sep, session);
 	if (!a2dp_stream)
 		return FALSE;
@@ -905,6 +922,11 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
 	else
 		DBG("Source %p: Get_Capability_Ind", sep);
 
+	if (!a2dp_sep_policy_allowed(session, a2dp_sep)) {
+		*err = AVDTP_BAD_ACP_SEID;
+		return FALSE;
+	}
+
 	*caps = NULL;
 
 	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
@@ -2858,6 +2880,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	GSList **l;
 	uint32_t *record_id;
 	sdp_record_t *record;
+	int ret;
 
 	server = find_server(servers, adapter);
 	if (server == NULL) {
@@ -2918,12 +2941,13 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 		return NULL;
 	}
 
-	if (adapter_service_add(server->adapter, record) < 0) {
+	ret = adapter_service_add(server->adapter, record);
+	if (ret < 0) {
 		error("Unable to register A2DP service record");
 		sdp_record_free(record);
 		a2dp_unregister_sep(sep);
 		if (err)
-			*err = -EINVAL;
+			*err = ret;
 		return NULL;
 	}
 
@@ -3687,8 +3711,11 @@ static void a2dp_source_server_remove(struct btd_profile *p,
 	if (!server)
 		return;
 
+	server->source_enabled = FALSE;
+
 	g_slist_free_full(server->sources,
 					(GDestroyNotify) a2dp_unregister_sep);
+	server->sources = NULL;
 
 	if (server->source_record_id) {
 		adapter_service_remove(server->adapter,
@@ -3696,7 +3723,7 @@ static void a2dp_source_server_remove(struct btd_profile *p,
 		server->source_record_id = 0;
 	}
 
-	if (server->sink_record_id)
+	if (server->sink_enabled)
 		return;
 
 	a2dp_server_unregister(server);
@@ -3734,14 +3761,17 @@ static void a2dp_sink_server_remove(struct btd_profile *p,
 	if (!server)
 		return;
 
+	server->sink_enabled = FALSE;
+
 	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
+	server->sinks = NULL;
 
 	if (server->sink_record_id) {
 		adapter_service_remove(server->adapter, server->sink_record_id);
 		server->sink_record_id = 0;
 	}
 
-	if (server->source_record_id)
+	if (server->source_enabled)
 		return;
 
 	a2dp_server_unregister(server);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 95f9580b0..26a6d7dea 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -3175,6 +3175,13 @@ static void app_register_endpoint(void *data, void *user_data)
 						metadata, metadata_size,
 						&features, &app->err);
 	if (!endpoint) {
+		if (app->err == -EPERM) {
+			info("Skipping endpoint %s:%s (%s) blocked by admin allowlist",
+				app->sender, path, uuid);
+			app->err = 0;
+			return;
+		}
+
 		error("Unable to register endpoint %s:%s: %s", app->sender,
 						path, strerror(-app->err));
 		return;
-- 
2.43.0

