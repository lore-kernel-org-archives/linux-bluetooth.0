Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00F225779
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144977; cv=pass; b=fsiqpud1AFaRSBN5Ns+LlxiC2y9E0pivIqJQIXei2ew1ozMo5kiSlmIbXlriQWVlKE5ddE9BDgKcbHagdEVh9Q2BbM+1pvP5+Q4cbJ1/OEGtSRSfeXw3Y8iDdidv804mtnDGfcHKBSVCosUQsaUeIKvff8dupz6uaZl8RWlnolk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144977; c=relaxed/simple;
	bh=AoxfMHSZt/lut6XytkIvX5bb20CC4p8leeeDqzeyNzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfwSJ+Z+POgTbCWD+2wwDztqRr6UsRauWjvryWY2N3rHmuZGUvNHl5XPf+IoUjZD3pYpOlJbL9RVZbMpyRCAgS+CODfpcjyC2LSemeMKMHv1tF1ND97oF6ZGUhHdWUZj6yOE1C8Gln9Hzs23Y7a20Sx5UcI2uC1GHuvhXLUqB+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=sSFownO3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="sSFownO3"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZXJ1M5kQCz102q;
	Tue,  8 Apr 2025 23:42:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1744144968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07j0uBUXC9xY+bAVxH0TMPWFk6pgsec3qqCCg7J7KVQ=;
	b=sSFownO3/9YqHZbquEuEpxEZGhFkYihKoxhIpOJaUJgIk2RyOnEKkB9/uM/vA7uBJJUGsG
	lESfc0f2sUhPdthNVKRW/Wn64x3hJZcb9x/Dn66tfc+fWfH9rNNRt2g9ZUaXT8omcHwxn+
	t2BT0NvFrFE1GHRk4fBDl3Y2wc5D1AU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1744144968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07j0uBUXC9xY+bAVxH0TMPWFk6pgsec3qqCCg7J7KVQ=;
	b=ke5jR8zN2CUFBW9x3p0fZ3buxrDQcdV2Pd+ha/MKfx4B9r/Hv8NsfQ+Q1KQaBtfEVX3Lsl
	V4hK1asdkyvr3Y7Jus9rrv+DdmMsXauCir3VUDERnV5hBt+Z06ywBO0y3HkaEsM2xVAtc9
	0kApdc7Q+SUHhjXCMlmS80KlJkgCTeQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1744144968; a=rsa-sha256; cv=none;
	b=yVuITsw4yV3LWCHE8pb8LzNgvXU8prD3sXqybdd6Ke7sQYRYD9Oz5T1LoXkKl/3j+qvXQE
	l/69T8CL5DQF2ABb9LW1877BxiGT5M69oBSqCQJCt/KG3m1NS2wLXxjZ2vyVkBl/S+kKj+
	NJQ3CdGwzS+4okoeNemK/YBsvm/P0YQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] bap: don't consider TX timestamps as errors
Date: Tue,  8 Apr 2025 23:42:40 +0300
Message-ID: <9b5dc8ea2e6727e9b83e10cc7bd76c85b5a13c54.1744144760.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aa9cdb0ec03c5fcbf12a2df3d183c47de664bdc1.1744144760.git.pav@iki.fi>
References: <aa9cdb0ec03c5fcbf12a2df3d183c47de664bdc1.1744144760.git.pav@iki.fi>
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

Notes:
    v2:
    - use new API

 profiles/audio/bap.c | 22 ++++++++--------------
 src/shared/bap.c     |  2 ++
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a37e62f76..fd9b751cc 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -39,6 +39,7 @@
 #include "src/btd.h"
 #include "src/dbus-common.h"
 #include "src/shared/util.h"
+#include "src/shared/io.h"
 #include "src/shared/att.h"
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
@@ -1868,8 +1869,7 @@ static void recreate_cig(struct bap_setup *setup)
 	queue_foreach(sessions, recreate_cig_session, &info);
 }
 
-static gboolean setup_io_disconnected(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static void setup_io_disconnected(int cond, void *user_data)
 {
 	struct bap_setup *setup = user_data;
 
@@ -1882,8 +1882,6 @@ static gboolean setup_io_disconnected(GIOChannel *io, GIOCondition cond,
 	/* Check if connecting recreate IO */
 	if (!is_cig_busy(setup->ep->data, setup->qos.ucast.cig_id))
 		recreate_cig(setup);
-
-	return FALSE;
 }
 
 static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
@@ -1964,8 +1962,7 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 		return;
 	}
 
-	setup->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						setup_io_disconnected, setup);
+	setup->io_id = io_glib_add_err_watch(io, setup_io_disconnected, setup);
 
 	setup->io = io;
 	setup->cig_active = !defer;
@@ -2024,8 +2021,7 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 		return;
 	}
 
-	setup->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					setup_io_disconnected, setup);
+	setup->io_id = io_glib_add_err_watch(io, setup_io_disconnected, setup);
 
 	setup->io = io;
 
@@ -2691,9 +2687,8 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 	if (!setup->io) {
 		io = g_io_channel_unix_new(fd);
-		setup->io_id = g_io_add_watch(io,
-					      G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					      setup_io_disconnected, setup);
+		setup->io_id = io_glib_add_err_watch(io, setup_io_disconnected,
+									setup);
 		setup->io = io;
 	} else
 		io = setup->io;
@@ -2736,9 +2731,8 @@ static void bap_connecting_bcast(struct bt_bap_stream *stream, bool state,
 
 	if (!setup->io) {
 		io = g_io_channel_unix_new(fd);
-		setup->io_id = g_io_add_watch(io,
-				G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				setup_io_disconnected, setup);
+		setup->io_id = io_glib_add_err_watch(io, setup_io_disconnected,
+									setup);
 		setup->io = io;
 	} else
 		io = setup->io;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index be35c2e60..3758aa000 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2779,6 +2779,8 @@ static struct bt_bap_stream_io *stream_io_new(struct bt_bap *bap, int fd)
 
 	DBG(bap, "fd %d", fd);
 
+	io_set_ignore_errqueue(io, true);
+
 	sio = new0(struct bt_bap_stream_io, 1);
 	sio->bap = bap;
 	sio->io = io;
-- 
2.49.0

