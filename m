Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8276F1F
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440499; cv=pass; b=jhcew6SS/iZkyhwgUifKz1hLcaHoTf7vixc7CdtheykH69n1JCc/X2lHQXQcTVHN73LysxJsuVOEOZsDZU1QlG70Jr2ynE7q9hNkUCE3pDCSnXgM6Tf19wjYIfHVKgZ+pwNgvzWIxaWFE1KA+2E6uTzPT3odVrhr6qBb4P1PNYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440499; c=relaxed/simple;
	bh=kRnp7V3lDW3v6atmRTpeyY8sqVIQFjFY0kd1VmPR/Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pxbohy/BU2+Q0KqyxBe8abEhA0RH4Osir/QLN6zpaOhkOo20kuMTs+2P0o8MD6kOe+PvzIPfbKqXS1C4L87r0T+IeESMh9Gzgny7rKMJH+8rVCL3olLcd/H3DsMuEHQwKCq7PaqV5Fe/GTa+d97G7RD/8VvE8O9qPApvQRSz9Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=fDegzOAO; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="fDegzOAO"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TwbLK0nlXz49Pvb;
	Thu, 14 Mar 2024 20:21:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710440489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1ZAG7iQohgKpksnivQ289GL76Qye04C74/31MpvBes=;
	b=fDegzOAOeMxSrpuZbGmMmsI/VPOKUkHN9hv4mE6FSmNpZq/o06Wd3JzTir4oJUcD4yOnJP
	aqzpfO9VOZ3gYpe+KEHWLJcbhurEI67Q44/FA6+8ANgsCQ5Y+oAYlcMfXlkXP7Ahpm8XIP
	GcZTtFrVb8gkCHBj4cPvt1Cd9QBWe1HFBJgYqq6ueg64IXJVNP42h6CpYzQSqiscdMLpO5
	YQB/WwJP07CwfLMzf+2TlkDrjAvbzQ/Fhf8HUnNUI7PXJCFtTGi+Jm4w7FK1jfPrGIcJFE
	ZaeuAeRnTgTrLYVmmokSBc7IFgRHwz/LvrI9PdXr6PcFwe6WCZ6iuNdNgfmLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710440489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1ZAG7iQohgKpksnivQ289GL76Qye04C74/31MpvBes=;
	b=g7LKvCmVTmxsBMsM1Vf2hND/8FzQG2W+047rjYG0cGKCxXfXYf4LKzSj2m9bVilFOFB5V2
	W6UoBiDCQ4UwiBl2umdBOxcmDbZK2jQqf4v/MjK2HKSFq/vu8/lbBZT4vsoAQT4QGnGlYj
	oUB7SA9NSN1tCqUlf1mIbryvDdAywtrKIznNgE2+8sBP3eLUw0v5SFMwG/XjspySZsao2u
	zBihVW1J/jMbcB6ZGYrsXNM/bPub317QmjqyCB1smjAXhmNKpBnxB9jR2sbySpS4cDqQSD
	QU3+irI4R6za4WaYdrz+MT4WQtytPsGfAeTSxJpBjfpNS9UXeRieUJ67hSi5nQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710440489; a=rsa-sha256;
	cv=none;
	b=gZittj2dAD+I9YuSHGm4Iw9JoyLWtdsfNBG7Nj/Qv6SwPgd1dNJ4YzDMwgk4GEnR2ANrBL
	+dri9Ap9vIo1WyIvZfIL9R0LEevu1TZANvowZwPbdRImPaoQY9v2fNel+LlOiTzznVzARN
	BullTPX3cGqnEM3Z0SldWylNYTsm3zvrkYdEGFagHfJkeyKGRCwFL/cloKtXJxmZd+hKVi
	daOSv8GvXAzmSxBJgXwVLVgpc0hxPD8H2i2x18f0OrO7cHoFM+D5jSf7NcQHUNO/DOn2Ti
	7Vv5cBqxvBLb/nyuAx6Jx99VtDPE4piGfnNnUxKpz31w83ybX44m4np6VWoOeQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 3/9] l2cap-tester: Add test for TX timestamping
Date: Thu, 14 Mar 2024 20:21:12 +0200
Message-ID: <ab857b100794c335dcde59dec5614bb7aa6411c8.1710440408.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710440408.git.pav@iki.fi>
References: <cover.1710440408.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test

