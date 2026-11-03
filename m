Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737823;
	b=FkYQqgdNuRMqBPTvyHl7Hg2DfNrTRYEy2D2dl5yKEdAkFTTV8Q7e0NxyfXCac0BWMVgB
	 +rAyJrSGKxAXjvBuaVM3C7QrwpAgomOJ5S/jiOWChtnSqnAGoZBbGcHJoRnkb/MeJwkvU
	 bNNFXFMqOkuGT36eAHp4PQf0u95PXTV09NGsrqiNxtklBOVnvESIYnss/nrAJVL/d7pUn
	 h+rTk5dAhqWxDfor2LHS9h+1om9wxJvsGJ31p+4BtOxgpBUMDVTloV/xRhQiAVT0LTkkj
	 SuTey819ao12pHXqCVjUeZftMpgYZSdF9qyT6GfbeNvz3KGCH/upME8CnXVSsazjL1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xqd4lphDTwt4DmTORMK4Ti/4GqTuyXzNgZSTKQf2E5I=;
	b=zXdfo7PjWKTYiDLZbN0liAF251fC5i+HWdN0rDks65AmIQ6QFy28/w8S2c7c2Qt/3jDf
	 jKS43V+8o137z8S8fHbjloQEffcPDtzi/UXDLvfoKDd6UqX9C85YOUjy8Z/q9bZGL9zg1
	 y1uXiFLASBMyJC2VsB3huY5xTAxCxe+bgBY1um1y2tt/23K/WJHzCm25nNybfWBhQr30z
	 FC7342eKg5vnNGUsZKYFST1GlJGqYE0YRG/fb/EEKpKhk/VbttxLaVeFTRx71EBIX5xl5
	 fmFOmErlXX0IFit1liByFJejCGd4KG6lDxFc0zTBhXG5GJmXzTxWkqqEEh9how9ax+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKTgLAys;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBD606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DABBD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKTgLAys
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so1274467137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737822; x=1794342622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xqd4lphDTwt4DmTORMK4Ti/4GqTuyXzNgZSTKQf2E5I=;
        b=qKTgLAysrnrKEMklat5SY1epOU8EipFlKLJt+p0dRC0FY7aUtmkgrBdEb3iebj4z7D
         GfRfv5zKfkyxD3U+rpIGIXWQdoiypX9mqqslQQ6dD/+QXENQc8U+XznqLaIOtTwvfCf5
         cxE9i4Dzd3SvtTpNRk00wP0ee8IH9PFIMtX6LPsvCHXSCexBFrexgkecZmv6s9pER2Ak
         /ubWp/K+nH+hhAUXqsMukO8oUyIj83nxi5UDoqH3RKn4e2Lp4OtgqH2uOlT3eVEyLHlC
         g36bulFr9RXCnP13hzMjns4Sm/sSspVqVL/Na7+aWc4chJElOnM6qNO+f/fjFudLYzrd
         xNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737822; x=1794342622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Xqd4lphDTwt4DmTORMK4Ti/4GqTuyXzNgZSTKQf2E5I=;
        b=qL4YGx6ABBpeUEtBj5NmNbHW1N01isiTIohFTllQZLpXj9xTpCtXVt7Ij/WLi86Jtf
         S8z6Ke4V5ZOUqSyCu6JydtIVC/bCwo1RoOn1Mr3iJQXQCzQYH81U3Feotydpych1ihQp
         IXfRDJ80letke8LNuqBstlelToQjpyskuRd4/YeXXkA5U0fu0YmV4aujDOPOZ0N+A17a
         4x8RVxksqjCfw4f/OwmvR7pDiguo/XnCGxC34QGDYSSd66Hv45nJk2j87HfdJe7XNsWU
         gQr3Juog6h1BXCPKzJsnJoQV0v29gedKA0gAWY1DroVg4QQ6w7dx6CkosNpDVukVE2qM
         bavg==
