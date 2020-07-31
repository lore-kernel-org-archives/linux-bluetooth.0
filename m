Return-Path: <SRS0=UTuE=BK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D277C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 01:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A481208A9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 01:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C8l0mXCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgGaBFk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgGaBFj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 21:05:39 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD361C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2020 18:05:39 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id s20so14968169vsq.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2020 18:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XL5rU5YC60frM3gP4UMCvKHyUzU+TZFJvAqINKMI6/E=;
        b=C8l0mXCQI4PP7k7BzBzwn63GljjNdROnpiBppAXoHj8EuD5jzgQeauXCNdEq0bkOyG
         cQazyxuAMC0HhsLQDMhNoya2W4bAtSN3cjm00MJv55Mvmxqhmsqn0lAihFXIbybfAQk4
         tw6VM7v6heHmWB6J8p8xfBfPUGGK60CUc485k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XL5rU5YC60frM3gP4UMCvKHyUzU+TZFJvAqINKMI6/E=;
        b=jF8dFVfLNDleaLs6zkPUtDxN+iTL25XeE0Hj9b/2FPgywaTa7GELJn2lyPzXQ49pv2
         RQa7Xs+Z1OCkNLuTALbrgib/uPWWjIO3WdjKcP6W7TKA2PoSN3YRqUq3z+aDJfpObGff
         FpdMdVLM/65eYrNy+8SedO3M12CY+XaVtL/Fxnk8G/q/77ENn1LzEVNg4WKzRulmGCLZ
         qPHWixz6eQS36dLYLv3Nl75ya+ojJ12Sk6jjeORj+bM9eAEzEAPsiLX8K14e0LAmt6KM
         kJ06gdyBpPh+puFC7GhDm2LMP1siuSSKHlJKz/ozD6p/le8qO7X5pShM7CUR130MX6K2
         xlLg==
X-Gm-Message-State: AOAM531yRCtb+LSODm2behYTI8HIk4Xv7yEqtCXBvdyTr9xiGK2Ohy4U
        U3vrlghh5GK5A78xzRL4Zi8KyVwSujo=
X-Google-Smtp-Source: ABdhPJzrwa6/9L8GG30Dt/jpgz3bqBnMkSBKMB4UmarP2YKaOViUJ7X+/zWSnq40NhBahCLfyA6tGQ==
X-Received: by 2002:a67:eb92:: with SMTP id e18mr1486085vso.96.1596157538598;
        Thu, 30 Jul 2020 18:05:38 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id n62sm1009914vke.12.2020.07.30.18.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 18:05:37 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Subject: [PATCH v2] Bluetooth: use the proper scan params when conn is pending
Date:   Fri, 31 Jul 2020 01:05:34 +0000
Message-Id: <20200731010535.1422455-1-alainm@chromium.org>
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
Reviewed-by: Yu Liu <yudiliu@google.com>
Signed-off-by: Alain Michaud <alainm@chromium.org>

---

Changes in v2:
 - Fixing Yu's email tag

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

