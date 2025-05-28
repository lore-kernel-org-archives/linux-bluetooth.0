Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165FC13AF2
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442088; cv=none; b=ZvOazf4Dl+sQHxeOGS0w0PROVxjsmbwAHRRHW1D3MJsHG2zgSrGTGl1KY2tWPIfKojywevY2Yl6KmkwQa0MCdMFn7gJ9MK9psAZEqmOL+dTVk1sUugP87CoZEniPSzRjTohC54KHjzMizTGnD2aK25tuH95CVbfmDP7zLqxYvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442088; c=relaxed/simple;
	bh=K99dIhdaGHnkE8nCbboB/1PzEiCa6a2bHkdOhHe+eic=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Iu0cyENQkIP84TDVFV/aJByQbK+mUDaCoyeGAHlc9Sx09eIkk+1Ab5k2ooZrZnRNzh3CuSkK/gt2Vbj6K/sGKVCMYMD6IeuMKu6/tyh0VYLq7pPzkKfv9+/5DOswwwhIbYN/0WusCbACyzQtsGMtrA6qFIZ53w5xzeFpA7lr7JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aflW0Laf; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aflW0Laf"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6faa9e72827so46528976d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748442085; x=1749046885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDI59oSCQ/6+C3h+FWv+qJDZZqKNvfzNb0NAval4sSE=;
        b=aflW0LafDCIxwLRsIyWsvCBMXQa9KFQ5y3hTk1QMwFFIo3buG9DjWkiBRgG6Ri4uOV
         8kxmsctmO83N2ogaojyu2nu3icT1LAhq2A+q++j9/SYE0HcobKFJfKpmgbEKbtFGfLot
         gFhw6AQZZMguQXI8unRJ8cCAl6t3luIeAkzYYDSJ3lMHv4tfdu6gvXlXlLLavM4Mklfl
         cJgbkO52d5xc8M0qvnLbf0bMgJ9rF/H7nzCPm6SADOhs5woEyZv+OHVZ7FwiGo82WiNs
         jEa1uZ0l25U4JxfbkRyDl4LOJF4VyO6jW6i/1hg5sshhagGQXjh5rXY8jOZlEbdo85YK
         Dehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748442085; x=1749046885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDI59oSCQ/6+C3h+FWv+qJDZZqKNvfzNb0NAval4sSE=;
        b=qWeNYnzAcxueoALRHucHbKjmiGnGytlzjy1qVQ+BW3p5VyaZ+VIGUEUUqbhwaBFGRt
         dvu4lTTGzQGcX+YTKIA5pUn5j5xx58H9Xv1MXOui1Gix9vFLBq2PzNNpZe4vDD0RJVUP
         z/XRV0L0w2SqOtH91mRb2YiPUBl6u4HvEsuEWFCN1Zcb2ptO9N5zIYPnUzaM2TD2okQX
         emoFnfBVJ2iLvbHRdSpPMq2WWeI2xvoBciJb8bHEw2jhFcB5o1ttY6U5BDMUy0hiEQVF
         H1GG1RrNd8ajO7B0BVaNswJwbRklQEntrezZMYwTIJKr9fJF6N2bWkS5mOYQWSP2jPh6
         Xd8A==
X-Gm-Message-State: AOJu0YzhPS6kxr2C7oL+h1naqys1c71AyxEcmteoPVoRuJU6wJyj8HnF
	Bx4QQOSK2FFuZRj5LbA6iMUkxq3ZKQZWxLH3cE+Cv/ZkQ1HcZj8M6c39fTEjVg==
X-Gm-Gg: ASbGncu3pKqdFdMy1Ev2AEzm8cq0Na/Otci19gduk4hqlq3WIEEmzF61O1R5ESJwhUI
	dGoNmcUxF/pRLYpbLmHqB2TDmW6cauINweqS04LlcCZb9YrHDlBgrxgODt4ochientNBgzNbNbH
	ioBNsQOTb4oxg3cZgvBMwb9BQlQjD1mWK0Ij1vYsuyRRdsHbMd/4qwOPOyzR0zhL1UIb3PPn2hw
	6PaznpO/CV/2A94wAhZCeWJ4P9m1HFk8NWiNIeMYjmLAWS6XHosuiG/zDA7WGvQ005CD4B+NIGW
	pBN8D+RrozqhbLhV7qvBSQ7cuuFHePVaqHrnYmJuuw05VhXQlx94wu2STz1JNjnWWQ9SCf29DDq
	eXl9YzbRrWJIItYj3cxHK
X-Google-Smtp-Source: AGHT+IHWZfGKrTqxEoUw4bSKckHS1EdFvuyjiknuFLL19vYpoXZbrzOzZcyJ3U6kaCZjRQBFwkUBTA==
X-Received: by 2002:a05:620a:4081:b0:7c5:3e89:c6df with SMTP id af79cd13be357-7ceecbad441mr2365053285a.12.1748442074741;
        Wed, 28 May 2025 07:21:14 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e1efd0ef3sm926127241.5.2025.05.28.07.21.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 07:21:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] audio/player: Fix not being able to register players of different types
Date: Wed, 28 May 2025 10:21:12 -0400
Message-ID: <20250528142112.434989-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When registering players both AVRCP and MCP were using the same object
path making them clash, so this fix it by adding a type to the object
path so each profile can register their player in their own domain.

Fixes: https://github.com/bluez/bluez/issues/1290
---
 profiles/audio/avrcp.c  | 2 +-
 profiles/audio/mcp.c    | 3 ++-
 profiles/audio/player.c | 5 +++--
 profiles/audio/player.h | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2d7b4e1e7ddf..831f1dc8bf12 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3577,7 +3577,7 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
 
 	path = device_get_path(session->dev);
 
-	mp = media_player_controller_create(path, id);
+	mp = media_player_controller_create(path, "avrcp", id);
 	if (mp == NULL) {
 		g_free(player);
 		return NULL;
diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index 0a2991f2074f..2808674cf3a7 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -342,7 +342,8 @@ static int mcp_accept(struct btd_service *service)
 
 	bt_mcp_attach(data->mcp, client);
 
-	data->mp = media_player_controller_create(device_get_path(device), 0);
+	data->mp = media_player_controller_create(device_get_path(device),
+							"mcp", 0);
 	if (data->mp == NULL) {
 		DBG("Unable to create Media Player");
 		return -EINVAL;
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 52844c9c07a3..86e59bc8e231 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1277,13 +1277,14 @@ void media_player_destroy(struct media_player *mp)
 }
 
 struct media_player *media_player_controller_create(const char *path,
-								uint16_t id)
+							const char *type,
+							uint16_t id)
 {
 	struct media_player *mp;
 
 	mp = g_new0(struct media_player, 1);
 	mp->device = g_strdup(path);
-	mp->path = g_strdup_printf("%s/player%u", path, id);
+	mp->path = g_strdup_printf("%s/%s/player%u", path, type, id);
 	mp->settings = g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free, g_free);
 	mp->track = g_hash_table_new_full(g_str_hash, g_str_equal,
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 5e181591c0f4..dcd7df286ee1 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -61,7 +61,8 @@ struct media_player_callback {
 };
 
 struct media_player *media_player_controller_create(const char *path,
-								uint16_t id);
+							const char *type,
+							uint16_t id);
 const char *media_player_get_path(struct media_player *mp);
 void media_player_destroy(struct media_player *mp);
 void media_player_set_duration(struct media_player *mp, uint32_t duration);
-- 
2.49.0

