Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C572152162
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162769; cv=pass; b=Mpr81AZU49QQV6zRF6LVfX02y6FM5+JTiEUnzLV1vmd4jAzMuVT0Gg+gbo2eKm7d2KepN/GdVOaI2QcJKU7VteH4yCd2VTRiR/dy4uKY4X3vkiAMRq70ORX76cHudNWGHIoSmrvPeeizBhtfRCt2ZA5TeH04BHvfJOJPzk8d8jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162769; c=relaxed/simple;
	bh=u6xsCkRPNfUcWaIJHgTg3Mwi6O1l001DBY5GqLvIrZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i16zVt5lilHf1BCKZjBBfeTOEoXcHakLGF2xcJQYYFjcGnZl3laJVCfbDDvTknyI+NY5tWWAmJgQim6wYazcg1tJt7oli3eJfks4jmNDmcNvD7hDW3457Gt8bOorGW6cXT0ewR0gPVa5XN7nQ0H5ZX+oUqNzs95vED4ArfvBNj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SGVYHsHX; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SGVYHsHX"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8rGy4dnmz49Q6X;
	Wed,  3 Apr 2024 19:46:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712162762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFqLwmQ/R+8dGLxGdjyFoT4oz92Vy0HCxdyYD/UED34=;
	b=SGVYHsHXWwVYE83/BzuMqHR3AqXRcO64QGNGtpt3rUc5lfjMFLhBOyvrTX2CgdAWp6i6Br
	SxASjDb7R0kIZ2Ood9trj23rvmMXTNYIMUkp8jqtzxoUVFPA7F3F3LSUdkxALrXW9PKWWl
	IGK9ibDD2/M1s8uet4a7fqAbiIdoOmBKYEvQIxx67T/caVbfK4MTnjD7lCmQEeCdsEdwVc
	FeTkmHlulovNx9gDM+w+K+2QdrI3wlfjK/tU/q0YUTrsxJGeApr7GHLNRJM77O0SDzBqZ1
	W63EdQMkTIhNdK2ai3JFEkGz8MMrrmr94kKmG+6gAyT6YgG3kiioJFwMih5kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712162762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFqLwmQ/R+8dGLxGdjyFoT4oz92Vy0HCxdyYD/UED34=;
	b=I/w+o0Et6bGBaTkMmYl4Er6ZiNwxJsZzYWXys9IcaWdxCjapp75Bc4S1zEnimKuyOLoCGy
	sdygvYAb0VVDurL+akeE3qhXXF9CBR/78o0rNS7SE75bi10PuKLdyiblrJwYgdOyHky3b3
	veGrRU3sIfWjqdclVwK5VoHKPq3B1NLwTYa+ItXUw+C9sULz/exGqNiyYElBj5u80NXP1F
	0ypVAkMY2Kd3LbDTtvA/nD3yRjsYLBUTKQJaLR+5NE8TwWq0u2Kiao0mFQbS6zRFcoKj12
	RGsyYAyAApuTPgJgWe56V6wtW7L87TpAiAl/gxjuIIHL9W7zOAplaD3i3O+4tg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712162762; a=rsa-sha256;
	cv=none;
	b=pxg10K9njXQk7NLjhsLBXmeZCPfVYtXL0qGtp/qemN/biM1ukCHs9fdPkUP+VSl8hJ7XyX
	IOdcLSOoP7rYcRyWqZJFJNPq71nJx/yksojltFyG4YouAJ3rajgrkqXrk8jfTRq4X4Yeb1
	wiW4Gc7+xkv5c6fiiUCJR9L9A18PKfcu4qIQSxw22FM+V88KcX/uUvDAnqCKgjqSsnuDml
	dPl1/SsXJWfCmkVCBF6Ed1AR31Gp2Sb/Vo6r/hz87JtmfJ24zB6Ss7SHKeWVE4gclMS0/M
	wF2pJM5mho8KfXJdIT1sVrM6YLCwx+dKV16RLdfGDTg1s575K4N2e/Qbt+HFWw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 5/7] sco-tester: add TX timestamping test
Date: Wed,  3 Apr 2024 19:43:24 +0300
Message-ID: <161ee7ceb7f314ce4be9bbcbbb2898d8baea956e.1712161649.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712161649.git.pav@iki.fi>
References: <cover.1712161649.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test:

SCO CVSD Send - TX Timestamping
---
 tools/sco-tester.c | 96 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index ecc65e092..d146a6937 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -31,6 +31,8 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
 
