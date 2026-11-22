Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345062;
	b=c+udnD//w0q8VxNbYZ4vKM/sTTgIWRVKDTQx2iApAjCZmp2GTCk9Y+f6Qf/BPjCQVoKP
	 kosCNQ31sQG/HpAqIEQaI4kesdY4OcDAD3/Fy6nrvOCwWYAO9MTkEUsoH/qQcQO1vE8Du
	 S8uwoO5Y55Q/spUsaeS4jz+nOIT/wIO6FZYgasthDJ4AYpIL7wxmhBfaT2QdFrmKqXzSM
	 fU2u2/ESobBMpMUTnok1P6wov0/P6R6eNakikQU/lKbyxvDDOWb/1m/0EXcdyzho76GHg
	 kFQmBfM+0MP3KA8ThX4dFLpi+epKCkK4Lcz5h25fDxaGTz/pLy8hkllptvjHQeYCJAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KF6FR9zxXR/+8zQsKiuwGWOeynceUhAVrCcStW2CeII=;
	b=ggIVeWJE4QiICUStFLWq4bRFtNWlEaLwmY6K0XiLn+XkZzPWtngGa8VN6S7YB75aYd91
	 aapVDQIc4koEQytNv2iGH7CdGBHin3i34m1Xtk+ZE+lVsNjVIk5fWIQVwsJLEvEhlg9+Z
	 A5iZzkLW1UybwB2R3OCTS33tVWPqPTalDkGk0a62frW98ymsq2lwF/eIUP3PFP+l6eb1D
	 5PJUPFBQ9s/I2q7YzNFsXxXo3xss4xim/j+XXTPmjjn2WD6kerwjeL1rkpASAEfySYOz9
	 ok0N9FeU6lFXhmHzpT1LzQiwuJEJDNo15UiZUrP87ALvH+0YE4Ss4Gn9zBccHVLGnmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=sxraM4wJ;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6D606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F6D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=sxraM4wJ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so22215095e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795345060; x=1795949860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KF6FR9zxXR/+8zQsKiuwGWOeynceUhAVrCcStW2CeII=;
        b=sxraM4wJOVFJZGcgUuQemeirGF/2hV1itDh8Vw5XfJUp0dSBFayis/GYa0vM286KgB
         YSDM2xtceiCR+MwU5qZao4D6Fg1syCJ6TpX9R2z9IOUrZBUgWRv2RAcIqD4UrcGm2sgQ
         gKB+A0MTp9asiJtKDTja7F29FlTnZXqtG/0Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345060; x=1795949860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KF6FR9zxXR/+8zQsKiuwGWOeynceUhAVrCcStW2CeII=;
        b=ULCBnpm9Yilzpuxlt2zRZn/GkRWXFx/Bws+Hgkq/1z3dbKVEtzSuA4sAUfFrw3AUHG
         nbFD3HXDHkealjztlkQEynTgpp+AXMxPIWrdiIZLkajJ2qkzW0To8dPGUvKkOBuDX++1
         Qo5X+wguYyTw8Ap4VNmb16s62yx0yqmrzMUrQMoI0RKEDTF6vp01gsHAD9uzQ0c47kkY
         M1oDi3j7U9a4+M/JIdzhH6jz0wPHhEr8xEz0dYdGsPQ7xnO5QOxgTKVWB1qGMNgzzyzh
         La0McUeIzXW97NJS1idTCHKdVlPaDbozDqvfJ7tPBFuhY5gk/NOw2J1dMINCA7cWySP8
         qGAg==
X-Gm-Message-State: APuU4Z81RX5fhYHTwGFBV+5YJcHKNw1FCPYmN0xDGdYZh7F8VVki4+XS
	7xr3wK7eONob61zBaQ2atD3uds0qj9m3WepdM/po8mCpJN/13EX3/2R+FkSiOJotGF97l8BqA/E
	CXLgj
X-Gm-Gg: AZFdTZeL3PW66SVoAoKA5MqWAWds6uRfxI5WBxKCUxgJm8TyXftWm9fBD/AgIG31W3X
	mhZ5KFdvILja1djEpPMSiSkEmucvtgKBqmDEmfFX1Te4W5ABEB3cOzmUHSGZ+iGHgDqLYB0z72k
	PfqqcGhvd4bWjtegkqHrOQhbqs0eDEL0Wmo1htRKq67eoaXqtZoItBvfeB9+ou0aj7d2a3KumsG
	K2fvFVVMMUwB0YDSp4w4QkY9byYGcztcNVN0id3UVSkxxR74Whp0barTK3eQY7y+MeUv70DIQgM
	3Q5FPdm2V+E/KWsN3wqbowm3iQT1BD44Bo8izeeRW0M3X7OTqkeRkyEvzva+psdaKOCl3h+j8AW
	bRU+5QJlbmQarYBJl7IC+1gp42UGHbiamKHOQFg24M1pagAz1iB3kAEgFieh0iTACPZ710LlTz2
	oFZIYx+cOfZl2ZNyly3nKCqdOc31QO7IFplf7rHm4nOOFyCK7p5STyRNQffQe+50HbaRPxfi5RI
	JlYHytNQRYTMtRKcSxjZ+s6ZapZ4dCGve8P6ZtI+q+6apXpqkHLx9bGIrkWLnVjTjAWA6YdpNRW
	L/D9oAlUkZTitFqS30iT2QfDuWZw+QkYOPteuognEt1FGniKaA==
X-Received: by 2002:a05:600c:64c8:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb8881d141mr172139785e9.26.1795345060009;
        Sun, 22 Nov 2026 02:57:40 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm300138965e9.7.2026.11.22.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:57:39 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 7/8] player: Fix missing Name of listed Now Playing items
Date: Sun, 22 Nov 2026 11:57:30 +0100
Message-ID: <20261122105731.799090-8-simon.mikuda@streamunlimited.com>
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

Set the name of an existing item when it is listed.

Fixes: b18723a18e8f ("audio/player: Create item on media_player_set_playlist_item")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/player.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 574a026ac..d4dbe1b59 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1876,6 +1876,18 @@ void media_item_set_playable(struct media_item *item, bool value)
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
+}
+
 static struct media_item *media_folder_create_item(struct media_player *mp,
 						struct media_folder *folder,
 						const char *name,
@@ -1886,8 +1898,14 @@ static struct media_item *media_folder_create_item(struct media_player *mp,
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

