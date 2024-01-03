Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC41D54C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmAX5Beb"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e778e484dbso95436957b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 12:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315089; x=1704919889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lc3ziiYCttAcyDckxBNiuK5nDA3dA+wlrReYUUzx4S4=;
        b=PmAX5Bebex2b6G0ywDdUnOYbzwA/ToLM+FRDWqDodM2hIL0KwC8xITijtG5Jvl0CN0
         fVZCn3lcl5Ugh+Abva0qti9WWKxo2Mjd5HUgCYZ5+wr7hZzklDJvZx04QIW/Hgd8XiMe
         xSGX05JlOIrhCghxMe8EXE3knYBnNwNFShp3sSHo7KsmWrcf7ahEl0UPRPtrUVQCjoYv
         055wzv9PJPcBSsSkRXoP+4jjb/xqNGXS788I0IBuCyirkV0VHWG4g6k8VaGVGPFIzFii
         DC6Ma94btUdmAWLndzSPQhSE0KzPSXSRlUzv2WqBzkZYkEZrdFAIqIroJXBA5AWP5Y0D
         Dz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315089; x=1704919889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc3ziiYCttAcyDckxBNiuK5nDA3dA+wlrReYUUzx4S4=;
        b=Sp3YSE1X9ka0iYRb9ctsgep/KcUqCAYG+Uqw7t3ezoUhhyM4cm4iYcCkPTbx0ccQC3
         h8C2dnTmJFZqk+V2NyFopZXJmgY0Faw4SDMF5onCc0s8yek9azowCAbckY8K6goka2HB
         zVfJWlOLetCnBeqynw5n7+WShaJQJ1VegiMAs+b3eUVirx+4Y7fGbOEgz2PeFPj+nPz5
         Z6qpaDGFIpjFIQGlyb27mT0/s3sQ+GEcJA5MUs+2usVEpcHKts219LxujJsySN3mRVtL
         TZPUAg7Jwrs5W1rjt4Co0u9ig+xr7QBVRmkAvdLg3dAxXoHPItExcgfTyeHBmE93AFQd
         MKWw==
X-Gm-Message-State: AOJu0YyxIXPNtOWM0HqfOByXiKXg97vtLayHp08eR36ysM1ntdSVg0+g
	LacuKyco2USeinaFTbS5qqqP2CcM2os=
X-Google-Smtp-Source: AGHT+IFxVAGxvOtehIBjKUuaVU9tYaFA/4N8/dY9RpmtDmgOniC8xMiInWJqVvPT2mfMX3c9GbqYBg==
X-Received: by 2002:a81:b718:0:b0:5eb:bfac:69c with SMTP id v24-20020a81b718000000b005ebbfac069cmr10221358ywh.45.1704315089296;
        Wed, 03 Jan 2024 12:51:29 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id d13-20020a81ab4d000000b005e71fbbc661sm12997084ywk.143.2024.01.03.12.51.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:51:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] audio/transport: Fix runtime error
Date: Wed,  3 Jan 2024 15:51:24 -0500
Message-ID: <20240103205124.3839768-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103205124.3839768-1-luiz.dentz@gmail.com>
References: <20240103205124.3839768-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following error cause by assuming transport->data would
also be a struct bap_transport:

