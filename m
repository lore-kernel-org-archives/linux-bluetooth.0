Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0C13A241
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845540; cv=pass; b=buM69iw5Ba9HOxabUCL4igA68hdOEckj/l4dmMcUxSIr2WuFM8AlZTVp+F07mggrScfXc8TkfeY5Ft/Xg65NaH1E8ZhjLjOXMs3nzGD7FilNS/CpjdiyUSZAsbiGsVSirkYoncF4eyMPmrjhynSAbKFZsBHmE5QuhHyzahBg0Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845540; c=relaxed/simple;
	bh=kIYYQGLmNPp2WNpWvzPG4CtlthVNTYHGmm6CF6qIPno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrKW1xkre7m1yhVENskNFyPiMrZ1xb9Crsapr2LfCCuuR31oxKofOyCrTkZBlNtmYz8KgrpUTW5R0PuGLU2WF1dE/PvHnJ7N5IGCi0fa7NTFgDJtVWG8j0ok2fdmVfSEF8R0rpQSLlgjLFKNe0iiFndzK6Mz0ungbYRSe43sInk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=bCPbRWKB; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="bCPbRWKB"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TrMJp3QsDz49Q9c;
	Thu,  7 Mar 2024 23:05:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1709845531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29R2t663xB73jCCUaDJoPS+ed3MKJ/TFk0HB3rSXttw=;
	b=bCPbRWKBiurFsClbGQPtZKz0KGeqpNJpiSgtCwRFn4ks94DL48mhSXGbgdSfY8zXPCZbxc
	szjOGK5iOvV6MjqS7DZNw5M3vO3RRNxxaFZfm74l/gf4/YpDJUTiRFneovgylTri6quhkS
	LVkKlrWJo/IhLASFyTzDhP1BIuC3w7WigdM3NJ07mezJGxs1sGCuaaq/zhCOgsdu4b8OGq
	Kjbky7PhlixxwdcQo3hBdqSuXpMlfz9r1W2em/ZS/FyrBntxQj5Nv3zY9NqfMnd6Aff4q6
	RioTAjKkjiGN8fOgqHCCntstA+931QyZWdtkhUq6L/c1+b/Epin8ziDixq3ezw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1709845531; a=rsa-sha256;
	cv=none;
	b=qbrT+2bWZOCbyJfNkIWXo3DPWzZuw4GcyV7aqDmJX6tzCRCYnjriQm7eieTvjCisd18Go6
	wUoZx2EBBUAqDeKXqU64ytTIoihnywXuDCY4Sf4tVo+7XIynzerCDq92xvMMNjYlRvkTUo
	UekFdeFjWLJff+O0RJ+Yv9VH8MQB2Y8k6vnxsRKDCwceSBHKBAf1UunoNI6iWsLZO9+EKh
	6lvMT0usJYPMevQPlJ6U/AuX/BaBrtTayo4EpE7xVE2vsFUWEMEYZty7DSyJz3IU6wiw0H
	kaiDNhJuGTDIQqeWCVl44db0d9lz7ZuGWt4FD5m+wQk/ZnhRCBZQBQM8Iqyz4Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1709845531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29R2t663xB73jCCUaDJoPS+ed3MKJ/TFk0HB3rSXttw=;
	b=Nl3BIVgJJ+e/tbPlBphXbvK3XfDY+w6LNlYs1nSJL7Ps5fr+Z9pstbAQBz9uH5ftSUrhQ7
	DaXxyP0cXwSSVkBJbXwT8mQJgj2YCn8trt+5fRzOnZnIydKGQ0HBVFjkP6oqeIJrs+Il9w
	xe/3sxrpISotJM/KP6sQteXN2llLf5nDr73ihyZ7obOgyiGYbebr1++szyPEdRS322PCFD
	+JV6EieYKfHJKwDuHId8wx0vt0rsprnkfLspCtqz+M7QxIWFK2eSnDJrhgmu0UaoLQpd9S
	Mvcnz2X+QqQs+QXtyluzDfs5b5oTk29fFuJDs4F4cRwqL9+YzAEd2ZELjrBuYA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] bap: don't consider TX timestamps as errors
Date: Thu,  7 Mar 2024 23:05:19 +0200
Message-ID: <b1061a29df2cab3f8b94350aa2043e857aa80d4d.1709845195.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <31e0a8235e5c04ad6ae171024e1127c2e7387e28.1709845195.git.pav@iki.fi>
References: <31e0a8235e5c04ad6ae171024e1127c2e7387e28.1709845195.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use io_add_err_watch to avoid considering TX timestamps as errors in the
transport io channel.
---
 profiles/audio/bap.c | 14 +++++++++-----
 src/shared/bap.c     |  3 +++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 1b8a47c52..3ed1ed750 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -39,6 +39,8 @@
 #include "src/btd.h"
 #include "src/dbus-common.h"
 #include "src/shared/util.h"
+#include "src/shared/io.h"
+#include "src/shared/io-glib.h"
 #include "src/shared/att.h"
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
@@ -1867,8 +1869,9 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 		return;
 	}
 
-	setup->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						setup_io_disconnected, setup);
+	setup->io_id = io_glib_add_err_watch(io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					setup_io_disconnected, setup);
 
 	setup->io = io;
 	setup->cig_active = !defer;
@@ -1925,7 +1928,8 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 		return;
 	}
 
-	setup->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+	setup->io_id = io_glib_add_err_watch(io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					setup_io_disconnected, setup);
 
 	setup->io = io;
@@ -2558,7 +2562,7 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 	if (!setup->io) {
 		io = g_io_channel_unix_new(fd);
-		setup->io_id = g_io_add_watch(io,
+		setup->io_id = io_glib_add_err_watch(io,
 					      G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					      setup_io_disconnected, setup);
 		setup->io = io;
@@ -2603,7 +2607,7 @@ static void bap_connecting_bcast(struct bt_bap_stream *stream, bool state,
 
 	if (!setup->io) {
 		io = g_io_channel_unix_new(fd);
-		setup->io_id = g_io_add_watch(io,
+		setup->io_id = io_glib_add_err_watch(io,
 				G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				setup_io_disconnected, setup);
 		setup->io = io;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 37fc1de4e..128d98b6a 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -20,6 +20,7 @@
 #include "lib/uuid.h"
 
 #include "src/shared/io.h"
+#include "src/shared/io-glib.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 #include "src/shared/timeout.h"
@@ -2130,6 +2131,8 @@ static struct bt_bap_stream_io *stream_io_new(struct bt_bap *bap, int fd)
 
 	DBG(bap, "fd %d", fd);
 
+	io_set_use_err_watch(io, true);
+
 	sio = new0(struct bt_bap_stream_io, 1);
 	sio->bap = bap;
 	sio->io = io;
-- 
2.44.0

