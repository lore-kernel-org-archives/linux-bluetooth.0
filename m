Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DBC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A937D20848
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 16:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9d7nMDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCJQcp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:32:45 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38086 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbgCJQcp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 12:32:45 -0400
Received: by mail-pf1-f201.google.com with SMTP id f14so4980001pfk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=orSnkR0b0kEaczXYpxz6sH2e+X0g5twrn8pQx+WIZsU=;
        b=f9d7nMDELRVltXLuc+w/x0sA9qcoRpITVlGtCZMS3SIPIR4GcWsOQof7Ev82kZrUii
         yH3Z0EpkdC9MD2e2RMoP4DIxM/2rLW21qeBviJy2WyMN1ZrMJs0Bhjx49QLTzoJNBTgU
         4DMR+vHmZuhQ5UxOTBoN5opUtIVAkohIuqimV4s5pO8ct8XofVo/Jq4E51k5/JCWKCg/
         9Xdi9jFPKgNrJJHhPKJRGbDvxBibwI2RwjxjoxPElmsRuV+ytDt3a1OncyBBUIt6mv7u
         nnMwGE+x2qN37Zue0ZsnAEUNJ6aiIz2zNk6x/lDi8UuFo+udFUd6vGTP/HhRoUoJ4q9R
         XdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=orSnkR0b0kEaczXYpxz6sH2e+X0g5twrn8pQx+WIZsU=;
        b=itD9xwKE9w0DpkeH8A8dTizL0qQLAWQj3PxpJ/Mdj4zyyU5gW8khwyRn1ZTZ5aBeXO
         vKQtE+hFEqJaC7zVNL7Pk2nerw/X8V4/+/LR6wV32MxDcEVqAGEXmHpaHEGa6PnXXNDq
         Mnu8kFJuNMeopv1DrE/5dfB8TEHC4wZ0Biz1wzkZ6xkyMm6ghy0+/LCIrJbqfgeJ6vH7
         3hGIEbhxtqxeej4Hw3jhN61tqn0N8j8oY4k2q8mI/VRcZW3cWRrUeDd92NSaJBsFE2bE
         PcBZkIAg/JGCex55k24p3fNtkVwVRDY3xqFF3g6ajMr2P3SjF4b/FymGZOB7Ki3ZBgqV
         xo2w==
X-Gm-Message-State: ANhLgQ1/DEhqvfbKel6iSo0nf/M0lrHlUGKP2FuzmK+u5DQp+praFdQh
        GIoncAvcVtUNA3KmB6p1WmSuW2LXSGRvnA==
X-Google-Smtp-Source: ADFU+vsk/MhKLnMEl6XXM0gmfMX/+yVoxQ1mlYcZ9OVXE+KVATINDkuf9BSlNbBWf92pBgHmMAtRTSSReTRc3A==
X-Received: by 2002:a17:90a:be0c:: with SMTP id a12mr2651608pjs.26.1583857963999;
 Tue, 10 Mar 2020 09:32:43 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:31:50 -0700
Message-Id: <20200310093101.1.Iaa45f22c4b2bb1828e88211b2d28c24d6ddd50a7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] Bluetooth: mgmt: add mgmt_cmd_status in add_advertising
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Joseph Hwang <josephsih@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

From: Joseph Hwang <josephsih@chromium.org>

If an error occurs during request building in add_advertising(),
remember to send MGMT_STATUS_FAILED command status back to bluetoothd.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 net/bluetooth/mgmt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1002c657768a0..2398f57b7dc3c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6747,8 +6747,11 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (!err)
 		err = hci_req_run(&req, add_advertising_complete);
 
-	if (err < 0)
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				      MGMT_STATUS_FAILED);
 		mgmt_pending_remove(cmd);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.25.1.481.gfbce0eb801-goog

