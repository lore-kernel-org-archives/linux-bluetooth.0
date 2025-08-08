Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B29274B2F
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680267; cv=none; b=hr2lKXNEEYp1u3gY2+E5vGqqQ0lrfamMk2DEDtZRW6LpkbAb1xOb1iQYADKakHC6atVy3mzHAAnf4JKrzeahbwF26mRyvzcRCdk/HAeJ2n8ljl+oCQ7MrPpRVKuZIBbT9pX8KiDhjYii9db1v7ps49SfvhDkkmrawc3gMu7AK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680267; c=relaxed/simple;
	bh=kdaXLa1orhcIlbao/Pt7mEB7aWZVjD51+sKWpsAVlFE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KksbW8VfRbX02ySSl53Z5II0AtVLo/FH57+zHUDEXhJ7MmXhmuoGaDGgX0VmLX5BQl2gQVRxb5gRbc7SSYJV3uyvewMQV+ucUeqVsEWMpNFDSpf4qwsjcSEaxUwIo/kKR9Dx2U3loWRrXreFnJBV9pZWOi1Eo3VORGWAhvRsGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWpYI3Rl; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWpYI3Rl"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4fc18de8e1bso805931137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Aug 2025 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680264; x=1755285064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nAbM9ShpQ+lGksOUokrZC2+o2SobnbwzlUIOi1cUSn0=;
        b=TWpYI3Rl3Mxi837AL6orwvvL53JcQJSEyV4ZaqHkbrkdn18RhQQUDU82lSc8QEqeG6
         0ohgDJdA1ENKhpvCR8n1pQvsVIrj5o1Y+PMqUjNi6HN5lIW6BeyneGKihmqw7zLeyL1r
         pLcKv+rhQRl7a+G1V7YI9Mkm/n0EEfTX+3/Wzl95/zRcy1OzO0B6ksHKRhiMwsOFz6Oh
         rTQMJh8u5/zdBA06VimOjbUCFfP5+AjF/tgJbtBR4g+Kln0AB3A27ntgYTAi+zgluNnz
         QbhroKwOnhZqZRPizU/GGqX+Fy+0zpvrmiKa9vt7AZ/duPqFktFNtctXFWhaEm82AD/m
         KjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680264; x=1755285064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAbM9ShpQ+lGksOUokrZC2+o2SobnbwzlUIOi1cUSn0=;
        b=dfGz0Fhqam8sCbPJeZkyePkGVoXAWm9uuzAC2T/DWYk5ASgu7Advi+BDm0xgd9+6jX
         fGv6CbvxlJ/y/H42O8lp27mPoc349Rz2rLiuqrRf/ooJmbIDIHoDyuqtjoYkO22psm+4
         vi8M0Bg5UCLHYETpKpbJQAGjLelXl5uq4S+IbxzyJR11M4LoMYrJym3aZ19p9YdwpyHh
         6UTIs4kHVEjTV3mBwAR6iHrqBurZmyoTPiEx5SLjL6o2hpSl6PWmk8VfVZofqx39luE7
         K2kd6Ou+annhk5cmGD3bP+FvcEQtL1uduE5KzoPB4ksQWnjHGq3cnNyu4A3Z0MwjavpN
         YR2g==
X-Gm-Message-State: AOJu0YxoZFutoM9euiz820wJRxyMX2KJTxAW/ZZ4HYEJ1EAR6HLFPN9k
	T5m/LGRmLdXt5K1fJIlpr+w2zQ0rkxOPvuZ+rh2zgl0H9Ve9ROPxwlpTDkJoxl8p
X-Gm-Gg: ASbGncv8MVOozC7Tnp/oSMoGF4Cc81cLLRTNwbPktwoLcYV9SFgi8dDmrspE969v1uN
	XIwk3JJK5tmXwC3YSDs9++hoNeoQODsIY11kSXW/RalIfzn4C3wGuYNuEvsAIs0mjGKT/6GS9jb
	2UAUoOo5tya96pq8gRusQmetB2WA6uME1uCRbBu5wrRdKUGoMwscUnMyGb5bS22nCRfCTHdkUFy
	MGST6AKdG/RLqPq29+E8c5tESMkZMqbwJjxODtsb2qyn6rDlyKgElXvh0MWGllnSIpQiO7uAfOZ
	keWgoioWCVWJkyhfqtdfKfjAUJbI34MmTmsPVD+xuwIbBgBtgLs3qMBIdPtnRjqtoevzjtv08dK
	PdbbTW1LPuJ9+hiH4kF5JNbO9PnDbkn133yQW7470qBFrOuvPqDOdG/YnvWmYFS72
