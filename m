Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3EA12DDBF
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218595; cv=none; b=KgW7d3jvGtC4HQtjz3BmrIrLr7O4dG4Q+SW0zH2ZWcroWKuNaHxGZHQmgxGKi+aIyifBtTN5o0Fe8nsVTyXQ8NsN/UpzURzI9xxb5fnA50S+UU9FJUIH5Ee8o2cWWnI8lauXP/BB8Dhw3ryMX4URdFORNC9B/P/TljbJUh+7tes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218595; c=relaxed/simple;
	bh=Sc8PWzUi9/KlVw/GmVTp9nSfoCrASQlbge540XJSr9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du7FcE9WmlxWb9qoh12S03+1Y/7uoByblgCKHGjUKRvNftV+Ce7jga98zGuSFwB48x/eKVz5FpmnEzNTzLUy7cR7lgUkPfvxdH7yDQhJzPY7RP6xhBbCIL5DLOBODa9nn+GbDl+hAQhasx/47rM72DwaxK0bJvc2YWYZte0SA6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TTgpk27q4z9ssx;
	Tue,  6 Feb 2024 12:23:10 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ v2 3/4] emulator/btdev: Send page timeout after 5.12 secs delay
Date: Tue,  6 Feb 2024 12:22:52 +0100
Message-ID: <20240206112253.76446-4-verdre@v0yd.nl>
In-Reply-To: <20240206112253.76446-1-verdre@v0yd.nl>
References: <20240206112253.76446-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Real bluetooth adapters wouldn't send the page timeout immediately
when trying to page a device, instead it would take a few seconds.

Try to behave more realistically in the emulator and send the page
timeout after 5.12 seconds, which is the default page timeout.
---
 emulator/btdev.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7b67e9430..6bf0f442b 100644
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
@@ -1298,7 +1319,16 @@ static int cmd_create_conn_complete(struct btdev *dev, const void *data,
 
 		send_event(remote, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(cr));
 	} else {
-		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
+		struct page_timeout_data *pt_data =
+			new0(struct page_timeout_data, 1);
+
+		pt_data->btdev = dev;
+		memcpy(pt_data->bdaddr, cmd->bdaddr, 6);
+
+		/* Send page timeout after 5.12 seconds to emulate real paging */
+		pt_data->timeout_id = timeout_add(5120,
+						  page_timeout,
+						  pt_data, NULL);
 	}
 
 	return 0;
-- 
2.43.0

