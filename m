Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0674C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 01:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiENBva (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 21:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiENBv3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 21:51:29 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423593D9DC9
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:54:00 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z26so10354745iot.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LxtZQmDFCfzvq4Wq0MCLivGxZ+Q/kBABlT5s9jx1zMg=;
        b=B6KnFS/gDy35fPnMhh7LzU2WhAiLmuXQgqnPyamgmwwPlUXZ89cWvDdfr1AsSHXUSZ
         zWFh2kvxSY6wx9Qb2nn4T1E7jKQmRpzU6tkETFd1s5khc4ZX7lT/8hfSjKz4LxU/cz6K
         hpk5xERM0WI2YpUqixECEaIA0qH0BGdyR07NRzayTIM2lZAZewFMhwFfu3eRBQbjoki0
         doJjhmnTG/TfIZN6kj2q1HUNmk79Q2oDbWowbPBZ99aixG4DgUyYD/dBtMFuiKIOazJ5
         cRnRCzxC9Zo7TOY7684P9b2DGcNgWRBwZzrmZ3hF1mMlDd+wXgtsjrENEsvoUZddo+mF
         NMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxtZQmDFCfzvq4Wq0MCLivGxZ+Q/kBABlT5s9jx1zMg=;
        b=t6VZTCBbrbKYZkuYOM401OZV5tcO9IC9hnJgcMOjKuhmtZcCQshG0EqHcEUZiOT33R
         1K3cgcl1CLYj8gQw0hYJK2S7CwGyGxehj1m0Qy78hlvEehJ4otR4YLUmnKzyN8HLYsgj
         lZMvfNrieD58FZYcSoihSOhhrSfZjNR7lntzHGN3vR6D+9es99OwcuJKQ9hj38caqk7C
         gkcTjc4nmxT0O77jhEPWCsbmZaqsGivNv5Pq4ySjdIV+6WyIoHB/yTc2CCZt8SZUfOt8
         S2JIaTmoGZQ1vre3GDBE5OkrtinOJvGz+RjeGOCXzgQwYoYC71Iego8gh9E8Yapv1l6I
         rvSg==
X-Gm-Message-State: AOAM533yLFhEruUzzGCqZ30Ewl7Tx3BlzJFW21UwNSyeiKE+g5C6vtpd
        txJQJtSSUr9DXMCiumvb72VhzulIguw=
X-Google-Smtp-Source: ABdhPJzpurznFC+m7FMvgq6t48ylV/Y6TQ/nkx7SXU3FQzVo+ApTrZ6FK4XSfXJIz/dJdgC7GSP/Gw==
X-Received: by 2002:a05:6638:160d:b0:32b:d9d2:f2f2 with SMTP id x13-20020a056638160d00b0032bd9d2f2f2mr3769190jas.68.1652485889038;
        Fri, 13 May 2022 16:51:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i16-20020a056e020d9000b002d0e8a52ab6sm937628ilj.27.2022.05.13.16.51.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:51:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: hci_conn: Fix hci_connect_le_sync
Date:   Fri, 13 May 2022 16:51:25 -0700
Message-Id: <20220513235125.1364692-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513235125.1364692-1-luiz.dentz@gmail.com>
References: <20220513235125.1364692-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The handling of connection failures shall be handled by the request
completion callback as already done by hci_cs_le_create_conn, also make
sure to use hci_conn_failed instead of hci_le_conn_failed as the later
don't actually call hci_conn_del to cleanup.

Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 5 +++--
 net/bluetooth/hci_event.c | 8 +++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4a5193499b77..a36297368c58 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -943,10 +943,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
 
-	if (!conn)
+	/* Check if connection is still pending */
+	if (conn != hci_lookup_le_connect(hdev))
 		goto done;
 
-	hci_le_conn_failed(conn, bt_status(err));
+	hci_conn_failed(conn, bt_status(err));
 
 done:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0270e597c285..af17dfb20e01 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5632,10 +5632,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		status = HCI_ERROR_INVALID_PARAMETERS;
 	}
 
-	if (status) {
-		hci_conn_failed(conn, status);
+	/* All connection failure handling is taken care of by the
+	 * hci_conn_failed function which is triggered by the HCI
+	 * request completion callbacks used for connecting.
+	 */
+	if (status)
 		goto unlock;
-	}
 
 	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
 		addr_type = BDADDR_LE_PUBLIC;
-- 
2.35.1

