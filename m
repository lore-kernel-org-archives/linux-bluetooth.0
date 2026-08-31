Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAF361959
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194484; cv=none; b=DDWB369MneCb/jYcKIlPjbHdCtG8a2nUmOIpi6RIwvwcnG0iQJp7fEPbCx604AbKGI2/BHvY0FlVBG5elRaBZcbnigdt1kbEfNSx9ObXkvE5axRAYHz7cMf0rc1CzM/++H6Hd0gWqV05pgof207aqz7oNcLSdvpTnV8Hadp07WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194484; c=relaxed/simple;
	bh=jCVHJpE9I2v/SYGTpH8qRVi/sqv+T+WDYBMmp46XjzQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GAjpBaKb3aIQRI4mS5yJfs89VUsomCLx24wV4H6pDyxY0Sbvdxcg1aAxs9ZqvxB8sH/SiEa7sIER4bXjnQzpT2AdRF1D5QlBMuFs9C7hzXxvBWOdM3rzcFIZTCUY+tEsMDIeEQdSFSlwia/OdvSyKB/aDWCunUUWpzS2L4D0SHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be15oxZj; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be15oxZj"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c7991578c2so1156018e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788194482; x=1788799282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WPPz86V9yd+3O/uWX2wEC0TlJmb2q71n7rhNcr2wyB0=;
        b=Be15oxZj1Wv+pHzh1Y6iRcfeWoNaRASugjJoCZhKTlv/hE9XmS/ah5lVkzchDGbcLG
         8gIR2sEAi1R/ibxFdUS9BdiAVWpD/rWvj/7eC8jhS8cSXnmu41cWKzHjCypUSIX0cV9r
         r6fhDLwu7mbyofm4MNKtUqmiq8gikl+1duQh+RpundZGvtQJX28MnSxkYM4pDNdQApt6
         MvSXBk+4MC+l6+VMNu6y1/DCQBvEZIQw5BPPY9dbQJyihlpth51QegtUP2ltAu9XqAAx
         /SSiOi9/rr2FiwY/5VdV3LilxaSKWLE4HJTVokUuv+vE7PyHCz986iboepk7dkZTFEZw
         fftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194482; x=1788799282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WPPz86V9yd+3O/uWX2wEC0TlJmb2q71n7rhNcr2wyB0=;
        b=lsrP39Fg/2YrRyLdfA2lGt2DEmALHjoC05zhCfpssVZXPIMCKQxTKUsV14GuhEZA41
         R8vyTltqTDpSb5gp2n5cJm8yL3l7DqCR8V/ikiwpM7BZpdyTEtnP3+70lll10og22Eqx
         OKmTfmPdTjV9e008Egqq2jk9LdPML7BlkQV76m3G7UaijZzeRKRC9Xn6LW1mK20UgV1w
         3m+EkdETX8Mkr8gAtFAp5EBT5Yc8j/VqjpgjVx9eoXjxbpd3OixLezLiLVFkHh0Vl5/c
         o10Lq6RaKkg9Ia54nhyV/jgpk4nX1PoWFRLu3R7sGZTEWg9vLSqCBhdyvHtzXffd1mJM
         iVZQ==
X-Gm-Message-State: AFuF++nlluT8vYt7heMArJbbKNIeg2q2dVyA6wkTLru8CjKX7kFyfnsd
	LzaqP+wXq08wT1J6gtsUPNYUZS9+pqcTHmVeJV5FXgLsB2Ojb81nZSUXuOXd9eEhv5q1oA==
X-Gm-Gg: AR+sD12Uopnm6DyBZ0AZXY7JdlHStHab1VCgqZ6k0/dXM4gm6fu2mxWL4+WLYU9T7TS
	hFKMxqorLcuWBb9lSGuUEmySMggoAwFW0otRH7DBe5FhVPEPU6ALl5Xu0lmdMoDc1VGJx1T0hJq
	U+zNo3V2Rt8pVPwgKYIKvZ4s7LbbkqVvBpbjY8CDiHh0puK3oS6mBW6/mVpn7/CaLyoqdsgdtns
	i3ooJej3upixHg3YfJ5B9pIrnnbcgeQxEfOLnRJcJRUriFOz8sl/JPsIwY1PoVoH8zQs5czVDFh
	Q4Kci9u1M0RzRoHaOpITseO46ftx/9/RK8m3TQoio17+7RDht1mOMDiUb7SFc3+iVtQVJh+/Riw
	DG2IctNi08qRe2MWNcfpagcis8JOK0PUVFjXydnA+0iECEmHggvBDd2+wNTP4sVxSmWvm3hYprZ
	8zw8WWeTXVEEZq7NxKYLYM2EPtIoUqJYi+3tcgzo9tIXurCVqkKznn4lepPg9S5TcbN+jrIi81C
	+dexxAKryQdsH4IZjNKojJIYhsr7K3BEAV7bUWJWfsgwS4GzPgR5Pc=
X-Received: by 2002:a05:6122:685a:20b0:5ab:26f:49e3 with SMTP id 71dfb90a1353d-5c681416ecemr8428258e0c.3.1788194482064;
        Mon, 31 Aug 2026 09:41:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c724263c41sm8759775e0c.16.2026.08.31.09.41.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:41:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btusb: Fix UAF of btusb_data by rx_work
Date: Mon, 31 Aug 2026 12:41:09 -0400
Message-ID: <20260831164112.778064-1-luiz.dentz@gmail.com>
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
index 84614e60d142..ce870ec5ab43 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2094,18 +2094,24 @@ static int btusb_close(struct hci_dev *hdev)
 
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
@@ -2131,7 +2137,7 @@ static int btusb_flush(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	cancel_delayed_work(&data->rx_work);
+	cancel_delayed_work_sync(&data->rx_work);
 
 	skb_queue_purge(&data->acl_q);
 
-- 
2.54.0

