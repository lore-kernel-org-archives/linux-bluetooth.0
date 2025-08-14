Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545326FA60
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188707; cv=none; b=EJf+DN4T7pjdw9QuRsZHP3iBOpYqfRUMIbVpnrZGQlDPqOaY5Bg+iVk+rTV0P7NluO1XKKpk3VVV5saatYnVutIhsmhbifIZfXG7UkVnAXAipitefr71e2qE+c6gBwgzFJPAMdyI55mW1aMqrratAOCnhtBv2tX+UJ5d5gyw32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188707; c=relaxed/simple;
	bh=45EhbU83eGEjaXni7oyoHpERWF6jKZunAhIhANJhDjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmZB1aXqjcNEtz+yNcQwDPLQOfxEM7GF7t1jIQn4ZNt3lSXsjFhQSQi6argBupg9EvDOOioceIq7/07j3qBKzbiiZurT8TZn5c8qVrH2VmfemVPJ9nK+WMlHkJU2H9rVCGYjribxawRQnXR67J8e4kqDgu4ZQtGDdJhyI28nHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+abFmwc; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+abFmwc"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-890190c7912so301298241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755188704; x=1755793504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEbZ9b4yT8JSaZOpPFoUZX/aMz9MnNiIOS9LSUiSGQQ=;
        b=V+abFmwc1G02bOubT6/QSqmJYO4e/dkQtaeb4GlqbA9TxC2dI6RuBMHr8WtQRV5sSN
         Eeywmin9DEb4GxJDx/DSHCDmBmxoA5rVDyXtXDblYz+/VK22/c0vJIDEvXDZRCwGagmc
         vEtwQ1JQga/ktB34oieYM8kvNwxzIv87yGkcYBzkKzzTpzpNzWDrE3uW7J2ZPxPReDuI
         U/h9zhNW5HlW3FeHkW7x1rUqhaF4clfPY3jai8nJ24CNu3SV7NnUlpDvu+JBVLOruNuq
         podS5H8LZ6v0hj3amc7Hz9MlyJU4q+p1++uKdnsa92+EiDMwMK0oy17ezmWCJyENdOtW
         ggcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188704; x=1755793504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEbZ9b4yT8JSaZOpPFoUZX/aMz9MnNiIOS9LSUiSGQQ=;
        b=iXelQuzdnbOMyVGozCaLOongkOzsPLXjdg3vn3Iof4Ie0ejXFXqrrfdNebcIES3F1C
         f62n9zMtrvct5Eq+iM+qF9/ANJvts0N5O5XB/3jtBhivLlaxjLMCsWRe6OHKzDDpSgrn
         qw6pSQdM3LZ/z9ROR/kCiqlEBZrmhwDFaqezO7LdFdODPWcZH1lS/3Zcn9HqZIg1QCGv
         YuCH2+JXXgEgNK6vWD4Sn6M/BBagHsoKHhEz/1VY7BNyDaNNJNFCB6ylyUBafmWEy9KT
         wBZMjwNypZp+mhFfIybm29iS0xCVizU5LUBlOCZ+FQvVmoeWAPz1da2UtvZylTAEStPY
         MyQA==
X-Gm-Message-State: AOJu0YyMLxw/a1mPah2jKRmvuPK9GeZlubWag58nCw6xHy6D8KP3HkR7
	Ot5aGBUjfDMxEHbPIVblpChGFf08KteedXO3y1NZkux5YFoSYoR+PliR9hiS8qV6
