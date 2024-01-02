Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B8156C3
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jan 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3SvbG8t"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7f0bf46a2so78247037b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jan 2024 10:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218840; x=1704823640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHn3fv0dSrcRp385CccshSU/CT10sO6+J+wQmntFtxc=;
        b=D3SvbG8ttAB2iTsNxK8DmxrdZxkn0RC5PL6iecrb/BtW+ea0EzMv+UvcYnAE2PHVtj
         S0XlLPg0KrhOs2VSibQ6ymn03BnDGwGQdZCmzxykFVthmDWJ/kzI6ZK6AtIbh4jZ/ZBb
         yicwCJE+ZLbaiRKDkJvR3nL3OmWo/a1v+7SLuedhdd2BLPSsA0hsMdofrtZv9e/0hEh4
         LPpA2ypWsOg69K0q04yol1LqJyPLW3u77z8KfF/Kt8n915GtBh2UJSKqZARue6JWWJFT
         2ZWKGZc/stCbO64LlEk3Nn+mF7dLDTWJidWbK0UCKhrkLvlOgVQg8d8HdMla81DidmLA
         FVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218840; x=1704823640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHn3fv0dSrcRp385CccshSU/CT10sO6+J+wQmntFtxc=;
        b=wbhiSzGeNb8j0bIEbsDpCgyFi14juoqM352NcAjQE/0AaO3LRlvLBWmbykZlgEIOGb
         /LlTl+f6H4anUMijuJ8TnF05YuCNEgzupQnlKwq2JpFfQZqH94nvwzm7JN2TkOVC5IvR
         oJRyjUn4J04JJJLUQPPatGCI20HHwPM/qepDcY0eQLCFA8vEH64skTabdtRrFksM3Dn5
         8SICe2cnNhTy8XNxxJ17TGKPqCXHdYutDaTegeUz49f7Axmg0NDvkRD5y/RaLUoZ1yKp
         my6m8+mTKXIWQLVclrDmRyEkUTZNzh2TNIRs7b4Abki+O6fQhCiplw5c00J4GpkFYP0A
         xuBw==
X-Gm-Message-State: AOJu0YwZDBjXK2Lflvmfqvh2tZ90jAoKSs4OSNdb+NczzEisA/Qx1UgW
	O3fUYSZLDJeeE8OVik/MW2Azm5/yRlA=
X-Google-Smtp-Source: AGHT+IGDQlnMvHdrfybwbXjY3fZNOZtbWll9PYYyUKCuGrSNoiU2heEDXdd3ykkT5k/zvq585tQk8g==
X-Received: by 2002:a05:690c:2a92:b0:5ec:2c54:5659 with SMTP id ek18-20020a05690c2a9200b005ec2c545659mr1059448ywb.0.1704218839941;
        Tue, 02 Jan 2024 10:07:19 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id q66-20020a818045000000b005e5fff5c537sm12391527ywf.85.2024.01.02.10.07.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:07:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] audio: transport: Fix crash on A2DP suspend
Date: Tue,  2 Jan 2024 13:07:18 -0500
Message-ID: <20240102180718.3735855-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit 052534ae07b8 ("transport: Update transport release flow for
bcast src") introduced a crash where it assumes transport->data always
refers to struct bap_transport which causes a crash when the transport
is in fact A2DP.

Fixes: https://github.com/bluez/bluez/issues/701
---
 profiles/audio/transport.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e2073451cc7a..0c60f06eef36 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -643,7 +643,6 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 {
 	struct media_transport *transport = data;
 	struct media_owner *owner = transport->owner;
-	struct bap_transport *bap = transport->data;
 	const char *sender;
 	struct media_request *req;
 	guint id;
@@ -675,11 +674,6 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	req = media_request_create(msg, id);
 	media_owner_add(owner, req);
 
-	if (bt_bap_stream_get_type(bap->stream) ==
-			BT_BAP_STREAM_TYPE_BCAST) {
-		bap_disable_complete(bap->stream, 0x00, 0x00, owner);
-	}
-
 	return NULL;
 }
 
@@ -1416,6 +1410,7 @@ static guint suspend_bap(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 	bt_bap_stream_func_t func = NULL;
+	guint id;
 
 	if (!bap->stream)
 		return 0;
@@ -1427,7 +1422,14 @@ static guint suspend_bap(struct media_transport *transport,
 
 	bap_update_links(transport);
 
-	return bt_bap_stream_disable(bap->stream, bap->linked, func, owner);
+	id = bt_bap_stream_disable(bap->stream, bap->linked, func, owner);
+
+	if (bt_bap_stream_get_type(bap->stream) == BT_BAP_STREAM_TYPE_BCAST) {
+		bap_disable_complete(bap->stream, 0x00, 0x00, owner);
+		return 0;
+	}
+
+	return id;
 }
 
 static void cancel_bap(struct media_transport *transport, guint id)
-- 
2.43.0

