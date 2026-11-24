Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522755;
	b=Dhp3kE7qQMdF6IBy3XT07Ai9K21OzSXcgyj6w8fDeEDv/yvlQkCkhqUjXedXBflBUTcu
	 ueR2rS5oURAN8NKlbmi0/jiBvy4RkMzO55+sYOGgufIfVtbEQSUUaRFh6zI+67+ZF6gBV
	 OhTeGklJ8L/l1Et9BJ9WZIvORNtt0LTAW2yFBiOvdoylZEviTOJ843wP0CFEy1gx/piqJ
	 0KTEUL+taxhCWKqBs/MJ+0afxnC7GuxT4B2tvkZfXejoKOxfh3Ey86d8WRdQ8VBiY4G3k
	 673uM/VcNiwJf7c5WczYt/ITMvbcIUSgdjhF9NOhZfTL9fz7ZubkJmCFMBg/W1mUJSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D7nno6EUUypUkbRmfVbiDkPklRoxlIfwDjf3nWt/PH0=;
	b=Q/myVD1GY7pz8hno/owG7OTHgdMWI6kO5hvRU9RyRuP6cqduArpM0bOzo9Ivh2M6M5Am
	 pUiNqIW82QpDFZq1zvHmCcA75ZATlJwJ2UH3D5uMinJ+sDyfp3diU7jXviUJIzkookqXb
	 J5Iranwi+Q97M/b5KglqOiHBd1CcjRW7iZlFnaSl7B8MQDBt+9DF763CzqqPssx456vGK
	 dsbEhMNlq1wVNsyKHMG5UlCaYEFhsOByNMrM0/3hx2adM3XCtalvpq6KkKg6XovhXyaTZ
	 8qfExWQyckZ5AEUd910145zdOYbSB4JbETJyqd2JK0qHCmF1/hudxYjB2i1luPs4IAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="kulD5/Dx";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974F606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5974F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kulD5/Dx
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb61185057so28907095e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522754; x=1796127554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D7nno6EUUypUkbRmfVbiDkPklRoxlIfwDjf3nWt/PH0=;
        b=kulD5/Dx4QwsXQquqzy2koJARTiMgVH3et60WJl6TD9NfAIrZ0dPKXXYT8f2dLJ5c+
         EX9AMTvX6NxT02VvCFGoiJF8vV7wUYLw1+6KI2R2RPv5UnL22nU6DN/CBkc+YkIZlCS/
         /SwvDiKcjvdVfDvn85CaXlS4MuLWMHWKJxKi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522754; x=1796127554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D7nno6EUUypUkbRmfVbiDkPklRoxlIfwDjf3nWt/PH0=;
        b=tV8dk9YnYVBHDLEnnoTLnZ7DhnHPttdYF6c5am3VuHiScE33Y4SoAyWYL/48eMR1XN
         M7YZVXvwMgHocbC5vxJ+U7uKH8qUxNC533KPWl++yA5VGHz0ljW16+wgj0Je0hOqRDXu
         yp54XVEMPhu8IobpzIpIwqGEOAp8dSqC9u9fuslgg0U6VMsUt/bYPoGW07JYf08610pA
         HH0Kgxq1DYrzVRKvtvVsP1xQS/ZIiqYApR46VykBC2wFgfu//NSOBamCP84N4b5DSadc
         bLg+aTrXkME9nWlyZHO15fYIyT7UKqdNPhtmXcro3hqm41iu4nDOOCW5gg4KsIckpXUh
         8vgQ==
X-Gm-Message-State: APuU4Z9HrHlCRoIBdEs2GxzErcv+SMbWoj9Gy5TjQM2dOo5dH00FbzMi
	EUJFeDyoUG6shm3VSSHmUNjrs89g2qrwvFwnsOYg7H5wN6G1v0pptG1v3cRFcGHEVTiXO5mvhgU
	kBkS/
X-Gm-Gg: AZFdTZdHC98UBf0cCGb5S24b+pf16dXLapzVyrisQKk2+sv/keDGck34Q/DYiqA62n2
	tcTw54KBv/islgBizTXJlCVZQBDqmRP3G4H1HFwTkzofcZ/7p07ug5/NcH1VIXjI1wyoR9+9wvI
	6UimsXr8w8xteKReqAekkhW7UW3MndMkz0lT5BHFEnQ/9enF9sq1GgkOg5cvXRutcRN/WrLACzo
	SZ26XRsfqkVdGUOy9CqtmghBmEPmBDT2NbK76zBemIN/KNkYyparD2uUyjvj952DBFvjZ8mednu
	w/xS25FAejgR7bvLWk7SVkrfIMToNfETuQqSVIRdAKSrGayg1ycbTfxzptXXscexLDSvzlJX1yH
	mmUXh2b601njC4jyJ7A3i7R5OghbEJ7QohGAPuDxqTwh5vRKqp6zpS4otFM+2FHfcUZMjein9if
	ZMj5ZQFXeZMXbA/7R7BMBeVTySyVNVvM0wBzjuY4TR6ofkQqMTlIR7VA9mRJX30NYgG8QppZuI4
	k0SYHLlIYZ7tYA/aZ5Tso54e4WH9D8Qo/k3gShergsn0mhfBFg3IWxHADhB2EzeUaHi+yP5R9wn
	AQlTAq3W31FsdHUHR2aSMzjdOCHnCL/OP8uz0C3PmD3wABbN0AAgldHr9xcrKc1dgeIx1AE=
X-Received: by 2002:a05:600c:3511:b0:4ba:73f:ef5 with SMTP id 5b1f17b1804b1-4bb88828304mr299460895e9.34.1795522753696;
        Tue, 24 Nov 2026 04:19:13 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:13 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 07/10] player: Fix missing Name of listed Now Playing items
Date: Tue, 24 Nov 2026 13:19:01 +0100
Message-ID: <20261124121904.3267700-8-simon.mikuda@streamunlimited.com>
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

