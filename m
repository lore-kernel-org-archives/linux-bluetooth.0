Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E612F362
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219880; cv=none; b=F3MKxV/dzMInIuKYe57boA8oHUpyGX27W32BTgmLx0gwd00v5xbXTDl7Qs/P9TA7syF2UH/hqzTNVHj3MDQadJGyjHkdoMupB1pWwBUakhIgj+miAa6XpWryLBm0pr+SBz0x/vNLN0vrUUxlDvRxJriLVIjACCvZdw/v0UQArgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219880; c=relaxed/simple;
	bh=xf6lzH5ZlI6OSYqVk7QbIjGy/QnvL1aon4/QFLMqawI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b61SPt5wYgfkFM5T/aAPtrocr8y4jg+HeWXhsS7NdG0MeHAbdfbov8+UiInCXfX1UMTzdRtBJCCzJh0rhDeqzRYczmfB8VFiIYJaE9HOX4x1G9+yOzyIcQeCrUCjbSu+vNVFsyD9iFdWBdfpMgw1pf+bKTS4Aw4eU0kUSU+FUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP2wEdvw; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP2wEdvw"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1aa86fb60so467162b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709219877; x=1709824677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdLdAvY23IptEzfjPVuitG5f1jjNfAz4ujuHKWIIC/w=;
        b=EP2wEdvwpNPJ55Oz2b/42aslE3t9kJdnlS2W4cmrsBeBauHrX9UaGtS6r0X6fKqIdI
         ncXbWIPpQs4Suse/ZNJiuBV+Uwe2Pn9my5leh2+uz0t+lxjQ33v2WaPDoNCLJhoXt+nC
         65z1oShbiro0qeoofej/2NaecoOn0WqJ8mr8SD7+TAW07LmKLStTnfr1L98EZIn1eu/V
         we2vi+MyUOOxg+rTF61B+OwO66vyAZ3J5UXtdtSNbPxBJuo9UZ7zZLUHTnX86UJ6ZHsg
         oCBPj+rBm0bRRALNcL8vbOQ+B4kIa4OQlB3II6q8isVa2mA3Wxa25XWOEWP37IXZoBH1
         7d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219877; x=1709824677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdLdAvY23IptEzfjPVuitG5f1jjNfAz4ujuHKWIIC/w=;
        b=YZUrk+jTU/O+O5JQ3wZ1snHaozKWRWKrOzhFWnX/RYFWBiWj1mHNQsr9ViCEeWUHn8
         ODNWn5x4uRA9VSICX62n4YMWS1OaOuKPz7UHmokFjYxm93Fzxog8gw/fqqMqz1JcYtK5
         rj8tDsLI+O/OMoFW7v8RaOFa69NlC27Q/x0/aWGOx5rkMjJWOSHSjT+E+GQSsXaDilRq
         mY7JjM1274iU7nG76NyN5xPQrP/yS0dd2rzWbA6w91Cq4a46QNWoAepK3hPUE3bvqc/g
         oNvtMBjti75nMYVOBVQvVf79bfKSCqbepJd5cAuxV0kIaynKV2pTDH8IxqbN/ozRWcY3
         8zPg==
X-Gm-Message-State: AOJu0Yykuxuyw+TVRx8D2/OsAClYpYOeOR2ZJTdEQp/IamyoXuiwa+0j
	EIAaIUweT04RbyhDRFXAp1lPKW6YWOewIMWASPm0IubDzwHbuLr6emy+A0la
X-Google-Smtp-Source: AGHT+IGjq2a2MZ2s6zt1j0W5/JkNsZs1FsAYCY8z8/7LVRAH+E+UuJJ4GKaKmxWEISfqPrxIBhtaFw==
X-Received: by 2002:a05:6808:2c5:b0:3c0:34b4:ee0f with SMTP id a5-20020a05680802c500b003c034b4ee0fmr2119489oid.53.1709219877275;
        Thu, 29 Feb 2024 07:17:57 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id il2-20020a056130600200b007d92d4c48fdsm222092uab.11.2024.02.29.07.17.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:17:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Remove bt_bap_stream_bcast_new