profiles/audio/transport.c:328:16: runtime error: load of value 2, which
is not a valid value for type '_Bool'
---
 profiles/audio/transport.c | 62 ++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 64b6ec694eb8..a4696154aba5 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -93,6 +93,10 @@ struct bap_transport {
 struct media_transport_ops {
 	const char *uuid;
 	const GDBusPropertyTable *properties;
+	void (*set_owner)(struct media_transport *transport,
+				struct media_owner *owner);
+	void (*remove_owner)(struct media_transport *transport,
+				struct media_owner *owner);
 	void *(*init)(struct media_transport *transport, void *stream);
 	guint (*resume)(struct media_transport *transport,
 				struct media_owner *owner);
@@ -310,10 +314,22 @@ static guint media_transport_suspend(struct media_transport *transport,
 	return 0;
 }
 
+static void transport_bap_remove_owner(struct media_transport *transport,
+					struct media_owner *owner)
+{
+	struct bap_transport *bap = transport->data;
+
+	if (bap && bap->linked) {
+		struct bt_bap_stream *link;
+
+		link = bt_bap_stream_io_get_link(bap->stream);
+		linked_transport_remove_owner(link, owner);
+	}
+}
+
 static void media_transport_remove_owner(struct media_transport *transport)
 {
 	struct media_owner *owner = transport->owner;
-	struct bap_transport *bap = transport->data;
 
 	if (!transport->owner)
 		return;
@@ -325,12 +341,9 @@ static void media_transport_remove_owner(struct media_transport *transport)
 		media_request_reply(owner->pending, EIO);
 
 	transport->owner = NULL;
-	if (bap && bap->linked) {
-		struct bt_bap_stream *link;
 
-		link = bt_bap_stream_io_get_link(bap->stream);
-		linked_transport_remove_owner(link, owner);
-	}
+	if (transport->ops && transport->ops->remove_owner)
+		transport->ops->remove_owner(transport, owner);
 
 	if (owner->watch)
 		g_dbus_remove_watch(btd_get_dbus_connection(), owner->watch);
@@ -541,20 +554,27 @@ static void linked_transport_set_owner(void *data, void *user_data)
 	transport->owner = owner;
 }
 
-static void media_transport_set_owner(struct media_transport *transport,
+static void transport_bap_set_owner(struct media_transport *transport,
 					struct media_owner *owner)
 {
 	struct bap_transport *bap = transport->data;
 
-	DBG("Transport %s Owner %s", transport->path, owner->name);
-	transport->owner = owner;
-
-	if (bap->linked) {
+	if (bap && bap->linked) {
 		struct bt_bap_stream *link;
 
 		link = bt_bap_stream_io_get_link(bap->stream);
 		linked_transport_set_owner(link, owner);
 	}
+}
+
+static void media_transport_set_owner(struct media_transport *transport,
+					struct media_owner *owner)
+{
+	DBG("Transport %s Owner %s", transport->path, owner->name);
+	transport->owner = owner;
+
+	if (transport->ops && transport->ops->set_owner)
+		transport->ops->set_owner(transport, owner);
 
 	owner->transport = transport;
 	owner->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
@@ -1688,12 +1708,14 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 	return bap;
 }
 
-#define TRANSPORT_OPS(_uuid, _props, _init, _resume, _suspend, _cancel, \
-		      _set_state, _get_stream, _get_volume, _set_volume, \
-		      _destroy) \
+#define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
+		      _resume, _suspend, _cancel, _set_state, _get_stream, \
+		      _get_volume, _set_volume, _destroy) \
 { \
 	.uuid = _uuid, \
 	.properties = _props, \
+	.set_owner = _set_owner, \
+	.remove_owner = _remove_owner, \
 	.init = _init, \
 	.resume = _resume, \
 	.suspend = _suspend, \
@@ -1706,24 +1728,26 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 }
 
 #define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
-	TRANSPORT_OPS(_uuid, transport_a2dp_properties, _init, \
+	TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _init, \
 			transport_a2dp_resume, transport_a2dp_suspend, \
 			transport_a2dp_cancel, NULL, NULL, \
 			transport_a2dp_get_volume, _set_volume, \
 			_destroy)
 
-#define BAP_OPS(_uuid, _props) \
-	TRANSPORT_OPS(_uuid, _props, transport_bap_init, \
+#define BAP_OPS(_uuid, _props, _set_owner, _remove_owner) \
+	TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner,\
+			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
 			transport_bap_cancel, transport_bap_set_state, \
 			transport_bap_get_stream, NULL, NULL, \
 			transport_bap_destroy)
 
 #define BAP_UC_OPS(_uuid) \
-	BAP_OPS(_uuid, transport_bap_uc_properties)
+	BAP_OPS(_uuid, transport_bap_uc_properties, \
+			transport_bap_set_owner, transport_bap_remove_owner)
 
 #define BAP_BC_OPS(_uuid) \
-	BAP_OPS(_uuid, transport_bap_bc_properties)
+	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL)
 
 static struct media_transport_ops transport_ops[] = {
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
-- 
2.43.0

