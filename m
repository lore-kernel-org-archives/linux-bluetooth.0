Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51EB1586CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563245; cv=none; b=nnkaCpRPKa+YIvTbmY6wuZhb6ZJTww+Jbl7I+dmF/JkQZDJAvs+basAF2uaCtqGxGo7NU3vJ7fxB1HonMf2plUMEn6HL65/BTcn+YHi7Qe2qfBEsQgf5cgz70L2fZNrpmV1kDe9XlR8kbtnq95v7Uv+3Y53UoRZmi4bBCCVsNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563245; c=relaxed/simple;
	bh=RWpqGRSkRSWk4lEGJPCW6tyR94TT26E8WeuDofH4bmU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoMZYSir7eEF3AZehyKhzwr0Yu1nlBqmhyHsNsdvZniGQv17Xkugv57txvvamWfTogIAbDPCXxrYCmROy/k2jYcs/lfN8KJEzYW8BCjI8CeNds8svZLCrJHCBAb8ZqVKUv3UDHfdA1sDWrMa/IKxxKWI6I8VLPkv+iixkLsNOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYiUlGBr; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYiUlGBr"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ffb07bed9bso28359357b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 13:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706563242; x=1707168042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdjgSjuG0kj725tEWVKb219DZuYi5FEEepM+fHB8AJI=;
        b=GYiUlGBr5jSX6qvFloDSk5Yqx+NIryCN0U6y6lqywLvl3sv/Bf0FnQDFLLHAtwSzbb
         jCgkiF29+bLjTz/p1c6sAJliOzebS7Zwde0BE5G1N6fGKN5Pl9FKSbi8HLEqmdnXpSNm
         NTee3oBqpBbVc4+HqYdCpzTu0ManWpRpbB+rTcKgq7tos7mgK/1pYftVCk5cXT4m13RV
         QA4gMjadlR0j+LRZsXoSDlm5Mz5Rhhks+P6yW+ZREVvxpUYQXCCRzU2EcgM+3gLJrArk
         jDnkWrWNMaX0XaYhV3duwlu1kYBcIbL8OrAwksQji8l7Q9ScdPjn2IEqBpc9Pxk56O0U
         gm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563242; x=1707168042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdjgSjuG0kj725tEWVKb219DZuYi5FEEepM+fHB8AJI=;
        b=U21ZmMR4W/KJSOG1KVSJgqicLrZW1WFkrbVGGb5FvXsX1ZdBzHbjh/Bv5bh5DQWJq/
         zhQFGI/MFLXJcMr7bQGs2qp+CGZRH5x7WqOxNiEbbkmmmkK3fhFERHEeVyiGwj+6RsXu
         M/0l1NydOHMoOjLBOZHssTHPbsG/bpWR1tHQIn1E0FzvwDSpGHqwPDGZduhx6HUEZ3nF
         4QV1W24tsk/FCbHgNyt78FX6Q73X5o8gcuAT+r3cgiKRsLMHMykjli5FGbcyPZc+jCTf
         0WV/ig84LFMEzrOWjUV3rTxgwG/BCI/+4JyrvTSPvhGLwrFItrpU+NgJ5nH8CaW65LH4
         Igpw==
X-Gm-Message-State: AOJu0YzaAzGYBH9/0kndHNyTjSEjaOMYPosJyDQt+iP963Q5+JWYkT19
	2TadXGRC7QP9cJXaZm+chJfa72wfPg4vpFunevKUuhZSIXkFGRrz7PAAE23B
X-Google-Smtp-Source: AGHT+IGnOIVJNgr+eycqg/F2g1ceLRf26hD07ZmK+j/Y7ZJiWe3vLlpsP2Nu4GuF6Qq8KJnzDRt0tw==
X-Received: by 2002:a81:9104:0:b0:5ff:b07b:9a57 with SMTP id i4-20020a819104000000b005ffb07b9a57mr4143024ywg.72.1706563241850;
        Mon, 29 Jan 2024 13:20:41 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l198-20020a0de2cf000000b005fff75780f3sm2704904ywe.66.2024.01.29.13.20.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:20:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] client/player: Use util_iov_dup/util_iov_free whenever possible
Date: Mon, 29 Jan 2024 16:20:35 -0500
Message-ID: <20240129212036.163298-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129212036.163298-1-luiz.dentz@gmail.com>
References: <20240129212036.163298-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses util_iov_dup/util_iov_free whenever possible.
---
 client/player.c | 73 ++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/client/player.c b/client/player.c
index f6b2278d5a8f..b37ed20d7275 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2166,7 +2166,7 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	cfg->ep = ep;
 
 	/* Copy capabilities */
