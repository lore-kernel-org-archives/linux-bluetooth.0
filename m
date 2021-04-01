Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5862CC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 03:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6F96105A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 03:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhDADMO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Mar 2021 23:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhDADLp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Mar 2021 23:11:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F654C061786
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 20:11:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w9so4478115ybw.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 20:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RmMaazUpNv9dO0QVdc1//Lz/b+2IP+ReIbSX7312Y+8=;
        b=DWp72/rU729D+hNGxjG+KVccftla4VD7a3chImMlNuJh5r4/oHs86378r5+At3wKLo
         UDRk7mV/mRTupfLSxZQh8dvayAwuZkOC+SZfTycsU3Luq1SSbqOdTR1E4jYXoRVqjS4r
         MGa5uEmiTAMyuxuvuiSGKiO7CnH/t2stpHq3pC3yjU7xYSQ9Z3UlvkyMpdeJQ8DpQ0eG
         UXE9sNvQeJ4dBiERcJFZ/AUPSz0u1accV6fojG++W4IQmF8AKaL6P0tpiX1Um49NTsoe
         jNWusKX65n5RCovDUKJJr1zF6p+4+ODgVsX2rtjh6kFsQys9GH8wARX9sftz3WlroL9G
         VOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RmMaazUpNv9dO0QVdc1//Lz/b+2IP+ReIbSX7312Y+8=;
        b=qHJdrPnHIP/BVqzEcFVNJ26g6Qb3bP+jhnK6lVbS/o2TOGIIR1puSA657oiXRHbdY1
         EaEDSQaQqNDS4gINdfS0GCcRhx3ykrmJ52Yjsmou2T6j5rfHr1I+wB1sWbCl9GTh+bh5
         fyQKN0ov9rntdXNTxCp7J3OGCyJfDcXk3TqvAz+G4FH7umNuptUvYswSlAsPhyRr3zXS
         E6cthEq0Y5pN7ZZ3qviyTozgCLkTJmDOAlE7p3BXrAT5xs5spdM0AQq4rP8Cd3CztbEV
         20Ka9JpF2ITEfTNAW9ePiaV2iXQm6Gokd8ZguE3rhqfjOblPzbtejPlGIcpBWtHrYyHO
         XLAw==
X-Gm-Message-State: AOAM530HjdcbD7IdlRGi5mpkqEHtVG1H9jQKCLzG4v1RdA1J1BHNYCGc
        WqCs7axE5QWHRgPsgDokbeCA27Wld+wyXmfzCmzkhoyTdmTqTWTSf7jLxv/rYbLnR5IEypRZl13
        3qN7TQuYHRhKnbzbjYLCqni9rT7VhcwmmNNWH8Cf9JwKR5hmwo5Ft3M49HvtOjkNl0in6VC2Yl8
        yI
X-Google-Smtp-Source: ABdhPJzlfwkJIYqwcBVjfLPx8f6dUBnhcDwwnnv822xSCx5WdAOodoBa9nWHxL/IAIe/c2LX4cmnxKqqjF3O
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:7d3f:ea49:2c08:677b])
 (user=apusaka job=sendgmr) by 2002:a5b:98d:: with SMTP id c13mr8478703ybq.463.1617246704286;
 Wed, 31 Mar 2021 20:11:44 -0700 (PDT)
Date:   Thu,  1 Apr 2021 11:11:33 +0800
Message-Id: <20210401111036.1.I26d172ded4e4ac8ad334516a8d196539777fba2a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] Bluetooth: Check inquiry status before sending one
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

There is a possibility where HCI_INQUIRY flag is set but we still
send HCI_OP_INQUIRY anyway.

Such a case can be reproduced by connecting to an LE device while
active scanning. When the device is discovered, we initiate a
connection, stop LE Scan, and send Discovery MGMT with status
disabled, but we don't cancel the inquiry.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 net/bluetooth/hci_request.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8ace5d34b01e..5a5ec7ed15ea 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2952,6 +2952,9 @@ static int bredr_inquiry(struct hci_request *req, unsigned long opt)
 	const u8 liac[3] = { 0x00, 0x8b, 0x9e };
 	struct hci_cp_inquiry cp;
 
+	if (test_bit(HCI_INQUIRY, &req->hdev->flags))
+		return 0;
+
 	bt_dev_dbg(req->hdev, "");
 
 	hci_dev_lock(req->hdev);
-- 
2.31.0.291.g576ba9dcdaf-goog

