Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737818;
	b=mgweUHcvbTe9Nym1wJsyUMBcu6Em5a+mM7jWXi7Z8GbQa9XKYUHa+BqDvvNZYPKKe5ol
	 xoZWvJJPiB2yUKrgcJL/85YD/zj+qJ6JrTRDzG9JxO+86p5Y5JpnYUMUhXpdvTpd9a2d2
	 bUjaIsC2+UhDKFc316Q211bFoNlWoqbO2e4ddcd9zmlNTKpqGMI3Nz/zvpLlxX++eKhUJ
	 7fE88RM4NK/4QQushZD6lEfKlvhO4GffLyrny3gcR9NT05JeoCkOkmyjjRSMxSj5D8Y+p
	 92VtyHCBgifaIcJKUiiBqmjVjBb4BisrnhH1gi15cR6845n1SbVBLEGFqRr+mGPiWmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8QTaohwhCz5Smms7WEFCKR4ggNmNB1N13T1B/mdnfgU=;
	b=gFZVEEej4VcYNYXX68e00cQYa2U8mKk+hfWM4I1/4Z7uN5LzdOh/5QJUG54V7sise9VG
	 3EPxjXEFF3btcuziwLDmSu6I3Wj0TzDvKIBWLru5952RjTzh8L3aIFnAhtzxWAXFPv+fs
	 aA/3ani9Gxs1GutzimtTMwNfXYAW9ecgIy2sLZHO08j11HUXVJ547fPwh4haLAswuVrBe
	 YLAgwL/BDW3D6fbnKvO6oU8BZjHZhkB7NCUzMHyrNJXAtrFIWA+y1VWlJSCa44bFw74KI
	 Bp0BEm1V0Zepv8H8GI+K9cszI6KgHKpiVZoW0ee2um1ZZM7MBEuvjwtRooMRK/rF7yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0dhO2C1;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EC606A328
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814EC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0dhO2C1
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9851592ada1so5269241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737817; x=1794342617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8QTaohwhCz5Smms7WEFCKR4ggNmNB1N13T1B/mdnfgU=;
        b=c0dhO2C1zytWxDhnnmBu3BZNheDwzotUk8JLEKfkhzctn1e/QpQhtYeY66ZwUaLkxj
         7NANY7ytn5lW7V9rZ/VdhTlxzq1kpm0R60TrXNkZ9H5RUMTjG7k1fr4N2E0h+lqTVjdH
         dvOsiPfKNtdo2P+0qkaVTs6b0cpVbzyhLBNUPRdBfzJlMVz2iamYJ9H3GW5bLFx06UMt
         8UFXeqZwPkMRV6OGRIP4+dz8BlJGFkhkMjiBp0P6Q6Op5OrE8frBqapKuKyWz8//BDWh
         Q9qiqwEMkFaCNkk8hhmpSm8K+HDO9cdD6+zElvxPaMwKRwUIjMBdfJje5oJjrYko/vLv
         V0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737817; x=1794342617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8QTaohwhCz5Smms7WEFCKR4ggNmNB1N13T1B/mdnfgU=;
        b=ibVhU7ZiIoCY2XEZk5/OTs0nRm74Bejkohqztw6LtCnVitPPxH9J9xb87/lw694a9k
         ajZJB4AymDtJifSot2q5J+GqEf8L7jNcZBDEZYU3wRhQL3d9KSTVTVYmHp/f5TeuxLz5
         Lk83pA1lFhWcHPcR1M+3qAKBlSdjs8/pSYxsO+WaYnAvMm+uCSCC9ZWjXt0uF3w6RBHS
         aFnZ4mdKY7TqM8RbNMcdqIyw7uG+uFBAqYWrzCL6Cm+Dhbx/VRTeI4WpRzd29uXjG3eU
         Qqy16mltghzmDXoG1hgFpyBAdQNRNiOpmHXv1O8ihkFPzc4aEOvx0I5JXX5a0rKVvHr1
         Poag==
X-Gm-Message-State: APuU4Z+jDG+lwU7T01H/xwpQQuZGOGjGTHnB/emD4CUIWw0QPPC9Uvvg
	8iSolQCkpceJC6PeT0rVSfRrKYLob3DJNNVn6s+GysX5J0291SPBXWrRsFN6WQ==
