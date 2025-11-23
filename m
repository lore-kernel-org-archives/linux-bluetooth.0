Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1A2638AF
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763928615; cv=pass; b=Z118aeQ0EMGYUGVto6k4I9RCNDuW9eKKYMitsf9+zAUGJubmgrst1G02tPRu6mo7Kr9EQWcZhswIPzmbhIaqP7do5omAe6f/wSLTh9yvgTPYOaVAX+VOSXyyEYJ+qwIGtGAZ4a7KQkb0mLup/w2UBq9jVdtQ8itaKms8PX5pJMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763928615; c=relaxed/simple;
	bh=wK2c9S3cWtD37MSEc5NxS3J0oI4sEk5Bzs+PyazoJrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMsJrH2cU2DPiFuDrWzB0Heup4CU9Ex1bqMkknp55jq1twcilfzQnu6PW8I8o2qvVBcCYXpl5tMuLvlu0SNznxj2J8Wzt3i3m6tP+64keknK+uER9yNTRk8BXcnUsJL0fVMpdTEGvOHAZUr1bOwK5majG/MXJxmT3mV4TcTMeU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BJZ0zWms; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BJZ0zWms"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dF0S13bwgzyQx;
	Sun, 23 Nov 2025 22:10:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763928610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4EOnm+ntDgxjFdynY7hz1DNFHaua/jh4ZvJwQAzEDQM=;
	b=BJZ0zWmsp0khiuEE4AjCK6OobGzrfxpcTp9SC+ZhKaTWv59SnMIOMdDV7nan5JkAfsSamN
	mBmGMWyUj2uKYlLmexWXiwYVumC0Au383U7ALiWhd0p+/BEv8NhIbXOeD/q9RlVztQf416
	LPOPvNCRWr6Zgz2og+PaQ4GkLnVaYe4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763928610;
	b=kSFZVzfi8MK0ZrRj+JrhIyUZ9LHckQfVy2LO+QklixYZPslumG78GoDhcvaNoYZHMTrfi6
	+ezz/Gc57W3bk81xuLOWd/bBr32rxb3/ubCPW5v6yvwe2vVtWL8qMyRFKCkqw3hd04hCHi
	fsEwEivK1wrbtjjJ2mbUKx0MXdPvKjU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763928610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4EOnm+ntDgxjFdynY7hz1DNFHaua/jh4ZvJwQAzEDQM=;
	b=mtuCv3pWGDfX8a/Zu/nRhiiHkfWe+lBNocVt1Bz/so5ptsE6I97ZwHy4XOiAKoLbnsz71I
	b6xxZZQN0DGYPeYrmwlX54KezpdDqTuNZtAab6XlsMyLzxFWoDleeoeSQTyNIxjx2TXT2i
	FAAYOxzS/l4nyvnzTTfINcnw0RM72sk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] sco-tester: add timeout / close during connection tests
Date: Sun, 23 Nov 2025 22:10:04 +0200
Message-ID: <d4a840b0d5c6bde1c6e5a5da6e2479bb2aaad7d3.1763928580.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests:

eSCO CVSD - Timeout
eSCO CVSD - Close
---
 tools/sco-tester.c | 77 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 7 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index d2ab51b35..660f36e07 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -56,9 +56,15 @@ struct sco_client_data {
 	const uint8_t *send_data;
 	uint16_t data_len;
 
+	/* Connect timeout */
+	unsigned int connect_timeout_us;
+
 	/* Shutdown socket after connect */
 	bool shutdown;
 
+	/* Close socket after connect */
+	bool close_after_connect;
+
 	/* Enable SO_TIMESTAMPING with these flags */
 	uint32_t so_timestamping;
 
@@ -247,7 +253,7 @@ static void test_data_free(void *test_data)
 }
 
 #define test_sco_full(name, data, setup, func, _disable_esco, _enable_codecs, \
-							_disable_sco_flowctl) \
+					_disable_sco_flowctl, _timeout) \
 	do { \
 		struct test_data *user; \
 		user = malloc(sizeof(struct test_data)); \
@@ -264,28 +270,39 @@ static void test_data_free(void *test_data)
 		user->disable_sco_flowctl = _disable_sco_flowctl; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 2, user, test_data_free); \
