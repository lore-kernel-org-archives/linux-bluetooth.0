Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD615A843
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737665661; cv=none; b=Xq1hrH4Idq3i5Zk2B+Qpb1Xhq5ErghgoUCuqv6VhK/JbqWMLBXG31pPaY+1/OfaFgqTDZOhqnkjNbW1hSjK7CT2I2taJBLPzlWgrpMrJqLQWxUBM3TG1gqZQA04u/AM0DKPuLldR5xDwuk2tT2OTrVti8LD9quMUidWgBrzlSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737665661; c=relaxed/simple;
	bh=xks9dU4Ws5ivr6AAqJoFfOeCQoK6jUiylHXld01x8DQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVti+DfxtnEFszRpjvSCxPIR3OfIETQia/iuYYOJ0IByNFd4A0ecD9qsS7wN0USNFc0UMZtZqlEjjEMA8rz9u+AL2Ng4cxBDpyg3fZERV7XaRvpKxO3pqfHxxHf9wKJolnnqz28X+KnXHmZadz/cajA8pGE9ttK5QzpCzEMyR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnohRlWQ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnohRlWQ"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85c5a91374cso676289241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737665658; x=1738270458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o18U4c6mryZ2s1oVZh+Hi0T1U0ebN1hM9+Dx57hL+A=;
        b=CnohRlWQJ6ljcm0CIGEUWaMwXxdLgAE7wqyg8fPXMrnAC/9iBcVmN0DnDkUAbfimT4
         +Wf1mOpWsavD9tZOX37mXPP/+ksLUl4BCK7BJi/Xc5F3w0fzVgbR5rVoKFpeybZ3QkeO
         JvR/czq5jZMesgHIXW1SvMtjIObmbd8WWvMJn5TMik6e5uSEbFcwjCI5lEOceCxC359y
         eJWqZmdRjDsKU0W0dbNztM9n0NewrHvcLl/bQOS5HKXYl2cHpGJg+3jmxPyEfBZZJCMu
         y82qJYkoLgyDu5osKVUOFWYp19JIbvTAxBBVgypVHwThbWkaI6LkDCuW278axI+MLgpR
         mXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737665658; x=1738270458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o18U4c6mryZ2s1oVZh+Hi0T1U0ebN1hM9+Dx57hL+A=;
        b=db7wnzduAwtGqlUNN+rMG3fPmACloNK1GwHg7NU8OcePvZ8QSA3zaVQXcF+6vT3wZW
         kbrerr4O5capTZEBtmRXYYZXVHBBrw2fAAehLinfCfovqsAK9zs/gYhY6Wv/85abGbdj
         QzddaRw5VMuZPOOHW7Cc16Hp3pHD05K6YZ8TtFCUkl0CqqHC1n42/XDov8IVPHSsRo3W
         GXxEaD81BhP/2GT0MQP57o6fMH4qaD0hAfgB/5utosOT2uFY4WaS6zWzuR051qkpAKad
         jWGQu00cs6peJzuB0OlSHfM/Jpp/WjMFA6zVaGj6TcOC8RhKsJsDX7sud19WL5Rg9+3M
         dOGQ==
X-Gm-Message-State: AOJu0YwzttsJprbM+gPkEBcO1WZbBbCIueY3x4SU32jFQ9NgoQPV4Dkv
	qNMTiM5dBOwhZFgzgz+EEGpX5Ql6Pzk9tLik7BKd5Kt25yAzqKaWV+TI8sms
X-Gm-Gg: ASbGncu7SS0PcCH/Rp5IgsPkjDMbpNADQp+X+OVCQwBbvFNKMXDhHvs15atkQAkIpiB
	khtj0Jtki+o0pc4MlKNLIiwnoCWpgyD2vR34tUijLmHLJ3UnhhO7FyY0aNrGiLxOwtdDRFaTCn0
	8JMrr6mlzTF9YajvwNpuQnYSzedbwXiPw449gAx7ubfFbiHk9jKAvkC4U7Djc4Y5p4d7Un7ZxvN
	CyEXLXrvLu5Kd2zI51LIJgeJQpiqipzmOuunEkNdRbMWVVyQOH469kPTD4VGq0wAPGfXysDamqM
	bwxvNKc8qhcFoaWE8IKqB1+8HZwoPgxBqLGHNJ2EuBA8Aexd66gW
X-Google-Smtp-Source: AGHT+IGmzimd38N3N0oG8NbL6+KRUGgQr1Ir0WwO2v3egWPAJLqh9SeYYgE4Pt79BI4xFdH/zpRLwA==
X-Received: by 2002:a05:6102:2923:b0:4b6:1a64:1c95 with SMTP id ada2fe7eead31-4b690cf1487mr24307379137.22.1737665658172;
        Thu, 23 Jan 2025 12:54:18 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-864a9c3e360sm66240241.28.2025.01.23.12.54.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:54:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] vcp: Fix using scaled values for volume
