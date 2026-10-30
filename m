Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367869;
	b=WgMaTpT2NtXljW2ITiKoPc3FWzmGfUVvb+0e5oxwhBOQkXqwhk/nOIrbfhFobV5OK42P
	 jambSNnKv5Phc+7ALJ6s/T8w7wbTcckqGyYu6+XrikmfyB2n9+YvGWvzC44m7NpccBVhR
	 ZHYECEDK+Vc0KklaCb7790+gcokkBVwJyYT7Yv0GNt1SSMVTXZszbPitB6/kV1dtMKQcJ
	 eLxgFrWP/j0qYDJyFQZ9Qn+B80KsXcryOx1KJ0GZEU9zD9EjOPNJoZ7Q50SnkzrOwbgU5
	 fA5QArSj3o1aZSrBmiLpwc0XRnBVt3VBljq5nDDoP9KNLX8Te86pMjJVEXta074c1Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=l5A4Rf9vYNsAC89purt1CgMvJ45V1kxpIPQzYh4toZQ=;
	b=2t1GFJtgjqQNeiKU5zYtNX+9bp9gV49X/4A1Y9xg/RhB7DemEq5S4sppKd3Yt4u4B+ro
	 d2YVED8JBt7dzibWrd/Gd8ImRAayg97/GgpBsIKBYUdXy4tdn2Dxv4bblgo3OusdTj2hi
	 u0oz2CGtYkYKQnAYyoKOrjGKqzQijh7vmctritMnyGvBf4O/1IvSgtSzpDb21c+TL+RjU
	 ZclAGNWhjEg9NUzOKJCcMgy9LQ8PrxErArtaraiEhkPPK2P3Ibj+cEb9gWKVZtWh6zxza
	 3ATLDCPWWZ3b5OaGVpqgeabXJOzf50J34IWvslZb4buWAwv9eIR6wxmpZnXcz2fdBTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VImjInxz;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D800606A31F
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 13:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D800606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VImjInxz
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso216541e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793367868; x=1793972668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l5A4Rf9vYNsAC89purt1CgMvJ45V1kxpIPQzYh4toZQ=;
        b=VImjInxz3HWpuX7TaS0WXBLhmM8JY4nsprd7Xoh+Jae8TKaYLRBDdI7vkBWLzvRcTL
         rfmvVHBPBYGWj9CXqRhG9bSeBEgAxHBcqyKGxu0Pnm+4qQ7UXnGbJnxyh06O5T0hsnyk
         Xx+dbOEaRVDHqnKhwg+m5zmiCduto7yO21C1Ntj7heagMalU/7HLfFXBRxSgx++fuNAe
         DgoTnilgIoHMnXpRf+NgEDB3d2WpE4orH1DHSgii1UGM8dKc8wCKLu62cmU/4BfQVq3U
         lqjKT8ElQBrtzhl36qWYCK+qay1QBbA5ANfsAzmKjdiqfA6r5no+3LXuSJmRZr99n1kQ
         v52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793367868; x=1793972668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l5A4Rf9vYNsAC89purt1CgMvJ45V1kxpIPQzYh4toZQ=;
        b=Yti9rXxxusUb4Wlak4gxP8Cm3QUWihROcuX0vpjBud2/JsONhqHnmdJ8yWKyCgGvWE
         21o3tyKZA/HD+/w9mG6kU2T7K86ZYNI1ClKESpVl2fYUDSd11CMQpKDt1MdnAgZy2ghl
         UEuzOxDKZA1L+b4lbIJzYHPufL/mJtrcAcN9yQFgc9QXfhgbQwgVZgENWZglzDWc3RJg
         cO4ceP5DkeVdtzW02a4cMfSW5QGJOGIzZ8oQT69fGOPqxQSHR4ARmOTB8rjumP8bUO30
         kcIp54lPstLN/CIuDsnpVbDlUUhBIQygBuql6nrFY7pOfNIyhaRet2HhF0dNrsR5j9Fr
         MsMg==
X-Gm-Message-State: AFq9FYJU+U9k9P4lolpeKxRC9z2qDUZf0ifeIQztQSQqx7rDqBGgduPF
	+2KQgx2pDhKRjv3YUyql5cO7/m0x1V66wvK4UudcQ3uVzzjcz0TLz0L3SpDCjA==
