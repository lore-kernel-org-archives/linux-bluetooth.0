Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C31153574
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168820; cv=pass; b=mgjxC7pgUeVmmqulBB4se4kEVk0VXyQ1ZjHXHkfceWWvP60xM7PRnQVyCYLneV/sl4yIt96fQaOF67/qj9X/k9vewegMTMa/PdvXW96uzjAsf2BQz3aCPMcIZpSJmbqdAl5qIhcOSmB/3Z0DQEi5oVpnZQka2p6dcQ8jggTt7Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168820; c=relaxed/simple;
	bh=u6xsCkRPNfUcWaIJHgTg3Mwi6O1l001DBY5GqLvIrZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDRjWWolp0b/PeXHO3ThZ2zanmWhNsIGdZRhf+Z4a2hBAj0gNY3LMKqVSE6Xyosoae6uSwwR+8b0BqJQkwdqhVpqFPh9do5t1nT8jOcloHbYCfuJld9nzMKGqoOZ2XjXYqE8hSCqwQyykhLVs/BTsOrpZzgXxCbkfwMvYWUxFhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=UogxKiC8; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="UogxKiC8"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8tWD3Pp0z49Q6X;
	Wed,  3 Apr 2024 21:26:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712168808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFqLwmQ/R+8dGLxGdjyFoT4oz92Vy0HCxdyYD/UED34=;
	b=UogxKiC8EGj2b/IMC8Kr5HTNzSSKp3iWx3DZsD684aPpFUcpsmRI2DO8DHctGQv57S8fdn
	nvIhhdXf77k+GQtL4uqpYrNekp58anv+XomjH12tZo8hBTThhQZmPyWlp1K1F9N6spO/Xh
	fWZJ7fJYS8c++DrXZY0U0SojMS5kVC2syANAeZDk1jB+T21NqaGLFQpCptjyZsFQwcxinE
	R7IWKumnKbN+XbUf6nEpLjrZi1s/4MVVAg3V6EhVuV7zEW0JRcnoeNI2ihOf4PphO4YebO
	iSAump2mEyOFqjHofdWk2CIv1W9/IEVpdlO+3psChCGwdUFOcy+16EIwCwK0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712168808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFqLwmQ/R+8dGLxGdjyFoT4oz92Vy0HCxdyYD/UED34=;
	b=Z0A8et/3sg/ufo3F30eIdsSTCI+ak5yh+rp5+FuxUzcYlJNv58eZNBET5eLPIzmrZ41gAH
	llbBt0voRrW3ZCaMF34mQyJrAcSVTz6jeVO9mI0HwNV9ZfZZpWZDZF25gVmvZwyZewWyXY
	M6W8hTUce4I6FJCMxq8jnCcnB25poX7OPmWEjN7rL6Z1/rWOjweuQIvkOjaRlMKJKwXH3m
	VHopSIqKz17+YGwaLTcAoUZUtlu0A0+D7c51SyllAg5rJXdBx+vpni72MDeUk9ajl82cZ9
	C/wyC6QOtaxxoTN8NnFyaIxncXuMQvLV5MI+jb8yiBLuFY/DPTClmWDNYKmC1w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712168808; a=rsa-sha256;
	cv=none;
	b=Sdcfo47f4JtnX15HB8B/C/ZNQqaDOUHB433aYq0mrCJGbCBlW6zb+KM9cZnvItRjwY0GGC
	H/jJ0a2Y2WcFn/4ViJDCiSOPwWThS4ILbmttSzVMrCf+zsLRnHkBQybQGZTxGZfQE6siy7
	fKDhZbflJtdfuHoauaujevCmdmU/NE2hlTug3Q3zKukAMYal3ztSrzENbELJ7ui49F9wSI
	XvMuQG+N0R/FhT4+x/nCOH6BZFlJrcafNmrZJQ1Bbrvzmo2Rk5QRRW3dpPcHMmZMUW0DOQ
	mu8uLF+NpJtrx1F5XjhmlBQ+EA8LnXWnU44zBf5an5buejV9dPT+8LiUyN49ug==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 5/7] sco-tester: add TX timestamping test
Date: Wed,  3 Apr 2024 21:26:35 +0300
Message-ID: <263706744f7171c777d3ce290d5ea1f55b73461a.1712168788.git.pav@iki.fi>
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

