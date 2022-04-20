Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669E2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 22:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiDTWR0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Apr 2022 18:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352762AbiDTWRY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Apr 2022 18:17:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5259A20F69
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 15:14:36 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id g21so3385236iom.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8mPG4K55GvP/c9OPDbf+XXwyJhzftHcTf1Vw8uoo1I=;
        b=aAHPKoaMhknPoL+QwEF/PuWKwYsTOoIadXl6kMxNNeiv4bXmFB+lI64a7Kj04v3s3e
         PmkRJyJWcxtAs1xRm9bBJFANmeYV+gql/nhide3bUcDEz429bnScZrDDMw2C1modhUgM
         DqR0Nyk2woCjNsZP2S2fmPupfoo+oIEgxzRtwOsLVFwG6yfwbB9sxcxk2CLObCwTd1jD
         B8w1KBjzbOa9ysQKRcpVo910dHBNtRxHKMsrRgqLG7AURZUSEJQm/QY9d5N6fjl2+0UY
         rT9Qkhs2rqgP0nSo36ojn0IVKUSHmQEwIB0JKyiEn8e4o6ROZFK7witSk7CykHLbX6mM
         fCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8mPG4K55GvP/c9OPDbf+XXwyJhzftHcTf1Vw8uoo1I=;
        b=BB9iW0zYS5dP6gXe0YojcYffBdNgslZBK2rj3CQQYp5TBKP3FjM5Yg0sipS9r6AeGi
         qol9BCZODJgO7szI/c37LQG98jNfEWShDdOHZzz7nCxrk+cpRzCikvuHJPmicaV8tHEZ
         UUOA/0KpSKjVakVdVcNKaVjzjTbAveBGjJrsnMCBxxCD7Wg2YqdeRqFZlr40pehdk/N6
         P3C+n9fg+1wMdOblRzFl4cbFb36NgjEOQLcDzvn339wHsVZEau+3BLu9/ERRZgzwsYYv
         NpwAY2k396PvD+AjnR07c3Vm0ix6v9bryrciREs+qE17KE/UNN1EqztDlFdDEG6H4adZ
         lGDA==
X-Gm-Message-State: AOAM533biiwgmgI6WyKwX2Jb4Eet4/NACFvnQo3/Cq8ttPKnCpqmNtkt
        VfNQq7L7NWkb34GfTh1NYLWAJJTpdfU=
X-Google-Smtp-Source: ABdhPJw338QElzWjgfDLgoBnvyehADJ+YhvQbj0MtEftfCRqP1LAA742epBZCxWLZoJihlqhtB9BHg==
X-Received: by 2002:a05:6638:258e:b0:32a:7db9:e769 with SMTP id s14-20020a056638258e00b0032a7db9e769mr4107988jat.113.1650492875489;
        Wed, 20 Apr 2022 15:14:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u12-20020a056e02170c00b002cc27d7fe26sm6498531ill.22.2022.04.20.15.14.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 15:14:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Fix checking for invalid handle on error status
Date:   Wed, 20 Apr 2022 15:14:33 -0700
Message-Id: <20220420221433.2933868-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit d5ebaa7c5f6f6 introduces checks for handle range
(e.g HCI_CONN_HANDLE_MAX) but controllers don't seem to respect the
valid range int case of error status:

> HCI Event: Connect Complete (0x03) plen 11
        Status: Page Timeout (0x04)
        Handle: 65535
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
[1644965.827560] Bluetooth: hci0: Ignoring HCI_Connection_Complete for
invalid handle

Because of it is impossible to cleanup the connections properly since
the stack would attempt to cancel the connection which is no longer in
progress causing the following trace:

< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)
= bluetoothd: src/profile.c:record_cb() Unable to get Hands-Free Voice
	gateway SDP record: Connection timed out
> HCI Event: Command Complete (0x0e) plen 10
      Create Connection Cancel (0x01|0x0008) ncmd 1
        Status: Unknown Connection Identifier (0x02)
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)
< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)

Fixes: d5ebaa7c5f6f6 ("Bluetooth: hci_event: Ignore multiple conn complete events")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abaabfae19cc..1cc5a712459e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3068,7 +3068,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	struct hci_ev_conn_complete *ev = data;
 	struct hci_conn *conn;
 
-	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
+	if (!status && __le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
 		bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for invalid handle");
 		return;
 	}
@@ -4690,7 +4690,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 	}
 
-	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
+	if (!status && __le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
 		bt_dev_err(hdev, "Ignoring HCI_Sync_Conn_Complete for invalid handle");
 		return;
 	}
@@ -5527,7 +5527,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	struct smp_irk *irk;
 	u8 addr_type;
 
-	if (handle > HCI_CONN_HANDLE_MAX) {
+	if (!status && handle > HCI_CONN_HANDLE_MAX) {
 		bt_dev_err(hdev, "Ignoring HCI_LE_Connection_Complete for invalid handle");
 		return;
 	}
-- 
2.35.1

