Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A61C4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 07:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC352080C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 07:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393853AbgLNHaO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Dec 2020 02:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLNHaN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Dec 2020 02:30:13 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC310C0613CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Dec 2020 23:29:27 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g18so11920273pgk.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Dec 2020 23:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UnPe12dT6b6iT2C3p6i0jSOevvJBWZfKVGfvi3n+4A=;
        b=eT+GqU2qoeWuLBldveCoVslUSrxOIVa2IZjrtcr6Q7RerPM7rFWrOhUpGPkf0xGN6c
         j/nPFAgGri8DY2g/qLWdm2jcst92kllfEsmnBfXio8h9floVPWSDeLha/Tyo0Zah4bjb
         9x9WVaIKA0ufM+BR+RM4we4lJl/yFngZ437eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UnPe12dT6b6iT2C3p6i0jSOevvJBWZfKVGfvi3n+4A=;
        b=bSosw8yDOhXUF4fJO93NSHF4xqyY4NXOu+5rrtcUajmtU5mz5Hn/4NzahjeRbraIov
         4rGpPdAOkcfznFAihugBkxP+t90Nc7I9LOjWqkoAUCCqdb+y+d4y9I6GVtP/naiMoZwv
         VqimMrclovA3A6gqC4CrscKX5z8ktaWSGyHsGWV6GumbJ8bO3Vdem55+dXDV6qM33KXi
         70eX46fvaamWf8A1kdtaJx00/wel0cguSSv7znMJpUw6dIEejNGH/zWYQgbO6TxH5OSo
         nz4Yi86jT8+94inFV4votu/SXBJqo7SXpqzZSSK9uuhGDY9vw+Wqu6V7LNOgHJ6D3iZJ
         t/5g==
X-Gm-Message-State: AOAM533AQ30p9+qnK/aWX0DDcXxI1UFbMHRfZ10jQ8C5cpeF6FE3gR5f
        h2vhgp7tVNcdNj0R72fBVNytpQ==
X-Google-Smtp-Source: ABdhPJyYR7QYt2Y7JFzV3OTCWyiglmqng5k93TIGp7kJzNduqM93tcZuMcXBbFERx+x9mDkIU7AE4Q==
X-Received: by 2002:a63:c26:: with SMTP id b38mr22979908pgl.333.1607930967361;
        Sun, 13 Dec 2020 23:29:27 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id gw7sm16746930pjb.36.2020.12.13.23.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 23:29:26 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        robh@kernel.org, sre@kernel.org, pavel@ucw.cz
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: hci_uart: Fix a race for write_work scheduling
Date:   Mon, 14 Dec 2020 15:29:21 +0800
Message-Id: <20201214072921.3402608-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In hci_uart_write_work, there is a loop/goto checking the value of
HCI_UART_TX_WAKEUP. If HCI_UART_TX_WAKEUP is set again, it keeps trying
hci_uart_dequeue; otherwise, it clears HCI_UART_SENDING and returns.

In hci_uart_tx_wakeup, if HCI_UART_SENDING is already set, it sets
HCI_UART_TX_WAKEUP, skips schedule_work and assumes the running/pending
hci_uart_write_work worker will do hci_uart_dequeue properly.

However, if the HCI_UART_SENDING check in hci_uart_tx_wakeup is done after
the loop breaks, but before HCI_UART_SENDING is cleared in
hci_uart_write_work, the schedule_work is skipped incorrectly.

Fix this race by changing the order of HCI_UART_SENDING and
HCI_UART_TX_WAKEUP modification.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 82f5169bf3d3 ("Bluetooth: hci_uart: add serdev driver support library")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/bluetooth/hci_ldisc.c  | 7 +++----
 drivers/bluetooth/hci_serdev.c | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index f83d67eafc9f..8be4d807d137 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -127,10 +127,9 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		goto no_schedule;
 
-	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
-		set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
+	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
+	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state))
 		goto no_schedule;
-	}
 
 	BT_DBG("");
 
@@ -174,10 +173,10 @@ static void hci_uart_write_work(struct work_struct *work)
 		kfree_skb(skb);
 	}
 
+	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
 		goto restart;
 
-	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 	wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
 }
 
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index ef96ad06fa54..9e03402ef1b3 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -83,9 +83,9 @@ static void hci_uart_write_work(struct work_struct *work)
 			hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
 			kfree_skb(skb);
 		}
-	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
 
-	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+		clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
 }
 
 /* ------- Interface to HCI layer ------ */
-- 
2.29.2.576.ga3fc446d84-goog

