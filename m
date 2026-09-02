Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819814AE12B
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385595; cv=none; b=T7x8eml0lL13ieQknIKzlgs3Bnye7V2uLld6PLmQ3UlzEpt6NGVldUIPyP78CwjxYsDYWAzfu8OL8Sskgfn5MwAEnvaBDgKG38Yiq4CCQMlvnu2KZIKCcWWUMKjFDCNIeufNVNRS1Vs/d5z2cZHNFzrvO+AXMZfsEUZnK6SMlog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385595; c=relaxed/simple;
	bh=9uZkSu2cjrOgHddMn+ZBNFZgxXM9f6xK8iKAEAoeI7o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GuGMhFY+89BMJoL+xM0h92EDpJKzBh8EzGcqgcu1+hzo52Hx429tU2vmY7VJ5b8fnqkfcWb9cC8MiSIl72KKMBuaGWMGQGtTBbDFaR34WJD1c44JsXxYGFo71TUxC+XBUMY0eDBgZs3G9JEnP1a0y0w4764+4kWwIlAXBazzngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4N/pu++; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4N/pu++"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c7d65c83feso992677e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788385587; x=1788990387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/72GeAIOpssvVJ/dMk3hCHoUrQM7pCiM3uu3xzIHCVw=;
        b=s4N/pu++KUG4n52mrW1PBHEmtU+LDzx5247WISwFb4fjyJjZgNpIdjVf5y2ky9kj3X
         8JNoq89FiOfbf9WcbwksgI20ij0RbIE9NxlA24fn+oXv/lIS4OSG11l5nfWUZo7K82D2
         ub4tfbmYLp3C7miKxlq/D5I4IOKyGYKaa2ZKqbU7B7wU6MMFYwE2zeUqz3F8ZfPTSHa9
         GKjqpLlsMOlhebZnhP8QIDRBBVRgCkG0fOMvbQNkZqNNpwtozunUdYKWAMnAVJwck0yf
         Q+408DH2hkpV8t/qNdPv+o6dIZaGS+IAnmRjaJckZrCcCkmzWgHsvkoNMUNAGcEssPu/
         m9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788385587; x=1788990387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/72GeAIOpssvVJ/dMk3hCHoUrQM7pCiM3uu3xzIHCVw=;
        b=GM+DCnEDE/U3MP2C4cn3rcY1WWAHPpXl4gD/e5y+zAiAo9i4igQeNR8T1HHfBWW7rU
         jKsdlNnbJ5wYrNXVft/gEquTN/Tw32Lr2tr4QwVr54quuTEayd2Rz0LlqAbctgw0upVi
         D5J5Z46+PWqE73IOc27IoEeiYFeW8g+4YVelyiB6a7UoixWEOJq1ec9Glhif8JL2DPHb
         64TXOYWbapUB4OBASYufSCpa4ENORp1ksHMngW5l0L4WzRi7Vxz/VR8pw+OrCpqGx5an
         TDWpv2D/KGE0ZIuOTW/DxVKnUXtm3rsIj/IPPQJHO/QXCoMj0ntDWcvDyZyq2nnaut1B
         DrYA==
X-Gm-Message-State: AFuF++ktYMY6pUy9RacT36qy9twtWtmy8FFQhVpY/nO0wuNZvcj44hyh
	IbpyjHLwI7TxePyUGaLc8rIltQnJGNqzFzGgr8Ba+4evvTAhoxmtoHcDXPEc/R9TLOY=
X-Gm-Gg: AYBFou1LA8fzudlqyYqVdgImfyMwSCG1NJGfOkEO8X20e0tj5c4bwDfIY3287ZH6MJl
	h541yC7NSrsXVrmqyXRxC+baean7gMgzi74ZqMoYghlOekzwue3O7fxzXuV2nLtl0eJ9RftABSv
	yUZvOGmPKrDlgYNBiFLTifT0PMUbLR+qOtTIBC6NjYRjuOjsM3x/XvsM5StmFRVLPGRzLlyBap2
	/InRyOdlqUNpuz7Fd4OAiBNzkENWzDqxF78E9Ktk7FCdaacEVz3pGnDV97O+kWumSy323H7qntS
	hZ7mrs04bhaWiSXP9o8/5b1IDfwUlVkxJzxNcNdl81FRNLviPOvfBSQcUWiAY+rZMxtyOvK/pjy
	aqGddn3zLzaLPcWhSxjGiU6y2KfWrb/Jj/EmsYbnM+RaE5F9A+FKxIgwu1bJrq5uCG6xNDDYyvL
	9BF4EjbjJAPsjVG44PVOFeay+DKrOuoTDAmIIt8/wHSCRnmiXrmKOQ5B4v9J6rbNrRo0oWQmyTw
	HLSOi8dKIGqkS7jSs4JCy9tM7DGDiap7874b6oawumCf6KTpsGU2kA=
X-Received: by 2002:a05:6122:e182:b0:5c6:6da6:7ce with SMTP id 71dfb90a1353d-5c7d276f99bmr3675718e0c.3.1788385586617;
        Wed, 02 Sep 2026 14:46:26 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd8fda9asm3219583e0c.14.2026.09.02.14.46.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:46:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] Bluetooth: btusb: Fix UAF of btusb_data by rx_work
Date: Wed,  2 Sep 2026 17:46:18 -0400
Message-ID: <20260902214620.44041-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btusb_close() and btusb_flush() cancel data->rx_work with the
asynchronous cancel_delayed_work(), so if btusb_rx_work() is already
running on another CPU it keeps running after the cancel returns.

btusb_disconnect() calls hci_unregister_dev(), which invokes
btusb_close(), and then frees the btusb_data. A still running
btusb_rx_work() then dereferences the freed data:

	while ((skb = skb_dequeue(&data->acl_q)))
		data->recv_acl(data->hdev, skb);

Use cancel_delayed_work_sync() instead. In btusb_close() the cancel also
has to happen after btusb_stop_traffic(), otherwise an URB completion
racing with the cancel can requeue the work right after it has been
waited for.

Fixes: 800fe5ec302e ("Bluetooth: btusb: Add support for queuing during polling interval")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03039ceaa77d..b42963417213 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2096,18 +2096,24 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	cancel_delayed_work(&data->rx_work);
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
-	skb_queue_purge(&data->acl_q);
-
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
 	clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
 
 	btusb_stop_traffic(data);
+
+	/* rx_work must only be canceled once the URBs that can rearm it are
+	 * gone, and it must be canceled synchronously since btusb_disconnect()
+	 * frees the btusb_data it dereferences right after hci_unregister_dev().
+	 */
+	cancel_delayed_work_sync(&data->rx_work);
+
+	skb_queue_purge(&data->acl_q);
+
 	btusb_free_frags(data);
 
 	err = usb_autopm_get_interface(data->intf);
@@ -2133,7 +2139,7 @@ static int btusb_flush(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	cancel_delayed_work(&data->rx_work);
+	cancel_delayed_work_sync(&data->rx_work);
 
 	skb_queue_purge(&data->acl_q);
 
-- 
2.54.0

