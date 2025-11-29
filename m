Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131431DDA18
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434470; cv=pass; b=qLOSKk/hYC0/emgYQB3vFCtTCXi6uL4/+HSzhQ9o+LlliWvRqKDI6X5iI8o7MDkeiS7KZ1FW9stUD/WJW5lWu93JRbJovwbT4RqGKWNJd2aaLTlajtGIAJxrwYK5Jg96uWlxFxqCnxX7ID3SCiBL7qPDcAxZ9A4K5ti2NHqE4gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434470; c=relaxed/simple;
	bh=uJpgN/g4j+TpseN2MCi9ffeVEHxxNaJ706/rkXWBgjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1xqa1Sbud9jkPKKZj1hGxFQ430iWoJxy5OgSyXR8xKeJ6q+a3NIRtKCBqlcmEP7oel/0mYMCkuRtkuRJOdI82sPoKosFyvlRTB/yDj2hvtJpyUuLdIVz0sh42jmtl4WrTrKM9lZBFyyRKM6zQqOwU/RL7KKu1Oiku9gD6l8I5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=TlUzwS1o; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="TlUzwS1o"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJbX00ZvHzyS8;
	Sat, 29 Nov 2025 18:41:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764434464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ah88DNQLPDrWIA+9birTfnQp89YVTQgsBNKkAXzZ0uA=;
	b=TlUzwS1oSZSBqDAvT0zQp5jwV+IN6RaoAb/VeJF6WO76/wL3a0dY53RObV9WbJEquYuVWv
	mxttwPfeKZhPJOOvnc+zl7BPDiEHddL7AJTth0CWETM1PfXPQ5CpL5PIK5ZUT5lFvG5oPJ
	FFg9m8sOOppIYI052nROicVaAYl8XVs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764434464;
	b=cv2caOBwaGJ55+73BsTnyYeuIr/TRbgfRYt0k3K1AiYHefJlu1wBiTzO/WkHNJy+PDhhKe
	o0EjQ+JptxDpLC+1W/F9vwFQ9Vy6RiuWjL/tDqXZ6Nv8+mVrgfRZPsZPh887ivO1chBo2y
	DySEFgUorzNtpvrTv+iFDC5LxutX4gI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764434464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ah88DNQLPDrWIA+9birTfnQp89YVTQgsBNKkAXzZ0uA=;
	b=GVWyz3/t46JYW4vF1iMwZPG0p/MR4eFgeBD9dOzE3/S8EpLC2uIPSjR6LWLABgUqMiegj1
	z8ZQHVcZD5xspTYAlTtrszUrPVuZH24GmqfMrHRBFsYw5HRAIv7Rkm4ha2d1qFm7kwzq0z
	Xpc1QJZfT+1xLf22ugOfLut9BBRQLEk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/4] sco-tester: add timeout / close during connection tests
Date: Sat, 29 Nov 2025 18:40:59 +0200
Message-ID: <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for connect timeout behavior and kernel corner cases:

eSCO CVSD - Timeout
eSCO CVSD - Close
---

Notes:
    Resend.

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

