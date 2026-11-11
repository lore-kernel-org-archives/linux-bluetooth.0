Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429469;
	b=L9ANQxQwU1PSNvH0JMIjDoQPUQR0HJAk2sD8e8b4l3vJ8N5pf5+ICqjLUQn8dKbjOCdo
	 mYC71u/ql67jKanL9zAf2fUPE/c6LgAn1KJL9h5QnTKyGY7ZxLJFJZwTcGw18SsGxP0bp
	 UeDjKxbp3ZJecKmp/5UGnDMGfO/zWmU/JeN/q6p3+5LXwOjvKfF6JZJdvvhaWZS4z5psC
	 bodXvTha6sDCLz4erTABZInGlIHqcGnCINca+Uyw3IA5OJn4Y/upn1iA3nzEvl2m4UTwx
	 3e8a7hwbwofhPRmMX6z6cfwU03x4Ts8kvpnraXuJKsG7llettMu7lnSxkiSpcUaEosQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NbtHOfkqIYaP5WAEb5hjhmOTknWfNiw0fYny/Jhelec=;
	b=Y/IrYJXoCky8U7TNf3zo86yKee0SXjLfpZ2Rxg4HuHIy5ARIDD8kus4BRcgDLrefpSv2
	 YOXtTkKf+NAPV8ELip3AP7OPmP5Dw7QVdS9DM+F/HPAiZfSSvYdg43A2egVkUsl2t6ftG
	 GuEj319QHZuePkHzG9lxCd3yvf6q7TTf4+dgW09ScsM0eC1eyVJ8q/Rcv9E7W0gdKGmKQ
	 hiVliMCXztApGBap3lKoka7YgOiub9bfp29dGAyMkf27MOJPZCgtk0d4gMso8eoIxge9N
	 KF9avPA5PD0ze4zJUfTPJaLd04cSWGc6tWFGFXQROkccZtqT7OKGYwzXGARQBaWf6jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lagi3epU;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF8606C1F9
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5CF8606C1F9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lagi3epU
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-998d151f441so958566241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429468; x=1795034268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NbtHOfkqIYaP5WAEb5hjhmOTknWfNiw0fYny/Jhelec=;
        b=lagi3epU9AOMFH6Onp95GwDvoe+07czzESdGdcvfuuwXSgApKeEXEu2d2IMjrtiFhq
         OUnkj9KJUmpnNsGtw2VW989SIRt+bq2MXHyA5heMFcfMYiF/rw53r9UEnDlbkxDf+Tz4
         ZB1GxcCMYT97iWeHgafkWHW4pWsv+nyFNJpj0HV2+yk/QcIKpLCt2KZ9a3x0BC0RRpFd
         HdKswNO0wk+XZaC8w91StWFIXZtqpBKPre0mNPdIVlzVN1znhlbI54T6U7SDAoYTSgkE
         K4JXIL4eFKfLg7jb1hHSJhX484iSR61gdGlhQTRPuj8VBFOYDHayiD2s4mD90Gk3RYUP
         3G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429468; x=1795034268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NbtHOfkqIYaP5WAEb5hjhmOTknWfNiw0fYny/Jhelec=;
        b=Z1CX4GKQ4cMM3vAQy21L3qA9MidQcmw5/sKRO2KvIUS0nuhHfYFQlzRVA05hp8IHjy
         xZzuIb7OMCFedW0i+48JvodWvNJD4IPn5PJafkzcI45b1hSuKbqbMh050Vb53ZSLrbi6
         4v+xyYuKk82+e+cwxb1KdNkBUxrXLsEOAkQX+m8OyWHkGsyp18ZAJblCVnLBoTXXiW9J
         QiVcq6+zrpPp4HX3YyBdRwnFQhZn+yfElh+0xgq18pmY+4EZHtB70SFFGE1VG7zEmZOW
         sGdYiKFokMylrmk3Z8x6N1QZcdZew4AWbNwGgK3AwVRYNx/Pmtzb7VHr5CW/NIL++44d
         Ggyw==
X-Gm-Message-State: APuU4Z9mTpvMivub2NrAN1eFoiVbdX0bo0YJRz/TEoUPHgkXMmq7XPB2
	3nB4uk7QAqpOkPBN/IPzUvmpKG/+LFUaFSdB9jgUV/WjjIGIRkhhrmQMMrjJOQ==
X-Gm-Gg: AYBFou0wBGmDg2PEK7e/5eaGgSJqzOUeTctRjmbS6CMjyKsVRSsdNsoZAGUMEXVTn3d
	ZlaTWbxIP+fLw8L2I86yl/F+TslHYVMNVfLFpMCnd5uQXIu21gT9/GH9xcUiZiIT3/uaYpRc0hr
	Pd+gZZLj+GN8gRiFLrJliCAdQi6vjSO5CrKPMB6LeN5EGEClZrYXDjEUJsZGyVKgn8/FYGDHRVM
	ifeeXvsRJPLLmLbKVVSYZg13WM8jjKdpMVFV5c0fGGzT8ue7cXSyaGqMj1rVvI6AV4L/Rq2MY51
	WdnWeAEz/YZ7yfiWfSPlJk/ralnbrIJJ35KmiqjhCVL3YL248lM4+8CTYo/JDAcpt789mdNBquU
	GpICi6xGB6kVXI/BwsCHsTZJJ9ITd1ouYDbeLvlV8yhdv1kR1ewQyOlOTKyA1UqM79Y0Sv4SLjF
	JCwJIMgRnSSXneKQw2R+M/tqQ7bR4Wjqjwz99buib+9TxettnQUyybw7Z+gi4qo+YNX9emuxg43
	Dwv3tlQ1mq582afZ3tNhxFjqvOyh2miw/2YPmfuMdZC9xBXnl0Ilnk2bcHokkeF+oszVvhIE0/U
	LT8fPo0RPIJ1p8bqGhPRfM+xqouVsUMySkhVV0YG8WVfuAdSyU6vVBpVdSmpD2X/sDUp68ZUIkG
	ex0/IhXKvMorhAKd9LgW0bUpJ9n6Jal/OZaciuK4q9TxnNZKcj3Rwi4Nwbx5an3k0lxiqFbcj6z
	7IWmU=
X-Received: by 2002:a05:6102:f88:b0:7cc:2712:cafb with SMTP id ada2fe7eead31-7d4fb294ca9mr1384041137.15.1794429467513;
        Wed, 11 Nov 2026 12:37:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/5] unit/test-bap: Add tests for a CIS shared by two ASEs
Date: Wed, 11 Nov 2026 15:37:24 -0500
Message-ID: <5c0fd2dfb47ca525bc900f09b34efabe99a3acd4.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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

