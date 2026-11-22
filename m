Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348168;
	b=xa3k/DRLVrGYSSOE2XogN8X0uovP/2TrBvxBamzs/sYKyw18JJvHE4wqpDfYbjGleVEx
	 db73tWwvrrZS8yH5oSkxPRa3x9SJC6wIa4AYgajE3fGDeXVtGC4u0ZlrRRvkqJKHyHO+A
	 fRl1mwPORN6NunfFvjtmm0Bam04c7Qq1gJGxrKb70BgCh3kvqccKGeaj+YEZmnNCp74t/
	 jjf/K03kBIKSzq+o5OVLwTSn0RYxn18CFZi8RdPpJC1dlIAxzMZzvg1bi8xfuNv1HJ5VU
	 ifLQRUfiRJ4bnGmr8PhNqCgTMvrKhbapVlJYyjxKJeemlnsP3Vt1+yFqh0OBrYfQ96A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3A38uwWX7M0OXNKS4d2x6il4xpmdR7XmMpNdpN2gPYc=;
	b=osMvOCcmGRFywPQXP4NvgSBNQtbPp9tku4+ez1NexisAfh5Tnk63GnVWxpJMjTTJqtQW
	 OQXeUn71w81seKAz9v8X8xARdJjzeHsqSeVZE0quZH8YW44++eDvisOkbVLpvoUxB+RVP
	 2Eh2umqBpXdIDakoQJDZEL9y3kWIJ51WN/Y9tpty6vp6JGsFRxgWR51GO3DLEHJ52IBpv
	 dZ155qTwab1WkV97GVkCAREr+oghBcG2izTTb0fV+TEdTywh9zVQ6l+u1FwPJToOQpH9k
	 xyTwFq5QWwI9JhidTPq3/27Vsm9dIxfQKWW7gqqXE2EdJGDYZQFiVQThesasNzgfk3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="pmPb0lR/";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EA606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F0EA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=pmPb0lR/
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so27894655e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 03:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795348166; x=1795952966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3A38uwWX7M0OXNKS4d2x6il4xpmdR7XmMpNdpN2gPYc=;
        b=pmPb0lR/dcf+2LsX6cxtxwMgbscXn7GGDNC24sbmCbZackj8JOWS/WnRfBf3GYAQP8
         dqu9zUkz+GDe255s5OJuObwJdQgAgh46UueJ0bp0u1UKGo5/PSJ16vrvyZqwKUhJ088R
         XJktXwxfuFV8KbSBQof880xf1RsgNNt2PiZBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348166; x=1795952966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3A38uwWX7M0OXNKS4d2x6il4xpmdR7XmMpNdpN2gPYc=;
        b=GfY7F7NCgRWWVlawt1PpHTL4rdqMHPCGz/Kat2HBoy6admMlgfYtAMXRSPBN7IE3dM
         b7e2cbeu1/Y74xaGbjSvsHv8iszPWS2nmLl4yAszBZLM5r9nta8zjU0ZZrO1TwF1f1dZ
         8HWfAWFX0GqViFRphXaFUpYl03vka3oTdE6y/HdHe1IWgF5Yf1M2oG2Pk6g8egzMGDht
         XknlJUC1/3AQOsCCluvErKEkRgbtK0tdNoUdA6wLIYsJMSYo2X/1azEnNQ97CLUNCnh1
         T8+7UGSYNG06G5WtfZhZuEDLsBU0hYa1C9xUl8hwXjvMXbZl3we5wNQrU4AU1SMPZA/l
         v4cg==
X-Gm-Message-State: APuU4Z+ohRrQH7rQsSamY4xzh9553nkwTcLgEXPqvvaYmgn0hcJUkj2j
	bVzRrAgeaxJDjZnzUn9Z6kENpnecs023pNz0oIgFa15ryDpr18312lSKXR7iNOA3xmKMrsjI2Go
	qABnr
X-Gm-Gg: AZFdTZdp5Rs6G63NXflf0IMg500hAsTecmsSmjGQ+HrWGZz6cyfcJpiUVb8FOFIUoRQ
	jkiUv6xu8McETyCDg6yrMJD9Zcd0ZVgKqLfbqfhkMLnHJaE6UU+yzJR6yKYA0Oha8UPmHZ9aMfr
	/9vui3XpHQv7WRbGUACNoG2vvS8KJrz/FHPQvIsMiWvixXEbGlZIQ0Kep1kYC3k3EGbzh9PQpds
	6sRnPud+2FrJrwuIRQVqS+GJj4/n7LeTFEsnb0A8PrzHisT/1uAstCn1Ht2QJ9pwXGnAQolvC4D
	6UTQex7lsLklvw6K+VmbttvDVYx9ipFLqOWfht+De3n+u4XZOYal7LSKe7zsXFTII3E2WhbYHx8
	oShM5wL9V5GeOZh7ekcy/1dPX60Z1laL8l3I43L1DE6MTqLuOSmwvJgcEPAxSulKMOmz/gktCPB
	ggmb+Eh/et4MSnVsPv79lbKwP5u6xKFCgwqjrKvzRBVyDCGze6fhrAAEWhaNkKIA0n/vZvbJD7U
	09+v2ygnbxuujce7wd51cGgnQX2PJnNEWgqpWH2q9HlYxKVOOALUeVzSghRhxBK2xrC68MuWQpX
	WCGPYp+PtrB7xyxyEsZPIb0bJ/e5ihPfV6ixqvEKuIhcG9W5kQ==
