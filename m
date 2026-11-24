Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512526;
	b=5rVCkJy3Ycyiha+njujhq89DLheKSfKQwVE7k5c5XQFut3/jm/VeSqfTIcBOh6E0drza
	 wyuLqahINPhV/89xeKCavo9AMcQHBWFKmIPd6U7p3HDYseszkloLURkHcpNBFXcwHPIs5
	 44isj65tD+WBcyZSP5F6uboRGjKlPfGvTH58bCVqjAKi0rfRSYfSncN34A3r3lWDCIs6R
	 bhzcjyGDb0HP4c4MOl4lm8ijI7seua1YU4UqI9Ay8rM42nO9LoJNtZ29Q6juPm6iSaaAo
	 rijYWJNb40Wws74wTsF1AfC8cbeqU4Tx4Yf89VSui/cy1ZxACq6Lrqtcg7OHVTuMOXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D7nno6EUUypUkbRmfVbiDkPklRoxlIfwDjf3nWt/PH0=;
	b=0QU8uTtTVD3vTewmT2crhaBIGrAjaYjVxXlRlPwA0aLWdGsJLkXljshWQr4F9C2q9n0L
	 IcyJAoYnH4RgCgfpm1gc0sJqGPx5cWOD08nPW6JhZCvsIirmeowLswO0OlIxKT4DogvlI
	 o0iLkOrHaCDfFuKT9JxMpDGxiDu2Ezuyz48vgiPWTW/Sbx2yEmuy/fcsJH+1UVmSsMt7w
	 Tbcg5Ro3MPpjascRYc7Fmf1wkt4BpLuw4zgj6KarzUofbKK84AVgYkl/3Z8eTow+OfYY0
	 zWEcy/bg1LL/SqNMLqJpBfxbGxH2jx61HC5sn/FQ5gBSKz+L8kN1ncHy46Hqe7O57iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cdSucBni;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF19606A686
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DF19606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cdSucBni
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso30177625e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512524; x=1796117324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D7nno6EUUypUkbRmfVbiDkPklRoxlIfwDjf3nWt/PH0=;
        b=cdSucBni6/iRjpzLf2p2on5E03dXl7nMKX8Rou0pCjBdlJNAnGphUJw72TbQAtqhJq
         2b9D0Pz1dzZopCTVc0MKk1dA+B6+EB5YPcLCWQunLaggBn9/oe7YPElOKbGYROmgvEXe
         +kLlwVG+sFx6KllCNjFHv5X++IGWDSzP5FNKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512524; x=1796117324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D7nno6EUUypUkbRmfVbiDkPklRoxlIfwDjf3nWt/PH0=;
        b=CEBPoDp03pGkoYTPvILk53GcwljvCSxTpHMDjNKpUMsXReiziP0mLNeGbHwBjfVYOv
         UoRAenStR7SfoZjvelm7wKg7X+B6DfnDH4qpja2pudkr9p8r85d8Lv6eMsYsznn4UnIU
         4kt56jRbR1XRk7AZ2UUBD06EUcruCaqOz/V6bJ5Dnme1dPej4WQnYhVjz33UsbMJGMk3
         Mnt+aupSAC4u6YlK52o4ybjtFlObfUIkaHGEe6yzqyb7/I0uDAqlXcxy2kIYDnRX00G/
         GhmrwnQcpjHYAaof8IW4qHyUVYT3JYIx8Pu5qt1O8O0eht1Km5hW2Z3qbdfH3vZXUaF0
         rjwA==
X-Gm-Message-State: APuU4Z/saKYDr/D4+vLprqpUxI6ijnMDVSuSjTWOJbR1N3Co+sQNat/d
	drkmy1g7LH0XBYfrjpXJD3z+lbJyPDk6piBnz6KCVElJtMDWahYFig8ub7RQTu8jdmwngJmEzhN
	xR3IA
X-Gm-Gg: AZFdTZcSEcDLt6kNdkbhTu3E0vZ04dC7ffXJfPHQ6f021WtBMdG9QbiIGxm8SvYJ3Bp
	65dszvEmlji+b1VstkJyqwxmzMcw9eg+JmmhM6Skd46fZzWWwcpR9Zt4FlkpqoNOAncV/98zkJG
	xTi6B/ziXk5BfseSe/M9Zf0iKrz7oKKochKuQJIgPx5OOvTnkgpcTP2ykSWbWFpNIfXtMEW2ir+
	PV4CaafiuLhcXh6GqCFEtOGEiM9AvuUbplRtaq7ykSmTwsycMp65k00lEfz3/HUApemQxRmmahy
	SscPZBMXxtCFrhX9KMW6WGt9pdoG83YHXljSjScyLvNu30CoitgogvEGRgtrzyaYX1e2NnxP9SG
	VSYwJ59m5LuIhMhC2nW2Zt8LGVMvr8hhenEPPKfFES1Pj5+KYgHmO/GO89D4IVPdaBB3Fly8W5m
	q/OwdvhKN6NB9vRoFXivRGv0NIZ2xH8Yg3ME//pLfo8l52kM9XRIS8I/TNxfAmdokOPsuAUxHM9
	16uFz1lAUt4WclUxXVlMCvzQJ9MWyl98NsnGBGetFuYQo7kcjMnXOCsVyBlP+opjtj7/6WanP/t
	TQ7dnC2AYViraPGU2IA0JPPGBnjG2vaUkb35YUbQrPnLjtr68R4=
X-Received: by 2002:a05:600c:a08e:b0:4bb:647d:dabe with SMTP id 5b1f17b1804b1-4bb887c3afamr317247725e9.3.1795512524490;
        Tue, 24 Nov 2026 01:28:44 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:44 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 07/10] player: Fix missing Name of listed Now Playing items
Date: Tue, 24 Nov 2026 10:28:30 +0100
Message-ID: <20261124092833.1191053-7-simon.mikuda@streamunlimited.com>
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
 profiles/audio/player.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index bfc51ac4b..07f4d4f78 100644
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
@@ -1886,8 +1904,11 @@ static struct media_item *media_folder_create_item(struct media_player *mp,
 	const char *strtype;
 
 	item = media_folder_find_item(folder, uid);
-	if (item != NULL)
+	if (item != NULL) {
+		/* media_player_set_playlist_item() creates it unnamed */
+		media_item_set_name(item, name);
 		return item;
+	}
 
 	strtype = type_to_string(type);
 	if (strtype == NULL)
-- 
2.43.0

