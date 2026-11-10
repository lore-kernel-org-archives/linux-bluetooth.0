Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349163;
	b=TYicgq45BGLtkW+BtlraJH1sTXxJPe/KlsiKTHIWVAFEc955IlLIbnh8FU5Or+io/OMu
	 2TuqwOsdO2cZHyZdGWCDHiceeYqutK7aM01EAfdYWs8lP5PMmBxBpWbN5Z9Gx+cm/9oXQ
	 WgOBZwrGZGf//8keydLLn8gLzcVTomxMOAZqKjbWnPAegXnBqWeIelkVuoJ/oEd5M0nIz
	 Bg8IZlJGdSLFiNxU/REFnswF+KMt8SCz/fy6IVOgFsz9SKoDD/0gfFR+MJ+CDGkGdtqFW
	 ev7nFn/MCXJUXEXtuUuaUFiaFYhEfKAwdRlNSx7kRunEj9woZOGLg6nKB3U6/PYYVNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NbtHOfkqIYaP5WAEb5hjhmOTknWfNiw0fYny/Jhelec=;
	b=zvjAhAARW5eZLkYuuQ28r0HgGDDP2XKOLYTVsJ2lQqOrOh/d5mDa28AHLgeUjXFsXFLk
	 SgKGQuJhdshLkaRUll3mZZKWE0otQpdGpIGhU/u5lJGvt4FJE2r2np1fhb+jE/fmsjj+2
	 Ukpo5ybkbSf7XO1IB8q8/6n1ivcJ/Gj4nJDyNUkrul2FG1fFvyX0Y/w1THeweGKC2co9u
	 Hh6GNqzwCosC3PtIdt3r6/EQRO293Kg2gti4ox3qwgL8eZn7n5v0jSu96zIBRT2+Of/Za
	 DwaM9O3jpa68GnOyuScilAZcS+igaJM0K7bfFd2wLsRleae1PvZrh8q7fylExLbozYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GpxQZmcL;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12484606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12484606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GpxQZmcL
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ee029fd76aso923077e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349162; x=1794953962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NbtHOfkqIYaP5WAEb5hjhmOTknWfNiw0fYny/Jhelec=;
        b=GpxQZmcLfzR46FhG4fWAefStT+mn3YMx57P8pXPAsMNeox6umHVytcjFSBb8rYFh/V
         xeoA/k3Y65OfoTxNd/uY5Jwvjtkb5B5HTRWtpFFpGnyNTOoHHk2lO+gT/zUJPmLrv8O/
         Q4XW2l3I+0MLXMEMFxCAjut52+88T0boru6gz8eS6HCFv0+VKS6VZ9OMN9aFovFEXQm/
         x0RyaUUB8eo1Fyopf34dT06zE4y6rcHjAsHckYW8zJYx2qpWp24gxGIdEjc1Hm2GvKvH
         ci427u8ta9nwJJHZ4gfCMg5tE5RLd3qLYA5vszovXYzWv6d0Keh2yK5LodwEnlrKw2rN
         AiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349162; x=1794953962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NbtHOfkqIYaP5WAEb5hjhmOTknWfNiw0fYny/Jhelec=;
        b=guOuvkzIjDFKdavDkIjM6UeoM6IH6VVcVoW6Xikuw3cbKH6u/377XTWtxOF5BjxkHR
         lLSBg/YNb4A+tenp/H1iBhsz7i/2tW98avtquf26IbEuhRFodzYZac4am1y4QaulWkSb
         2oEem3rQAaSHDUhjy0kTcWmK5gUxSgWemj5cW0xXxBBV2TiBRatlGj5EzfoHu/PLbUzr
         ZxHLGcKDjpppCrH/GCTyhDk6UI1/CFPult7k76YNkzWSFzDuxPVzKt/tGGaZdon2UYe6
         UGUvP2r1x2vvcjNOFITQkgbUBYNyuPjwy8MI2WoT5AFq4Iv1gmQr71OcvQFoiwQNbLPN
         ncLg==
