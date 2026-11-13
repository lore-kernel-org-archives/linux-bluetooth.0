Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588821;
	b=WykV+RzcVZQXNui1YSg+M8qC/BZJVnYh7sI3yJxt16eLkiYq8tuNfJ0GEwtqn7MKN3eb
	 iOO8RWXUAyWJ+2/09tbbNUd3Z6hZ5j9jJ2+WzQU7rbDO3qSdvZyefvIJLU8J3SxAT3aHy
	 Ws0X2ymuEGmjsj0IvOVr7Yajd6ic4nbc2gZwk9Ri4XzYYtK3aFFLEGo3vmsZ/xikaa1ZS
	 rIhtSXb/5zp5nTCzspvLrtZZ7Y3UAgBYXGsJH8bdGHerDPImxUkWlJ3nLXfKOZeC6Ghns
	 uzYnt+/StIlbxxXFu6EY8YkARkpa8NDHHhMym/HdCO+4n+jPty2j2PY+UF2bJc8sWIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588821;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gJ2RbXESB5NrWF1kq5b5d5yUoxdyfWBl1b67Pb3MGDg=;
	b=i1vFOkfSgC9yjjw0vY18gLYYPmDMRsiJS4N3zI/lXXMEOgxonRv3j1LGkRr1E1v295rW
	 04ovRa6joRAUL61EAF5YVwG8i+ZfpqyTr2TtV/V4A8Kzq7PmWj+z8l62xtkUTUjvfQg/4
	 4zgakKZLPXbyP4xTLVDQDUtwG5U6GtVnkMtWVF9eU2/gu1J/TYgFrbcV52819uNfb6kYB
	 p6P0D4/i8WbH2jz6JPItrm9Yj41DOU+YgbhKjLbx08PiUA99kevOesjW1be47CKlrxZjN
	 pX58LTMHOJ2Orx6flM6kYBZmYM1aEAkACJhoqSL+EAPamRaZ8PVqX9aGPZ2zt4OCS+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGUeyfpG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7585606D608
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGUeyfpG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588821;
	b=FdnZ24pCMomF5Zr/QHS512n3PRHSaMKHKLMPRrm/8D7RXRgcJauPNu0UdamrbGJFviFL
	 qLy8pS5eGa74Pg7clT6sGk6Y5+B7F29T0YASNrwJwex1Z4JCWOgspi8i0uE7IcbRkvfec
	 ucYXu2CZ2bvwftRBgZUxjEd/AKsRex6kqFUg9n4fi5ncciNYSoGOYH9NNChcMHZFy7DdB
	 ZdB+XYiT68J1GhEZkg2DPSi1bXql4lVprWi/NAl7Fb2khF+O4mCzYlX8fXRUXC7tQWjlR
	 YDl57bzOCNKZBjQv7UOofHWTkeG565GootIANZ7TnuYmGsHrKuBZaPCTWGaXeWWpkbg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588821;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=gJ2RbXESB5NrWF1kq5b5d5yUoxdyfWBl1b67Pb3MGDg=;
	b=wJhWBfa8kC3UsWVFTTpArZK+hEzxpkF1ZRO/LHGMtqDlzLHvdxIsSN0fciEb5fXIcI6s
	 tUVH4HFQVFZVwhTymRSpKyJ83nNmLoaePECSkIrIKfuNhtGE2Cxj80RoQ58FTgKNaZXow
	 QRzDSEPckJWnOj8wNBDEZvmt/CMFmtJZFw8RAqRg3iRIkMFBIMwnKWwsdxtyPRMB9/f30
	 n5Mw7f7NyidF7auU+pjAzG6zK9zLyZZZgbquTFZCzV+UlAliyYwTAOf5oonmonC04rHWD
	 OvlES0Fuwg6WLyos0/iv3bqkawja0FxP4fQF/3uZA/yze/k5gg6zqWdKEotv6JNbWMA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4C5F1F000C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588821;
	bh=gJ2RbXESB5NrWF1kq5b5d5yUoxdyfWBl1b67Pb3MGDg=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=ZGUeyfpG8DsC0LV8cr6KD4dTnsUG8B+mO6Zc/kk4yK302vF9STK+BLXI7JJskLbD1
	 4lE5gzTvKWb95Y1gITI1WKqGn2zT11puWe3YCSFmo5s699SXxc4eMUzNgKSGSR0gwS
	 D8rEPtBvqVaOcx2SkXrC5aTxvKBIchfkQ5asiK0mk0ZjyhCRuh/l5Y2UkS41aOJhDz
	 pwfQIxCD6rItk6Et9tHvtNkGCd4VJM89gtHQkNgbCMjczNNQEgsENNqUfUpdzYl8yc
	 RaTIcrId1j7w7vzoI3/Jgga+2FAtHsVLVhm8lALvZcWhBil82rYUcJl9rb6OwVvKIb
	 qnQiLfiL2ad0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6D883499F7
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:53:40 +0000 (UTC)
From: Marian Poltak via B4 Relay <devnull+marianpoltak.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 17:53:41 +0100
Subject: [PATCH bluez v2 2/2] unit/test-gatt: Add Service Changed
 registration tests
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-svc-chngd-notify-only-v2-2-e07cc198f32b@gmail.com>
References: <20261113-svc-chngd-notify-only-v2-0-e07cc198f32b@gmail.com>
In-Reply-To: <20261113-svc-chngd-notify-only-v2-0-e07cc198f32b@gmail.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588819; l=3061;
 i=marianpoltak@gmail.com; s=20261112; h=from:subject:message-id;
 bh=AWuuhQZCzmugPiIPFZIXU2E6nWv6JH4eaEXPdPqyg2A=;
 b=iBOIE7PGFkH3fEL+FXbptbVWX+c1N2pq0MxWrOVrishzteKby5qTSVojmtlOXcPg28YaQQk6J
 2it4nAw46XmDtC/YmQdohDb1TNv9apiixDoLGcMS1GTiTzoGxgLq/J9