X-Google-Smtp-Source: AGHT+IHgttS/I5vchcVBcOYeNFXWc3ucp+/meP0vDWPpdmy6ZzbSoSEa8h+zZlvaax99V7o2bAY05g==
X-Received: by 2002:a05:6102:334a:b0:4fc:782c:27af with SMTP id ada2fe7eead31-5060d7a7309mr1751152137.9.1754680263380;
        Fri, 08 Aug 2025 12:11:03 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5062b6519fdsm510824137.10.2025.08.08.12.11.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:11:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] iso-tester: Add ISO Reconnect Send and Receive #16
Date: Fri,  8 Aug 2025 15:10:53 -0400
Message-ID: <20250808191053.648211-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ISO Reconnect Send and Receive #16 which test reconnecting,
send/receive datas, 16 times to stress test the handling of reconnecting
logic and confirm tha POLLOUT is generated everytime:

ISO Reconnect Send and Receive #16 - Success - run
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #16...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #15...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #14...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #13...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #12...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #11...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #10...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #9...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #8...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #7...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #6...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #5...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #4...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #3...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #2...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
  Reconnecting #1...
  Connecting to 00:AA:01:01:00:00...
  Connect 0 in progress
  Accept client connection with handle 0x0101: 0x00
  New client connection with handle 0x0101
  Successfully connected
  POLLOUT event received
  Writing 40 bytes of data
  Receive 40 bytes of data
  Client received 40 bytes of data
  Disconnecting...
  ISO handle 0x0101 disconnected
  Successfully disconnected
ISO Reconnect Send and Receive #16 - Success - test passed
---
 tools/iso-tester.c | 171 +++++++++++++++++++++++++++------------------
 1 file changed, 104 insertions(+), 67 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 7c0cfc408952..ea73782a54ed 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -474,7 +474,7 @@ struct test_data {
 	unsigned int io_id[4];
 	uint8_t client_num;
 	int step;
-	bool reconnect;
+	uint8_t reconnect;
 	bool suspending;
 	struct tx_tstamp_data tx_ts;
 	int seqnum;
@@ -1189,6 +1189,14 @@ static const struct iso_client_data reconnect_16_2_1 = {
 	.disconnect = true,
 };
 
+static const struct iso_client_data reconnect_16_2_1_send_recv = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.recv = &send_16_2_1,
+	.disconnect = true,
+};
+
 static const struct iso_client_data connect_ac_1_4 = {
 	.qos = AC_1_4,
 	.expect_err = 0
@@ -1616,9 +1624,8 @@ static void bthost_recv_data(const void *buf, uint16_t len, void *user_data)
 			memcmp(isodata->send->iov_base, buf, len))) {
 		if (!isodata->recv->iov_base)
 			tester_test_failed();
-	} else if (!data->step) {
+	} else if (!data->step)
 		tester_test_passed();
-	}
 }
 
 static void bthost_iso_disconnected(void *user_data)
@@ -2198,6 +2205,71 @@ static bool check_bcast_qos(const struct bt_iso_qos *qos1,
 	return true;
 }
 
+static void test_connect(const void *test_data);
+static gboolean iso_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data);
+static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data);
+static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io,
+						uint8_t num, GIOFunc func);
+
+static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = user_data;
+	const struct iso_client_data *isodata = data->test_data;
+
+	data->io_id[0] = 0;
+
+	if (cond & G_IO_HUP) {
+		if (!isodata->bcast && data->handle)
+			tester_test_failed();
+
+		tester_print("Successfully disconnected");
+
+		if (data->reconnect) {
+			tester_print("Reconnecting #%u...", data->reconnect);
+
+			data->reconnect--;
+
+			if (!isodata->server)
+				test_connect(data->test_data);
+			else {
+				GIOChannel *parent =
+					queue_peek_head(data->io_queue);
+
+				data->step++;
+
+				iso_defer_accept_bcast(data,
+					parent, 0, iso_accept_cb);
+			}
+
+			return FALSE;
+		}
+
+		tester_test_passed();
+	} else
+		tester_test_failed();
+
+	return FALSE;
+}
+
+static void iso_shutdown(struct test_data *data, GIOChannel *io)
+{
+	int sk;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_disconnected, data);
+
+	/* Shutdown using SHUT_WR as SHUT_RDWR cause the socket to HUP
+	 * immediately instead of waiting for Disconnect Complete event.
+	 */
+	shutdown(sk, SHUT_WR);
+
+	tester_print("Disconnecting...");
+}
+
 static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -2305,6 +2377,8 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 		tester_test_failed();
 	else if (data->step)
 		return TRUE;
