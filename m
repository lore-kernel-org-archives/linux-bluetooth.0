Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9CE2EA158
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708497; cv=pass; b=sMaj1qqoTOoMHVzMXBo9xBYhayYd7A/AhObqpQZHkxQH+vuhkVZRAjG5g1POrW17YUnULUVO/bJpNFNEw0Qrfizhm6/+OWGBfVsGse2yRqZXRiWS2capr88TE7fpW/gDblVf8efH5Lg/7B/ffMvl003uk3cSvlWxkVQKk6IyeF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708497; c=relaxed/simple;
	bh=TZnowD4SozmAIWQZldk/iz2SQwLNoCFizSJ8uDyYpv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQsmWty4YNsTxcp5uKr6ObGR1H57KgbkpD+7Fff9xJDxx+CIXsmZ/B+3+6Szj31/fTC7ymBCUGspyD9lQQ4NscDjkt2N8u1FOpVtEKQi1EGSaK6lUe7kcYnyeQAGz/pVkFZEEOaHh1kV5Vcqi3Zw/kwlDpEhsXcDpJIjyht5RtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=EYvQO+ND; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BIS9CScJ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="EYvQO+ND";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BIS9CScJ"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4dLXsb1t0hz49Q80
	for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 22:48:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1764708483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk1+Jw6C4mWuzjmioQygpl/nJLdLoOesNvf6rg3xiNk=;
	b=EYvQO+NDkm4XW7nsVHSQcAeSQeZh1z/78zjBRctYaSADnnvg3K0pxXnCt69Gcw4Mg4EBBH
	zbTfJKQlq0k2YKN5kbV78pPsbRJ0c/UwNwLbV5WtZ3IwRH1spozXZR0JCCbwTXjxMjZxs/
	g3ddW32WRKg4uVoHc/2+DYJ3sZ4cBZYd8ztV//47XoPYCDM8HjE05tXNbK+ib+3eTVsCqj
	zus+/83WHG5XH65Df+Leu6DaLY7ZWizPFOgQhnSGNEDhVBV5aAtr8AhevviMTqQJ3qf+xm
	RmPniSwTJuiSYERisq08eQTtPIM2h5M+XS3H2UX7cbW2OVv36SfR4J0Rajcz1Q==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dLXsR36fvz10Lw;
	Tue,  2 Dec 2025 22:47:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764708475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk1+Jw6C4mWuzjmioQygpl/nJLdLoOesNvf6rg3xiNk=;
	b=BIS9CScJGy/TIvZIkUzuy7qLmqTAkcJ4u3X24l0g/hrOoYagmwNx5VBYUQaZD4wjVFXnbV
	VmAVcFSp1oR4jWa9DDuCUtt6JydeY9s4QE4cmXCvJY4BVreNxCy1b3Bn672ORoubft21Mb
	qf6JXzHTHtlh4jh2GttPvV4s04IQCHQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764708475;
	b=YTpUg7rJqZ6Sj1rkbbesmsHPmZ5mA9v/mAn6XvazILeJ7epoO0G8IX2QOe/Y1p+lzlxomc
	388VMJR6AUeiRCaIczrb0ceqsvWc6md82E0zThfZ50UkkDCFHQwrCeREDydmxkdhDF/5Uv
	R8LhlH9uZOL3SWgdC+YGrkTNE0IGhps=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764708475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk1+Jw6C4mWuzjmioQygpl/nJLdLoOesNvf6rg3xiNk=;
	b=saa8AHAi48XXMQrZhiL2t2YDX9HeQCm0OrQ8lcdP4p87MyL468Q39hZ87PvWjIuZgUPy99
	6FNYPfXUw6kbKyypsgm+5CiUVCFf/rZo5j8DdBcdpR3HivtKt0iaudEaAtOF8jZqDIhs2P
	aOiqRL0fMqUiWgSE5FNpGbREG74Q5U8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 4/7] service: implement btd_profile::after_services callback
Date: Tue,  2 Dec 2025 22:47:49 +0200
Message-ID: <5c6590378409461bf24b97f090af3abb59c7a66d.1764708372.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764708372.git.pav@iki.fi>
References: <cover.1764708372.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle btd_profile::after_services callback when after_services
dependencies have finished connecting.
---

Notes:
    v3:
    - after_uuids -> after_services
    - don't log "dependencies ready" if there is no deps or callback

 src/service.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/src/service.c b/src/service.c
index 7690a1261..8301b1ead 100644
--- a/src/service.c
+++ b/src/service.c
@@ -26,6 +26,8 @@
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/sdp.h"
 
+#include "src/shared/queue.h"
+
 #include "log.h"
 #include "backtrace.h"
 
