Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D342620D5
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511502; cv=pass; b=IVqaurYVr1a5e90sbOIKdukysGcICYmXAEf0RKfHdt93q0fj6cuZSRO7td/b3VhHu6qUMa4ZtU0mZdfqG2ruue4WDUPuQf+sU1NxbGV4/z8VfOA0ysZ/gslVZ3TOnrVKlJqNSmJH2K4QiU3JlHbBXjGtz7AIwHDdZk5Yy/X3s+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511502; c=relaxed/simple;
	bh=BnJE6BCJiCKi9ahdTXfQe/LSCxMjGyEzTxxyIJbeKSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6Kz49MAXq/43Z0Hf0leXsY2nDodm9zS+2JalSjvuP+X15pfp7NVGlCfsdyxoe3DK+IdfAOAok6RzZ2+UOvkIE4hIWq3CkJXv4fexnw8SEVx3vdstIByJC68apD0Pofa7QFnOgDgjTpb4hoNEKyggYBJCrMbAeUzgINrnpnGccA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AN0mR7ZH; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AN0mR7ZH"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bgp861HfQz49Psn;
	Mon, 14 Jul 2025 19:44:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752511494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q9FqoJ0N3ofCsSESWqPVLfk0nlfmV8KmWFyvRiH6ims=;
	b=AN0mR7ZHfEEs02fT6ZqHohECGR2ZXQ2HvA3gzCLyNYcA+33v5Spx/ZeDYmotp5X2Jrs7YS
	UiYrCb0fHkA5U7/4sPgEV228lp19S+QMYh+UU1jyUw7PqhKCN7R7ojPU6YHkkd0dPvRT50
	4xLxF+a6La47RRQW+k4BKWcUBBGcI92ycSSJjqas7ruMMyuEGmIHM+jIrNgiozAjjpxo8Y
	QkG8+vk5eZ18kVt5SEXI15f7BJBZFxWT/CwDW9216LuL3Q3VkDqWgwIRppaHs7iousBcfx
	UyYorG1YAASF4H/T0RsN9R1qLArsc8E/Eiw9luuBt05smzEKnpaxkp49PO/iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752511494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q9FqoJ0N3ofCsSESWqPVLfk0nlfmV8KmWFyvRiH6ims=;
	b=a1/DwEAMlpjgerFaLc939VVsvVaKqrZVm6+8ADyMjjdIR4hGb0Q56zKNU0rs4N5hWcmcQs
	Bt5t4i0VdXkddfUSX3DjTcOgMjVgmpqTyJnZjbyQnX/v3fEU1OBs49vjB6SFsIWNrbwUAM
	ypTB6Wq4kf7xNG4JOspTcqmrFmAPQuY3ORcA3YqX3ePfXyI8oUlKx443RhWpOOlMI2NCXV
	oCAiTDDZwoB28o5Zx2EyeJ8V7Zt3zioGrXoa0KgbiaCm63cR9/0uVVK+TMCiMKcjCiRtYi
	rvSl3wsOhjBl0EUWoDHlmiTtRxHmpfzf2esDqpmrlz6sr3zp9JCCm7X43fgZJQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752511494; a=rsa-sha256;
	cv=none;
	b=h1W8a7+CnABWThdS0Bf+WtTc5ZmbykvWDqlnL2oPoEceJ7TY0TjVi9zFZ+/sCaymIuwUoO
	D2TYHXzdHCxLfONdeG2kS/PDqA5zbHppw4sqxHL+PIVvObOdAD5gXPV4b7fmozYnJezTPG
	keViebzJvq8GtvZFM4Phs9g25q3pgQTASL7VyPGaIyyQXjIup7rZZ7rRj29LfgoPqhDdFz
	hUmZ4OYvqUENDN5rwc0L3jdxhgk52bu+rFMC07+yxVCrAMvs1ePB+raBbJTNbx8UpJcJ8S
	hUW0ZXb1/reMQVBHz/hpFwQaf/Ogo5uPMcX6dmFGXNXpWNeSr0lA9MCmGpZprA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2.. 1/3] lib: tools: remove POLL_ERRQUEUE
Date: Mon, 14 Jul 2025 19:44:48 +0300
Message-ID: <2ffec6539fe38318c713b48985aaddda9671f258.1752511478.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This experimental feature did not land to mainline kernel, and probably
would need to be done differently.

Remove defines and tests for it.
---
 lib/bluetooth.h    |   2 -
 src/shared/util.c  |   2 -
 tools/iso-tester.c | 127 +--------------------------------------------
 3 files changed, 1 insertion(+), 130 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 9b6b54d5d..150679d72 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -253,8 +253,6 @@ enum {
 
 #define BT_ISO_BASE		20
 
-#define BT_POLL_ERRQUEUE	21
-
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
diff --git a/src/shared/util.c b/src/shared/util.c
index fa058170e..c2cf2bf72 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1677,8 +1677,6 @@ static const struct {
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
 	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
 		"BlueZ Experimental ISO Socket"},
-	{ "69518c4c-b69f-4679-8bc1-c021b47b5733",
-		"BlueZ Experimental Poll Errqueue"},
 	{ }
 };
 
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 56550882e..2c674171d 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -515,9 +515,6 @@ struct iso_client_data {
 	 * Used for testing TX timestamping OPT_ID.
 	 */
 	unsigned int repeat_send;
-
-	/* Disable BT_POLL_ERRQUEUE before enabling TX timestamping */
-	bool no_poll_errqueue;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io,
@@ -654,18 +651,6 @@ static const uint8_t reset_iso_socket_param[] = {
 	0x00,						/* Action - disable */
 };
 
-static const uint8_t set_poll_errqueue_param[] = {
-	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
-	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
-	0x01,						/* Action - enable */
-};
-
-static const uint8_t reset_poll_errqueue_param[] = {
-	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
-	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
-	0x00,						/* Action - disable */
-};
-
 static void set_iso_socket_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -677,26 +662,9 @@ static void set_iso_socket_callback(uint8_t status, uint16_t length,
 	tester_print("ISO socket feature is enabled");
 }
 
-static void set_poll_errqueue_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	if (status != MGMT_STATUS_SUCCESS) {
-		tester_print("Poll Errqueue feature could not be enabled");
-		return;
-	}
-
-	tester_print("Poll Errqueue feature is enabled");
-}
-
 static void test_pre_setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct iso_client_data *isodata = test_data;
