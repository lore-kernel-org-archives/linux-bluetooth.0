Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149A13C809
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169987; cv=none; b=VW0XAJ+FLqjJOtT0IGbZDJowygrKJkLJtN0Dmx9fgxUBp1HfO4S2H0yMclkFKKju6LEOgfBiecW8GTgRHUfMkTlYMC5j3/Eu1OlRBr00egs8bwjgxutWFncLprNfb3qQ7Mr71LGb51T+TNjUF/e5F3rnQ9iSXmPkKA8qLuVTrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169987; c=relaxed/simple;
	bh=4UgF2Ma8Ry2HBALH6UqTPjSXhuSqVk4ELQyVT++w4ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S134lXEzh2BYQxyqeMrPCQuOwlYJ3z9bcjtNNRZrdskeT3uiXYw8RG/ux6R5t16tbq+/p/NfBNcoZWwSstOrMFuGD7+UQKGRzlDys4GvgwxZ6keinsO8UhcZQ9eYV9zakb1fGoZPvlOZ0MYEf6P3DfwEz9PfxcALTXmRJDHfbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BA2460006;
	Fri,  5 Jul 2024 08:59:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 01/11] gatt-server: Don't allocate negative data
Date: Fri,  5 Jul 2024 10:57:29 +0200
Message-ID: <20240705085935.1255725-2-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
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
index 3a53d5dfde6b..66e370d1fe3d 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1120,7 +1120,7 @@ static struct read_mult_data *read_mult_data_new(struct bt_gatt_server *server,
 	data->cur_handle = 0;
 	data->mtu = bt_att_get_mtu(server->att);
 	data->length = 0;
-	data->rsp_data = new0(uint8_t, data->mtu - 1);
+	data->rsp_data = new0(uint8_t, MAX(data->mtu, 1) - 1);
 
 	return data;
 }
-- 
2.45.2

