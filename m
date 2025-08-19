Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E241F4181
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612851; cv=none; b=fU5kFPlK5lbtIpr4OiQ/qGLY2CLqJCov6Y1RRgPfJMU9G3AXj07Dkn4r/JmrafsnZWYz3k1BegBTd+rRBMMlOhtQg5B16F3TT1dNFnhxmZkqFR+w0yjxu+TWeLsggOEG+LKh5WFgNH9Yn451qIbKpjIv95k73S6VQnRXvRI6T/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612851; c=relaxed/simple;
	bh=jnztzumPCxiPPc/BSAf3asZ012v8I6kYbVk+fICq0aU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=RRmp+L5m+vIHMoFou8YXlOBGqVCwKIfk6Hh7Ynvtqr5H0+pKgZGT8ZS6XJF9QUfHGjai3cWAvyM+Y4yzKeGLg9wqe2HqnL1yRuQ2jQ0BLh8MzGbLuYIXjHpV/dFbpbIeneo3p4mjsKfFKp2WsxpqM1KuidlsnPF8K4zgBW9Y4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4c5s5F4pfWz5B0pS;
	Tue, 19 Aug 2025 22:13:53 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 57JEDnIS060666;
	Tue, 19 Aug 2025 22:13:50 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 19 Aug 2025 22:13:53 +0800 (CST)
Date: Tue, 19 Aug 2025 22:13:53 +0800 (CST)
X-Zmail-TransId: 2af968a486a1ffffffffba9-d944f
X-Mailer: Zmail v1.0
Message-ID: <20250819221353357gfKAFq93zfeYcRSTpGtBB@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <luiz.dentz@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>, <chen.junlin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LXN0YWJsZSA2LjZdIEJsdWV0b290aDogaGNpX2Nvbm46IGF2b2lkIHF1ZXVlIHdoZW4gZGVsZXRpbmcgaGNpIGNvbm5lY3Rpb24=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57JEDnIS060666
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 19 Aug 2025 22:13:53 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A486A1.000/4c5s5F4pfWz5B0pS

From: Chen Junlin <chen.junlin@zte.com.cn>

Although the upstream commit 2b0f2fc9ed62 ("Bluetooth: hci_conn:
Use disable_delayed_work_sync") has fixed the issue CVE-2024-56591, that
patch depends on the implementaion of disable/enable_work() of workqueue
[1], which are merged into 6.9/6.10 and so on. But for branch linux-6.6,
there's no these feature of workqueue.

To solve CVE-2024-56591 without backport too many feature patches about
workqueue, we can set a new flag HCI_CONN_DELETE when hci_conn_dell() is
called, and the subsequent queuing of work will be ignored.

[1] https://lore.kernel.org/all/20240216180559.208276-1-tj@kernel.org/

Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 include/net/bluetooth/hci_core.h | 8 +++++++-
 net/bluetooth/hci_conn.c         | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4f067599e6e9..9a3ec55079a1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -954,6 +954,7 @@ enum {
 	HCI_CONN_BIG_SYNC_FAILED,
 	HCI_CONN_PA_SYNC,
 	HCI_CONN_PA_SYNC_FAILED,
+	HCI_CONN_DELETE,
 };

 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1575,7 +1576,12 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 		}

 		cancel_delayed_work(&conn->disc_work);
-		queue_delayed_work(conn->hdev->workqueue,
+		/*
+		 * When HCI_CONN_DELETE is set, the conn is goint to be freed.
+		 * Don't queue the work to avoid noisy WARNing about refcnt < 0.
+		 */
+		if (!test_bit(HCI_CONN_DELETE, &conn->flags))
+			queue_delayed_work(conn->hdev->workqueue,
 				   &conn->disc_work, timeo);
 	}
 }
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 549ee9e87d63..67a6513bb01c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1112,6 +1112,7 @@ void hci_conn_del(struct hci_conn *conn)

 	hci_conn_unlink(conn);

+	set_bit(HCI_CONN_DELETE, &conn->flags);
 	cancel_delayed_work_sync(&conn->disc_work);
 	cancel_delayed_work_sync(&conn->auto_accept_work);
 	cancel_delayed_work_sync(&conn->idle_work);
-- 
2.15.2
