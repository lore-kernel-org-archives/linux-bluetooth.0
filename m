Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794505254;
	b=3C6Hv0X4GbDRYYScuTz2kHJXORf7tMkbKVetGu88vUSUzU0jXSaHpm+DZTb64cn4L6FK
	 hrW7Hj6sM6hSqKBnHTP2KvK+uyiNR1jr6+uaLkIfomxYQ3LxNhxYFlsHAyGiqs2WznQI7
	 8/COPSrxkUn2kJwCP1quF++bFzat7LtiF19Ie0VkCdAitY1CRyOBzDJQGILZigyOVAZOF
	 z7xMJmtW4uA0yrBzlf7PG24QpkmR5mYdou02u8LxJ24Zer5ZFrTxVzUQYgaBGp+iuCJ4q
	 7Z/hgUwVZyRTIm7A97qU6dPkksMJtyQggJ5ro1Zt0sLm7IpIJ6Ne2QmVYXPzLHSJQIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505254;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LBbzLDMi3tUpJWb9FAQ+FK8k0XDL0E1xorOpMlHneUs=;
	b=kfs4XPpKeemgDTPCLwO1fj6YitL1IDOaKxy74o33zmYHOkJx5O4REvlFqsXVwsBjTjhz
	 fLlaPkMLm94oAMfLBwMquIwoJwEXesGz8FmnYZ4yCsVtQ/3BE1NkdTIm5kl/9PGLQPQM3
	 Avi8VcZnA8MZwZQKW001P9BH6SBcILoI4hQopk0rv0EeudzQtEPgA0pc0cdYzdRd0Friv
	 KgfOh1nckoH34fy3mZ7VeDdzsBTUbnekPjMDOsVnDjI6mk2pSK9xVfOyIWzvJ5JPKf+xe
	 hTsTlPkj9Q5m34WQdwOouJp4HNBOTzqCg4gfGS3xZxO5fad+tlr63OJIffyhVtNy76Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFsHYSoP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351AB606A213
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFsHYSoP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794505253;
	b=zHV/HtGdjoFaEBCgmRFTzlWDv8tTQyYIggamWtPuc/Osmb9UTrZ1psg5OHy9W0Hvwt0O
	 7kJkS5d36lkeGgdy+/D8c3k4OtsjwiOrAGHiT9mzvt/DPkJSDBG0Ix8oKYQNBs6b1mRLr
	 fBc+/2j258vfkDKumBqj56yJUsuHGrOS1VPswHhu1uHbATBBuclbP5eyu5gIVGFsU8vt4
	 6Zjh2Ypl8eoy0K8t7I9Edg35jqK4oD1DFsl/zc+5yt5sSv3qic6v12sCNtLnb+dPaOHrf
	 qGdu5lIrqgvKgjH/yq3wi1ZNTwmL+ggzRqma4p+ucqYS/jWlRnsSGs0ElfARa1gchLw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794505253;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=LBbzLDMi3tUpJWb9FAQ+FK8k0XDL0E1xorOpMlHneUs=;
	b=UUg25HYhqcYixCaVAsnFWZwSQFi4ZzeHIIq+onOCV8oFA+lLJzbcyT/vxdQcT19zI7WZ
	 KoPRP+tnX8bC88Yz06LUTGU4joWsSbRkNx5bTgrvgMdAkCTbhiYKjttwZFOQdSocqnT7F
	 +EP/jJ21P2A9sOjhiNaNfjqkUYxyrfeQA4ZYd8w7A+YyaFXk9DwB2GZ3VL7FlIkZNw80F
	 o+BGYTEfTuFe3tlVSPtAeI2rUWqKmamTbC8y1onxTz/iPGrMXOsSZvBVJYytW+Pvv4xGo
	 MAHzWi8jyoioc/eUu2QYlNXHwENHsLxShYtO8CmXe8W4pQaPRAnb/o/UTPCK1rVpEwg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6FD7E1F000C5
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505253;
	bh=LBbzLDMi3tUpJWb9FAQ+FK8k0XDL0E1xorOpMlHneUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To;
	b=gFsHYSoPY7U4qezbdsdG1s6EzhE9T8gicdvHqtBwZ9VMaFch2kpwfyewoEn5Y3mwS
	 x2SpKD2INw8bKjAzN5fehqNkIcjx6vIH22fvgoQtWD3kTsNoSJXn3NPPO8j/gSJM/4
	 03anUToPoIPROn/Piw8Ff2IxUEv9046nLBtOYBL6yjPXnLo2k3POBiya427hngOm4y
	 iUaUtC3AbsCGOPcDGIyI/VCNloggcybifTYTHjH4sIhmHxwF24WmNxDTkFaixXnysz
	 gW9VSwApl6VTdu0xbzeMyJxV8+wxQDvVw4bNbbzn3eVDHXJW+Kxg+6cIhdQOmOkNDh
	 Yf6wELvY3xjAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 01F1C4746D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:40:53 +0000 (UTC)
From: Marian Poltak via B4 Relay <devnull+marianpoltak.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 18:40:53 +0100
Subject: [PATCH bluez 1/2] shared/gatt-client: Fix init when Service
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
Message-Id: <20261112-svc-chngd-notify-only-v1-1-c7db7ac47acf@gmail.com>
References: <20261112-svc-chngd-notify-only-v1-0-c7db7ac47acf@gmail.com>
In-Reply-To: <20261112-svc-chngd-notify-only-v1-0-c7db7ac47acf@gmail.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794505252; l=2178;
 i=marianpoltak@gmail.com; s=20261112; h=from:subject:message-id;
 bh=1/TTqObs78ywj9niQGB3b4pnlfDX7RjHY1NjRlkW48Q=;
 b=MkQQUNlMjgzknCyj5N1zjnf6HN4pazJ+BJpmWad0KJ//uRPaaOV9cp4Bu0/ciyHBDBmdrYsSv
 x28NsT4JwPaCfLLXxJhuhvu5ahlzBJXj3XX1ypMCk621e9HXUqARfdA
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


