Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349175;
	b=MHCB3HXo+NhYywrxx0hxZp3F/xSbdzm13hBV2Xac/5SYdWfUi27NmKxHMXdYs63aAmOn
	 o7UxW5um0qp9NfOaOt5M4fNPj84vDWGad2G6Uh69jnFhTZEItLLIS+mXgHZZsSYW7KPGE
	 1JIgWXGg0eRdFlimXew3tFV1s2VHg+p/OtthjXdXv/iPdsPP/r/sMCdPFUdRA8rdtLVkt
	 8ywy27oqBWlbeBnIR1+HU8U0tw59siA5r/vZEkN3FhNKLKZ4PK5GSr5Es2Jonn6LC65Cb
	 ImtexjJTtYtJ96FQbglBATWP7Ro7jkZrjBX/yzAzCZwLyhp8epU2CAhi0MFk0qkd+ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y1sJ3eyQdXePX+6KVVd6cueJvkgGEPK+WPEO6v6vtMI=;
	b=QFI+STUHmet9nJiHXy7VBqKc6o/MB97bIq7/Q9QwzZ33Mm5hK/zhgWGBKJsc8nK+okqt
	 NC47NVHHXLeQjtNYxYHQ5RiuuboUryfDyoqJDKcAM/TnaSMxEtJbf2r52RRVkGVAnp3DB
	 bsNKmyhV6foBQXTs3/dZ4dI+Y6PpgLfN72yJFKVLC4iDFJMuB2b0C1qrX0HfEqhWcYC0Y
	 1j8igfwRG1ZQXwyk7Gbmt52lUoYAQ1foRQyoXb5MSmzucVdPgDoLn7Ab0KuoJR9q+0Jk3
	 p6xaya/ZiVwGk0QiIs+eQDDZWQTQwYXAcPhT55xPVaZv+bsrZvez+t1LVpMI9VEM5Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgntRlvk;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04A606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F04A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgntRlvk
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eae12762c9so927010e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349173; x=1794953973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y1sJ3eyQdXePX+6KVVd6cueJvkgGEPK+WPEO6v6vtMI=;
        b=SgntRlvkuywDd8lVEfhdGqTUhdGJv9evE2SuC0xIZCvwS8cWiAheziu7YwZqHCtk0j
         FizM4jia7/P6GT+xfmmK3FSMahs4nTJS+t1eZejESytIDct/sDblxz/AS8J9fQ+eUsyG
         HRNCEUP91PR027/zeOwSjvSOvKO8KnNSF0AHI4kWSJlyd0YkHN879IydfWA+MRer3gPd
         fAPoCJP0MBdZMFcfPGvhGpI/Vu5FE9U/Ds1DZkSKE1/6O08wg1M8Fm5DuSla6oFJJwAE
         0Srs7o4ekUbfmid52YZD4njqNfy7P2fZ+jlurOaR8/x1Jfeo1L7qfP3EDfxEYIEBFXWd
         xVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349173; x=1794953973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y1sJ3eyQdXePX+6KVVd6cueJvkgGEPK+WPEO6v6vtMI=;
        b=gl2YVNZrHnxCcWPfI9il0W18otO9/RMhsxG+BbWa1oLXXqU/WtPW33q0AUqYuY+ie/
         djTETC+F+IdCxOfK+G+4k65/R8a2z27jkSPMuDu+ZsnIYXjFrJ+U+GcRvyRL77rTvL81
         cfurtnDirfHMOaeUUO7VTtfUr0jLa+RXdGo05t6YmFf0b0Wsv4Ny14J8wLNk+hy1N2yl
         QKUHf+SsFnwCnB1XHeg4EbodQFGQ2O6Z+oQxs+HgnnKdWvPcMtKrG6QZgTcaEuDlsT/+
         c6c8KfROY41VtDhnyz01CNnZRJjoHKhN4MS0kV7gPPO8vCjWlduthkgOyohLqdmhX2Ko
         014g==
X-Gm-Message-State: APuU4Z+kpqQyixunxo68zGQSNr8rHQAJiz7CK4T0wWUGMYG3StZ5c8L5
	vDBSZJ1W50NtL3XEynHS4CKSAyFLHeZavIiEeC5RuEO1B6SbkTE5hsEooCXgTw==
X-Gm-Gg: AYBFou3sgi+tBRwfCZ/LdRzyAqWsnyMKVg24TSvExlXIVWkKo+x3j7w+wqvI4kjIlZe
	aKBrkj4wSZu6TqM1dn+rbrEpb695/vchiEMSEq0FIXLwSIIZlcxRkrKvhbdbIHxZkw2E4xVoMzk
	tkJkm9kMqVYy8RqjFOzNol1Rr6tyABgDhG1SwyynK85EQYanJ0AXNC//8Pzc/Su6FRW3wnzgTlb
	ZpH4Sj7NzdsVe8t8c1ln2tDKZ9z7+hxIbVg9sh6CBuHV37njLMwMx4c715nActPMWZfxk1pkPEU
	84U9drIIy65cZxUrwYoMtjpk/CR5fF5T8m48OuLSMHhBJnMxGprbIfWeEb1eAlqb3cdXFKIYPDE
	jDBC8i5NEa2UKQ6azh+u3liTaP673HdcxnUfj/xM+S/NMPR79AkwSeWIEkGZKo9rQLB6VIZXc54
	/8bCYUfqcQuq2DU14LqEROUVP9gJqVInpWph/epc6RzJ8jr3D8FqaaShDkR35jmtLFAQjs4tcNs
	eKzW0GjAoG/MgWeS+fzGC/W9UksmyXyTYLryh3vdkXZ+ko1Mfkb1dbwQlBvg485PU9756FGWjHJ
	Zg+mI1sf/jxOonLD7VTBy4n6nt9ODfS9D2rvbPN+tR39+2Yxjib2z7yJCbzTJ2Cxy3b4mZ8sNVi
	AQ9Iz3W4Q7B2SZ7vzyivCYUaBkyS7gfiBNBKRPYkMIRZFJA51/2Ty2S7JrtR4XocgHBGmXlWRiu
	odbY9YsjRsPysvroSEixCAtBiH
