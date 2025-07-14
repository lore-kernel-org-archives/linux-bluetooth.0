Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA728EA
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511508; cv=pass; b=OFZ58rhDmbW8psaNe85p5jAvc8oaqfoMbZ2Sijuv8J/EJVwIaGhNOHAEaSoYvcNH7Om1c9EoBd8tbl+vSume+awLBg4hpsJDHcXeiwul4ePhmPZQmVhZU5bhBpWD11mchEnKzz1eX22tRfjsuXu0334RiDrwCk2sz7IJn8AWwZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511508; c=relaxed/simple;
	bh=XDwqLkunv18KD30JCOsPRnQUluEwhZiPRF6RIQOJ2QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEjV2H3a+/ehwFl2wT8wL7MH9q0lPQLS/adHlFuecahHLZ/ndsf5G9Hm4uthpDoFfEGf/SECwqhLL3VRp+8wC8t7PzI0D/w2jX9cpmQo/tswoa0Mf7DSebHQrnhhyud0bn5YVDRjBJS60dS+QwTgkU973kiN9AEVSiB+WIRYG7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=WQZI79RJ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="WQZI79RJ"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bgp8H73gsz49QFV;
	Mon, 14 Jul 2025 19:45:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752511504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHkDQ04IJvRQUpilHYAr/2FYonwTeL2uUyLBFmdhnzM=;
	b=WQZI79RJ8O+f9GuW0WUXrkgsAPKHySKmr3sifieJRetmGMY3RUbLMWkbnuFGRvdL2bFB8g
	iczzPJs7s18kToyOCnPUrxaCwoHWQhLQ2YpkU7hb95o4apE3Kg3hIalzHLdpXtwm0d8Seq
	sYuMsoXVHpO4vKgngmYQB3QIuT92Y6+ffLj+XOokoKvlGDQ+Nve6i2yEFB5sCvrSQNC3Cr
	bsqKdWHiFff80x6bOp4KTq4W8iJeBTpvtBjqdySGvm/doJE6z9NhuqxFGeDvv1O9NC/jbh
	V9rek/ZjynSwVPmn9ySlEvGRHjzBQsfsuUqhCeTMsYiqaihraxcSTVGalCvsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752511504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHkDQ04IJvRQUpilHYAr/2FYonwTeL2uUyLBFmdhnzM=;
	b=Kk+NyMSk+6BrJOF0ZaVmhaFNbfH7oXmBJU1Gwn8bk85IlaoV9vxKNU8GUXUZVvUXj+TENl
	gL4+IvelkfdMICIrRLUkEfYxD2DIPDTjOO6wxox2BWR/+zoku3oARVx5jn95OraeBb7ccf
	v5e8L7vAIuK3u92BycncivjObxVy0PbG/k+My23P0Fw5/UTAAYv2SLt0p4Jc8K1dbkBizc
	jKJNIzB5AARQ4s8fXrW4m8U0jLDgiViWynZDSKRqrCt0fBuLzU8LUWjMuBeBUElFRt/8sE
	AhQMt/xgnUTrirJXCDg+8LncBNClVxkAok4YLe7Sr4rPe7smx8MHlDDHw1fglw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752511504; a=rsa-sha256;
	cv=none;
	b=ojj0/PZ1pttITjDY0iBi2I7BPXPOVzbZRd7dHzL2y+w9IZ9FusCy/YT1SSsDxunzGotE0R
	8B1BIxpmBVBcGo/HfUur9T3nBOtCDsv43dy8U58dfxxPw9GGm1FGPhxlQVBsWkiu+q1go4
	0FAKcXhfmWjXi7WOfQ+pzebKnjvLvEO04kXW50iQ3Oeso9XtO2YhYntKYE8pZ4W/4HHFOW
	shT2r54fPMN6/qNQn1wBGr1yZMH6AB8H0PQryNqrPXdI5yOvzZ1PeB4jmQAVrg06TKvSI1
	ndSlMqxmL6WrNtw8IFuT8DUTD+NZz179OeK16MjuizR0POKGT0Og3S131bbM7g==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2.. 3/3] iso-tester: add tests for BT_PKT_SEQNUM
Date: Mon, 14 Jul 2025 19:44:50 +0300
Message-ID: <b98b7691e4ba06550bb8f275cad0635bc9e4e8d2.1752511478.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2ffec6539fe38318c713b48985aaddda9671f258.1752511478.git.pav@iki.fi>
References: <2ffec6539fe38318c713b48985aaddda9671f258.1752511478.git.pav@iki.fi>
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

