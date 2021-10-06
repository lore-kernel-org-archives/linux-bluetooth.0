Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 01:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68EB60FD8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 01:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhJFBLc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 21:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhJFBLb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 21:11:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95B6C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 18:09:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m5so944761pfk.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UujgEphjMrEFczsS+HOszjq8VaQaCdHEXS9ra14Xg/Y=;
        b=iL+2ggrS0T6JsxdS97ruXStQMy6a3nTn6mvkABnxv8SMvTzAfLgOHy5EBzDZfNAZt+
         1h+WVG8ar3CzYzAouQhs+RcOt/JlDk5Gy1J7xIUS6MWz4cvLnkZeHt06Quk6D083SVkl
         y9RlrzYbhRJ3ZlmxSgpASoDHts0JyrMZEuHKDbx77IVtMkk511ETTNivy0mJbY9NcYJ7
         lQeYUPdsIVajqfj7X+dz4RU0nBIlR4aLURworR7gs0zLMuuNdzrQnNWOA5NvPgG1JwjM
         JjOZlObeknLtuZF6DE0vYTJYQRUM8LVpFJ7g3aBngqgfJLN9UobDcmm+ckrjR1WBDkbL
         XyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UujgEphjMrEFczsS+HOszjq8VaQaCdHEXS9ra14Xg/Y=;
        b=kIha3Z2+k0UTaGkjmCKqzjyxu8E/28jR8f8PG8gIk11m1F9kzy2xT8jI0j1R8iShN5
         C9phoBfGysZowkYg/Zq71VEkBO3iqi1oehlH1wmXSPD8MOfBJl1dwIW3HodHGIBTQCXR
         yCFuWXAAY6lPrloWU3/kwL7kud15zLzmi0b+CzpcO0KECDDoN0qFqemL2zbLh1SVJuw7
         Dq4ExRH/0r2VbKtcJWLQj2bXn32mKmieURe0DnE38JrnMcjcTMFt2AGe2VwoE08cPPGl
         aXZM4MwKVfpPTOvE1joEfIP+1/QDFdNq1SZ45dNjCcH+rPB4VJfzWeOjIV9se94twyOu
         g0dw==
X-Gm-Message-State: AOAM531asLtlgiDtznoRqT9injUbAxBgFNvndqIdqSRoEgnVfssGzmx4
        BUueWWRj2gOb3H0cPG/cTIPYVXffJUM=
X-Google-Smtp-Source: ABdhPJwpgE/TrgdQqgk/OSCjb7HQDMCcp8nWXOY7uXq7irrQmNx5zSoKENrep2NMvTcUCCksY+gqfw==
X-Received: by 2002:a62:9242:0:b0:446:5771:7901 with SMTP id o63-20020a629242000000b0044657717901mr33394410pfd.81.1633482579983;
        Tue, 05 Oct 2021 18:09:39 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id nr14sm3158988pjb.24.2021.10.05.18.09.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:09:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix handling of SUSPEND_DISCONNECTING
Date:   Tue,  5 Oct 2021 18:09:34 -0700
Message-Id: <20211006010935.902645-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006010935.902645-1-luiz.dentz@gmail.com>
References: <20211006010935.902645-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When SUSPEND_DISCONNECTING bit is set that means Disconnect is pending
but the code was evaluating if the list is empty before calling
hci_conn_del which does the actual cleanup and remove the connection
from the list thus the bit is never cleared causing the suspend
procedure to always timeout when there are connections to be
disconnected:

Suspend/Resume - Success 5 (Pairing - Legacy) - waiting done
  Set the system into Suspend via force_suspend
= mgmt-tester: Suspend/Resume - Success 5 (Pairing -..   17:03:13.200458
= mgmt-tester: Set the system into Suspend via force_suspend    17:03:13.205812
< HCI Command: Write Scan E.. (0x03|0x001a) plen 1  #122 [hci0] 17:03:13.213561
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4         #123 [hci0] 17:03:13.214710
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3      #124 [hci0] 17:03:13.215830
        Handle: 42
        Reason: Remote Device Terminated due to Power Off (0x15)
> HCI Event: Command Status (0x0f) plen 4           #125 [hci0] 17:03:13.216602
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4      #126 [hci0] 17:03:13.217342
        Status: Success (0x00)
        Handle: 42
        Reason: Remote Device Terminated due to Power Off (0x15)
@ MGMT Event: Device Disconn.. (0x000c) plen 8  {0x0002} [hci0] 17:03:13.217688
        BR/EDR Address: 00:AA:01:01:00:00 (Intel Corporation)
        Reason: Connection terminated by local host for suspend (0x05)
@ MGMT Event: Device Disconn.. (0x000c) plen 8  {0x0001} [hci0] 17:03:13.217688
        BR/EDR Address: 00:AA:01:01:00:00 (Intel Corporation)
        Reason: Connection terminated by local host for suspend (0x05)
Suspend/Resume - Success 5 (Pairing - Legacy) - test timed out
= mgmt-tester: Suspend/Resume - Success 5 (Pairing -..   17:03:13.939317
Suspend/Resume - Success 5 (Pairing - Legacy) - teardown
= mgmt-tester: Suspend/Resume - Success 5 (Pairing -..   17:03:13.947267
[   13.284291] Bluetooth: hci0: Timed out waiting for suspend events
[   13.287324] Bluetooth: hci0: Suspend timeout bit: 6

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7d0db1ca1248..3cba2bbefcd6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2987,14 +2987,6 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_disconn_cfm(conn, ev->reason);
 
-	/* The suspend notifier is waiting for all devices to disconnect so
-	 * clear the bit from pending tasks and inform the wait queue.
-	 */
-	if (list_empty(&hdev->conn_hash.list) &&
-	    test_and_clear_bit(SUSPEND_DISCONNECTING, hdev->suspend_tasks)) {
-		wake_up(&hdev->suspend_wait_q);
-	}
-
 	/* Re-enable advertising if necessary, since it might
 	 * have been disabled by the connection. From the
 	 * HCI_LE_Set_Advertise_Enable command description in
@@ -3012,6 +3004,14 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_conn_del(conn);
 
+	/* The suspend notifier is waiting for all devices to disconnect so
+	 * clear the bit from pending tasks and inform the wait queue.
+	 */
+	if (list_empty(&hdev->conn_hash.list) &&
+	    test_and_clear_bit(SUSPEND_DISCONNECTING, hdev->suspend_tasks)) {
+		wake_up(&hdev->suspend_wait_q);
+	}
+
 unlock:
 	hci_dev_unlock(hdev);
 }
-- 
2.31.1

