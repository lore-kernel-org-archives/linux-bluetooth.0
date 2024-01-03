Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C521D54B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy1/qKC+"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e6c8b70766so92570997b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 12:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315086; x=1704919886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHn3fv0dSrcRp385CccshSU/CT10sO6+J+wQmntFtxc=;
        b=Dy1/qKC+3FOwunwjq20IiROv9dcZKtgGO9WKGrweumq50ruwIrwlyemP0N6aP+Nk4J
         gsuNHVOazaWPY4ZHJbY126+sb99Jt4ZBHEIjRI88njxOWdntF+VRXiIWUlf04gJEz9kn
         yP5G0baRpLUwEdFABDHPmAUwL0tnFg78YRiXLI3kpkk++5u21vofEj+q9rKtWJMKrzDy
         P1tSb1LxXU8E4BprvCb46pD1z1WfFACIOQo9wDLtAyCo8+Vm0m7OHoniCEmZ9mgz+ir4
         2mlRkmvWBt91jNnzkwxV2QfCjpPDY3rLGg4noUWNJ5uzXPSMIJoBN8LOrJkZpEUuJut6
         yRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315086; x=1704919886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHn3fv0dSrcRp385CccshSU/CT10sO6+J+wQmntFtxc=;
        b=c85R5renWQ8RQA+BB8GzhJlJ1bq0SZ7qnVznsGeJwyWbb+PCGapxcgshXp5pzpdLmZ
         52oVUiXWpt0c3X95Phd+9T1Umx02gMralQx6kdIrNZY/DhvsHFcXnEKifU2U7rbaj32F
         QPRWWHcVCfluBTgsgo6enIhaG8QhfO4DS+V+WaP7Z8Bkgqx941K/Swd365qOy7ouYhiB
         eKy2V+ol8s0gCngFmqfD27m6k/Xbr/vtoz6izSm2z5AZwtrxTja41tCFqCb7kg7PR5S3
         m3al7c0zcKBBq/ooR+Xfeqczz9z5VONPp0XhPYuHSuiN5l54u0aG3LhkjUZBPkrxiX0C
         /sNQ==
X-Gm-Message-State: AOJu0YzOKuOZ0LFodDDEnec5FHTOfPUVKiRaMmI5ceDLDWh+U6ZN7VI9
	9jO0uy+AFj+LKDbKG9GV9F+Xa1axF7w=
X-Google-Smtp-Source: AGHT+IGrvajLemj5QCnRyOl85kMEJ2so/St+8IkOHb1NC/ySW58CLZQwDzs/ChvoMqK2DcJW9pp0IA==
X-Received: by 2002:a05:690c:4047:b0:5ef:6f5c:c693 with SMTP id ga7-20020a05690c404700b005ef6f5cc693mr4561262ywb.28.1704315086158;
        Wed, 03 Jan 2024 12:51:26 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id d13-20020a81ab4d000000b005e71fbbc661sm12997084ywk.143.2024.01.03.12.51.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:51:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] audio: transport: Fix crash on A2DP suspend
Date: Wed,  3 Jan 2024 15:51:22 -0500
Message-ID: <20240103205124.3839768-1-luiz.dentz@gmail.com>
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

