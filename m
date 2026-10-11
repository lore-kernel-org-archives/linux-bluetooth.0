Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F044F56C
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751253; cv=pass; b=YBtWd5zgchuKWcd9TJQ2LiWrBfZU6pIYK3UQWZ0eHYM8A84nDAufAGzYVJ9fd8hJ3nMu3zDwUFgMonTHG3d8FRD7oiXdoQ7nmdX7IJ5l06eWlLtU0UeUlQLLp/A+7S+gqp1uOize11nApwGi4At31XBgU+oURgaR8dN0+05b0TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751253; c=relaxed/simple;
	bh=p/iUCQUXIm5nblMYkPKPhSclueqEeIcw5q3TQfina9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgoQStvmIgwPQlLRn1txDrTjiZT8Ji0fVsGMALZuI6njZJOc4hYDBkPVGJczartMAgYHZndqNQmqay6szyPvBDLl1PooSFjWJUTpxm+iIceuCzhWvrRG48DmMAlLzUovg9sRK3j58h2zMM3ZpD/q9sZQOokGTsJmIwxC8//uiUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Lb4Vg6ys; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Lb4Vg6ys"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2sth4BFYzyb7;
	Sun, 11 Oct 2026 23:40:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791751244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKgJpjopqmE4l0YVpQHm2frKp2PFCK8ouonVlcQyLvo=;
	b=Lb4Vg6ysswj0QbZBlBGx6iaJNCVXnvQ0mz+gzu7xcQXpeIwisu3GTnwLop83QN2nNUSnjG
	oBF86aHeiWhwLgvEQ066Ge2RuzKhSGh2u0kk/+sq83NqujJg0LMfkfPEIsra8NmO57RxeA
	D6kRC8IKkBvZ8JFCgLM7k93lo3GfIgQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791751244;
	b=BFvKn4lmu4wEvPBeAKVgTL6POCKe/xDd3TAeuqP0n8/eUWS2u0HUHLvVuMk0hkItculOsq
	kvcFtRjsPtxnUk7yCbp9H+sHBOmhyXCMfRBctt+i9WbNPNLCt4K+IE+yHO6xeBRPtw8mnY
	1fTKxRjU13lgKnV1vdfdLyP90nCPsP4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791751244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wKgJpjopqmE4l0YVpQHm2frKp2PFCK8ouonVlcQyLvo=;
	b=ssPGQDuXkiTQXXbvcN07sFNYnCRTZZQFIenxg1YQR5GuNhe1H5cent9NcxtWypVRPlHQz0
	8r91i3/ftny97kjsbyJhkTu3RdnVKtZhH3ykyIx/YejZu/5OwbmX61JUfvxPsRc9vC7+2D
	O70t+e1x2D5j9phu0Xf6jtb8jUwwml0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/5] bass: wait for PAST listener readiness
Date: Sun, 11 Oct 2026 23:40:19 +0300
Message-ID: <5b5a8c1ebfe761606affcca1437c8a352fa0502a.1791750393.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791750393.git.pav@iki.fi>
References: <cover.1791750393.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Defer SYNC_INFO_RE until the PA sync listener signals POLLOUT, so the
Assistant cannot start PAST before receiver setup completes.

Check kernel support via BT_ISO_PAST_POLLOUT, otherwise skip waiting.

Fixes test_bass_past_transport_* test failures.

Assisted-by: LLM
---
 profiles/audio/bass.c | 66 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index fd05195f3..90e758c08 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -146,7 +146,9 @@ struct bass_delegator {
 	struct queue *bcode_reqs;
 	struct queue *setups;
 	unsigned int io_id;
+	unsigned int io_ready_id;
 	GIOChannel *io;
+	bool past;
 };
 
 struct bass_setup {
@@ -751,6 +753,11 @@ static void confirm_cb(GIOChannel *io, void *user_data)
 
 	DBG("");
 
+	if (dg->io_ready_id) {
+		g_source_remove(dg->io_ready_id);
+		dg->io_ready_id = 0;
+	}
+
 	/* Close the listen io */
 	g_io_channel_shutdown(dg->io, TRUE, NULL);
 	g_io_channel_unref(dg->io);
@@ -1528,11 +1535,28 @@ static bool delegator_match_device(const void *data, const void *match_data)
 	return dg->device == device;
 }
 
