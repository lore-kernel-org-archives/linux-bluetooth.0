Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CB153574
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168817; cv=pass; b=k0OzSdiyqbeU2HiopzbeKC1XCftM88Rgk2V7uRsibeKevOLBvKkYUZ5GmsRqVm6Dzrgsr9ShM+6a7W953cNv1m7Kax24MsAnYwM+sw4DCzhHUbIYQc01877LgWoJZ2F4o2PTD4jMHjdv0kIkMVUO1+TCLmG+mCiivNoEZQ/maLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168817; c=relaxed/simple;
	bh=TBTq1/pgDhwcGI4CajQNhPEXompuuII3oKojAvLbc/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvTH/RXg4IZ7Qn0zC5o48gggXELLXKNgo3wqLSnQP9FNc8ll9RNFDUShr6hWDuAUlJpJYxrrYyXmVDpIZXgrKbOrV7hxde/j5Q1niXeyudGj70+q5MXYXozNrFvxMAIIEoi7AB9FZHrfModqpfXp40Z4stXa7FArTWEloOuL8Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZM+rTHoA; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZM+rTHoA"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8tWC6sVnz49Q5D;
	Wed,  3 Apr 2024 21:26:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712168808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7TQLnR6F+9sRt9uphya0SMZPbennG+mfKO57PtPSb8=;
	b=ZM+rTHoAzH2rS/fr75itWbaoRE097t/359bxCq6Tl8M5SS6X/u1ZsxRPce6RDDthZd9LKM
	ETqH4HYyAYNaJ2wNnzsUz5Io1pPwN2PhK3E0NqFfPuM5et9zR5fHnO+Gunc/ack8n+WRYQ
	CwoB+ei4FODIrhh8Sv0HWMHtX8zTMAyf5byWYu6BkQCy0saNqq8uqlzwyJKENGT44iO2bz
	g/Pn6hsj7smmOIWtovc5REcU4WzFZM6tzRryf/pb4rMsP79Pq3vAF8xaCMRYrwfU4Au2Wy
	sFk2I1I8HEtWQySZYE/pBpdYKJXBZjle7QNnfVe5jIaJmj8RkfPTV46CGN03yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712168808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7TQLnR6F+9sRt9uphya0SMZPbennG+mfKO57PtPSb8=;
	b=jYoRR1M67oejl3Tc/cWfQ3lu8MfLFdRQwgM+46nZJs1fnEJLD3x4sUNunnhuSVD0zeHx/O
	5ThaeMn0vYRwl9X6NI/Neb4ohTJD5NZXAd1ZianYjCwtaIhsjDV/s+SiXaNVBmIn/WPLJW
	WrxErWJ5AWb0HX9wlbXWa3tynPJbIdOQM3fyJNcT26Ly9a+cye1sEDFiNYX+0Cmw66/9gM
	HJFgIydDuE4GSaHUEwJrrB+0USOLiuwsob4/MGxv1csEMN/bcRSg8Lhb+PDoy3cWNHWrrq
	4oDl3nYNe4MbCquKudSnMEa5pLGyWZO9VRft97cx/EZbuVoVwXrWBXcQ8SrAjA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712168808; a=rsa-sha256;
	cv=none;
	b=PpTTLnqaliaqy7FmKzPwxXyoo4gWFx3IT831L2RjYPrLuszY2iWcdKUskfkdztLIAHYJ8Y
	UYJKd0XgAVirPrpSMFxBg98PK3QBvG6gaRjCzmRSADDpn2vsmmLqAgyYQ9Ka5jGFp8Na/g
	+0zg/aCaHM4K1sIGK+but+msYKzPsQXv/Swf7QBPGnejW0V6+x9DtzqezFRY3WJlhtvgY3
	xc3TeCs0WsIWByLYff+Ct6qRGib+WtbNMnkHGJlag5xEjMKuPjA5ga322tM/l/+GKTTaZ5
	kSpoY9Aq5Xg0u3U9cvAVLhmH/gKPHEbxjDQ5Jc0HP3cbl5LMXQ1Sn3sVGx90Pg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 3/7] l2cap-tester: Add test for TX timestamping
Date: Wed,  3 Apr 2024 21:26:33 +0300
Message-ID: <458e7f16c66e9988d625cb0dd083e1219b849dcf.1712168788.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712168788.git.pav@iki.fi>
References: <cover.1712168788.git.pav@iki.fi>
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
 tools/l2cap-tester.c | 107 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 5 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 461f2c27c..375ff767b 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -30,6 +30,9 @@
 
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/util.h"
+
+#include "tester.h"
 
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
@@ -86,6 +92,12 @@ struct l2cap_data {
 	bool defer;
 
 	bool shut_sock_wr;
+
+	/* Enable SO_TIMESTAMPING with these flags */
+	uint32_t so_timestamping;
+
+	/* Number of additional packets to send. */
+	unsigned int repeat_send;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -226,6 +238,11 @@ static void test_post_teardown(const void *test_data)
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
@@ -245,6 +262,7 @@ static void test_data_free(void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
 		user->io_id = 0; \
+		user->err_io_id = 0; \
 		user->test_data = data; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
@@ -259,6 +277,7 @@ static void test_data_free(void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_LE; \
 		user->io_id = 0; \
+		user->err_io_id = 0; \
 		user->test_data = data; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
@@ -321,6 +340,17 @@ static const struct l2cap_data client_connect_write_success_test = {
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
+	.repeat_send = 2,
+};
+
 static const struct l2cap_data client_connect_shut_wr_success_test = {
 	.client_psm = 0x1001,
 	.server_psm = 0x1001,
@@ -1096,6 +1126,8 @@ static void bthost_received_data(const void *buf, uint16_t len,
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 
+	--data->step;
+
 	if (len != l2data->data_len) {
 		tester_test_failed();
 		return;
@@ -1103,7 +1135,7 @@ static void bthost_received_data(const void *buf, uint16_t len,
 
 	if (memcmp(buf, l2data->write_data, l2data->data_len))
 		tester_test_failed();
-	else
+	else if (!data->step)
 		tester_test_passed();
 }
 
@@ -1207,6 +1239,59 @@ static bool check_mtu(struct test_data *data, int sk)
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
+	int so = l2data->so_timestamping;
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
+	for (count = 0; count < l2data->repeat_send + 1; ++count)
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
@@ -1249,15 +1334,23 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
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
+		for (count = 0; count < l2data->repeat_send + 1; ++count) {
+			ret = write(sk, l2data->write_data, l2data->data_len);
+			if (ret != l2data->data_len) {
+				tester_warn("Unable to write all data");
+				tester_test_failed();
+			}
+			++data->step;
 		}
 
 		return FALSE;
@@ -2280,6 +2373,10 @@ int main(int argc, char *argv[])
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

