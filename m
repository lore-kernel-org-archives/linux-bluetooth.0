Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEB17C69
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865797; cv=none; b=T8n0wsU1eGhiSh0oZmSKox8dlTHJwY2xkgAJQliQWmzKUg8eUwy2Uxr49MZWwqQNnlIiWloJ2/voBYJFSRhZhe52BPo12wJ3jhpZXbHwrUpEwA2rjiZxG7+1YMQSQGLA8OktwuYZ3sS4ohdiEwkhE5jK3d9ShY4A62Y1/ekmxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865797; c=relaxed/simple;
	bh=zxNvGco3OGDblWGo67VcK+hd9R/qtkasd5Tc6mcJ+3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5OBDO3st1qgBTyzNAOC/DV83jt1NWgQMQCbHJv/mcl5EJKrSOOImwgKPYha4FZIPCIR1P3ef9A32e+HUrS20PYA+NxYvtDZl8SN5WZ6CduGJ5jBuxJ0ID1Mv+msTrEdujMBGQW26LVdtjtiqyA5nfyWX8MEWHAwqihtixZqJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM6q8b/4; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM6q8b/4"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c60adf3474so104088b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712865795; x=1713470595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSdJwN6sd4qzAZQcyujWTL3olcKLXCX3cO2D2vPIsn0=;
        b=cM6q8b/4pKLdGSuYf0jrm2ABvnY5lzTpBAeMOGl1mMOsiOxjPHcGhYH0zqLipq+77o
         ZA8YWeKAP6LoHdzfpo/rlFWsm1U29cBEdf64HxGsBvtiKdws/WtCMnCQP7vphmLje6Wo
         diJnLrq5Mp9NXiHgxQhvcaMJAn40mOVsr35fvLCjxotLHlAcAj1fU+Fp5qGOQNNKVtRn
         k8ckGonXBKc1TmKjrt/3ZwI2l0wr7auvUQyB/2VlMtmG1wgmE4F39wRbWMuTv/82L/0g
         ARkUVel4xg4a/gb7z8ntACNtCy0ybEGkoEU63uSg/AQRMO58uDSq9z+gv9zC61L8Qmwq
         rP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712865795; x=1713470595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSdJwN6sd4qzAZQcyujWTL3olcKLXCX3cO2D2vPIsn0=;
        b=SCZAVGdMeAyCLXklyUMFdz0zGzhxA08yFT6AV8Gr4QtREV7eo6tPQT1p2uFWcLTKiZ
         tYiCWsYvvS+C3lvQClex2pUAdASmK+3hyEx922H7cXkZ3I2YdFyKcVRWyDUcy+q66bLP
         v+TaUiIhGMEAjfcbtzBaQGx0H7Z0gg++jG9QVd2Nip2hFWTrND/hutPNGsJJsaumtYvI
         5NFz3FiT9ovOF0gc3O42jnkap71APVt/vbFS5bBUMCcvgABHbZiH7VfyqZyMwAp+6/Jc
         nLYoa0ZHDWtNDaEFzkYTCFPyBi7uibQBVsI0gnM8Lo+tCXqRIQ/2J4wqJWlf70wCIenC
         B+ow==
X-Gm-Message-State: AOJu0YxRCqsSBLuWebPPfcq0xAKrBQAT0VA63VY/bhwVQaE/qqNotIBI
	ph9Gb6vsogexuq/6znM/GScZfmXtYRA6iWX0EWOYJhpj3LHqDju0xq7d3Q==
X-Google-Smtp-Source: AGHT+IEsDlP5sL65NZP4hBh8L/atK41N78yQ8ptv2/trkfJBQILXW58oZiYga2dRP2P1zmbIjtw2mA==
X-Received: by 2002:a05:6808:4396:b0:3c6:64e:a9ec with SMTP id dz22-20020a056808439600b003c6064ea9ecmr654363oib.58.1712865794820;
        Thu, 11 Apr 2024 13:03:14 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id da2-20020a056130230200b007e6b31e535asm268110uab.29.2024.04.11.13.03.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 13:03:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/4] bap: Update properties of endpoints
Date: Thu, 11 Apr 2024 16:03:05 -0400
Message-ID: <20240411200305.183703-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411200305.183703-1-luiz.dentz@gmail.com>
References: <20240411200305.183703-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a MediaEndpoint if found during registration stage attempt to check
and update properties since they may have been updated at later stage
when a session has been attached.
---
 profiles/audio/bap.c | 48 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index db0af7e7cba5..30049f0fb3a7 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -92,6 +92,9 @@ struct bap_ep {
 	struct bap_data *data;
 	struct bt_bap_pac *lpac;
 	struct bt_bap_pac *rpac;
+	uint32_t locations;
+	uint16_t supported_context;
+	uint16_t context;
 	struct queue *setups;
 };
 
@@ -376,9 +379,10 @@ static gboolean get_locations(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct bap_ep *ep = data;
-	uint32_t locations = bt_bap_pac_get_locations(ep->rpac);
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &locations);
+	ep->locations = bt_bap_pac_get_locations(ep->rpac);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &ep->locations);
 
 	return TRUE;
 }
@@ -387,9 +391,11 @@ static gboolean get_supported_context(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct bap_ep *ep = data;
-	uint16_t context = bt_bap_pac_get_supported_context(ep->rpac);
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &context);
+	ep->supported_context = bt_bap_pac_get_supported_context(ep->rpac);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&ep->supported_context);
 
 	return TRUE;
 }
@@ -398,9 +404,10 @@ static gboolean get_context(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct bap_ep *ep = data;
-	uint16_t context = bt_bap_pac_get_context(ep->rpac);
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &context);
+	ep->context = bt_bap_pac_get_context(ep->rpac);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->context);
 
 	return TRUE;
 }
@@ -1261,6 +1268,31 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	return ep;
 }
 
+static void ep_update_properties(struct bap_ep *ep)
+{
+	if (!ep->rpac)
+		return;
+
+	if (ep->locations != bt_bap_pac_get_locations(ep->rpac))
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						ep->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"Locations");
+
+	if (ep->supported_context !=
+				bt_bap_pac_get_supported_context(ep->rpac))
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						ep->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"SupportedContext");
+
+	if (ep->context != bt_bap_pac_get_context(ep->rpac))
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						ep->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"Context");
+}
+
 static struct bap_ep *ep_register(struct btd_service *service,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac)
@@ -1289,8 +1321,10 @@ static struct bap_ep *ep_register(struct btd_service *service,
 	}
 
 	ep = queue_find(queue, match_ep, &match);
-	if (ep)
+	if (ep) {
+		ep_update_properties(ep);
 		return ep;
+	}
 
 	ep = new0(struct bap_ep, 1);
 	ep->data = data;
-- 
2.44.0

