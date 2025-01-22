Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5F1B3948
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580498; cv=none; b=BsxEXqMgnFUy3TmEVt1kgq7h+q3vynSCWyU5PKNgc8I4a9Ty6t975Rhy/CfJyc9fCuYlqMc6ohkO5abPwP3jm2fpuwghsWmFCRlXauzn4lrtzcOnNEAxVeX5LyB3G9Br7pjZVUb5ee9LzWRtQv4k2pMVl7uNekfwMHR4bwh+v6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580498; c=relaxed/simple;
	bh=Zyfn5jv0yUp4+mwXcwxOQyi+UcxZTxXUPMr+s9qeh6I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTrEBgu9VZaYxSJlfbBqQXr58Q0FacPpJOEYqYN5XH2tZyqoNP/FyaugrkuVY0ZpgnsOdlCfNdLaAFJ+jVRa5RYs3xqKgoCiLdMfNLyKfW09lVzaJ3ikUNueYTK++0GWOdCCGsKxct5ERcbNf8UJfeJTisc/MNUAw22bALQ5DIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmS1V/Hi; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmS1V/Hi"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85ba92b3acfso97748241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 13:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737580494; x=1738185294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvSlDHMO9b366TEvAtz8uAV4nGTzzKAQx1FybK7hu+k=;
        b=NmS1V/HiXtqCP7aRgncZJ3FoPlsqKXmj2LoTQDjQ6miYWGUwH7xtjzfxr6uT5oWPTe
         EfHecJvYv1iBVrZW6uspzs6dfM7U9S0ell8bkJl+g8+icRqppV1OV1WJ5ahegIA4vGQ9
         lNxqB2ge6TWO+y3YgcIge8jHp8XFizwDr6wi2A2ZuhbmyJjVNUc4XGju2KghInGEHNJf
         QjRZacV+koMRAWG+xMt9v5f3mBuhP3KKV0zUBUGuBvu/95bc1FLiZpv/opPj5FQZ3lbh
         K9wGtCUrJbPpjZ+BelIzgXkzp5lbXx1mcAg2RHXb829k2Fj5Bja1wTMjV4WEG/7msGGj
         aGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737580494; x=1738185294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvSlDHMO9b366TEvAtz8uAV4nGTzzKAQx1FybK7hu+k=;
        b=BRPLU1onZoAQvwodA43iMFYqzZFhp4bchTIFNGZueAHAxSaBkTfgXitkRMq9xOssDU
         XjTgj+qhEI6oH9aP3O4Hb22TlXf/0akpCm/ZVuQx9wqBXu7AhmNO9LOgoqMQeSG8aT2s
         xeF45grugrR9uV8yqBUEAsbNnJwD7bbLB9YSktIijrhJt5wjoduL9Rg0uXdZRqf5KnX8
         iVBriEOyqcjoaDF+gsRV2D+HDQeUrT3FFMMQlZOLaWj4XqJZZ/FaVHWmYYBe0Bp4vlrU
         50CTLP79qzqWkWuTl8me0L0X/ztQnR/s+7v2NIvjgQNSzceIxujPYPvCkEupLpyhj1Sx
         vuBQ==
X-Gm-Message-State: AOJu0YxRpmoEN7YYSH6lnhEQLTAqq7pbnPjqga0eoXiERcgECrc6F6U8
	WA3N50mtyuVwrJhgvWGO/u8gk4AjvhR1f70xXvzCB9mmn9kHnCmFcPQyJ+g6
X-Gm-Gg: ASbGncuJIE5fFpdeGX5wvrv5bN5U1/QhRvBygMhsVD8IZPglYNfmWHRD818Y2KfeXhf
	YWtbgo6UoC7IfZ4wwPm4dNEy+PRrp8hCJf31nkMfCCPzfQ2YoN+vcPB/k0TD6gMdshX55m28NwU
	noHIE1oajyPYUgdnKKs3U/H4Agst6qrD93kWShk4HEv5H9BramD54CNQiowD0sPo8W+bo9A6Jqe
	2zfYCSRQrpnhoTKH3tMi+TMCg8725k9zHYyOQJ5YK9vqW3OLDiZrYLNoUVggdOOuIPb8kzzsTjE
	UdHTiMDeMiYzElmFZbZIAKuW+nCTvdtBcRP9d/v6Mw==
X-Google-Smtp-Source: AGHT+IEC1W0xFUIPVRoZ604ltgoelZBJSoAxq5vGTO6JcA/Lm5bB6y9+jfPie+AVvso6KRy6tjR4cA==
X-Received: by 2002:a05:6102:3f41:b0:4b2:5ca3:f82a with SMTP id ada2fe7eead31-4b690bb6273mr20769431137.7.1737580493401;
        Wed, 22 Jan 2025 13:14:53 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b68a21dae2sm2840665137.13.2025.01.22.13.14.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 13:14:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] vcp: Fix using scaled values for volume
Date: Wed, 22 Jan 2025 16:14:46 -0500
Message-ID: <20250122211446.142626-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122211446.142626-1-luiz.dentz@gmail.com>
References: <20250122211446.142626-1-luiz.dentz@gmail.com>
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
 profiles/audio/transport.c | 14 +++++++-------
 profiles/audio/vcp.c       | 23 +++++------------------
 profiles/audio/vcp.h       |  4 ++--
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index eff95a7c2655..4635c978bd80 100644
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

