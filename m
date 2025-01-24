Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1241CD1F6
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716620; cv=none; b=gIys7gmVBNrguODz4LcsBxIL8a2jG2T81e93frTfCKcQ7j2Gmg2b36C1JcereC8h1MEeu8ZjTllPcvUxO3Lir0cK3DMF1YP0gU8lZrVpl/+PV2A7UNqYwOi6HLLR+zl/D9W/wNGhDwmQGKWzKeLf/8yY3r/5LFocJ2Vljiq0sTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716620; c=relaxed/simple;
	bh=6PGmypZtbWxf5cYs+2F4Q49IvRDwDsll3XiW/Nnvmug=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tR6yCriLgYkxNaeAwKDvPs5T+85xKGWy7n9PRqwmYNW2HuAoUToO8W8NxNzxCZtRlji5+VqICJGe7dydrhf0XVjgDBd/ZEKtRcsDJT7mDkXDI1Xq7XIyWDymhHTxFESeOXLoHVucbpeW+xYoLtGnjsu/49pbV1Mda9/HhFKM4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dpLTSW0Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dpLTSW0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737716616;
	bh=6PGmypZtbWxf5cYs+2F4Q49IvRDwDsll3XiW/Nnvmug=;
	h=From:To:Subject:Date:From;
	b=dpLTSW0YHsgEzIp20yUwEuORJraucD+pizh6u/RZnIMHKiPE5FgghhTxCK3VuXXul
	 9DN82alySxOtcZDi0UWJrcJo5k7tPSJZSgv/LCdWB3Wdf+JCFXZyDtOSR4B+Y8Qkjq
	 2vD7vbtyN7w05jDs2ryO7e8mGGcfZ3O5H+0jOw9xwCSgakAfcnRUjFY1SjY1vBWYIZ
	 402VdfkymIGTNQ5ZBVGRUIHST5lacU9n0Lm480jx4bro5zxKdDqhc9wf2k5k59IEyQ
	 Wt068Dq7HR4irdNe/BuhUeyYNxdDs2mJ9TEstYs2dq7fLLDTPVClL43UoCwR7PxRPi
	 tTDBG1lP4rAvg==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C23017E0237
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 12:03:36 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avrcp: Fix crash on remote player changed
Date: Fri, 24 Jan 2025 12:03:31 +0100
Message-ID: <20250124110331.1003810-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

bluetoothd crashes when the remote player changes while bluetoothd
is waiting for avrcp_list_items reply.

profiles/audio/player.c:1597:9: runtime error: member access within null pointer of type 'struct media_folder'
AddressSanitizer:DEADLYSIGNAL
=================================================================
==825871==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000020 (pc 0x602bb0fffabc bp 0x000000000020 sp 0x7ffef88216d0 T0)
==825871==The signal is caused by a READ memory access.
==825871==Hint: address points to the zero page.
    #0 0x602bb0fffabc in media_folder_find_item profiles/audio/player.c:1597
    #1 0x602bb100cd3b in media_folder_create_item profiles/audio/player.c:1877
    #2 0x602bb100cd3b in media_player_create_item profiles/audio/player.c:1928
    #3 0x602bb107eae6 in parse_media_element profiles/audio/avrcp.c:2605
    #4 0x602bb107eae6 in avrcp_list_items_rsp profiles/audio/avrcp.c:2706
    #5 0x602bb106892f in browsing_response profiles/audio/avctp.c:987
    #6 0x602bb106892f in session_browsing_cb profiles/audio/avctp.c:1028
    #7 0x73de85b1448d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d48d) (BuildId: 461eff2b4df472ba9c32b2358ae9ba018a59a8c5)
    #8 0x73de85b73716  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc716) (BuildId: 461eff2b4df472ba9c32b2358ae9ba018a59a8c5)
    #9 0x73de85b14f76 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5df76) (BuildId: 461eff2b4df472ba9c32b2358ae9ba018a59a8c5)
    #10 0x602bb13a22a8 in mainloop_run src/shared/mainloop-glib.c:66
    #11 0x602bb13a2bb6 in mainloop_run_with_signal src/shared/mainloop-notify.c:189
    #12 0x602bb0fd0257 in main src/main.c:1544
    #13 0x73de84e2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #14 0x73de84e2a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #15 0x602bb0fd3124 in _start (/home/fdanis/src/bluez/src/bluetoothd+0x5c8124) (BuildId: 367892bd0501d74713dd7341977abfac1b2c5d6a)

This can be reproduced using bluetoothctl and doing "player.list-items"
just before switching music player on the remote device.

This commit discards the item list parsing if the current player has
not created a pending_list_items, i.e. it doesn't start this request.
---
 profiles/audio/avrcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9fe8f55e5..6378b7a6e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2661,6 +2661,11 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 	size_t i;
 	int err = 0;
 
+	if (player->p == NULL) {
+		media_player_list_complete(player->user_data, NULL, -EINVAL);
+		return FALSE;
+	}
+
 	if (pdu == NULL) {
 		err = -ETIMEDOUT;
 		goto done;
-- 
2.43.0