X-Gm-Gg: AYBFou090RGURpNfwKS2YD2zgco2BqNCBTq4zFBVZBtcAKF4fJjKZ4xqZFSjfBQ643s
	G86u0YRB2oZJzLvmWEMiDlY3pyHoRwTUOXlSeVRabrn1kz+P5Vw4HST88ZsRDzVxD96nva9vLK2
	Ikz32dxjze/pGYhTR5TE5BA/2aA1Fy8hhy+rCltNFTuApZVri4AExMKHepe+2R7hEGhwRuY2YZ7
	ag8SBGf3PYfrVlnZsUGBMe6ZJruCZroJICJ6PaxshNXkB0iZwJKaKWBu2gql8raDwNa8Oo/FwJL
	irfS+Egm8V4KlD6Im6EHwyydFbLG7X2zrCnoBaKuS5Og1p3LVpdyWsGkck4IwAP/tNYYxblfF4i
	FU/5DF/6FpAm47c+ejpl16Ne3tZ3uRIblWHc24pTXkaFKZL0EQKQujcgZWIT/orD1w0+mD/PGLg
	z9xJvhm1k0VNujpb5HgDW45EbxWqGP7DuFiEJT1BsPFkUYX3/J+Je7P4dN6m42TdL+7J92Ypxq5
	ewCBmtiGBhZrurA9XzCSfREQIfHb4kZVesYhGdsqMgmW/8A1P2PFBR619/A5GaDv+PZHm9PHLqh
	ZROLFP380M446+l4wD6u8p+lVY9pd+PATn96oU82h1Hcpwt9X3Toed8o8rrOrwgHwPIp9AA7MMl
	6csaxrHBXGv/IcCMzAAtkVCIOnD3VlrOjEU17Sp4PG1PUcaKsFWMAxrWNzqqYiAcbiCxNRpiLSg
	PyvH0=
X-Received: by 2002:a05:6102:3ec7:b0:7a1:f980:e934 with SMTP id ada2fe7eead31-7d072620efdmr5369670137.16.1793737817155;
        Tue, 03 Nov 2026 12:30:17 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm139916241.8.2026.11.03.12.30.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/7] unit/test-bap: Add tests for cancelling grouped Enable
Date: Tue,  3 Nov 2026 15:30:05 -0500
Message-ID: <20261103203011.3904290-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203011.3904290-1-luiz.dentz@gmail.com>
References: <20261103203011.3904290-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tests that cancel the leader or a member of a grouped Enable
request, either while it is still queued or while it is waiting for the
ASE state, and check that only the remaining requests are completed.
---
 unit/test-bap.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 161 insertions(+), 4 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index d16fbd96c555..8f081d92b936 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -45,6 +45,17 @@
 	do { tester_warn("%s:%d: failed in %s", __FILE__, __LINE__, __func__); \
 		tester_test_failed(); } while (0)
 
