Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579551599D
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024519; cv=none; b=q/qowUB8ZtdViPyJkO0z20Y4ZU5JLMUPY/41pnigsOU01LZbMz+4/8vJBgXOL7KH25nUFK+MuEqHxA+zf+bPdX9nd2WDa634FsHQN9q04q74BONMXvah/HsoKC2EBFBc5uG7DiUxyqj6kOvM93oTiabj2PfjSLnlKpAE9Cz8Vg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024519; c=relaxed/simple;
	bh=2O8eleONipRqGE11jMHDLf9pJpK4Q/N+R7kS1Wqkkak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3d2yLo0Cj58o4qZSqelsD3M8PI5D/mIndGc8zTt+e7csFqYInlZnv7qd1ddnIcvrgfdaVFuY9VsLWz5I+KzvN9V80WJXi+aZxKzJey0RAuSt6RF17F5STiSRipRKGnkYk3KjF4SmjNwllssLPdNCKJQxGNMDxmpb8mIIaIWyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+Mdwy7a; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+Mdwy7a"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d4eb63f16so11951197b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024516; x=1790629316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=//v28d/5ze6BKBbAIPpH2GR+PljyoMJUFyW9zNGJrPw=;
        b=V+Mdwy7arR7xNcfGTOzqxYXC/MHGzClzeXlj3Hpmh6s1QuQzLRuX/DqA78Lr6XwR+m
         mIOS6EM7ao9P1trkkzmHfpEXr9wtly/kzU61T1DhTajfpp9pX4xIjs8NyEtmKcJqEyeI
         I4Yi7MhS3hUoX+W5lxtfm1voFKeZ7KkqKX8TGq3NSGuMWl8vCMwHdDfeVKHQ28gGofnO
         8xVoZLvq1C30TKJdf+NM223h/IM1DuYJfquf72PIBrZroPdTdR+w9OBgJjuMRv9ik7gG
         89ZAq8hywnwGyCRMrmye/LlxqSkqJ11AKeHB0a8AME3YmlWLSA6jheN8jILc0hGoe8P5
         w4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024516; x=1790629316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=//v28d/5ze6BKBbAIPpH2GR+PljyoMJUFyW9zNGJrPw=;
        b=mN5OulJjPb60LYePbwca30ysTuK2HUFOWnnaxW0s7/Sv7MYHbi9ABOAzRdpzpI1+bj
         s5st4YHqIGqdmLdWfv/R2qHdfkneFr6bVLLBcLjyi7j2TOUs0xNtOiFdiN8HKOSBitHH
         OxSwDfK6DN8XPLjqcx0qYy+T3kHib37eG0jcP5RRSVJHOgPRIpRk3mjx1muKMfpCAdh7
         4hyFKzYae0oR92X0F31TzocgdqhMcS3PFsMzN2QLE3UGcya23Pqj++BFqwcyzDPaUzay
         wY7RQICipwY/qDtpa6mzMRRoZwyqIogDhA9fTk88wJjGn/5WnpunW+f3W9slNmPxLWNr
         wXqw==
X-Gm-Message-State: AFuF++nppjn3Xql0V1OwUUa2xwScA5i0PWKc4bE5Fb7GAF55uyTvOnrA
	s6fU5PZ56aCproEn5l2F0NUZDN/UTwZCd+d469pcUflbQ59Xou0/NsVFrhsHbJNE
