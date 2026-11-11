Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429480;
	b=alatWlR88h/nL5QJ7XStQIQmEwJYF6B27/P3zRJNIVbJFdww+0gFRZtSEtWaPmtOWNo1
	 rGyFnHam9+O17bJQ2YXPF6zT+xfk4WrCJRU38vbrIRdkzYtnXmg6/2Ivj4m5NUoqEuQQw
	 OeZb9XaSb1NO5eaDVYiN6Sf93iSuplFXfvnxLSHLhIOzm8Fmmm4r1/uqkiOcr1zBIi5VB
	 McFcNo8sJQhtkuDJ1qUUOfUTtaTgV2P+G8tLboD8G9bPc9hZUV23ynYQVxatPkTctPvO3
	 IPh9rdhYLD5XjekmXWSp78TZMhn2MDC86Up38j5vNAGhxuh3f2Odj9sT2FNStS6Aj6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y1sJ3eyQdXePX+6KVVd6cueJvkgGEPK+WPEO6v6vtMI=;
	b=qD0mF+CWGXnQJzoFIlQqNw+61XV4/q8fKI8I1VvdimCXPST8W8rRGFlKYC4ofltLguVT
	 +m6oIFAxJK7TUoQZLbJ4bpvQYxq2MlEDgHz3F4+dQlchlbTaYo5fMy/kMwthLwGT97AmL
	 48flBnTIXBH2E8+Lh7qT0VPHGZg1YEs/B5E+rd5Z11WRNMm0aORfV9QeftYfs/+RZQJSI
	 oIqj4WDBu5Oj+iiWHpsHN7ZWVvsA1iePtm/+OunhW5yVUD3jJyxIzcE3hGInBzgLasxP/
	 aKAUxfbDWlZ+Yfi5uZuiEJM+lItv2JqrC5wuxAN9KVj32HIksKGhR9RQxZvzxae2x0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ES1WeJ3j;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FC60A262E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 305FC60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ES1WeJ3j
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so966500241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429479; x=1795034279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y1sJ3eyQdXePX+6KVVd6cueJvkgGEPK+WPEO6v6vtMI=;
        b=ES1WeJ3jHT5uOpmx4lJQl9IPveWhw78j8ocYObYpDWF0Zt9sre1jbudrmiZTmgnn0q
         gfXpf/X2WNeng+bgS3/2h+1ycC1i7PTKs/1z1k07eWc8pgBy06nrRr9wh/Jr/ZFR5EM6
         k9JghdmVgCCWrcr4bBaiNYzWG5fOesgBzpnwhk08yQxX/o3IJqwBIYIrJVK+e5zGorcw
         19m5xaqEHh8GicJ0cdZIr2cv5F/XuIFntSHLFGI7IM4KiNpfbPUeK618XfOZWiFUwQDc
         Kb/guqBocqQxhw1NHGeZ9U6dIM6Ar5CdChE87Av3ITkOdcVfNpDm2LNpV5v6U8gfhjDP
         WKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429479; x=1795034279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y1sJ3eyQdXePX+6KVVd6cueJvkgGEPK+WPEO6v6vtMI=;
        b=E77+72R11kpKqGWkTsUOheJKfLLEpoFDt85zoidr5tkKB/E9dzhNWTVcy+aFQ4kpRg
         pjvYs6fCutjV1studzTY7JPNwMVFLcHa2bmxRJYk8fvcu2FaMUFf9xxGlLfZcQYIBOlY
         M7+hveUjKGsp3JEcksHFPEu0qOa2w0I9lqSceDlevXMtTe+qwR/axDjf+OXRwas69wga
         9fePCizvXqkq7kY0owgwvEhyiBsjW1vNTXaRTtKCwA3LACwxvBH9eJ8eNr89kxFHFGKI
         kWngS+BgGGNYYCdz1Fkij4S/2op6UZ0cS8O+GeqRVbr9360iHGKJXSM27PgtXi4I/bNC
         BgYA==
X-Gm-Message-State: APuU4Z/8COyiOPvC2jRaN0C9YblPigdkoJVKfpkXrnplc5+yKlDeq4He
	XiGn7JqSKCtNFjcv/LW68WAt7HHSnmagdEtHWkOmfFlII1WScxUBAUAWOiZgIw==
X-Gm-Gg: AYBFou13ZY9bt38D9fUa5d4wxrX0ogFgdo+lHfDaM7Hxo29cKeYU/243aZegAE0Id1A
	kKy5lJhSUXNgmVTCUQnJYgH4sobmg+pKyZyxtgRKFxDS+lCcGMEEY6CJ/+oaEN7xko7hdznKnyG
	5AekHbqToLGAjMxqVcShtbiP5EuAWFbm4SYduQqi0QigHC4ru7oEZ670FpeABPMBYZ9RFvef7qw
	/ly2ou+0bhcHSC0WdYDJxk5VCMd4M41RluUIQOH3g663iMHul4rqCS9D4rAhaUlLOSAR96TO0tx
	ZZJ03qZmN0H6ykY9JXM5Y0C+qvHJ5lCArVU7zrS2QMMwdcwFbiI02u86JuIPynkT+dXIfkz4vUm
	OgZ9gyouW6i1MdXgeto3FMzgNMscSxwqJV2flYoLbu5ivg365Vry1aIpkKQIT4c2NsnHywO3e09
	oXRHuOCbHJpJyGM6cBRdKixvTjGdtpYW3SqvJjha/CApmAdVGWRmt/4v9c5NbpvQoUpLFMHNzhg
	7nlQ8dqfhyi2OsIT9+rvRut8l+DNFgwqpWs34PhDSnf2WW9/HgpgQJ6bjDAnp7g0YJxrF1ONg0P
	JANkpUowOwju5FAHpD/AWmicAiyX/bias44q8js6R+TFibFkaGXcNl1MXrqMyXsDz2eakTlQL4w
	+pO/wAJ9tSE2SnPkaPFF96arSMuYXDqo6vhF6abVW4fhsififrtZnvEpXVYfSzNQFL7+YTOVtzt
	hbwTQ=
X-Received: by 2002:a05:6102:3f44:b0:7b5:7cd5:2a1b with SMTP id ada2fe7eead31-7d4fb250760mr1207702137.10.1794429478999;
        Wed, 11 Nov 2026 12:37:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/8] unit/test-bap: Add test for disabling one ASE of a shared CIS
Date: Wed, 11 Nov 2026 15:37:36 -0500
Message-ID: <39244774bf8c444d7870ef0b839ccdc3fb981f24.1794428234.git.luiz.von.dentz@intel.com>
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