-	iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
+	cfg->caps = util_iov_dup(&preset->data, 1);
 	cfg->target_latency = preset->target_latency;
 
 	dbus_message_iter_init(msg, &iter);
@@ -2182,8 +2182,7 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	}
 
 	/* Copy metadata */
-	if (ep->meta)
-		iov_append(&cfg->meta, ep->meta->iov_base, ep->meta->iov_len);
+	cfg->meta = util_iov_dup(ep->meta, 1);
 
 	if (preset->qos.phy) {
 		/* Set QoS parameters */
@@ -2887,17 +2886,8 @@ static void endpoint_free(void *data)
 {
 	struct endpoint *ep = data;
 
-	if (ep->caps) {
-		if (ep->caps->iov_base)
-			g_free(ep->caps->iov_base);
-		g_free(ep->caps);
-	}
-
-	if (ep->meta) {
-		if (ep->meta->iov_base)
-			g_free(ep->meta->iov_base);
-		g_free(ep->meta);
-	}
+	util_iov_free(ep->caps, 1);
+	util_iov_free(ep->meta, 1);
 
 	if (ep->msg)
 		dbus_message_unref(ep->msg);
@@ -3380,20 +3370,18 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 static void endpoint_set_metadata(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
+	struct iovec iov;
 
 	if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
-		free(ep->meta->iov_base);
+		util_iov_free(ep->meta, 1);
 		ep->meta = NULL;
 		goto done;
 	}
 
-	if (!ep->meta)
-		ep->meta = g_new0(struct iovec, 1);
-
-	ep->meta->iov_base = str2bytearray((char *) input, &ep->meta->iov_len);
-	if (!ep->meta->iov_base) {
-		free(ep->meta);
-		ep->meta = NULL;
+	iov.iov_base = str2bytearray((char *) input, &iov.iov_len);
+	if (iov.iov_base) {
+		util_iov_free(ep->meta, 1);
+		ep->meta = util_iov_dup(&iov, 1);
 	}
 
 done:
@@ -3404,22 +3392,21 @@ done:
 static void endpoint_set_capabilities(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
+	struct iovec iov;
 
-	if (ep->caps && ep->caps->iov_base) {
-		g_free(ep->caps->iov_base);
-		ep->caps = g_new0(struct iovec, 1);
-	} else
-		ep->caps = g_new0(struct iovec, 1);
-
-	ep->caps->iov_base = str2bytearray((char *) input, &ep->caps->iov_len);
-
-	if (ep->caps->iov_len == 0x01 &&
-			(*(uint8_t *)(ep->caps->iov_base)) == 0x00) {
-		g_free(ep->caps->iov_base);
-		ep->caps->iov_base = NULL;
-		ep->caps->iov_len = 0x00;
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
+		util_iov_free(ep->caps, 1);
+		ep->caps = NULL;
+		goto done;
 	}
 
+	iov.iov_base = str2bytearray((char *) input, &iov.iov_len);
+	if (iov.iov_base) {
+		util_iov_free(ep->caps, 1);
+		ep->caps = util_iov_dup(&iov, 1);
+	}
+
+done:
 	bt_shell_prompt_input(ep->path, "Enter Metadata (value/no):",
 					endpoint_set_metadata, ep);
 }
@@ -3495,12 +3482,13 @@ static void cmd_register_endpoint(int argc, char *argv[])
 
 		cap = find_capabilities(ep->uuid, ep->codec);
 		if (cap) {
-			if (ep->caps)
-				ep->caps->iov_len = 0;
-
 			/* Copy capabilities */
-			iov_append(&ep->caps, cap->data.iov_base,
-							cap->data.iov_len);
+			util_iov_free(ep->caps, 1);
+			ep->caps = util_iov_dup(&cap->data, 1);
+
+			/* Copy metadata */
+			util_iov_free(ep->meta, 1);
+			ep->meta = util_iov_dup(&cap->meta, 1);
 
 			bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
 						endpoint_auto_accept, ep);
@@ -4129,7 +4117,10 @@ static struct endpoint *endpoint_new(const struct capabilities *cap)
 	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
 					g_list_length(local_endpoints));
 	/* Copy capabilities */
-	iov_append(&ep->caps, cap->data.iov_base, cap->data.iov_len);
+	ep->caps = util_iov_dup(&cap->data, 1);
+	/* Copy metadata */
+	ep->meta = util_iov_dup(&cap->meta, 1);
+
 	local_endpoints = g_list_append(local_endpoints, ep);
 
 	return ep;
-- 
2.43.0

