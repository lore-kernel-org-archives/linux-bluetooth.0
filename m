Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794668996;
	b=Euyg6cVZbb54emSNupLFmmlxZjUw0cuXPyzp7L1tSJfXRlVyegWeBpDlPplQ4FeygNwT
	 XylhCIhA4nFaOOEZO7U0Dir1Wla5jNva46+7foCIX0JRZURZQWEpHROwMH3k7xK1mUrNm
	 mQHVW6j/BpsmAwMXIwGUfr1dVb8xA888e9iqKcIPkgExO9CZb2cVeE/PEw1hLMiiE3zFA
	 S/QDxQLGYOVe7g0we8nfM8+ZGUO/FKkiB4+CL75XXYVXHKfCkDgtX3PA9v3Mr1cyJldrO
	 ywA919fXsIcPJBTrpLBi5RWkQxRqUl3OjJ7VZBS2ymvepYR/ZfbNeueXRB8bdzj8Gzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668996;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RVfY4Vj9J6/b2cysWWFNn+OcG8ngi18tkM6s2wDHvlE=;
	b=5HjRKOpuFhZLCBprWQhjovoLkBrKfyttwKhEJ6SKGBpqQ1PJcuInhkoTQfhka6GYiRJN
	 NUrqpRAy57+65qo6Mjk3ji9Y8SwKYGkCyjQj0hXw/mx5I20DFBdZCrTbCriKp+InmqdNT
	 kfl6fv+GGybmn+jhipkROo7CY7wwmk8dmDSQfs3CXmoBfI6iIMvFYrwy7pJg7UsrZT8Se
	 X7FMza6y4hJecq6CojVu9Uy3GDvctGK14/HO7PsKnBalRSF/b4Q+a3zLLtKEN/hk2LBdf
	 cDcaP4BXKqDbmXxUCdABSdsDxgv3j8GHwOixcOu7GreGXcImsc1BOabldkqH1BvrjWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aID+Tlyb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C9606A329
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aID+Tlyb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794668996;
	b=Z3tYk/rObYXByfgtgJbWAHXwhugCk5TDyItY1rFcZs4xcfoZMv34iyWg60RAaNh7HFwC
	 4PYtcm/kwf5sVL/vOSGbrW9g7r+3TI/miksenzInKu/+r1HOqq3KBEGdgZGZLoesj79/z
	 x6gjSRDsyvRI/ozcWF9C4YhR+diRzS84qDMDER+mu8qaE2DNQtQWY/J4Qa5KyIczB0t4g
	 0ByY8UTIZGmarD1E9L7rrZf+NhbCTh3WWciVII4WIw5S8gzUhiUvNcodYIqrRtFicWOJQ
	 ULFUXXcEHwTuMn76sWZbz1nlb3X5Kv5dejXF9h42fJTvU0PjAUdPueE3pz3Nj0BuIrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794668996;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RVfY4Vj9J6/b2cysWWFNn+OcG8ngi18tkM6s2wDHvlE=;
	b=otq43dc/Vy2Xcgu+aQKr9ol/tk2m4FuiY2u8tA0KOH0wTl9fslqaLFm9EGjzKEceKdTW
	 Yit5m37JMZzod+9xdFPWNs4RNS3jEYoGvNq7s4ye30uXIiMmlaYAt86iAbX3SpCiNu85c
	 m5oAEOqijsfFbOSSJrGjYt0ULyL1jshn3oouAlwPZzNholRqp2/6o4j/nc+2nic2ixho0
	 a8uFIGoXphr8OYa3fM7eHaTPd88uVE6RMXijM7pXUafHQHOonVdrfHp55idOe5wAxf2x2
	 KVcwrW4TL/xy8DCYsmihqap95FnShuHxALqaBXVI+YOGV6lwQgzUtbPxSDBQHOv2qpg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E83161F000C4;
	Sat, 14 Nov 2026 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794668996;
	bh=RVfY4Vj9J6/b2cysWWFNn+OcG8ngi18tkM6s2wDHvlE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=aID+TlybW+GA3P9bpG4w795zipFH50dB+g/JFUWqZnsHRFa0KAJ18oljmxLDINVCH
	 ycIrVzd7z5dv9AkZFT6YRyktXxFvaUjvEsQHeMjRESvZj0K4+2pen9ZAN88QwG0wxa
	 0GKIa4d/7dqA79RwuQx1sBp42aHc7oBzI+cGJXsBbIJ+JyINHs2lOs+JO8gYhoZoX5
	 Lm20B6TwrPsP2GFVGPlWsojRhhV9bUu1M6fGthSx+hqvIijvWu2zVbjkScEl0JlobB
	 uxZZqkyK6x8MhutVCu/GiLA2CMqGbZQiW43dSFogYzxJ8SR/Cko/Wpp538R2Y8S6hL
	 JEgDImcKENnhw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 68EE749DDA;
	Sat, 14 Nov 2026 15:09:55 +0000 (UTC)
