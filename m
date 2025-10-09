Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32D2848AC
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045405; cv=none; b=HER3gg0sMlsKeOXCRJUdbzc0gPhzx88G3aDlG8BY3iuJMGAmHWk7196+PZzWQFrGUrsOiz03wqBE8tx9LDNBk6+PH592UYNJKbQdYPq4V0fqdaTfqHy7eFD/FFHZVM3Gi3/TiqWtRVes6ImXvI6v50rrQA6W9GqMNnRtnLv2o5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045405; c=relaxed/simple;
	bh=vkdekGD2lDlAmfwAeU4IdPYIJ6dudgJd2dc1CftMM7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0C0HalVsih52tzZ/8MwO8f9pBUjJ288EGT34Whmh8QkkIOo1mQSx+WNzZLg7jcAybMULRr3AQ5fuUibP+zvRrEobtQ0WYwnvPU3qQJTDiBq7W7dzOFNhQXzPT2pItqF08m26tT5QQyBl+1gTvpNzzFYtX44jLyPV3Rk4/ObwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6SMgzRN; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6SMgzRN"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54bbb587d6dso843659e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045402; x=1760650202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERLw+poKrd2DyTQQ0RzzTla+ABQDWwEocqOEKoFTjsE=;
        b=L6SMgzRNs3rpkmatY2u0BFbYinBd4MJ807AZ1BeKWHPNe2Z9bMNRMC+LEjg38y8fUL
         BYz3s/WsMp9ppiHirBjdQ/nxqP/CB2ifDrK6fAaYJa0rCVbWCpAnltOS4+blaWkS5KBu
         ncf5PzTOeY90bTsgecB8iR8tG/rGa43VShXh0+bJX7y/uay3JqbN0WUylyxtWkKOaPth
         gbNj+NF3nyUvNtat3WvSAqpED6FoRiw3qCEAO9zqP9RBoFB6kKRYYLqTFYmiFl9POKqV
         9Nk9cUedfItjkHqMMd08HsV4n+wRCCU6bLjMqNtz0ZYRNjEX2RwiIqNoKAFrqHFv6wVO
         Vv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045402; x=1760650202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERLw+poKrd2DyTQQ0RzzTla+ABQDWwEocqOEKoFTjsE=;
        b=DO+pkgxHO/wP0r3qkPrtWS8MdSnukKXFAyIJ/cgWIjezEd2TrKF7nO2BHVOfFVzM1u
         JKGHhoZ9s86vXYYCUB4iRkmqtavkE2mllfmfbG07o1oycojjIoA8go8PD034nO3+6gyB
         gYJCs8o0zSFaQO2D42o4CFIxCJLKA3G0NittUUnAdF6JJaRTp+fk2sSzmRiAfl85AQdo
         2BvA7r8QPYDdJNW8LmuFZVly49Co0jxpmJpetTkIga2CfldNQ5vyBg3YnlZ9ajOom0nE
         in7gi5TW5CiavX47w4RX34YGeeUTAkLhFLtHvNLCGW2ZXP9Y8jzvwlfPWo0xH+TgGKBG
         eVWA==
X-Gm-Message-State: AOJu0YzpPo42yhz3Op/jWGj94yctgAoUBV+U4+9N1Nht9oxc19hiQNdC
	tZL50uV8uZYp36ogV2ZHRbpbHHM6XcGMZ+A+8JYdiRXkqBYeiu7Ho+e5Edek28fP
X-Gm-Gg: ASbGncty6D111zAvrVl85Yi2U1Or9o1M4FSXM0U/XztFTcEOmKLDtiCbSaNU9Jc2T4R
	tsqWfcU8i09Q4FfJwsCJsAf0WGDO1L/TusbQ3tNl9EnxvUJWZqcZ+LuirRrZAbfBe3/s6C3WMOy
	bZ1vj85uNlxVqyYuZr/Xu80/sebOrKSsUZbvZ91CwFLY6jblpQfVe3UgnA4xcH8ldUfTrnbd5U8
	mzzaqlgRzD1GGZwQgB3jpqxFKHqAg5BwB7konMdPI9VOpoe/hpNYmsdx6jZNJb7nLMOYbedUl7/
	WEY0CzCjRsFzFr2PZrgJCcA/Ycs3w00yhFBpMpDqsH0F8wevFqlPtE/6sltX5n3JcQ5lNydIJoO
	pyOZQesfLVUCEK/u6DMz3x4oZDEcgHeL3IGW3CFM8yk1TNzgfDR29w77zlKtWwnIgeovrvQawlH
	pWSPtXH0yBYbXCkQ==
X-Google-Smtp-Source: AGHT+IFl9HRWgAWRxYvvQ/4VgMB2LJAx/ydl4iAaC+/bA2fFZlIpBAhjVhJoShho5R7dkL7YmNNiFA==
X-Received: by 2002:a05:6122:1d16:b0:54a:9f40:ac85 with SMTP id 71dfb90a1353d-554b8adf217mr4046157e0c.5.1760045401599;
        Thu, 09 Oct 2025 14:30:01 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.29.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:29:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/13] shared/bap: Add callback broadcast instances
Date: Thu,  9 Oct 2025 17:29:27 -0400
Message-ID: <20251009212931.445719-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_bap_register have a dedicated callback for broadcast
instances and also fixes bt_bap_stream_io_get_qos to handle broadcast
streams.
---
 profiles/audio/bap.c  |  2 +-
 profiles/audio/bass.c |  2 +-
 src/shared/bap.c      | 59 ++++++++++++++++++++++++++++++++++++++++---
 src/shared/bap.h      |  4 +--
 unit/test-bap.c       |  2 +-
 5 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 2994881ccc1d..b2711359952b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3897,7 +3897,7 @@ static int bap_init(void)
 	if (err)
 		return err;
 
-	bap_id = bt_bap_register(bap_attached, bap_detached, NULL);
+	bap_id = bt_bap_register(bap_attached, NULL, bap_detached, NULL);
 
 	return 0;
 }
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 537c9206a71c..ee1257702638 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1815,7 +1815,7 @@ static int bass_init(void)
 		return err;
 
 	bass_id = bt_bass_register(bass_attached, bass_detached, NULL);
-	bap_id = bt_bap_register(bap_attached, bap_detached, NULL);
+	bap_id = bt_bap_register(bap_attached, NULL, bap_detached, NULL);
 
 	return 0;
 }
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 9b7395223c67..2b99b23488fa 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -98,6 +98,7 @@ struct bt_bap_bcode_cb {
 struct bt_bap_cb {
 	unsigned int id;
 	bt_bap_func_t attached;
+	bt_bap_func_t bc_attached;
 	bt_bap_func_t detached;
 	void *user_data;
 };
@@ -4524,13 +4525,13 @@ static void bap_free(void *data)
 	free(bap);
 }
 
-unsigned int bt_bap_register(bt_bap_func_t attached, bt_bap_func_t detached,
-							void *user_data)
+unsigned int bt_bap_register(bt_bap_func_t attached, bt_bap_func_t bc_attached,
+				bt_bap_func_t detached, void *user_data)
 {
 	struct bt_bap_cb *cb;
 	static unsigned int id;
 
-	if (!attached && !detached)
+	if (!attached && !bc_attached && !detached)
 		return 0;
 
 	if (!bap_cbs)
@@ -4539,6 +4540,7 @@ unsigned int bt_bap_register(bt_bap_func_t attached, bt_bap_func_t detached,
 	cb = new0(struct bt_bap_cb, 1);
 	cb->id = ++id ? id : ++id;
 	cb->attached = attached;
+	cb->bc_attached = bc_attached;
 	cb->detached = detached;
 	cb->user_data = user_data;
 
@@ -5643,6 +5645,17 @@ clone:
 	return true;
 }
 
+static void bap_bc_attached(void *data, void *user_data)
+{
+	struct bt_bap_cb *cb = data;
+	struct bt_bap *bap = user_data;
+
+	if (!cb->bc_attached)
+		return;
+
+	cb->bc_attached(bap, cb->user_data);
+}
+
 bool bt_bap_attach_broadcast(struct bt_bap *bap)
 {
 	struct bt_bap_endpoint *ep;
@@ -5655,6 +5668,8 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
 
 	queue_push_tail(sessions, bap);
 
+	queue_foreach(bap_cbs, bap_bc_attached, bap);
+
 	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb,
 				BT_BAP_BCAST_SOURCE);
 	if (ep)
@@ -6769,6 +6784,36 @@ static void bap_stream_get_out_qos(void *data, void *user_data)
 	*qos = &stream->qos;
 }
 
+static void bap_stream_bcast_get_out_qos(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_qos **qos = user_data;
+
+	if (!stream)
+		return;
+
+	if (!qos || *qos || stream->ep->dir != BT_BAP_BCAST_SINK ||
+				!stream->qos.bcast.io_qos.sdu)
+		return;
+
+	*qos = &stream->qos;
+}
+
+static void bap_stream_bcast_get_in_qos(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_qos **qos = user_data;
+
+	if (!stream)
+		return;
+
+	if (!qos || *qos || stream->ep->dir != BT_BAP_BCAST_SOURCE ||
+				!stream->qos.bcast.io_qos.sdu)
+		return;
+
+	*qos = &stream->qos;
+}
+
 bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 					struct bt_bap_qos **in,
 					struct bt_bap_qos **out)
@@ -6785,13 +6830,19 @@ bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 		bap_stream_get_out_qos(stream, out);
 		queue_foreach(stream->links, bap_stream_get_in_qos, in);
 		break;
+	case BT_BAP_BCAST_SOURCE:
+		bap_stream_bcast_get_in_qos(stream, in);
+		break;
+	case BT_BAP_BCAST_SINK:
+		bap_stream_bcast_get_out_qos(stream, out);
+		break;
 	default:
 		return false;
 	}
 
 	DBG(stream->bap, "in %p out %p", in ? *in : NULL, out ? *out : NULL);
 
-	return in && out;
+	return (in && *in) || (out && *out);
 }
 
 static void bap_stream_get_dir(void *data, void *user_data)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index fba8b6b17884..bf166d439935 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -116,8 +116,8 @@ uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
-unsigned int bt_bap_register(bt_bap_func_t added, bt_bap_func_t removed,
-							void *user_data);
+unsigned int bt_bap_register(bt_bap_func_t attached, bt_bap_func_t bc_attached,
+				bt_bap_func_t detached, void *user_data);
 bool bt_bap_unregister(unsigned int id);
 
 struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb);
diff --git a/unit/test-bap.c b/unit/test-bap.c
index c15afe52dbbc..d07652f6ca44 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -1184,7 +1184,7 @@ static void test_server(const void *user_data)
 
 	tester_io_set_complete_func(test_complete_cb);
 
-	data->id = bt_bap_register(bap_attached, NULL, data);
+	data->id = bt_bap_register(bap_attached, NULL, NULL, data);
 	g_assert(data->id);
 
 	tester_io_send();
-- 
2.51.0

