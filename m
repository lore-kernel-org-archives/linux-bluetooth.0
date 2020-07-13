Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A5C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B662075F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhQbI2ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGMGSx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgGMGSx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:18:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF4C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so5707935pjb.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PK9IFrqGA8tYf+eWNXSfj5UIMsffCcBtO2fOhU2TTN4=;
        b=NhQbI2ei67hufJgVSdS8zpkQQXKWe+xpErfVRbSXURKMOQ7eHBVc331c3BD0Dyp3yH
         bLzc/KC7PRop3VlBwJRmqGP549GoPyLTdxJKepJx1qXGXT86+8oTbGYcUGzVESe09sOL
         49ZH58GotMOGsiEUGuZWzNgP5TEsF+DWuEbqCtn+gxhOiIkVJyZm7erULcWSy+OpLTEa
         X9ijT7M47YPO+meb/naSGX6yCaJtQXKSamXZ5wv+BODYs4nV8M9XFLuZRGPjem1fPLTP
         Pjwk/aGQ4IqJk3LmDfXbND8CaI0k51mAncGYtex+9PTXX7247sv/FrW5qL7rEcIKAg4c
         enBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PK9IFrqGA8tYf+eWNXSfj5UIMsffCcBtO2fOhU2TTN4=;
        b=oQiJrIYJaM81WWNFeCr3oOf57cMZl2/Qa7ks3xTuTQ3w6o73olnH3ysr2dV7mCaqV6
         LENQUQVQEL8XiP+EP0N/uCPJwKjtbKciMsCbLVLr/bjvtM9XF1i+lJSzZ+oLN9YHC0+d
         tNjdSHvyaRDJtM+GRYl3wX0q8gu0PkIe+jOyslgMpm4qWk2bV6U2dwlstHfRvL3C0FNu
         i/14eSm80nRcnrsLqxTFv6HtjPFSF+ro3pH0hBDnE0icvpB4kvj8y4X8YpozGwM1aegg
         l9VVKXw+KbKwMVZGI0MTQfxxOs43jCecVDdL+8SKuGLWy8oOnqzJTzCal2JkBSthv8zO
         IdmA==
X-Gm-Message-State: AOAM533ARJ+7Oa0SwKlMo9GBSUf6rkaHuBTwNlq3B3qxmLdrj4s+v34U
        L53LGagyI9yHApLIzCasqi5uWFO64KMZDA==
X-Google-Smtp-Source: ABdhPJxfWUUJkvx7LaKkaub5iMWPPZChuj/DK9iVV92p4uvA7jUKRB8GAizrlWzKrg9qNpSBZt+mxA==
X-Received: by 2002:a17:90a:71c4:: with SMTP id m4mr19130787pjs.178.1594621132889;
        Sun, 12 Jul 2020 23:18:52 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 204sm13096371pfx.3.2020.07.12.23.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:18:52 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v4 7/8] Bluetooth: Enable RPA Timeout
Date:   Mon, 13 Jul 2020 11:52:12 +0530
Message-Id: <20200713062213.3692-8-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713062213.3692-1-sathish.narasimman@intel.com>
References: <20200713062213.3692-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Enable RPA timeout during bluetooth initialization.
The RPA timeout value is used from hdev, which initialized from
debug_fs

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index abab8b5981a7..4ff2fc4498f3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1637,6 +1637,8 @@ struct hci_rp_le_read_resolv_list_size {
 
 #define HCI_OP_LE_SET_ADDR_RESOLV_ENABLE 0x202d
 
+#define HCI_OP_LE_SET_RPA_TIMEOUT	0x202e
+
 #define HCI_OP_LE_READ_MAX_DATA_LEN	0x202f
 struct hci_rp_le_read_max_data_len {
 	__u8	status;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4af208b82138..2030536cc5d8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -762,6 +762,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_CLEAR_RESOLV_LIST, 0, NULL);
 		}
 
+		if (hdev->commands[35] & 0x40) {
+			__le16 rpa_timeout = cpu_to_le16(hdev->rpa_timeout);
+
+			/* Set RPA timeout */
+			hci_req_add(req, HCI_OP_LE_SET_RPA_TIMEOUT, 2,
+				    &rpa_timeout);
+		}
+
 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
 			/* Read LE Maximum Data Length */
 			hci_req_add(req, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL);
-- 
2.17.1