X-Gm-Message-State: APuU4Z+W0ucHc70a3Z3IFJyhW/Zbm0W+n1mD49EBkQOaOHBzV+wTSrnn
	Iu7vY+ElR3DhZMPi7vfz6Dvngf4mYFNxt4lbbM0IlPUYNpdsOmuvleFg+QCw7w==
X-Gm-Gg: AYBFou1RIgrCyu8aF802y0S6fDDfn/JyVxadh7qnqpFhJEFUoFFgkaU7Dw6dIXhTmEu
	lHgLjh1/67xqiOVSKwSSBZM9rZ3meCLVrxyEK8X3OccUKj9vBWPbEWGJJhYxqvBOiD1lv4wvJAf
	zfrJGXocZXYTktlUU1ZdqKdZtTpShRZsFwdLV5fZd1l76S2u4yg9bUwPHOsUeIvtD+2oht6hE8H
	AAcNLStWV9pSgXW6i3fG8e32QruwpHisP07EJ23d9hcPIBwiBIJbT75Xt+4rX+nttUf5Fji+SNN
	qmze/DqrwwGwa6XbBwYNQ3/h/foZwtgL/EwcNcpLflWaFShWO2mA0t4UuuNZts9jAmiNCfXSLFl
	sp+INJoVMiXnVvbCjW9PEdTs4uE9P8JHDcjE1Eoz7rVqcs9BRJL1hOd+ZsopJq8nrgOgv5Shu1/
	cHiz5I0+Vqk97Jr2VS9JC+OehMpU7M8dsrpXgaXWw9QPu+csQf1bCZboG4cvF3nPqcNxHNWL9XW
	0HzWJHvCZrf0XOUOjhrZdrf+FdSTpZC3AC6oWYVt0ka7otu3lFoIcccT72dfVT62fAJL93DzTEo
	Pi3WKIR21xp0d4Fbmd88sIrXdX6fJP7AJ4sL7WthQxqX4t9y4LfjMvjmqCbW6X7BcW+t43VJ4BF
	C2DOsdU1uP4/XrPD5w/lzYIzHPYzbcv38XlQXG8kjY9M+EUul1J8fXupAkgbLdSYKFpsw9s9mu6
	K6FivmbszYbZL5wruHU5H15uVQ
X-Received: by 2002:a05:6102:3706:b0:7c3:9b0c:a75 with SMTP id ada2fe7eead31-7d0725ceb28mr4658959137.12.1793737821596;
        Tue, 03 Nov 2026 12:30:21 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm139916241.8.2026.11.03.12.30.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 7/7] unit/test-bap: Run unicast tests with Notify Multiple
Date: Tue,  3 Nov 2026 15:30:09 -0500
Message-ID: <20261103203011.3904290-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203011.3904290-1-luiz.dentz@gmail.com>
References: <20261103203011.3904290-1-luiz.dentz@gmail.com>
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

This runs each unicast test a second time with Notify Multiple, both as
server and as client, using the same test data: each chain of
notifications is given an alternative with them sent as Handle Value
Multiple Notification, which is the one selected for these tests.
---
 unit/test-bap.c | 185 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 168 insertions(+), 17 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 8b091a5f640d..99c5ae92e447 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -95,6 +95,10 @@ struct test_data {
 	size_t iovcnt;
 	struct iovec *iov;
 	int fds[8][2];
+	bool mnotify;
+	struct iovec *alt_iov;
+	size_t alt_iovcnt;
+	struct queue *alt_pdus;
 	unsigned int enable_ids[2];
 	struct bt_bap_stream *cancelled;
 	unsigned int enabled;
@@ -132,24 +136,169 @@ static struct bt_bap_pac_qos lc3_qos = {
 
 #define iov_data(args...) ((const struct iovec[]) { args })
 
+/* Unicast tests are also run with Notify Multiple, using the same test data
+ * with the notifications sent as Handle Value Multiple Notification as
+ * alternative.
+ */
 #define define_test(name, setup, function, _cfg, args...)		\
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data data;			\
-		data.caps = &lc3_caps;				\
-		data.qos = &lc3_qos;				\
-		data.cfg = _cfg;				\
-		if (data.cfg && data.cfg->pac_caps)		\
-			data.caps = data.cfg->pac_caps;		\
-		if (data.cfg && data.cfg->pac_qos)		\
-			data.qos = data.cfg->pac_qos;		\
-		data.iovcnt = ARRAY_SIZE(iov);			\
-		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov));	\
-		data.streams = queue_new(); \
-		tester_add(name, &data, setup, function,	\
-				test_teardown);			\
+		static struct test_data data_mnotify;		\
+		test_add(&data, name, setup, function, _cfg,	\
+				iov, ARRAY_SIZE(iov), false);	\
+		if (setup == test_setup_server ||		\
+				setup == test_setup)		\
+			test_add(&data_mnotify, name, setup,	\
+					function, _cfg, iov,	\
+					ARRAY_SIZE(iov), true);	\
 	} while (0)
 
