Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792855712;
	b=zYokdV1DR5tZWKyFUHId7AGhd6BkN1JMWwviEdaW+pW1BwzY7f2XWaVFjy7gKHQsTzlM
	 2b8QClL3sx8IafbETwPNvyq1XxiefXcZRKGzv65EtvE9eaYzAbSSbVxEJDkPboMG1g6sr
	 wluHnr0pV3k8imxXe+vrwyM5nxPDPgeobsVzRuuVxM7c0uthv8Ii8cT8SkkUt4p2YjmZk
	 OgBWy+sQ7ZU2lX+X+WDUoSfqGCE5CUYsuf4NCmbDdWr82hV5ra+B3EMCd+3tlVOYNoSRx
	 7Xox2gCBEUJMje550Gr6gZTgAwiSa259/5eJAcUqQUOecDZctYxLvKdg+hY8rQ/CyFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=G5ZdTFdBM0PGrAmpGShpEB/IRaYS4YRfJmkm2SOMrh8=;
	b=vwypGf7sXDygTXMVsf76YmAfA95ikA8LsU+lqNcx0lFduRGkHnSLQOPFr6sKxTdiM4XO
	 tJ2D5daMdXt+3gMPcS/tSCs4Xj+yW3bFAO6pTeWiriX1SWlmmpS0ZQghaWEpRgTBBd5It
	 L+KmTAGjQ6rQM4b3EDanEjginj3wQgz4YjFg+Hyv1LPoqO8cwnSmWbTWVEjevzy/zXMnV
	 ykn6qe5/1nYTSf4qLMOWrg10qKq4CLdg0jWjWPbvyoyq6xD98XhuIvGK/VXU2EOt3Dny8
	 p14rbZBQIFJHOeqhyVhgkkRmzxFJdKGfHHHrYro1KAI8qB45kG2MlIzo/WtrdOu07DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XoNtJHNp;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE4606A31D
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 15:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6CE4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XoNtJHNp
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso869405a91.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855711; x=1793460511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5ZdTFdBM0PGrAmpGShpEB/IRaYS4YRfJmkm2SOMrh8=;
        b=XoNtJHNpmyYYRka6TwVDm+UtrVfE/ZQucwLF6+krOzCPVZdqT+U3/xuUGou3wXA65i
         zhyOpwK7QFAGsZut/95rLgvWvdic2xvcsiy5LU8XXAcIqgruYVNczhW+XnZntiUA4QLU
         VG+vdceSf5Vc2XacnM+5mZz1WCjoNAEFin3cTExMyGeFwsx/LmkQ5ra9mZqETyYJYkY1
         S2xiUn8C/77rALNwySV4v3vZeCt2m6MLG4Qv6tB6rXYpXKEbifndhLuTQ3D+us7fGzXH
         fpB65D2WT/S3Bw3YT64/nIxlgrrq9a/PR5oWisZqOBGKcjOza6qrXb3UMuk28DhTrDga
         3s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855711; x=1793460511;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G5ZdTFdBM0PGrAmpGShpEB/IRaYS4YRfJmkm2SOMrh8=;
        b=BJx7cQA4cSgwWJmIztr4sbx4M99fZV5bl8nehrQrQkNDJQlyguJABKOmS0qLcdL0RJ
         pBTTR+wAZeM3/B++3yT98nkxzCU6CGfaFl/wTI9+9OZ3UlIOqgkkZayzHEwqm5kA06Lt
         nGdznuUf4waKDskXAGkJX5awL//e9WDFLv6x+aCmj/8Y7w5c3gStt7ZmEV1cbIyUvwtD
         +0XIqyb8Vx/f8Z/3+GvSr+cQ2dGioNczjreqYxq/csvqBdCHcTm9lRYcBO9Q349dK6Tt
         +FA6yspadEm3USZtFV81S2Jx03GtUWHXahz21s9GUQL0REFcvAPErJUOiKXgnMARD7uE
         UMyg==
X-Gm-Message-State: AFq9FYJMPszLsoJs5rMg307BNR/ftx1cCHk6QteKgxvh/V62LK/+Hply
	fFAJF1Qetvx+nvMW27zBp753FR+pUHtwfHwGHWMifSKs3TA1gNwxZzmF
