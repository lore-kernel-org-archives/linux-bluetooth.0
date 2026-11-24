Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522757;
	b=vAQnxqjldnH/Y3qJh24NJU3XMuIiLifXESyNLF6PFkPbVMwPdoiiJmYfleBk0pZ9gM+q
	 L7XNmjEX0bsJzKhRf9qvHjXz07RJLCrdmmDbC3z4caJeEIuVfZLZtaIibEKngYqvK/yI2
	 fUmBwpZYmrT783gGsrRFgQpbDxuz1ZpjRpaG3PugdiNmI6xSZ46Ku+N6H1Ch9H9B4dU4x
	 T+4gASuuB+DekKL6fDatYfBBcItVDkCC1welfRTtxRJk1zHjPa7+9BR2jtGWpQM5/AC05
	 WhcgbSPaO+rq7xgu574Nr8mBkv1gcGiZCjh2Xs0bmZ44mIyMZb7lx0pKzhc5NrlEsUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lpI5sdjNNELC66nEWFczL9aM7GGgky1ZCN22mO1d7jc=;
	b=zaN/BtcOQX/cGmpxyUE0OhEYl13YQyz7YTEuZt7XTSoXDbnC9h6kpY0VM3bPQipXhSJ+
	 A9uWcFq6CstiY1nmv1ySDNc1TK43qFR7vtOE56FVsnh9+3+hqmjJqFjjDvmCRNZaD3Rb0
	 +4hev1srE8/YuKQFxWdzi9kinHj5ANJWXqgBtuWhVj6Nw2Kj+Y50Rq0gBzKnLP/UnufeQ
	 ZJZJEzrHQdkhel2Nj/wWCCVfDyR5+K9bmZI3Nl79MxjuADtWOrcPCn2O9KydPjflrlc1l
	 QyVJgotiJuJs+VZPuPbUQb39shDcH60Agz0mDTopaIClbux6+Yvf4/OlVbVg0vgxuYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=nb9K4h6E;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1D5606A334
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB1D5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=nb9K4h6E
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so36935425e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522755; x=1796127555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpI5sdjNNELC66nEWFczL9aM7GGgky1ZCN22mO1d7jc=;
        b=nb9K4h6EiLWwb25BCPRaEROLVBOZkfXW0lM98URe84cJkL7g5Zwzw8PiWMS4iAtfpL
         IR92F+z8Xh8zM7Fmqoxptz0JeLXTCDiTQ2d/AeFU/tjgmDpz8FMrzb8N+cXIP9inentV
         bv0iXy32RrgjWqh9JhL0JN/GZfygF3mi2nXJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522755; x=1796127555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lpI5sdjNNELC66nEWFczL9aM7GGgky1ZCN22mO1d7jc=;
        b=bEUXaGXruG1xoici7hTsuC2t6vqLzpEtbV8iUzQyVrmz2cMA0O97tH0Fv7VaQXG/dW
         SzoWv5aPgtu5CuqtoytZgRXL4MZuixmdpihcFan9RMsxjZvIk3T4uXTEIK2DyChsNla/
         Jh66aZbiV86Uc3DlBET4HKLRy7JQZ8jt5TfdmJRI4uGroQ2fOpGcAvsWfjbBYReXpb8W
         Q+0YygPrkfEZmKPVPPZ9vDGR+oraODuQHv3xm92Oi6byQmYbq4EcSEBHcdFIz+xfPBT/
         kqgAcy6ELMD4aPuUBFhRZ2W0BGnnvy3O8epg/w0q7TJKp+MWOD0xqyBxDLNkFE3b3ryB
         YaWw==
X-Gm-Message-State: APuU4Z+eopiAwBHhIrBRA1qSQ9nnivlqyT+PsgEIDF5amnfBss+Vfb4I
	P0a989FEp25C2UZ9MqG1+IM7UImGXQsNnVMgOhkip6YNxxWqUnHQzkqVmYxguc8Kk/yxAPb3bbc
	d29id