-
-	if (isodata && isodata->no_poll_errqueue) {
-		if (tester_pre_setup_skip_by_default())
-			return;
-	}
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
@@ -712,13 +680,6 @@ static void test_pre_setup(const void *test_data)
 		  sizeof(set_iso_socket_param), set_iso_socket_param,
 		  set_iso_socket_callback, NULL, NULL);
 
-	if (isodata && isodata->no_poll_errqueue) {
-		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
-			  sizeof(set_poll_errqueue_param),
-			  set_poll_errqueue_param,
-			  set_poll_errqueue_callback, NULL, NULL);
-	}
-
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
 					read_index_list_callback, NULL, NULL);
 }
@@ -726,19 +687,11 @@ static void test_pre_setup(const void *test_data)
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	const struct iso_client_data *isodata = test_data;
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
 		  sizeof(reset_iso_socket_param), reset_iso_socket_param,
 		  NULL, NULL, NULL);
 
-	if (isodata && isodata->no_poll_errqueue) {
-		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
-			  sizeof(reset_poll_errqueue_param),
-			  reset_poll_errqueue_param,
-			  NULL, NULL, NULL);
-	}
-
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -1085,16 +1038,6 @@ static const struct iso_client_data connect_send_tx_cmsg_timestamping = {
 	.cmsg_timestamping = true,
 };
 
-static const struct iso_client_data connect_send_tx_no_poll_timestamping = {
-	.qos = QOS_16_2_1,
-	.expect_err = 0,
-	.send = &send_16_2_1,
-	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
-					SOF_TIMESTAMPING_TX_COMPLETION),
-	.repeat_send = 1,
-	.no_poll_errqueue = true,
-};
-
 static const struct iso_client_data listen_16_2_1_recv = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -2319,37 +2262,6 @@ static gboolean iso_recv_errqueue(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-static gboolean iso_fail_errqueue(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	struct test_data *data = user_data;
-
-	tester_warn("Unexpected POLLERR");
-	tester_test_failed();
-
-	data->io_id[3] = 0;
-	return FALSE;
-}
-
-static gboolean iso_timer_errqueue(gpointer user_data)
-{
-	struct test_data *data = user_data;
-	GIOChannel *io;
-	gboolean ret;
-
-	io = queue_peek_head(data->io_queue);
-	g_assert(io);
-
-	ret = iso_recv_errqueue(io, G_IO_IN, data);
-	if (!ret) {
-		if (data->io_id[3])
-			g_source_remove(data->io_id[3]);
-		data->io_id[3] = 0;
-	}
-
-	return ret;
-}
-
 static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 {
 	const struct iso_client_data *isodata = data->test_data;
@@ -2370,39 +2282,7 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	sk = g_io_channel_unix_get_fd(io);
 
-	if (isodata->no_poll_errqueue) {
-		uint32_t flag = 0;
-
-		err = setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
-							&flag, sizeof(flag));
-		if (err < 0) {
-			tester_warn("setsockopt BT_POLL_ERRQUEUE: %s (%d)",
-						strerror(errno), errno);
-			tester_test_failed();
-			return;
-		}
-
-		if (!data->io_queue)
-			data->io_queue = queue_new();
-		queue_push_head(data->io_queue, g_io_channel_ref(io));
-
-		data->io_id[2] = g_timeout_add(100, iso_timer_errqueue, data);
-		data->io_id[3] = g_io_add_watch(io, G_IO_ERR, iso_fail_errqueue,
-									data);
-	} else {
-		uint32_t flag = 1;
-
-		err = setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
-							&flag, sizeof(flag));
-		if (err >= 0) {
-			tester_warn("BT_POLL_ERRQUEUE available");
-			tester_test_failed();
-			return;
-		}
-
-		data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue,
-									data);
-	}
+	data->io_id[2] = g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue, data);
 
 	if (isodata->cmsg_timestamping)
 		so &= ~TS_TX_RECORD_MASK;
@@ -3763,11 +3643,6 @@ int main(int argc, char *argv[])
 			&connect_send_tx_cmsg_timestamping, setup_powered,
 			test_connect);
 
-	/* Test TX timestamping and disabling POLLERR wakeup */
-	test_iso("ISO Send - TX No Poll Timestamping",
-			&connect_send_tx_no_poll_timestamping, setup_powered,
-			test_connect);
-
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
-- 
2.50.1

