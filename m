Return-Path: <SRS0=UTuE=BK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF92CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 01:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E4C208A9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 01:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U1ti9bzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgGaBDs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgGaBDq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 21:03:46 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F532C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2020 18:03:46 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id x19so3126785uap.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2020 18:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wYtuIahi8xNh+qop7NMQ+Yr+S+J0oeXKPSMxVb1bcQ=;
        b=U1ti9bzZVkEsMGU9J987jd2ZK0f6QCFMDKXM9k1cURTKlSGcpWmsd1rMe8Q6ZciIwG
         5rIvIbku0CzxrRGLkUHvGNomS6Iirng6oNr4/JFCCTBicF1Vl3HCyCLI72l5/LvvJlLq
         TOHkrIYj0pcr7DRGzkq3Nh1GrRqwCsNPZ2PJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wYtuIahi8xNh+qop7NMQ+Yr+S+J0oeXKPSMxVb1bcQ=;
        b=WQISSYEsV06/rYTac5un7lGWnAyFtCrnjml1L17rRurrIbHucVM9qAywermA69yPj9
         5+eI63iS+BNbvqvVoTqS+6f2ZvYRDARbr91qOcKmV+Wudxy6xnW+etY2+fCn3D4DNo1v
         F9mZp9GTWQGKh1RUGZX/cFRR1cSgSv9am9rpmLVffOT9R0KCuboC4um72zYpoThrDTd1
         BsfJJxqsfdjseJvXvZhN6rwQL7uWi0J5d9AIN3+rdwQSeZ+kRy1SoZ9ab7oSJTDeFYUI
         TCJlA139hEUIQabhu23ThJJ68TBuwTok/zH52IZ8+B6ePQcaBQwqBHx4SQUlF2tPb0Bg
         M2Kg==
X-Gm-Message-State: AOAM533u998IYkZavK+NpiXSqFOE7cQ+W5K1pG2VFZJaPl4nDQPGDqex
        6QgkMjjQJvBYa9yb25MbEGDDTRn6ClQ=
X-Google-Smtp-Source: ABdhPJzoO0IjdqbCE+WghcbqxucCMzEI6b7DEcMohE032wh0ib5aQDd+oMsfMOXvvGriISz1KPtzLA==
X-Received: by 2002:ab0:6585:: with SMTP id v5mr1046266uam.73.1596157424888;
        Thu, 30 Jul 2020 18:03:44 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id r5sm1023993vkf.20.2020.07.30.18.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 18:03:44 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudilu@google.com>
Subject: [PATCH] Bluetooth: use the proper scan params when conn is pending
Date:   Fri, 31 Jul 2020 01:03:41 +0000
Message-Id: <20200731010341.1421926-1-alainm@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When an LE connection is requested and an RPA update is needed via
hci_connect_le_scan, the default scanning parameters are used rather
than the connect parameters.  This leads to significant delays in the
connection establishment process when using lower duty cycle scanning
parameters.

The patch simply looks at the pended connection list when trying to
determine which scanning parameters should be used.

Before:
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8
                            #378 [hci0] 1659.247156
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 367.500 msec (0x024c)
          Window: 37.500 msec (0x003c)

After:
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8
                               #39 [hci0] 7.422109
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 60.000 msec (0x0060)

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Yu Liu <yudilu@google.com>
Signed-off-by: Alain Michaud <alainm@chromium.org>

---

 net/bluetooth/hci_request.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 435400a43a78..e0269192f2e5 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -953,6 +953,27 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 	}
 }
 
+/* Returns true if an le connection is in the scanning state */
+static inline bool hci_is_le_conn_scanning(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == LE_LINK && c->state == BT_CONNECT &&
+		    test_bit(HCI_CONN_SCANNING, &c->flags)) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return false;
+}
+
 /* Ensure to call hci_req_add_le_scan_disable() first to disable the
  * controller based address resolution to be able to reconfigure
  * resolving list.
@@ -1003,6 +1024,9 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	if (hdev->suspended) {
 		window = hdev->le_scan_window_suspend;
 		interval = hdev->le_scan_int_suspend;
+	} else if (hci_is_le_conn_scanning(hdev)) {
+		window = hdev->le_scan_window_connect;
+		interval = hdev->le_scan_int_connect;
 	} else {
 		window = hdev->le_scan_window;
 		interval = hdev->le_scan_interval;
-- 
2.28.0.163.g6104cc2f0b6-goog