X-Gm-Gg: AYBFou25iFit20Pzwg+uYY+Z0EocibwrnAyNU4Jv5YE7hiEEQotnnBczJqrPJJ3IoEE
	TpA5clSq1krTqy1ExHH2znL2YnuvEFawsPkYLLtjaSY9tEL1G1piXl5zK1Kg/Uib4ZViNmIuOct
	rdtXHdZElQaVFFWa/7n+8IhL2IEh7zFMf+mJQG0fYnCMQSbAyAw/896bISOHRVvpWHLTfcqWxtA
	jZQt5ckA5I3I7KaCXYkNO2KcffDyHH3MTztpUcRzZCnDn2wNNvCcyZfL1uFGOkRwjiTukz/O4ze
	opecE8toKx9RghdNgzSHzeLZ9YnyblhEDrCkTGkhIv6/Ve2hz/XQEKfd2vA6X5j5HrSrl6hAtau
	7tnopmhAnDlv45z5VxQxL1GJr9lOrk570vyiz78JTPwzWhxjvs+e8kli+h/SfWmr2YXv2icD1FA
	7d5ArApkWHVWje/MhVkiWqoaSyY/hQg6/TgrxIOq8F9EsujGp0iXr5elAgYi1G7EMxmAbpI8xpa
	m2Xz/JLBUx8y8YSNvuzYvxbjiX4GALMddMK3oKuqomo2D7NaMa3HJFeHgpfwZRPonbuu3nvyqjj
	jl2VKO/lWcA5MsR3isRdmmn1aU9xeUD8wgLYvZjst/LMoX+8TJeXc7+W9oLtDu9/NvqhyTDpcsl
	dpRzCb6U6OUbushE+/x538Pj4YLKRRf8rdK/New+q67GCYQNGMufaT74lkbUgdraWGOz1i+Uq7C
	H1diw=
X-Received: by 2002:a05:6122:1d46:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5ec68295940mr1255810e0c.0.1793367868117;
        Fri, 30 Oct 2026 06:44:28 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bb872dsm2541474e0c.6.2026.10.30.06.44.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:44:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/timeout: Fix use-after-free when a timeout removes itself
Date: Fri, 30 Oct 2026 09:44:26 -0400
Message-ID: <20261030134426.420979-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the callback of a timeout_add() timer removes it, e.g. the tester
test timeout restarting it for teardown, its data is freed before
timeout_callback() reads the id, and the id may already be reused by a
timeout added in the callback, which then gets removed instead.

Keep the data while the callback runs and free it afterwards if it was
removed, and add a unit test for it.

Fixes: efe0efc925db ("shared/timeout: Add timeout_add_seconds abstraction")
Assisted-by: OpenCode:claude-opus-5.5 valgrind
---
 src/shared/timeout-mainloop.c | 23 +++++++++++++++++++--
 unit/test-mainloop.c          | 38 +++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.c
index e6f9c5e826b3..3dfcdee8143d 100644
--- a/src/shared/timeout-mainloop.c
+++ b/src/shared/timeout-mainloop.c
@@ -20,14 +20,28 @@ struct timeout_data {
 	timeout_destroy_func_t destroy;
 	unsigned int timeout;
 	void *user_data;
+	bool running;
+	bool removed;
 };
 
 static void timeout_callback(int id, void *user_data)
 {
 	struct timeout_data *data = user_data;
+	bool ret;
 
-	if (data->func(data->user_data) &&
-			!mainloop_modify_timeout(data->id, data->timeout))
+	data->running = true;
+	ret = data->func(data->user_data);
+	data->running = false;
+
+	/* The callback removed the timeout, so data was only kept around to
+	 * be checked here and its id may already be reused.
+	 */
+	if (data->removed) {
+		free(data);
+		return;
+	}
+
+	if (ret && !mainloop_modify_timeout(data->id, data->timeout))
 		return;
 
 	mainloop_remove_timeout(data->id);
@@ -40,6 +54,11 @@ static void timeout_destroy(void *user_data)
 	if (data->destroy)
 		data->destroy(data->user_data);
 
+	if (data->running) {
+		data->removed = true;
+		return;
+	}
+
 	free(data);
 }
 
diff --git a/unit/test-mainloop.c b/unit/test-mainloop.c
index 70ee03ee4283..b876e0285907 100644
--- a/unit/test-mainloop.c
+++ b/unit/test-mainloop.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 
 #include "src/shared/mainloop.h"
+#include "src/shared/timeout.h"
 
 
 #define test_failed_msg(msg) \
@@ -153,6 +154,42 @@ static void test_timeout(struct test_data *data)
 	check(data->destroys == 1);
 }
 
+static unsigned int self_remove_id;
+
+static bool readded_callback(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->new_calls++;
+	mainloop_quit();
+
+	return false;
+}
+
+static bool self_remove_callback(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->old_calls++;
+	timeout_remove(self_remove_id);
+	check(data->destroys == 1);
+	check(timeout_add(1, readded_callback, data, destroy) > 0);
+
+	return false;
+}
+
+static void test_timeout_remove_self(struct test_data *data)
+{
+	mainloop_init();
+
+	self_remove_id = timeout_add(1, self_remove_callback, data, destroy);
+	check(self_remove_id > 0);
+	check(mainloop_run() == EXIT_SUCCESS);
+	check(data->old_calls == 1);
+	check(data->new_calls == 1);
+	check(data->destroys == 2);
+}
+
 #define define_test(name, function)				\
 	do {							\
 		static struct test_data data = {};		\
@@ -167,5 +204,6 @@ int main(int argc, char *argv[])
 	define_test("Test Modify File Descriptor", test_modify_fd);
 	define_test("Test Re-Add Other Callback", test_readd_other_callback);
 	define_test("Test Timeout", test_timeout);
+	define_test("Test Timeout Remove Self", test_timeout_remove_self);
 	return 0;
 }
-- 
2.56.0

