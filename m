Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512527;
	b=DWK5/52WIQCzYTdDQxQaLrs3Xez1J/dS0v/BX2xUn+lLqZMdTvg89Kx3K2X5UnW7oJWt
	 6TzpHKSiArTYspoTUrfwwNoB1Q3f1hPvuunL4q9ESZTHNU9YMxkVNsGTnBReKo3Tdi8Kx
	 093GhGPCOrRxW4mSVdFeQidOaHiFmb55hvbIckZOuMGR2Yn4wXv/vllIAv/7Sv4b9es4j
	 chyUItN6APfchOg9xzw3wEwFAhBoSRFzX5O3HGT4hJTb7kEM0EbE1g252BPPR0SZrgj/I
	 YpvYDe5+pgI75ZI1yYBZm3ZTTK0a3Ha938WNlHX0UJ0xYllubC1s/uQ/ITr0uANogzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lpI5sdjNNELC66nEWFczL9aM7GGgky1ZCN22mO1d7jc=;
	b=zXHCdnKC1i1bvaGlphF6HDtCicewYtfSszhRmkRJkE7diiU30Nf1WRPOghv/K5unKpXW
	 uIwct5xbMoNwXa1rkrplUaMNKB8ubjI0wLndmc1EJB3/MM8tlnk/vBFAL7v9IXzDcpMkJ
	 O7rfrV6bBxcMpJ0TsY0kujI/u0VLTs21eiRB1OB2eNmG9p3k+zwaQeYACrwoe3nOKk9Gr
	 iWP6MhP9Oe06KJcmhOJ+nkCMPZPMU4ssP2C34jmPWLBgUSYIbn67MelFFaDIe2ThrNzj/
	 XZeqb86UEPCaBQXPGxdAe8WfzQ+UZcpiY8+O4P36LVYTC3YBgNMgGQeLNJ1+K48qkHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=QdQiTUnB;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F06606A331
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F06606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=QdQiTUnB
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so3524186f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512526; x=1796117326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpI5sdjNNELC66nEWFczL9aM7GGgky1ZCN22mO1d7jc=;
        b=QdQiTUnBxKYbDxPGO3FXyF0VP66SCgz81YuPDJ2R+kqLm9JPYt7cIoHuiBq5hiQEBZ
         x5VrqCASAsNnj33nlx4OnelF8HsajZuce3G05PbsKZJp19KE6ZFt1QLei9y4JxzEp3So
         VWxbTcSfnKBvgwZdfN5uAnC+yzJ706hu0zI5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512526; x=1796117326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lpI5sdjNNELC66nEWFczL9aM7GGgky1ZCN22mO1d7jc=;
        b=HP+2HyelzsKXkxqIQgmns5Xsocx5FF2Hjw+iM7rgHtmFyJ4W2NPcw/WkRqy1oMZeND
         gCJjglYYkh/8XkS9qc3m89sXJDYFUnc463xBYJSxOKd3e8AwKFGp3BL6pct4bDtdXopn
         a68ukLWRdoG0SvhkkXrjGoX1pTBsNTz6Q8rZ+hQTgcPb7J+tPiskNqOX6YdAZd0kRnCy
         fIs02KL4Z8CrtgeIaynQAK7MCd0qLFfEm1HakSZ8WdF/rRb5gHmK46JmDGIoH+8zTJXM
         xvculr0YbLfbh9JIt+7GVA18yyKWJUVHzBeg0Ut5RfqJ2JtLTzTBgyi6kjimNISHz47u
         NzJw==
X-Gm-Message-State: APuU4Z/eTnYus5MhpICfTEZnzAPBSbVM08LQXtZQjsW+Up2yclpwj7u3
	/mmghNBV2hu6ZK4qn7sSXyautz8vChVTS0efjNJCsihL0i7taSqWlxMNgSYJu7ZKxktrCLhSP7p
	xz3i2
X-Gm-Gg: AZFdTZfM5f9sA61YELDH9BhnTWtjYaqdKqM4DYH88Hd8eTVrW5Gt+asyTIwCQJCUP5s
	Z4HzxjX9+/gseoq68kyh+zj/nF5NYDCjrQOTtG6kg9VYMgbNt0hLgpUV7pqWxeiot0NuJ2I0Y3v
	7x/1yEHg/YTsCPvftUhkwqckx0vHZ9pgHqqjwZLEFU3+mcrz8CIZCrLiT3RA/XiGBaZ6HpO7YpJ
	w56GRwq4ih/9rHRoU/q3LIESi67Py2gK6P2cIJFg8MrWH6VTGnQS/f6IlvLR9f7h9z+t5/0Hdjg
	7EA2G5CK8O//GkXrDWrBhmqiL7RI8mZZWQZ+ZtUVyO6UVnx6R/QSKHtNcb3vLUesod1VMxL3B4f
	UjZRThhyDPGPd1VqSf8CkEC6qpTfOKTvSfdOVtrCCBA6djo5tkAPFbnAo5a6m/m+uOnNQGKqh/s
	fUIdjSJQkGTQxdLipZ1/2tRQ3LbhcToqUQcWkdOFLNfHt2ySFzrCXn/vChqAWWlcG+nH2+rvHgN
	sLORsXvaaA2eQc9jZRMXhJYD+jwZ/c2HSzikWYDLpkcOiSDHSXqcJ4hKWkvVrBbBOG6LsVkeftI
	EMOUL94brnzP62cTDsXBlz8o3O8qrkxPolWBsiYl2XX4u1WnMA==
X-Received: by 2002:adf:e19e:0:b0:4a2:dae8:ca5f with SMTP id ffacd0b85a97d-4abb2ece9cbmr27690277f8f.36.1795512525923;
        Tue, 24 Nov 2026 01:28:45 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:45 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 10/10] player: Fix Now Playing NumberOfItems when its content changes
Date: Tue, 24 Nov 2026 10:28:33 +0100
Message-ID: <20261124092833.1191053-10-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
References: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
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

