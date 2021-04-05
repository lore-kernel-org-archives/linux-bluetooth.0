Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07B6C43460
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 23:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9316121E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 23:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbhDEXdf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 19:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241707AbhDEXde (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 19:33:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED404C061788
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Apr 2021 16:33:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p12so6706050plw.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Apr 2021 16:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HPTI6CO+kSdi1thvqgPehfBWso2sQojBqpZVVccLYlA=;
        b=C7eJ3y6GPJ+S35NBKbS5DakcYR2ahrZCstmTJPcKVifURHE/CgGFEc86NbKipBmCSL
         dA6toN44nlCfvF5Iq3YPR//L0ZHwOIHQuwPmfmyOhPflVZeWT3D4PPpqt4XGx0fSjXyf
         /IOnTqYGD+xBC9k/PyhB4UWZ4dHALex2G+LXx5smKMES4ltU0n4mEorovDNIotAxShmD
         zwUNK58RzoxrTvZZGhVeCB1D7ZQOUkfogDlxEfDQ4LTXn8UOCVACsaAIS9M82V9uEGP6
         S6f0DRBQVTYs564cyxfQn2s70GsGiO4ggI86zgScEY0/J8FJjNEKZBNOIby4Pd7k/wrv
         BJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HPTI6CO+kSdi1thvqgPehfBWso2sQojBqpZVVccLYlA=;
        b=DI9FSKEVmwzYfTBPlWMhHzEpzq31qX0fv2JBQhyhEU58D1MUOu/wHele3RUKL2NV9r
         D6/QIP1x9eqmEohtxPe/ELoLuF4R8aiqT+pbr17wrMJQmPCzFmtBJh1mQvmKvmOR1j2i
         Sh7gJSZs/ZwR7MUn4q4nkpR4McOZG16dhMFWTJbQtOITlZ37lLQzJn1BiI+5NPuBjDaK
         MaceBRbPB4JEe5rmbQFisRMbKggXo9wBnwODVD6UXaybYQjtlOA+0zHYrQG9oGNxfX74
         4+ltzM4gPJ1ARv2tlvUyTfjJGaMI65xbOL2gqMuqVaqfy2oOmllwkkv41jUa4AGFP3Y0
         ccHQ==
X-Gm-Message-State: AOAM5301LmJ48JvfCaoDQxY0bszKDUpSHW8J860D0nEIG1M+natVc+VA
        pBsDQGeFw85bionv+g1blf4mRMP2kle+ZCbsZOjS
X-Google-Smtp-Source: ABdhPJy7yHGGqIVq9CL3HofU8vyHA6j9u/fhZ9DDqOZz4wzB7nBbLJwv9LS94A5oHwi8syBe2hqao59WdoyFg6kvM+yV
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:1cb3:ad22:2ed6:7c62])
 (user=danielwinkler job=sendgmr) by 2002:a17:902:7585:b029:e6:cc10:61fe with
 SMTP id j5-20020a1709027585b02900e6cc1061femr26020769pll.23.1617665606465;
 Mon, 05 Apr 2021 16:33:26 -0700 (PDT)
Date:   Mon,  5 Apr 2021 16:33:04 -0700
In-Reply-To: <20210405233305.92431-1-danielwinkler@google.com>
Message-Id: <20210405162905.1.I3c9905e2c5aa4d2e6c894b5cd18ce62350b8af4a@changeid>
Mime-Version: 1.0
References: <20210405233305.92431-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH 1/2] Bluetooth: Use ext adv handle from requests in CCs
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
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

Some extended advertising hci command complete events are still using
hdev->cur_adv_instance to map the request to the correct advertisement
handle. However, with extended advertising, "current instance" doesn't
make sense as we can have multiple concurrent advertisements. This
change switches these command complete handlers to use the advertising
handle from the request/event, to ensure we will always use the correct
advertising handle regardless of the state of hdev->cur_adv_instance.

This change is tested on hatch and kefka chromebooks and run through
single- and multi-advertising automated tests to confirm callbacks
report tx power to the correct advertising handle, etc.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 net/bluetooth/hci_event.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 593eafa282e31a..016b2999f21957 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1212,12 +1212,11 @@ static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!hdev->cur_adv_instance) {
+	if (!cp->handle) {
 		/* Store in hdev for instance 0 (Set adv and Directed advs) */
 		bacpy(&hdev->random_addr, &cp->bdaddr);
 	} else {
-		adv_instance = hci_find_adv_instance(hdev,
-						     hdev->cur_adv_instance);
+		adv_instance = hci_find_adv_instance(hdev, cp->handle);
 		if (adv_instance)
 			bacpy(&adv_instance->random_addr, &cp->bdaddr);
 	}
@@ -1778,17 +1777,16 @@ static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	hdev->adv_addr_type = cp->own_addr_type;
-	if (!hdev->cur_adv_instance) {
+	if (!cp->handle) {
 		/* Store in hdev for instance 0 */
 		hdev->adv_tx_power = rp->tx_power;
 	} else {
-		adv_instance = hci_find_adv_instance(hdev,
-						     hdev->cur_adv_instance);
+		adv_instance = hci_find_adv_instance(hdev, cp->handle);
 		if (adv_instance)
 			adv_instance->tx_power = rp->tx_power;
 	}
 	/* Update adv data as tx power is known now */
-	hci_req_update_adv_data(hdev, hdev->cur_adv_instance);
+	hci_req_update_adv_data(hdev, cp->handle);
 
 	hci_dev_unlock(hdev);
 }
@@ -5308,12 +5306,12 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (hdev->adv_addr_type != ADDR_LE_DEV_RANDOM)
 			return;
 
-		if (!hdev->cur_adv_instance) {
+		if (!ev->handle) {
 			bacpy(&conn->resp_addr, &hdev->random_addr);
 			return;
 		}
 
-		adv_instance = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
+		adv_instance = hci_find_adv_instance(hdev, ev->handle);
 		if (adv_instance)
 			bacpy(&conn->resp_addr, &adv_instance->random_addr);
 	}
-- 
2.31.0.208.g409f899ff0-goog