+/* Cancel one of the grouped Enable requests, either while it is queued or
+ * while the request is waiting for the ASE state.
+ */
+enum {
+	CANCEL_NONE,
+	CANCEL_LEADER,
+	CANCEL_MEMBER,
+	CANCEL_WAIT_LEADER,
+	CANCEL_WAIT_MEMBER,
+};
+
 struct test_config {
 	struct iovec cc;
 	struct iovec base;
@@ -61,6 +72,7 @@ struct test_config {
 	struct iovec *pac_caps;
 	const struct iovec *setup_data;
 	size_t setup_data_len;
+	uint8_t cancel;
 };
 
 struct test_data {
@@ -82,6 +94,9 @@ struct test_data {
 	size_t iovcnt;
 	struct iovec *iov;
 	int fds[8][2];
+	unsigned int enable_ids[2];
+	struct bt_bap_stream *cancelled;
+	unsigned int enabled;
 };
 
 struct notify {
@@ -9461,6 +9476,31 @@ static void test_bsrc_str(void)
 							LC3_PAC_CAPS(0x01))
 
 #define STR_AC3		DISC_AC3, STR_SNK_SRC_STREAMING_LC3(0, 0, 0x1, 0x1)
+
+#define STR_SNK_SRC_QOS(cis1, cis2, challoc1, challoc2, codec_id...) \
+	SCC_ASE2(SNK_ID(0), SRC_ID(0), challoc1, challoc2, codec_id), \
+	SCC_SNK_NOTIFY(0, STR_SCC_DATA(challoc1, codec_id)), \
+	SCC_SRC_NOTIFY(0, STR_SCC_DATA(challoc2, codec_id)), \
+	QOS_ASE2(SNK_ID(0), SRC_ID(0), cis1, cis2, QOS_SRC_8_1_1_DATA), \
+	QOS_SNK_NOTIFY(0, cis1, QOS_SRC_8_1_1_DATA), \
+	QOS_SRC_NOTIFY(0, cis2, QOS_SRC_8_1_1_DATA)
+
+/* Enable of the Sink ASE cancelled, only the Source ASE is enabled */
+#define STR_AC3_CANCEL_LEADER \
+	DISC_AC3, \
+	STR_SNK_SRC_QOS(0, 0, 0x1, 0x1, LC3_CODEC_ID_DATA), \
+	ENABLE_ASE(SRC_ID(0)), \
+	SRC_ENABLE_NOTIFY(0, 0), \
+	START_ASE(SRC_ID(0)), \
+	SRC_START_NOTIFY(0, 0)
+
+/* Enable of the Source ASE cancelled, only the Sink ASE is enabled */
+#define STR_AC3_CANCEL_MEMBER \
+	DISC_AC3, \
+	STR_SNK_SRC_QOS(0, 0, 0x1, 0x1, LC3_CODEC_ID_DATA), \
+	ENABLE_ASE(SNK_ID(0)), \
+	SNK_ENABLE_NOTIFY(0, 0), \
+	SNK_START_NOTIFY(0, 0)
 #define STR_AC5		DISC_AC5, STR_SNK_SRC_STREAMING_LC3(0, 0, 0x22, 0x2)
 #define STR_AC7i	DISC_AC7i, STR_SNK_SRC_STREAMING_LC3(0, 1, 0x4, 0x4)
 
@@ -9649,6 +9689,42 @@ static struct test_config cfg_str_ac3 = {
 	.qos = LC3_QOS_8_1_1,
 };
 
+static struct test_config cfg_str_ac3_cancel_leader = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { 0x1, -1 },
+	.qos = LC3_QOS_8_1_1,
+	.cancel = CANCEL_LEADER,
+};
+
+static struct test_config cfg_str_ac3_cancel_member = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { 0x1, -1 },
+	.qos = LC3_QOS_8_1_1,
+	.cancel = CANCEL_MEMBER,
+};
+
+static struct test_config cfg_str_ac3_cancel_wait_leader = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { 0x1, -1 },
+	.qos = LC3_QOS_8_1_1,
+	.cancel = CANCEL_WAIT_LEADER,
+};
+
+static struct test_config cfg_str_ac3_cancel_wait_member = {
+	.snk = true,
+	.src = true,
+	.snk_locations = { 0x1, -1 },
+	.src_locations = { 0x1, -1 },
+	.qos = LC3_QOS_8_1_1,
+	.cancel = CANCEL_WAIT_MEMBER,
+};
+
 static struct test_config cfg_str_ac5 = {
 	.snk = true,
 	.src = true,
@@ -9931,8 +10007,17 @@ static void streaming_ucl_do_stream(struct bt_bap_stream *stream,
 	}
 
 	/* All streams handled */
-	if (data->id == 0)
-		tester_test_passed();
+	if (data->id)
+		return;
+
+	/* Check the requests not cancelled have been completed */
+	if (data->cfg->cancel && data->enabled + !!data->cancelled !=
+					queue_length(data->streams)) {
+		FAIL_TEST();
+		return;
+	}
+
+	tester_test_passed();
 }
 
 static void streaming_ucl_connect(struct bt_bap_stream *stream)
@@ -10005,6 +10090,37 @@ static int streaming_ucl_create_io(struct bt_bap_stream *stream,
 	return i;
 }
 
