Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F69C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 05:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5295561354
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 05:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhKKFYB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 00:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbhKKFYA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 00:24:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08FBC06127A
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 21:21:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d8-20020a253608000000b005c202405f52so7713620yba.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 21:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bXvoGq85SjQrZE2UDJdD7tTQN0yXDS84CPrsHpU2ecg=;
        b=VNAzwo5Shkdg3dxf283rVfyylmMu5nAfaDf2I9NCkyk6Q8WBduzquCY9bhxqMRm3zd
         xNiLSjaTz+J6xeselnY+5QrX/WSJdTyyJvV4SPaw2m52+g6nyoLWGkjJbzg/dhQ/6INH
         5e3bgNOrylE88J5y/aS09oaUFoVdf9C8Nc9FPg5dHncD7X4q/McY1pf0jpv1AYxchz2X
         qkBDKJn/Cgunsnj3IiFE6ACpIOWdmKvKZ3uBunsljSpRuYttgbgzLbXdUuWUM9AKMqCm
         2mgkqFO1mOIQfj8eHp50jVv+lDP1fX2FEQIFhERMri+Ua4CTh0QyKB8J5gM7inE0Qokc
         ONug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bXvoGq85SjQrZE2UDJdD7tTQN0yXDS84CPrsHpU2ecg=;
        b=WtVNbXa1GQ3l3MBbCwbr2gb6aJLF76gSm/yq9ZZ7ShfoGSpsL3lHfHwm8WfjhtSkjI
         R0iiIw4817UbwM2i3Lm62lOLePXlvQUL/VO5/qDTrJb3lQCDiMT4ei241AK2eRa5POI6
         ng/wVYWKwff1Equi5+4iJ0Rs//a3Fqnl8K8jYdgJdEqvcZPvyQVgl6VZVdqqlHmak4Sv
         EwY4ezRQa6VCQ3IKmME0opLR6wKrDQSerBSLIdv5hgUjH8UnIl4VQB3SUQMnVmyYROy8
         +bHPZaXEVcazg7cziSCVeglcWPqjAN1aLPGtmkenGFTzl3ypE78tgrT01y6+9tbD10y9
         8Zxg==
X-Gm-Message-State: AOAM530tdjAxTdAm0mHCtSCXPgYY6iAX9u6N5em0+i+M5C+NnpSjG/Yj
        OCXUSpnvJn//NcJ0UJvYUCVF6odDB0mWJ/dWYQyFnqDmv/QPfV7Mt8vKp/GJF/6xq5SgoVvOOmj
        Rr0CiPjAO3A5EZNBVlCTu5jltK83/RRQGtAZpvhkt2dOYTnwfawu+lqUGK/5idbVm+z6o0+E7vU
        nI
X-Google-Smtp-Source: ABdhPJzLucYZdSz607KwUMA4pm8NAhPadPIQEQpMeYRLmJSFH9e2Hgaj8d39ogIHjaaLoIIHGDS24o0y/RuI
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b87e:3eb:e17e:1273])
 (user=apusaka job=sendgmr) by 2002:a25:3252:: with SMTP id
 y79mr5132719yby.5.1636608070701; Wed, 10 Nov 2021 21:21:10 -0800 (PST)
Date:   Thu, 11 Nov 2021 13:20:54 +0800
In-Reply-To: <20211111132045.v3.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
Message-Id: <20211111132045.v3.2.I4e34d9e5fdd7515aa15d0ee2ef94d57dcb48a927@changeid>
Mime-Version: 1.0
References: <20211111132045.v3.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v3 2/2] Bluetooth: Attempt to clear HCI_LE_ADV on adv set
 terminated error event
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
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

We should clear the flag if the adv instance removed due to receiving
this error status is the last one we have.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

Changes in v3:
* Check adv->enabled rather than just checking for list empty

 net/bluetooth/hci_event.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7d875927c48b..6cf882e6d7e7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5532,7 +5532,7 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_evt_le_ext_adv_set_term *ev = (void *) skb->data;
 	struct hci_conn *conn;
-	struct adv_info *adv;
+	struct adv_info *adv, *n;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -5558,6 +5558,13 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remove_adv_instance(hdev, ev->handle);
 		mgmt_advertising_removed(NULL, hdev, ev->handle);
 
+		list_for_each_entry_safe(adv, n, &hdev->adv_instances, list) {
+			if (adv->enabled)
+				return;
+		}
+
+		/* We are no longer advertising, clear HCI_LE_ADV */
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 		return;
 	}
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

