Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5415B57C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083792; cv=pass; b=DXZfoZaM0u9MX960MCrd+nvOqdxtWkwdKcKqDCCjhJ2zzBaDwH91585NoYoEJ2FAF4hK8+SRG8aJFZWXCgKmNu9BpHWl56NHOGi4auCl4Phx376X55BH6UcjyntqwnLwRoDTNTtcCfaJvBoZBqVm73VoB92UQYKCTpYgPWKiDE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083792; c=relaxed/simple;
	bh=1Ux7vU2EN6XfhF2iHSUa7m1yjbwoXsqdQj+LuIZ5DzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUOkYSDnsJvX1uO5iX+2BcW2ZTZUBa1ya2l7ddkUjDGCwcR48sU1ykrBIWo3MfobpsTQIyNdGmelqgAb+5uUtyI/jxQ5Ai2X1M8YxyEC8+YavfUnF8GVGZmzEMIoqSIf14lqlG8CaviSYfVEz0dq08LoWO3zOHI8F6weOqyNtZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZMPxYrPS; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZMPxYrPS"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8H3h4tN6z49Q20;
	Tue,  2 Apr 2024 21:49:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712083761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwyCCRgw3xaKuhE1uxZhmGMrtIEPd+B5gXuytRvdC/E=;
	b=ZMPxYrPSNT/Wh6natDc2JgmWnlakBbxs1dL5+rgrTQmdLz+71JodLIZdlmLyKWyCoeEuLS
	QFiBg9pekBbCf31v3OK1AexmscouehtDZ6wz0xrPI8a+8m7YWqe/+6vxKjzKdSf9bPNGV/
	y/iISF82mmfOIpzvTHn94YNjIpWWGGq/Lz5mge8IYlMGI8OjJY8XWYtuNAUYFOighwL+J1
	1VniW8LG6J4pWOSNkGDuyUWtEIgLSAcB/zcRQFnyDbo2KFAd9t5dWvns2Sn1X6ljuDMYKC
	tA7YLxU8sKpf1Q5grH7u8tflwcl0OXvWvppjBEAMB2hqj0Nh9+oaStjUJmju+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712083761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwyCCRgw3xaKuhE1uxZhmGMrtIEPd+B5gXuytRvdC/E=;
	b=no70vu/DCPRgrXNljmDdsO59pIDlQZ227OD5H8N54wheuqdHL7cs5VLDNiZL3H3otT4zzE
	4ufQyaoD4uAYCty4gZW7WSkpAoMszs+D1FDIcZV2kaTUHiI7mJ8S4a2k070SZnCxz9dPqS
	Grk+xh47OwCkNF5I9WtYsNVzGD8RW0waoJiqCDzzABvmC3Xr8wsfBxOpD7MIAwe751ve7g
	vvAPqCI6aRdhv4u8tR2Ai9bP++wOd71bFBGG5P5M/c96aqkxJzKSDeRJltVwilfL6vJf0g
	RAUCyVNDDj9IeYAna7T0HidNemfNfsYkL3V10DJDBFHNnJ5Oyo5hplKcPcMzrw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712083761; a=rsa-sha256;
	cv=none;
	b=WiXiBGTD5ltlp+Uk+xkG0xwyR/XLdB0/y/I/B0vKtfV3J/9Z9n0NWWCiFnU25+4EMUkVUo
	uQjtFbPNoaDuFxcI/PIdimb6SzwkGYLbpY6PQxDn15rcoNd0/qC5VZkAyvxDCFHCP3VsyS
	rs2Ivin4YZtWjEdud39iDERlI6fQYXUGsQp0d9SSC5eOWKg/lYwvEl3sO0yRocDFEsKDSb
	mvsH6kcFd+eK4gKqk7zUAum6muFgiDDonbP+mv+NyCivUEoc7AgMKo1FpC/MCixsuK/Zsy
	C51kRLznKGNGGdIOPCB2XdB7ZhjLAtEbyeBr0Sphhw0/PunE0Wena2cpOe4ocQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 5/7] sco-tester: add TX timestamping test
Date: Tue,  2 Apr 2024 21:49:12 +0300
Message-ID: <32a5c4f8fb77f94920f55f6f73087182dc55c59d.1712083655.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712083655.git.pav@iki.fi>
References: <cover.1712083655.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test:

SCO CVSD Send - TX Timestamping
---
 tools/sco-tester.c | 94 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index ecc65e092..8997e86f7 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -31,6 +31,8 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
 
