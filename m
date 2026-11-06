Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990036;
	b=ozOreEu2hMshM6tobmQVZd5vR1n7o548yVrVHRYbbkdrK3VzzDr8nXJZ1fpl3DDUosVz
	 Y/xISjauH2s0oh5oB0URW+tWU+YkHMZDYAgHnmiMz/PBGtheXz80tMaYv3AYRZuEkQUTx
	 VdQWsiRdJ7c9el0ocDOb50PceD4dYPlJxGIHMEwpptSAzbhBImt6rccuRsLofUiU4gi7m
	 d8Kgaz/9dHr9I8Ra9PMxGxUgImqt7JQ4GMj5H02gd+ZQSf39Tp3r5MZVgdaeMGXF6jFhd
	 Z+2zxQCqqmJqgcFp+8HG2oeOwRAmp5o+R0sqotgrflxIksO9DSp4JiFqUcrah/ldXig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4vl0/6QfHZspV+UGdtydUAFSXyMbPA6EWr8MJbvxMM8=;
	b=tDuLOy4+siC5FMKkO9srgTeuIYkpw32f1x1IsRjR0XPUFgKWZNKjro5eJzUJw+QajjJo
	 m5FDOXiILiNQfO67ygRJ3DdUr8Ft19hE/LCRYKiM4H0b1AwpvVf3L+eqGP1XpWhX89G3J
	 wVvb2fnMOl9gGamEkmZcpnTncbdNT2vGnQhYdZPkmQ71+/N6FpN9exnKbZiNAlnplKoPW
	 9EUzCUcMYEcNW3BfZXL5RDyQTNPH0J+/eamm5B7qr16PnMfv0LGIHw/OZKdREVye/xKJg
	 5gblFXuBhhQZe0//BqwCZaWo9Z0mY/L1u3zhu8NHgxJzsVPI8gEAGGlegknA84teHJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHKx+bPQ;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D583606A32C
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D583606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHKx+bPQ
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7c3b75caad1so678921137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990034; x=1794594834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4vl0/6QfHZspV+UGdtydUAFSXyMbPA6EWr8MJbvxMM8=;
        b=GHKx+bPQ4tplN6CBoesm9VhKXNmEtYlKFcge2U5AnMg82fyaUrIcztg7oYTQrTamg9
         BuA02/8Ckht89EPgJbku4eVKfKcVAoa/QPnQNxaL7zj5wAuKKziecnt7gnj4KnF/YpAE
         3ZXvstudDng7b350A3UtBt1XtUG7UPckDgKCn/NSb5xVGs5Ccy6fWLEA037ONxNihvkJ
         IIndIWDih0MSeoRc1NK0ijDnuhLJeDMDsFdM67AvtRp7bffqpZqqIxZcCoNqiyWQoWEx
         Xrzkemrd6zrkhdb2lGVa5VLFxjuk6I9rGXJuzNkPdIzT5lvSvl1B6DLHbuYGoNK0uII4
         vuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990034; x=1794594834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4vl0/6QfHZspV+UGdtydUAFSXyMbPA6EWr8MJbvxMM8=;
        b=1E5eKRt6J86jZToaLUmZWkbxiPXW6LFWC0u/8ieXHDlbd/z1wd0bMbAeGyNNGYva7/
         Pju4AkyPIZp6eS6ztle4h5tJU+Mx6eXOCbABWkpC/gnwTcmNraGKHG2vLUhW3B7g+RU5
         vzcxG2OLuc4p10Q1qoswP4BOYWQUkxryXHi+D8SLWRz/dmtWiinc0DBbYufw3ozkVl1d
         dz9UcBVe/Etgo1WNA6XI4sZ9qPKi+bCinjT6KlODMhJXWrqmnpCJNB9qNIh9OzK9Mfyc
         VngzOGFk3HgnRbIoDzlQZNoULqa5H0CUZWilDilfqv+WI9iR9Ywl1PN9NnexhgwVjpX7
         G/Pg==
X-Gm-Message-State: APuU4Z/Ix6FH6IGHTRZaOm21kR2Qznb8KY8WtsEQG0R1m55emh7xYLOd
	OPv7A2l6OUWq8FjRc92Mxbdojpn98vSfav4bx10R3PNewS0oazJxY3BJjzfsTQ==
X-Gm-Gg: AYBFou3Ucxoj0eBkM34kV7FnBSKJwxCkENVXfhXtVdABnuCV8VAHSxIUC5wee72Kr4q
	fkODdfWiYxtwtsXKZSjVR8/ISVyT4btiVG4zanQFZx8wkcEou2Re44nTU0C3e0NDTPompv0AXAZ
	pWdNQrkpHLdDFzyCsau/l9b6RxewjV+Fn5xbd0Cv1IcDIU1cuKdfsua6zWRUIBegSVkDuUCTQt2
	S+KbiuNx/D/5YKynCQLli37c2JOs48s+DRs4JsJGiVq+JIwQ1IkqDIiAtyrpakuXFPGaUZOJLa1
	iUvtgIp87u16y4Yp2+X5hMaD8jPHrUGZCUOcAMcDZeAiCFD8AERbewD/XNJ4P1gfYNzZPeXkynW
	Lk1/BHU7Ge6DvW2xPuDg4tB04D/SJ1q8FW/aEgfr5XhX/sRL60LPDuod6gpVQ0BofuPO1yF8BRk
	Yvs7/pKr6LuA5n0nr1sTrqE3S24xisk7NCUbkL9Qs5EXTeFxFtYNeE4bBPGbXFWHytpeHBWCqay
	KxyHBqjkuJ/uD0wQVPP0hhHGnlUOUw/RP0Qz0mVCmnUqDBPNXbg7xYEtKDD4KwDwdBmeszN8GwR
	nxlzdYJzCYr1BLJRcQX7y+MCsWW1+R5FHjexfASG9GSSdHZrJskq0SfYOz9Mzd2zh2MjNNdgm1h
	YjuqXQL5Bofcrv1nWX6Sdri5OBaOy/P55FhSefBxHsp1zz32svyCA3OrRsbhI6Oa4GbXd1YfNeE
	dCxvt8
X-Received: by 2002:a05:6102:c51:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7d2a154e715mr1903310137.14.1793990034533;
        Fri, 06 Nov 2026 10:33:54 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm1910173e0c.3.2026.11.06.10.33.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:33:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/8] shared/gatt-client: Fix handling of short notifications
Date: Fri,  6 Nov 2026 13:33:45 -0500
Message-ID: <20261106183350.3155282-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106183350.3155282-1-luiz.dentz@gmail.com>
References: <20261106183350.3155282-1-luiz.dentz@gmail.com>
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