X-Gm-Gg: AYBFou0zI8HSeU1ZU2L+8wL0c3KaU/m/IhcDoX4wgkOPeFMxf6WTjNfee6WolOACfAQ
	LW4M57AEfkGWg+q69qyfwrJ63eN/ZnoWZGo6khX49Y+AgNf4zW7Hbwr1h8VlU93c1wYLm4u6icV
	OikduE5We2d2qipPO9QCHELNzMCVV3tUk896sMo7loJtkXCAl4WYshcZQHoIppB7SsKCrQC+5gR
	o2qTwnuHIpWNIHzPf98HFvgycOcL3Z8vXQX5dXEp5tychc76ssGzL2WghweJJLZqBS5NGKiG7Tk
	M19iXBOphekj9snC0MPDz8aTPQNThEql2hrRBVDQaeISClXfAxBnt43ACRQ+8rho3l9JkHkTGuP
	HbR8C5YerTHUjKkfajar6zypw1muBXQJfpC7XHEyIOjmbSOi+qA3srW/t7BjLqEE6nZddcPcqVM
	sCdjVHLEXAGTAbwE3JSVXuq88On6w93yYnWsMEDz1FXuHOJ2TywsIFy99YeP10jPJrh1LI+Vor/
	9KVYpH1fWCMW5GilduVHjtjk7l8iS5W33ldlScfT7fhRgyIjPg=
X-Received: by 2002:a17:90b:5286:b0:3a7:a463:54c2 with SMTP id 98e67ed59e1d1-3adeae763d7mr2054757a91.35.1792855711139;
        Sat, 24 Oct 2026 08:28:31 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebfa4102sm3255498a91.12.2026.10.24.08.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:28:30 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: vhci: Serialize packet reception with device creation
Date: Sat, 24 Oct 2026 23:28:23 +0800
Message-Id: <pm-bluetooth-objects-candidate-0253-v6-ffe55995e8c517fb1d86@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hci_dev passed to hci_recv_frame() must stay alive until the receive
operation finishes. __vhci_create_device() stores data->hdev before
hci_register_dev() and frees the device if registration fails.
vhci_get_user() checks and uses that pointer without taking the
open_mutex held by the creator or a device reference.

An incoming packet write can overlap the delayed default-create work
scheduled by vhci_open(). If registration fails before acquiring the
registration reference, the following order is possible:

  Default-create work                Packet write
  vhci_create_device()
    mutex_lock(open_mutex)
    data->hdev = hdev
                                     vhci_get_user()
                                       load data->hdev
    hci_register_dev() fails
    hci_free_dev(hdev)
      bt_host_release(): kfree(hdev)
    data->hdev = NULL
    mutex_unlock(open_mutex)
                                     hci_recv_frame(hdev, skb)
                                       read hdev->flags

The packet retains the pointer before the final put and reads flags
after the allocation is freed. The HCI_UP/HCI_INIT test therefore
accesses freed memory before it can reject the packet.

Hold open_mutex from the packet-side pointer check until
hci_recv_frame() returns. Creation and its error cleanup already hold
this mutex, so the writer waits until they finish and cannot retain a
failed device allocation. Release the mutex on the missing-device error
path too.

KASAN report as below:

    BUG: KASAN: use-after-free in hci_recv_frame+0x4e/0x7e0
    Read of size 8 at addr ffff888107034138 by task python3/500

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? hci_recv_frame+0x4e/0x7e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? hci_recv_frame+0x4e/0x7e0
     kasan_report+0xe0/0x110
     ? hci_recv_frame+0x4e/0x7e0
     kasan_check_range+0x105/0x1b0
     hci_recv_frame+0x4e/0x7e0
     vhci_write+0x35a/0x4c0
     vfs_write+0x637/0x1010
     ? __pfx_vhci_write+0x10/0x10
     ? __might_fault+0xdd/0x190
     ? __pfx_vfs_write+0x10/0x10
     ? __pfx_hrtimer_wakeup+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? common_nsleep_timens+0xa8/0x160
     ksys_write+0x111/0x200
     ? __pfx_ksys_write+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? restore_fpregs_from_fpstate+0x55/0x100
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000
    index:0xffff888107036a40 pfn:0x107034
    flags: 0x200000000000000(node=0|zone=2)
        raw: 0200000000000000 ffffea00041c0308 ffff8881887bf180
    0000000000000000
        raw: ffff888107036a40 0000000000000000 00000000ffffffff
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff888107034000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
     ffff888107034080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    >ffff888107034100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                            ^
     ffff888107034180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
     ffff888107034200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    ==================================================================

Fixes: 23424c0d3169 ("Bluetooth: Add support creating virtual AMP controllers")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 8f7db0102b25f..de7d4d67e46e9 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -524,7 +524,9 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 	case HCI_ACLDATA_PKT:
 	case HCI_SCODATA_PKT:
 	case HCI_ISODATA_PKT:
+		mutex_lock(&data->open_mutex);
 		if (!data->hdev) {
+			mutex_unlock(&data->open_mutex);
 			kfree_skb(skb);
 			return -ENODEV;
 		}
@@ -532,6 +534,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 		hci_skb_pkt_type(skb) = pkt_type;
 
 		ret = hci_recv_frame(data->hdev, skb);
+		mutex_unlock(&data->open_mutex);
 		break;
 
 	case HCI_VENDOR_PKT:
