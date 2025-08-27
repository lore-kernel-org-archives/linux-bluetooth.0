Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A230FC29
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310774; cv=none; b=F4STfgpYr1cb8E+1xD76Iam7l4AS07i5d6TcL8GsPXWUNVQuHPeSrTpEz6v9o9QX6g1P5VXa+HwBGNSK0fidTRv5fVdEqpZrKFwZw4KuW+e5vqV9axQoed1nbQsTFR+JZqSvjlWkCkWBivMPDVb8gCMTxyAdxMI/qShZZ4c6VAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310774; c=relaxed/simple;
	bh=l2bskqRzaj0T3T9Wz046yyZI7WN/yqAd9erwupUh6R0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EonHT3ZsIGKZShClI4NKJhpJ5XPNedsrmxDvYmclfDVBMVWVVGtE64xh3hh5HEYZOc94H8aMbpn4pzHCFECVwLEhtUk4QZ/ESb+YUGAJzJcfKs/K23jtx5wlJKpac4ETagj2RLCotKRcm7mw8Eq4YApAf6ujVHwQ4ymvI0xOhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm9DTQHq; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm9DTQHq"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53b174dbfceso37536e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310772; x=1756915572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLzUzUIC8ZUYbi5IA5uTnp7gGiQe5wOZBz6vNs6A9wo=;
        b=Hm9DTQHqWlYvkoONCY2QFL6I20n8cCiB2ozjQkUEpGkB0Qcqc84bvAg2emHnSVMuDC
         b3sVQeBj4h7MpxVL9JrdmRG/5Ua9e/NAvx9h7w/85X2/x0Y1GQpW79YyUeG/bmdrJfUr
         TAyZY0d1RkC3GGSQGIRPXR9WmSRJQnE1l87yNae9xpHIL4/1KmRwL65iL2hc6IqlM4sz
         iB4TZPtDRjUx535kl6NwD7kuxAVmTqb3s74sImBZXc6j1L7zOKfxuhOMK3obXuBaMlh5
         aVsmPQc1A++fItTK/vTPvml8UsDPhL4WnpeD8sPxb+TlhASt29Cl2lDYzmRmwo8ES4bg
         C2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310772; x=1756915572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLzUzUIC8ZUYbi5IA5uTnp7gGiQe5wOZBz6vNs6A9wo=;
        b=JIZlSBf05KJlW9SK/am4MBXlz4Nk9XdDmozrU4fq1obdFSb9GPzEureMYDkbV9f6c2
         LXuq/4zEz5zsIZXeMCkf5ZRb8Wn6U/Uo9bgjvK2hTr2hokghuevueml9owpwQZ7dlUfa
         KN0TbLWuDUm7Fqw2ndCL13svFQTR48No287Fosu+xJPF9/FL2y2kXJbsiFq36cAXL32k
         B3SypCLMWG4ImJJCi70QKFJdGZVBK6hGX5y4aElydDAxnvdqc7uhKuBMiR0eDbgsCph6
         +m3iZbpm5sfD+rdh1nqioIIzx2rsK7ZJ80P/6xtAuEPg3Pzb2MZ4ppjivNGcHzaU5OJ5
         Ff8g==
X-Gm-Message-State: AOJu0YxTkw/qGsCsUQWloTy0h4hKUUbPmqhjB4oXTc6PY+jKCK6/0uA9
	Ne6xpZCARz4T9CJyGJ89usGkkyJr/yKfhP0E53YsSPz7kJizb/qUYPh+wnKvQis5
X-Gm-Gg: ASbGnct3z3XIOLndoRDW9e2va3WmwF+AsRgNbdFORLeex3IauIDrqOfTgx8WsXlsF9O
	3XFl0dfbgWy5RuD0/Rz2MSu32hRYw47xDxEw4ANsMztXlqnW5f8t+zQrnONsa3uMS2Wr9JvwTOq
	AYrq4g/30uzjWSHGueOP6+qXjIHNqukS8y9R0Gj3DpSBzKfmVoeV0z8saHu+TuE8lVSW0gexK4e
	Ee99GJlhFWSIJsAo6O8aFGEb8MDle8/eYygPHLzv8Y2FZbIMleT0+ydkZP7fthi4dkMQsfZBzut
	w5nUkJAKbchmqmufAMG9SKkMxfRsL4vsKpbuBnOGs2U+yizWmL6NM7aGebZd0r1srnRLfM7fiiX
	LAPxThHY9cW4P+Lkz7FSY9rZCrjUopXNQ4txry4rQbQnXhAKZcUQELa9aHdsKXWgR7VrrDFnkk1
	Is9kiBhxlbQCeGkulwL/ePkZdkcZJfWHTMhxFtfoUHD2b9lwCi+w==
X-Google-Smtp-Source: AGHT+IG+ddN8mxBjoti7lQo2fElGhWMrzNPTXw5Cw6TJ5qafor4oM/OrPXAkRjdPYH43+sgakmaqLw==
X-Received: by 2002:a05:6122:2012:b0:543:c44d:c1ed with SMTP id 71dfb90a1353d-543c44dc536mr2083921e0c.10.1756310771307;
        Wed, 27 Aug 2025 09:06:11 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5442e4c4e3csm1060135e0c.14.2025.08.27.09.06.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:06:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/3] Bluetooth: hci_core: Print information of hcon on hci_low_sent
Date: Wed, 27 Aug 2025 12:05:55 -0400
Message-ID: <20250827160555.1446966-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827160555.1446966-1-luiz.dentz@gmail.com>
References: <20250827160555.1446966-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the information about the hcon on hci_low_sent to confirm
all connection are being processed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5078d7de6a7b..ac49de2e7bc4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3435,6 +3435,10 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 		    skb_queue_empty(&c->data_q))
 			continue;
 
+		bt_dev_dbg(hdev, "hcon %p state %s queued %d", c,
+			   state_to_string(c->state),
+			   skb_queue_len(&c->data_q));
+
 		if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
 			continue;
 
-- 
2.50.1

