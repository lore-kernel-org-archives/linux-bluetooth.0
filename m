Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F06CC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 05:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B5E611AD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 05:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhETFNh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 01:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhETFNg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 01:13:36 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A4C061760
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 22:12:16 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d15-20020a05620a136fb02902e9e93c69c8so11528937qkl.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 22:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nSHjW7bKWecnxQu3kZC8W2cm3ydg9WYf51lZYtMzgOg=;
        b=vMOyzNDeFx1M0xVAhwjqx0war39y6moGq+UKVlCCcBk5bnt3xZzpzsr6K88mh/0wj7
         wXEchgKN2iwi7xQ7tWHAjUHHwBXHbSrBl0vRuLN9r99Qmf2kxpE4tGpNUqyjXXwmdci4
         njMzdWq4Raas3wxwNTR+tcNWS5Puh5/l1qTNJBcjOX/4whGr4cKAGnDS49Yz/VqLP4G0
         NFr6ItR7Kgs9jSeNbML8IXxwDuYUSAyqLfk7kKLH3LuYbY01EOYQTOfBu4auVNvpItaF
         mNMxKkB9qFxCvRF70tqHDX+6zt/gOXaBR3kodT9H3MulXbyH+IBRYEhp7NZOtRf5dILG
         Kw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nSHjW7bKWecnxQu3kZC8W2cm3ydg9WYf51lZYtMzgOg=;
        b=d6Tvz5A170efmwqZSdcgGaHcBuNH7ZPitHnvl1/zTWXm+93S10/Jr5tquADUGwG07K
         Gbz5QmzZRzs5ljiwkr+/55bhViJgi1Qu8W/EKc/qUg2z59P6DCTf2pMJX1mDP/PJ8WEE
         lrvjDK3NZ54p4jzAmEwCpdtSlvalSzlNq7IJgVkcaFn+W0GxaT2hbIF9geV98zJIunRW
         nm2+BWBYDR7Jnjv0sIBaxOPP6e9EIlM1bRgYRzlkTFH554ToQzotyB0N/YNDCcM3LBsJ
         P3PvSSwy9IIfFRN+7+8+m4nvO3Sry6SAjwvEiXJUW0mobmAMvrL72VTeW957jM/woQ5Q
         NFIA==
X-Gm-Message-State: AOAM531AvOymu/oXVLUdKJPMO7vrClUU830eJ6L4j3Pzgl4MZzncd1lj
        AO53lq6o/k6SF61FYUwxyaSnq5HkS1abHeqcgLN2ji9jFiobULWuHMlC26iFncwm3tcgDySHV8L
        J8jHhHZ5Hs3MNhyzO5vJCbc+eutEqWo/ra3PQ55EfqDXQNf4l3qEgMeRbfQLCQrpmn1h60lD8qD
        wAumekEfP5hkQ=
X-Google-Smtp-Source: ABdhPJwQy5bIy4FKavqab+Kx8aF2GTMz69DN1UlXuxvD3QCWzHsTrIWRlA/EWOV/vDw4aNXYNhXNIErpZY5ypI2XpA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:5827:f259:c0e8:5b1d])
 (user=howardchung job=sendgmr) by 2002:a0c:e34b:: with SMTP id
 a11mr3693793qvm.24.1621487535094; Wed, 19 May 2021 22:12:15 -0700 (PDT)
Date:   Thu, 20 May 2021 13:12:09 +0800
Message-Id: <20210520131145.v2.1.I69e82377dd94ad7cba0cde75bcac2dce62fbc542@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2] Bluetooth: disable filter dup when scan for adv monitor
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

Disable duplicates filter when scanning for advertisement monitor for
the following reasons. The scanning includes active scan and passive
scan.

For HW pattern filtering (ex. MSFT), Realtek and Qualcomm controllers
ignore RSSI_Sampling_Period when the duplicates filter is enabled.

For SW pattern filtering, when we're not doing interleaved scanning, it
is necessary to disable duplicates filter, otherwise hosts can only
receive one advertisement and it's impossible to know if a peer is still
in range.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>

