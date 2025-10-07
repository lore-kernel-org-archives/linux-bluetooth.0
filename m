Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025234BA33
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848598; cv=none; b=C3Wc9ZdHV2XQBmlAUN9zHZh7gl4qyDo0pt34iDRIfNeycUpraBX8ZqldAb6oyRCk1uT/a5HyZnJpFk//r0VZg4yf8HaIAUyI9sPtjbJRzzWV4iiAEYZ7jFFlOvo7xRrXX+y+0CZLo+E7sAarnKxWkuPonplsupxt94DhfzD/k/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848598; c=relaxed/simple;
	bh=+s1Dp/WkcumV/oeMpwET6T/N7C9sGo8Ngqee2YkBjG8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k63tbRN4O9ye6FxPTkL4GBFvV9PZNEUpheANwvj+TwzAkZIT5aDY2G1MZCStQwEaF/jsTC+II218YQm9Ph3TI7+d5QiG1CfAyQhGSn/y3JPwzuVZ/4Be3XLHfs4LSZb1P9dzPwrkUhlIshGYl5ephUUUugUBUyxeShH6Byb4yzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ0NZZo1; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ0NZZo1"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so2288250e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848595; x=1760453395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPdK/0HQXSmO9b4ioplGtKdjqi6NNmvSFZMhPPRCqfM=;
        b=mJ0NZZo1E49x+MP/NevA71X/tcCHl+1ZEvMuiHkl7rKgBlvXxC/JmuurjHzkQCRG90
         QfSmbeIHSVvHMK9xrFCeCIBEOyTiKP4nttlu4OGIOUKg9GfCQut9G8CkhXflGqnZkFFq
         JzZZQE9x3l1eopnSyqUXI4XJq3cdiPIU8HHNNnXB+3FHWNRXDwWrJkzHZDUHdzUK6qhI
         mn5UboNVZXb0Sar19hYflg6bEdUEtKoo0Dy6Oq6slP0kFubImep/d1Pstzz23T/HDuDu
         9Zg5Kwu+P5raigkVUtMKA476l1Fozrk6FynxmxcZDGECzsrsndt8zJDOPa4AnNb41BGC
         5r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848595; x=1760453395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPdK/0HQXSmO9b4ioplGtKdjqi6NNmvSFZMhPPRCqfM=;
        b=UfSYYoY0YonAKQnaBWcFGSYF4fMsEmEaPB1m6hFJaTQFrFKs0aT3SaVa9xjWgKulgs
         k2KUpdTUCzKY7lkcGf2R0FEC+yLfQdf9HCpGl+csNlRlHegYu8th7p7x3SASuNZnAjo2
         hZ0npxEGBaCwGyYOoGHk4c0Sj6qftqUhzl0gmHRG6sc8GdMhmfstGUZSnLgNga/aZW6t
         WGyaTSQ3hHHKjbxc2wgZuuuNfCahUb/Hzh13dNJKRaLUrxG64+Rg7ckP7ZvaG78khRx8
         OOyUsmXUs/teGOhjLj9/mr5JtPOdbV65q4MIQzUk4+kGJdv9SzNxMx3KvsYpHlnQM0I9
         828Q==
X-Gm-Message-State: AOJu0YynrUaLbizVGxKJNugougC+XD92CbuLCxrDWltmMCNJwppbZiPz
	AK41mXX5//vx1pcfkFf8gqdfwkSi/QmdMblyeiJ2xvwuarbSl1ti98DEX16yfQ==
X-Gm-Gg: ASbGncvWnqVlK5nBRAuO3Si6GMPSdr3fR/ILXBrJqKeIRcG5QnqN1f7wWDhnjvO1XTy
	qnY+dJ0VxtFUZFwqk74cRcJPIU1sz+mhUeDwPT8W5h4hjOT/zoOAfv5bFPhGRKGvYJmnZYJbOZ7
	ZRIJSBC42zZlCRsjqGk67wT2gzmLtAIef6bQPX9AbR4q7GR7rqZS6Tneyz67h7kNJxrBaar+ACE
	W9B+1ai7r48taEcg+OVwyVgUyWGzW9OjVx9ZjF+7D+hauSewMYpqyvje85fq0X8zqd3YQgXGPSy
	7tMYTPPGw8iP1P1k85ltCBuzYecFFZSk5q3O1Q0n0sLRLpDeldT7t/wbWZG2oxi1m9jxxS9DkSm
	nZQiTgqxbjmRWR8HGDvleN6AM4JIzYqzpJdZwvqaJT5mIx4IYi6Inn0ZMqDlihjIo8vPOORt7l2
	F4O+P3YiMmo7FooQ==
X-Google-Smtp-Source: AGHT+IEgNtK9HOc3cTgiK4PbAj+KcuIgWgogFv9VNU+w9VL0x3Io2rSkzn60A8Oz2J5bOGnbzBsf9g==
X-Received: by 2002:a05:6122:1d45:b0:539:2a2c:6efe with SMTP id 71dfb90a1353d-5524e89110amr6429445e0c.4.1759848595261;
        Tue, 07 Oct 2025 07:49:55 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce64af0sm3731864e0c.8.2025.10.07.07.49.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:49:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/7] Bluetooth: ISO: Fix not updating BIS sender source address
Date: Tue,  7 Oct 2025 10:49:30 -0400
Message-ID: <20251007144930.1378274-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007144930.1378274-1-luiz.dentz@gmail.com>
References: <20251007144930.1378274-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The source address for a BIS sender/Broadcast Source shall be updated
with the advertisement address since in case privacy is enabled it may
use an RPA rather than an identity address.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 83cda8dad4d8..817c7ef1ec68 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2014,6 +2014,25 @@ static void iso_conn_ready(struct iso_conn *conn)
 	BT_DBG("conn %p", conn);
 
 	if (sk) {
+		/* Attempt to update source address in case of BIS Sender if
+		 * the advertisement is using a random address.
+		 */
+		if (conn->hcon->type == BIS_LINK &&
+		    conn->hcon->role == HCI_ROLE_MASTER &&
+		    !bacmp(&conn->hcon->dst, BDADDR_ANY)) {
+			struct hci_conn *bis = conn->hcon;
+			struct adv_info *adv;
+
+			adv = hci_find_adv_instance(bis->hdev,
+						    bis->iso_qos.bcast.bis);
+			if (adv && bacmp(&adv->random_addr, BDADDR_ANY)) {
+				lock_sock(sk);
+				iso_pi(sk)->src_type = BDADDR_LE_RANDOM;
+				bacpy(&iso_pi(sk)->src, &adv->random_addr);
+				release_sock(sk);
+			}
+		}
+
 		iso_sock_ready(conn->sk);
 	} else {
 		hcon = conn->hcon;
-- 
2.51.0

