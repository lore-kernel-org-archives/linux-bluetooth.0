Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B193FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9845D6113B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhKEVQE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbhKEVQB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:16:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37432C06120A
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 14:13:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso4236937pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+CkZMeU/mvGHQu61gg/VulszIL5MrKImOHlTkdFuNM=;
        b=WbRxF1tlxD+OtW6i3H5VQ1AlSLSYlER4cinsDgGwGiJwytHgHJMYjEy5WIGebCOgFc
         HgIo+X6atU26X47bhZrYV6JDnRqTYE417f2hr65+8J5aSwRQknWA8o7a/gXO9efbnD5L
         aQfsjGntTHhbVlXRjc1OiYPspiFtPBTTh9m9fzoHXz3wJIisZUxA9Cu8/9zWIsfoVOMS
         gPX3iqGmj4w3FKqJReCUheanAw9LSMQIkKkDdYuVd3kxqzgWHPf/po1jdnJsLY8e7LVi
         1XtJf2daRpXF8XE8/RhIUI7IpRSEyGk9X+v3mrxzDxfiZAsd2kkeHFbaDv57oKJsRvwU
         aNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+CkZMeU/mvGHQu61gg/VulszIL5MrKImOHlTkdFuNM=;
        b=h0txKJ4V255sANGRPyNf0nLsbR7yTqEmJFIOM90zjnW7BhVfxWKFNE4fOSTehHYkTV
         CoqZeM3Ohl0l1QbH+E0O9MFRtHp1mLsk3UYadBEujc6g3ajhQ04UyRth2One7rUvW31o
         Uk6iGVPhELcKwvpPL/wXOWVT2iBSH9xXciv7yH+gdCry5hWSbcil72AWSH3zB8oRZlwx
         cqMiieTgVRCkQ4dLS0uensDAZvVE0hPrtVzru2kvESsll+DbT5zDuoG0veHoGt/mJ7or
         gxfStlsMuim5kqN00/3lCCiYtj7i7hQhWPfQ5XkpCx1zaj6qc1Rq8cEq64nT0K9HjS0+
         2bEA==
X-Gm-Message-State: AOAM5332EXGV9cZv5NZA24XDtYj0JgjbYTW1Q2BUi9FnHQly88k6RfKJ
        SiF9/OXAj1K7Td1F48hHWf0JBBpI4AQ=
X-Google-Smtp-Source: ABdhPJyHmL7q1UDCmBn17J+myBuDw/Eb/ThJEbVt7y+JpcJ5aw0RS5QXnIfUIjJH30bjTrT87jy/1A==
X-Received: by 2002:a17:90b:188e:: with SMTP id mn14mr33002473pjb.91.1636146800485;
        Fri, 05 Nov 2021 14:13:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 32sm1351632pgn.31.2021.11.05.14.13.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:13:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY device flag
Date:   Fri,  5 Nov 2021 14:13:18 -0700
Message-Id: <20211105211319.424249-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
userspace to indicate to the controller to use Device Privacy Mode to a
specific device.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/mgmt.c             | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b5f061882c10..f28cb245adbb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -160,6 +160,7 @@ struct bdaddr_list_with_flags {
 
 enum hci_conn_flags {
 	HCI_CONN_FLAG_REMOTE_WAKEUP,
+	HCI_CONN_FLAG_DEVICE_PRIVACY,
 	HCI_CONN_FLAG_MAX
 };
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 06384d761928..2062359a7bcb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4456,6 +4456,13 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (params) {
 			params->current_flags = current_flags;
 			status = MGMT_STATUS_SUCCESS;
+
+			/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
+			 * has been set.
+			 */
+			if (hci_conn_test_flag(HCI_CONN_FLAG_DEVICE_PRIVACY,
+					       params->current_flags))
+				hci_update_passive_scan(hdev);
 		} else {
 			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
 				    &cp->addr.bdaddr,
-- 
2.31.1

