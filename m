Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453183;
	b=yLPIlBoTeueixzMXrEtBzcix3EbYAr4cBh6xOlZDhj3YZXNQWsebQwp7GDuJCa/MwKaB
	 Jm+w/K8e1//uMGlXLX4dG9k6g646mSXjcHw4fL878cRB7nO2hcn8z5Q0CLw0d4X7qftWy
	 rmmnhumOvvp/VQWvjQagmr7rOP4Ycyrvz5cDa0VcQ8PciJ7LE3gC53dLzn2oLbNprPw7j
	 7sWEFFkdlRIOB/O9mMCpTJ8Lvsq5lZy36bcO9EkWoMgzfU6tw9x+/NXjW/DvCed0XGqWr
	 luCgM2IxeezVztT+ks2Ce7A5b3V+Wyx0ysTQVvM5X3BdOMDAdDb5MVkXqxlFuXiL6Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iKOEKbDn0kmPNlbd6bmEYR6j1nCdEjrC4H8V1Ij7z7Q=;
	b=mqynGSZN2Dsoc7Z4Y63HXUOBdLPPaWMmeuK3EH6nWk5UgZLWflk6yOQASySAPQUvf9+k
	 aweX/2reHXXyxEy6yOs/2QMLK5Z6lxSotR+5BFxp74f8etWG+dC1dngLCqFjz0ZVkGTSx
	 97ATcuRDzVqQUdKdaU6tZy5iACZR4Vl5ASI89yQDKgJ8TeSPN74nB13SP5Dxp/wn2Cmsp
	 RYt9t0R41loe/adch4kLw6ANVBjAs1FojW3VXQs815xSHeK+Gjolm2b8jsA+yini8dbxV
	 7d8rm2WGdl4GqnEPH+iCENp+dYZJhP9Qn1MtpQqkPMFg+loi6trFXppS4CYSHV+DVUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=TL3eUgWc;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE92606A331
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EE92606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=TL3eUgWc
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so20062315e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453182; x=1796057982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iKOEKbDn0kmPNlbd6bmEYR6j1nCdEjrC4H8V1Ij7z7Q=;
        b=TL3eUgWc7i9wPUvs2YwfMeS+6fJ/vJHBob/3Yq49pMljT9k+Aju6KsxmolrKtYqLkL
         S4xtYE1SHti+DSRHMQa2m9QmPda2wC3uczwhxTD8BrFmpsnCymazi83nb2oofGLB0fN3
         gEYaDiirsIgzKRPeHzT2aLY84wFN9KpemZVmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453182; x=1796057982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iKOEKbDn0kmPNlbd6bmEYR6j1nCdEjrC4H8V1Ij7z7Q=;
        b=keFxdIJsH9tnuIQcjDt73qg95oG0Xpwfny6ooOjVh3yzfl9g+FapNrGVSAt7QFO3d1
         7xmNAhHjTZD8lx8s0md/7lEUd2P1XclzUzCUwV/hLzBNlJeh6tTOeQF++a2d/eC/miJZ
         2UvK3eYLIj21IXAQ7Fe4TG+pV4uslqyc4H9b3QcMWL7q/KuQamw3raANCKFO+r5QOd4w
         SZvu3URgrt9lNo1JM1r1vVW05K7+AhsUD18iloGn0obRlmed+ts5YhA73eV8HFpK7PGv
         kBxkQTxWJZZ5pZrcXAVYft3Z51iYBVe51800/Y3YsURWTzY5AMhvL6zvkP3exJw2PrRS
         bnug==
X-Gm-Message-State: APuU4Z/yEYmLsbUFaNq2gkwAABdGUmTd/4BC4WkbWBufZtGYgPNUFHTv
	k7Kh7AeHU4TzbuQLy0K0tATUtH7q6hfo9Osuz441y/rNGvSN8tF6XSBiZXpVM8fn0mGKoVfSVg/
	fOP1+
