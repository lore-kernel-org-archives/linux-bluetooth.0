Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126278F3A
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481720; cv=pass; b=YLjktAlcL0MEELqU2gZbsC7LnH9BN0adkCjYrJoyQem/Mr7QqZ0w2OcPz76AcCc9Ohq3jKWugUYzjaMJuGYahgjtegCwmiCLLHoCvwLEGZ2NINDDaVwd4WT08Pq5PwsSyEYhH9T3mxe0Fwl9bSaPsLuV2461PE1DeLHWcyHK/B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481720; c=relaxed/simple;
	bh=AHmnA+0nFrqwRKyF0nR5AZsdlzIuYC/3RuYY/Jmfnyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulgsegqb4miBb1siwBfJxuEiqrDfeERwuYhTkRyw5wXmD8HH7uNNgjn/x3VUuxp9xIDEN8H/8xS1Ifh+yv5UDjqM0X5Alflebewql/0Bo3PdRrGNkO/ddnzXFHFWebI+ViCSM/ryRZ2hn3IHsFH11RZ+3is5KX7ob3zfsDz0EU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=BGTetn+w; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=c2T5F1id; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="BGTetn+w";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="c2T5F1id"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4hSVw91sjBz49PxH
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 13:41:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1787481705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lY1U4JcCvT80t0d0oHGU5EMw41oDS1GGUw4XmDRwF2k=;
	b=BGTetn+wM7ml26TKY8yBv2f9xYyrYNgUA9rdsItCfeRaYJ1ubf0L+z4sP0rtR1ez5E92iA
	AEYhtEefabV8m4WOSzNyXeHPpI8js7cvolRKMun2x2qGhQwwwujUYebOHUsNrXrY2kv6Ie
	+TM+NgzWAgRS6wQP29MPRmd450N3TJiULrCO41149YSIwn0O8opeBnsF9uyaCksvCFC7ng
	N+aCyepjgr15oTXZaj94qf21Um4z+nWCRLw3+gYmqmjocezMH8AjmBqs3+sGyPd0PMJ4k0
	u48l96YngFCdZa8Q5InZrtqax3HNeGhrMc0mq2yqY9WBLhJaY1m+NO4Sm3mvQA==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::d101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hSVvw4lGczyYL;
	Sun, 23 Aug 2026 13:41:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1787481692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lY1U4JcCvT80t0d0oHGU5EMw41oDS1GGUw4XmDRwF2k=;
	b=c2T5F1idGWjvu/amoHqRV3Sj13tKOGnTer2xk/bcLeID4gmASp2xme7zcdRYiJiEfsSQTp
	WrxDjNqtUOXY4dBFuFXKk/BMRto8KEPnQYj6Dilgt7jtz0FxXX8Ka6FgCNzuy4Lb/LTu3x
	9A/WdBTjpKYVHIt+v/w3Qg6XwpDrFAk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1787481692;
	b=GMR8n6hImhgiGPk+eR9rGM70QaYlTB35cR2/q++Xq+usdLJXaRYw0Q1zNSYzUrXkoGbIgF
	TCEPiG6BHRlngYg993Il0G4oss3KpDO3bagcd0pDUXcfI461l9SkjRdWwpwhL1EEBuVPpX
	clznfzKCw1rAzBa5fb+epm7ci3OndfU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1787481692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lY1U4JcCvT80t0d0oHGU5EMw41oDS1GGUw4XmDRwF2k=;
	b=RN6/z8ttIJYL10LZZcaDa8AABz8epqj5iXBsvH16P6rILwrzo4C9Z5QEymyc/xxK+FkBtp
	3hsOwzG1BNotPIaC1WYMtovpa6zoaHR7JDSusN7ohoGhnvkf5JOyNnhBKQ4fNgldb2Qhbp
	UDdOkpT8Lg9QS1y2ci+Seeq5gcULxmc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] tools/iso-tester: fix GIOChannel refcounting
Date: Sun, 23 Aug 2026 13:41:30 +0300
Message-ID: <a95c6273788e688e4034705305ec0c960739a9c5.1787481678.git.pav@iki.fi>
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
correctly again.
---

Notes:
    v2:
    - resend
    - modify commit message
    - no code changes

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

