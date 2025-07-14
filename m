Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE55253F1D
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501897; cv=pass; b=lsL+XJnYZSS6S5v+BCSCdgbmCNTeNBvHCJpgePjZmkfA6A3nQzuKiSBxg2oogBH2ZHGFCM2Xwsmzxk3jGuutqmeMpXHeGJJo9vo+b83NwFhFwCzsiQ4VCiDLfbz/107fC8oivHSSEHKBSRjG6bvkERWTzhMv11tcGUlALCwc54o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501897; c=relaxed/simple;
	bh=XDwqLkunv18KD30JCOsPRnQUluEwhZiPRF6RIQOJ2QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afPF/12Fua0z7xulCri8sYjC7jL/e9F5aTmDc3/dtD8OPg7rek0GJSRuT8VwRQ9fPxX+3gu+52LQ+3dyDHPK1kW1CL1RwEKVfr5o0t+OyB68x8YGEmICaTAA+80BYcZNNW5Tg6L8FGhpmCCqVYIgjYc1ioWCNy9ZzSg4NQ1QDGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=naEeeoU9; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="naEeeoU9"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bgkbT45tHzyZL;
	Mon, 14 Jul 2025 17:04:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1752501894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHkDQ04IJvRQUpilHYAr/2FYonwTeL2uUyLBFmdhnzM=;
	b=naEeeoU92MtLWet43Q6gG8LtLEpHcoVU97hbgkqfLKKcNtTmVQPcAS688+lyRZM3TPUQLv
	SQ9yH44mGwEzqEPpoG+U57hKbHwOcpscDx/lH0pWaJPoEnL0gDYJ6J3SkW037GPyemV4K1
	EvPHGI/G6SHYCBXbyFqqO1KKy0oasD0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1752501894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHkDQ04IJvRQUpilHYAr/2FYonwTeL2uUyLBFmdhnzM=;
	b=s5I7pSoDVwdhDLdDMbzXj/+xuI+DI7raf16HkBYyvh9giNYlvfiLVNCoU7z0HTAFdAmRcK
	xy0Gm1SqHZUTwXLR3m6kE7Bmu3XVuW3w96NuZ9tB1/3zCgi+6JfOmbHmJWHcm3s6CvhsAX
	AU4603XAeaJg4PXZdbBbhzhD7BzUIOw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1752501894; a=rsa-sha256; cv=none;
	b=K1i930fgwPa+lfAElk/x4BQaXJSt/ZlI7M5EI+MOFbpi7/KteelWgsbY1NkVxtEV0RdJC+
	3kUHdcKiSwl4667ECbDe44U2J8KNTg4QUXkodjrLhSHUe68Sd+1DRK2jlEdvvqciNuR/XV
	4T0wvCrGpLBVbUkpIqOz7DygCyIRDdA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] iso-tester: add tests for BT_PKT_SEQNUM
Date: Mon, 14 Jul 2025 17:04:46 +0300
Message-ID: <c9a75585e3640d8a1efca0bf96158eec1ca25fdc.1752501450.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2ffec6539fe38318c713b48985aaddda9671f258.1752501450.git.pav@iki.fi>
References: <2ffec6539fe38318c713b48985aaddda9671f258.1752501450.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test

