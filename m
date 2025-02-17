Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B5217716
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792892; cv=none; b=BbjBxv6shd+asngud0Keyjmga+aWR7N8GHTrNoidHpWRQQsNV+q6sPUQXr3+aMUjZy/I6QHZ3/FwLpdDMjqawpYUxD1hfYpUJ1ahepmNHLgF5XZqFVBFuYEfeJihx4mg6j5TDUzk15Ah5zoTNs3VeEG2jnUUcyyPB3tectcmnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792892; c=relaxed/simple;
	bh=akGeh2S6k0vAlqR965lZTpBxe1J6gWIFifeB+LcOi5g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aKavrenPoL8bSkFJrTwJmleHmKfncXXE08m0EXqw+dIXeJjrpVM5U4MQZOJ025SiQwjEWqO+56zS40o/hOhKzhYx5HethPLYvOZkGuK02IQxSDGS3ghgatf/jqI9UZSZaDgOn/i5TA6Ebrl3Qs9m7aKoUHhkEpuJ/f9TSKVlCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ITi74nSQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ITi74nSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739792888;
	bh=akGeh2S6k0vAlqR965lZTpBxe1J6gWIFifeB+LcOi5g=;
	h=From:To:Subject:Date:From;
	b=ITi74nSQfhioaQUYsUBimoxyAxCYN/j6n/TL2lt9GXVmE6JgxmA7ABopCM82cm8/F
	 P5Crc7fRKC6GrnrSw2URyN6PgUCTIWF2/bCs+30yxHmWm2tPSMMR4S+HiRwGjtGhFP
	 sEHWPHc3//bJ1X55r6wyYEXPo3VSjqpBPcqiEOKblT8PPeh73bY9MYGKPt2Gy+CB2/
	 tmEJQ980rlOwd6c43XaOrxMhAPZKoSLb2JvV/P4FMjJcqhaqOCjajFCpHKofksiWn3
	 FA2uvhtNYRkVdNguDCzh+yqtI5RWJhNgilm4K+EVm9SI4gQYAxCVY4OgQ5rkJI/q1A
	 ce9hkkE4F0HsA==
Received: from fdanis-XPS-13-9370.. (2a02-8428-AF44-1001-3634-502c-f5AA-0320.rev.sfr.net [IPv6:2a02:8428:af44:1001:3634:502c:f5aa:320])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 124B417E00F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 12:48:08 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Remove Endpoints cache entries on device removal
Date: Mon, 17 Feb 2025 12:48:02 +0100
Message-ID: <20250217114802.52247-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When a device is removed, currently the endpoints and last used info
are kept in cache:
  [General]
  Name=Frederic's Phone

  [Endpoints]
  01=00:00:01:29f50235
  02=00:02:01:80010484e200
  LastUsed=01:02

This may prevent future connection, after a new pairing, to use the
best codec available.
---
 profiles/audio/a2dp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 0eac151db..81dbbfae3 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -880,6 +880,44 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	g_key_file_free(key_file);
 }
 
+static void remove_endpoints_cache(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	char filename[PATH_MAX];
+	char dst_addr[18];
+	GKeyFile *key_file;
+	GError *gerr = NULL;
+	char *data;
+	gsize length = 0;
+
+	ba2str(device_get_address(device), dst_addr);
+
+	create_filename(filename, PATH_MAX, "/%s/cache/%s",
+		btd_adapter_get_storage_dir(device_get_adapter(device)),
+		dst_addr);
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		g_error_free(gerr);
+		g_key_file_free(key_file);
+		return;
+	}
+	g_key_file_remove_group(key_file, "Endpoints", NULL);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, 0600);
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
+	}
+
+	g_free(data);
+	g_key_file_free(key_file);
+}
+
 static void invalidate_remote_cache(struct a2dp_setup *setup,
 						struct avdtp_error *err)
 {
@@ -3352,6 +3390,7 @@ static int a2dp_source_probe(struct btd_service *service)
 static void a2dp_source_remove(struct btd_service *service)
 {
 	source_unregister(service);
+	remove_endpoints_cache(service);
 }
 
 static int a2dp_sink_probe(struct btd_service *service)
@@ -3366,6 +3405,7 @@ static int a2dp_sink_probe(struct btd_service *service)
 static void a2dp_sink_remove(struct btd_service *service)
 {
 	sink_unregister(service);
+	remove_endpoints_cache(service);
 }
 
 static int a2dp_source_connect(struct btd_service *service)
-- 
2.43.0

