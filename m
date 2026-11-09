Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239110;
	b=yhTCQKRvowZY0zbPkoN7nd9L+XEL+6geQoQD5t/1llWt92WF/Ac1udvatQ/6a9mE0AAD
	 s7ZUqIdUfFiQmjjGXpLrpJ79jWKOcMc0eHKlm69zp5w1YuunoRu3UxHPCcPujg0bQbwDz
	 WGNGvgBNLbe6hvLDY6HfD/YcAbZE+x2Md09ErKftIpWCoSXOMYe/6Ax3Yen1LyL3w2DAK
	 sLGaOmHAG3Enyaas/CEaLIZXrF+96T+GRK8+81qDQzspDxUtQ+Rov0ehEerFvo713xntG
	 CGVHiB8kNCM+g9o3SNMMG+PKhTRu07qU2NqRhI9LBnMtMxFWVHt1fbH2w/0MM60DWGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e8NUlUCZtgMyj5zmfD4IvdtHvsUHwHOEX9khVD0ox/o=;
	b=qzdAvYht35Jd/YrU8nkyFWgUXy9Ti1i4PUAPdqs2ok5b8Fp3ixjE670sdNeQRp1uq8oM
	 RbZzFSvqqlxRy6YCH1YEjHPQLfznG+Y9QRxYNQEpI9uNT7PEqoiB9K0yw6nJjanQ50hJ4
	 va2/WRn+FUH/yob8dM/8JAdgXQdmENN7LNzCp2wkBMdz8TMqHyItN2vNpv/RE+dE0KRIl
	 tWnUqWwQEWqJ77NVkeJdIDQblyiwwClJG2El2rr5Hnoq0BKkH2Bqopxxg52UnEdjWVAu0
	 DRmvhQ7X+pxXvIi2L+0whOrVYzb9r75pGtSzDFu6DxHXVw9y641OiTZDYe6flFhHrKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wvf51Y0C;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA6606EEA4
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DEA6606EEA4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wvf51Y0C
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso511898137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239109; x=1794843909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e8NUlUCZtgMyj5zmfD4IvdtHvsUHwHOEX9khVD0ox/o=;
        b=Wvf51Y0C/zdsvY73XNJ9ygYrCith1WpzyF3yMPoQyshro9iDCB4tlvTcztWOHOL4MT
         nG8e2OTTPkkk/dnLMJyGnRKN13tnxMkFa+UciMBhWlwp1MNtgDPyhMBjCr7eCwS77obG
         JWPQj2nydrnxeiyTLRlow2Pj3XgHLiHw4Ud7pMGs5u3cTnBaB+Pq9f7VpJlzTuCMhH9B
         SnthM34zJNo4l3S2mK6zLTpk19F9IJtV7lsXyv1are/G6pm3QRC8DrmugObb0jtrSjTx
         y/xZ8tQZHAOiVphBg5oBuAjLM2IA1cKqRcdKefjGHyLg7++uTT37x3V08b4VxepiwCJ1
         H8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239109; x=1794843909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e8NUlUCZtgMyj5zmfD4IvdtHvsUHwHOEX9khVD0ox/o=;
        b=1Jg8j6Y+HByYKluS8moZRRuoEupxEHxryFOBIzNadJggzQtDpK7qAVzCtNAGl0vs1v
         DPLaSk/hFQ5At1SWfRav6lBKhy5qw5W9jthbDkwvu+gfFAfa5vxvofekAo5isAMibPJt
         9qJGVXnkniwTCyAiFH+8FpkQm2blFFlRB2zhQCMZc2+JPLRXBksSa/82H/qfP2aSPEwG
         o1ePqRt2EfxBvB7ok68asJORCgk7CsV13EVTFFFL/um0Fo96WwDHu0sjlbQ1NsQ7MYbf
         5iYmSJTvlILsQ8r1M1LSj3QqK2Y+GjFDzXWaYjPyUo/ZL2ReUp1FXiIoKFMvyPa7gJuU
         UXBg==
X-Gm-Message-State: APuU4Z9aEun7qafmigMzUfVEQIp5ljwB7vPPcpK3Eot8UmycDUuuq8Yk
	pPsauGniGJcXqJqLcxWDqm7VV38FHOq8BOvJaHCx/RrNqhk0hn9Z2SZSK9kUMw==
