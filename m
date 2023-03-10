Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A24C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 15:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjCJP0X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjCJPZ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 10:25:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E882C141609
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 07:15:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso6024723ybu.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678461273;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ZxFQ1lCgbN700UyOUwQnE48bNFXti2FaZcvjdkd2/o=;
        b=DoeuEloTalasZej4IniSK91oO+mjn0TQylvFzkGG2ME+OjwanTIQ1mqeS4SCaBK9Wj
         jQmok9pVcrQbI//48zw31sLlM+Bt6sGnxYNXO5GuciWwmNTkoj8KjoMdvOvJ2nIO30f4
         etX514o8mStNGvouQmVs7VOP7fSFj5wKDjHYwfhuBl6b1LpXt8CSw+L3fusqws7xaRS/
         eR+MN3SqIJoO5vbttct5BPEode0OwbFOcSb3X/iDxRvl9t5MWRYdKnHTzHZZ5jPAzMqO
         qOM1Wc2R0TfmitAs8Qcm5JJ/WmPxH8R5FDGVeJCcZZGmSLgUF5s3HjdtzRAhFJpEiSHw
         x3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461273;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZxFQ1lCgbN700UyOUwQnE48bNFXti2FaZcvjdkd2/o=;
        b=p4rEOp8uo13HvD5FixGgqTXja3XGE3aO+EAsw+E+pVZZhgeiVOEyzPjf1wGL5PTNrj
         dOVWV6RnRpbjY6bAuHYxOc2yzpWsKVrr2KUSX+D0lYQW1ObapEhmD3IVAVrY67qdAIUM
         cn4diDgEkzf2TBQRe53mfpWmFhEv+LrtuX2QcMnzYQJ4mudN+MwJH/qi0hfY65Nq7i4r
         /z69+QnlKRnsdlUnw5rSJKXorQGZbM5iS3sX6nWXV2D0E3NoMe85Gp9VqF8Ne/YWdJP/
         Zctc1KCtN60VHCa9DgpyXf4Yu1JRWSVnWlDYGYthae/M5hJa7vXBlcPU+u2jJBdCz1Rp
         WHVA==
X-Gm-Message-State: AO0yUKXLtLxuHBOxGmDggMQdPy+H/Wv93rceTSUQ86+3Gf9/SFJSSNr4
        QqFrpcyB9CiW1tGHlxARHp2irVqIUGe3MRf6P16lrtGX+NxPD1FPJz9vPXuLeiYZ3flcA7b8yxm
        y5eu1ypkrGwXNT9P0VhDPDPh3EKsPxOviyJus/+AdVAMXIIW558H8lahjC3vHwNy8jyF8j4+AOQ
        KIM0lr3C4GyDc=
X-Google-Smtp-Source: AK7set9tt7CUK2UnASqnCB5Nh+1Un8yEY56uVij2WwgjgXM+zIZM86yJ8o6mXmjQzixEveuTFiFym18iqj4YT8ygew==
X-Received: from rcheleguini-vm3.c.googlers.com ([fda3:e722:ac3:cc00:52:384b:c0a8:ef])
 (user=rcheleguini job=sendgmr) by 2002:a81:6ed5:0:b0:52e:db9c:9ef2 with SMTP
 id j204-20020a816ed5000000b0052edb9c9ef2mr4ywc.269.1678461273214; Fri, 10 Mar
 2023 07:14:33 -0800 (PST)
Date:   Fri, 10 Mar 2023 15:14:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310151410.2686458-1-rcheleguini@google.com>
Subject: [PATCH] Bluetooth: Improve support for Actions Semi ATS2851 based devices
From:   Raul Cheleguini <rcheleguini@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, Raul Cheleguini <rcheleguini@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add two more quirks to resume the device initialization and basic
operation as the device seems not to support "Read Transmit Power"
and "Set Extended Scan Parameters".

< HCI Command: LE Read Transmit Power (0x08|0x004b) plen 0
> HCI Event: Command Status (0x0f) plen 4
      LE Read Transmit Power (0x08|0x004b) ncmd 1
        Status: Unknown HCI Command (0x01)

< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Status (0x0f) plen 4
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Unknown HCI Command (0x01)

Signed-off-by: Raul Cheleguini <rcheleguini@google.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0c94cd7f4af3..7382b021f3df 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4104,6 +4104,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_ACTIONS_SEMI) {
 		/* Support is advertised, but not implemented */
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 	}
 
 	if (!reset)
-- 
2.40.0.rc1.284.g88254d51c5-goog