+static void test_setup_server(const void *user_data);
+static void test_setup(const void *user_data);
+static void test_teardown(const void *user_data);
+
+#define ATT_MTU			64
+#define ATT_OP_NFY		0x1b
+#define ATT_OP_NFY_MULT		0x23
+
+static const struct iovec iov_null = IOV_NULL;
+static const struct iovec iov_alt = IOV_ALT;
+static const struct iovec iov_alt_or = IOV_ALT_OR;
+static const struct iovec iov_alt_end = IOV_ALT_END;
+
+static bool iov_is_nfy(const struct iovec *iov)
+{
+	return iov->iov_base && iov->iov_len >= 3 &&
+			((uint8_t *)iov->iov_base)[0] == ATT_OP_NFY;
+}
+
+static void mnotify_pdu_free(void *data)
+{
+	struct iovec *pdu = data;
+
+	free(pdu->iov_base);
+	free(pdu);
+}
+
+static struct iovec *mnotify_pdu_new(struct test_data *data)
+{
+	struct iovec *pdu = new0(struct iovec, 1);
+
+	pdu->iov_base = malloc(ATT_MTU);
+	util_iov_push_u8(pdu, ATT_OP_NFY_MULT);
+	queue_push_tail(data->alt_pdus, pdu);
+
+	return pdu;
+}
+
+static void mnotify_push(struct test_data *data, const struct iovec *iov)
+{
+	data->alt_iov[data->alt_iovcnt++] = *iov;
+}
+
+/* Add each chain of notifications, i.e. notifications separated by
+ * IOV_NULL, with the alternative of sending them as Handle Value Multiple
+ * Notifications:
+ *
+ * IOV_ALT, <notifications>, IOV_ALT_OR, <multiple notifications>,
+ * IOV_ALT_END
+ */
+static void test_setup_mnotify(struct test_data *data)
+{
+	size_t i, j, k;
+
+	data->alt_pdus = queue_new();
+	data->alt_iov = new0(struct iovec, data->iovcnt * 5);
+	data->alt_iovcnt = 0;
+
+	for (i = 0; i < data->iovcnt; i = j + 1) {
+		struct iovec *pdu;
+
+		if (!iov_is_nfy(&data->iov[i])) {
+			j = i;
+			mnotify_push(data, &data->iov[i]);
+			continue;
+		}
+
+		/* Find the end of the chain */
+		for (j = i; j + 2 < data->iovcnt; j += 2) {
+			if (data->iov[j + 1].iov_base ||
+					!iov_is_nfy(&data->iov[j + 2]))
+				break;
+		}
+
+		mnotify_push(data, &iov_alt);
+
+		for (k = i; k <= j; k++)
+			mnotify_push(data, &data->iov[k]);
+
+		mnotify_push(data, &iov_alt_or);
+
+		pdu = mnotify_pdu_new(data);
+
+		for (k = i; k <= j; k += 2) {
+			const struct iovec *nfy = &data->iov[k];
+			size_t len = nfy->iov_len - 3;
+
+			/* Start a new PDU if it doesn't fit in the MTU */
+			if (pdu->iov_len > 1 &&
+					pdu->iov_len + 4 + len > ATT_MTU) {
+				mnotify_push(data, pdu);
+				mnotify_push(data, &iov_null);
+				pdu = mnotify_pdu_new(data);
+			}
+
+			/* Handle */
+			util_iov_push_mem(pdu, 2, nfy->iov_base + 1);
+			util_iov_push_le16(pdu, len);
+			util_iov_push_mem(pdu, len, nfy->iov_base + 3);
+		}
+
+		mnotify_push(data, pdu);
+		mnotify_push(data, &iov_alt_end);
+	}
+}
+
+static void test_add(struct test_data *data, const char *name,
+			tester_data_func_t setup, tester_data_func_t function,
+			struct test_config *cfg, const struct iovec *iov,
+			size_t iovcnt, bool mnotify)
+{
+	char mname[256];
+
+	data->caps = &lc3_caps;
+	data->qos = &lc3_qos;
+	data->cfg = cfg;
+	if (cfg && cfg->pac_caps)
+		data->caps = cfg->pac_caps;
+	if (cfg && cfg->pac_qos)
+		data->qos = cfg->pac_qos;
+	data->iovcnt = iovcnt;
+	data->iov = util_iov_dup(iov, iovcnt);
+	data->streams = queue_new();
+	data->mnotify = mnotify;
+
+	if (mnotify) {
+		test_setup_mnotify(data);
+		snprintf(mname, sizeof(mname), "%s (Notify Multiple)", name);
+		name = mname;
+	}
+
+	tester_add(name, data, setup, function, test_teardown);
+}
+
+static struct io *test_setup_iov(struct test_data *data)
+{
+	if (!data->mnotify)
+		return tester_setup_io(data->iov, data->iovcnt);
+
+	/* Use the Handle Value Multiple Notification alternative */
+	tester_io_set_alt(1);
+
+	return tester_setup_io(data->alt_iov, data->alt_iovcnt);
+}
+
 static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 {
 	if (!success)
@@ -670,7 +819,7 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 
 	if (!bt_gatt_server_send_notification(data->server,
 			handle, value, len,
-			data->cfg ? data->cfg->mnotify : false))
+			data->mnotify || (data->cfg && data->cfg->mnotify)))
 		tester_debug("%s: Failed to send notification", __func__);
 }
 
