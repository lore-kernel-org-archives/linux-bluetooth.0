Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917005;
	b=GZWvedjhKJlA5gjy43RdHJVl9l4xqVfUwWqGTBnJ8rX/S2rjo/id0jB7YsWjTq2jpnhA
	 OkBuTtMGsr36eOM1K6x9jzWjpMb+RJNZjfU4Sws+mcKyQ2WvEYP/iyGtF6fDEjEQfrFbK
	 v/g0USJz8MuHnLtmiEkt3XFHQpvhMgfZOzdBTWHaHFbk+Sc8taD+o6yXZ41zzHbhCKy4e
	 rKZgEEiyj/CnvsGURpHQN2FnT3US6AahlYNjvXqxWTUUMzE5+pykX0xjFiXsI/XXAKvqk
	 tkg5r8pXWfv/ka+edE/HDAkiXle1sTqQWyndi+mtd/e0h3+DtsPsixtHxrJ2gT1Gk5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4vl0/6QfHZspV+UGdtydUAFSXyMbPA6EWr8MJbvxMM8=;
	b=XhkTO3NbaiRgdF142is+7AZNk19lhNPAmhCdCLCm6y7gX5IojFKEzTjZvGsc+T9sLZ8u
	 2bPA6uadJzRJgUPnhI4+lF/ghCDlAHhaDN+vsAsR2cRR/FPjvWDpE/Vi9vac/g//VP9Um
	 EBi5Kl9v9T7unQpPqQijbeB5BCei7bCrhTtSf6PMFLfH/f+X8jorpwDj7yxCX25+0GyXe
	 lUEs6seiTkKPbA35MbpKWmcujlOnDUKJbhikTNEkhMbAzK771ygH7fRkGQPV/9kQU0qIK
	 +X34S7SUj9unRq02qe5BoEhx/CZ8yOaKxSWvV6PvQ6LRIxmHR2jgYMBx1R2/+5cGFwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+KdP1hW;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713E606A336
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C713E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+KdP1hW
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-745497ac8fcso34413137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917004; x=1794521804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4vl0/6QfHZspV+UGdtydUAFSXyMbPA6EWr8MJbvxMM8=;
        b=i+KdP1hWuxWXcTBEzcy+f0UEgRtznRDFOiND7Q6SdlBg1mNJzU3vHfU2hmEMsC+TyR
         bnyronItuQaKmrKf+NxXYMqoE9VoyrsbEWa11mepljGrB6s77zo5b0i4jQJwvF+PEGNA
         PtmD8vyGhJY/aSzW0EigJEbEnY5Jg8L4P+TkqC+8anFghETWeVr/EzZhPy/L/jt23E8a
         AnwGD4Vx6x2N6+OFIKX2QMYTwfGYfEsJcX57PiPttr9EiJFWIvqEMT4RCUMjWIZualoF
         mHxTDABCo70/IqZRztaMsGLcYbJHr8CpXZdwFSt8FPAGhlbCN32MVEvHidpyuU6q+9xi
         jcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917004; x=1794521804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4vl0/6QfHZspV+UGdtydUAFSXyMbPA6EWr8MJbvxMM8=;
        b=ipwXG1bi2YPpkS8MkqfM0scx14pz1zvr7pDZaPMnXM1UpiXqsgixX/QiVA49YTyRC5
         7ZTiOxo09TdxRIipdzjfthLiKAcsDG0tBO2nO3Ex0rMSoGaxw5JVK7b0jaSVkz8nwg80
         /jSthkwOTYfHyon/D5PbjwiBktDbjmSzJV3CfILAiYcIphalnD4s2d5Nu5N8vq/dsSH8
         hE7icep//kRBe1UeU19foz686zrRQMGpTzjjvdf9mFI0xFWwjM38ZNYJJ0oJ/vQNyBDi
         MD2eQnsPqgxh52Bszgz8P7BvRcRp1pEs+sFxuoR3OfAbanamHeigUzW2B0aJjIyT+X3X
         JE+g==
X-Gm-Message-State: APuU4Z8f2ynR+tRc7NBrrTKVwuZeZYNFTjgeQLypQ003eJJ+4BSZhzc1
	EZD9f7kFzrJRneATZwXM6YD5M0ZGy8d0naqMOD0rnASxTvNuOQYMZorSV0OAtA==
X-Gm-Gg: AYBFou2wMOFCqrVB6UNJM64CvK+wJ5juh6kd4c5JbEWDz8zC4y3EctDJWWuqcrjn7pH
	xF8wy+dZsmeyu7XF2754pmh/uHoGKF7aGvNT8F5KBBQ0IC1cf4wNCgdTMFIZCaTrMNnrK2ps2vA
	6gyDnhvTckpcB4GmZItiX+B2dNgpdUwBVAGepWI2FY6PFRsvP2XB/wzFJFYs1PQCWNQdDDLfYp8
	3jiN8rMUB1Uyk1ta0EsMojH+89kZ6RZGw5jx2H6Mu399qcHOh1eo3sW6okaVRCJ/SaHVP25+ydt
	q0Y62+IPdx4D+D/VNT/hK61hJZQsm6chIOO7TR95pRXbrvdLUFX2Es8sRfWFJp5QXjm8iNZzoIH
	jhd3ZeCx654+Gzaa/juCr3wp4vu0RqKCXgc2jv5yISaWBifLNVLHd6W9KcNdCech021IhGw44+2
	icFwbY1/BmOgWWAGldJTcDPeCz9Rk1J1aAyY3bYh25tUSMd+3OqbVrSkNZU7GVQN0mL8YyAB6Yk
	JZXhZtjDTxG3QKnFco9Tz4yBpgWRGmR2fnH/9L1eVVpUuCSaKab0V02fNGbtxNv/YSeMpj8g7bm
	DwBnb86ocFtcbdmdZPc1U+5XZRObtYyu6H9EM1gixVa9UR9Cd2ztPznZF0jmShAQXdwe56OobSJ
	9t60AUmdspZ+inCRSU9w0xN/XKdl1SA1+mYZuaVJsv2bXj0iUfvQz1gw9RNvonjCY5+I4kuNsHR
	DGGQc=
X-Received: by 2002:a05:6102:3712:b0:7ce:8505:9848 with SMTP id ada2fe7eead31-7d2a166d564mr797983137.31.1793917003751;
        Thu, 05 Nov 2026 14:16:43 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d29d1ea0efsm1355419137.6.2026.11.05.14.16.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/8] shared/gatt-client: Fix handling of short notifications
Date: Thu,  5 Nov 2026 17:16:33 -0500
Message-ID: <20261105221638.2332398-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105221638.2332398-1-luiz.dentz@gmail.com>
References: <20261105221638.2332398-1-luiz.dentz@gmail.com>
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

A Handle Value Notification or Indication shorter than a handle made
notify_cb read the handle past the PDU and wrap the value length to
65534, passing a value larger than the received buffer to the
registered handlers. Ignore such PDUs.

Fixes: 151582e6a343 ("shared/gatt-client: Handle incoming not/ind PDUs.")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 09bd9c971ee5..2b6da611b9f1 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2299,6 +2299,9 @@ static void notify_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 			pdu += data.len;
 		}
 	} else {
+		if (length < 2)
+			goto done;
+
 		data.handle = get_le16(pdu);
 		length -= 2;
 		pdu += 2;
-- 
2.56.0

