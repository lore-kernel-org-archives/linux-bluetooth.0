Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177453976A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625621; cv=pass; b=jUgNiXdwy2rTn0IE1eofZ2mfBAT2fo28taWZ0JyqgOIGisS6oJz1aCv2Tgoz4amgW/f8ODFnQeFMhaCrGDW3dgRDcgZBewwHPXtcMtp7Yg9+NXau0X2jKulNj+cU9aBRmY9wbJQAk//C588BGPu2oaPeNMMR/EhVPAPhzvJsXDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625621; c=relaxed/simple;
	bh=wao0LjWLsuYWNCE00cBDc3WJ6+v0zPrNGOj2aLujCmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N35kop+fZfHO10PMcHPVDzC/s7MTlpiOH3wQ1sTTy+Um0lbtwGs5cf2GrXkq0KhfFhnl4HRKuPuyOiqg0mzfgBo6WpzJu581Fi0BnGEEDDeZQbO9grQ9RPJR3BHSglXogEf2corEl+XBtXL0W9rcCTskiC/EXPQh+cPrD1CS24w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iXvfTpJ0; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iXvfTpJ0"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h4BgJ365pz4BKLM;
	Tue, 21 Jul 2026 12:20:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784625612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9SiXMHI9N2IaYEzPBrFsWUZOhtvOzkvX+NfYzfngFuU=;
	b=iXvfTpJ0jy8CmbUhY4OCR+K2d4ffYpxXfRnzHToVsJzUxnwNn8Zgs4ISZKpCchky6Nqi/X
	inZbZd+P0+oSrXtP1VDBkxowB2YGrbBtuUppL9ep6i01gpAWzjcYV8GSPXvlxO1U3K1Z7a
	HXCEHJUADH8yo7issyGCA3oFssWPiY4LEvtJaVEMsLra3Taej/Pvjbl8KCv9eTMdfnxOOb
	7mbzCFnNW0QVEpuS7/n21nGSrjVx3GBffr1DpAPYplDUrtFc1LytGo2Jor8Wi/WHiQ2Jv6
	i4UGdRUckQ/d9uzrYoDDUSWv4TgxrIBQMbWVRI16JbhjVQ9Hw9i69VY3PhRSVQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784625612;
	b=letE5F723+v6mxTtYTn1FlbW2x5NPKk0Y6quR0MepApmCDaQYLJhFH+Q92g0ggkvye+hbX
	gW9wOKkP8ByYX9nTUOn0Hy18PfuBIizshYkMPCP3RO+AofA4SRP5NyqGPM80MV58QdRlLn
	GHXmDQIM9A6hZYXIsTFxV7G6/5URFo5BK0Q1tqlURoLLUZL3BzRERzgE9Ar8gLSBbJfsQ8
	p7kXxCQa5ft/UaUP9R8Owr89Rw2wNselX1Bc/OV56CcDmQcD6j/gHA6DY4ofGIWna2wpn4
	trwM5nts/GWu/3khyCzBAvtvhvCmtQdJxhSV8V1tlcGuW5GGDib2J9K2U9WGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784625612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9SiXMHI9N2IaYEzPBrFsWUZOhtvOzkvX+NfYzfngFuU=;
	b=FOr50Asl/pIPloALCHwQBUU76JVXapUuPDj11Xt6msT14i5xHXmUyq/sT/B8ttkGE/yCSe
	8FFMLQ4W1lDx67PZNCBo1kTA2yGsLttjFEDXjlKYfDxXzn9KrFCDpFYhh5NvLLkZoPbhvu
	f50f4FwJcEz2F0Vm2bsoDVjDx4PBR1zOakhDSgcMeNeiEZqh/tEBNP/JHCQyNDyvGM0tDG
	P3rYL5xQjJB5mTHuz4wDBgBFbRamUz+kJofcB1r4AyCVlgVtSvsdevfKf9RkE/rOcdAOnQ
	XKX8aSNAl1YBvtGZCvn4i+kzKt5Ko18VNSomn7nVQGnUarurn7dWURY6M0mZiA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] tools/iso-tester: add tests for socket shutdown with linger enabled
Date: Tue, 21 Jul 2026 12:20:08 +0300
Message-ID: <f81384d367ad95cbe74338eba688daa46b379feb.1784624911.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests with SO_LINGER enabled, to test kernel sock transitions
properly to BT_CLOSED on shutdown.

