Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794505254;
	b=Il4zCZusTthQOs1xGqb/11jFVxXIJZtLZIP8C6nDsNgYoWpsspv2N0+BN0f6WMyvwH+w
	 JO6gNW5twInKeGqpld5AuFzwdEjwwYot+QZ+mhndgZzDyYvc6bQIZs6v6aU7ekEVhAbKE
	 UfbGcSPWbXE0DAeIiMPS7TBWFIsPG2/buh1MwS/rB19k1ET8PCrXiHnnGOipYMakyCsUA
	 GmZW4Y4LlyqPbc27Dwp7nOSP2UX4KOoAcwy27WpOsgSiBtdKfLdbNyv/0546QsSniUfZ/
	 PJsXP6dTfLNwhPapoF5lZbCYuSAOapPI3PQ9/BEJNOb30kunSHm3JxqZyeEKF3n7LNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505254;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kbE8iti45RK/FYFU+7UQy9IHe6ypSi0fDvGXESoMAo4=;
	b=vaLXJbFeloMJJjACoy9OX63dB4CrB684KJnMFsIhcllDMWHbl+F4MgIiq1O0vK92WGU2
	 /jNlBIVp+uxoOkzGYxAVHubuZnnqc5I3vvz5iyFPBF8970+FujDX6NTsjlje3Y55Q6nWH
	 MSFkcxbKy26yvorQDQ71UK9V6q5IbqlwSgGkQ0OfHFeI+wewVfeqh5O2ji2NeA7tSCYEh
	 4sNPxQr42RwEYonxg/CULMpY2bJ8Fg09sPyriHwdGxpEt1GpGBAyg0BD8XClmrkZwRq1i
	 IzjtjwSl79otzeM72ISr4cyPVqfqm4oslS5nmBkfXEx/yZZlGNfffREP9qGwl3He1MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmwXKa3W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75017606A218
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmwXKa3W
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794505254;
	b=gwN+Z43fhlhg+q2IKD+LdTbIJrBVivJFYJbnZyatiB4zX+S8CT0qQtyhVDqN4L2ukrx/
	 H5tg+RFQK5d7Fg4W2U4mLXIfMU4fAsO3fsWZVZ3hB36q6Nml/hIwBSlPSprO6Ljf29Ks5
	 1RN8ZhkeszzLLKrtzIbT1fTJtttHOZM2LxYdMlH/xgef9CQSmhScQIaoFFLSHBXdg9kad
	 FMPL1eUzChhK75MTsz1+gLHBD5FWncI0sR9CTI3OQrhiv6b6gAbLyKn6vetyxUc9qct3l
	 pKSYpQLrhfLrQSEeE8F69ImT3eNjx98w3u5mylrSh+VejybyCmx1bki6VGJDWqb+BPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794505254;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=kbE8iti45RK/FYFU+7UQy9IHe6ypSi0fDvGXESoMAo4=;
	b=kSo3Mk9EwLhSGEZp9wj95sPyOqnciq/tLxBrAAARLAMAM012o6O+tfvHjXKr2khoL13l
	 hjgWtyXA708utiD7FkjynvH/qZBHChiBezsQJHNcBafA6CAmVB7+3+he6rIQ4UmuteQub
	 1s4314XdMpDxz04wgaNvDupUDmLN+8jsAjmd19i1RRJVqGTPuV7xHk49af/TKqh/2faG9
	 aFtqojXZ8oMwlGDFgffUlyGcMqLJlGOdUcMCgptR6slFmxqNKuS6gzoDPfvaZBa4N7dkc
	 dqw0saEAOfXhts7nWfrR2cwOrYZywz9AfZBTqN9ByX44BijLULTvIszYaVv7ex+SFHA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 87E591F000C6
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505254;
	bh=kbE8iti45RK/FYFU+7UQy9IHe6ypSi0fDvGXESoMAo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=DmwXKa3WbkAG6ydizWDnazmLaDYgIjTIJbqvM7xpN8mIOWoMCZcBXr+VuAAMEFiED
	 xiG3WGzl2xYGRiSttdjLR6QHtqsI9zAhWbnNp/4R5C19wfdjr9yiwFMwfbwD3KrPvq
	 fZB6P7jP0fPYxm7HljNkM2JhGggM37XmAYPcLL92IYiqkXyvREdgj8j+7TNNYGO8nD
	 KjluGTYgxfWHbVR+cdyYN9+OwznXdhaC8A9CJcjOqmfAwmpKRQlktHSQinDZ1RCn0F
	 NFchZOys09TQXz4FENv2VqvPk0t/wDgYGZt/mdmwHYZe/3trWjouCC0ZxtkimB2abN
	 X+OQN6soTAXYA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1A3EE4746F
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:53 +0000 (UTC)
From: Marian Poltak via B4 Relay <devnull+marianpoltak.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 18:40:54 +0100
Subject: [PATCH bluez 2/2] unit/test-gatt: Add Service Changed registration
 tests
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
Message-Id: <20261112-svc-chngd-notify-only-v1-2-c7db7ac47acf@gmail.com>
References: <20261112-svc-chngd-notify-only-v1-0-c7db7ac47acf@gmail.com>
In-Reply-To: <20261112-svc-chngd-notify-only-v1-0-c7db7ac47acf@gmail.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794505252; l=2400;
 i=marianpoltak@gmail.com; s=20261112; h=from:subject:message-id;
 bh=XK5mcZb3G2ELsrp0b6wGWcIGxQMIVDa+IEfTDoVdkJ4=;
 b=fBnyIyAvPzE8qHNURWtPhqm+RBa5se+7agNZkZ4Nsytak5IKgbKsrwBZvDEA5N959cEd+0Ody
 4c00wy/Z1MTA057XFk3TfIl3N0HfuWiPyzJi3xrfbabLNvPWMf2x43U
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
 unit/test-gatt.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index bf6074107..45a257ad1 100644
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
@@ -3736,6 +3755,26 @@ int main(int argc, char *argv[])
 			raw_pdu(),
 			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
 
+	/* Service Changed with Indicate: indications are enabled */
+	define_test_client("/robustness/svc-chngd-indicate", test_client,
+			NULL, NULL,
+			CLIENT_INIT_PDUS,
+			SVC_CHNGD_DISCOVERY_PDUS(0x22),
+			raw_pdu(0x12, 0x04, 0x00, 0x02, 0x00),
+			raw_pdu(0x13));
+
+	/*
+	 * Service Changed declaring Notify only (not compliant, seen on
+	 * real devices): notifications are enabled instead of failing the
+	 * client initialization.
+	 */
+	define_test_client("/robustness/svc-chngd-notify-only", test_client,
+			NULL, NULL,
+			CLIENT_INIT_PDUS,
+			SVC_CHNGD_DISCOVERY_PDUS(0x12),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
+			raw_pdu(0x13));
+
 	define_test_server("/TP/GAN/SR/BV-01-C", test_server, ts_small_db,
 			&test_notification_server_1,
 			raw_pdu(0x03, 0x00, 0x02),

-- 
2.56.0


