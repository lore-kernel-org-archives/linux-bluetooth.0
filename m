Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8067C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Mar 2021 20:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A148B64E87
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Mar 2021 20:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbhCAUO5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Mar 2021 15:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbhCAUHN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Mar 2021 15:07:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86669C061794
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Mar 2021 12:06:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l18so304935pji.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Mar 2021 12:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmepXWNSTdEA/KAVI+oGgo16QBYQH6RJ6J9+l/y7d7k=;
        b=McvTQtWmvYeirDmyu8L2JF7XHJv7bQrSQps5CeCQa1wGyAV75Isv5HuzVp0HR5x6Ru
         xYfbMPLaqg1sWsNUx2SQj+9N7rOQbD0qyg5+0B1nh1BUEs9N/+cmRs2oHg6vq/LO/dpY
         z46LpHPUovpIUzpIFwVeBwy3NJ/q1TNEcPTr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmepXWNSTdEA/KAVI+oGgo16QBYQH6RJ6J9+l/y7d7k=;
        b=rg6zTQ7byaAmrQ8jrfGS5S9jda1rbibiurKEzdWvJZev62p0FwdY4eAJGt5u1ZHW9d
         c3cUILMlvGih7rMuHj3vzGvbST+qGdB8XFTEJPJNZSbCeTgABVC4wtQydKtiQg/++d5m
         Q38JETZSeSU+2I36rXYmYUOs2kRpOsZURg78SxjFwA1MCqc1VpB1Kn8muiNrqK9DIG0z
         BORdDh5JXyAiqCN/YZ8ip/UgrjGJL8sSL5HAVu1cKDntuCrVrhTx20WXEhHxL4Vpr/TT
         PWuST5KlPKYL8DK6LTDH69J+B5wwsYolrATgApOe2GVZ/9AXJq1mD1PNxaG0iViAdglN
         bB9w==
X-Gm-Message-State: AOAM531ggV6TFNwTG7cSl6xOcHPPlgt3CrN8JtJ5OVwDQVZ2N3CrZhvF
        55iGBwmoxYaKRr95hZG3rg++Qg==
X-Google-Smtp-Source: ABdhPJxmVMgVucgDn8XCd+M7wCjWLhNXnFkQgXS4h0sfEl7VoV1ymxBwC/zGqjfq4Bl13yHk53vGpA==
X-Received: by 2002:a17:902:be06:b029:e3:7031:bef with SMTP id r6-20020a170902be06b02900e370310befmr285165pls.19.1614629176090;
        Mon, 01 Mar 2021 12:06:16 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:d800:e660:6ed:356a])
        by smtp.gmail.com with ESMTPSA id t4sm238256pjs.12.2021.03.01.12.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 12:06:15 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 1/2] Bluetooth: Notify suspend on le conn failed
Date:   Mon,  1 Mar 2021 12:06:04 -0800
Message-Id: <20210301120602.1.Ia32a022edc307a4cb0c93dc18d52b6c5f97db23b@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301200605.106607-1-abhishekpandit@chromium.org>
References: <20210301200605.106607-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When suspending, Bluetooth disconnects all connected peers devices. If
an LE connection is started but isn't completed, we will see an LE
Create Connection Cancel instead of an HCI disconnect. This just adds
a check to see if an LE cancel was the last disconnected device and wake
the suspend thread when that is the case.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---
Here is an HCI trace when the issue occurred.

< HCI Command: LE Create Connection (0x08|0x000d) plen 25                                           #187777 [hci0] 2021-02-03 21:42:35.130208
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: D9:DC:6B:61:EB:3A (Static)
        Own address type: Public (0x00)
        Min connection interval: 15.00 msec (0x000c)
        Max connection interval: 30.00 msec (0x0018)
        Connection latency: 20 (0x0014)
        Supervision timeout: 3000 msec (0x012c)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                           #187778 [hci0] 2021-02-03 21:42:35.131184
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0                                     #187805 [hci0] 2021-02-03 21:42:37.183336
> HCI Event: Command Complete (0x0e) plen 4                                                         #187806 [hci0] 2021-02-03 21:42:37.192394
      LE Create Connection Cancel (0x08|0x000e) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                                           #187807 [hci0] 2021-02-03 21:42:37.193400
      LE Connection Complete (0x01)
        Status: Unknown Connection Identifier (0x02)
        Handle: 0
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: D9:DC:6B:61:EB:3A (Static)
        Connection interval: 0.00 msec (0x0000)
        Connection latency: 0 (0x0000)
        Supervision timeout: 0 msec (0x0000)
        Master clock accuracy: 0x00
... <skip a few unrelated events>
@ MGMT Event: Controller Suspended (0x002d) plen 1                                                 {0x0002} [hci0] 2021-02-03 21:42:39.178780
        Suspend state: Controller running (failed to suspend) (0)
@ MGMT Event: Controller Suspended (0x002d) plen 1                                                 {0x0001} [hci0] 2021-02-03 21:42:39.178780
        Suspend state: Controller running (failed to suspend) (0)
... <actual suspended time>
< HCI Command: Set Event Filter (0x03|0x0005) plen 1                                                #187808 [hci0] 2021-02-04 09:23:07.313591
        Type: Clear All Filters (0x00)

 net/bluetooth/hci_conn.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6ffa89e3ba0a85..468d31f3303d7a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -772,6 +772,16 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 
 	hci_conn_del(conn);
 
+	/* The suspend notifier is waiting for all devices to disconnect and an
+	 * LE connect cancel will result in an hci_le_conn_failed. Once the last
+	 * connection is deleted, we should also wake the suspend queue to
+	 * complete suspend operations.
+	 */
+	if (list_empty(&hdev->conn_hash.list) &&
+	    test_and_clear_bit(SUSPEND_DISCONNECTING, hdev->suspend_tasks)) {
+		wake_up(&hdev->suspend_wait_q);
+	}
+
 	/* Since we may have temporarily stopped the background scanning in
 	 * favor of connection establishment, we should restart it.
 	 */
-- 
2.30.1.766.gb4fecdf3b7-goog

