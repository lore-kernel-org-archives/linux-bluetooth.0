Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787E326920
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381467; cv=pass; b=bZAFFIf9kqkRwB4OpJBUwmiJ0UGA+wZFa/xGPMMGvmo6pdb1XCqrFl5RkkyaoQHkcJgyE+p2d2QRngZTlFXRaG5pXLY/9Q1fFKo2bY/EQ5W3laC4IWEbQ+usqbkV9wn0NYfrcYlgl+Fy1ZL1URp0+1jEXsY4njIJcFZhziMslZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381467; c=relaxed/simple;
	bh=aeog+6PLXNmGbhLNu7i7EGWyHvCrjz0EodWyA0y1TUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldmmON/27hWBFfn2/hfF3/4zs4W29sVHGJu/Nf/qkJGed0/ide8be3Q3/05WBiVHGLXSpF4N82Qbxs8YcaOWH8Z0TAdDfllPMAQvXBdtQ7nIRzbcAk5Aifzn2f5xWgk1FhacFldsF/vFXH24c+wLZ0k/RdqHSapYATZunQhf67Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=hdHegA5o; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="hdHegA5o"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRKlV5KKSz10JQ;
	Wed, 10 Dec 2025 17:44:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765381463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=hdHegA5oqndhbUjB62wTUkLQ/gnubMZEJHZb7t9VWzAikks6s6a+gp4zq8YDaafrPO6iaY
	M7rjP+GLLm9AxwiBKABnnb7OlofUWXOsqZSuMcuLcGIzTbEtE0625IG0BIMz4V72N0k2vL
	ke/CyUzyqeWugbp+NhdaAP0VqketMt4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765381463;
	b=XbjP++czACGuZAqInRZ2rNggpprbLDY5UQ7JRQp//L+oE934WqrdHvHzwfUy9qxLaNT2nl
	XjHIrRgC/EikLIVjXWS2GVIzWBxMgHS4uxJcnbf7Cg+w2RC0VCty1SHhpHJ91QyEDuLf3s
	UlBxq+XZ/iGi71o7IBQUTNQhSSUjvnc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765381463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LnqALAKocDHdaUaCb8sMgnvU6pb7SZqtIOeHda+FgY=;
	b=xjpiRwyeHC8v8J87ushtwolGMNBs9Mrs0cii/G/qYOD8BRs7zvvwTEHPBrvGwqIOJ8xEvG
	+hABigza8qcWllQDK9bMQR4oR55EZdB/Zgu8oDe29C3A5HkrHs/zGA/NFKstW06vFT9BlB
	SpQWXrElRhuRk6zX/GNsVT1os48tl5E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2.. 7/7] shared/gatt-client: fix notify_data leak in notify_data_write_ccc
Date: Wed, 10 Dec 2025 17:44:12 +0200
Message-ID: <14e2a607cf2b5930a8e2c66c94845972c1cb4477.1765381438.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765381438.git.pav@iki.fi>
References: <cover.1765381438.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling bt_gatt_client_unregister_notify() when ATT has disconnected
leaks the reference to notify_data: in notify_data_write_ccc() the
bt_gatt_client_write_value() fails, the destroy is never called, and
notify_data_ref() is leaked.

Fix by balancing unref notify_data on write failure.

Log (unit/test-mcp):
Direct leak of 5760 byte(s) in 90 object(s) allocated from:
    #0 0x7fd7e2ce6f2b in malloc
    #1 0x0000004227e5 in util_malloc src/shared/util.c:46
    #2 0x00000044a81c in register_notify src/shared/gatt-client.c:1782
    #3 0x000000458367 in bt_gatt_client_register_notify src/shared/gatt-client.c:3685
    #4 0x00000049f9f5 in foreach_mcs_char src/shared/mcp.c:1834
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f6d5dc4b7..f8ebab3fa 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1691,6 +1691,9 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 						callback,
 						notify_data_ref(notify_data),
 						notify_data_unref);
+	if (!att_id)
+		notify_data_unref(notify_data);
+
 	notify_data->chrc->ccc_write_id = notify_data->att_id = att_id;
 
 	return !!att_id;
-- 
2.51.1