X-Gm-Gg: AZFdTZdFWEFcDvgVApGnmKfZkCzmKD/pIPQHlJZ+1M1vXSmOyUojHjQUkAwgfPg+Rl3
	UnB8Pe8lW8xd+5K9Z/2BOImmoZTKwmdOFWRo2Ekme0HMeG9qdoBbIbVEqkPE42lWsShLJlDVPIN
	8aiiD12B2PolxBKy2yJM6q8xLngjY2rxZsz5kJTHXNPjzV0M2fE6h/A3PDPqrS04GVU0XUeWz2X
	4DmbIKlHsUqvEymlgJ1v/RtbE5M/e3Y0gFgJo73D0J2wEgM8hhL3r3yGSSELXR3X6OM5NFamMRe
	mVfPqU2JwQF4zJw7LFDsw7/mve3u7OAbXhbFEvECZa52tXmnGQp68GZtJs/sQdnHHz1fAgbrUcH
	T338TIPJqcebjwA7U2NSYlSh13IP3IvhstIJks2wVUnnnJwCj5xZ/UjfViZWqaNf0tc1dIJB6zv
	SLsUUfJ7MvDWjL5gJKHS8pPEVKm1PyBzDXlOzOy98phGQqrPDcp10Vtd7bLN1RPhm7PMh+b7NJ2
	1hVGay+UmF0NYKzYVe49dzBBrHVRMgl5G0RfbTGh8nIrFo7kJ/HzGwTX6TpzD05dxk1AnwrfZgS
	mA+ImG1LFcVIcch/GGR9L0qSH4lxSNeo4yvso0l4ortB5go8
X-Received: by 2002:a05:600c:4f48:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4bb8893ab9cmr262378515e9.29.1795453181842;
        Mon, 23 Nov 2026 08:59:41 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm289748185e9.2.2026.11.23.08.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:59:41 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 7/8] player: Fix missing Name of listed Now Playing items
Date: Mon, 23 Nov 2026 17:59:31 +0100
Message-ID: <20261123165932.470612-8-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
References: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
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

A track change creates the Now Playing item of the new track by its UID
alone, without a name. When the folder is listed afterwards,
media_folder_create_item() finds that item by its UID and returns it as
it is, so the current track, and any track played before, are listed
without a Name.

To reproduce, browse a target with a Now Playing list, change the track
to one of its items, and list Now Playing:

  btmon: AVRCP: GetItemAttributes: len 0x000c
  btmon: Scope: 0x03 (Now Playing)
  btmon: UID: 0x0000000000000002 (2)
  bluetoothd: profiles/audio/player.c:media_player_set_playlist_item() 2
  media_folder_create_item() (null) type audio uid 2
  ...
  btmon: AVRCP: GetFolderItems: len 0x00e5
  btmon: Name: Blue Morning
  btmon: Name: Green Afternoon
  media_folder_create_item() Blue Morning type audio uid 1
  avrcp_list_items_rsp() start 0 end 1 items 2 total 2

Item 2, "Green Afternoon", the current track, is listed without a Name.

Set the name of an existing item when it is listed, and report its
Metadata as changed too when it has none, since the name is then its
Title.

Fixes: b18723a18e8f ("audio/player: Create item on media_player_set_playlist_item")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/player.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 574a026ac..5f29be749 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1876,6 +1876,24 @@ void media_item_set_playable(struct media_item *item, bool value)
 					MEDIA_ITEM_INTERFACE, "Playable");
 }
 
+static void media_item_set_name(struct media_item *item, const char *name)
+{
+	if (name == NULL || g_strcmp0(item->name, name) == 0)
+		return;
+
+	g_free(item->name);
+	item->name = g_strdup(name);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), item->path,
+					MEDIA_ITEM_INTERFACE, "Name");
+
+	/* Without metadata, get_metadata() reports the name as Title */
+	if (item->metadata && g_hash_table_size(item->metadata) == 0)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					item->path, MEDIA_ITEM_INTERFACE,
+					"Metadata");
+}
+
 static struct media_item *media_folder_create_item(struct media_player *mp,
 						struct media_folder *folder,
 						const char *name,
@@ -1886,8 +1904,14 @@ static struct media_item *media_folder_create_item(struct media_player *mp,
 	const char *strtype;
 
 	item = media_folder_find_item(folder, uid);
-	if (item != NULL)
+	if (item != NULL) {
+		/*
+		 * The item may have been created by
+		 * media_player_set_playlist_item(), which has no name for it.
+		 */
+		media_item_set_name(item, name);
 		return item;
+	}
 
 	strtype = type_to_string(type);
 	if (strtype == NULL)
-- 
2.43.0