Date: Thu, 29 Feb 2024 10:17:55 -0500
Message-ID: <20240229151755.2589489-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is now handled internally by bt_bap_stream_new by detecting if an
ATT session has been attached.
---
 profiles/audio/bap.c | 11 ++-----
 src/shared/bap.c     | 74 +++++++++++++-------------------------------
 src/shared/bap.h     |  6 ----
 3 files changed, 24 insertions(+), 67 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 6cac99140217..de687ae224bb 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -68,11 +68,6 @@ struct bap_setup {
 	struct bt_bap_qos qos;
 	int (*qos_parser)(struct bap_setup *setup, const char *key, int var,
 							DBusMessageIter *iter);
-	struct bt_bap_stream* (*stream_new)(struct bt_bap *bap,
-					struct bt_bap_pac *lpac,
-					struct bt_bap_pac *rpac,
-					struct bt_bap_qos *pqos,
-					struct iovec *data);
 	GIOChannel *io;
 	unsigned int io_id;
 	bool recreate;
@@ -893,13 +888,11 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
 		setup->qos_parser = setup_parse_bcast_qos;
 		setup->destroy = setup_bcast_destroy;
-		setup->stream_new = bt_bap_stream_bcast_new;
 	} else {
 		/* Mark CIG and CIS to be auto assigned */
 		setup->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
 		setup->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 		setup->qos_parser = setup_parse_ucast_qos;
-		setup->stream_new = bt_bap_stream_new;
 	}
 
 	if (!ep->setups)
@@ -965,7 +958,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	setup->stream = setup->stream_new(ep->data->bap, ep->lpac, ep->rpac,
+	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
 
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
@@ -1300,7 +1293,7 @@ static void setup_config(void *data, void *user_data)
 	 * and PHY.
 	 */
 	if (!setup->stream)
-		setup->stream = setup->stream_new(ep->data->bap, ep->lpac,
+		setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
 						ep->rpac, &setup->qos,
 						setup->caps);
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0931c8fa249f..37a44cd3dc37 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5163,7 +5163,7 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return 0;
 }
 
-struct bt_bap_stream *bt_bap_stream_bcast_new(struct bt_bap *bap,
+static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
 					struct bt_bap_qos *pqos,
@@ -5245,66 +5245,20 @@ struct bt_bap_stream *bt_bap_stream_bcast_new(struct bt_bap *bap,
 	return stream;
 }
 
-struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
+static struct bt_bap_stream *bap_ucast_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
 					struct bt_bap_qos *pqos,
 					struct iovec *data)
 {
-	struct bt_bap_stream *stream;
-	struct bt_bap_endpoint *ep;
+	struct bt_bap_stream *stream = NULL;
+	struct bt_bap_endpoint *ep = NULL;
 	struct match_pac match;
 
-	if (!bap)
+	if (!lpac || !rpac || !bap_codec_equal(&lpac->codec, &rpac->codec))
 		return NULL;
 
-	if (!rpac && (lpac->type != BT_BAP_BCAST_SOURCE)
-		&& queue_isempty(bap->remote_eps))
-		return NULL;
-
-	if (lpac && rpac) {
-		if ((rpac->type != BT_BAP_BCAST_SOURCE)
-			&& (!bap_codec_equal(&lpac->codec, &rpac->codec)))
-			return NULL;
-	} else {
-		uint8_t type;
-
-		match.lpac = lpac;
-		match.rpac = rpac;
-		memset(&match.codec, 0, sizeof(match.codec));
-
-		if (rpac)
-			type = rpac->type;
-		else if (lpac) {
-			switch (lpac->type) {
-			case BT_BAP_SINK:
-				type = BT_BAP_SOURCE;
-				break;
-			case BT_BAP_SOURCE:
-				type = BT_BAP_SINK;
-				break;
-			case BT_BAP_BCAST_SOURCE:
-				type = BT_BAP_BCAST_SINK;
-				break;
-			case BT_BAP_BCAST_SINK:
-				type = BT_BAP_BCAST_SOURCE;
-				break;
-			default:
-				return NULL;
-			}
-		} else
-			return NULL;
-
-		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if ((!match.lpac) || (!lpac))
-			return NULL;
-		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
-			return NULL;
-
-		lpac = match.lpac;
-		rpac = match.rpac;
-	}
-
+	memset(&match, 0, sizeof(match));
 	match.lpac = lpac;
 	match.rpac = rpac;
 
@@ -5326,6 +5280,22 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	return stream;
 }
 
+struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
+					struct bt_bap_pac *lpac,
+					struct bt_bap_pac *rpac,
+					struct bt_bap_qos *pqos,
+					struct iovec *data)
+{
+	if (!bap)
+		return NULL;
+
+	/* Check if ATT is attached then it must be a unicast stream */
+	if (bt_bap_get_att(bap))
+		return bap_ucast_stream_new(bap, lpac, rpac, pqos, data);
+
+	return bap_bcast_stream_new(bap, lpac, rpac, pqos, data);
+}
+
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index fa0d4b524ffd..2c3550921f07 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -244,12 +244,6 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_qos *pqos,
 					struct iovec *data);
 
-struct bt_bap_stream *bt_bap_stream_bcast_new(struct bt_bap *bap,
-					struct bt_bap_pac *lpac,
-					struct bt_bap_pac *rpac,
-					struct bt_bap_qos *pqos,
-					struct iovec *data);
-
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream);
 uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream);
 
-- 
2.43.0