+static void streaming_ucl_enable(struct bt_bap_stream *stream, uint8_t code,
+					uint8_t reason, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	tester_debug("stream %p enable code 0x%02x", stream, code);
+
+	/* Cancelled requests shall not be completed */
+	if (code || stream == data->cancelled) {
+		FAIL_TEST();
+		return;
+	}
+
+	data->enabled++;
+}
+
+static void streaming_ucl_cancel(struct test_data *data, unsigned int idx)
+{
+	const struct queue_entry *entry = queue_get_entries(data->streams);
+
+	if (idx)
+		entry = entry->next;
+
+	data->cancelled = entry->data;
+
+	tester_debug("cancel stream %p enable", data->cancelled);
+
+	g_assert(!bt_bap_stream_cancel(data->cancelled,
+						data->enable_ids[idx]));
+}
+
 static void streaming_ucl_state(struct bt_bap_stream *stream,
 					uint8_t old_state, uint8_t new_state,
 					void *user_data)
@@ -10033,18 +10149,47 @@ static void streaming_ucl_state(struct bt_bap_stream *stream,
 		for (entry = queue_get_entries(data->streams);
 					entry; entry = entry->next) {
 			struct bt_bap_stream *s = entry->data;
+			unsigned int idx = data->id;
 
-			if (data->cfg->state != BT_BAP_STREAM_STATE_ENABLING)
+			/* Don't connect the stream to be cancelled */
+			if (data->cfg->state != BT_BAP_STREAM_STATE_ENABLING &&
+				!(data->cfg->cancel == CANCEL_LEADER && !idx) &&
+				!(data->cfg->cancel == CANCEL_MEMBER && idx))
 				streaming_ucl_connect(s);
 
 			id = bt_bap_stream_enable(s, false, NULL,
-							NULL, NULL);
+						data->cfg->cancel ?
+						streaming_ucl_enable : NULL,
+						data);
 			g_assert(id);
 
+			if (idx < ARRAY_SIZE(data->enable_ids))
+				data->enable_ids[idx] = id;
+
 			data->id++;
 		}
+
+		switch (data->cfg->cancel) {
+		case CANCEL_LEADER:
+			streaming_ucl_cancel(data, 0);
+			data->id--;
+			break;
+		case CANCEL_MEMBER:
+			streaming_ucl_cancel(data, 1);
+			data->id--;
+			break;
+		}
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
+		/* Cancel once the first ASE is enabling, the request is then
+		 * waiting for the other one.
+		 */
+		if (!data->cancelled && data->cfg->cancel == CANCEL_WAIT_LEADER)
+			streaming_ucl_cancel(data, 0);
+		else if (!data->cancelled &&
+				data->cfg->cancel == CANCEL_WAIT_MEMBER)
+			streaming_ucl_cancel(data, 1);
+
 		/* TODO: not correct to call bt_bap_stream_set_io() from this
 		 * callback
 		 */
@@ -10324,6 +10469,18 @@ static void test_ucl_str(void)
 
 	define_test("BAP/UCL/STR/BV-549-C [UCL, AC 3, Generic, QoS, QoS]",
 		test_setup, test_select, &cfg_str_ac3, STR_AC3);
+	define_test("BAP/UCL/STR/BLUEZ-3 [UCL, AC 3, Cancel Enable leader]",
+		test_setup, test_select, &cfg_str_ac3_cancel_leader,
+		STR_AC3_CANCEL_LEADER);
+	define_test("BAP/UCL/STR/BLUEZ-4 [UCL, AC 3, Cancel Enable member]",
+		test_setup, test_select, &cfg_str_ac3_cancel_member,
+		STR_AC3_CANCEL_MEMBER);
+	define_test("BAP/UCL/STR/BLUEZ-5 [UCL, AC 3, Cancel Enable leader "
+		"waiting]", test_setup, test_select,
+		&cfg_str_ac3_cancel_wait_leader, STR_AC3);
+	define_test("BAP/UCL/STR/BLUEZ-6 [UCL, AC 3, Cancel Enable member "
+		"waiting]", test_setup, test_select,
+		&cfg_str_ac3_cancel_wait_member, STR_AC3);
 	define_test("BAP/UCL/STR/BV-550-C [UCL, AC 5, Generic, QoS, QoS]",
 		test_setup, test_select, &cfg_str_ac5, STR_AC5);
 	define_test("BAP/UCL/STR/BV-551-C [UCL, AC 7(i), Generic, QoS, QoS]",
-- 
2.56.0