X-Gm-Gg: AYBFou1aCYriWJ6xzM/967jFf/Sxv6ypRbfKzxv2V1p3eIJXBg7i6RioLT+fy8rW/2M
	6i9X386ueQUB3L/nWO4zQ9vGo5F/B0i8d6qzFaxwrfH/by/p+0ASncli9Ha4gJ8q7qovpbrHHaf
	xK/+/swAp24q+SSnQ9B7QVfOOAELxtFnllfAPSQ7y0gxJdoOKafEz738af2oDSdLvAJuINn4kWV
	Oec14Xowl/9JAivqgoT017yil7IbY6cZdhCKbCSHpXTur4jEnbcgWBw0zC+0KbUa02QCfZX7iSq
	3k5PRawh2pCmr04LGG8OWk8KfPvKMZhDFcJkjJqpo0JJX7dSeRxUTGWZT0oOW/PfaHds51FfklB
	AZbcvkW2VLeo/WaPU0WwjoePb2hwA2FMosDF363JAzVOLnENb0qVjkz/6Z5Y/zIxmritowDlJ0N
	vUEnOwzbBejPgWIQwyTlojyZqZzNdxibIDwdmQnCqW+UNbrinc7e/2KqPYu1rFS5MdCvk3enyL5
	dzLLxND77Hk0VQ6HBNehTjq779bc0MqIkH/3wPWaeh8G1IhhQawNKaeo1AG5xbsovSucHVXcZ3t
X-Received: by 2002:a05:6122:2210:b0:5c9:a5be:7b4f with SMTP id 71dfb90a1353d-5c9e349e72dmr1298562e0c.6.1790024505763;
        Mon, 21 Sep 2026 14:01:45 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9850c318641sm83527241.9.2026.09.21.14.01.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:01:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/6] bass: keep the push target per MediaAssistant object
Date: Mon, 21 Sep 2026 17:01:21 -0400
Message-ID: <20260921210123.3690449-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921210123.3690449-1-luiz.dentz@gmail.com>
References: <20260921210123.3690449-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Every MediaAssistant object of a local broadcast shares the bass_data of
the adapter, and pushing one stored the session of the delegator it was
pushed to by overwriting the bass of that shared data.

With a single delegator this goes unnoticed, but with one delegator per
side of a true wireless pair the second push replaces the target of the
first one, so the Broadcast Code of a request coming from the first
delegator is written to the second one, and the first never syncs.

Keep the session of the push in the assistant itself, and only handle
the changes reported by the delegator an assistant was pushed to.