X-Developer-Key: i=marianpoltak@gmail.com; a=ed25519;
 pk=VPxSnAMaNkyjfVbKo8tQ1gFPwqOoZoPqtVZ8znSiAiA=
X-Endpoint-Received: by B4 Relay for marianpoltak@gmail.com/20261112 with
 auth_id=1502
X-Original-From: Marian Poltak <marianpoltak@gmail.com>
Reply-To: marianpoltak@gmail.com
Content-Transfer-Encoding: 7bit

From: Marian Poltak <marianpoltak@gmail.com>

Add client tests enabling Service Changed when the characteristic
declares Indicate, and when it declares Notify only.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-gatt.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index bf6074107..06c9505fd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -303,6 +303,25 @@ struct context {
 		DESCRIPTOR_DISC_SMALL_DB
 
 
+/*
+ * GATT service (0x0001-0x0004) with a Service Changed characteristic
+ * declaring the given properties, value handle 0x0003 and a CCC at 0x0004.
+ */
+#define SVC_CHNGD_DISCOVERY_PDUS(props)					\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18),\
+		raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),	\
+		raw_pdu(0x01, 0x10, 0x05, 0x00, 0x0a),			\
+		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),	\
+		raw_pdu(0x01, 0x10, 0x01, 0x00, 0x0a),			\
+		raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x02, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),			\
+		raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x03, 0x28),	\
+		raw_pdu(0x09, 0x07, 0x02, 0x00, props, 0x03, 0x00, 0x05,\
+				0x2a),					\
+		raw_pdu(0x08, 0x03, 0x00, 0x04, 0x00, 0x03, 0x28),	\
+		raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a)
+
 #define SERVER_MTU_EXCHANGE_PDU raw_pdu(0x02, 0x17, 0x00)
 
 static bt_uuid_t uuid_16 = {
@@ -2507,6 +2526,18 @@ static const struct test_step test_notification_1 = {
 	.length = 0x03,
 };
 
+static void test_svc_chngd_register(struct context *context)
+{
+	/*
+	 * The client is reported ready once the "Service Changed" CCC write
+	 * is queued, keep the context running until the PDUs are exchanged.
+	 */
+}
+
+static const struct test_step test_svc_chngd_register_1 = {
+	.func = test_svc_chngd_register,
+};
+
 static void notification_short_cb(uint16_t value_handle,
 					const uint8_t *value, uint16_t length,
 					void *user_data)
@@ -3736,6 +3767,28 @@ int main(int argc, char *argv[])
 			raw_pdu(),
 			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
 
+	/* Service Changed with Indicate: indications are enabled */
+	define_test_client("/robustness/svc-chngd-indicate", test_client,
+			NULL, &test_svc_chngd_register_1,
+			CLIENT_INIT_PDUS,
+			SVC_CHNGD_DISCOVERY_PDUS(0x22),
+			raw_pdu(0x12, 0x04, 0x00, 0x02, 0x00),
+			raw_pdu(0x13),
+			raw_pdu());
+
+	/*
+	 * Service Changed declaring Notify only (not compliant, seen on
+	 * real devices): notifications are enabled instead of failing the
+	 * client initialization.
+	 */
+	define_test_client("/robustness/svc-chngd-notify-only", test_client,
+			NULL, &test_svc_chngd_register_1,
+			CLIENT_INIT_PDUS,
+			SVC_CHNGD_DISCOVERY_PDUS(0x12),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13),
+			raw_pdu());
+
 	define_test_server("/TP/GAN/SR/BV-01-C", test_server, ts_small_db,
 			&test_notification_server_1,
 			raw_pdu(0x03, 0x00, 0x02),

-- 
2.56.0


