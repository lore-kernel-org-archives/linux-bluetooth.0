Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84139C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 03:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34DDA22518
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 03:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgLDDQD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 22:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgLDDQC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 22:16:02 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3FC061A52
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 19:15:16 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id n95so3365913qte.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 19:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=SqrSxY5uc4xcJqKSvQt8JkbosUVthJxwVLPagRQfa9k=;
        b=ZtoCbhF83mH8woZoUdtLoCbWmJ69GR8ZSC7CbsMblk48Asr7dttdoLeBj4/QMHcxWC
         n/WqQ0M6X4a2zQTPqqJbOUg5BMPeXthOn6YvhNjwvyYi2GhMIWsehNr3oF+HLQGUZFZB
         U+lzRysW5d6Bynymlp1oBm2meut/MtnoCvChFGvdVZJyU8a9w9j2dDeYtajHCy87oXFu
         GvkMsj5NHy8ahIki1cL7qxZWmwSWSyrYlw6lp97ts5Ok0cI8H2uPj7kgH4fCOHW1JM1i
         PFbXWl/oPM2xYrfOMbpPSaeeDSvQoERuv9h4wdX8ygDYryoQ4aeeMleNgs0RqUjkS8E7
         vSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=SqrSxY5uc4xcJqKSvQt8JkbosUVthJxwVLPagRQfa9k=;
        b=f7BnuKJh8YRZQfdxpjlpYz0YByXkzQ6luVX7ap3tUvScAarDlClHS0ij8VH/NQyk8e
         70S4aDUWSQkxjFHB4rq90Rpfby6J70ZogCm4K2jd9RVn3ho8YtBEtYwEA4e+lBQ0kV5U
         aospo35iarMPcZ8F7tcSz3SX3stN3RDR61AWi2xVfdyxEEtVAVNRnQtD6EJXkDOdBniX
         X2XerYFevF+0YAH/07OcMRrNGZjA2dh6Th73Du/xtnE7T164avB4FRyN3698NI5OgbRl
         5yFjEEIWmysskVrAioMW/Ljxg8iu1K5X7sPweeoHHa/sCQNF/CQtQZjJU6jGSXr2CZ30
         5GXg==
X-Gm-Message-State: AOAM5311D25L99QJThvbWVgYbFDCSjiYpdZr1BZvXHzDu0pj39MFF38Y
        wBPp+Wrs7bgvm1aP31AAFYB8Kzv3GuTqDdTIk8KtC43Ltw5Sudlz60QsCFx4Q3CQ+WttLrsReVU
        glg6Z2XBpNuWvONkbhfZG+eHmiLrMacd0KHK0y/D5qBWgHbukKlD0/EccGGmC4qcSl0tmhWBwXz
        8DA64F10XEC+M=
X-Google-Smtp-Source: ABdhPJw6pYkEPaXn6m8Sa+IEwWAZKLX13zrJN5JXeLuCA6Cr5L/HdyQWDCnm9EPigYwxBtnqeBX6CeiZcx6ZH0NoNg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:4d84:: with SMTP id
 cv4mr2903690qvb.14.1607051715532; Thu, 03 Dec 2020 19:15:15 -0800 (PST)
Date:   Fri,  4 Dec 2020 11:14:31 +0800
Message-Id: <20201204111038.v1.1.I4557a89427f61427e65d85bc51cca9e65607488e@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v1] Bluetooth: Set missing suspend task bits
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, mmandlik@chromium.org, mcchou@chromium.org,
        marcel@holtmann.org, abhishekpandit@chromium.org,
        apusaka@chromium.org, Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

When suspending, mark SUSPEND_SCAN_ENABLE and SUSPEND_SCAN_DISABLE tasks
correctly when either classic or le scanning is modified.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/hci_request.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 80dc451d6e124..71bffd7454720 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -707,6 +707,9 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 		return;
 	}
 
+	if (hdev->suspended)
+		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
+
 	if (use_ext_scan(hdev)) {
 		struct hci_cp_le_set_ext_scan_enable cp;
 
@@ -1159,6 +1162,11 @@ static void hci_req_set_event_filter(struct hci_request *req)
 		scan = SCAN_PAGE;
 	}
 
+	if (scan)
+		set_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
+	else
+		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
+
 	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
-- 
2.29.2.576.ga3fc446d84-goog