+#include "tester-utils.h"
+
 struct test_data {
 	const void *test_data;
 	struct mgmt *mgmt;
@@ -38,15 +40,20 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	unsigned int io_id;
+	unsigned int err_io_id;
 	int sk;
 	bool disable_esco;
 	bool enable_codecs;
+	int step;
+	struct tx_tstamp_data tx_ts;
 };
 
 struct sco_client_data {
 	int expect_err;
 	const uint8_t *send_data;
 	uint16_t data_len;
+	uint32_t so_timestamping;
+	unsigned int send_extra;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -227,8 +234,10 @@ static void test_data_free(void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
 		user->io_id = 0; \
+		user->err_io_id = 0; \
 		user->sk = -1; \
 		user->test_data = data; \
+		user->step = 0; \
 		user->disable_esco = _disable_esco; \
 		user->enable_codecs = _enable_codecs; \
 		tester_add_full(name, data, \
@@ -265,6 +274,16 @@ static const struct sco_client_data connect_send_success = {
 	.send_data = data
 };
 
+static const struct sco_client_data connect_send_tx_timestamping = {
+	.expect_err = 0,
+	.data_len = sizeof(data),
+	.send_data = data,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_SOFTWARE),
+	.send_extra = 2,
+};
+
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -595,6 +614,61 @@ static int connect_sco_sock(struct test_data *data, int sk)
 	return 0;
 }
 
+static gboolean recv_errqueue(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = user_data;
+	const struct sco_client_data *scodata = data->test_data;
+	int sk = g_io_channel_unix_get_fd(io);
+	int err;
+
+	data->step--;
+
+	err = tx_tstamp_recv(&data->tx_ts, sk, scodata->data_len);
+	if (err > 0)
+		return TRUE;
+	else if (!err && !data->step)
+		tester_test_passed();
+	else
+		tester_test_failed();
+
+	data->err_io_id = 0;
+	return FALSE;
+}
+
+static void sco_tx_timestamping(struct test_data *data, GIOChannel *io)
+{
+	const struct sco_client_data *scodata = data->test_data;
+	struct so_timestamping so = {
+		.flags = scodata->so_timestamping,
+	};
+	int sk;
+	int err;
+	unsigned int count;
+
+	if (!(scodata->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK))
+		return;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	tester_print("Enabling TX timestamping");
+
+	tx_tstamp_init(&data->tx_ts, scodata->so_timestamping);
+
+	for (count = 0; count < scodata->send_extra + 1; ++count)
+		data->step += tx_tstamp_expect(&data->tx_ts);
+
+	err = setsockopt(sk, SOL_SOCKET, SO_TIMESTAMPING, &so, sizeof(so));
+	if (err < 0) {
+		tester_warn("setsockopt SO_TIMESTAMPING: %s (%d)",
+						strerror(errno), errno);
+		tester_test_failed();
+		return;
+	}
+
+	data->err_io_id = g_io_add_watch(io, G_IO_ERR, recv_errqueue, data);
+}
+
 static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -619,10 +693,20 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	if (scodata->send_data) {
 		ssize_t ret;
+		unsigned int count;
+
+		data->step = 0;
 
-		tester_print("Writing %u bytes of data", scodata->data_len);
+		sco_tx_timestamping(data, io);
 
-		ret = write(sk, scodata->send_data, scodata->data_len);
+		tester_print("Writing %u*%u bytes of data",
+				scodata->send_extra + 1, scodata->data_len);
+
+		for (count = 0; count < scodata->send_extra + 1; ++count) {
+			ret = write(sk, scodata->send_data, scodata->data_len);
+			if (scodata->data_len != ret)
+				break;
+		}
 		if (scodata->data_len != ret) {
 			tester_warn("Failed to write %u bytes: %zu %s (%d)",
 					scodata->data_len, ret, strerror(errno),
@@ -633,7 +717,7 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	if (-err != scodata->expect_err)
 		tester_test_failed();
-	else
+	else if (!data->step)
 		tester_test_passed();
 
 	return FALSE;
@@ -869,6 +953,10 @@ int main(int argc, char *argv[])
 	test_sco("SCO CVSD Send - Success", &connect_send_success,
 					setup_powered, test_connect);
 
+	test_sco("SCO CVSD Send - TX Timestamping",
+					&connect_send_tx_timestamping,
+					setup_powered, test_connect);
+
 	test_offload_sco("Basic SCO Get Socket Option - Offload - Success",
 				NULL, setup_powered, test_codecs_getsockopt);
 
-- 
2.44.0

