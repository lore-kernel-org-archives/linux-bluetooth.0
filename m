Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0981AC43460
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 14:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB3B611BF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 14:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349882AbhEROOT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 10:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349869AbhEROOQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 10:14:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A51CC061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 07:12:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a10so720987qtp.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reaganmcf.com; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KxUrJHmK65TUPhstPO4qv9AyRaQQt5FUyzzptUDCDVs=;
        b=dGS1CUsAyt5WH6CwLtWjRMx+wKJ5NJs4q+Eqi6Qld7mq+iKin2FTJsxRpSPr1MNvEq
         SolYyWAcb3S57slXilTwmmP74oXfqe8LMjb2ncND/pkITgEpfCo+XKZrn9E6EIFdbD9S
         PCsLP9Pb9CxwUURqh1OMvYxmJijWmUNrj7ww2xfqCbOwQZB4kgPX0UtocAN4jCXXUnmN
         UdLS9MszOOUAShZjxObVL/hWDvJo2c/vpdAWBeZlUXbvsvdu8qfp1Uf6OLTJu5+wj4FF
         d0cUbvwNe7eb7NMSdFGCMaGEc6DFhud7JkxHy+pwNSWXijTosm1ZgnQqKh8+qb0aKs8C
         nCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KxUrJHmK65TUPhstPO4qv9AyRaQQt5FUyzzptUDCDVs=;
        b=RsUEHn+MD+KcYNfgX+Aqdw8XGrgNnnjoQovlf+scQpU+0FsTM149UB3bRluNju6lAz
         dnOXECI0dAn6Jk+d2aDuyRJf8NNS+jbt7Nl9y4U3mv3LsEVCo1K131S09N8CAzlluIjw
         yBOTjtJMMp+yhhoNzAIkySNPxKkzic25zRrRszSIxyljRHOvscQwxKsd99EGJKE5jJ/R
         SsM4TJgN5cUfVwaZk9TNvLaemiG1Um6ItdS/nWUfO0g1BeYbWul/hITo0doWrC7NfhmM
         KQUlGviLtLG024Gob5UzjSNZEywn7Mk/lF6skqQQsjlo7+XVYpMTWoe+nev73VF0dhsH
         zvBg==
X-Gm-Message-State: AOAM533vpxO7QuewF7IDQogp9Hil5BN4X6LCch0E5xCkigrx81GHSjD3
        GNDJuRnAXeorEbfucAreQrtShn9XdVrI6oUgxYA=
X-Google-Smtp-Source: ABdhPJzePXqU7JOLB9Nzju7YbIQtifKC7+rzO6bB+Y1JtNXzJZCiBSjjLLqvK7gGiF/JQs44hmwsMQ==
X-Received: by 2002:a05:622a:289:: with SMTP id z9mr5012030qtw.325.1621347177389;
        Tue, 18 May 2021 07:12:57 -0700 (PDT)
Received: from [192.168.1.18] (c-73-112-152-161.hsd1.nj.comcast.net. [73.112.152.161])
        by smtp.gmail.com with ESMTPSA id e19sm1343447qtr.45.2021.05.18.07.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 07:12:57 -0700 (PDT)
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Reagan McFarland <me@reaganmcf.com>
Subject: [PATCH] Bluetooth: bfusb.c code style cleanup
Message-ID: <c4755ff4-3bae-a5c8-a081-78cd2e0c52f5@reaganmcf.com>
Date:   Tue, 18 May 2021 10:12:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Code styling / formatting changes made to drivers/bluetooth/bfusb.c to get rid of the warnings
when running the checkpatch.pl script.

Signed-off-by: Reagan McFarland <me@reaganmcf.com>
---
 drivers/bluetooth/bfusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 5a321b4076aa..b4da848bdcf5 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -275,6 +275,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
                case HCI_EVENT_PKT:
                        if (len >= HCI_EVENT_HDR_SIZE) {
                                struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;
+
                                pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;
                        } else {
                                bt_dev_err(data->hdev, "event block is too short");
@@ -285,6 +286,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
                case HCI_ACLDATA_PKT:
                        if (len >= HCI_ACL_HDR_SIZE) {
                                struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;
+
                                pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
                        } else {
                                bt_dev_err(data->hdev, "data block is too short");
@@ -295,6 +297,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
                case HCI_SCODATA_PKT:
                        if (len >= HCI_SCO_HDR_SIZE) {
                                struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;
+
                                pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;
                        } else {
                                bt_dev_err(data->hdev, "audio block is too short");
@@ -365,9 +368,8 @@ static void bfusb_rx_complete(struct urb *urb)
                        buf   += 3;
                }

-               if (count < len) {
+               if (count < len)
                        bt_dev_err(data->hdev, "block extends over URB buffer ranges");
-               }

                if ((hdr & 0xe1) == 0xc1)
                        bfusb_recv_block(data, hdr, buf, len);
--
2.31.1
