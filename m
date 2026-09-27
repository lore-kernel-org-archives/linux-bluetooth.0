Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AB397B02
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531408; cv=pass; b=YnV1N73jEG43sMMyb7GciCC1lwfgWsykpo/iCQwcB52a6kLQYpx8Sf8pTgzWSTKi30PKXNhRx+SSKAgl97+/QNWVlLM+lyeRtXYeMMrFmbTaZtUB46Wa8m1ojK1HkuZDU7/diGm9n6H2wkUoEZoU6dRh4ANLAT6iS9YeQ2uTK6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531408; c=relaxed/simple;
	bh=9KyFfDh7d2GWf+Z1hohdaSNHuNvJcjEd5jlJYHwEaFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYt+hIUgt6CDQcz5x7hDz+BStAMBvtA6lcS1PXlg7U8PPr7MTm9YavvjuejHfdzTpkmvPR8RnZoM+iv8G8jOGtz1/Zd5cKePBuHm6E9Rr+jJuEMvIpHTSCnblyfXkvHL3NUW9n5GaEfvUazLBZ1VjJf2zvG6x4O9/eej05HvaVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=R9uM6FjY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="R9uM6FjY"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4htBm14Q2hzyVw;
	Sun, 27 Sep 2026 20:49:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1790531394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6CzkLVl7UBonMB1TmlBMw0O30TPV/vks9/hVX31Pej4=;
	b=R9uM6FjYQjhAttPnAPeL4LjqbBMhw2PK4/9Ij6RTvNp6D+O2fG67nsAMAu/8EzW5DbwVn3
	q5IPesuDhpdnC7vT8pVUqdYqsBz1xH9taLYujo+ozVtdH0z6gsHGgNKsmxSvEKmMMMbuod
	g9KYtG0GkYOe/oSxcU01LqMhl1ytLc0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1790531394;
	b=Yak51DTM2lCnqqSouxh3x0M/GIYIxiZ19tlqVztV8no5YlBM3P168oK/hupSVuztTjPXEh
	fBNzLVIn0uMGcWUdRDrpW4bo6NU1xDkmM/VR6YrzTLEqQMTAYnBOiz+kMrRKb0tQQWIk6K
	nAyaXk4EX7v9zFrerblbFsRyN4ouwoA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1790531394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6CzkLVl7UBonMB1TmlBMw0O30TPV/vks9/hVX31Pej4=;
	b=SDH4J3DF+0Fma0QdItsBsf39nBVTIwpKVdi7yKVPQ5C9gq4SWDCGIM9ARC7U2vStw9RRL4
	IBXmfR0aH0NyAZRgI5HPZCRW80sdksqisAris6hsKLvuHwgnmxymbBWXwxJQMoGS0JY66z
	aGHRU8l3ZdXcPVljuZ6UfYl3JGqQA2I=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] shared: mainloop: Skip removed mainloop events
Date: Sun, 27 Sep 2026 20:49:49 +0300
Message-ID: <fc1baff935104e08b170f528477e31bfedc57c7c.1790531371.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mainloop_remove_fd() on an fd that occurs in the same epoll_wait batch
as the current callback, causes ASan crash.

Several callsites do this, crash is sporadic since it requires suitable
timing.

Fix by adding registration ID in each event and dispatching only if that
registration is still active.

Fixes random btvirt crashes.

Log:
ERROR: AddressSanitizer: heap-use-after-free on address 0x7b7576be3f18
READ of size 8 at 0x7b7576be3f18 thread T0
    #0 0x5637f7b4014f in mainloop_run src/shared/mainloop.c:104
    #1 0x5637f7b41f79 in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #2 0x5637f7aa598b in main emulator/main.c:310
freed by thread T0 here:
    #0 0x7f45788ee4cf in free.part.0 (/lib64/libasan.so.8+0xee4cf)
    #1 0x5637f7b40d05 in mainloop_remove_fd src/shared/mainloop.c:213
previously allocated by thread T0 here:
    #0 0x7f45788ef24f in calloc (/lib64/libasan.so.8+0xef24f)
    #1 0x5637f7b4034b in mainloop_add_fd src/shared/mainloop.c:142

Assisted-by: opencode:gpt-6-sol
---

Notes:
    Triaged with LLM, patches cleaned up manually.

 src/shared/mainloop.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index 9a2e1eee6..b3ec0f2b1 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -35,9 +35,11 @@
 static int epoll_fd;
 static int epoll_terminate;
 static int exit_status = EXIT_SUCCESS;
+static uint64_t next_id;
 
 struct mainloop_data {
 	int fd;
+	uint64_t id;
 	uint32_t events;
 	mainloop_event_func callback;
 	mainloop_destroy_func destroy;
@@ -99,7 +101,13 @@ int mainloop_run(void)
 			continue;
 
 		for (n = 0; n < nfds; n++) {
-			struct mainloop_data *data = events[n].data.ptr;
+			uint64_t id = events[n].data.u64;
+			int fd = id % MAX_MAINLOOP_ENTRIES;
+			struct mainloop_data *data = mainloop_list[fd];
+
+			/* Another callback may have removed it */
+			if (!data || data->id != id)
+				continue;
 
 			data->callback(data->fd, events[n].events,
 							data->user_data);
@@ -145,6 +153,7 @@ int mainloop_add_fd(int fd, uint32_t events, mainloop_event_func callback,
 
 	memset(data, 0, sizeof(*data));
 	data->fd = fd;
+	data->id = ++next_id * MAX_MAINLOOP_ENTRIES + fd;
 	data->events = events;
 	data->callback = callback;
 	data->destroy = destroy;
@@ -152,7 +161,7 @@ int mainloop_add_fd(int fd, uint32_t events, mainloop_event_func callback,
 
 	memset(&ev, 0, sizeof(ev));
 	ev.events = events;
-	ev.data.ptr = data;
+	ev.data.u64 = data->id;
 
 	err = epoll_ctl(epoll_fd, EPOLL_CTL_ADD, data->fd, &ev);
 	if (err < 0) {
@@ -180,7 +189,7 @@ int mainloop_modify_fd(int fd, uint32_t events)
 
 	memset(&ev, 0, sizeof(ev));
 	ev.events = events;
-	ev.data.ptr = data;
+	ev.data.u64 = data->id;
 
 	err = epoll_ctl(epoll_fd, EPOLL_CTL_MOD, data->fd, &ev);
 	if (err < 0)
-- 
2.55.0