Signed-off-by: Yun-Hao Chung <howardchung@chromium.org>

---

Changes in v2:
- include the vendor name in the comment and commit messages

 net/bluetooth/hci_request.c | 46 +++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index fa9125b782f85..3465862429fb5 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -932,7 +932,7 @@ static bool scan_use_rpa(struct hci_dev *hdev)
 
 static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 			       u16 window, u8 own_addr_type, u8 filter_policy,
-			       bool addr_resolv)
+			       bool filter_dup, bool addr_resolv)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -997,7 +997,7 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 
 		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
 		ext_enable_cp.enable = LE_SCAN_ENABLE;
-		ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+		ext_enable_cp.filter_dup = filter_dup;
 
 		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
 			    sizeof(ext_enable_cp), &ext_enable_cp);
@@ -1016,7 +1016,7 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 
 		memset(&enable_cp, 0, sizeof(enable_cp));
 		enable_cp.enable = LE_SCAN_ENABLE;
-		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+		enable_cp.filter_dup = filter_dup;
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
 			    &enable_cp);
 	}
@@ -1053,6 +1053,8 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	u8 own_addr_type;
 	u8 filter_policy;
 	u16 window, interval;
+	/* Default is to enable duplicates filter */
+	u8 filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
 	/* Background scanning should run with address resolution */
 	bool addr_resolv = true;
 
@@ -1106,6 +1108,20 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	} else if (hci_is_adv_monitoring(hdev)) {
 		window = hdev->le_scan_window_adv_monitor;
 		interval = hdev->le_scan_int_adv_monitor;
+
+		/* Disable duplicates filter when scanning for advertisement
+		 * monitor for the following reasons.
+		 *
+		 * For HW pattern filtering (ex. MSFT), Realtek and Qualcomm
+		 * controllers ignore RSSI_Sampling_Period when the duplicates
+		 * filter is enabled.
+		 *
+		 * For SW pattern filtering, when we're not doing interleaved
+		 * scanning, it is necessary to disable duplicates filter,
+		 * otherwise hosts can only receive one advertisement and it's
+		 * impossible to know if a peer is still in range.
+		 */
+		filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
 	} else {
 		window = hdev->le_scan_window;
 		interval = hdev->le_scan_interval;
@@ -1113,7 +1129,8 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 
 	bt_dev_dbg(hdev, "LE passive scan with whitelist = %d", filter_policy);
 	hci_req_start_scan(req, LE_SCAN_PASSIVE, interval, window,
-			   own_addr_type, filter_policy, addr_resolv);
+			   own_addr_type, filter_policy, filter_dup,
+			   addr_resolv);
 }
 
 static bool adv_instance_is_scannable(struct hci_dev *hdev, u8 instance)
@@ -3135,6 +3152,8 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	u8 own_addr_type;
 	/* White list is not used for discovery */
 	u8 filter_policy = 0x00;
+	/* Default is to enable duplicates filter */
+	u8 filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
 	/* Discovery doesn't require controller address resolution */
 	bool addr_resolv = false;
 	int err;
@@ -3159,9 +3178,26 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	if (err < 0)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
+	if (hci_is_adv_monitoring(hdev)) {
+		/* Duplicate filter should be disabled when some advertisement
+		 * monitor is activated, otherwise AdvMon can only receive one
+		 * advertisement for one peer(*) during active scanning, and
+		 * might report loss to these peers.
+		 *
+		 * Note that different controllers have different meanings of
+		 * |duplicate|. Some of them consider packets with the same
+		 * address as duplicate, and others consider packets with the
+		 * same address and the same RSSI as duplicate. Although in the
+		 * latter case we don't need to disable duplicate filter, but
+		 * it is common to have active scanning for a short period of
+		 * time, the power impact should be neglectable.
+		 */
+		filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+	}
+
 	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval,
 			   hdev->le_scan_window_discovery, own_addr_type,
-			   filter_policy, addr_resolv);
+			   filter_policy, filter_dup, addr_resolv);
 	return 0;
 }
 
-- 
2.31.1.751.gd2f1c929bd-goog