X-Gm-Gg: AYBFou27/tUHUGrHb8q2aZ0mGr+RScmfTuBXdpEutD1+BkguaZR/pBWt4QW9KbG78st
	JdCBWqcO0IEnQyW0k/5apRoPMTXSbx6VHGZGFPb4kXhNXvIgEVKBYL1ZlH03Fm2M8V2RN3M0JXA
	J9ISUU4SBNFef18SRHOqB7Yjp7MV545woUbWygGR3MhIKpy2Jfm9Sldr8J2m+SiA1e694zg9P5f
	gLf1U+8lwK1jHUgdqY20W+16GOGHSUAilxAfpr3wewXXidzOkhCgY2bz8Bq6IEQAKQxnhyu5c37
	QaQC+tulURpQavnt5qqUGpxcEFHBo0cpqjT3JwvcG6KGbHCc/DZAwKPUxPCyiFmbUdWCS/EaNOp
	hjVV3Zb+04CjFuivsifvMexmydrcf4YldR3rb5QAWRT2EnfuRl0/R/d78x6/HsQaplXVIIOz04w
	U4RU5L1UK9rveQ9fe5alQN7C298CLU3Y6jBsIfpQQok3W7lyUZqRTkXLt4+BOH/ebyY4Xza89Av
	QBW9Rs6II2DB2P2HSqMXhcUV8ZOlv7+30cB8gw74epEE9xoWTO7dsC6YuWs7GG99D1e1aLeYsf4
	WhCAM0iMBzsvNRg02k3hwUz9bIeE1eQGxZvIK9XfdfclGO4X25xgUJ68Nh+BybBFDU7ZVZSZzao
	es9NMphwZIiBGVcMMm9MpJT5gUaK1ziJiwYgDWdFAq+Ar6mt+RosZAgqwVyGzfg/eTho6ghiDId
	04D+M=
X-Received: by 2002:a05:6102:84c2:b0:7a7:b6a:b022 with SMTP id ada2fe7eead31-7d2db21312emr1243290137.22.1794239109434;
        Mon, 09 Nov 2026 07:45:09 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 06/10] shared/gatt-server: Fix authorize callback getting handle 0 on write
Date: Mon,  9 Nov 2026 10:44:57 -0500
Message-ID: <20261109154501.1362649-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109154501.1362649-1-luiz.dentz@gmail.com>
References: <20261109154501.1362649-1-luiz.dentz@gmail.com>
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

write_cb called authorize_req before decoding the handle from the PDU,
so the authorize callback always saw handle 0 for Write Request, Write
Command and Signed Write Command.

Decode the handle first and add a test checking the handle that is
passed to the callback.

Fixes: 291e9a0d8e6e ("shared/gatt-server: Add bt_gatt_server_set_authorize")
Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/gatt-server.c |  4 +---
 unit/test-gatt.c         | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 6796817bf324..b63745c4df2e 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -838,7 +838,7 @@ static void write_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 	struct async_write_op *op = NULL;
 	uint8_t ecode;
 
-	if (iov.iov_len < sizeof(handle)) {
+	if (!util_iov_pull_le16(&iov, &handle)) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
 		goto error;
 	}
@@ -847,8 +847,6 @@ static void write_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 	if (ecode)
 		goto error;
 
-	util_iov_pull_le16(&iov, &handle);
-
 	attr = gatt_db_get_attribute(server->db, handle);
 	if (!attr) {
 		ecode = BT_ATT_ERROR_INVALID_HANDLE;
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index ad8e95453be2..bf60741077c5 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2008,7 +2008,7 @@ static void test_client(gconstpointer data)
 	create_context(512, data);
 }
 
-static void test_server(gconstpointer data)
+static struct context *create_server_context(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
 	ssize_t len;
@@ -2021,8 +2021,38 @@ static void test_server(gconstpointer data)
 	tester_monitor('<', 0x0004, 0x0000, pdu.data, len);
 
 	g_free(pdu.data);
+
+	return context;
+}
+
+static void test_server(gconstpointer data)
+{
+	create_server_context(data);
 }
 
+static uint8_t server_authorize_cb(struct bt_att *att, uint8_t opcode,
+					uint16_t handle, void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
+
+	g_assert_cmpint(handle, ==, step->handle);
+
+	return 0;
+}
+
+static void test_server_authorize(gconstpointer data)
+{
+	struct context *context = create_server_context(data);
+
+	g_assert(bt_gatt_server_set_authorize(context->server,
+						server_authorize_cb, context));
+}
+
+static const struct test_step test_server_authorize_1 = {
+	.handle = 0x0004,
+};
+
 static void test_search_primary(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
@@ -5038,6 +5068,13 @@ int main(int argc, char *argv[])
 			raw_pdu(0x23, 0x03, 0x00, 0x09, 0x00, 0x01, 0x02,
 				0x03));
 
+	define_test_server("/robustness/write-authorize-handle",
+			test_server_authorize, ts_small_db,
+			&test_server_authorize_1,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13));
+
 	define_test_server("/robustness/read-by-grp-type-malformed",
 			test_server, ts_small_db, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-- 
2.56.0

