Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345061;
	b=2QBYBkrehmBfE8yp2Uosz9VqYl8jAbXh7bUjCc70c20tWnejf73ouUzE6KrM0JCdvPhC
	 PN+xI2R7KCE/KBu5Azc0k2zy1jABc9tSSRZCLDdACqhoPBYQZAdmet9lcAfE76zWpcez2
	 XAQG2STTtHfqz1CDAXPAqUSWeNtML4O00kpdgKUYPfrxx+bz47KOMKGV04fz8pDWmCbbR
	 OnZzs5+Tog12aZTlb/ojAG6Zd3VEFi7wfwEyOWQBppX1zQLOEz5r/WbT36UXptMl66gBo
	 oZ89CNucWOdRNIaif42pIwcwT6W6ESs0z9a+e0W9msxymka+dZ2rNbHKGGNKJCgd6mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OVYcvEv2FvzrRHg2HxR5L56GzrbvfJImI8AnXyG5nGs=;
	b=jip8zZ6J2pVFjzqQ/OWPXqkvKwbl+n+MyUts9y662E0LEuPOTM6e5iiYtGoCi7i806Nn
	 t3LceqBMKkEDALaok1tLmnWw1VYKTSIqeqByyLFcs8ABx9/mbce2cvybI/2yo/+GAL4bD
	 0I0zPWZpXHpT1a0JNgYgcxbRSydfujq/TKIllGLmh2g49VMc+EZ7X8OALIGoijpjXi7PE
	 BKBrAYS5xxG5beKLckX5KwEDx0GJ/+xepAK8Xxmv8YhDcIOR+PInfR/vQrNJFJyeUy3Rd
	 89iOcIODfAWIqgMtrqdSf17sslLPTh8RDVF+2i7J8r6hFBFiJAJ22KCbMfgomajOuDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=AMS+7lgn;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B84606A331
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B84606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=AMS+7lgn
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so18672695e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795345059; x=1795949859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVYcvEv2FvzrRHg2HxR5L56GzrbvfJImI8AnXyG5nGs=;
        b=AMS+7lgn4d550XwFyLZafYxmLnss96S/k65cMe/l+ZZLYHtv1pAoTBdflKv3Blf0Vj
         iyLfzKm/nag7RpKD4bMVOwGSoWI5FW975WkJThY1HZw4vHxRMdaGzSTKgI50kb2ZGnQL
         yHsY1oHv+ugHzUtqgbei19rmNG6XZz2C3qKhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345059; x=1795949859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVYcvEv2FvzrRHg2HxR5L56GzrbvfJImI8AnXyG5nGs=;
        b=c2+JJ9EwpVPZw1w4TjvVo2q5C65JuddMiqifApfs3xGQiWSPZUNaNUI6a9s7yf8Dmu
         yQvxaC4cIaOhCMoNnUn8KcJ2fjTRw4EinyQqpvw7NSmWg6pkdm+Qm0AAFUs551M3no2F
         2MBxfbGSCQz8pImXUioLqBiAKOx60wGAumDyNi0hve0bWAlbtdckHcE3ZoBdp/QpSdXu
         U4GO5eins5waKT9IaNieUQprzDXtzwf2XuaHrL8oZXZXvgZqfxuzaogFAYwEKoIIS4kO
         y8dLL/I5h0oxHXtKfVNvm8rQkMG+2Jar8AoNJg4Z3W5X0ZvoNlgJ9nRVze76eGV5dPS9
         Pfig==
X-Gm-Message-State: APuU4Z8nfWW+Z0oZS1pMZo+UD4FP2FHrlymf9QRRPoOdm9XoyKXgKGF/
	gaO6w8CUe51KZGvPb62hj5TQuTFlf1cQak0WR+2MmLPPT9qUuUiIT7Hg+V+S5+d7t6hmBJwn64B
	hrmfL
X-Gm-Gg: AZFdTZdyeRTb4Zl8eQWy8rP0MPRTIm05/bvge7JFTL327FNQJ2euST46ZEVp8ylWgq0
	tVB6VO0tbBysLw5srtygq4QY12o7ytcuxuwfYxDU58dGpKAivqSx4OW0q7keCtgUy3dqYeYKQyo
	QYypP8etCzD2yl4EK5n10OJHn0mHBZGd5Yeo7xom49J85mAkdGpj9GNqoNlWE6c4yXgnDgvYYa7
	M1WiJckLQ+GyeoV6ePgbej7fclVGfPOMXD6XpKbFMH9lO7p0WHJULJ1UR+GFiICNcrP0hK/DkUz
	6aL/06Xf3xr2oQMHlDKMKQA0SIvnX7m54zcEX6LaHmZMULN7sDTarRpEpxoAJ3rv2jdsnd9p9HI
	zStLoxIV4tH4IhplDFBJLXz3wW8W9Lp40CK+oFpP+uBnxLlWG1nRF+IHr9gribZPs3zuTmu2Wk4
	mkAecMS1emigTVUGcI0tvWPZMuydkaHbfRwkfLp7o1CRCSNN1kCT+1yGV+GOSyeJHwESpLuDS1R
	MHUG9rEVYYm55Q2HkbeSv1eJ/jqnb4iM1OXLZzrCAaFdFqdu1Xy/cAjyHAz/NNGmtgVLWgHo0lw
	3j8jvvFh0O7FhT8PIxfvf0j55XegWJkz5xGNsL+tgZ7o79PmkEpg4TYb95UotXgzQnTKgrk=
X-Received: by 2002:a05:600c:3b88:b0:4a2:191f:7cbd with SMTP id 5b1f17b1804b1-4bb888078a8mr202698015e9.11.1795345059216;
        Sun, 22 Nov 2026 02:57:39 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm300138965e9.7.2026.11.22.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:57:38 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 6/8] player: Fix crash on Search in a folder with a space in its name
Date: Sun, 22 Nov 2026 11:57:29 +0100
Message-ID: <20261122105731.799090-7-simon.mikuda@streamunlimited.com>
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
 profiles/audio/player.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 4c94dcab4..574a026ac 100644
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
@@ -1890,11 +1899,23 @@ static struct media_item *media_folder_create_item(struct media_player *mp,
 	item->player = mp;
 	item->uid = uid;
 
-	if (!uid && name[0] == '/')
+	if (!uid && name[0] == '/') {
+		char *c;
+
 		item->path = g_strdup_printf("%s%s", mp->path, name);
-	else
+
+		/* Folder names may contain characters not valid in a path */
+		for (c = item->path + strlen(mp->path); *c; c++) {
+			if (*c == '/' && c[1] != '/' && c[1] != '\0')
+				continue;
+
+			if (!g_ascii_isalnum(*c) && *c != '_')
+				*c = '_';
+		}
+	} else {
 		item->path = g_strdup_printf("%s/item%" PRIu64 "",
 						folder->item->path, uid);
+	}
 
 	item->name = g_strdup(name);
 	item->type = type;
-- 
2.43.0