+	else if (isodata->disconnect)
+		iso_shutdown(data, io);
 	else
 		tester_test_passed();
 
@@ -2439,11 +2513,17 @@ static void iso_send_data(struct test_data *data, GIOChannel *io)
 	data->step++;
 }
 
-static void iso_send(struct test_data *data, GIOChannel *io)
+static gboolean iso_pollout(GIOChannel *io, GIOCondition cond,
+				gpointer user_data)
 {
+	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
 	unsigned int count;
 
+	data->io_id[0] = 0;
+
+	tester_print("POLLOUT event received");
+
 	for (count = 0; count < isodata->repeat_send_pre_ts; ++count)
 		iso_send_data(data, io);
 
@@ -2454,74 +2534,18 @@ static void iso_send(struct test_data *data, GIOChannel *io)
 
 	if (isodata->bcast) {
 		tester_test_passed();
-		return;
+		return FALSE;
 	}
 
 	if (isodata->recv)
 		iso_recv(data, io);
-}
-
-static void test_connect(const void *test_data);
-static gboolean iso_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data);
-static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data);
-static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io,
-						uint8_t num, GIOFunc func);
-
-static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	struct test_data *data = user_data;
-	const struct iso_client_data *isodata = data->test_data;
-
-	data->io_id[0] = 0;
-
-	if (cond & G_IO_HUP) {
-		if (!isodata->bcast && data->handle)
-			tester_test_failed();
-
-		tester_print("Successfully disconnected");
-
-		if (data->reconnect) {
-			data->reconnect = false;
-
-			if (!isodata->server)
-				test_connect(data->test_data);
-			else {
-				GIOChannel *parent =
-					queue_peek_head(data->io_queue);
-
-				data->step++;
-
-				iso_defer_accept_bcast(data,
-					parent, 0, iso_accept_cb);
-			}
-
-			return FALSE;
-		}
-
-		tester_test_passed();
-	} else
-		tester_test_failed();
 
 	return FALSE;
 }
 
-static void iso_shutdown(struct test_data *data, GIOChannel *io)
+static void iso_send(struct test_data *data, GIOChannel *io)
 {
-	int sk;
-
-	sk = g_io_channel_unix_get_fd(io);
-
-	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_disconnected, data);
-
-	/* Shutdown using SHUT_WR as SHUT_RDWR cause the socket to HUP
-	 * immediately instead of waiting for Disconnect Complete event.
-	 */
-	shutdown(sk, SHUT_WR);
-
-	tester_print("Disconnecting...");
+	data->io_id[0] = g_io_add_watch(io, G_IO_OUT, iso_pollout, data);
 }
 
 static bool hook_set_event_mask(const void *msg, uint16_t len, void *user_data)
@@ -2855,7 +2879,15 @@ static void test_reconnect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	data->reconnect = true;
+	data->reconnect = 1;
+	test_connect(test_data);
+}
+
+static void test_reconnect_16(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->reconnect = 16;
 	test_connect(test_data);
 }
 
@@ -3490,7 +3522,7 @@ static void test_bcast_reconnect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	data->reconnect = true;
+	data->reconnect = 1;
 	setup_connect(data, 0, iso_connect_cb);
 }
 
@@ -3511,7 +3543,7 @@ static void test_bcast2_reconn(const void *test_data)
 
 	data->io_queue = queue_new();
 
-	data->reconnect = true;
+	data->reconnect = 1;
 	setup_connect_many(data, 2, num, funcs);
 }
 
@@ -3544,7 +3576,7 @@ static void test_bcast_recv_defer_reconnect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	data->reconnect = true;
+	data->reconnect = 1;
 	data->step = 1;
 
 	setup_listen(data, 0, iso_accept_cb);
@@ -3878,6 +3910,11 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_reconnect);
 
+	test_iso("ISO Reconnect Send and Receive #16 - Success",
+						&reconnect_16_2_1_send_recv,
+						setup_powered,
+						test_reconnect_16);
+
 	test_iso("ISO AC 1 & 4 - Success", &connect_ac_1_4, setup_powered,
 							test_connect);
 
-- 
2.50.1

