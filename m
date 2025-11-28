Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C32BE622
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360174; cv=pass; b=G7s0I6MYjkgc5UiPorkPCp9yhvCPV2rfpw5nCKDj/kCHrTewhVZO9tixLhLNl2AMygCb3yaEgt0oKRZgmdus8FO/Jddv3jCqsC8ejWrTrYdNLUiAdnHFDYOsx0ZYtVwDSmFDxYMuAu3Ac5dphDH0OBlHsCwZGkKhIPkAsulRR2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360174; c=relaxed/simple;
	bh=iUr0Jdf2RU82jcN63CfWE/PZbM7IVTdxZOc6MUKZkYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbfToHws0Z0LJ6wU4Tp3b465SY21vELgdpc4gVTSjlnPuZtTBMSiiIbQnpKcipI6nFtNX5ZkspHoT9mOpIwWvPlhi6b+rLbe3TSZJagcBumS7alSwRqcLtJkPDEnINpSaywa894ddr+3M48EhOp8Ux7K9g+iAtchoznzXqFgFW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=f7K7xm7E; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="f7K7xm7E"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJ4356lCBz10Kc;
	Fri, 28 Nov 2025 22:02:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764360162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWTA02LCtg1U/jhkAqSE1NenFJJny1Pv5JBIi6rno78=;
	b=f7K7xm7EvvMPbJStrwefjKUXgQITl6KOaOiAdS8mTILivZZ39GUXywWTgoxJJaW/nr/MSd
	DrZP4NuT9QxWT08T1rzDcSzUpS438xnkJEinsr3j7YAalC18emulHnMIKZigdUdhXDOOqW
	GW4BY3w6DezJkl/9/1lyFCGGuDJPeoY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764360162;
	b=CkgP5AVACoDMocMideTh7JUAkRcElz2PX4m+9dEUPOE70D8Wy+1ny4qu2Kr/ZPdHB8nKiZ
	ueYg+wzvJJsi9jD3Rfg63MZTVfnomGnPpAxKXU3wH5MHs5mr7YAylykaet6LgxPdv5N0WA
	+53wdEbnuTLDmb3YMkmzYMM2ZA7gh6s=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764360162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWTA02LCtg1U/jhkAqSE1NenFJJny1Pv5JBIi6rno78=;
	b=MhjQEHCi9OPIFMxiVmy1z+dHv96oBNYVmXahbFDtTVvuBRNrYlf7e0kn4e/OXLI2lmFIKd
	xnYLMlX6vWWafqm8tJ4l8JEL4X05JD3U0HxKSrQ5zf4LgZwHFbX7OihYszlFJBtkvXlpox
	Uiut8mNFeWNfetqfUucVjNMXiNWwZxs=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 9/9] bap: have unicast client wait for VCS & TMAS & GMAP
Date: Fri, 28 Nov 2025 22:02:28 +0200
Message-ID: <c833be2c695b126089c8c9242a7aa5d69e267cdc.1764360141.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764360140.git.pav@iki.fi>
References: <cover.1764360140.git.pav@iki.fi>
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
    v2:
    - use the generic mechanism to do this

 profiles/audio/bap.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 0dcc57eb5..8e6a7c57f 100644
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
@@ -3996,10 +4024,17 @@ static struct btd_profile bap_profile = {
 	.device_remove	= bap_remove,
 	.accept		= bap_accept,
 	.disconnect	= bap_disconnect,
+	.ready		= bap_services_ready,
 	.adapter_probe	= bap_adapter_probe,
 	.adapter_remove	= bap_adapter_remove,
 	.auto_connect	= true,
 	.experimental	= true,
+	.after_uuids = (const char *[]) {
+		VCS_UUID_STR,
+		TMAS_UUID_STR,
+		GMAS_UUID_STR,
+		NULL
+	},
 };
 
 static struct btd_profile bap_bcast_profile = {
-- 
2.51.1

