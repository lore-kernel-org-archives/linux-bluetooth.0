Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3042F745C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708492; cv=pass; b=GrCkH1ckkVo9ZSxuZVyKUCKAqp6PKelW+PMwzDHL9EnSAz3CS6s7hApk36sxxtLpYk7FP60KNd/B9NFWbAYttI662kZqVrXmg6YgcLQIq/lsyS855BwK5jL+cK87SQ04iSRRFoOWUGq2l70zVUgiAgxTpQtc0VaMlRXN3lBXljY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708492; c=relaxed/simple;
	bh=xFMR9Gk8RLaEFI6qmNfrUPAfPfF4n8mZT3/LI7RF3wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+/OONpp4k6Y/274ImsjiPR9a7wlTq1D4Og8hzVBmXYMq76saNPcOYI2AY83OCEbNz1VIOvsVAUpi0Lm4Xt5FCSIo49c6y4CGShJ0zWQelmP68zXly3QP3+cvxwyZHrn35miZw9OCAnGJNmnqBIj3ft6EbklUHsK7vYBg021Boo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rlmUPYdr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rlmUPYdr"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dLXsR4fdqz10M3;
	Tue,  2 Dec 2025 22:47:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764708475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zs6AMls0y6pjwnp6M1vJqoMhk7yZI2/AREY3VYzcP8=;
	b=rlmUPYdrMt+gky2ObDYmSuFrp1x9Q/UUQpOlc0yOalV6vHEuQpuhazZxChdOFBs6olaChR
	X+InY9RGnhsjQ3nUuUsjr+AJEPUKWNnBca0Di4vk9Bp+y375tH0d9B2UISK42gDk9kF6wR
	g1rjLeBjfKXSw8Vk5CLTzzBazKZLzEM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764708475;
	b=ShM6rsqri87aiB/9X2RpjpbCcrtbsh2PICNZZS1FaBmvfo4XeCkXW2RxqX0Psu2UX31DCv
	Wtk1TpmxYPfK4+ervOPXv3l4mbmnbprD6rRpiWsTP/Eo2MAxW6c2pp5H2TeQLL7zefk6QT
	uJzaUvh53EMlJtoJCdwweW2++PJFWLE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764708475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zs6AMls0y6pjwnp6M1vJqoMhk7yZI2/AREY3VYzcP8=;
	b=OAUZ8BjeeVMCdI8qhkwyltbp2inqERPxzHdi3RNBFdgOcgKjQvi3GqDUs/Hwc/o8q/YkEb
	woUhFFvBpyhD0VQPTEe1M5UQMRGG8N1wS+kYH3bztg9Yv8UpnRUeCNyJlUmKOw0JoMKPGU
	rIIJwVgrLwOX4sY7oyZv5VN2i6LIhOM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 5/7] bap: have unicast client wait for VCS & TMAS & GMAP
Date: Tue,  2 Dec 2025 22:47:50 +0200
Message-ID: <ea99aac0d8fddbc9dc7130cfb89d139e48850c66.1764708372.git.pav@iki.fi>
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

Have unicast client to wait for VCS, TMAS, and GMAP before creating
endpoints and transports, so that their information is available at that
point.
---

Notes:
    v3:
    - ready + after_uuids -> after_services
    v2:
    - use the generic mechanism to do this

 profiles/audio/bap.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 0dcc57eb5..295e4552d 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -145,6 +145,8 @@ struct bap_data {
 	GIOChannel *listen_io;
 	unsigned int io_id;
 	unsigned int cig_update_id;
+	bool services_ready;
+	bool bap_ready;
 };
 
 static struct queue *sessions;
@@ -2137,10 +2139,10 @@ static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return true;
 }
 
-static void bap_ready(struct bt_bap *bap, void *user_data)
+static void bap_ucast_start(struct bap_data *data)
 {
-	struct btd_service *service = user_data;
-	struct bap_data *data = btd_service_get_user_data(service);
+	struct btd_service *service = data->service;
+	struct bt_bap *bap = data->bap;
 
 	DBG("bap %p", bap);
 
@@ -3723,6 +3725,29 @@ static void pa_and_big_sync(struct bap_setup *setup)
 	}
 }
 
+static void bap_ready(struct bt_bap *bap, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_data *data = btd_service_get_user_data(service);
+
+	DBG("bap %p", bap);
+
+	data->bap_ready = true;
+	if (data->services_ready)
+		bap_ucast_start(data);
+}
+
+static void bap_services_ready(struct btd_service *service)
+{
+	struct bap_data *data = btd_service_get_user_data(service);
+
+	DBG("%p", data);
+
+	data->services_ready = true;
+	if (data->bap_ready)
+		bap_ucast_start(data);
+}
+
 static int bap_bcast_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -3877,6 +3902,9 @@ static int bap_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	data->bap_ready = false;
+	data->services_ready = false;
+
 	if (!bt_bap_attach(data->bap, client)) {
 		error("BAP unable to attach");
 		return -EINVAL;
@@ -4000,6 +4028,8 @@ static struct btd_profile bap_profile = {
 	.adapter_remove	= bap_adapter_remove,
 	.auto_connect	= true,
 	.experimental	= true,
+	.after_services	= BTD_PROFILE_UUID_CB(bap_services_ready,
+				VCS_UUID_STR, TMAS_UUID_STR, GMAS_UUID_STR),
 };
 
 static struct btd_profile bap_bcast_profile = {
-- 
2.51.1