L2CAP BR/EDR Client - TX Timestamping
---
 tools/l2cap-tester.c | 106 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 461f2c27c..f990110d9 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -30,6 +30,9 @@
 
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/util.h"
+
+#include "tester-utils.h"
 
 struct test_data {
 	const void *test_data;
@@ -38,12 +41,15 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	unsigned int io_id;
+	unsigned int err_io_id;
 	uint16_t handle;
 	uint16_t scid;
 	uint16_t dcid;
 	int sk;
 	int sk2;
 	bool host_disconnected;
+	int step;
+	struct tx_tstamp_data tx_ts;
 };
 
 struct l2cap_data {
@@ -86,6 +92,9 @@ struct l2cap_data {
 	bool defer;
 
 	bool shut_sock_wr;
+
+	uint32_t so_timestamping;
+	unsigned int send_extra;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -226,6 +235,11 @@ static void test_post_teardown(const void *test_data)
 		data->io_id = 0;
 	}
 
+	if (data->err_io_id > 0) {
+		g_source_remove(data->err_io_id);
+		data->err_io_id = 0;
+	}
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -245,6 +259,7 @@ static void test_data_free(void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
 		user->io_id = 0; \
+		user->err_io_id = 0; \
 		user->test_data = data; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
@@ -259,6 +274,7 @@ static void test_data_free(void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_LE; \
 		user->io_id = 0; \
+		user->err_io_id = 0; \
 		user->test_data = data; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
@@ -321,6 +337,17 @@ static const struct l2cap_data client_connect_write_success_test = {
 	.data_len = sizeof(l2_data),
 };
 
+static const struct l2cap_data client_connect_tx_timestamping_test = {
+	.client_psm = 0x1001,
+	.server_psm = 0x1001,
+	.write_data = l2_data,
+	.data_len = sizeof(l2_data),
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_SOFTWARE),
+	.send_extra = 2,
+};
+
 static const struct l2cap_data client_connect_shut_wr_success_test = {
 	.client_psm = 0x1001,
 	.server_psm = 0x1001,
@@ -1096,6 +1123,8 @@ static void bthost_received_data(const void *buf, uint16_t len,
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 
+	--data->step;
+
 	if (len != l2data->data_len) {
 		tester_test_failed();
 		return;
@@ -1103,7 +1132,7 @@ static void bthost_received_data(const void *buf, uint16_t len,
 
 	if (memcmp(buf, l2data->write_data, l2data->data_len))
 		tester_test_failed();
-	else
+	else if (!data->step)
 		tester_test_passed();
 }
 
@@ -1207,6 +1236,61 @@ static bool check_mtu(struct test_data *data, int sk)
 	return true;
 }
 
+static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = user_data;
+	const struct l2cap_data *l2data = data->test_data;
+	int sk = g_io_channel_unix_get_fd(io);
+	int err;
+
+	data->step--;
+
+	err = tx_tstamp_recv(&data->tx_ts, sk, l2data->data_len);
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
+static void l2cap_tx_timestamping(struct test_data *data, GIOChannel *io)
+{
+	const struct l2cap_data *l2data = data->test_data;
+	struct so_timestamping so = {
+		.flags = l2data->so_timestamping,
+	};
+	int sk;
+	int err;
+	unsigned int count;
+
+	if (!(l2data->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK))
+		return;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	tester_print("Enabling TX timestamping");
+
+	tx_tstamp_init(&data->tx_ts, l2data->so_timestamping);
+
+	for (count = 0; count < l2data->send_extra + 1; ++count)
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
 static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1249,15 +1333,23 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 	} else if (l2data->write_data) {
 		struct bthost *bthost;
 		ssize_t ret;
+		unsigned int count;
+
+		data->step = 0;
 
 		bthost = hciemu_client_get_host(data->hciemu);
 		bthost_add_cid_hook(bthost, data->handle, data->dcid,
 					bthost_received_data, NULL);
 
-		ret = write(sk, l2data->write_data, l2data->data_len);
-		if (ret != l2data->data_len) {
-			tester_warn("Unable to write all data");
-			tester_test_failed();
+		l2cap_tx_timestamping(data, io);
+
+		for (count = 0; count < l2data->send_extra + 1; ++count) {
+			ret = write(sk, l2data->write_data, l2data->data_len);
+			if (ret != l2data->data_len) {
+				tester_warn("Unable to write all data");
+				tester_test_failed();
+			}
+			++data->step;
 		}
 
 		return FALSE;
@@ -2280,6 +2372,10 @@ int main(int argc, char *argv[])
 					&client_connect_write_success_test,
 					setup_powered_client, test_connect);
 
+	test_l2cap_bredr("L2CAP BR/EDR Client - TX Timestamping",
+					&client_connect_tx_timestamping_test,
+					setup_powered_client, test_connect);
+
 	test_l2cap_bredr("L2CAP BR/EDR Client - Invalid PSM 1",
 					&client_connect_nval_psm_test_1,
 					setup_powered_client, test_connect);
-- 
2.44.0