+#include "tester.h"
+
 struct test_data {
 	const void *test_data;
 	struct mgmt *mgmt;
@@ -38,15 +40,24 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	unsigned int io_id;
+	unsigned int err_io_id;
 	int sk;
 	bool disable_esco;
 	bool enable_codecs;
+	int step;
+	struct tx_tstamp_data tx_ts;
 };
 
 struct sco_client_data {
 	int expect_err;
 	const uint8_t *send_data;
 	uint16_t data_len;
+
+	/* Enable SO_TIMESTAMPING with these flags */
+	uint32_t so_timestamping;
+
+	/* Number of additional packets to send. */
+	unsigned int repeat_send;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -227,8 +238,10 @@ static void test_data_free(void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
 		user->io_id = 0; \
+		user->err_io_id = 0; \
 		user->sk = -1; \
 		user->test_data = data; \
+		user->step = 0; \
 		user->disable_esco = _disable_esco; \
 		user->enable_codecs = _enable_codecs; \
 		tester_add_full(name, data, \
@@ -265,6 +278,16 @@ static const struct sco_client_data connect_send_success = {
 	.send_data = data
 };
 
+static const struct sco_client_data connect_send_tx_timestamping = {
+	.expect_err = 0,
+	.data_len = sizeof(data),
+	.send_data = data,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_SOFTWARE),
+	.repeat_send = 2,
+};
+
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -595,6 +618,59 @@ static int connect_sco_sock(struct test_data *data, int sk)
 	return 0;
 }
 
+static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = user_data;
+	const struct sco_client_data *scodata = data->test_data;
+	int sk = g_io_channel_unix_get_fd(io);
+	int err;
+
+	data->step--;
+
+	err = tx_tstamp_recv(&data->tx_ts, sk, scodata->data_len);
+	if (err > 0)
+		return TRUE;
+	else if (!err && !data->step)
+		tester_test_passed();
+	else
+		tester_test_failed();
+
+	data->err_io_id = 0;
+	return FALSE;
+}
+
+static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
+{
+	const struct sco_client_data *scodata = data->test_data;
+	int so = scodata->so_timestamping;
+	int sk;
+	int err;
+	unsigned int count;
+
+	if (!(scodata->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK))
+		return;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	tester_print("Enabling TX timestamping");
+
+	tx_tstamp_init(&data->tx_ts, scodata->so_timestamping);
+
+	for (count = 0; count < scodata->repeat_send + 1; ++count)
+		data->step += tx_tstamp_expect(&data->tx_ts);
+
+	err = setsockopt(sk, SOL_SOCKET, SO_TIMESTAMPING, &so, sizeof(so));
+	if (err < 0) {
+		tester_warn("setsockopt SO_TIMESTAMPING: %s (%d)",
+						strerror(errno), errno);
+		tester_test_failed();
+		return;
+	}
+
+	data->err_io_id = g_io_add_watch(io, G_IO_ERR, recv_errqueue, data);
+}
+
 static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -619,10 +695,20 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	if (scodata->send_data) {
 		ssize_t ret;
+		unsigned int count;
+
+		data->step = 0;
 
-		tester_print("Writing %u bytes of data", scodata->data_len);
+		sco_tx_timestamping(data, io);
 
-		ret = write(sk, scodata->send_data, scodata->data_len);
+		tester_print("Writing %u*%u bytes of data",
+				scodata->repeat_send + 1, scodata->data_len);
+
+		for (count = 0; count < scodata->repeat_send + 1; ++count) {
+			ret = write(sk, scodata->send_data, scodata->data_len);
+			if (scodata->data_len != ret)
+				break;
+		}
 		if (scodata->data_len != ret) {
 			tester_warn("Failed to write %u bytes: %zu %s (%d)",
 					scodata->data_len, ret, strerror(errno),
@@ -633,7 +719,7 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	if (-err != scodata->expect_err)
 		tester_test_failed();
-	else
+	else if (!data->step)
 		tester_test_passed();
 
 	return FALSE;
@@ -869,6 +955,10 @@ int main(int argc, char *argv[])
 	test_sco("SCO CVSD Send - Success", &connect_send_success,
 					setup_powered, test_connect);
 
+	test_sco("SCO CVSD Send - TX Timestamping",
+					&connect_send_tx_timestamping,
+					setup_powered, test_connect);
+
 	test_offload_sco("Basic SCO Get Socket Option - Offload - Success",
 				NULL, setup_powered, test_codecs_getsockopt);
 
-- 
2.44.0

