Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414353;
	b=j8vwb3S87EKkY8n0EOSmxiojMBHOe3mvs+eME1HalKdfX17bWhjoJjHRe1PJPUMtF4PU
	 UsFFdeCojnJ+3tO74vlt0DkxuklhxjMb8lJoMq6IspKOZsm+/mxDdNCkKp5ldObI0l8W/
	 eM0bGu5D92BEWKDss9fYe8jtG+dUaIYwZBcm9W1dfuYqAK2n2b4HqMZFNWmvzdkLwrWUY
	 KAqcHuANswGaV5r2xccqU1gPPNbuC+1o8tw8RZoqvAOqlGJZB64cQiwDHwwQXFA4bOXxm
	 6Eg5LHpTA27Cx/NSAmF647mws+dCh2dFzC82EHwFdWj9TLLGFL9R4NQB6x6FJBCjIpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y1sJ3eyQdXePX+6KVVd6cueJvkgGEPK+WPEO6v6vtMI=;
	b=XMUveWRHE/ATPwsEjNpkwXolSihnGWvjDCmzUaOucOMRIaBHwpTEUjYo8pv6JXQobW0B
	 JQfuMATp3iSapeRVcmD9Nn5JJcRgvlykxFj56CbO29CepBENW1NpgMMs3BP8GWawbkhv8
	 umzWr7R+YirS2KxkcgXwgCnw6LFsep6gTZELcAKo24ozdGZ8XeO3FHnjX/RixyYbbF2Mi
	 EwEkLqVo7iP8fMyjVKY3dKCMrUfiKSGbYZVqc6aIWvIHco/8tovhIowFTKFehlFXVGDu9
	 O/i778taK9Hq8F7qnoFB6TWog1A5r9+pl9xlxflqw3XOpJWXhXGUrgEeYmpZVLvMP5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d00zZMIE;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B586606A883
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B586606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d00zZMIE
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc91ddf447so1329715137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414352; x=1795019152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y1sJ3eyQdXePX+6KVVd6cueJvkgGEPK+WPEO6v6vtMI=;
        b=d00zZMIEMHTFoDi3CXrDlaIs73BriGDnmhmdPPUqhc8u6GAHSYX1bB3aSm1Xq6Wvt2
         iTxgx7CsqdlNDWCSvc3v93+TT16QbLRGFtIDUtzfGQlALHM6c+r/0FdH+6V4B4jbEnIS
         ZjS9BRYG9rshoOeqYtUinegYJWXQG9YpUz5V+ohQaF93DTDqHEiMTeJHc2cZQKiE7ow3
         SEVEEUtYwra5DKl3x7Q7+5COksxbWjpfOVu6FOxp2JeQmBCvDlXXj4PeVd8vKPrDwcPw
         /vKwgNWCBZA2n9SSfAL4+UmDzEMj7IKZP5pd6HPtQuDD0RTI0nTNO+FjX/Y9sm4d5XUz
         V+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414352; x=1795019152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y1sJ3eyQdXePX+6KVVd6cueJvkgGEPK+WPEO6v6vtMI=;
        b=gzfdfuIk5jE3xEVc9qviPtJe4iD7/OfDHGc29Xw9fapyxGnl7fmOGMsnt9S0aErBH/
         wCnJp1v0iXqxIaHfnDLWUF7My/i9vRe2hmESXm1FW0EhZZ1tz9d6VUKEo7HuFBRzXd+w
         hZwAKg5GhqiqR9UCIHA6lh4Ep9CWC/cpnuNNc63km+Xs/4kAkDJIzplUMmcoLgGl2UO7
         YNL16cz1R6B4QgH68isPrzud41OrQrR0ilCqH0UYWFdx8Etke9+C3eoVdBSGWNmq252L
         8e+OQJ1KpB52ezvG0/qX3wxDWhvA0BJi91txF7sHlqdDsPUx7qb0sSitAx+7xNr4CvgA
         VAoA==
X-Gm-Message-State: APuU4Z+RHy9srCIOBVq3Gse4URXGtw9IxhuxUMPwt6u4lEI17h7Phu0D
	awi8hSFLFE6+jA7EXC5+UcCNWzCLS444i6w/m4sfzgBVrO0Jq6BWGw0PI9cqyg==
X-Gm-Gg: AYBFou3Lzk0uV7Fow+l6XTSzMySpjM1XVoPU4RePOkycEuuHNPa6YcdQKRBr+GjcT+o
	hjQRE2Z6NxxyQ60v1XGoOCP1e/D4V/soMgs6TofTFWwR2IFu9nQasQVM/GyK8MvUJMR++scb0tP
	RyXDyRrSaY5QYhZcRGJAQQUKhIypSIK4a7FkdNU1UGsJOr0zHZXuci9NWN6A9WCylsyRaC2gbKI
	Yr8lhBLoag+HDdgUdT1PkwzTb/jJiRkkIXakSujyEs/krJ0LNQI0CEWkRshWRJ4jnoHLV2X40HO
	MxrF8gS3BUIflqhppoqdTP4Y7TueWOJlMTgQgxLbo2EwA2iT9sIGWZLHbFPpQCOlpM+HKGKWlZ4
	nJOlotq6svz2tDNZGUC7OwnffTY1HRN14BBdbtdkar4+chfTIlAO+pMiuoQlhuDTVVv0q7FlDHn
	lRzOZzTsOMBQ8PfOuw4pKmre6UP4zyhDPuz7kHRV3kmkbkMCA5Ps1xy7Uc+ihhyES87fIl54tP4
	7KHRjMjaeEK9kPY6s6GZ4uyi+hNxdyrO902OUCkv/iqpfUfd+MUnChihnnmg4vI7iNVqFRJ6XZL
	EI8kTyP1xAoipfVivOfkRKaWTaSa7LbXDtOTdNpdZHD6kcFZW7WsmJhxp4Z9PqODo9EDSU9KT+w
	6L3IXL5atC6GsJ2iOHQpJ6fRKTx+SNhsUtxBO0BOqr/jQ+H48NTZJWJhZ77dOxPxuXuS1EWXcSK
	ijZLw=
X-Received: by 2002:a05:6102:418c:b0:7cc:32ce:4c49 with SMTP id ada2fe7eead31-7d5060b70bfmr824514137.27.1794414351732;
        Wed, 11 Nov 2026 08:25:51 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/8] unit/test-bap: Add test for disabling one ASE of a shared CIS
Date: Wed, 11 Nov 2026 11:25:25 -0500
Message-ID: <3eeb1d44306e1c3833788460706ae2fc9803f4ad.1794414122.git.luiz.von.dentz@intel.com>
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

