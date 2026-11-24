Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512525;
	b=3MAbFxDEGGGl4VhVGxRZ+eFKxCi+npaE1FAU4evsTeQome3EoN4ohHDcZsaZY7TJEgx5
	 vWw1L2UgZuCOQ1hjkYJmLC5svaAr3zMBj+MKQeDjHY74sv/kG0WBxhzJXmxbMsqnzcRfQ
	 Cu+8OKCjsy5JJFejrJAmb1qOhgHV2wfPxjlYlG+cs5J/TvSM6mCeBKPIWmN+7JLapdDXU
	 KtAVAqAErIyV1kgW6gRbRaVP5Js8uZCAj/2jG3k8HcqJ3pVNGsIlxHBvfxOeNz1jiiuOi
	 /mTfiji3f+iuidXEYluMCzWbhxzsskzDIVnnw3V9FeHJavTll6B/SK/UGarMMyQaXkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9I0Y/Fz00U/JfLIJYFe8trRkD9P+BbO9baVK1YGIO5k=;
	b=JMm9edtvW7AYalZVwhgs+Su26YCcVbKrzi8nb23xOzCYbAOWoeIsl/KhNON22L6tApGm
	 87lORfq36xqrK9L8ILNltEPqi7YIxF5Rn/EoY2plkj9P5C5KPLOYmV8KaCUV2J95Son5A
	 mXNGIv4C7Uw5xnCAFAzY6udB4dC+s2Av1LGUeo8sSMLWNcWgSbO51GtzgcFo07f6VeMnO
	 qpGCaCdnDFVXijbA/qoyZF4awlZo5cCoFjzqJdzqK+3K/6ps7p7H9TFMpV2a9qigR25Zk
	 uyo4y0K4vLlPFbzQpTjsbKVkaUE15P8hqlbRMRghtMQTntBTX4Vobsvhvp3GrfjmLnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="0wrxdb/j";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591EA606A683
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591EA606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=0wrxdb/j
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a42b34e930so3734142f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512524; x=1796117324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9I0Y/Fz00U/JfLIJYFe8trRkD9P+BbO9baVK1YGIO5k=;
        b=0wrxdb/jzqyopgTEDCOGFYdczNtyfKJe603cftxvVJ3efUQlZ1nquzc8mhsB/Fo31l
         u0rxWN7/rQ0V+i/z5s3KHtb5XELUyOzv6omw+grwKJPs3yh5LUSooerfdjwpPO8Inbem
         rWYjLntGk2fUfwiKmqpVLq+ZsBNlzXCcCaAO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512524; x=1796117324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9I0Y/Fz00U/JfLIJYFe8trRkD9P+BbO9baVK1YGIO5k=;
        b=sFWwNEFXDUmYa0cNv+MB99PMDFZSkh3mX/qxvrrTMblgOqCk0TUA6numpruk8Zx04w
         fAmovSEnH5G+/ClEWime7ZPyTRDUnIrxVj5PM1aFETJkOfHkRgtVZKPlDuKw47/HAcTr
         FeK7gMmsHHVkBZ2jOMsBTITRghSY9ijZuuWDgVadPGbV/U+zFj1eFCjdUbD+LT1us52V
         aj69ru+P8HI1ZC2SocKlPoYbfdIX/HxHWGIV0pQ7MA1c4tIp6lIGZsFStgs8JEjDfrNJ
         JyhAL1PKZRJrPM/mXPKzUCKc/3HeBCZybi9Qo5itwNwd5F1cbVvj/1/3wUFhUL7QDafN
         JoAA==
X-Gm-Message-State: APuU4Z877+11X0xnAVW0Vz1PSz1ehanRktmPqI/e4LjLs78H6tJjMTUr
	vg4s+o0nNlNfiRhOnegNVf2zYuXduxaW/BTsQmNxDdEuLN77LUNS3DdaHDxsHfEqIMqvbfs6NM/
	Ko09K
X-Gm-Gg: AZFdTZcrdQJW61zErEJELtfeuzff5jOZGLjKJJ41htcbuhQekJYihxEv414ZNXPMt7s
	NroRF0rWPMoJqZgAlhUK9LghISylmWgVQNDHSxoY5Ji53Y4mNtJAugfjdo3IOxpknwHH/MY5eQm
	SkCPg3vTc7St31ifr2DOgHGw6fe3n5/FUg99uYF1nGqupkrLzz+XT/HRYyNXxHeOXUChPCe/QM7
	HMpr+4DpV3vx7NohLPfJrWcFYA9FTiYEurj8Ytit0zYHbznB8K/wokFDISW9DuU0Xx8O+nSaY8x
	f//944BuBbaQUHeoR+TgI+242VhoDd6WkSch/gUofaYAAPvb8kK8op9ePStBeflRxujOhQJ/EQ7
	KrfWzQn9j92gHG8szKomzA6wSOhf05G+5QumEaDh6c8lv2mEAMDvuLLwncHpAhd7i2Z5ePCSh9b
	eeyxxm/KATtQgik70YsxDLmceIuHQX+ryMh7DXmrCeqEMSbNEdYpx3y03iCXZGB93XbflhybKwQ
	3HpA6mS6c3mn7PKkJOk1K9Lzrt588JOXsfv8Vr3UNXZsLBBl1SXdwPtME6j1I6Yy3GNPn6Ie8Dn
	v7U20Y/Tt7b9+jUkJaauH9tzskxe9wO9tARVxCtCL5hSE1MGyw==
X-Received: by 2002:a05:6000:2b85:b0:498:be72:6371 with SMTP id ffacd0b85a97d-4abb27268f2mr16540676f8f.21.1795512523821;
        Tue, 24 Nov 2026 01:28:43 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:43 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 06/10] player: Fix crash on Search in a folder with a space in its name
Date: Tue, 24 Nov 2026 10:28:29 +0100
Message-ID: <20261124092833.1191053-6-simon.mikuda@streamunlimited.com>
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

