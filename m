Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345062;
	b=FYHvWIZ6ILRhQB2PgGzl8hysiHo1F/3lCflI3wUf0pH0M4OpfsnLr8nzd3R60F+2+t9W
	 wYcaAnBendruTB2YAO+T5OxEQ2w+SJX62lSSzpDm52GeMCn8nydGmRahe0p1ivp8f6QSi
	 5hUTSF0nkC/8cxjSTBjwflMzp/NdclDYYjZLCjEbq0op3/NwywAhZWGd3j9mpecjkACJa
	 wVWgg7+gyLE73FwdCDnrRcbM66CiW/da70egbdEAzFH3mzGbDlhbQ/5BT4486dtjm0Iv9
	 VIj7zAGx85nksWKiNUFTFYOxR+utB7+eE4K/blLfkHgN9qCj3XCjFg7rSNdQVC8/9Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DvykyDbbxe9qHkNDIwlydX0b6ASdAg48WMPPZc5U0lo=;
	b=kAqNzLDgFtpJQunbCOulR+wYE6PKTCODz5O5lG/C0/M/mlICTXneGizb62Y6/YzmLgXo
	 LmpZAzrZwD9yapH5aTak8CbndIl0fWIshMf5NRvYjsbXIYu2l6xEeum3eRPrUcNT7vlsm
	 Fm97nGEI01U6OaARXALwLeZO3Qw9UPRzLoE7bth7lefI7P+nWeRXnY1jIGspU2OtsqHza
	 bh5ChlaZ/+De2YFk8a0QD08/1xYxMnz2pP+yLKUIQtlPjbF8W0o6CGoM0h3HTzv5kzpjt
	 gbWijb/SKrPyQzideOky40tDvyysCX9WFe6N+mxaF1lqMJXDVnNfZPU0NZ6I5LFSFeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=lWg6ZtgJ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBF606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ADBF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=lWg6ZtgJ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so12318895e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795345060; x=1795949860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DvykyDbbxe9qHkNDIwlydX0b6ASdAg48WMPPZc5U0lo=;
        b=lWg6ZtgJyT8IN02TALUVktl2iQYTLwPwe+dEJGsCCSWXlSfLWTa9HUjAfxwnNqHcGn
         iKPpiDjfu6FKl58aCBHbNnZ9F9nf5jCC+y719iGz1zZoE5osBBoxTlnHdB80xcXBBDam
         wPzFu4dxIH++yDqltT+rHvKZygl+TgPS4u5+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345060; x=1795949860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DvykyDbbxe9qHkNDIwlydX0b6ASdAg48WMPPZc5U0lo=;
        b=IIGbYEBJxZkEdMDaxIKEKCRf/PWPXHdJ+vEljK5i0msrvzM3oP8AK/rdcpN2fPOwak
         HdEFw5GHgAsGznA8E4x8bew9RspPfa/VTajAJOsP+/OusfRDIFZuoL0NxB89g1j/UdKj
         7+l155ur8SNDRUxwL8VE4+fhhhquOoomjn63WS/MssElZab7tgW50o7z4nM6UfamfLH7
         qE2yQKDSBwCnq/KCyI9U72FXacE7X3FVc8NsUsOGeF1+5Os5aQkvhMd2iz5CAeW1KiBh
         kGImKMp34kOvLVFvz4EPPkefFwolWXwsFbes9n0ihQ6XQoJunr+PrRGLWKKpfPDiSiJt
         /yQA==
X-Gm-Message-State: APuU4Z+gwiuIk5IY0vxBlTeN7IdwjkOV06noYWoDh+Ydxa5JYeyk7asb
	7+U5lky7kWILf2T9SiJpmE+QTIHjPnyJWHe7GWIU3K3e9PjwZ4av8C8shkVtKbTnA/N/TI63gXp
	MSQdg
X-Gm-Gg: AZFdTZdu92A73p0MyAgNNkXicj7ecxpbOjEdwFmD4pnNnDPF6HTsGzFpetCWl/aJQRH
	8Mbk+3fcgiAkoa8yT0MjnxQFU75FsxNGdd9Hyc5mjKNbVz1z5KxeJiwLj4NAbrzRrxbrfqAggJz
	jGzfYhHuGLxOblEgL+JFFJGVDdX5Om/KZ06Ud4v11iWCezMNy3I73oaIswvEU06kq799+NaTN1Q
	ww4azuHdtmZsXYvT8K3MWPsHm+MihPC+B+U6xIE40Qf4InRY+C9tQ0hs4C5w9mBGd6bJyCuIqZ7
	G5Kfc/nlGKYqhrwPO+zMQwHzJ6BMHn/FEImke7KqDtjVYDSSPWCjGcdvX4/H0aHRSsHzaETe9gl
	JKdZ7bSsLtiSHnJpJi7bVyM6ems9hfw7ZpyDR3yHlliASYjbPAUyQqJbbSLupkQgr4rs9Y4ywRI
	LlIchP4+mz5qYsgg0z2cH+iDs6+k9D8CPj9pfT9GG33ahRwwqAS7eQvVyfa02Qlrd/T5+rQJyL0
	A7FNIa8Vd8DeuOL6vh0uhfwSlfEa3QUEiF2IC7bHGqW/wHyGMpL9oXrl69TOwIqsYp1EcqYiOrr
	2aULzZ9KBcghc0JPFnnHQBdq6JH9A4gLmBvXmqMWjZFYFRHIvr8=
X-Received: by 2002:a05:600c:530f:b0:4bb:781f:6067 with SMTP id 5b1f17b1804b1-4bb887e21e4mr171614575e9.1.1795345060567;
        Sun, 22 Nov 2026 02:57:40 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm300138965e9.7.2026.11.22.02.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:57:40 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 8/8] player: Fix NumberOfItems of Now Playing after its content changed
Date: Sun, 22 Nov 2026 11:57:31 +0100
Message-ID: <20261122105731.799090-9-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122105731.799090-1-simon.mikuda@streamunlimited.com>
References: <20261122105731.799090-1-simon.mikuda@streamunlimited.com>
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

NOW_PLAYING_CONTENT_CHANGED clears the Now Playing items but keeps the
number of items, which is requested again only when the scope changes,
and ListItems does not list past it. So a controller that stays in Now
Playing lists a grown list cut at its old length.

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

Reset the number of items, so that ListItems leaves the end of the list
to the target until it is known again, and request it again when Now
Playing is the current folder.

Fixes: 671f370a8e34 ("audio/player: Clear playlist on Now Playing Changed AVRCP event")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/player.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index d4dbe1b59..a24c51952 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -2067,9 +2067,28 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 
 void media_player_clear_playlist(struct media_player *mp)
 {
+	struct player_callback *cb = mp->cb;
+
 	if (mp->playlist) {
 		g_slist_free_full(mp->playlist->items, media_item_destroy);
 		mp->playlist->items = NULL;
+
+		/*
+		 * The number of items may have changed: leave the end of the
+		 * list to the target until it is known again.
+		 */
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