@@ -942,7 +1091,7 @@ static void test_client(const void *user_data)
 	struct test_data *data = (void *)user_data;
 	struct io *io;
 
-	io = tester_setup_io(data->iov, data->iovcnt);
+	io = test_setup_iov(data);
 	g_assert(io);
 
 	tester_io_set_complete_func(test_complete_cb);
@@ -1141,6 +1290,8 @@ static void test_teardown(const void *user_data)
 	bt_bap_unref(data->bap);
 	bt_gatt_client_unref(data->client);
 	util_iov_free(data->iov, data->iovcnt);
+	free(data->alt_iov);
+	queue_destroy(data->alt_pdus, mnotify_pdu_free);
 
 	util_iov_free(data->base, 1);
 
@@ -1499,7 +1650,7 @@ static void test_server(const void *user_data)
 	struct test_data *data = (void *)user_data;
 	struct io *io;
 
-	io = tester_setup_io(data->iov, data->iovcnt);
+	io = test_setup_iov(data);
 	g_assert(io);
 
 	tester_io_set_complete_func(test_complete_cb);
@@ -1530,7 +1681,7 @@ static void test_server_state(const void *user_data)
 	struct test_data *data = (void *)user_data;
 	struct io *io;
 
-	io = tester_setup_io(data->iov, data->iovcnt);
+	io = test_setup_iov(data);
 	g_assert(io);
 
 	tester_io_set_complete_func(test_complete_cb);
@@ -10406,7 +10557,7 @@ static void test_select(const void *user_data)
 
 	data->id = 0;
 
-	io = tester_setup_io(data->iov, data->iovcnt);
+	io = test_setup_iov(data);
 	g_assert(io);
 
 	tester_io_set_complete_func(NULL);
-- 
2.56.0