X-Gm-Message-State: APuU4Z9pBW9aN2ihf5J5u/lfLMU394hX1ZCj+0B/qjdCGw31MkM5o0rl
	Cnc+8QOH7a0ZgtpWAXv+pgqV6ole/DDXifCzXkd/lGX9EuNgvYVTPRtd5lnpbQ==
X-Gm-Gg: AYBFou2loMkiRkkqyq6Y56RpbtSqK24f61arYQ10Ouit48+EYULbXhCKzxbbM8GHRcf
	7Fw0ZyHw8vfsjYsQgO18nN4ZiY366ECX43INvZbZKgi9K58IQKSSmsdjX5vpJE8MIjwq9F36O+R
	c+qIy6yRbS/NOYQbVNXxEEi7sMRvM1cYS/wFRg4QR7inB5BdinN26ey1CKxxfHxz1paKbqaP9HM
	ddzDq7J0aeiE6b2bsEMUnL1Cyyx0j/N7kEzx0FTXY+r4sHZYjlIDxbaviZH/DC8OqPEKw7Ffgct
	y2F0u6SZFANQzzJ4we9rdVe5jEv4S43oU/dT/ibumIpSKBWoNFOqiYryVxoaj2nUA8uVHh2a1eP
	o4lzKaMleE4JK6TG6wNwDO82ai2GaiXcBYbKq99/sqYsnLd3ZYlW/j7fPll2qTY7tQaGeOcOAxg
	VN4wThP8Mf1PFy9y1rnOPy5lxkF+4o7u74Y4EFP8OZffAXTSfppWXY5u+8f+oHRhXAPexheTx+R
	yIgH5AHzI3ASYXj1ZaRzkTDX6MeFAXfnglVgeqzVBDkoXiJcTdNXUtSEmWPXE+6Nokw512GX1jJ
	uf/zC3pM9lDz+nS7JL9i0XJvEkbtFPLBm8MAev6JaNGdHXFc4Yk3NTcGHepz7zwqchH6JsVODeZ
	p6NTPvzBRwISB2RUhvHuhr+sYeTdHTAtGtFjqcuw0Nnu2tKq/hZA1jN+KSv6xlkrHofAHVIy8xP
	Lo6dBt
X-Received: by 2002:a05:6122:3287:b0:5ea:9a2c:27a8 with SMTP id 71dfb90a1353d-5ee1c43413fmr130254e0c.14.1794349161804;
        Tue, 10 Nov 2026 14:19:21 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] unit/test-bap: Add tests for a CIS shared by two ASEs
Date: Tue, 10 Nov 2026 17:19:00 -0500
Message-ID: <7bb461aa653d117915b16dd4092ed17c3d06615c.1794349049.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794349049.git.luiz.von.dentz@intel.com>
References: <cover.1794349049.git.luiz.von.dentz@intel.com>
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

Configure a Sink and a Source ASE for the same CIS and enable the Source
ASE so the CIS is established, then cover:

- Releasing the Source ASE until its stream is freed while the Sink ASE
  keeps the CIS: once the CIS is disconnected, enabling the Sink ASE
  must not start streaming over it.
- Releasing the Source ASE, which has to be released once the CIS is
  disconnected, caching its codec configuration, although the Sink ASE
  configured first uses the CIS as well.
- Disabling the Source ASE and enabling the Sink ASE right after, as a
  phone does when switching a headset from its microphone to its
  speaker: the Sink ASE has to start streaming over the same CIS, which
  has to stay connected, as the client does not establish it again.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-bap.c | 227 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 99c5ae92e447..3713ad56c072 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -4728,6 +4728,230 @@ static void test_usr_scc_cis_loss(void)
 			SCC_SRC_ENABLING_CIS_LOSS);
 }
 
