Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A92E739E
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781668507; cv=none; b=tuY5JF8e0a/dqONbQi6+NkboLrnz+0TQncIJbzQG/f0ejYNwzvh2tLFqLxrgjb/NAHVsTRbpjayztxbSHlYqMg2k1kGJVPtBtJWx8WV0Y6QgRqnJDzoRfuq26on54w8QssO8O3+7hPvHkFsDvGl8UF4Aa4ULL9tGuThdVK3hwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781668507; c=relaxed/simple;
	bh=kN5P8TxAAs1jbe/bmrhBFiCOnvdfPMtDPC3zoj//HLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9uktq2kBsGMVIMRSgdyvu/IaR6/9uI/Jg1qnRTZFKSKL7UidMo1D7V9MH1AqSO6PwqRxUswqH9AETZ7B0fgISD6xkU1AgXrhL2q8E4K8t/IeX4uF1IIvVC3nG1o6/QyFe9wTQGttLykAHbvhKAK/7VVti9NnWPKy9eFgI3h6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7e2f3646c10so59342157b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 20:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781668505; x=1782273305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNfeiKB2ViEnhW6D2DIyBmYQpDC7mYoG0gqCU23ucIo=;
        b=RqfvqZ4zgRO3uVyXMCIz0gdV+ZMTLmboatSoxmKDLX0hl2hXAyBZmi2VfWIt4a9Olw
         PLBjL530Cna6M3tgy8F5dIsKYMHtdqopZAwrVGOH2zTh67hCqROF7ep0GX8lyNAc5v3f
         SIwAh5MagsEcj0LmdgszuGFFvqiCdcVss2TglWgJu3+CJyJWioagUvh6ucFTaKiZYrcv
         Xg168R/7YR6b2MDeuvkrvCBinNIAJxd5zHMjV7ZskUaEp0pZyQVLGnjMRCoJLJhIXL8r
         eppNf9BnSU67Dy0PENbVMYRFyOyq2sxT08pWHnFLxfPTbYkebBoe4XClYd8ZEFqATLhS
         ZLqg==
X-Forwarded-Encrypted: i=1; AFNElJ/dUbI+mkfJyVo7ncgBbAXVY9KVI2MAnkVYqYICg8ElH6Urw175APDFTpUYeIx/B3nzxNR32MOG7GdcCae85Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1daUbhaT9+s4AzGamcMrq3ofl5bsIcVjPQEq9GIdvwcECdZ+l
	dBrYljIUjUHRqtUBwx9eiWditAOD5+K46Nt/gRclm9kWNAiFRLXUEYlF
X-Gm-Gg: AfdE7cnhf/gm+dsZCzQi9VdVVtPUsuMp/EgCNeCOJBc1nnN7aa4CGP5E5TN/S5qBWzn
	C5lpDWrLOeGLe33DEkUM0eCrH/N8K3jYakYEvyDfC0pbPw2dy2hWpdh5H99XezT2bWM+7Eg3Udl
	knSpMb/Zw6Vaw5TVvRz+6K8zcaFvz3En7526IkvNl8gCl8TUsjexVRInwNtYVS9GGVgcOgSzytN
	crOWFDhAhLLNOoUvZzJZioN4a2CTZwLvD9SDQEwlUg0iDbD7og9zsmEEAfUuU28jhqiBHMTp9AC
	YAJsACkozndTHF22OFM9WYHCX5cnjRiuC8tqcXxxBSDvRDGn1u07wB3B3x1ca5JO+eNxyH1i2+/
	FtMXNAck48VPVPytEbiZI2IHfVzEbzcN76BsJ6dJOUYGxQ9JECt9wp5LRzlWb2ZgH59DLZpKs2F
	M=
X-Received: by 2002:a05:690c:c52b:b0:7e4:bc8:7ad6 with SMTP id 00721157ae682-7fe5d39f3d5mr18917967b3.30.1781668505273;
        Tue, 16 Jun 2026 20:55:05 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-7fcd345749csm34017227b3.33.2026.06.16.20.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 20:55:03 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] bluetooth: hci: Fix null-ptr-deref in hci_conn_timeout
Date: Tue, 16 Jun 2026 23:54:21 -0400
Message-ID: <20260617035421.341457-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC only.

The hci_conn_timeout() function dereferences hdev->sent_cmd when handling
connection timeouts. However, an HCI_EV_HARDWARE_ERROR can trigger an
asynchronous reset sequence that sets hdev->sent_cmd to NULL via
hci_dev_close_sync().

hdev->sent_cmd is dereferenced when conn->disc_work timeout:

hci_conn_timeout()
  hci_abort_conn()
    switch (hci_skb_event(hdev->sent_cmd)) {
      ...

However, an HCI hardware error event (HCI_EV_HARDWARE_ERROR) resets the
hci device, setting hdev->sent_cmd = NULL asynchornously:

hci_hardware_error_evt()
  hci_error_reset() (async)
    hci_dev_do_close()
      hci_dev_close_sync()
        hdev->sent_cmd = NULL;

As a result, a race condition exists between conn->disc_work execution
and the reset path, which can lead to a NULL pointer dereference when
hci_abort_conn() accesses hdev->sent_cmd.

To fix this, this patch ensures that all pending conn->disc_work
instances are canceled and completed before hdev->sent_cmd is cleared
during the reset path.
This is a provisional fix. Better design suggestions are welcome.

Oops:

Bluetooth: hci4: hardware error 0x00
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 2 UID: 0 PID: 408 Comm: kworker/u17:4 Not tainted 7.1.0-dirty #96 PREEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
Workqueue: hci1 hci_conn_timeout
RIP: 0010:hci_abort_conn+0x291/0x350 net/bluetooth/hci_conn.c:3196

Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Acked-by: Dave Tian <daveti@purdue.edu>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/hci_sync.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index df23245d6ccd..dab709448a02 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5419,6 +5419,14 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	/* Drop last sent command */
 	if (hdev->sent_cmd) {
+		struct hci_conn *c;
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
+			cancel_delayed_work_sync(&c->disc_work);
+		}
+		rcu_read_unlock();
+
 		cancel_delayed_work_sync(&hdev->cmd_timer);
 		kfree_skb(hdev->sent_cmd);
 		hdev->sent_cmd = NULL;
-- 
2.47.3

