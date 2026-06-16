Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96883603F7
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613038; cv=none; b=NIMGjawGbnR0I6LbEghipxHVWGz7HGBTfIkYCnU4eroKe1WYdDUQk0H2lXCl1CJEYvpBu7d4AKVh+VLkj07JgUZyXXNcymdwk5rkfbckkYblU45NUtqh9NBnggKQdUzf7TcPQVSEArGh9aicUW3bqpu5bRwm+n/uohUUMZXAlG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613038; c=relaxed/simple;
	bh=enrYuiwpFCtvOJsehVWjF3fZUcMufZ/1rhMNDXUUQvU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fizoJSkjNGN3OgCpAl5Tk7C3PTIALk79xmpkSwzfxvc3feYOMZotPFhIHoxXjeLIDTJv2m/1Ji5k/2TQfTYDanWl6CkjphDykcs7yrHoYnwMDlTilQzlcWvDVFUI0e27Tn9H4ORCAlagnbV/Yn2RJQRChrkfsA5KSCmOjsccb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gmDMTlH+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gmDMTlH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1781613035;
	bh=enrYuiwpFCtvOJsehVWjF3fZUcMufZ/1rhMNDXUUQvU=;
	h=From:To:Subject:Date:From;
	b=gmDMTlH+djE/1mPtzkr8dchLuTbilE6NYWF1vguC0BhYf+ZG0JMAO/GqASPMybCwF
	 RGSCs7/SLh6VSlXM58OiPtKty3anObIfufvyCpon51FCNFbtIE9sXp7P0HbOtv2llU
	 Mo18H/LunwtSKhzXdEfsuXQonJnecIZUxHUCN/mVd5dMPQ4w3be41yV3+2Q5GVsPnp
	 /oUtRiVBSHaMyjeB28ZVgeLGvGw+imv3WjKC3hxBBxKe7y5YpW+y37NgilmnlRcKSh
	 y5kEd6vrD127kZ7EwA9/WX4eh2x7soW5H2NzGPlpLSTWn3PRRKJEaTBjALEZ51vJme
	 fBY6iE9OOsiPw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2FD4C17E0979
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 14:30:35 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt: Fix gatt-db buffer overflow for cloned db
Date: Tue, 16 Jun 2026 14:30:29 +0200
Message-ID: <20260616123029.301362-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On notify_service_changed() timeout, db_hash_update() is called but
for cloned db the last-handle has not been copied and only one slot is
allocated, ending in buffer overflow:

==288975==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x5020000ac220 at pc 0x55f8b7e551bf bp 0x7ffcd6e9ddf0 sp 0x7ffcd6e9dde0
WRITE of size 8 at 0x5020000ac220 thread T0
    #0 0x55f8b7e551be in gen_hash_m src/shared/gatt-db.c:415
    #1 0x55f8b7e5d817 in gatt_db_service_foreach src/shared/gatt-db.c:1744
    #2 0x55f8b7e5d817 in gatt_db_service_foreach src/shared/gatt-db.c:1722
    #3 0x55f8b7e60c6c in foreach_service_in_range src/shared/gatt-db.c:1633
    #4 0x55f8b7e60c6c in foreach_in_range src/shared/gatt-db.c:1656
    #5 0x55f8b7dde002 in queue_foreach src/shared/queue.c:207
    #6 0x55f8b7e5c435 in gatt_db_foreach_service_in_range src/shared/gatt-db.c:1698
    #7 0x55f8b7e5c87c in db_hash_update src/shared/gatt-db.c:442
    #8 0x55f8b7f15283 in timeout_callback src/shared/timeout-glib.c:25
    #9 0x7fc1845154f1  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e4f1) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #10 0x7fc18451445d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #11 0x7fc184573976  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc976) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #12 0x7fc184514f46 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5df46) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #13 0x55f8b7f157e8 in mainloop_run src/shared/mainloop-glib.c:65
    #14 0x55f8b7f16116 in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #15 0x55f8b7af46df in main src/main.c:1709
    #16 0x7fc18382a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #17 0x7fc18382a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #18 0x55f8b7af68b4 in _start (/home/fdanis/src/bluez/src/bluetoothd+0x6588b4) (BuildId: 89dc89ac5800f58cc305bae57a965b1185601a3e)

0x5020000ac220 is located 0 bytes after 16-byte region [0x5020000ac210,0x5020000ac220)
allocated by thread T0 here:
    #0 0x7fc1846fd9c7 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55f8b7ddf2b6 in util_malloc src/shared/util.c:46
---
 src/shared/gatt-db.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 87cc61cf3..751d4c3da 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -330,6 +330,7 @@ struct gatt_db *gatt_db_clone(struct gatt_db *db)
 		return NULL;
 
 	queue_foreach(db->services, service_clone, clone);
+	clone->last_handle = db->last_handle;
 
 	return clone;
 }
@@ -433,7 +434,7 @@ static bool db_hash_update(void *user_data)
 
 	db->hash_id = 0;
 
-	if (gatt_db_isempty(db))
+	if (gatt_db_isempty(db) || !db->last_handle)
 		return false;
 
 	hash.iov = new0(struct iovec, db->last_handle + 1);
-- 
2.43.0

