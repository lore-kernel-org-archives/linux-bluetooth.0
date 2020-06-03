Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE814C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC21F20674
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiFDCuvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgFCROe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgFCROe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:14:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACFBC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:14:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o6so2206058pgh.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5aGJDCTVUf27Q5D9JDTfavbwDNrp4VfqXTMY6QGNOA=;
        b=fiFDCuvxKqGHpKKO+MMyLyDL5EKslBQuoC5iZdAkp0GX3he7E5Xi6+6MlM6Uzikhvv
         DFaFPljD77rPgL29PUjFOj/rIk/hAnvCl1bVjWONpMzbNJpcmc+ZnonfnKLhTilZD/e0
         TUnzS32K0CaclBAq8eurabFa7Yy6PpWSwGdITZfUcaN25bi0BCWbjHIK9df0/EscmBEp
         oSEtpl5qaGaGEDNllirEhLt90QzBaj1/fJP5NpOnG3ju+DUUplFx/ofUEnN8oU81MuS3
         fRv2+s3WHPbD9st1rzKxJ054ngXLDGAzeEIGzzCxqx/yifaXDaxzQgQIAYHPw3NvKRMS
         2ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C5aGJDCTVUf27Q5D9JDTfavbwDNrp4VfqXTMY6QGNOA=;
        b=i1A0JrS1n30eQyqxfoHD6CSFozTuSClqYhYxClVPUqFg1tW2flcRU4dlJ8atqFbl61
         1zuePI6TcdmFJnZr3RzVSb1qI007F448WerpZpFxLV7gZ4T7ex5Bv/bXv97FujW0C0Rz
         belruLKxYfQliRDMVG+fZ5/l70pu+lB58/OA9/XYeSb9d6xtGA8cMi82W2G1v2Dcpw/C
         4MIDYQoORc0Icw7na2LzI0KM/Z20r6jiTYUK0fgkdDTHxwB0K/LtxgM3hPRRqzt/V6Ww
         PXJUvq/axFmu2wqUq++OyebyHrRTKpDhKu2SDj6u6JuPBOs2bjJq4BU/+3S7wyVwkPYo
         hFYA==
X-Gm-Message-State: AOAM532h7WPRSfgpttdX/m0tA3vEMHWGfIOsS+XA3mJJTFvV3ZyKKjrM
        tGpg/S/rHJmZlfqhe/6E+UurWQdGbyI=
X-Google-Smtp-Source: ABdhPJwFisMy2dylIof5pK6pv7bFWp3eV4AqsrdmCEQXfbwb5rs+INtIRYwZLPVx/zFMR+cBheUx3A==
X-Received: by 2002:a17:90b:23c8:: with SMTP id md8mr1002099pjb.72.1591204473343;
        Wed, 03 Jun 2020 10:14:33 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id x190sm2016770pgb.79.2020.06.03.10.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:14:32 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 7/7] Bluetooth: Enable RPA Timeout
Date:   Wed,  3 Jun 2020 22:47:13 +0530
Message-Id: <20200603171713.9882-8-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603171713.9882-1-sathish.narasimman@intel.com>
References: <20200603171713.9882-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1165dfea56a9..12005fbe6e09 100644
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
index f4ceda1f1454..67e1434c3f31 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -763,6 +763,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
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

