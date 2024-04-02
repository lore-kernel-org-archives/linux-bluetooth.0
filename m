Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2D159919
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076199; cv=pass; b=RhGjhAdXEsszKKd6BmPT6Ajblt+MYkzjHfyTewtLIKH4oK0iNnbCrFCZRizLnbK46H1Vi/JMQYsaRIEZDTBdR5iIwkav4jegTgBrjI11+DFIRwnkMZc2OmfV7QdwhiipLX1YtnmBQjbb76ie0dN3tIU1PWE2p4Qqq+KPoTPKIiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076199; c=relaxed/simple;
	bh=1Ux7vU2EN6XfhF2iHSUa7m1yjbwoXsqdQj+LuIZ5DzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYkL5Jqw+HV/4IsuwKKlvhBwse+UuLegwj/Sk0aeDkQM4FvXLkwuSKztrIF8DvAeHcXfobsr8wV6A9HGhaZ0jO7OyI3bX8QwQrSg4SNPVoSIfeUtwqI89rAqgirYq3VhbRAqJ8rU+Ng34F8jD+8ZksliTuOqaFv29SPsl/QPtZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=hRnnSdkZ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="hRnnSdkZ"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8DGB2TDwz107F;
	Tue,  2 Apr 2024 19:43:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712076194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwyCCRgw3xaKuhE1uxZhmGMrtIEPd+B5gXuytRvdC/E=;
	b=hRnnSdkZtl+OeRMrOGbo4Y8Cgb0GmbvHaPOj2UAqWxYYFVBiefOLoWOgdEWlsAU70CDFZX
	Kix/2ULO8pLC+d9v6l3+cZ3WHDtXNSl/cDjTRqUrkEOA+ZOlqFAMscy4fJyeyexxwbpvWP
	XdipwwcmATmwzPvxLFyAw/I/N8XrtaQ=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712076194; a=rsa-sha256; cv=none;
	b=GTF6jE+hhnj40CJVPSqiHOtMX5NDcglyOIzeUL9j9GavkMNQre5LCDrjjckdRZkip2ZUBQ
	BpQex7iX+oJA6ygOJOSnK3RRKmn5OZ/BpY5aTLKGos3OqJRSjTIGYdV8F9VXpX+UicZFiV
	C4pphogKq9O/KvhSFpmvDi/P92tgff4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712076194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwyCCRgw3xaKuhE1uxZhmGMrtIEPd+B5gXuytRvdC/E=;
	b=BNKzNd2IKzHzArgAfD4EwucvA7dXBHC8IMczdYQPQUA1tEHNURFY9muVsbD6+DluzXuvLi
	ODNlwz0Z17lVqCpcddOG1wJt5bHgOTG7CoUZF71267rR8RbeIC9k06+puoctF8uftpAXNL
	nVCKuEG/Y5Kkw3PJxm4FsPwRgeDVS+0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 5/8] sco-tester: add TX timestamping test
Date: Tue,  2 Apr 2024 19:43:02 +0300
Message-ID: <ac1ca4121110c68da2ed0c9ad3b6d993964b61cb.1712076170.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712076170.git.pav@iki.fi>
References: <cover.1712076170.git.pav@iki.fi>
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

