Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDD43E9F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572027; cv=pass; b=HG6tQ3ke2j8lTAcIyEqS8kKxkaTOHoop6RCGcYXJRh34lTXWUl1tXzrQDGcmBlmYgfkJfJzRoy/ORjzy6hwdXGXbnMeDbxn9KJdDmsbdsMN2gpSkr9VDXyKLt15mEDcJ/k2wlQK9wnotkk0+BZtEExxqB3ANk0yC/AKs38b/VZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572027; c=relaxed/simple;
	bh=IIpyl12pOaBLck7yxz0NeEKH4cSOt54AR4xNXObnwyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAIAdK7xOfFD4hvTPl/FrOIfVydNnFtmV+SRd/nRQ3YizFYjZlyX3QKOJ+IJEs65QpgRqD0iRDKK8E37rXrkmB79M8KRb95QL00axyJ+Gjs6P7Wub+5tskIbGQ20vwtXbroHEagUB2qgL0ZP5rFxD8I3aZE9VZMe4ZYvf4+15yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=KfYTkNeW; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="KfYTkNeW"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h3prk4B5kzyVG;
	Mon, 20 Jul 2026 21:27:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784572023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4UaVitcOJZOADeR1aUmdoJGY7DMYs2LE5zrtcTl69DE=;
	b=KfYTkNeWczgnKbZx16OXfGEFQKHtQsY0PYjQJ6/kF4woFY/YpT8gv3OjC+erkheJnhGb/C
	bTnwVcjuQHLxd7JIOISupPL7RxGbnlc/xP47WF0aM2COq307nSNSZsy4ukq0HOxUtnvhl4
	Euo5SCRx416E8XoG943jXS9HG0YQNqU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784572023;
	b=UT20mBJuGR3WRwaJINlE6YrOXK5cIRP8ym+5WaotDRDYRPb5LUqoS8C8yFQABnT1IzxCKD
	H66E9f9PVCQIuaWTAYrVao8tuzetOIt4l0imTXpSLPmNVBT5XeGWu+i3DoVvnITPjUuoXQ
	pTyMXzoYE8bSxOM6GeSRYnI/+ylFT4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784572023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4UaVitcOJZOADeR1aUmdoJGY7DMYs2LE5zrtcTl69DE=;
	b=B9d3NihdNUPAZ6ladVpMmrNkwLFvbF3NRzxaaEa4VG3SwDmdau9Mij9xrw8btftWqYEckh
	UeSj94poJrHDLf7KXUy2Yd8Oclw7ZZycZp0FzBgQwooY0sykRXcIFvD3b+GkOqbucgtzZi
	PKVjBCE7m6qSgQBOKwHQ7LWH4trnzt0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] tools/iso-tester: fix GIOChannel refcounting
Date: Mon, 20 Jul 2026 21:26:57 +0300
Message-ID: <77c23b3b0b0b0be0ce52e5718f88f8723dabf7ee.1784571951.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_defer_accept_* consume the reference passed in.  g_io_add_watch gets
a reference.

Fix the refcounting accordingly. Also clear data->io_queue immediately
after the test, so the sockets get closed.

Not leaking references makes "ISO Connect Close - Success" to work
correctly again, exposing a KASAN crash in current kernel.
---
 tools/iso-tester.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 767ee0c57..fe27eaaf3 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -697,10 +697,20 @@ static void test_pre_setup(const void *test_data)
 					read_index_list_callback, NULL, NULL);
 }
 
+static void io_free(void *data)
+{
+	GIOChannel *io = data;
+
+	g_io_channel_unref(io);
+}
+
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
+	if (data->io_queue)
+		queue_remove_all(data->io_queue, NULL, NULL, io_free);
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
 		  sizeof(reset_iso_socket_param), reset_iso_socket_param,
 		  NULL, NULL, NULL);
@@ -709,13 +719,6 @@ static void test_post_teardown(const void *test_data)
 	data->hciemu = NULL;
 }
 
-static void io_free(void *data)
-{
-	GIOChannel *io = data;
-
-	g_io_channel_unref(io);
-}
-
 static void test_data_free(void *test_data)
 {
 	struct test_data *data = test_data;
@@ -2387,8 +2390,10 @@ static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 
 				data->step++;
 
-				iso_defer_accept_bcast(data,
-					parent, 0, iso_accept_cb);
+				if (!iso_defer_accept_bcast(data,
+						g_io_channel_ref(parent), 0,
+						iso_accept_cb))
+					g_io_channel_unref(parent);
 			}
 
 			return FALSE;
@@ -3094,15 +3099,15 @@ static void setup_connect_many(struct test_data *data, uint8_t n, uint8_t *num,
 		data->io_id[num[i]] = g_io_add_watch(io, G_IO_OUT, func[i],
 									NULL);
 
-		if (!isodata->bcast || !data->reconnect)
-			g_io_channel_unref(io);
-		else if (data->io_queue)
+		if (data->io_queue)
 			/* For the broadcast reconnect scenario, do not
 			 * unref channel here, to avoid closing the
 			 * socket. All queued channels will be closed
-			 * by test_data_free.
+			 * by test_post_teardown.
 			 */
 			queue_push_tail(data->io_queue, io);
+		else
+			g_io_channel_unref(io);
 
 		tester_print("Connect %d in progress", num[i]);
 
@@ -3495,6 +3500,7 @@ static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
 		if (!iso_defer_accept(data, new_io, num, func)) {
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
+			g_io_channel_unref(new_io);
 		}
 		return false;
 	}
@@ -3724,6 +3730,7 @@ static void test_connect_close(const void *test_data)
 									data);
 
 	shutdown(sk, SHUT_RDWR);
+	g_io_channel_unref(io);
 }
 
 static gboolean iso_connect_wait_close_cb(GIOChannel *io, GIOCondition cond,
-- 
2.55.0

