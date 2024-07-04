Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FC1AB90B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088783; cv=none; b=FPgF/NdNUoGRVQgyik+kI4E7SupZqjDJD+Dc0Bmvat95YkaUL5vmCFPmMBbf2Eebe4eav2hnUDmVPCcrAXfS/2LDm3s7xIVwvzXJSkGZ5XRAq+SPPzIwaSQ5qpRn6bt8+y2TbSxOsmnDjkQKqBgEniYytgYq/NiT++0Zk2OQP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088783; c=relaxed/simple;
	bh=1mmU6nPD6m4Swz7UeXdpRrTFshfVYLP6F8b8V2+GLgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqvvXiW1/DRhN0D+C1XqM+5uIfiaom7fLewDlIFh4x3gpwbJNceydnopIiO09YyAt2hxHCs4loe0U5rSRZjqxhIXaAUUUKNxe2heHXFlEHNCbVQ0lBt8qHXkiG+ytqtRv6D2+lHmJvoC1QiwzPmJt1eCnprWhtPXPJ9P5wkfjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D33D240009;
	Thu,  4 Jul 2024 10:26:18 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 01/12] gatt-server: Don't allocate negative data
Date: Thu,  4 Jul 2024 12:24:32 +0200
Message-ID: <20240704102617.1132337-2-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Set a lower-bound to the data MTU to avoid allocating -1 elements if
bt_att_get_mtu() returns zero.

Error: OVERRUN (CWE-119): [#def36] [important]
bluez-5.76/src/shared/gatt-server.c:1121:2: zero_return: Function call "bt_att_get_mtu(server->att)" returns 0.
bluez-5.76/src/shared/gatt-server.c:1121:2: assignment: Assigning: "data->mtu" = "bt_att_get_mtu(server->att)". The value of "data->mtu" is now 0.
bluez-5.76/src/shared/gatt-server.c:1123:19: assignment: Assigning: "__n" = "(size_t)(data->mtu - 1UL)". The value of "__n" is now 18446744073709551615.
bluez-5.76/src/shared/gatt-server.c:1123:19: assignment: Assigning: "__s" = "1UL".
bluez-5.76/src/shared/gatt-server.c:1123:19: overrun-buffer-arg: Calling "memset" with "__p" and "__n * __s" is suspicious because of the very large index, 18446744073709551615. The index may be due to a negative parameter being interpreted as unsigned. [Note: The source code implementation of the function has been overridden by a builtin model.]
1121|		data->mtu = bt_att_get_mtu(server->att);
1122|		data->length = 0;
1123|->		data->rsp_data = new0(uint8_t, data->mtu - 1);
1124|
1125|		return data;
---
 src/shared/gatt-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 3a53d5dfde6b..c587553d655d 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1118,7 +1118,7 @@ static struct read_mult_data *read_mult_data_new(struct bt_gatt_server *server,
 	data->server = server;
 	data->num_handles = num_handles;
 	data->cur_handle = 0;
-	data->mtu = bt_att_get_mtu(server->att);
+	data->mtu = MAX(bt_att_get_mtu(server->att), BT_ATT_DEFAULT_LE_MTU);
 	data->length = 0;
 	data->rsp_data = new0(uint8_t, data->mtu - 1);
 
-- 
2.45.2