ISO Receive Packet Seqnum - Success
---
 tools/iso-tester.c | 80 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 2c674171d..6aefb5196 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -477,6 +477,7 @@ struct test_data {
 	bool reconnect;
 	bool suspending;
 	struct tx_tstamp_data tx_ts;
+	int seqnum;
 };
 
 struct iso_client_data {
@@ -500,6 +501,9 @@ struct iso_client_data {
 	bool pa_bind;
 	bool big;
 
+	/* Enable BT_PKT_SEQNUM for RX packet sequence numbers */
+	bool pkt_seqnum;
+
 	/* Enable SO_TIMESTAMPING with these flags */
 	uint32_t so_timestamping;
 
@@ -1061,6 +1065,14 @@ static const struct iso_client_data listen_16_2_1_recv_pkt_status = {
 	.pkt_status = 0x02,
 };
 
+static const struct iso_client_data listen_16_2_1_recv_pkt_seqnum = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+	.pkt_seqnum = true,
+};
+
 static const struct iso_client_data listen_16_2_1_recv_rx_timestamping = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -2204,11 +2216,51 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
+	if (isodata->pkt_seqnum) {
+		struct cmsghdr *cmsg;
+		uint16_t pkt_seqnum = 0;
+
+		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
+					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+			if (cmsg->cmsg_level != SOL_BLUETOOTH)
+				continue;
+
+			if (cmsg->cmsg_type == BT_SCM_PKT_SEQNUM) {
+				memcpy(&pkt_seqnum, CMSG_DATA(cmsg),
+						sizeof(pkt_seqnum));
+				tester_debug("BT_SCM_PKT_SEQNUM = 0x%2.2x",
+							pkt_seqnum);
+				break;
+			}
+		}
+
+		if (data->seqnum < 0)
+			data->seqnum = pkt_seqnum;
+		else
+			data->seqnum++;
+
+		if (pkt_seqnum != data->seqnum) {
+			tester_warn("isodata->pkt_seqnum 0x%2.2x != 0x%2.2x "
+					"pkt_seqnum", pkt_seqnum, data->seqnum);
+			tester_test_failed();
+			return FALSE;
+		}
+	}
+
 	if (isodata->so_timestamping & SOF_TIMESTAMPING_RX_SOFTWARE)
 		rx_timestamp_check(&msg);
 
+	if (data->step) {
+		data->step--;
+	} else {
+		tester_test_failed();
+		return FALSE;
+	}
+
 	if (memcmp(buf, isodata->recv->iov_base, ret))
 		tester_test_failed();
+	else if (data->step)
+		return TRUE;
 	else
 		tester_test_passed();
 
@@ -2220,6 +2272,7 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 	const struct iso_client_data *isodata = data->test_data;
 	struct bthost *host;
 	static uint16_t sn;
+	int j, count;
 
 	tester_print("Receive %zu bytes of data", isodata->recv->iov_len);
 
@@ -2234,8 +2287,13 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 		return;
 
 	host = hciemu_client_get_host(data->hciemu);
-	bthost_send_iso(host, data->handle, isodata->ts, sn++, 0,
-				isodata->pkt_status, isodata->recv, 1);
+
+	count = isodata->pkt_seqnum ? 2 : 1;
+	for (j = 0; j < count; ++j) {
+		bthost_send_iso(host, data->handle, isodata->ts, sn++, 0,
+					isodata->pkt_status, isodata->recv, 1);
+		data->step++;
+	}
 
 	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_recv_data, data);
 }
@@ -3093,6 +3151,20 @@ static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
+	if (isodata->pkt_seqnum) {
+		int opt = 1;
+
+		data->seqnum = -1;
+
+		if (setsockopt(new_sk, SOL_BLUETOOTH, BT_PKT_SEQNUM, &opt,
+							sizeof(opt)) < 0) {
+			tester_print("Can't set socket BT_PKT_SEQNUM option: "
+					"%s (%d)", strerror(errno), errno);
+			tester_test_failed();
+			return false;
+		}
+	}
+
 	ret = iso_connect(new_io, cond, user_data);
 
 	g_io_channel_unref(new_io);
@@ -3654,6 +3726,10 @@ int main(int argc, char *argv[])
 						&listen_16_2_1_recv_pkt_status,
 						setup_powered, test_listen);
 
+	test_iso("ISO Receive Packet Seqnum - Success",
+						&listen_16_2_1_recv_pkt_seqnum,
+						setup_powered, test_listen);
+
 	test_iso("ISO Receive - RX Timestamping",
 					&listen_16_2_1_recv_rx_timestamping,
 					setup_powered, test_listen);
-- 
2.50.1

