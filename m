Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE54C34026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 14:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CE722B48
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 14:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prE2QiPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBROrS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:47:18 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40881 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgBROrS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 09:47:18 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so1089294pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lqRkHzdACsQRLJjUsOOjqJQcPqRbQU/3UQn/jXoSJv8=;
        b=prE2QiPbXsHXKGa4W2kFnXcQUmTVQPaCPQXB3YD5wvvewWPp05GTcVPdtH6T4TRLFf
         8lP9deKQYM20ksnk41FtK/3UKu0lip3ok3v5F3wKbgwP8hZxuC3Plk2No80aV+Cnmm67
         i552DONYs2/ICVUOXqOK24BbBuKjyr15EHsyRONVfrm3+WMxulGNLeabbGB0QQD9LU7x
         Kddf8Mcgpl6ldAFHvxnXUin57bZvkggF3RFAT6RrNRHkHYbWg+MkkktXBMW26xhLTkQN
         gY8l4JdfVUMt8zC9Ur0SR0q5Du3Ox8gNfrkpZPzmAqbjfbV+sb/1d5HnL6wWTP1ROueU
         E+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lqRkHzdACsQRLJjUsOOjqJQcPqRbQU/3UQn/jXoSJv8=;
        b=Pd0xpAM2Ab8rtbLfRG3IcC35V21X87upa+RupLESJgnrfqdq9lr024GkauZlD/3L0o
         WBp/+db5qJ+5M62kpM0MClLx5LmOUps/eaSwShsGgsuVp4rnycxT9RLrdA4g9ae9v2s9
         whQMegP0NyOjbqXSIr9/MSfwe9dRq+ccF1BYvxpnrRldsqjw3pSrFSf0iBGWjaUsn13K
         b/PXPmCs6M7L3l1Q+KLS3Sbe3PkVv8rz1qHl9baSmpspt7QtSCr8W5ajpogmaCjZf8Gm
         3HSM16WwceSQPLg4hk7pW8OPAMc0YrLKL0jqon3ZZHd8BuOkzgcG0ALLo+LPUw2/o3tW
         LtYQ==
X-Gm-Message-State: APjAAAWbfV3TVJFqQKYDK3IrZaBzSQ0yVQ3+/ovVDYmIRrgNwUX7VItG
        uTd3/JPvg/BNP25c41cbBy7bN6aC7FvvTg==
X-Google-Smtp-Source: APXvYqw/TtS7aMZKqpxx/fnzbgeIACRZhKEOJ51MbrBflY2AxM/qBuYs1mD7sDZElePTMcS9plBZHA==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10mr21523346plb.288.1582037236125;
        Tue, 18 Feb 2020 06:47:16 -0800 (PST)
Received: from nsathish-Latitude-7480.iind.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id l26sm4973082pgn.46.2020.02.18.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 06:47:15 -0800 (PST)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: Fix - Remove adv set for directed advertising
Date:   Tue, 18 Feb 2020 20:18:40 +0530
Message-Id: <20200218144840.2854-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Extended advertising Data is set during bluetooth initialization
by default which causes InvalidHCICommandParameters when setting
Extended advertising parameters.

As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
advertising_event_property LE_LEGACY_ADV_DIRECT_IND does not
supports advertising data when the advertising set already
contains some, the controller shall return erroc code
'InvalidHCICommandParameters(0x12).

So it is required to remove adv set for handle 0x00. since we use
instance 0 for directed adv.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h |  2 ++
 net/bluetooth/hci_conn.c    | 10 ++++++++++
 net/bluetooth/hci_request.c |  5 +++++
 net/bluetooth/hci_request.h |  1 +
 4 files changed, 18 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6293bdd7d862..0d7e36c54733 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1724,6 +1724,8 @@ struct hci_cp_le_set_ext_scan_rsp_data {
 
 #define LE_SET_ADV_DATA_NO_FRAG		0x01
 
+#define HCI_OP_LE_REMOVE_ADV_SET	0x203c
+
 #define HCI_OP_LE_CLEAR_ADV_SETS	0x203d
 
 #define HCI_OP_LE_SET_ADV_SET_RAND_ADDR	0x2035
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 65fa44cbe514..1887da39a93d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -898,6 +898,16 @@ static void hci_req_directed_advertising(struct hci_request *req,
 		cp.peer_addr_type = conn->dst_type;
 		bacpy(&cp.peer_addr, &conn->dst);
 
+		/* As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
+		 * advertising_event_property LE_LEGACY_ADV_DIRECT_IND
+		 * does not supports advertising data when the advertising set already
+		 * contains some, the controller shall return erroc code 'Invalid
+		 * HCI Command Parameters(0x12).
+		 * So it is required to remove adv set for handle 0x00. since we use
+		 * instance 0 for directed adv.
+		 */
+		hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(cp.handle), &cp.handle);
+
 		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
 
 		if (own_addr_type == ADDR_LE_DEV_RANDOM &&
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 2a1b64dbf76e..63da7acbb48c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1550,6 +1550,11 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 	return 0;
 }
 
+void __hci_req_remove_adv_set(struct hci_request *req, u8 handle)
+{
+	hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(handle), &handle);
+}
+
 void __hci_req_clear_ext_adv_sets(struct hci_request *req)
 {
 	hci_req_add(req, HCI_OP_LE_CLEAR_ADV_SETS, 0, NULL);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index a7019fbeadd3..8dd40c6c33c8 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -84,6 +84,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
 int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance);
+void __hci_req_remove_adv_set(struct hci_request *req, u8 handle);
 void __hci_req_clear_ext_adv_sets(struct hci_request *req);
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			   bool use_rpa, struct adv_info *adv_instance,
-- 
2.17.1