X-Received: by 2002:a05:600c:1d83:b0:4bb:687c:4fbe with SMTP id 5b1f17b1804b1-4bb88805c26mr162182635e9.8.1795348165371;
        Sun, 22 Nov 2026 03:49:25 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb905f1489sm117367905e9.0.2026.11.22.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:49:25 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@gmail.com>
Subject: [PATCH BlueZ] bap: Sync to the BISes of a broadcast in ascending order
Date: Sun, 22 Nov 2026 12:49:18 +0100
Message-ID: <20261122114918.1063391-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Mikuda <simon.mikuda@gmail.com>

The BIS list of a BIG sync is built in the order the transports were
acquired, so when BIS 2 is acquired before BIS 1, the kernel sends
LE BIG Create Sync with BIS 2 listed first. Core Vol 4 Part E 7.8.106
requires ascending order, so the controller can reject the command with
Invalid HCI Command Parameters (0x12). Nothing reports that, so the
transports stay broadcasting and the stream is silent.

Sort the BIS numbers in ascending order. The kernel notifies the BIS
fds in that order, so give each fd to the stream with the lowest BIS
that has no fd yet.

Fixes: e59a915db9d8 ("bap: Remove PA idle timer logic")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 54 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 457ba5de8..98ef26997 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1672,10 +1672,23 @@ static bool stream_io_unset(const void *data, const void *user_data)
 	return !bt_bap_stream_get_io(stream);
 }
 
+static void find_lowest_unset_bis(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_stream **lowest = user_data;
+
+	if (bt_bap_stream_get_io(stream))
+		return;
+
+	if (!*lowest || bt_bap_stream_get_qos(stream)->bcast.bis <
+				bt_bap_stream_get_qos(*lowest)->bcast.bis)
+		*lowest = stream;
+}
+
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_setup *setup = user_data;
-	struct bt_bap_stream *stream = setup->stream;
+	struct bt_bap_stream *stream = NULL;
 	int fd;
 	struct bap_data *bap_data = setup->data;
 
@@ -1685,12 +1698,15 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 		DBG("BIG Sync completed");
 
 	/* The order of the BIS fds notified from kernel corresponds
-	 * to the order of the BISes that were enqueued before
-	 * calling bt_io_bcast_accept.
+	 * to the order of the BISes passed to bt_io_bcast_accept,
+	 * which is ascending, so the fd belongs to the stream with
+	 * the lowest BIS that has no fd yet.
 	 */
-	if (bt_bap_stream_get_io(stream))
-		stream = queue_find(bt_bap_stream_io_get_links(stream),
-				stream_io_unset, NULL);
+	find_lowest_unset_bis(setup->stream, &stream);
+	queue_foreach(bt_bap_stream_io_get_links(setup->stream),
+					find_lowest_unset_bis, &stream);
+	if (!stream)
+		return;
 
 	fd = g_io_channel_unix_get_fd(io);
 
@@ -3902,22 +3918,7 @@ static void append_setup(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
 	struct sockaddr_iso_bc *addr = user_data;
-	char *path = bt_bap_stream_get_user_data(stream);
-	int bis = 1;
-	int s_err;
-	const char *strbis = NULL;
-
-	strbis = strstr(path, "/bis");
-	if (!strbis) {
-		DBG("bis index cannot be found");
-		return;
-	}
-
-	s_err = sscanf(strbis, "/bis%d", &bis);
-	if (s_err == -1) {
-		DBG("sscanf error");
-		return;
-	}
+	uint8_t bis = bt_bap_stream_get_qos(stream)->bcast.bis;
 
 	DBG("Do BIG Sync with BIS %d", bis);
 
@@ -3925,6 +3926,11 @@ static void append_setup(void *data, void *user_data)
 	addr->bc_num_bis++;
 }
 
+static int bis_cmp(const void *a, const void *b)
+{
+	return *(const uint8_t *)a - *(const uint8_t *)b;
+}
+
 static void setup_refresh_qos(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
@@ -3957,6 +3963,10 @@ static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
 	append_setup(setup->stream, &iso_bc_addr);
 	queue_foreach(links, append_setup, &iso_bc_addr);
 
+	/* The BIS list shall be in ascending order */
+	qsort(iso_bc_addr.bc_bis, iso_bc_addr.bc_num_bis, sizeof(uint8_t),
+								bis_cmp);
+
 	/* Refresh qos stored in setups */
 	setup->qos = *bt_bap_stream_get_qos(setup->stream);
 	queue_foreach(links, setup_refresh_qos, data);

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

