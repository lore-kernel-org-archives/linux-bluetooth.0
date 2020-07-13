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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20161C433E7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3ED82068F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSGENNWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgGMGIz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGIz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:08:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B13FC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so3856788pls.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PK9IFrqGA8tYf+eWNXSfj5UIMsffCcBtO2fOhU2TTN4=;
        b=mSGENNWuz+5DFcCC++eo64EguI3yOMGm+wbneGECzOF+p3uN2wnjo82+pBQDToUzOq
         glUk9u3mTEWocdjxMo41FNifcAmUveljzUTvjSvLgQmN64evIJZdyLY93Uy++YGXRFWc
         iOn9I5Daktdi0Zn3NJoj7W0SV4glqhfgdb3NlFRiEl4GeTfBJvvLe6plxy6aqc5aGuBx
         emMCW0DU/F4bJV5Pn9qkTixAta17IsJjOTWskH5Ra6XM9snQ5k1m3OXx+99Oyheg4BZW
         OMEEwAk4jZqyWTMPJit+rPUcKCoWJHznO7oTw/eB5vr0/foUbcUigz5snvWiziBfyrKu
         yT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PK9IFrqGA8tYf+eWNXSfj5UIMsffCcBtO2fOhU2TTN4=;
        b=NmSuAuztgRWvO9Jtz/CWtbfTuGfut/AMbEj53YSmj9Q4psZas56eg7Odu6Z2MuJ8R+
         8Wbn4kuKvN5w6JLxmN4ez5jPqbKyNxW8aayqebm9euAhVH8tjPW7v+Uh/XWwUxPM1sQ/
         /8jf31SuNAZl+l2B38l//6dfQKKlWOzjN188VLpRwvvLtb8hC72xxnllCVzksP2yjAwl
         PysC0ksTteoGZU48jxyAOQu52+SogGUkJ2kBKFSBxnmy8CQF4g5lVCFXDFsRj3KkKcFk
         Kxy6tA6vaSqdrJtv+o+nAbwFPHUh4IfHjDgKMx8lkG7bvRtAASUESuc6ub5hGQGm3fCp
         Jk0g==
X-Gm-Message-State: AOAM5317LATQWkN4di7Mu3+qbZUJ6XaiRdBMh+tN+6DvOT/WG7lj9jZL
        qm0g+vOV1WE71GCxJNCYEi6591nnGfhQiw==
X-Google-Smtp-Source: ABdhPJx2384XBpTsijDnW4mdF4LV1bBMe5R6BRfL9GoNcFsij5XZ1yQVyfU+y5reTHiSHJqM9ql3yA==
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr18743064pjb.181.1594620534693;
        Sun, 12 Jul 2020 23:08:54 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id e5sm12787172pjy.26.2020.07.12.23.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:08:54 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 7/8] Bluetooth: Enable RPA Timeout
Date:   Mon, 13 Jul 2020 11:42:19 +0530
Message-Id: <20200713061220.3252-8-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713061220.3252-1-sathish.narasimman@intel.com>
References: <20200713061220.3252-1-sathish.narasimman@intel.com>
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