X-Gm-Gg: ASbGncsPPv1yiwaq96LPQ2YPojvUy55OUseQSFv5I5yktzt9rxB9CweHvMCGS0OeWG8
	gKgYzMBACY19DLC4BTVdBYTkZfsgHkxGqy4f7DOQOHZAUJTqCsgcZ4dW3EyfaL3h0s+e+em4B2n
	OJjsRmAE8XZixZ0dHcYVceJ8LnfPnfZbfXQNKKW4ggYhsAaegoPx5X3cyNRjPTZ8IVYOqzwC4H8
	V3lVo1JCQ3k/B/bpkW5YonJ0gt+8INVZsiF2s4ZbhGmtn/7n7JhQa3PKK1At4rvwm83cQIN5NXU
	DM3CLquc5i0dyjjPBvs52iTOmZhYk0O79o+mlNYV4VJxjUP+OAoqTJ0YZzJIlgXpLPF5Q57HAIr
	DN+SLXWz/NiGuU5bPnc1y4if0fi7Uu4EkhxsXabyaE1NP2kQLQISC+KylG0BOYj41
X-Google-Smtp-Source: AGHT+IGSv6vpD3yTaED1YMh36f83t2nhmMuP13e0ZAyMUrVcT6/W0Qzrk+klHCQJEdPHbPq3pmhAZQ==
X-Received: by 2002:a05:6102:54a0:b0:4fc:817:dca8 with SMTP id ada2fe7eead31-50fe9d81ac8mr1728237137.16.1755188703921;
        Thu, 14 Aug 2025 09:25:03 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e57924cb0sm969037241.8.2025.08.14.09.25.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:25:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/6] Bluetooth: hci_conn: Make unacked packet handling more robust
Date: Thu, 14 Aug 2025 12:24:46 -0400
Message-ID: <20250814162448.124616-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814162448.124616-1-luiz.dentz@gmail.com>
References: <20250814162448.124616-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to make unacked packet handling more robust by detecting
if there are no connections left then restore all buffers of the
respective pool.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d2324eb1211..3ba0d0bee48e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -149,8 +149,6 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 
 	hci_chan_list_flush(conn);
 
-	hci_conn_hash_del(hdev, conn);
-
 	if (HCI_CONN_HANDLE_UNSET(conn->handle))
 		ida_free(&hdev->unset_handle_ida, conn->handle);
 
@@ -1151,23 +1149,47 @@ void hci_conn_del(struct hci_conn *conn)
 	disable_delayed_work_sync(&conn->auto_accept_work);
 	disable_delayed_work_sync(&conn->idle_work);
 
-	/* Handle unnacked frames */
+	/* Remove the connection from the list so unacked logic can detect when
+	 * a certain pool is not being utilized.
+	 */
+	hci_conn_hash_del(hdev, conn);
+
+	/* Handle unacked frames:
+	 *
+	 * - In case there are no connection restore all buffers to the pool
+	 * - Otherwise restore just the buffers considered in transit for the
+	 *   hci_conn
+	 */
 	switch (conn->type) {
 	case ACL_LINK:
-		hdev->acl_cnt += conn->sent;
+		if (!hci_conn_num(hdev, ACL_LINK))
+			hdev->acl_cnt = hdev->acl_pkts;
+		else
+			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
 		cancel_delayed_work(&conn->le_conn_timeout);
 
-		if (hdev->le_pkts)
-			hdev->le_cnt += conn->sent;
-		else
-			hdev->acl_cnt += conn->sent;
+		if (hdev->le_pkts) {
+			if (!hci_conn_num(hdev, LE_LINK))
+				hdev->le_cnt = hdev->le_pkts;
+			else
+				hdev->le_cnt += conn->sent;
+		} else {
+			if (!hci_conn_num(hdev, LE_LINK) &&
+			    !hci_conn_num(hdev, ACL_LINK))
+				hdev->acl_cnt = hdev->acl_pkts;
+			else
+				hdev->acl_cnt += conn->sent;
+		}
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
 	case PA_LINK:
-		hdev->iso_cnt += conn->sent;
+		if (!hci_iso_count(hdev))
+			hdev->iso_cnt = hdev->iso_pkts;
+		else
+			hdev->iso_cnt += conn->sent;
 		break;
 	}
 
-- 
2.50.1