From: =?utf-8?q?Neboj=C5=A1a_Cvetkovi=C4=87_via_B4_Relay?= <devnull+nebkat.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 10:09:55 -0500
Subject: [PATCH bluez] gatt-client: Fix not emitting MTU on reconnection
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
Message-Id: <20261114-gatt-client-mtu-reconnect-v1-1-a86edc1eb208@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yWM0Q6CMAwAf4X02SZ06lB/xfgAs2INFrN1hEj4d
 6c+3iV3CySOwglO1QKRJ0kyagHaVBDurfaMci0MrnaeiHbYt2YYBmE1fFrGyGFU5WBIbr89UNP
 4o6+h9K/IN5l/7zN0Q+Y3XP465e5Riu8X1vUDfbjE2IQAAAA=
X-Change-ID: 20261114-gatt-client-mtu-reconnect-125381776960
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: =?utf-8?q?Neboj=C5=A1a_Cvetkovi=C4=87?= <nebkat@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794668995; l=2589;
 i=nebkat@gmail.com; s=20261114; h=from:subject:message-id;
 bh=7zEhQSfBbmmd9CGuGhNZp1WtJKQdpGgoQNgSKQa7HMc=;
 b=zZpPcw5ZkDN1Y0ya2iX6dBnnnwD3g4EDbbMbSPmP05utKTk6Zi0lol8uWGMcRJ9IK9JWpKpgY
 H+OKQXH1etGAVMCsOLAO2Uil9YCv3Bbioz79GguVWnwasEeDpcQBNdU
X-Developer-Key: i=nebkat@gmail.com; a=ed25519;
 pk=uig8l6j+LcM3b6EaVYnCVjReuerjQ7eZjriM64jfQzs=
X-Endpoint-Received: by B4 Relay for nebkat@gmail.com/20261114 with
 auth_id=1529
X-Original-From: =?utf-8?q?Neboj=C5=A1a_Cvetkovi=C4=87?= <nebkat@gmail.com>
Reply-To: nebkat@gmail.com
Content-Transfer-Encoding: 8bit

From: Nebojša Cvetković <nebkat@gmail.com>

Characteristics kept across a disconnection have their MTU exchange
callback registered on the bt_att of the connection they were created
on, so no PropertiesChanged is emitted for MTU on later connections. As
MTU is omitted while disconnected, a client that enumerated the objects
in between has no MTU for the whole connection, and one that kept them
has the value of the previous connection.

Register the callback on the bt_att of the new connection, and emit MTU
as it is no longer omitted.

Fixes: 3a6b5f5ec14c ("gatt: Emit PropertiesChanged("MTU") when MTU is exchanged")
Assisted-by: Claude:claude-opus-5-5
---
Signed-off-by: Nebojša Cvetković <nebkat@gmail.com>
---
 src/gatt-client.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index d94dc9d..2d58ee2 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2414,9 +2414,29 @@ void btd_gatt_client_eatt_connect(struct btd_gatt_client *client)
 	}
 }
 
+static void characteristic_attach_att(void *data, void *user_data)
+{
+	struct characteristic *chrc = data;
+	struct bt_att *att = user_data;
+
+	chrc->exchange_id = bt_att_register_exchange(att, att_exchange, chrc,
+									NULL);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->path,
+					GATT_CHARACTERISTIC_IFACE, "MTU");
+}
+
+static void service_attach_att(void *data, void *user_data)
+{
+	struct service *service = data;
+
+	queue_foreach(service->chrcs, characteristic_attach_att, user_data);
+}
+
 void btd_gatt_client_connected(struct btd_gatt_client *client)
 {
 	struct bt_gatt_client *gatt;
+	struct bt_att *att;
 
 	gatt = btd_device_get_gatt_client(client->device);
 	if (!gatt) {
@@ -2429,6 +2449,15 @@ void btd_gatt_client_connected(struct btd_gatt_client *client)
 	bt_gatt_client_unref(client->gatt);
 	client->gatt = bt_gatt_client_clone(gatt);
 
+	/*
+	 * Characteristics kept from a previous connection have their exchange
+	 * callback registered on its bt_att, and MTU was omitted while
+	 * disconnected, so register them again and emit MTU.
+	 */
+	att = bt_gatt_client_get_att(client->gatt);
+	if (att)
+		queue_foreach(client->services, service_attach_att, att);
+
 	/*
 	 * Services have already been created before. Re-enable notifications
 	 * for any pre-registered notification sessions.

---
base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
change-id: 20261114-gatt-client-mtu-reconnect-125381776960

Best regards,
--  
Nebojša Cvetković <nebkat@gmail.com>