X-Received: by 2002:a05:6122:1d9f:b0:5ec:41df:f110 with SMTP id 71dfb90a1353d-5ee1c499800mr117519e0c.23.1794349173390;
        Tue, 10 Nov 2026 14:19:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/8] unit/test-bap: Add test for disabling one ASE of a shared CIS
Date: Tue, 10 Nov 2026 17:19:11 -0500
Message-ID: <2b39b535cdf993b8e363d96ed66e58f07d7a42ed.1794349049.git.luiz.von.dentz@intel.com>
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

From: Kannan J <kannan.j@intel.com>

Configure a Sink and a Source ASE for the same CIS and have both
streaming over it, then disable and stop only the Source ASE, as when
a call ends while media keeps playing. Once the Source ASE is back to
QoS Configured, the Sink ASE has to still be linked to it and streaming
over the same CIS, which has to stay connected.
---
 unit/test-bap.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 3713ad56c072..bfe98a885411 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -4952,6 +4952,95 @@ static void test_usr_scc_switch_cis(void)
 			&cfg_switch_cis, SCC_SWITCH_CIS);
 }
 
+static int disable_link_cis_fd = -1;
+
+static bool match_stream_dir(const void *data, const void *user_data)
+{
+	return bt_bap_stream_get_dir((void *)data) == PTR_TO_UINT(user_data);
+}
+
+static void state_disable_link(struct bt_bap_stream *stream,
+					uint8_t old_state, uint8_t new_state,
+					void *user_data)
+{
+	struct test_data *data = user_data;
+	struct bt_bap_stream *link;
+	char buf;
+	int fds[2];
+	int err;
+	int fd;
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
+		disable_link_cis_fd = fds[0];
+		data->fds[0][0] = fds[0];
+		data->fds[0][1] = fds[1];
+		break;
+	case BT_BAP_STREAM_STATE_QOS:
+		if (old_state != BT_BAP_STREAM_STATE_DISABLING)
+			return;
+
+		/* The Sink ASE is still streaming over the CIS, linked to the
+		 * Source ASE, so its transport has to stay acquired.
+		 */
+		link = queue_find(bt_bap_stream_io_get_links(stream),
+					match_stream_dir,
+					UINT_TO_PTR(BT_BAP_SINK));
+		g_assert(link);
+		g_assert(bt_bap_stream_get_state(link) ==
+					BT_BAP_STREAM_STATE_STREAMING);
+
+		fd = -1;
+		bt_bap_stream_io_is_connecting(link, &fd);
+		g_assert(fd == disable_link_cis_fd);
+		err = recv(data->fds[0][1], &buf, 1, MSG_DONTWAIT | MSG_PEEK);
+		g_assert(err < 0 && errno == EAGAIN);
+		break;
+	}
+}
+
+static struct test_config cfg_disable_link = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1,
+	.snk = true,
+	.src = true,
+	.state_func = state_disable_link,
+};
+
+/* Sink and Source ASE configured for the same CIS and both streaming: the
+ * Source ASE alone is disabled and stopped, as when a call ends while media
+ * keeps playing. The Sink ASE has to keep streaming over the same CIS.
+ */
+#define SCC_DISABLE_LINK \
+	DISC_SRC_ASE_LC3, \
+	SCC_SNK(LC3_CONFIG_16_2_DATA), \
+	SCC_SRC(LC3_CONFIG_16_2_DATA), \
+	QOS_SNK(QOS_16_2_1_DATA), \
+	QOS_SRC(QOS_16_2_1_DATA), \
+	SRC_ENABLE, \
+	SRC_START, \
+	ENABLE_ASE(SNK_ID(0)), \
+	SNK_ENABLE_NOTIFY(0, 0), \
+	SNK_START_NOTIFY(0, 0), \
+	SRC_DISABLE, \
+	IOV_DATA(0x52, CP_HND, 0x06, 0x01, SRC_ID(0)), \
+	ASE_CP_RSP(0x06, SRC_ID(0), 0x00, 0x00), \
+	QOS_SRC_NOTIFY(0, 0, QOS_16_2_1_DATA)
+
+static void test_usr_scc_disable_link(void)
+{
+	define_test("BAP/USR/SCC/BLUEZ-5 [USR Disable one ASE of a shared CIS]",
+			test_setup_server, test_server_state,
+			&cfg_disable_link, SCC_DISABLE_LINK);
+}
+
 static struct test_config str_snk_ac2_8_1_1 = {
 	.cc = LC3_CONFIG_8_1_AC(1),
 	.qos = LC3_QOS_8_1_1_AC(1),
@@ -7816,6 +7905,7 @@ static void test_scc(void)
 	test_usr_scc_release_link();
 	test_usr_scc_release_cis();
 	test_usr_scc_switch_cis();
+	test_usr_scc_disable_link();
 	test_scc_metadata();
 	test_str_1_1_1_lc3();
 }
-- 
2.56.0

