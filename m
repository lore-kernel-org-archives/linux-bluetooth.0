Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414338;
	b=qDIHspSUtH4CcYe7dbjTys7apYn5HTuQWp7/wATDoBMkHu+2i4SQTGdBghdTBdgPPVH8
	 ZcCcFqdZ73NT/Gbq5QNgg+bhh49mn0K1Qjqnp28DoaMbqJrhSr+o055vsHZBcXNduArnI
	 bdcO5qCraGuG2fxLPt+Qq8CNHHkPZqK4UEseu7WiIQRLViWlS5bL8bx0IEfvNoSqqas2A
	 tg86VdNyyUHm9tJ3EzhnbBSjnpLUE5hrIyGCxK47k1sZGPC51IqWjpDEl4Kk9oXuOxAIR
	 vYRA4ZPdTNrcK172jcbgTjH4K5RCjiqJK0w/AodikSGcjJ90FU0khCvln6im+zqTndQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NbtHOfkqIYaP5WAEb5hjhmOTknWfNiw0fYny/Jhelec=;
	b=L9q2NlYHrYJcRNhBAkd7sSCZsgTKyoeaEOMWEb/V1iUSiVSbWfQt5wOjHkFtuqgvxvPR
	 t+cDlj7tddgMWrtD6r0FXNS6mOaqSx5y5naLXbdC9v+xkRcnTaVgfbDhbJTEgC7ejo3YV
	 uYb0lYouAQz+z5bRQ4SX/tE1NagZL3wqnNY3ghm2I12aMO6efXXkl0TIYVNGu94nhsDLb
	 PySVGLOt8Z6Qxkceo/IsnBEW1jEjH5KoUodC7xxA++Q5Q/AI5+KrjI2ocsRl8pEK2BJ8f
	 X0jmdZpuHbgxwSjQV5QpDp37TUqca5kyYD1iefyOD3xsgEoGwzrsTCBFpDgIAoWBGAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wx7zGBnd;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DC606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wx7zGBnd
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2bf046d7fso1866999137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414337; x=1795019137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NbtHOfkqIYaP5WAEb5hjhmOTknWfNiw0fYny/Jhelec=;
        b=wx7zGBnd7GOOsBOt83nWGoa8BN7Q4xrPmpKAXnsq2VQukRRS2iSN0oQfKQiZk8SJYq
         eYpIPBmrH3bCnzUnVv/xxSZtBAY0YPUM13h2Gz+iT/CnS1bMdEFlBqA3zoFyK9LyV33i
         +J8vRyaeKY8hqfWl3kev2Ab9jIeJaH4qzB41XYGMaSQNpwtgh1kUFhLMR8FlH2+BsIfG
         w/vlSVmLOkQeVLzNimDryjfxpsonb2iwf9NbPtNuXXpImUfyzSSZFk5cGr4jlmFEj9lV
         1ZOUiu7qxkJH+NAwE7YI8zj9+R7yz7cv5ieAbaxJZ9KOms0j3tf0KovMaxtkSo91CpJF
         Vzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414337; x=1795019137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NbtHOfkqIYaP5WAEb5hjhmOTknWfNiw0fYny/Jhelec=;
        b=bR0+NNZiLKUylpkf+h1bSo95iiW4noSm+LH9BNQIPcCjUqHxwIyYCrc2ORXux9YXbj
         4cQhZRAx4U4lKLOxG+SrwfBHwAL4Ll6lt/Kze0ZQkyc6saElOfhkOEKS7tcJC784MzWT
         JlxY01V91A3jJ8JgmeMrXeer0KEtlOos6fPD6I+CZWqi0CEbOumO6FBun6tkUxHtVSzL
         YIuHz9McH0GP5+8HnKR6EnQhMaEU/azrChkWC33ewE9RB52oyLEvz3FCUGTqn3DFZFNk
         qGs/ULm3VY1J+yy3dK6ojOsT25k36+7h0W+oNDdsZMrEn4sJA7M9XPdRFvAnOALI0Sko
         IpOg==
X-Gm-Message-State: APuU4Z8THiEpBuHWFFMM+oRJahMJHFyAUYZT8mkxkx/dojgZPwv9yc7N
	lS7lD9LL1DC4tOsT0d6KTzXxwPzf+BKY5rAAYlY45qdLl94jEbzFU7r8hGqfTg==
X-Gm-Gg: AYBFou1B/KU9H6A3B5/C9lVsC3JZXq3Jbl3VqVUG/+LL7yhW4lgdDd8oMmVwojT4N7I
	aZ2y9F3EFwjTbKEgo0K0WyeMny1cVaXqcN8L2cQjjcn7MRo5nG8ysEwdkd9pnMRuOpfAswnhDh8
	zTpQ/KmiWMpOEZCiuYEES+zOBoIQ2m1YdyHkOjA9EkvhRkwo4cJ02YIp5F6FqT/zRnXLMje/X7R
	FUxu87IfH9pHQkHqGdYGvcb7nVJV8NdKp3a2Wp5S9vFiF3r8TV3I7muZc1u8pdC3MsiggvauRpK
	8wSkbmgT22oMbkhqGZ37GOjdY/5L+3m1tPl125y0Q23eEqSpsvJvmEq7MyOT+hBazPvtuOeGlKq
	Nw4+ZpdaCe0DfaucdDp79IMGdM32BTQ72iLy0qKx2MQn45WyMBB/Rk+OtW5SLYCJaup1syZl/Oa
	wRw+A45CEtKRvG3X8YOLy/TzeiVAPvf9r/wSj42DP6Viy5THzJcNin9Urjosw671tf5TS0eDQ30
	UTb67onR1UdVECIEbrIB6hLV0OCAQQBTyIle0Ly+UqjLJqaTchDtiVxgvUYdCzUwdAi8aHY0JAp
	OVv74lHuOi76oUPQprDw1didXriCqsVkzB0+fnotO6ItDmBFYUeNeUHo0redTK57di06DdVqr1i
	JFhtaNLE5UWwRZi8vqswfVIpL2bKcaFGHExiCvvqnFg+8HQuDhm6atm+ugCMewz4aZdJYzjSM5E
	yUzGo=
X-Received: by 2002:a67:e106:0:b0:7cc:7801:b317 with SMTP id ada2fe7eead31-7d4fb2a39a3mr1016937137.9.1794414336792;
        Wed, 11 Nov 2026 08:25:36 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] unit/test-bap: Add tests for a CIS shared by two ASEs
Date: Wed, 11 Nov 2026 11:25:13 -0500
Message-ID: <55e9b0272a729fcc8cd69021750329c3e907b7d3.1794414122.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794414122.git.luiz.von.dentz@intel.com>
References: <cover.1794414122.git.luiz.von.dentz@intel.com>
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

