Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA46EB5B
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389146; cv=pass; b=fBkGVtcpowVbquUFEcfvW+smzF+qoIysSfjCXsj/xCjoQV86J6aWwtsAivx7gWi80So18+1YUwud22FNRaGj5/2KNQSFEIg9A7mD+2jPyBnme+hKK85sUrEFwiu2K7Plcd8iOY2foWIGP1X4ZCdsk0mb+RfpESZ9Iev6lK7WuNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389146; c=relaxed/simple;
	bh=Sz5i0O4sg5dAfSV23MIpwJ+RqvlorepByZG3UUhZGqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7U82LpzxcA1cH5NHb748aJfayU9R2GCAue+XVodTHGBe688wcpokACHB1I7XGHiKOtdp2vGsxPo3/xbOUfXrURQPBA0P/xVSUeF1zCmsEmqAOZNULYUY9od9AM+FX68ZbvaCtQorJLtkCHxm97g05T05Su3wWNwHL+3PAnwTWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=aqYy+NLl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="aqYy+NLl"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V3L9W1rmTzyVd;
	Mon, 25 Mar 2024 19:52:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1711389135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vxw6imeQohDnHTOzjutyvqYdhVlp9mLTfIewY3DYNBY=;
	b=aqYy+NLlLywFJ3L8niGWsQz3SnCgMmUrnAJXFg+nzAACgHv85Kt821HtfleE8tpr8z1QN4
	cPyM8nglWIy8JwwLehgF/5rSwL6RQUDjivpZGv4kTPsIziL66Bn/0NPbB7rveFtSMtm2/O
	6W+jBFKYFFS4iFaLP/8cU3AmoLZr/d8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1711389135; a=rsa-sha256; cv=none;
	b=RnJII9hjg0miMgWD0Y+etHn/ni1SA7+vuGwpA4i8j4Zhbbl3ZIFUhybgI9vJASyfTZjrNg
	01RNCGnRL2Oh/hNjgfTDzoBrUj2HlYUZ24jBdSVBFLYQJGGReNZtnkUPWzgIqHtg0VEZHA
	x8klXuzWbtEJlhCFaWhPq3Rq64hrUMo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1711389135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vxw6imeQohDnHTOzjutyvqYdhVlp9mLTfIewY3DYNBY=;
	b=d3RpC2NA68CCqe5LP+6/3ipa5Ss5zuszps9vgZ6tEsVg1iE3dne1TCwoVtOEghMBzynEtA
	ILVNzBhgRlit8FyAK/tPIn6zod9gFEAHz2j/uGHTkmPmmUjYyz2mkls8e9LL4If2lAt+wL
	se5qhmRoqG9CDCJbk0yyYwRXZPcIIx0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 1/2] shared/bap: add bt_bap_cancel_select to cancel ongoing pac select
Date: Mon, 25 Mar 2024 19:52:09 +0200
Message-ID: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711389066.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add function and PAC ops for canceling a previously initiated
SelectProperties() call.
---

Notes:
    v3: fix wrong usage of g_slist_next
    v2: cancel the DBus request and callback, instead of ignoring stale cbs

 src/shared/bap.c | 12 ++++++++++++
 src/shared/bap.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a1749153b..f553096df 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5180,6 +5180,18 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return 0;
 }
 
+void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
+								void *user_data)
+{
+	if (!lpac || !func)
+		return;
+
+	if (!lpac->ops || !lpac->ops->cancel_select)
+		return;
+
+	lpac->ops->cancel_select(lpac, func, user_data, lpac->user_data);
+}
+
 static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 9839e3249..62e210485 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -72,6 +72,8 @@ struct bt_bap_pac_ops {
 	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
 			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
+	void (*cancel_select)(struct bt_bap_pac *lpac,
+			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
 	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
 			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
 			void *user_data);
@@ -160,6 +162,9 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			int *count, bt_bap_pac_select_t func,
 			void *user_data);
 
+void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
+			void *user_data);
+
 struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
-- 
2.44.0

