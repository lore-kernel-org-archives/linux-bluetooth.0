Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99652F6920
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663804; cv=none; b=kImm9Cjz5IeoHZ8tcwUGAUYitPq+3zeFzNf6hnOXG3pfyorXEnRA6kXhIZjm4nTPLZ0znPoHzpOk/YgxT+jb3J1Zx7bysEBMT4EHRCLNr4HMQIi2AYIzH1vX1xMQgLmvH6ZUOgqyk+RmhX9lkJ5gVlO1xEJNAWq2YiESL+yDnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663804; c=relaxed/simple;
	bh=i64MSDYyFzPyBbLpNKVNZhYZXEBSwKU3pR6fwhJeiDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zl8ATxP7cd0top0DnthEp2bzmuwLFNs04n9CX/LfWoBNmTkYPpMxFqc2q+S55HUryI8lpJ1iZn/x1ERubl/G+rywR9nFwOt/rYM0NKdJBpLyHRd44kgG59muxS/gfWVMOvroTLw108+38+2xr1lAG3bPQR6by3HBBUf6M6K2Yu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRdTsrKE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRdTsrKE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b0046078so36275655e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775663801; x=1776268601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bydB5v4DzzNRJHgkjndYYKtbbrYjfgIG1NUJBAofkc=;
        b=sRdTsrKEWA4H9XkJoD6vBRuI6K7heHKLhdE4nKI6lSYaCxYPZJm4LUv4b6pPN3lcL0
         RHv76aJQnchnHEAEYxKqjPil3wBMvcV/cjbkgclXqeAmVsOOyL2ZCJ/z0Oa8Jyikay4n
         3q0U/V3rpghSkPK85Kg4g3+G8d+xf8H8aT+XS7Ba9fhnvdHtTc3nMqCCNcBdEJlefZQu
         jhYhxAEslCI/EXGkMkdEkOFrLoX7JeODQIyTBPyEpBRoMJnZ+F8fTkLquncEU3h6WPgy
         u+YKnGL/U1IEiqdK3a0aZja4vO29hctr/TuO06TG+JYN72GdBr+4hueWqo7UYS+omFDe
         IRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775663801; x=1776268601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bydB5v4DzzNRJHgkjndYYKtbbrYjfgIG1NUJBAofkc=;
        b=X6FKGnfQR+P1IM/CO2/PjtauOe9DDVZyQibeBb2Wz4wNtK5LOv+4PxmkofSscOj1uZ
         Cp96Byh2Jd2jd8NZqPqtioVguXSOtOT2V6W/NNGTQgRSTBHxozy6LNmJxA7E9yZE4aME
         fUg+RQN9Em9l2SPcrvjj0Xg/TdOxsOdNr7Q5AoYIRNcAQwwuwxvm9+0QYk80EeYUvct/
         rTDzBqswJkyB1nol+q3p8eiBxDk9ZYwS+0UJ8/2upoqim0DGEy9ZwfDw/Tt65hbMysqg
         B6QfzO+ouoZO82MXsAEdfxOTX7tdLA60xxXSAxNcGtJbLekAT084BzRJ1uTXtw5BwvDf
         ihGA==
X-Gm-Message-State: AOJu0YxG7GaZb5kR8sL0Bkw22D8/u7hHyGEARrU26NaMM8+5z4DL7ofX
	w+UPmIpi02L1f5RPCDNL3FTrgAkTL7raSAzyNGnhJ+YxeV0Px/NkJv3E
X-Gm-Gg: AeBDievxo4pzb5MrcTHm499CClwzwM49uLG3DFTN6XNg/hlvyPVDn/61QR/nGcmWJgS
	oRQkQ7vCBJiI9AjvECqhC9GNmvFyf36glKQujnAmtmhx9wtNuB9N+aTt+64xU4FCl7WZRwxrDiO
	gUZ4uGrCbvdKiv+n45o5ETATResdrPkm1HPqqOgOOJUndwWKPc7lGm6a8ZOem+U0q//DXwSqa6l
	RyRkDgsRwwLMK67MYJsbcr19N+8/Ic6qMa7ZTPFaDQ3D6OWIaMv0MvdGeDkmGtna4nvyNvzpQWu
	Sh/nNPnTpgAAhLRmYY3a5pP+Sv6S41JJW5KMUdwBJk8qcQsuwX/FrZWLuDY9b8K62GXIMNE8Hsw
	kbTyv8tgWGAERVtlm7Q2faixx7y/lIoKCi1RAcso2h4h2FgtvNqw8RFkI34VVZ8wyCna8WyywGb
	yK4NEeqx7sCTbC6CBCUPnGx/LIDbVhJdX2+Qehp+oYjIqU1ni6G2vwNsaLdtGpJOHTJsPsArBI6
	9IshLhm3Z/h
X-Received: by 2002:a05:600c:628e:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-488997d94e0mr288446605e9.31.1775663800844;
        Wed, 08 Apr 2026 08:56:40 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd19ea83sm3372565e9.1.2026.04.08.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:56:40 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] Bluetooth: hci_conn: validate connection before BIG creation
Date: Wed,  8 Apr 2026 16:56:38 +0100
Message-ID: <20260408155638.95927-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing hci_conn_valid() check in create_big_sync() to prevent
a potential use-after-free. The connection object passed via
hci_cmd_sync_queue() could be freed before the async callback
executes, leading to a dereference of stale memory.

All other async callbacks using the same pattern already validate
the connection (e.g. hci_le_big_create_sync, hci_acl_create_conn_sync,
hci_le_create_conn_sync, abort_conn_sync).

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/bluetooth/hci_conn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2551..be522fae0058 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	u32 flags = 0;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	if (qos->bcast.out.phys == BIT(1))
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
-- 
2.53.0

