Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9B45695
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197265; cv=none; b=VW3pSWyXrrNmFMPp5YT8fKJOtCq9d95awKixs2MIoHyoMCznziitv6mtHC+v7UFhmQ2E7BcWSu4aHfYQk1pcHSjCTIzwkH1lbQoKPw5UQfvTX36TjHFBdzYylNLkNwpSfy/PdM52sxcdCQh6XT3vIM+8WFtDrdHrkqyLvaZLDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197265; c=relaxed/simple;
	bh=LoFGbRBxk7ItLcSgnRNxvsWtHdzzrMfOftX6GO5tzAQ=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=rW+MK3nsXoV5IRYT7jiKWp+sfyAC67LYZGe4U/hVIyJjyIfpn4NqqwliKjUpm/XLv+Wejt2ionL83uEZcOQOmNdkIWADRtvJ/BxoSRX0rBJG/0tAsc1qwtUmRKO2cEty2ldSQjHd01o+slU2ojIxWXjgp0Uvhwo+Bhuzh6VxRik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dQ1d76P3Sz5BNRd;
	Mon, 08 Dec 2025 20:34:19 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 5B8CY1BO039691;
	Mon, 8 Dec 2025 20:34:01 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 8 Dec 2025 20:34:04 +0800 (CST)
Date: Mon, 8 Dec 2025 20:34:04 +0800 (CST)
X-Zmail-TransId: 2afa6936c5bc672-7632c
X-Mailer: Zmail v1.0
Message-ID: <20251208203404000bLAos3jnZFMsLDRmqZb_S@zte.com.cn>
In-Reply-To: <20251208203056891J84Xq6wiMu3r7HXa_mRb3@zte.com.cn>
References: 20251208203056891J84Xq6wiMu3r7HXa_mRb3@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <wang.yaxin@zte.com.cn>
Cc: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <chen.junlin@zte.com.cn>, <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?W1JGQyAyLzJdIEJsdWV0b290aDogaGNpX2Nvbm46IGZpeCBXQVJOSU5HIGluIGhjaV9jb25uX3RpbWVvdXQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5B8CY1BO039691
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 08 Dec 2025 20:34:19 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6936C5CB.000/4dQ1d76P3Sz5BNRd

From: Qiu Yutan <qiu.yutan@zte.com.cn>

The warning is triggered when conn->refcnt is decremented to a negative value.
Since atomic_dec_if_positive(&conn->refcnt) only decrements the value by 1
when conn->refcnt is positive, the resulting value will be greater than or equal to zero,
preventing this warning from reoccurring.

Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>
---
 include/net/bluetooth/hci_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5e01e6c501c1..2b306115add4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1635,7 +1635,7 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 	trace_hci_conn_drop(conn);
 	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));

-	if (atomic_dec_and_test(&conn->refcnt)) {
+	if (atomic_dec_if_positive(&conn->refcnt) == 0) {
 		unsigned long timeo;

 		switch (conn->type) {
-- 
2.27.0
