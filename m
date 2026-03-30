Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79B386C22
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774908620; cv=none; b=SCZi2knV5InXruyrwNDdtTAGE4Y9ELpWCMAJp/ZTXnAGrlGeF24EUZXvOOTKfKa8tCeb5hqYoWWNgS2wL3rTd9WPnqBA6z26UCdoWk9nyU4Zy8C4H4SHIKXXC4QZDaURZm4AscPxxPpi9W3Lb1w0Trx10aTmq0wQPCJZn89ibog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774908620; c=relaxed/simple;
	bh=FDBfk2gTLu1bF0rsxtRP8sgWzUpvU/oWz/qYiDUySTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEzMPuEhr/SYBFUJIzNhw02cQpIcMmlePxx1eZFtz4zOERJpyoG4iMkv298iA1Isq0WxRo/RbfB/AK2VXQ2+v7Z7c+pKNW2Yv2u85CHyYc6lykhr1yKaXoLcaEph2Qx5w9HtRDrBfM/EKXkAyHBZ3vCyVjzgsnEQM7TrRRcWxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMN/ajqG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMN/ajqG"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd78a4ce8dso704648885a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774908617; x=1775513417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvvCrpWMzIENV2FZlq4KX5Fhj0gALiIkbUI42JoqXcU=;
        b=dMN/ajqGZgDB0BeeTodBZ3BYWpk0wyvyv5Bms5HCIIhrJGl9Lt622sRaTO0UwgBu2X
         x8XtnbqCnehgFY+hOxzbBHdx9UJETg/ocYpvKZwFC98D4fsSSeotzKqgB4v9Xaki3tmP
         BUqHweologJtWuWwl6B9y/9iWNiY8H1qtuZFI/Dsw5EPfS3L6yS5rFWgkUkaoQjomGYk
         WiftKPRIxxT5d+tMzv9CBBTcJ5HQHPnElIpLGlGMOtD+phaI6SjZ0CNT7l5AijGGIsw6
         AhJg3EUX66IWybd4dAKOI/7rSfEqCWygk2hbgmj+veshKiwzOtGn7vwlrVw9h8r/nZ+I
         B7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774908617; x=1775513417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvvCrpWMzIENV2FZlq4KX5Fhj0gALiIkbUI42JoqXcU=;
        b=Jyeq8MD9dCPYKw19SYRsr1qpVfAbGl0S6vx4fZSnWg0kv4Tb2GBWhaP4hcHZBJ4xi/
         cT4VKf5zqRG3VjK0p+mejZ83x2U3zBG5f891mAhQCeSRGZBLR4koXLJjgQtyNrEN/EHv
         QRwA1nfHc/YROT7DuH9DnuL5JYcDgdLeEneDENI0s0232UckjGigvJOvzvRdBUiJxukT
         +cOkz8d7DBGecs0lJmN9Nkxr0oGNQSqQvh9QUvPlT7R2Q27xhWh485gNOpGDPxzaiU6K
         WXbqrAGNnjqsxRjRMyblC5oGN1Y/IPDOzb8osCm5RidW/tb3bL1gIjCn/y2reaJxuWL5
         mnVg==
X-Gm-Message-State: AOJu0YwR2vnn1bQegovAh4452ocVQnfN8ZwsV24v8Ec79+Tc9i0CeNuS
	00cyCKx6RHE7/NF4MOaoiG8jy2GGgd9c/8ImRIdSwOxBFhj0BKg0ygKUJ4ULiGQv
X-Gm-Gg: ATEYQzyOAjvdLcJuXnRv6CTqEIFbrhYy2/aCIzHK/SuqSTu070/41+4JFs/S/8V16PM
	PGI5qAYW3HGddCfnQ/LcBTfTF2atu4x+VhYChdKFNlhPE5jemedurywRIUZe4F9mjR6tyT9gdHa
	3sxcgCfA3iwQyZ95PevHKUDdhVrp+AYDuS5ZfPVCS03GWRIMTqfkwL1jLNj9P6+zey3q86p7P1V
	yxsoKJs4mUVjqgtNyswwA2t/0cXrsE/K3v3ToTXm4mfuPUqLzYNpp40dXRx6trUKrK4XJ7pUQz/
	zEu9k8RwbKLZqquKfcLCZgcv1RGrf53eoe/+Gc9pe9WF5iQVj/8SKjLrEARMc7diSp2GSaD2VyV
	7VunLj7QiTbl8kJN3gYyTqnFs/CF9A3U5Ug+tdOnbaLIJOhlUylSR8YITydt22hKGkQtflZFo7v
	OQmVwPMnT9ubmG1aff0xD7bLes6er0QCzsitw/07P0tTY1H1XF+DfF/+Y9HyBC9c0a0Ijmrx/kk
	RkEa6XOLzrUBl1rWYDBeA==
X-Received: by 2002:a05:620a:4547:b0:8c6:a8a6:e164 with SMTP id af79cd13be357-8d01c796d8emr1904826285a.45.1774908617261;
        Mon, 30 Mar 2026 15:10:17 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028095f1csm819343585a.47.2026.03.30.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:10:16 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	kyungtae.kim@dartmouth.edu,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH v3] Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
Date: Mon, 30 Mar 2026 18:10:15 -0400
Message-ID: <20260330221015.322337-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
References: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISO_CONT case in iso_recv() properly checks for unexpected
continuation frames and oversized fragments before accessing
conn->rx_skb. The ISO_END case lacks both checks.

When an ISO_END packet arrives without a preceding ISO_START:
  - conn->rx_skb is NULL (never allocated)
  - skb_put(conn->rx_skb, ...) dereferences NULL -> kernel crash

When an ISO_END fragment length does not exactly match the
remaining expected length:
  - the reassembly is malformed and must be rejected

KASAN confirmed the NULL-deref on kernel 7.0.0-rc5 via VHCI:

  general protection fault, probably for non-canonical address 0xdffffc0000000018
  KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
  CPU: 0 UID: 0 PID: 72 Comm: kworker/u9:0 Not tainted 7.0.0-rc5
  Workqueue: hci0 hci_rx_work
  RIP: 0010:skb_put+0x27/0x1a0
  Call Trace:
   <TASK>
   iso_recv+0x5e0/0xee0
   hci_rx_work+0x226/0x730
   process_one_work+0x633/0x1060
   worker_thread+0x45b/0xd10
   kthread+0x2c6/0x3b0
   ret_from_fork+0x38d/0x5c0
   </TASK>
  Kernel panic - not syncing: Fatal exception

Fix by adding validation to the ISO_END case: reject end frames
when no rx_skb reassembly buffer exists, and reject end fragments
whose length does not exactly complete the expected reassembly.

Fixes: ccf74f2390d6 ("Bluetooth: Add ISO Socket")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
Changes in v3:
  - Check !conn->rx_skb instead of !conn->rx_len to correctly
    handle the case where an ISO_CONT fragment completes rx_len
    but a valid zero-length ISO_END still follows.

Changes in v2:
  - Tighten end fragment check from (skb->len > conn->rx_len) to
    (skb->len != conn->rx_len): the end fragment must exactly
    complete the reassembly.

 net/bluetooth/iso.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e273..7c57b1d22 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2587,6 +2587,20 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		if (!conn->rx_skb) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
+		if (skb->len != conn->rx_len) {
+			BT_ERR("End fragment length mismatch (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.43.0

