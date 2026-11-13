Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588821;
	b=VVMdKt2hDxWMhvyyo4mkCFocyj8K0Yh6N3evT5icX2Gg64cJknO3NT7XZ6kZgWNXWPNI
	 1Qc3cD7Ny83z6dv6GPb9s140ihCtGhyUezKOLRklGzs9H/ngJBQ49v6MXlP8xc8cDxg0x
	 g7rFnBXMLQDz4RZrGrAewxHkYHgWMp/xXGm1gN9ixlrAKx0q0OdHemBQubv9qTcIuiF5E
	 hjIM6bCUDLVe+oUeAk+mW11B6UYVV92Zfqk1y3yBzQnOKR6cLr94QLdzqANLlI83rFwmz
	 kTv7vTGm7aJYy/osA0niza14a/n1myJ/0S4bCOBCoW3gG1/T0BVJtdXpPH/K3A8zi3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588821;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LBbzLDMi3tUpJWb9FAQ+FK8k0XDL0E1xorOpMlHneUs=;
	b=3EKkyO33r1eaZA+wfJYWyUayHNddFX1Vaf0WXPlNQ1jISF71fWhqN3MIJBlsHJuLaXKu
	 XH5mzXtaLPreFBdNS1m0Iovr0rK33CghVYnl3jwcCKBH8EKXWbdsaqLAe9MpqUtv8mm0X
	 0hE86Blr4ZyCtF+vSBvNRo+2SQ6sM6XetBhMIfEspLCjY+LBMFeJEWcwlG1Gkq6iqh7RF
	 5y2NBQ6cbTt5Ym9yD46hkDW9l71Y14tAD1VqpUt+8C1fUhdvJMiXVnngOmnUxy3yEyP89
	 0R+NwIu/GuNQP+3LTfbpmh12HKjL0GTqenoWT0aJZBgq+AOSM3wRBOy1yHSOVHcRJ+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nS/PqsEf";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2516606D602
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nS/PqsEf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588821;
	b=q+whi2r4ov6yviWJxUmGDFnzbPJdiu+ZwF6OWMC9KLSalhkg+UQx3QZB35Zvi3PoQ9TF
	 enIYSU5E+MsE4e6EleV7IhE/Shm3TMpTkPDOpfF9ttt3cIAU4ZnRegdo8gmZaAWbbmJCt
	 tMGx7jzs/3Y5mbNri0iwZQEh9d4LmrbNuktCdjlAYapbHl78RX/ZRfnFmPTCtCVXOv1s0
	 CKXWUmBqiilr95bEVTmIS9Gx/rmS1UzQJMjujyKD4FBS+JFs0uOjjAYC8WZm89JWepFjl
	 MuvtntvzahAkGiRzkSyjyDqwG7V/o9xCkaaxwFxgD/elg8H/0RszkFc8f1Z9E3OaoBg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588821;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=LBbzLDMi3tUpJWb9FAQ+FK8k0XDL0E1xorOpMlHneUs=;
	b=buGO0F2cxQgKfkJHPNqoPNVzXyl+pd6+qqjy2a/tEXKV1mgXuQXuA2yxB9hpgjsmHRFg
	 UBXEVDlGbEwXbbetB/fHeqXFu277n8horUXhiTrVjqyrJw9J4cgE3y1PXecj2nfuo7r97
	 XL6WvrpaaudaMfXAEKbzFRbVgW5I2KsuxX2WvaDbF9I1Joho1mkglbbKiYPgeSAmDjhfJ
	 eokZK+oM4kkD+Lc5yVXuzg9M4I7YeHYVOwtN27cQDB/s0NNEn5sKINEJXLjSuHBIoyzwM
	 Mepx6DWymz9UtolQmc+QSYeLrDr/JmUXmSJOqN3MdlnLg5MPX2N3p9QwtxE/45QeV0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DBFF21F000C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588821;
	bh=LBbzLDMi3tUpJWb9FAQ+FK8k0XDL0E1xorOpMlHneUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=nS/PqsEf3zUlaZp+SyltH3SZPn4RJEO2h9mg9wrCnURfKerNz7Pw+KYJ68paYg38P
	 /frOtPs7nxQXf6P2LLb3LEotZK5HvSM+b+DwYSCtflLIdFOP8snky5Mlz28+WioRhl
	 sENSJ1W9YCZcGbenAJsIo/Wk8CqL1Fxy98NY3YyGrYVvIOfXDSHTSre15NJXT90F7N
	 +OrkToJ9M3B08zqexef8cctKE9ziMpCOaCWNthG/n0UZtwc6dr485Qv1ZHR7pCbldR
	 VKi7DyUMJ7v7vJJ0KrFO1XBfn89kEZVPIUllmrK4VXWFjgtrcKnZ4YKtImohn9092r
	 IpgPR8h8AnplQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5BEAD499FB
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:53:40 +0000 (UTC)
From: Marian Poltak via B4 Relay <devnull+marianpoltak.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 17:53:40 +0100
Subject: [PATCH bluez v2 1/2] shared/gatt-client: Fix init when Service
 Changed lacks Indicate
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
Message-Id: <20261113-svc-chngd-notify-only-v2-1-e07cc198f32b@gmail.com>
References: <20261113-svc-chngd-notify-only-v2-0-e07cc198f32b@gmail.com>
In-Reply-To: <20261113-svc-chngd-notify-only-v2-0-e07cc198f32b@gmail.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588819; l=2178;
 i=marianpoltak@gmail.com; s=20261112; h=from:subject:message-id;
 bh=1/TTqObs78ywj9niQGB3b4pnlfDX7RjHY1NjRlkW48Q=;
 b=YhT2CvZTV1HFWzD1xmJFdXb2XhFWwwJ/gg0jZmbcXGPSDww0BbPWBR+ktmzaipSCVVWyVi60o
 HPR+cK1f7UVCGuvB39gzMFEIZNBhgE8pWjfSm28YpRV8xTasu2jsTiv