+static void state_release_link(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	int fds[2];
+	int err;
+
+	if (bt_bap_stream_get_dir(stream) != BT_BAP_SOURCE)
+		return;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		/* Establish the CIS for the Source ASE, which its linked Sink
+		 * ASE shares.
+		 */
+		err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0,
+									fds);
+		g_assert(err == 0);
+		g_assert(bt_bap_stream_io_connecting(stream, fds[0]) == 0);
+		data->fds[0][0] = fds[0];
+		data->fds[0][1] = fds[1];
+		break;
+	case BT_BAP_STREAM_STATE_IDLE:
+		/* Once the Source ASE is released and its stream freed,
+		 * disconnect the CIS the Sink ASE kept.
+		 */
+		if (data->fds[0][1] > 0) {
+			close(data->fds[0][1]);
+			data->fds[0][1] = -1;
+		}
+		break;
+	}
+}
+
+static struct test_config cfg_release_link = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.snk = true,
+	.src = true,
+	.state_func = state_release_link,
+};
+
+#define QOS_16_2_1_DATA \
+	0x10, 0x27, 0x00, 0x00, 0x02, 0x28, 0x00, 0x02, 0x0a, 0x00, 0x40, \
+	0x9c, 0x00
+
+/* Sink and Source ASE configured for the same CIS: the Source ASE is
+ * enabled, disabled and released until its stream is freed, while the Sink
+ * ASE keeps the CIS, which is then disconnected. The Sink ASE is then
+ * enabled, without a CIS.
+ */
+#define SCC_RELEASE_LINK \
+	DISC_SRC_ASE_LC3, \
+	SCC_SNK(LC3_CONFIG_16_2_DATA), \
+	SCC_SRC(LC3_CONFIG_16_2_DATA), \
+	QOS_SNK(QOS_16_2_1_DATA), \
+	QOS_SRC(QOS_16_2_1_DATA), \
+	SRC_ENABLE, \
+	SRC_DISABLE, \
+	ASE_SRC_RELEASE_CC, \
+	ASE_SRC_RELEASE_IDLE, \
+	ENABLE_ASE(SNK_ID(0)), \
+	SNK_ENABLE_NOTIFY(0, 0)
+
+static void test_usr_scc_release_link(void)
+{
+	define_test("BAP/USR/SCC/BLUEZ-2 [USR Release ASE of a CIS kept by its "
+			"link]",
+			test_setup_server, test_server_state,
+			&cfg_release_link, SCC_RELEASE_LINK);
+}
+
+static gboolean disconnect_cis(gpointer user_data)
+{
+	struct test_data *data = user_data;
+
+	if (data->fds[0][1] > 0) {
+		close(data->fds[0][1]);
+		data->fds[0][1] = -1;
+	}
+
+	return FALSE;
+}
+
+static void state_release_cis(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	int fds[2];
+	int err;
+
+	if (bt_bap_stream_get_dir(stream) != BT_BAP_SOURCE)
+		return;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0,
+									fds);
+		g_assert(err == 0);
+		g_assert(bt_bap_stream_io_connecting(stream, fds[0]) == 0);
+		data->fds[0][0] = fds[0];
+		data->fds[0][1] = fds[1];
+		break;
+	case BT_BAP_STREAM_STATE_RELEASING:
+		/* The client disconnects the CIS once notified that the
+		 * Source ASE is releasing, while the Sink ASE is still
+		 * configured for it.
+		 */
+		g_timeout_add(50, disconnect_cis, data);
+		break;
+	}
+}
+
+static struct test_config cfg_release_cis = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.snk = true,
+	.src = true,
+	.state_func = state_release_cis,
+};
+
+/* Sink and Source ASE configured for the same CIS: the Source ASE is
+ * enabled and released, and remains releasing until the CIS is
+ * disconnected, then it is released caching its codec configuration,
+ * although the Sink ASE, configured first, was using the CIS as well.
+ */
+#define SCC_RELEASE_CIS \
+	DISC_SRC_ASE_LC3, \
+	SCC_SNK(LC3_CONFIG_16_2_DATA), \
+	SCC_SRC(LC3_CONFIG_16_2_DATA), \
+	QOS_SNK(QOS_16_2_1_DATA), \
+	QOS_SRC(QOS_16_2_1_DATA), \
+	SRC_ENABLE, \
+	ASE_SRC_RELEASE, \
+	IOV_DATA(0x0a, SRC_HND(0)), \
+	IOV_DATA(0x0b, SRC_ID(0), 0x06), \
+	SCC_SRC_NOTIFY(0, LC3_CONFIG_16_2_DATA)
+
+static void test_usr_scc_release_cis(void)
+{
+	define_test("BAP/USR/SCC/BLUEZ-3 [USR Release ASE of a shared CIS]",
+			test_setup_server, test_server_state,
+			&cfg_release_cis, SCC_RELEASE_CIS);
+}
+
+static int switch_cis_fd = -1;
+
+static void state_switch_cis(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	char buf;
+	int fds[2];
+	int err;
+	int fd;
+
+	switch (bt_bap_stream_get_dir(stream)) {
+	case BT_BAP_SOURCE:
+		if (new_state != BT_BAP_STREAM_STATE_ENABLING)
+			return;
+
+		/* Establish the CIS for the Source ASE, which its linked
+		 * Sink ASE shares.
+		 */
+		err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0,
+									fds);
+		g_assert(err == 0);
+		g_assert(bt_bap_stream_io_connecting(stream, fds[0]) == 0);
+		switch_cis_fd = fds[0];
+		data->fds[0][0] = fds[0];
+		data->fds[0][1] = fds[1];
+		break;
+	case BT_BAP_SINK:
+		if (new_state != BT_BAP_STREAM_STATE_STREAMING)
+			return;
+
+		/* The Sink ASE streams over the CIS established for the
+		 * Source ASE, which is still connected.
+		 */
+		fd = -1;
+		bt_bap_stream_io_is_connecting(stream, &fd);
+		g_assert(fd == switch_cis_fd);
+		err = recv(data->fds[0][1], &buf, 1, MSG_DONTWAIT | MSG_PEEK);
+		g_assert(err < 0 && errno == EAGAIN);
+		break;
+	}
+}
+
+static struct test_config cfg_switch_cis = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.snk = true,
+	.src = true,
+	.state_func = state_switch_cis,
+};
+
+/* Sink and Source ASE configured for the same CIS: the Source ASE is
+ * enabled, establishing the CIS, then disabled, and the Sink ASE is
+ * enabled right after, as when switching a headset from its microphone to
+ * its speaker. The Sink ASE has to start streaming over the same CIS, as
+ * the client does not establish it again.
+ */
+#define SCC_SWITCH_CIS \
+	DISC_SRC_ASE_LC3, \
+	SCC_SNK(LC3_CONFIG_16_2_DATA), \
+	SCC_SRC(LC3_CONFIG_16_2_DATA), \
+	QOS_SNK(QOS_16_2_1_DATA), \
+	QOS_SRC(QOS_16_2_1_DATA), \
+	SRC_ENABLE, \
+	SRC_DISABLE, \
+	ENABLE_ASE(SNK_ID(0)), \
+	SNK_ENABLE_NOTIFY(0, 0), \
+	SNK_START_NOTIFY(0, 0)
+
+static void test_usr_scc_switch_cis(void)
+{
+	define_test("BAP/USR/SCC/BLUEZ-4 [USR Switch direction of a CIS]",
+			test_setup_server, test_server_state,
+			&cfg_switch_cis, SCC_SWITCH_CIS);
+}
+
 static struct test_config str_snk_ac2_8_1_1 = {
 	.cc = LC3_CONFIG_8_1_AC(1),
 	.qos = LC3_QOS_8_1_1_AC(1),
@@ -7589,6 +7813,9 @@ static void test_scc(void)
 	test_scc_disable();
 	test_scc_release();
 	test_usr_scc_cis_loss();
+	test_usr_scc_release_link();
+	test_usr_scc_release_cis();
+	test_usr_scc_switch_cis();
 	test_scc_metadata();
 	test_str_1_1_1_lc3();
 }
-- 
2.56.0

