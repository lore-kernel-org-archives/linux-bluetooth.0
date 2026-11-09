Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239112;
	b=eKwXefxV6z4lt7xeqsHa7znjruSGXz4GlnjhTiocULcBhB+ieQxPn4dRhkv9UoTih4Wh
	 HJFf4wYJqTDNHY2zlrQ4RtE5bh3/Q4nkj5xBBjTElYkWE5v/LFh60E7zJ13U8xZUEn/6l
	 C+ZJQdJKMZEHQ38YPJPPfOMGnlZ17YYk56XLS0lXRJ6DXS/pOg/qNNChGNFhv24ymXXGX
	 KqFm95GOuUiNZ2G4WYtWr9HOhWagCqTrCtrzzcnLLwzVEvzojBtcPP3Dr4LIs3wHT12R8
	 B5RKbKyJ30bs/BQ2vwjwFkwqmUeX6Kxcs0uHGP+At/GY4r/+1evQANC9wa+0mc+hcZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=94bad9sjk//6VWvikgqdpqdeY0LqN6qFWMqJliNyA2s=;
	b=5EGGqcGJZzsD5eYz17dp5bnl2NyG+48LitIGXr6fJMNXqWuf4tX7Y3shAACxh5ipce0P
	 BxXea7NGjcFYUGsA7KM7MsyifprYx4JXmuP6r30PR+WdKYijeXvIJ81/BapbBx/8qCDFb
	 y396JVfHd6QP/z4wDBRhOvHXywxeXIny9PmafsDDdaMUN2IqJbMQM6HcNJpsFBK7HbbWa
	 uZAhW2uRlSAzx7FjtKMNIy0UCZ65P6U4mFIZVFTH4YK72/Sd9IxQqHp2WFsIcSFF/RaZ+
	 Dk8QRxVQsR9VbO4sDMMK62lXTsaSGLoUwZkTBGP2qwsDMQ71fjqzBLvesPKVdJ9oMlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZ2cHJWH;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F1606EE87
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 390F1606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZ2cHJWH
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7d2eba2b74aso380536137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239111; x=1794843911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=94bad9sjk//6VWvikgqdpqdeY0LqN6qFWMqJliNyA2s=;
        b=BZ2cHJWHvi/vjrE1cy2PqvdAV82ErizEjOAIFJis4aGDfDeT9983QokwemQyb7kyWl
         TvMbiatrAOyM6z351iqUiCrmqSLaGXAJjpMZLAW5YgG5QVkcZkY2v1sjsz7xebKz3Y+L
         yRxOrnBn/eL1AT1RYVA1iLs09LlLEqDDej2FGIrxZJwVosagSA7LGnxT+ycHVBlxBW0o
         fAGrlvX2x5mDC2v38VhqjTGc18lC3EEbfzbIX7teUYnJYsTL5suFzAzvAqiaQNf8Mjxr
         pHvxtloccC45aohBGmhRhwXFCMVEDCgEPmDQd+5ulexNBLGem/qZMy1VUqhRL8HT++F9
         sKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239111; x=1794843911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=94bad9sjk//6VWvikgqdpqdeY0LqN6qFWMqJliNyA2s=;
        b=XbCuyk1B2M3GG4JFILpFQNvAOp+o8jrcl96gVCKlWNAOXBILQeFmFA2JFzoCYmZFV3
         TdwCl/EjVkbH56DiHF9yPeOuzqHbi68vfrNioCbNorzvx4NUX0w31rCZY1btrbD9pNtF
         vbGD+SVaQ3Em2E335r2BCjbYcsjZdI6oDSt/daoOYkplS9AGL/CqEJdP32W4VD3hOqvC
         Uy/E4ydtR6fe+iEF+zz58axxVOce2KXJcqBjaL+CeHpeJTwSrYT2o1a9B7S84E4by6Qs
         6RN37WUedbjIUJZDRm5VpB25AFlRRPyS4TyVWBZnvrMdNm0JuG3kPwGTrbBdbCfpgVlt
         KA7A==
X-Gm-Message-State: APuU4Z8v7HYDP9eIouVKHswNaF2c16kWQC5VG6w2N/xmckiFU3Ik+dfg
	Po5Wbv9LRRlgEn83xy8wcwOFl8wudsTcNCMFhrxQDoalFnHYXe2N/NUFt6T2rA==
X-Gm-Gg: AYBFou2MEZPXivIOhU7lhPnqnt8N6CiDj7AI/rNSfgsrr+PMKC/DC4Q6m13f055gSGY
	/nWa9hQ9B4N6gb1nnmakAbky1NBuELYgHuqvBQ6bi6CLxqy4CP8o/4cte1N/PqCqZCBPXe7efvV
	jeEviVgJAr+XQHbDm9Y+qNR++SDP2/xoBA7ctRIBglEHh1viz4Zo4ot0K0VKV1bEoTUDyMDjQEq
	Gp9li47Kx/6LofTIYhwWFMdFWHtHQFW0R9bNUkc9iMMZfCNbDwTnRdSkhDT0+bKXOTvHfYz3pWK
	4kn5oE0pOGo9GW3eu93xhdadEaJVXldz+SEycb3KHkDgpMvGtkE+HoP0yKWLR/CM23GPhyptV7u
	LaeC3GujYngIkSwOGS2cskO9urAWe16HjdQ8z+18wjZNqjUhwvEDgPrzFz6Au2O4hvYqua+tmTT
	k9M1HSpKGCyDtzW/pspKdEQaFnUovic+8vMeR7OfoXhweJ5LUaeFJc6l9Tr44+St4biouy8IC7N
	xlJKIDVHNuh8tz7kDxquKe683AkUhI84ejvpC12eYMPSj7ETwevYdJlbjYtis4URvgOxnUQRMyB
	jTRpcmDiv/pxDJ+C2bUKDR1aAQAtdH60KV4/5izGrl3f2ckxS5HoKtpoeUQSF9tTFqv2boljZOj
	yUNY5U4XQg8b+DOAPcPEZg4ZuL5d/7FBKPrpSA4QbLxvedlQAyr25Z32qccXytX1AMNaaTjB/AW
	zvx1s=
X-Received: by 2002:a05:6102:c08:b0:7d2:8999:7393 with SMTP id ada2fe7eead31-7d2daa68595mr1712558137.2.1794239111039;
        Mon, 09 Nov 2026 07:45:11 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 08/10] shared/gatt-server: Fix return value of handler registration
Date: Mon,  9 Nov 2026 10:44:59 -0500
Message-ID: <20261109154501.1362649-9-luiz.dentz@gmail.com>
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

gatt_server_register_att_handlers returns bool but returned NULL when
registering the Execute Write handler failed.

Fixes: b3e2fa94 ("shared/gatt-server: Implement "Execute Write" request.")
Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/gatt-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 4a6bdb4677ab..4ec4a59993a2 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1653,7 +1653,7 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 						BT_ATT_OP_EXEC_WRITE_REQ,
 						exec_write_cb, server, NULL);
 	if (!server->exec_write_id)
-		return NULL;
+		return false;
 
 	/* Signed Write Command */
 	server->signed_write_cmd_id = bt_att_register(server->att,
-- 
2.56.0

