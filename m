Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310BEEBA
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829818; cv=none; b=C8vgCsjQH3AAzJD7L7Z2V0ak+o/ddLFpav5Dv8CyPxPq7eKartZIRLrwRcMPq82fniM5zgT4cLMMuo/HadGM3qMU8aOY5pV2ZBZmPVMrqSfzQ2gt2g4s+2uFGdeMc/nfJ0cn7gGbKs+5Cfb2YNRK8yUKYFCabsAjPjA9XMZLzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829818; c=relaxed/simple;
	bh=IdPBk/l8ftlPB/4AQV6mmQxH8TRqn+amLYTJ4EtwVA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXEcsBBgbb6rkKTPqy2/li7iwHqJsR1/kOo+BzIcpdL7eXUnkAqwoBgCEz8n6Zd8LngucufDu5MynEfFXDCB6vLPsik5FVbrFLTWw8uTfljAJknWtjZWQ7LCseXOtpyLkmEzlIfn9f/XGHD6Fergl1zpKn6zqsE0i+zNqG575SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66058b880e9so1800928d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 17:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781829815; x=1782434615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NO0hPGknQjAlctvuk8YgxFhDULGBg/+FtvKhAaHoB0=;
        b=HSZHNAdHfOg/vTqVZecQlMxeolMloPJ/nC3aNCTXdPrsPsQqNW+9QDMAcFrnXUCvjH
         YP2X7N4la1P+iAQL2QAw8mT1DwMlGgSvUBAr2sOtaxXMZVpJczFBEo44pEWWZic8mbEy
         r9mCja7Wn5Yg5KRp5vHUfJalhY2m+RirWpkODRLLKirsHyz7s+f2kpjuD0MdEUUzmk4d
         fd87Izk3xaW8hT2W5VkiaP8oRMZVFgnfVquIcu3MRB+rSAxohgBeqIrt5XelDj5vbCMc
         PrABufHe0BHj0OW2t+CfMgGke8D4FO7eVzqUTPgokSZHJwHhD5uh9/6We3ECCB5X6Djz
         eaJA==
X-Forwarded-Encrypted: i=1; AFNElJ9UijXRKki/XzMvYj62FqaIkp7pkHEiqzisCo8bnMf8yypMLMaj6Q68II8s17CMw2dZFQTZMMREZ/zF6ZzXz/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31voCDHzsDuLHhuibva5nOjJgWHm0t1jjvraQbFz4pm6tI0O8
	Ey9dmoVw3a072yQPQrIWxpX8TEK0qfL5VbPIUqreQTlEDuj2hwW6ScFn
X-Gm-Gg: AfdE7cltHpa/9ZVg8KnfM71d1i/lefcJJw1MZSc9+GZ918QM5VJ2A1aPf0iRAU4axgq
	1FRCjr6/heBXgEjMuatOdrQxb/cb3b/IMkyqoX+LUZDyL20Ma7ACdVsW/6Vv1R/vBikE+PSwpMz
	jv9hvIEH6dydJ/7MaRV1EfoVoe0ha5+UDl82TWkwQD5FY4h83Ko/iL0SkTPaAt1qOw0mByGjUfq
	2MwVEMviNRxhnBuqvd01fzQfdqh6+e25q4YZynMP8xFU9ZpsAhAj0j/h/EZJcAR1Rgufq814C3e
	HyEneu33EpectkBM05mWZwZd7pnnPBqoi/2wAvTM+IhL0LzJaBUt96wY9T9SrnyPeTSl3yWF/kJ
	TSPGwYxbySbblsDaLvycEupY97xNly1dZJEUpxcX9skekZt57RTEqoONLaCb2lQKx3t4hZ+mDZr
	c=
X-Received: by 2002:a05:690c:2501:b0:7fe:3059:6f50 with SMTP id 00721157ae682-80132c3ebb4mr13294937b3.8.1781829814843;
        Thu, 18 Jun 2026 17:43:34 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8011a1dfe07sm5975227b3.13.2026.06.18.17.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 17:43:34 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Chethan T N <chethan.tumkur.narayan@intel.com>,
	Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>,
	Kiran K <kiran.k@intel.com>,
	Manish Mandlik <mmandlik@google.com>
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Synchronously cancel timers in hci_cmd_complete_evt()
Date: Thu, 18 Jun 2026 20:42:22 -0400
Message-ID: <20260619004222.3764523-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC only.

hci_cmd_complete_evt() and hci_cmd_timeout can interleave, leading to
user-after-free access.

CPU1                  CPU2
hci_cmd_timeout()
                      hci_event_packet()
                      [snip]
                        hci_cmd_complete_evt()
                          handle_cmd_cnt_and_timer()
                            // this is asynchronous
                            cancel_delayed_work(&hdev->cmd_timer)
                        hci_cmd_sync_complete()
                          kfree_skb(hdev->req_skb); // free
  hci_skb_opcode(hdev->req_skb); // use-after-free

To fix this, make cancel_delayed_work() synchronous so it can wait for
the timeout handler.
However, this is not a complete fix because hci_cmd_timeout() resets the
device and queue a new command.
I would like to request for comments the better way to fix this issue.

KASAN splat:
BUG: KASAN: slab-use-after-free in hci_cmd_timeout+0x216/0x260 net/bluetooth/hci_core.c:1432
Read of size 2 at addr ffff88811605a7b8 by task syz.2.21760/74233

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xba/0x110 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x157/0x4c9 mm/kasan/report.c:482
 kasan_report+0xdf/0x1b0 mm/kasan/report.c:595
 hci_cmd_timeout+0x216/0x260 net/bluetooth/hci_core.c:1432
[snip]

Freed by task 4563:
[snip]
 kfree_skb include/linux/skbuff.h:1333 [inline]
 hci_cmd_sync_complete net/bluetooth/hci_sync.c:36 [inline]
 hci_cmd_sync_complete+0x152/0x370 net/bluetooth/hci_sync.c:24
 hci_event_packet+0x8fd/0xd20 net/bluetooth/hci_event.c:7863
 hci_rx_work+0x5c5/0xfa0 net/bluetooth/hci_core.c:4041
 process_one_work+0x93f/0x1810 kernel/workqueue.c:3316
[snip]

Fixes: ecb71f256667 ("Bluetooth: Fix race condition in handling NOP command")
Acked-by: Dave Tian <daveti@purdue.edu>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/hci_event.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eea2f810aafa..3639aa896bc3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3765,14 +3765,14 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
+static inline void handle_cmd_cnt_and_timer_sync(struct hci_dev *hdev, u8 ncmd)
 {
-	cancel_delayed_work(&hdev->cmd_timer);
+	cancel_delayed_work_sync(&hdev->cmd_timer);
 
 	rcu_read_lock();
 	if (!test_bit(HCI_RESET, &hdev->flags)) {
 		if (ncmd) {
-			cancel_delayed_work(&hdev->ncmd_timer);
+			cancel_delayed_work_sync(&hdev->ncmd_timer);
 			atomic_set(&hdev->cmd_cnt, 1);
 		} else {
 			if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
@@ -4304,7 +4304,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 		*status = skb->data[0];
 	}
 
-	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
+	handle_cmd_cnt_and_timer_sync(hdev, ev->ncmd);
 
 	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
 			     req_complete_skb);
@@ -4418,7 +4418,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 		}
 	}
 
-	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
+	handle_cmd_cnt_and_timer_sync(hdev, ev->ncmd);
 
 	/* Indicate request completion if the command failed. Also, if
 	 * we're not waiting for a special event and we get a success
-- 
2.47.3