Date: Thu, 23 Jan 2025 15:54:11 -0500
Message-ID: <20250123205411.369041-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123205411.369041-1-luiz.dentz@gmail.com>
References: <20250123205411.369041-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the volume range 0-255 as per VCP spec rather than scaling it
to fit 0-127.
---
 profiles/audio/transport.c | 18 +++++++++---------
 profiles/audio/vcp.c       | 23 +++++------------------
 profiles/audio/vcp.h       |  4 ++--
 3 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index eff95a7c2655..5fd20910f745 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -126,8 +126,8 @@ struct media_transport_ops {
 	void (*set_state)(struct media_transport *transport,
 				transport_state_t state);
 	void *(*get_stream)(struct media_transport *transport);
-	int8_t (*get_volume)(struct media_transport *transport);
-	int (*set_volume)(struct media_transport *transport, int8_t level);
+	uint8_t (*get_volume)(struct media_transport *transport);
+	int (*set_volume)(struct media_transport *transport, uint8_t level);
 	int (*set_delay)(struct media_transport *transport, uint16_t delay);
 	void (*update_links)(const struct media_transport *transport);
 	GDestroyNotify destroy;
@@ -616,7 +616,7 @@ static void transport_a2dp_remove_owner(struct media_transport *transport,
 	a2dp->cancel_resume = FALSE;
 }
 
-static int8_t transport_a2dp_get_volume(struct media_transport *transport)
+static uint8_t transport_a2dp_get_volume(struct media_transport *transport)
 {
 	struct a2dp_transport *a2dp = transport->data;
 	return a2dp->volume;
@@ -624,7 +624,7 @@ static int8_t transport_a2dp_get_volume(struct media_transport *transport)
 
 #ifdef HAVE_AVRCP
 static int transport_a2dp_src_set_volume(struct media_transport *transport,
-					int8_t level)
+					uint8_t level)
 {
 	struct a2dp_transport *a2dp = transport->data;
 
@@ -635,7 +635,7 @@ static int transport_a2dp_src_set_volume(struct media_transport *transport,
 }
 
 static int transport_a2dp_snk_set_volume(struct media_transport *transport,
-					int8_t level)
+					uint8_t level)
 {
 	struct a2dp_transport *a2dp = transport->data;
 	bool notify;
@@ -2190,13 +2190,13 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	bap_update_links(transport);
 }
 
-static int8_t transport_bap_get_volume(struct media_transport *transport)
+static uint8_t transport_bap_get_volume(struct media_transport *transport)
 {
 	return bt_audio_vcp_get_volume(transport->device);
 }
 
 static int transport_bap_set_volume(struct media_transport *transport,
-								int8_t volume)
+								uint8_t volume)
 {
 	return bt_audio_vcp_set_volume(transport->device, volume) ? 0 : -EIO;
 }
@@ -2355,7 +2355,7 @@ static void transport_asha_cancel(struct media_transport *transport, guint id)
 	}
 }
 
-static int8_t transport_asha_get_volume(struct media_transport *transport)
+static uint8_t transport_asha_get_volume(struct media_transport *transport)
 {
 	struct bt_asha_device *asha_dev = transport->data;
 	int8_t volume;
@@ -2370,7 +2370,7 @@ static int8_t transport_asha_get_volume(struct media_transport *transport)
 }
 
 static int transport_asha_set_volume(struct media_transport *transport,
-								int8_t volume)
+							uint8_t volume)
 {
 	struct bt_asha_device *asha_dev = transport->data;
 	int scaled_volume;
diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index 608496a003b6..423210b4af3b 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -103,25 +103,12 @@ static bool match_data(const void *data, const void *match_data)
 	return vdata->vcp == vcp;
 }
 
-static int8_t scale_volume(uint8_t volume)
-{
-	/* Convert 0-255 to 0-127. */
-	return volume / 2;
-}
-
-static uint8_t unscale_volume(int8_t volume)
-{
-	/* Convert 0-127 to 0-255. */
-	return volume * 2;
-}
-
 static void vcp_volume_changed(struct bt_vcp *vcp, uint8_t volume)
 {
 	struct vcp_data *data = queue_find(sessions, match_data, vcp);
 
 	if (data)
-		media_transport_update_device_volume(data->device,
-						      scale_volume(volume));
+		media_transport_update_device_volume(data->device, volume);
 }
 
 static void vcp_data_add(struct vcp_data *data)
@@ -179,22 +166,22 @@ static void vcp_data_remove(struct vcp_data *data)
 	}
 }
 
-int8_t bt_audio_vcp_get_volume(struct btd_device *device)
+uint8_t bt_audio_vcp_get_volume(struct btd_device *device)
 {
 	struct vcp_data *data = queue_find(sessions, match_device, device);
 
 	if (data)
-		return scale_volume(bt_vcp_get_volume(data->vcp));
+		return bt_vcp_get_volume(data->vcp);
 
 	return 0;
 }
 
-bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume)
+bool bt_audio_vcp_set_volume(struct btd_device *device, uint8_t volume)
 {
 	struct vcp_data *data = queue_find(sessions, match_device, device);
 
 	if (data)
-		return bt_vcp_set_volume(data->vcp, unscale_volume(volume));
+		return bt_vcp_set_volume(data->vcp, volume);
 
 	return FALSE;
 }
diff --git a/profiles/audio/vcp.h b/profiles/audio/vcp.h
index f313cd96a5fc..cf7935d1a4ea 100644
--- a/profiles/audio/vcp.h
+++ b/profiles/audio/vcp.h
@@ -8,5 +8,5 @@
  *
  */
 
-int8_t bt_audio_vcp_get_volume(struct btd_device *device);
-bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume);
+uint8_t bt_audio_vcp_get_volume(struct btd_device *device);
+bool bt_audio_vcp_set_volume(struct btd_device *device, uint8_t volume);
-- 
2.48.1

