Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370123FD4
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097975; cv=pass; b=nVkfe9lWDwHHnBeYD4TkbFu+GDGYyIkCum4WzqTuHsWgecgH9K1jGOyib06q+GL+D+NpFVJLPAhDHnNx10gYeFK3JAccKgphC4ELacT1PdF+LyD52pqvg7ev6wiQ01cW214OuPJhCkCPtHOZkFb2jbnlW4M9Y4NAiGIUCtjhYlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097975; c=relaxed/simple;
	bh=UKERzn7VqxK7mUEkXhWD3RABhZzsc+GIC8M4m8E97nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ij43WSqXzv+vyG7vYzjlsbXF3Ddj2JvCLdo9nhbbTflB1pSDk/MOh/WbnT2AKbpE7I4AE03v/89NhBuuIkaDFSh94npm895/qtc1wXI3sY6yhlvoUgo97om+7v62hQ1iw1mrNUy/RD4ABMBA0HpufufAgo3IbTrZPnFjKFEmrog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=oBTDxL0X; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="oBTDxL0X"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPWl52pKz49QC9;
	Sun,  9 Feb 2025 12:46:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEGU5/W8/XopXtFn6EtYW0PWvNEV0XTXVX09PRQkiSU=;
	b=oBTDxL0XqJKVG1qMpGT5fOVS69O33DVlGievlC4udB1hA99MEwygl2hJxv/lUHlrn7FKd0
	7vE3i+NCBX2DTqhQ1mp9n0bQW1WNNDMNVCNJiRBudNFOXoGX2BGKFGz2Uuvjm3my8mzN7p
	xcKRieUTUzRWi+1QO97AWnma9aEltd7QzACCpQxxi4gIBlh7jauFVZm5asZ6guQSDxvqFy
	70z4owRYbceagjUN8yHVYv3mOP/IEhBoSu6ClandG21Q3F760IQYKX5ZusDxBGD5CRbAqx
	XszNc8JYc0oj0koq0VSk5KWcXDv7TskFJh9MSCam2e5rXcJF04yVsyXoS+eSAQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097972; a=rsa-sha256;
	cv=none;
	b=oDexGiWS1JPAut8IKwG6r4hu7pTi48o+rtlH2ZZ9ibOWWz2C37FWq0aYnS980rQkra/mAn
	mF/FNWLGJyvGSYYjnaEyqHj/TsTPVCYd0PZKghFGgVpUnCZAjO7tIYRd4SEvbz8ASNK3nf
	hIVUNO1ZNx42TotJEntGlwyFfnSgEsAtURckuTVVb8NObhq0qhzE7gdUjTd4JNZQmTNK4L
	inzPXTY7nZfS/QIs4siZDVxdRjMUPVdMA86CjTc7hu+/1HxcwzHlsvn5xiBRuTXrjGP/t3
	AhvMOpWTdm03P4UDzPY3z3/4gOrek1QWaVpHVdVwiR47so78k2PHZCOJmYcwcQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEGU5/W8/XopXtFn6EtYW0PWvNEV0XTXVX09PRQkiSU=;
	b=leUb4b6TIrTeoVa1532uERqmHaHFHIVwJ6FOYZWJp924rNGDyrPYlU6/yVawZ8aZybyKpD
	vIMrIjEegpLO/pTrZZp2HYOrpzPFBhxIRxZmeHQWnnHQ5G1PRuR6SWf/HBlriioe32ssMT
	Uo+Qd+PlGiA/0U/NqJVDMKrIztj+LupJjTKYS2fvBQNlr8w8/tnPTbrQVIpzuVU97qhGrG
	n1FnpTy2o6zic4K2XLO2rTXjpEDhbtE+Sk0Htlb6vaKYTKujHbQ9YSUVGdVnN9xo9mIcGi
	2pZj/8CsMVtS7TWiwNW7l9HyX9+hIqYUotMQxv8FQtYX36fpiWfULU8Ou7+gWQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] bap: don't consider TX timestamps as errors
Date: Sun,  9 Feb 2025 12:46:04 +0200
Message-ID: <002a6059d976c202ca7da648025bb4ada7388313.1739097949.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739097949.git.pav@iki.fi>
References: <cover.1739097949.git.pav@iki.fi>
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
index 77df9455a..a1947f9cd 100644
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
@@ -2059,8 +2061,9 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 		return;
 	}
 
-	setup->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						setup_io_disconnected, setup);
+	setup->io_id = io_glib_add_err_watch(io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					setup_io_disconnected, setup);
 
 	setup->io = io;
 	setup->cig_active = !defer;
@@ -2119,7 +2122,8 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 		return;
 	}
 
-	setup->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+	setup->io_id = io_glib_add_err_watch(io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					setup_io_disconnected, setup);
 
 	setup->io = io;
@@ -2797,7 +2801,7 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 	if (!setup->io) {
 		io = g_io_channel_unix_new(fd);
-		setup->io_id = g_io_add_watch(io,
+		setup->io_id = io_glib_add_err_watch(io,
 					      G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					      setup_io_disconnected, setup);
 		setup->io = io;
@@ -2842,7 +2846,7 @@ static void bap_connecting_bcast(struct bt_bap_stream *stream, bool state,
 
 	if (!setup->io) {
 		io = g_io_channel_unix_new(fd);
-		setup->io_id = g_io_add_watch(io,
+		setup->io_id = io_glib_add_err_watch(io,
 				G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				setup_io_disconnected, setup);
 		setup->io = io;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6ffeefa41..b24566c88 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -20,6 +20,7 @@
 #include "lib/uuid.h"
 
 #include "src/shared/io.h"
+#include "src/shared/io-glib.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 #include "src/shared/timeout.h"
@@ -2652,6 +2653,8 @@ static struct bt_bap_stream_io *stream_io_new(struct bt_bap *bap, int fd)
 
 	DBG(bap, "fd %d", fd);
 
+	io_set_use_err_watch(io, true);
+
 	sio = new0(struct bt_bap_stream_io, 1);
 	sio->bap = bap;
 	sio->io = io;
-- 
2.48.1