Assisted-by: opencode:claude-opus-5
---
 profiles/audio/bass.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index c9a9111e010f..fd05195f36d2 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -108,6 +108,13 @@ struct bass_assistant {
 	struct btd_adapter *adapter;	/* Broadcast source device */
 	struct btd_device *device;	/* Broadcast source device */
 	struct bass_data *data;		/* BASS session with peer device */
+	struct bt_bass *bass;		/* BASS session the stream is pushed
+					 * to, which for a local stream is
+					 * chosen by the push, so it is kept
+					 * per assistant: the session of the
+					 * data is shared by every assistant
+					 * of the adapter.
+					 */
 	uint8_t sgrp;
 	uint8_t sid;
 	uint8_t bis;
@@ -803,6 +810,7 @@ assistant_new(struct btd_adapter *adapter,
 	assistant->adapter = adapter;
 	assistant->device = device;
 	assistant->data = data;
+	assistant->bass = bt_bass_ref(data->bass);
 	assistant->sgrp = sgrp;
 	assistant->sid = sid;
 	assistant->bis = bis;
@@ -991,10 +999,10 @@ static int assistant_parse_props(struct bass_assistant *assistant,
 				goto fail;
 			}
 
-			if (assistant->data->bass)
-				bt_bass_unref(assistant->data->bass);
+			if (assistant->bass)
+				bt_bass_unref(assistant->bass);
 
-			assistant->data->bass = bt_bass_ref(data->bass);
+			assistant->bass = bt_bass_ref(data->bass);
 		}
 
 		dbus_message_iter_next(props);
@@ -1040,7 +1048,7 @@ static void assistant_past(struct bass_assistant *assistant)
 		return;
 
 	if (!device) {
-		struct bt_bass *bass = assistant->data->bass;
+		struct bt_bass *bass = assistant->bass;
 		struct bass_data *data;
 
 		data = queue_find(sessions, match_bass, bass);
@@ -1095,7 +1103,7 @@ static DBusMessage *push_mod_src(struct bass_assistant *assistant,
 		util_iov_append(&iov, &meta_len, sizeof(meta_len));
 	}
 
-	err = bt_bass_send(assistant->data->bass, &hdr, &iov);
+	err = bt_bass_send(assistant->bass, &hdr, &iov);
 	if (err) {
 		DBG("Unable to send BASS Write Command");
 		return btd_error_failed(msg, strerror(-err));
@@ -1109,7 +1117,7 @@ static DBusMessage *push_mod_src(struct bass_assistant *assistant,
 		struct bass_src *src;
 
 		src = queue_remove_if(assistant->srcs, match_src_data,
-						assistant->data->bass);
+						assistant->bass);
 		free(src);
 	}
 
@@ -1210,7 +1218,7 @@ static DBusMessage *push_add_src(struct bass_assistant *assistant,
 	util_iov_append(&iov, assistant->meta->iov_base,
 				assistant->meta->iov_len);
 
-	err = bt_bass_send(assistant->data->bass, &hdr, &iov);
+	err = bt_bass_send(assistant->bass, &hdr, &iov);
 	if (err) {
 		DBG("Unable to send BASS Write Command");
 		return btd_error_failed(msg, strerror(-err));
@@ -1219,7 +1227,7 @@ static DBusMessage *push_add_src(struct bass_assistant *assistant,
 	free(iov.iov_base);
 
 	if (assistant->state == ASSISTANT_STATE_LOCAL)
-		assistant_add_src(assistant, assistant->data->bass, 0);
+		assistant_add_src(assistant, assistant->bass, 0);
 	else
 		assistant_set_state(assistant, ASSISTANT_STATE_PENDING);
 
@@ -1235,7 +1243,7 @@ static DBusMessage *push_src(struct bass_assistant *assistant,
 		struct bass_src *src;
 
 		src = queue_find(assistant->srcs, match_src_data,
-						assistant->data->bass);
+						assistant->bass);
 		if (src) {
 			assistant->src_id = src->src_id;
 			return push_mod_src(assistant, msg);
@@ -1274,7 +1282,7 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 	 * be enabled yet and the state changes it triggers, e.g. a request to
 	 * transfer the sync info, would be missed.
 	 */
-	data = queue_find(sessions, match_bass, assistant->data->bass);
+	data = queue_find(sessions, match_bass, assistant->bass);
 	if (data && !data->ready) {
 		DBG("Session not ready, queueing request");
 
@@ -1391,6 +1399,7 @@ static void assistant_free(void *data)
 	util_iov_free(assistant->meta, 1);
 	util_iov_free(assistant->caps, 1);
 	queue_destroy(assistant->srcs, free);
+	bt_bass_unref(assistant->bass);
 
 	free(assistant);
 }
@@ -2237,7 +2246,7 @@ static void bass_handle_bcode_req(struct bass_assistant *assistant, int id)
 
 	util_iov_push_mem(&iov, sizeof(params), &params);
 
-	err = bt_bass_send(assistant->data->bass, &hdr, &iov);
+	err = bt_bass_send(assistant->bass, &hdr, &iov);
 	if (err) {
 		DBG("Unable to send BASS Write Command");
 		return;
@@ -2280,6 +2289,14 @@ static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t state,
 		struct bass_assistant *assistant = entry->data;
 		uint32_t bis = 1 << (assistant->bis - 1);
 
+		if (assistant->bass != data->bass)
+			/* Only handle assistant objects that have been
+			 * pushed to the delegator reporting the change,
+			 * otherwise e.g. the Broadcast Code of a request
+			 * would be sent to a different delegator.
+			 */
+			continue;
+
 		if (bid && assistant->bid != bid)
 			/* Only handle assistant objects
 			 * that match the source
-- 
2.55.0