@@ -43,6 +45,8 @@ struct btd_service {
 	int			err;
 	bool			is_allowed;
 	bool			initiator;
+	struct queue		*depends;
+	struct queue		*dependents;
 };
 
 struct service_state_callback {
@@ -71,6 +75,50 @@ static const char *state2str(btd_service_state_t state)
 	return NULL;
 }
 
+static void depends_ready(void *item, void *user_data)
+{
+	struct btd_service *service = item;
+	struct btd_service *dep = user_data;
+	struct btd_profile_uuid_cb *after = &service->profile->after_services;
+	char addr[18];
+
+	if (dep && !queue_remove(service->depends, dep))
+		return;
+	if (!service->depends || !queue_isempty(service->depends))
+		return;
+
+	queue_destroy(service->depends, NULL);
+	service->depends = NULL;
+
+	if (!after->count && !after->func)
+		return;
+
+	ba2str(device_get_address(service->device), addr);
+	DBG("%p: device %s profile %s dependencies ready", service,
+						addr, service->profile->name);
+
+	switch (service->state) {
+	case BTD_SERVICE_STATE_CONNECTING:
+	case BTD_SERVICE_STATE_CONNECTED:
+		if (after->func)
+			after->func(service);
+		break;
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+	case BTD_SERVICE_STATE_DISCONNECTING:
+	case BTD_SERVICE_STATE_DISCONNECTED:
+		break;
+	}
+}
+
+static void service_ready(struct btd_service *service)
+{
+	queue_foreach(service->dependents, depends_ready, service);
+	queue_destroy(service->dependents, NULL);
+	service->dependents = NULL;
+
+	depends_ready(service, NULL);
+}
+
 static void change_state(struct btd_service *service, btd_service_state_t state,
 									int err)
 {
@@ -98,6 +146,9 @@ static void change_state(struct btd_service *service, btd_service_state_t state,
 		cb->cb(service, old, state, cb->user_data);
 	}
 
+	if (state != BTD_SERVICE_STATE_CONNECTING)
+		service_ready(service);
+
 	if (state == BTD_SERVICE_STATE_DISCONNECTED)
 		service->initiator = false;
 }
@@ -111,6 +162,20 @@ struct btd_service *btd_service_ref(struct btd_service *service)
 	return service;
 }
 
+static void depends_remove(void *item, void *user_data)
+{
+	struct btd_service *service = item;
+
+	queue_remove(service->dependents, user_data);
+}
+
+static void dependents_remove(void *item, void *user_data)
+{
+	struct btd_service *service = item;
+
+	queue_remove(service->depends, user_data);
+}
+
 void btd_service_unref(struct btd_service *service)
 {
 	service->ref--;
@@ -120,6 +185,11 @@ void btd_service_unref(struct btd_service *service)
 	if (service->ref > 0)
 		return;
 
+	queue_foreach(service->depends, depends_remove, service);
+	queue_foreach(service->dependents, dependents_remove, service);
+	queue_destroy(service->depends, NULL);
+	queue_destroy(service->dependents, NULL);
+
 	g_free(service);
 }
 
@@ -172,6 +242,39 @@ void service_remove(struct btd_service *service)
 	btd_service_unref(service);
 }
 
+static void add_depends(struct btd_service *service)
+{
+	struct btd_profile_uuid_cb *after = &service->profile->after_services;
+	unsigned int i;
+
+	queue_foreach(service->depends, depends_remove, service);
+	queue_destroy(service->depends, NULL);
+	service->depends = queue_new();
+
+	for (i = 0; i < after->count; ++i) {
+		const char *uuid = after->uuids[i];
+		struct btd_service *dep;
+
+		dep = btd_device_get_service(service->device, uuid);
+		if (!dep)
+			continue;
+
+		/* Profiles are sorted vs after_uuids, so the dependency will
+		 * have started connecting before us if it is going to connect.
+		 */
+		if (dep->state != BTD_SERVICE_STATE_CONNECTING)
+			continue;
+		if (queue_find(service->depends, NULL, dep))
+			continue;
+
+		queue_push_tail(service->depends, dep);
+
+		if (!dep->dependents)
+			dep->dependents = queue_new();
+		queue_push_tail(dep->dependents, service);
+	}
+}
+
 int service_accept(struct btd_service *service, bool initiator)
 {
 	char addr[18];
@@ -199,6 +302,7 @@ int service_accept(struct btd_service *service, bool initiator)
 	}
 
 	service->initiator = initiator;
+	add_depends(service);
 
 	err = service->profile->accept(service);
 	if (!err)
@@ -265,6 +369,8 @@ int btd_service_connect(struct btd_service *service)
 		return -ECONNABORTED;
 	}
 
+	add_depends(service);
+
 	err = profile->connect(service);
 	if (err == 0) {
 		service->initiator = true;
-- 
2.51.1