Unlike L2CAP, ISO sockets don't have a feature to send POLLHUP only
after HCI Disconnect is received, so only SO_LINGER can be used to test
the sequence is shutdown -> Disconnect, HUP -> release, and not
shutdown -> HUP -> release -> Disconnect.

Add tests:

ISO Defer Linger - Success
ISO Connect Linger - Success
---
 tools/iso-tester.c | 68 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index fe27eaaf3..a792a804b 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -478,6 +478,7 @@ struct test_data {
 	bool suspending;
 	struct tx_tstamp_data tx_ts;
 	int seqnum;
+	GThread *thread;
 };
 
 struct iso_client_data {
@@ -522,6 +523,9 @@ struct iso_client_data {
 	 * Used for testing TX timestamping OPT_ID.
 	 */
 	unsigned int repeat_send;
+
+	/* Whether to enable SO_LINGER (for test_connect_wait_close) */
+	bool so_linger;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io,
@@ -717,6 +721,11 @@ static void test_post_teardown(const void *test_data)
 
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
+
+	if (data->thread) {
+		g_thread_unref(data->thread);
+		data->thread = NULL;
+	}
 }
 
 static void test_data_free(void *test_data)
@@ -1352,6 +1361,19 @@ static const struct iso_client_data connect_ac_1_2_cig_1_2 = {
 	.mconn = true,
 };
 
+static const struct iso_client_data linger_16_2_1 = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.so_linger = true,
+};
+
+static const struct iso_client_data linger_defer_16_2_1 = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.defer = true,
+	.so_linger = true,
+};
+
 static const struct iso_client_data bcast_48_1_g = {
 	.qos = QOS_OUT_48_1_g,
 	.expect_err = 0,
@@ -3679,6 +3701,19 @@ static void test_connect2_busy(const void *test_data)
 	setup_connect(data, 0, iso_connect_cb_busy);
 }
 
+static gpointer shutdown_sk_thread_cb(gpointer data)
+{
+	int sk = PTR_TO_UINT(data);
+	struct timespec start, end;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	shutdown(sk, SHUT_RDWR);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
+	/* Completed before linger timeout? */
+	return UINT_TO_PTR(TS_NSEC(&end) - TS_NSEC(&start) < SEC_NSEC(2));
+}
+
 static gboolean iso_connect_close_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -3688,6 +3723,13 @@ static gboolean iso_connect_close_cb(GIOChannel *io, GIOCondition cond,
 
 	tester_print("Disconnected");
 
+	if (data->thread) {
+		/* Wait for shutdown() to complete, for linger enabled */
+		if (!g_thread_join(data->thread))
+			tester_test_failed();
+		data->thread = NULL;
+	}
+
 	--data->step;
 	if (!data->step)
 		tester_test_passed();
@@ -3737,16 +3779,34 @@ static gboolean iso_connect_wait_close_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct iso_client_data *isodata = data->test_data;
 	int sk;
 
 	tester_print("Connected");
 
 	sk = g_io_channel_unix_get_fd(io);
 
+	if (isodata->so_linger) {
+		struct linger val = { .l_onoff = 1, .l_linger = 2 };
+
+		if (setsockopt(sk, SOL_SOCKET, SO_LINGER, &val, sizeof(val))) {
+			tester_warn("Can't set socket option : %s (%d)",
+							strerror(errno), errno);
+			tester_test_failed();
+			return FALSE;
+		}
+	}
+
 	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_connect_close_cb,
 									data);
 
-	shutdown(sk, SHUT_RDWR);
+	if (!isodata->so_linger)
+		shutdown(sk, SHUT_RDWR);
+	else {
+		/* With linger shutdown() blocks, so run in separate thread */
+		data->thread = g_thread_new("close_sk", shutdown_sk_thread_cb,
+							UINT_TO_PTR(sk));
+	}
 
 	return FALSE;
 }
@@ -4160,6 +4220,12 @@ int main(int argc, char *argv[])
 	test_iso("ISO Connect Wait Close - Success", &connect_16_2_1,
 					setup_powered, test_connect_wait_close);
 
+	test_iso("ISO Defer Linger - Success", &linger_16_2_1,
+					setup_powered, test_connect_wait_close);
+
+	test_iso("ISO Connect Linger - Success", &linger_defer_16_2_1,
+					setup_powered, test_connect_wait_close);
+
 	test_iso("ISO Connect Suspend - Success", &connect_suspend,
 							setup_powered,
 							test_connect_suspend);
-- 
2.55.0

