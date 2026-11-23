Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453183;
	b=YBj9DDsetB61OBG7dlOv/oLFu//cpO0XfYjSbm4xuXJpXmLWydWu3qVMVVv3eFjWTA7u
	 LFCuSYLK3v815lKq8363y788tu0C3Sxgqrtx3BGesPKQLXg26C1mlEm0P0N31+2n+bsyS
	 eMDIVnh0m5qmb/MxN7Cg8m3roM16lgUzDQdtS+tGmH0IPQ2Ak5KIZTEZ8YjE9Wbxx2crw
	 fF9IQcwrjgoB7KmEktHMCvhYMu7u1iIkulgXulfBVriw9vby7H0u44aeeSQgzhn5aqLfi
	 5bXfeWici/Ia0nEngjL62qkFXApp2EQ8UR1Dggi/b+elB7on+6qQ/sot9niZjcz64PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OVYcvEv2FvzrRHg2HxR5L56GzrbvfJImI8AnXyG5nGs=;
	b=CR8I2P0Yh9oBTgPwBYXf1X76x9ntE0aKWJEhS0UbJjYuVOLbYV87yhgDZJW4TNWAOjyN
	 px4erJ4ljzeLmTphZo+dXLRdezKIWnO9KbA7CKlzfuOYGehaJgFRkBhP3Oyc9C/sjaa8o
	 BkquaJApCWVPF1XkZcOacWzUqP1zqdVIj0mXd/usJT81mJqKM3sKqgwIF6AQ+lqgVt8Im
	 pvZ01/U8utkrXJH6Mdn4eq9EX06H/J8oMGGsS8rQmnvTnnmRvRaPy7+k6zreN7B6zPYMD
	 eibatqa5OeVtO646++XI4EGUOFiO+lLUZGcMNghhbYMmjFvSFmRa0QLzPVAoC/c6EyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=XIicRRsP;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412C606A699
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D412C606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=XIicRRsP
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so2890851f8f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453181; x=1796057981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVYcvEv2FvzrRHg2HxR5L56GzrbvfJImI8AnXyG5nGs=;
        b=XIicRRsPDCP7lAqN1ixoRqe5yARL+PcRWw+MLjNjzcUhdpWcu9VTX3Ol2HQHkvhqCO
         g145Sg8L4AmjnA0dIoE47v9rc+WKYbNMCiieukmR2RBM5gfCerr1e4SgZ92oSyO+I7WO
         nsJu/JSKZ0c8VOm0tgcRX4skVSIM7g9C+1GZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453181; x=1796057981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVYcvEv2FvzrRHg2HxR5L56GzrbvfJImI8AnXyG5nGs=;
        b=SdxxNV2Is/HAQVRs+6QxzVpu0atCTVb8fIl8OG18WS3CCNhbTt+Im1TGqG7Pa/Pp77
         2AUIToOCzkK7UnehLWqrK4HOK1hwAG3SC6AzdVgW+5oR3QC+Y88xo1W2NXd85GH9prnt
         O4vzqj8l7THFtorwSV22eAEQqEfcnS3uyjWnkPWfjkc/BPQP4+VCxAoHhD8AliHXvKJH
         J6c6Ijh5+V4h9FoD6YAunhQPT9zOckZvl977YaipmSahnuFN61mD8sOnhM4v5h5aiAy2
         yJvFUUCXJuOSvVWfEff7Gl+hhoVjGolrJpQVg+6F9UA3FRaS4q/vUotkxKnLKJNFRg06
         bB3Q==
X-Gm-Message-State: APuU4Z/AvqVWsWdbAO300jF29r8tlJBzjbTQFyUSMW6yxsq0rWEFrlaT
	zyOonJZckehFsPPys4VgI2IMXBR07UOnkDp6H+1JYY5VesiG/+4wKbDHGalRk3uKgGH0lCyYUK/
	j47If
X-Gm-Gg: AZFdTZfEaYKiwMcDNJBpgmCHu+xD7dxIUnGBoggJEfMNdjXRbYxcf73LpTXiwfGNOr2
	DO13lX5MLAyx8TjEWkm5SkjlPLCTfZvOu/pDZZlWuqaUvA7yKZ/Vr1LVDwqAmmNWGQLTC/RKgIl
	xyXsRLTUPoL4IZgRJwS/WRLudVx8srPih8sIJbeuLa1AhsMrefTGmiIE8mbk+tjFa8DGyMEn1ap
	aLWlc3jVWv+fepWqvv8wBqV0bb5vCW6WnBqIg3jSgnE2VvF1FPggdlcP066qTgrHWP3Ow1tfE8f
	2AcVnoP2sQ6yYM6gfhSJQkrIdwL+Pf9Zp/5vXVpj/a1A3G3MR0qijMU+CIhBXXOI19kdojptW0j
	I1k41nc50sXbGfTj4YuSXxIrMQ13rug6yPN95lVao7QpDiY9d7HoH6XaTBb/6RE8KHD3eU6aMPw
	qnI+KkL1C0JFCr5U3L3umSDSum63l3seO4Ay3X1s15K+/yVeGi+h78vfauiBLRScy7laeOsex4y
	xHCiANTenT7UdGcolEZ7JiIqNcLVf18IlM4zoZTr0tnKDm+IfULhFJ98cUYJANlVT9IgDDQ4y/9
	aRAWl6eOBFWv6tUPwhznU/fQPxCOzXvxAc10PS6Uyhs7SdbA5Q==
X-Received: by 2002:a05:600c:3555:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4bb8881da76mr246436155e9.34.1795453181239;
        Mon, 23 Nov 2026 08:59:41 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm289748185e9.2.2026.11.23.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:59:41 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 6/8] player: Fix crash on Search in a folder with a space in its name
Date: Mon, 23 Nov 2026 17:59:30 +0100
Message-ID: <20261123165932.470612-7-simon.mikuda@streamunlimited.com>
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