+static gboolean pa_sync_ready_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct bass_delegator *dg = user_data;
+
+	dg->io_ready_id = 0;
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
+		return FALSE;
+
+	bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
+
+	return FALSE;
+}
+
 static void delegator_attach(struct bt_bap *bap, struct btd_device *device,
 				struct btd_service *service)
 {
 	struct bass_delegator *dg;
 	GError *err = NULL;
+	socklen_t len;
+	int sk, past_pollout;
 
 	dg = queue_find(delegators, delegator_match_device, device);
 	if (!dg)
@@ -1570,6 +1594,30 @@ static void delegator_attach(struct bt_bap *bap, struct btd_device *device,
 
 	/* Take ownership for the service by setting the user data. */
 	btd_service_set_user_data(service, dg);
+
+	if (!dg->past)
+		return;
+
+	sk = g_io_channel_unix_get_fd(dg->io);
+	len = sizeof(past_pollout);
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_PAST_POLLOUT,
+						&past_pollout, &len) < 0) {
+		if (errno != ENOPROTOOPT) {
+			error("Unable to query PAST readiness support: %s",
+							strerror(errno));
+			return;
+		}
+
+		past_pollout = 0;
+	}
+
+	if (past_pollout)
+		dg->io_ready_id = g_io_add_watch(dg->io,
+				G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				pa_sync_ready_cb, dg);
+	else
+		bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
 }
 
 static void bap_attached(struct bt_bap *bap, void *user_data)
@@ -1645,6 +1693,9 @@ static void delegator_free(struct bass_delegator *dg)
 	if (dg->io_id)
 		g_source_remove(dg->io_id);
 
+	if (dg->io_ready_id)
+		g_source_remove(dg->io_ready_id);
+
 	if (dg->io) {
 		g_io_channel_shutdown(dg->io, TRUE, NULL);
 		g_io_channel_unref(dg->io);
@@ -1906,7 +1957,7 @@ static void bass_detached(struct bt_bass *bass, void *user_data)
 
 static struct bass_delegator *
 bass_delegator_new(struct btd_device *device, struct bt_bcast_src *src,
-			uint8_t sid)
+			uint8_t sid, bool past)
 {
 	struct bass_delegator *dg;
 
@@ -1917,6 +1968,7 @@ bass_delegator_new(struct btd_device *device, struct bt_bcast_src *src,
 	dg->device = device;
 	dg->src = src;
 	dg->sid = sid;
+	dg->past = past;
 	dg->bcode_reqs = queue_new();
 	dg->setups = queue_new();
 
@@ -1945,6 +1997,7 @@ static int handle_add_src_req(struct bt_bcast_src *bcast_src,
 	struct btd_adapter *adapter = device_get_adapter(data->device);
 	struct btd_device *device;
 	struct bass_delegator *dg;
+	bool past = false;
 
 	/* Detect if PAST can be used then it can be used as destination since
 	 * PAST Receiver uses the ACL connection itself.
@@ -1957,6 +2010,7 @@ static int handle_add_src_req(struct bt_bcast_src *bcast_src,
 		if (btd_adapter_has_settings(data->adapter,
 						MGMT_SETTING_PAST_RECEIVER)) {
 			device_set_past_support(data->device, true);
+			past = true;
 			device = data->device;
 			goto done;
 		}
@@ -1980,16 +2034,14 @@ done:
 	 * autonomously probed inside BAP.
 	 */
 	if (!btd_device_get_service(device, BCAAS_UUID_STR)) {
-		dg = bass_delegator_new(device, bcast_src, params->sid);
+		dg = bass_delegator_new(device, bcast_src, params->sid, past);
 		if (!dg)
 			return -ENOMEM;
+
+		if (past)
+			return 0;
 	}
 
-	/* Set PA sync state, this has to be done after probing otherwise there
-	 * is a race where the remote may receive BT_BASS_SYNC_INFO_RE and start
-	 * PAST before the kernel has sent PAST Parameter command that enables
-	 * receiving it.
-	 */
 	if (params->pa_sync == PA_SYNC_PAST) {
 		if (btd_adapter_has_settings(data->adapter,
 						MGMT_SETTING_PAST_RECEIVER))
-- 
2.56.0

