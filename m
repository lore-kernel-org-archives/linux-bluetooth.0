Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE25D8FE
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528961; cv=none; b=Z91/1QD2g0HqjswXsD0wAi6nI31AsGuTYsYKijYrCuIU9RdN6p6lF4gZbyKMLI93rZhcwdghX4WJyLzOPpSLRdxpptxOhJMioDqZEs9G14084ydScJn/2f5XqDYOGKHNYJJJr8qE8tuTTqOvFRXh1Vaqf8ArAtxg/tHJJAN4kqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528961; c=relaxed/simple;
	bh=tJ+QG345hAeqhkWfdmnPB882FgeVkgs+i41FMpoqWHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip8iFpTTyMAtW1ndI6FpWfjYHMFJUk1qxOpi9FpZNpLCofxR/vTYqzjtDax1m8e+oXrHW5TYWTvNi9dVK2oG2RaC+ZLVeo8PUx7a8LlNhrXwPEjK3Nw0vdXBDyQTHcQBiDrN+zoxxIc0RcgCKuHel1GeZuwg8MDJNJnoP9DN+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TNmmP1m7Xz9sPy;
	Mon, 29 Jan 2024 12:49:09 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ 3/4] emulator/btdev: Send page timeout after 2 secs delay
Date: Mon, 29 Jan 2024 12:48:59 +0100
Message-ID: <20240129114900.92919-4-verdre@v0yd.nl>
In-Reply-To: <20240129114900.92919-1-verdre@v0yd.nl>
References: <20240129114900.92919-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TNmmP1m7Xz9sPy

Real bluetooth adapters wouldn't send the page timeout immediately
when trying to page a device, instead it would take a few seconds.

Try to behave more realistically in the emulator and send the page
timeout after two seconds.
---
 emulator/btdev.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index da94f29d1..a40117400 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1281,6 +1281,27 @@ static void conn_complete(struct btdev *btdev,
 	send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 }
 
+struct page_timeout_data {
+	struct btdev *btdev;
+	uint8_t bdaddr[6];
+	unsigned int timeout_id;
+};
+
+static bool page_timeout(void *user_data)
+{
+	struct page_timeout_data *pt_data = user_data;
+	struct btdev *btdev = pt_data->btdev;
+	const uint8_t *bdaddr = pt_data->bdaddr;
+
+	timeout_remove(pt_data->timeout_id);
+	pt_data->timeout_id = 0;
+
+	conn_complete(btdev, bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
+
+	free(pt_data);
+	return false;
+}
+
 static int cmd_create_conn_complete(struct btdev *dev, const void *data,
 						uint8_t len)
 {
@@ -1298,7 +1319,14 @@ static int cmd_create_conn_complete(struct btdev *dev, const void *data,
 
 		send_event(remote, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(cr));
 	} else {
-		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
+		struct page_timeout_data *pt_data = new0(struct page_timeout_data, 1);
+		pt_data->btdev = dev;
+		memcpy(pt_data->bdaddr, cmd->bdaddr, 6);
+
+		/* Send page timeout after 2 seconds to emulate real paging */
+		pt_data->timeout_id = timeout_add(2000,
+						  page_timeout,
+						  pt_data, NULL);
 	}
 
 	return 0;
-- 
2.43.0