X-Gm-Gg: AZFdTZeDVRQV3/rY7ivruRQI9kplbzob/5hV5q/oRXT0pWXeRHpJ00VInQcsGb8WTba
	FITYEtLcHn4PiUbEbtakeoMr/mQRUap9t9FIfGgcxjd+kg/XZmqr09tBdQWgtanFQqRVsAeo/Xu
	grrZMd9+Q+1yDjDMBweKcuFte3VRxmc9WD/CHE25XgUtH9Hf9FzoyEr652vcijh0DdkAAo4M07b
	9fMAzKuKhOYwb+TPwsmiwPVNrWMuCDbXnJJpNCpCVb8wnHsb9FMdw2wNcw1c04U9+/5gwJGZLeb
	bZlcE+1phulY7hMUeerYk7KM/NpvIdfS67qRJKZMHMhFaHWdTQdpWt4oGiF3CPNb1kPeSRLtMro
	UH1pVa2J42Jwaqq+Q1upWqDsKIArChB4/YNt5OD66BJnRPz8HSgS3ENYRK8ZY0ggKezyLzBtpIS
	rizJmOTNnTtzanUvOTMQuygavTA+M1ZMUCrnSy9uO+t4USE00jGZuhAQnmbWYcZLJgYjnsg/bAX
	O1eDxdkz4eeN2Bpz24bIZIn4qr7gM5+MFjAxm/zxIQhpNho29838FcC/MynH7d+CJKQUMCv0oTX
	B/FFdhzT7RPNFbUgIUHsyoUg6G6cumBPffiSgiryZdUML4+/8Q==
X-Received: by 2002:a05:600c:4e0d:b0:4bb:5f07:10d7 with SMTP id 5b1f17b1804b1-4bb8882445cmr287219855e9.26.1795522755287;
        Tue, 24 Nov 2026 04:19:15 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:15 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 10/10] player: Fix Now Playing NumberOfItems when its content changes
Date: Tue, 24 Nov 2026 13:19:04 +0100
Message-ID: <20261124121904.3267700-11-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124121904.3267700-1-simon.mikuda@streamunlimited.com>
References: <20261124121904.3267700-1-simon.mikuda@streamunlimited.com>
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

When the target reports that Now Playing changed
(NOW_PLAYING_CONTENT_CHANGED), bluetoothd drops the listed items but
keeps the old NumberOfItems, and ListItems asks the target for only that
many items. So if the list grows while the client stays in Now Playing,
ListItems still returns only as many items as before.

To reproduce, list the 2 items of Now Playing, let the target add 3
items, and list Now Playing again:

  btmon: EventID: 0x09 (EVENT_NOW_PLAYING_CONTENT_CHANGED)
  avrcp_now_playing_changed() NowPlaying changed
  bluetoothd: profiles/audio/player.c:get_items() 2
  btmon: AVRCP: GetFolderItems: len 0x0022
  btmon: Scope: 0x03 (Now Playing)
  btmon: StartItem: 0x00000000 (0)
  btmon: EndItem: 0x00000001 (1)
  avrcp_list_items_rsp() start 0 end 1 items 2 total 2

Only the 2 items listed before are listed again.

When Now Playing changes, reset NumberOfItems to 0 (unknown), so that
ListItems asks for all items until the target reports the new number,
and request the number again if Now Playing is the current folder.

Fixes: 671f370a8e34 ("audio/player: Clear playlist on Now Playing Changed AVRCP event")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/player.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 9802e52bb..e1458dfb8 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -2065,9 +2065,25 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 
 void media_player_clear_playlist(struct media_player *mp)
 {
+	struct player_callback *cb = mp->cb;
+
 	if (mp->playlist) {
 		g_slist_free_full(mp->playlist->items, media_item_destroy);
 		mp->playlist->items = NULL;
+
+		/* Unknown until the target reports it again */
+		mp->playlist->number_of_items = 0;
+	}
+
+	if (mp->playlist && mp->scope == mp->playlist) {
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						mp->path,
+						MEDIA_FOLDER_INTERFACE,
+						"NumberOfItems");
+
+		if (cb->cbs->total_items)
+			cb->cbs->total_items(mp, mp->scope->item->name,
+							cb->user_data);
 	}
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
-- 
2.43.0