X-Developer-Key: i=marianpoltak@gmail.com; a=ed25519;
 pk=VPxSnAMaNkyjfVbKo8tQ1gFPwqOoZoPqtVZ8znSiAiA=
X-Endpoint-Received: by B4 Relay for marianpoltak@gmail.com/20261112 with
 auth_id=1502
X-Original-From: Marian Poltak <marianpoltak@gmail.com>
Reply-To: marianpoltak@gmail.com
Content-Transfer-Encoding: 7bit

From: Marian Poltak <marianpoltak@gmail.com>

register_service_changed() requests indications explicitly and
register_notify() rejects this when the characteristic does not declare
the Indicate property. Some devices, e.g. the Aqara Presence Sensor P2
in Matter commissioning mode, declare Service Changed as Read | Notify
only, so the client initialization fails and no services are exported,
although ServicesResolved is set.

Request indications only when they are supported, and otherwise pick
the CCC value from the properties as before.

Fixes: 52fdca35b8e7 ("shared/gatt-client: Allow registering notify with explicit CCC value")
Assisted-by: Claude:claude-opus-5-5
---
 src/shared/gatt-client.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7bebc50dc..ea9f7167c 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1887,6 +1887,8 @@ static bool register_service_changed(struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
 	struct gatt_db_attribute *attr = NULL;
+	uint8_t properties;
+	uint16_t ccc_value = 0;
 
 	bt_uuid16_create(&uuid, SVC_CHNGD_UUID);
 
@@ -1898,6 +1900,17 @@ static bool register_service_changed(struct bt_gatt_client *client)
 	if (!attr)
 		return true;
 
+	/*
+	 * "Service Changed" shall be indicated, but some devices only
+	 * declare the notify property. Request indications only when they
+	 * are supported, otherwise let register_notify() pick the CCC value
+	 * from the properties.
+	 */
+	if (gatt_db_attribute_get_char_data(attr, NULL, NULL, &properties,
+							NULL, NULL) &&
+				(properties & BT_GATT_CHRC_PROP_INDICATE))
+		ccc_value = 0x0002;
+
 	/*
 	 * Register an indication handler for the "Service Changed"
 	 * characteristic and report ready only if the handler is registered
@@ -1905,7 +1918,7 @@ static bool register_service_changed(struct bt_gatt_client *client)
 	 */
 	client->svc_chngd_ind_id = register_notify(client,
 					gatt_db_attribute_get_handle(attr),
-					0x0002,
+					ccc_value,
 					service_changed_register_cb,
 					service_changed_cb,
 					client, NULL);

-- 
2.56.0