+				test_post_teardown, _timeout, user, \
+				test_data_free); \
 	} while (0)
 
 #define test_sco(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, false, false, false)
+	test_sco_full(name, data, setup, func, false, false, false, 2)
 
 #define test_sco_no_flowctl(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, false, false, true)
+	test_sco_full(name, data, setup, func, false, false, true, 2)
 
 #define test_sco_11(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, true, false, false)
+	test_sco_full(name, data, setup, func, true, false, false, 2)
 
 #define test_sco_11_no_flowctl(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, true, false, true)
+	test_sco_full(name, data, setup, func, true, false, true, 2)
 
 #define test_offload_sco(name, data, setup, func) \
-	test_sco_full(name, data, setup, func, false, true, false)
+	test_sco_full(name, data, setup, func, false, true, false, 2)
 
 static const struct sco_client_data connect_success = {
 	.expect_err = 0
 };
 
+static const struct sco_client_data connect_timeout = {
+	.expect_err = ETIMEDOUT,
+	.connect_timeout_us = 1,
+};
+
+/* Check timeout handling if closed before connect finishes */
+static const struct sco_client_data connect_close = {
+	.close_after_connect = true,
+};
+
 static const struct sco_client_data disconnect_success = {
 	.expect_err = 0,
 	.shutdown = true,
@@ -684,6 +701,7 @@ end:
 
 static int create_sco_sock(struct test_data *data)
 {
+	const struct sco_client_data *scodata = data->test_data;
 	const uint8_t *central_bdaddr;
 	struct sockaddr_sco addr;
 	int sk, err;
@@ -697,6 +715,19 @@ static int create_sco_sock(struct test_data *data)
 		return err;
 	}
 
+	if (scodata->connect_timeout_us) {
+		struct timeval timeout = {
+			.tv_sec = scodata->connect_timeout_us / 1000000,
+			.tv_usec = scodata->connect_timeout_us % 1000000
+		};
+
+		if (setsockopt(sk, SOL_SOCKET, SO_SNDTIMEO,
+					(void *)&timeout, sizeof(timeout))) {
+			tester_warn("failed to set timeout: %m");
+			return -EINVAL;
+		}
+	}
+
 	central_bdaddr = hciemu_get_central_bdaddr(data->hciemu);
 	if (!central_bdaddr) {
 		tester_warn("No central bdaddr");
@@ -923,6 +954,7 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct sco_client_data *scodata = data->test_data;
 	GIOChannel *io;
 	int sk;
 
@@ -938,6 +970,12 @@ static void test_connect(const void *test_data)
 		return;
 	}
 
+	if (scodata->close_after_connect) {
+		close(sk);
+		tester_test_passed();
+		return;
+	}
+
 	data->sk = sk;
 
 	io = g_io_channel_unix_new(sk);
@@ -1036,6 +1074,25 @@ end:
 	close(sk);
 }
 
+static bool hook_delay_evt(const void *msg, uint16_t len, void *user_data)
+{
+	tester_print("Delaying emulator response...");
+	g_usleep(500000);
+	tester_print("Delaying emulator response... Done.");
+	return true;
+}
+
+static void test_connect_delayed(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_SYNC_CONN_COMPLETE,
+					hook_delay_evt, NULL);
+
+	test_connect(test_data);
+}
+
 static bool hook_setup_sync_evt(const void *buf, uint16_t len, void *user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1201,6 +1258,12 @@ int main(int argc, char *argv[])
 	test_sco("eSCO CVSD - Success", &connect_success, setup_powered,
 							test_connect);
 
+	test_sco_full("eSCO CVSD - Timeout", &connect_timeout, setup_powered,
+				test_connect_delayed, false, false, false, 8);
+
+	test_sco("eSCO CVSD - Close", &connect_close, setup_powered,
+						test_connect_delayed);
+
 	test_sco("eSCO mSBC - Success", &connect_success, setup_powered,
 							test_connect_transp);
 
-- 
2.51.1

