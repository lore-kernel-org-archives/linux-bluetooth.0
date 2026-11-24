Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522755;
	b=zUdXAo2wryJAEitGncGyoVkdkDZ1/w8HKbw/prcTBSS9wsnI5Epd0Q6CMNwhe7jB2KgA
	 jzCX15O72K3lVhdC29PrndkRJ4tlO7IwSHV6SgLwAPDtmIn3EQIQbyhpQTafSbzTcTnO5
	 SnUEhT9l9uA2OsqIdqZkukTABFveHZywtUZkh6jmjMS0FaCVV3zeHcusq+EskegXx1QI+
	 PUwcVcyDvC933g8mvIxG72M8hE/FB+A2pujtlMVYPMffJ4xKPSQPtqwnafkvFHbRTMmMQ
	 PwOI/VYH6PK7m2pYVY91gHDs4b/cLD6A1Y5V+X9HNrOCKJgbe+xV3ahfH/BNhj+cUBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9I0Y/Fz00U/JfLIJYFe8trRkD9P+BbO9baVK1YGIO5k=;
	b=dxkyEId5KaFqMsUTvpN7gjHftmNwQ04Trz1+9JzbhUIL1FikRbhFIaInKgOdImaufcSp
	 zaqeKmLXfOoXUoR2CwJ/t+PFWAicDyRyjhwV8JZczbOQDZL8H+cDvUFCatXc9YL3SwrAX
	 UVoOW2yJeZYhneht3+DgmrN0Y5t2JcLIwv2u9HGjfnK1+3oHi9/CCswluk36OEo+d8sey
	 IGwuJqtLM0exEkij0Qudcfyyz66vZLYElvYaFkztEeMkqt1Vvnf+v2t5CRUUJeCL4BChV
	 A+ot8uQh7+WXP8XcGBXN2hih4Mqo/Lqu9p5d4WDTZ4WfOU4FfSOKKR8J03X8wEEW8Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="Lxk2j/X5";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7DE606A331
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE7DE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Lxk2j/X5
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so43466645e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522753; x=1796127553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9I0Y/Fz00U/JfLIJYFe8trRkD9P+BbO9baVK1YGIO5k=;
        b=Lxk2j/X5Z1Ks/Q5X05Ktzck5inSbevjcWha4yTd7HA5ga7WAihVoNgVAkLw+ooeGrt
         ZZiympnCYe1oLS8YmaX2Ajo9Rm7df9uoq5Y6TQrMMBMAaPH0c8Bdd27lmh/k25IUjCFR
         FxSiZ+UFtjyHNj5aoo+uOBN29YkkwOFk9mgE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522753; x=1796127553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9I0Y/Fz00U/JfLIJYFe8trRkD9P+BbO9baVK1YGIO5k=;
        b=o/r23bRPVx7RGZF1ieRUyfZEJ88lY7l5A27XaO8oiNO2SyO3T7sEa8UYn1YsqTc04m
         8Cltk8WhzCbGMX35y75om34qumZn/+zsk/xD+Duu1IAhJP+pV+dOB+NsbKzLQ1iCWGpB
         8ldcVi9GyRw/wd/sQgITPUu5dqoQ46cYW0zVyoooChtY2RrMBdYRVElawhNNEVHv8EN+
         tPIkqhz6NVwrQ3oy6WCg+5peH1p18kDaOUQ0VJaWk93ghOhXw83Kry4KegopARYUqP4B
         Rf83ATaII+OA7aeG50qhSZemJNQ5k2wkhl5VqBtwoFzy6kWogsAWvtSD8IsdOSuiO67S
         xUAw==
X-Gm-Message-State: APuU4Z+LPkv8X2LvX/49aHkhTfqjm1Q7JidtXcURyUTzAwNOA2XoFLNF
	c6Ut+hqyyuoeuEc6CQJfm7mS00zkRcNqBjYQnBF5GruYxUfZnqRsds73zyb4ulTE0AqfXNTp9c8
	1dkoR
