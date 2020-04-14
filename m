Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BACC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7432C20787
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 18:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKSsICsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504547AbgDNS7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504542AbgDNS7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 14:59:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7230C061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 11:59:05 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o22so9690707pjp.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vIh5eTB8uOZv+p6Eoz7dTqGKo5Rnh4f9sFKMcqBFlS8=;
        b=TKSsICsFBab9k1r/Gi5jGrU9d5rCvU8AKwKC4tWt+X4MHt8DCtd7JylXyPtfDr97It
         cWvrhcw8k895UD38eusJiJiXLt8LJcVf5Z0GTMQSaGZKkNGuX6QUnhfCUraiApk4aPVC
         zUkxuEaZUfBnb4dgp4Wh8RldstNeGPXqBLEoFg8r+Q29SKYCDPNTewavGBOmD/z5ndit
         sA0PM1rjsRpW6QeqWDeMcUTlWpnOqsT5kP59nabvANNNLjPhqSj+/KRdaXN56Hkl3e7x
         CBNpY6OGBXo+MK5RU/QXKqUxCMUGcDACNLYg8lKP/HdrZAgGjKO8EUe2ZDtvBqYc5LoE
         rfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vIh5eTB8uOZv+p6Eoz7dTqGKo5Rnh4f9sFKMcqBFlS8=;
        b=ZDBQHV5PxqYvS5+V6IOV5RcU63uiFvpwdhHAEl0zBp/+GRQ4NfW3JWg7akCD5bp0rx
         8f22vs5rAIOd3rPuSTJf0t7hqvV4ArjtY8L8pIdJe4Nm+10peWPB0W26zrmOhDF7765v
         7/G6Leje62eBdspHRdacling8/fleP2qFsxbuXxejO4dWC3W7G+nY0KBVApf/cPjN02m
         dwSOhLs52OBFR6RmxIDlUGOnLsyEAqNuMQVDPtZCHZBCZK3JC/54OVFuc5lBS/SDxhXP
         LFWBVyRsrD4LFmZ+6RTQjpBxRQDJ7WnLrB7LE5uOqpMaYgLHhSc2OauJfcywSCQfj7kC
         WXfA==
X-Gm-Message-State: AGi0PuYgbYbz/bead/Wj6Jrhv98ycpOwN8tggWenhwS+NPXK5kJNNhW1
        fLOzzMZD99PJyztrbXHb7GbMpgmzNovC5w==
X-Google-Smtp-Source: APiQypLCRwItYE4hAhA2TRPzwwyxc65C2HZuJqXdiigQnh9OCq/AJAhmepoJkaAhS7Huv9Y2QbNqd8iIqzVihw==
X-Received: by 2002:a17:90a:e02:: with SMTP id v2mr1764972pje.131.1586890745234;
 Tue, 14 Apr 2020 11:59:05 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:58:21 -0700
Message-Id: <20200414115512.1.I9dd050ead919f2cc3ef83d4e866de537c7799cf3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] Bluetooth: Terminate the link if pairing is cancelled
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
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

If user decides to cancel ongoing pairing process (e.g. by clicking
the cancel button on the pairing/passkey window), abort any ongoing
pairing and then terminate the link.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---
Hello Linux-Bluetooth,

  This patch aborts any ongoing pairing and then terminates the link
  by calling hci_abort_conn() in cancel_pair_device() function.

  However, I'm not very sure if hci_abort_conn() should be called here
  in cancel_pair_device() or in smp for example to terminate the link
  after it had sent the pairing failed PDU.

  Please share your thoughts on this.

Thanks and regards,
Manish.

 net/bluetooth/mgmt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6552003a170eb..1aaa44282af4f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3030,6 +3030,18 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
 				addr, sizeof(*addr));
+
+	/* Since user doesn't want to proceed with the connection,
+	 * abort any ongoing pairing and then terminate the link.
+	 */
+	if (addr->type == BDADDR_BREDR)
+		hci_remove_link_key(hdev, &addr->bdaddr);
+	else
+		smp_cancel_and_remove_pairing(hdev, &addr->bdaddr,
+					      le_addr_type(addr->type));
+
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
-- 
2.26.0.110.g2183baf09c-goog

