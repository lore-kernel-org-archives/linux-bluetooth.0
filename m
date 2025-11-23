Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED482D7D30
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914654; cv=pass; b=uEKGkMIBWSiEaqUPEZAM3jPoZ9uqqpkYtGppH/SCo8JJzqSoYxLYURWV/xQkoVCecrhd6ZcoW5BX05aH33R7XNOaQuwrvcDIMcXH26gVOuxJ2xSWQlWRB4A7rTwTUr/SaYxatCKPO68cTeIaxV8UErgszgOfRxKA72QOObTRwrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914654; c=relaxed/simple;
	bh=/fzpcf7VcVJdb3sONvqaS9S+HvfQ0ZtaCZPJA9RF0YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyOKNZUXuwqrAC8L0oMS0cPmAdUdKPpn9xyWdbscG55B1ECx7a0FO8F2KMr7LnrWcd/i/ToX3RkWArFxVHpYIB2MrnbEcpaTZAgk3XpsNq1zQpvdAwzQSPnf66V0FfXzJ8P/jTs9drmRF5FoCcmHcGyx37H28WJZoQmlmBnsdbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=T1RGsFtM; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="T1RGsFtM"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHS61fLz109Q;
	Sun, 23 Nov 2025 18:17:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7yg9Eql7owK347YuH0pwZx+nWo+vrJ+BZOrI0C/yso=;
	b=T1RGsFtMrQoadAnhrZidCiuq35etvg5og9iJ3mZKPcq2psH7Y/T8lijES47hOLVYT8P9F/
	a2PqZg34BgVaPgPygLmSZlJaLr9keDHypR0Qo9T6CXXLnBC58ySE5ox1JYQnMlgb9z3Rx/
	kWBo6EgM7OuZyLly6y0KR620j89Xa9Q=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914645;
	b=FHKyaJIsGawqAaU1CFyUG6kRsGdxCzdb5OjBtgFVrCHbEkWd16PYBPxpp1UFhEUBjyZVXS
	GRKmHjWkLmcsGYjSIXDlt2SpfsHmCliqx575Ht7rENCk6VfI4IGrQTwMnd6zpKOB7gHHUE
	owKDq9yGqf1wp/1NYtnYGk1uVOFOwhU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7yg9Eql7owK347YuH0pwZx+nWo+vrJ+BZOrI0C/yso=;
	b=pJl5NdZJ06w4dyvudYGVJ+OOORks0M9I3ejQN3SGNxSm3tVMRcZKSV7o6lHIV3wtpLNfJR
	Wre2YQu2gFqGXTj9Dybsa+aPj2zotH9BsIck7vbv54wI/nY613/JNtfrvJ6lZNJh0M729o
	IFkQzecOG/7MaUL6wkz1DHwxYOxxrMA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 04/10] bap: have unicast client wait for VCS & TMAS
Date: Sun, 23 Nov 2025 18:17:09 +0200
Message-ID: <3761b0c09f02442470d64de9225d3308df2d509f.1763914558.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763914558.git.pav@iki.fi>
References: <cover.1763914558.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have unicast client to wait for VCS and TMAS before creating endpoints
and transports, so that their information is available at that point.
---
 profiles/audio/bap.c | 69 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b07d65e68..73c5cfc74 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -127,6 +127,7 @@ struct bap_data {
 	struct btd_device *device;
 	struct btd_adapter *adapter;
 	struct btd_service *service;
+	struct queue *wait_services;
 	struct bt_bap *bap;
 	unsigned int ready_id;
 	unsigned int state_id;
@@ -139,6 +140,7 @@ struct bap_data {
 	GIOChannel *listen_io;
 	unsigned int io_id;
 	unsigned int cig_update_id;
+	unsigned int service_state_id;
 };
 
 static struct queue *sessions;
@@ -186,11 +188,15 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->bcast, ep_unregister);
 	queue_destroy(data->server_streams, NULL);
 	queue_destroy(data->bcast_snks, setup_free);
+	queue_destroy(data->wait_services, NULL);
 	bt_bap_ready_unregister(data->bap, data->ready_id);
 	bt_bap_state_unregister(data->bap, data->state_id);
 	bt_bap_pac_unregister(data->bap, data->pac_id);
 	bt_bap_unref(data->bap);
 
+	if (data->service_state_id)
+		btd_service_remove_state_cb(data->service_state_id);
+
 	if (data->cig_update_id)
 		g_source_remove(data->cig_update_id);
 
@@ -2015,13 +2021,16 @@ static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return true;
 }
 
-static void bap_ready(struct bt_bap *bap, void *user_data)
+static void bap_service_ready(struct bap_data *data)
 {
-	struct btd_service *service = user_data;
-	struct bap_data *data = btd_service_get_user_data(service);
+	struct bt_bap *bap = data->bap;
+	struct btd_service *service = data->service;
 
 	DBG("bap %p", bap);
 
+	if (!queue_isempty(data->wait_services))
+		return;
+
 	/* Register all ep before selecting, so that sound server
 	 * knows all.
 	 */
@@ -2031,6 +2040,15 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bap_select_all(data, false, NULL, NULL);
 }
 
+static void bap_ready(struct bt_bap *bap, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_data *data = btd_service_get_user_data(service);
+
+	queue_remove(data->wait_services, NULL);
+	bap_service_ready(data);
+}
+
 static bool match_setup_stream(const void *data, const void *user_data)
 {
 	const struct bap_setup *setup = data;
@@ -3740,6 +3758,44 @@ static int bap_probe(struct btd_service *service)
 	return 0;
 }
 
+static void wait_service_cb(struct btd_service *service,
+						btd_service_state_t old_state,
+						btd_service_state_t new_state,
+						void *user_data)
+{
+	struct bap_data *data = user_data;
+
+	if (new_state == BTD_SERVICE_STATE_CONNECTING)
+		return;
+	if (!queue_remove(data->wait_services, service))
+		return;
+
+	DBG("%s", btd_service_get_profile(service)->name);
+	bap_service_ready(data);
+}
+
+static void wait_service_add(struct bap_data *data, uint16_t remote_uuid)
+{
+	struct btd_service *service;
+	bt_uuid_t uuid;
+	char uuid_str[64];
+
+	bt_uuid16_create(&uuid, remote_uuid);
+	bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+
+	service = btd_device_get_service(data->device, uuid_str);
+	if (!service)
+		return;
+	if (btd_service_get_state(service) != BTD_SERVICE_STATE_CONNECTING)
+		return;
+
+	queue_push_tail(data->wait_services, service);
+
+	if (!data->service_state_id)
+		data->service_state_id = btd_service_add_state_cb(
+						wait_service_cb, data);
+}
+
 static int bap_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -3760,6 +3816,13 @@ static int bap_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	queue_destroy(data->wait_services, NULL);
+	data->wait_services = queue_new();
+
+	queue_push_tail(data->wait_services, NULL);
+	wait_service_add(data, TMAS_UUID);
+	wait_service_add(data, VCS_UUID);
+
 	btd_service_connecting_complete(service, 0);
 
 	return 0;
-- 
2.51.1