X-Gm-Gg: AZFdTZcWZ6ZsQVAKE5856obTjDQq8R5yWm38eiMsGupNS3JF8o03bqNMSSwsqK8zEuu
	Q/YQxgtclL+icHHPjotQWndSDbyJE7+cYxae5R01Ia7WzIqtMovOF8DN9ZlF8ndiTi1FvZw2hJR
	KI+on8Qss+SrG7aWcAHvMJnBlDr/cYp2Dm85Q88Bkv6NxZLH7gnk+OmtseH7nWfUHJyUPzmdO49
	zK1E6qYCE19Mh/qnoNELEBP3gzMyMLDzNx3K3QQ6fToHJW6IXhSns5R25TTaI4fyxOJmnu2Ouh7
	Ut7QlCgsGHGoBSbCy67R+zj8iB5DMG+PyhqVxOo5gFzKCzAFyr9mdFVNB9V5L+mx4ovds6a66tm
	Ugw+zmEdABxT5oirFlNbwi2eL3RX+8vu4tCIuF2inSPvfLYiGyFlD1N+ntYmidWoMmZkpJMlAvp
	eFa1k0ZCOQwgP25+n5LpugboLc3Rpum+F/IY7o0Tv4jHer/OCSoa6Vs/af4fZ21ScUri1/E7rHJ
	kQI2qtyVuqnGeGN2rzh1YGRzk9Gjjc1y3ixjexRc4k+70BpYmvsXwfN4cRuLe0R2lSYfxMyapvF
	R8uGKsLfSJ8eYnz8fGo2M73HP338B8EPRB+VHiwN3gZEtxG6nA==
X-Received: by 2002:a05:600c:3555:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4bb8881da76mr292346465e9.34.1795522753210;
        Tue, 24 Nov 2026 04:19:13 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:12 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 06/10] player: Fix crash on Search in a folder whose name has a space
Date: Tue, 24 Nov 2026 13:19:00 +0100
Message-ID: <20261124121904.3267700-7-simon.mikuda@streamunlimited.com>
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

The search folder object path is made from the name of the folder
searched, e.g. /Filesystem/My Music/search. A name with characters an
object path cannot have, such as a space, fails to register, and
media_player_search_complete() dereferences the NULL item.

To reproduce, browse a target with a folder named "My Music", change to
it and call Search:

  media_player_create_subfolder() /Filesystem/My Music/search
  media_folder_create_item() D-Bus failed to register
      org.bluez.MediaItem1 on
      /org/bluez/hci0/dev_00_AA_01_01_00_42/avrcp/player0/Filesystem/My
      Music/search path
  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  dbus_message_iter_append_basic () from libdbus-1.so.3
  #1  dbus_message_append_args_valist () from libdbus-1.so.3
  #2  g_dbus_create_reply_valist (...) at gdbus/object.c:1572
  #3  g_dbus_create_reply (...) at gdbus/object.c:1587
  #4  media_player_search_complete (mp=..., ret=2) at
      profiles/audio/player.c:741
  #5  avrcp_search_rsp (...) at profiles/audio/avrcp.c:4460
  #6  browsing_response (...) at profiles/audio/avctp.c:964

Replace those characters with '_' in the object path of a folder named
by its path, as the search folder and the folders of the browsed player
are, and fail the search if the folder still cannot be created.

Fixes: 0a232a434d4b ("audio/player: Add implementation of MediaFolder.Search")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/player.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 4c94dcab4..bfc51ac4b 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -730,8 +730,17 @@ void media_player_search_complete(struct media_player *mp, int ret)
 	}
 
 	if (search == NULL) {
+		struct media_item *item;
+
+		item = media_player_create_subfolder(mp, "search", 0);
+		if (item == NULL) {
+			reply = btd_error_failed(mp->msg,
+					"Unable to create search folder");
+			goto done;
+		}
+
 		search = g_new0(struct media_folder, 1);
-		search->item = media_player_create_subfolder(mp, "search", 0);
+		search->item = item;
 		mp->search = search;
 		mp->folders = g_slist_prepend(mp->folders, search);
 	}
@@ -1890,11 +1899,16 @@ static struct media_item *media_folder_create_item(struct media_player *mp,
 	item->player = mp;
 	item->uid = uid;
 
-	if (!uid && name[0] == '/')
+	if (!uid && name[0] == '/') {
 		item->path = g_strdup_printf("%s%s", mp->path, name);
-	else
+
+		/* Replace what a D-Bus object path cannot have with '_' */
+		g_strcanon(item->path + strlen(mp->path), G_CSET_A_2_Z
+					G_CSET_a_2_z G_CSET_DIGITS "_/", '_');
+	} else {
 		item->path = g_strdup_printf("%s/item%" PRIu64 "",
 						folder->item->path, uid);
+	}
 
 	item->name = g_strdup(name);
 	item->type = type;
-- 
2.43.0

