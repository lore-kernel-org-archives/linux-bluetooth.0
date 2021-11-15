Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA7EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 13:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E6061B27
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 13:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhKON4I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 08:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhKONyO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 08:54:14 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78393C061204
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 05:51:18 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id r15so7754413uao.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 05:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sT7dVvX2xHNEaNzGRE8l0+idzX1B1bhslbP0R4UQEcI=;
        b=BV07h8q7iUdgIGGEd+5O2tC38ZAjwHNXhrka+u2xwHvXVPWZm2qK//pboiKnCoOtjQ
         no5Hn0GOu1nKyXYKTksTcVJkHwd0ZCYITk6tt/BdwYt/ShBsHYO4CdF1zP4LvazKXmGK
         DHX+q8A55RSHOptTpJJHLP1bFuJ2gFinrh2XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sT7dVvX2xHNEaNzGRE8l0+idzX1B1bhslbP0R4UQEcI=;
        b=4tweccp9hqd8fsw3FvMsMKmFmMDV6sVaHUkidSK3tGekxIrj4EueP2jb/YwInmikuC
         kpuvv/KrV8b5m8Dg9FEc4SVn4+V8cQQiT2TPDxT8aPBTzA8YSZ894pRGCQ8FgyL3Owp8
         7si6Si/0YZHfEPvRJvf6y8D/cb6RewdHf9kFjdEuejNkdwARtvzs6xntm3jVWFILORo5
         nuvw0AlUbJoeyXTKqb0HpprI2drP1WOaH1t9bQoOjqzoEvi9K8rWrqtdL48XUAGm/VhZ
         AUcOjeAD1GA/wKJP68MOGxlNkAbpjcq1aZGQ/8VEACzh9h1GeGKgbf6BRs0vyadxwuB3
         B9zw==
X-Gm-Message-State: AOAM532V3SDEnS08H7Su2itxp8nlU8pZXH83yen/mPIYMeQy3oCpeFPs
        llrvNXj6OGi+Y70Aqe94HVbPOo3+CpUD3CdB
X-Google-Smtp-Source: ABdhPJx+xMwfsIIFZniNq/ZtM1DXBSzD7TumhzSHXFzgoKd/AjtnBl08JpbfUCbjk0E59R/s1CjgtQ==
X-Received: by 2002:ab0:2041:: with SMTP id g1mr17506386ual.131.1636984277432;
        Mon, 15 Nov 2021 05:51:17 -0800 (PST)
Received: from alain.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.gmail.com with ESMTPSA id 128sm8752147vsx.19.2021.11.15.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 05:51:16 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>, mcchou@chromium.org
Subject: [PATCH] Bluetooth: Fix adv set removal processing.
Date:   Mon, 15 Nov 2021 13:51:14 +0000
Message-Id: <20211115135114.2763223-1-alainm@chromium.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When multiple advertisement sets are active and a single instance is
removed, the processing of hci_cc_le_set_ext_adv_enable will result in
considering all advertisements as disabled since the instance has
already been removed from the list.

The fix is to use the command parameters to validate the intent rather
than making an assumption based on the validity of the adv set.

remove_advertising() hci0

hci_req_add_ev() hci0 opcode 0x2039 plen 6
hci_req_add_ev() hci0 opcode 0x203c plen 1

hci_remove_adv_instance() hci0 removing 2MR
<-- This removes instance 2 from the adv_instances list

hci_cc_le_set_ext_adv_enable() hci0 status 0x00
hci_sent_cmd_data() hci0 opcode 0x2039
hci_cc_le_set_ext_adv_enable() adv instance 0, enabled 0
<-- This incorrectly assumes that all instances are
    being disabled while only handle 2 is being disabled.

hci_cc_le_set_ext_adv_enable() adv instance list status - before
hci_cc_le_set_ext_adv_enable() adv instance 3 is 1
hci_cc_le_set_ext_adv_enable() adv instance 1 is 1
hci_cc_le_set_ext_adv_enable() HCI_LE_ADV state before: 1
hci_cc_le_set_ext_adv_enable() adv instance list status - after
hci_cc_le_set_ext_adv_enable() adv instance 3 is 0
hci_cc_le_set_ext_adv_enable() adv instance 1 is 0
hci_cc_le_set_ext_adv_enable() HCI_LE_ADV state after: 0
<-- This is incorrect since handle 1 and 3 are still enabled
    in the controller

The fix was validated by running the ChromeOS bluetooth_AdapterAdvHealth
test suite.

Reviewed-by: mcchou@chromium.org
Signed-off-by: Alain Michaud <alainm@chromium.org>

---

 net/bluetooth/hci_event.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4b75a6cfeee..52161d04136f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1385,14 +1385,16 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
 				if (adv->enabled)
 					goto unlock;
 			}
-		} else {
+
+			hci_dev_clear_flag(hdev, HCI_LE_ADV);
+		} else if (!cp->num_of_sets || !set->handle) {
 			/* All instances shall be considered disabled */
 			list_for_each_entry_safe(adv, n, &hdev->adv_instances,
 						 list)
 				adv->enabled = false;
-		}
 
-		hci_dev_clear_flag(hdev, HCI_LE_ADV);
+			hci_dev_clear_flag(hdev, HCI_LE_ADV);
+		}
 	}
 
 unlock:
-- 
2.34.0.rc1.387.gb447b232ab-goog

