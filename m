Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3431C56201
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A356020809
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 10:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETGfwhm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgKJKS6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 05:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgKJKS5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 05:18:57 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12016C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 02:18:57 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id i20so7115986qtr.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 02:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ng9DznihbQUkFPdna2vLl5VrTCi12IJEIBLO5x+5mHI=;
        b=ETGfwhm8wmwbQFEBMthnHCpx0/T6RBXir36T/twL1eQvmmwlBFOyl2GvqYgtXuFSxH
         nfQXo1G92+RA9xV9/OH2AYDQLjQ8Z4qWZCMjuV0F1/JB0MCVboeY0VUxnNAUxXftVjbU
         +Yf+d+XZB9lVv+134lRRzPX/nHZHi4kxdmram0TzOB3ZSEX4qB0EWr8YPmQXwj76a/50
         E0WylOARkbriv3UzNeuwnHCXj6lVEEDFO3Zme/YsupPyKtlfAdAU26sz5/8RyYo3Nsus
         bRcdYqO1HlxLJo03E72oLLqrE/h2Q5knZvw6mdkI9HvYgvshqGTcvwVr6DFYXEscQLzp
         mzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ng9DznihbQUkFPdna2vLl5VrTCi12IJEIBLO5x+5mHI=;
        b=GZaqZhR76Abm0KtlDk/OPnCMHMfqayaiF+6YZAkC6PZ57Wlmi+fwyU9cl/sxUShE9o
         CkFps/awsV087nWIifXmd5x/8Awjh88vpPO4eapGZfLKXbflS7fYT8EP4A82z9Slwmxk
         T30VeN0VToN9/OKjGG//ZyGoWULXU47wSlqGq7n92h5mrCyex94BKSGj2A5gbtd1IrWB
         Zb/j7FLHQ0I4Hn8OLavyXcPKgbmRUNpvi5nG+JBbivfIjgc9vkLso4RuncceTrIas5i5
         rWeDohu3eqKnIBkCOmjoqLKwrxVAEptXsGvdewXwHD+MfV0PZFfKTdsVxQzLmq+qAKEr
         YZGA==
X-Gm-Message-State: AOAM532trazQv6qCu0EVRkCBCFE0TcHJpdL6DYOeSO0KIn1OpPXhO2yh
        c9G2Me9cnV06/I7pqU00WDCXt96qso2cu+vNCGWqMgrL5A/ORMD9PSxK6bwGHdIgiCr9v78bIMz
        CvaRsOcDEhLr8lPp+X3LLHpfMJeL09InTtDW1mvY4OISnC11xhks2Dja4IXGr6OGEqnAvaQfvNH
        373dGS2A8jbxc=
X-Google-Smtp-Source: ABdhPJzo+C1gW2N3WQm541fJ3trCx005qMtRnr0DomSImLDSdxmT72woNbFb2Cd4xQ1ZBHms/1n4jQcXXQsAtTOBNg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:5807:: with SMTP id
 dd7mr18821000qvb.35.1605003535685; Tue, 10 Nov 2020 02:18:55 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:17:54 +0800
In-Reply-To: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
Message-Id: <20201110181740.v8.5.I9231b35b0be815c32c3a3ec48dcd1d68fa65daf4@changeid>
Mime-Version: 1.0
References: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v8 5/6] Bluetooth: Refactor read default sys config for
 various types
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, mcchou@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Refactor read default system configuration function so that it's capable
of returning different types than u16

Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v8:
- Update the commit title and message

 net/bluetooth/mgmt_config.c | 140 +++++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 56 deletions(-)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 2d3ad288c78ac..282fbf82f3192 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -11,72 +11,100 @@
 #include "mgmt_util.h"
 #include "mgmt_config.h"
 
-#define HDEV_PARAM_U16(_param_code_, _param_name_) \
-{ \
-	{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
-	{ cpu_to_le16(hdev->_param_name_) } \
-}
+#define HDEV_PARAM_U16(_param_name_) \
+	struct {\
+		struct mgmt_tlv entry; \
+		__le16 value; \
+	} __packed _param_name_
 
-#define HDEV_PARAM_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
-{ \
-	{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
-	{ cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) } \
-}
+#define TLV_SET_U16(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
+		cpu_to_le16(hdev->_param_name_) \
+	}
+
+#define TLV_SET_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
+		cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) \
+	}
 
 int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 data_len)
 {
-	struct {
-		struct mgmt_tlv entry;
-		union {
-			/* This is a simplification for now since all values
-			 * are 16 bits.  In the future, this code may need
-			 * refactoring to account for variable length values
-			 * and properly calculate the required buffer size.
-			 */
-			__le16 value;
-		};
-	} __packed params[] = {
+	int ret;
+	struct mgmt_rp_read_def_system_config {
 		/* Please see mgmt-api.txt for documentation of these values */
-		HDEV_PARAM_U16(0x0000, def_page_scan_type),
-		HDEV_PARAM_U16(0x0001, def_page_scan_int),
-		HDEV_PARAM_U16(0x0002, def_page_scan_window),
-		HDEV_PARAM_U16(0x0003, def_inq_scan_type),
-		HDEV_PARAM_U16(0x0004, def_inq_scan_int),
-		HDEV_PARAM_U16(0x0005, def_inq_scan_window),
-		HDEV_PARAM_U16(0x0006, def_br_lsto),
-		HDEV_PARAM_U16(0x0007, def_page_timeout),
-		HDEV_PARAM_U16(0x0008, sniff_min_interval),
-		HDEV_PARAM_U16(0x0009, sniff_max_interval),
-		HDEV_PARAM_U16(0x000a, le_adv_min_interval),
-		HDEV_PARAM_U16(0x000b, le_adv_max_interval),
-		HDEV_PARAM_U16(0x000c, def_multi_adv_rotation_duration),
-		HDEV_PARAM_U16(0x000d, le_scan_interval),
-		HDEV_PARAM_U16(0x000e, le_scan_window),
-		HDEV_PARAM_U16(0x000f, le_scan_int_suspend),
-		HDEV_PARAM_U16(0x0010, le_scan_window_suspend),
-		HDEV_PARAM_U16(0x0011, le_scan_int_discovery),
-		HDEV_PARAM_U16(0x0012, le_scan_window_discovery),
-		HDEV_PARAM_U16(0x0013, le_scan_int_adv_monitor),
-		HDEV_PARAM_U16(0x0014, le_scan_window_adv_monitor),
-		HDEV_PARAM_U16(0x0015, le_scan_int_connect),
-		HDEV_PARAM_U16(0x0016, le_scan_window_connect),
-		HDEV_PARAM_U16(0x0017, le_conn_min_interval),
-		HDEV_PARAM_U16(0x0018, le_conn_max_interval),
-		HDEV_PARAM_U16(0x0019, le_conn_latency),
-		HDEV_PARAM_U16(0x001a, le_supv_timeout),
-		HDEV_PARAM_U16_JIFFIES_TO_MSECS(0x001b,
-						def_le_autoconnect_timeout),
-		HDEV_PARAM_U16(0x001d, advmon_allowlist_duration),
-		HDEV_PARAM_U16(0x001e, advmon_no_filter_duration),
+		HDEV_PARAM_U16(def_page_scan_type);
+		HDEV_PARAM_U16(def_page_scan_int);
+		HDEV_PARAM_U16(def_page_scan_window);
+		HDEV_PARAM_U16(def_inq_scan_type);
+		HDEV_PARAM_U16(def_inq_scan_int);
+		HDEV_PARAM_U16(def_inq_scan_window);
+		HDEV_PARAM_U16(def_br_lsto);
+		HDEV_PARAM_U16(def_page_timeout);
+		HDEV_PARAM_U16(sniff_min_interval);
+		HDEV_PARAM_U16(sniff_max_interval);
+		HDEV_PARAM_U16(le_adv_min_interval);
+		HDEV_PARAM_U16(le_adv_max_interval);
+		HDEV_PARAM_U16(def_multi_adv_rotation_duration);
+		HDEV_PARAM_U16(le_scan_interval);
+		HDEV_PARAM_U16(le_scan_window);
+		HDEV_PARAM_U16(le_scan_int_suspend);
+		HDEV_PARAM_U16(le_scan_window_suspend);
+		HDEV_PARAM_U16(le_scan_int_discovery);
+		HDEV_PARAM_U16(le_scan_window_discovery);
+		HDEV_PARAM_U16(le_scan_int_adv_monitor);
+		HDEV_PARAM_U16(le_scan_window_adv_monitor);
+		HDEV_PARAM_U16(le_scan_int_connect);
+		HDEV_PARAM_U16(le_scan_window_connect);
+		HDEV_PARAM_U16(le_conn_min_interval);
+		HDEV_PARAM_U16(le_conn_max_interval);
+		HDEV_PARAM_U16(le_conn_latency);
+		HDEV_PARAM_U16(le_supv_timeout);
+		HDEV_PARAM_U16(def_le_autoconnect_timeout);
+		HDEV_PARAM_U16(advmon_allowlist_duration);
+		HDEV_PARAM_U16(advmon_no_filter_duration);
+	} __packed rp = {
+		TLV_SET_U16(0x0000, def_page_scan_type),
+		TLV_SET_U16(0x0001, def_page_scan_int),
+		TLV_SET_U16(0x0002, def_page_scan_window),
+		TLV_SET_U16(0x0003, def_inq_scan_type),
+		TLV_SET_U16(0x0004, def_inq_scan_int),
+		TLV_SET_U16(0x0005, def_inq_scan_window),
+		TLV_SET_U16(0x0006, def_br_lsto),
+		TLV_SET_U16(0x0007, def_page_timeout),
+		TLV_SET_U16(0x0008, sniff_min_interval),
+		TLV_SET_U16(0x0009, sniff_max_interval),
+		TLV_SET_U16(0x000a, le_adv_min_interval),
+		TLV_SET_U16(0x000b, le_adv_max_interval),
+		TLV_SET_U16(0x000c, def_multi_adv_rotation_duration),
+		TLV_SET_U16(0x000d, le_scan_interval),
+		TLV_SET_U16(0x000e, le_scan_window),
+		TLV_SET_U16(0x000f, le_scan_int_suspend),
+		TLV_SET_U16(0x0010, le_scan_window_suspend),
+		TLV_SET_U16(0x0011, le_scan_int_discovery),
+		TLV_SET_U16(0x0012, le_scan_window_discovery),
+		TLV_SET_U16(0x0013, le_scan_int_adv_monitor),
+		TLV_SET_U16(0x0014, le_scan_window_adv_monitor),
+		TLV_SET_U16(0x0015, le_scan_int_connect),
+		TLV_SET_U16(0x0016, le_scan_window_connect),
+		TLV_SET_U16(0x0017, le_conn_min_interval),
+		TLV_SET_U16(0x0018, le_conn_max_interval),
+		TLV_SET_U16(0x0019, le_conn_latency),
+		TLV_SET_U16(0x001a, le_supv_timeout),
+		TLV_SET_U16_JIFFIES_TO_MSECS(0x001b,
+					     def_le_autoconnect_timeout),
+		TLV_SET_U16(0x001d, advmon_allowlist_duration),
+		TLV_SET_U16(0x001e, advmon_no_filter_duration),
 	};
-	struct mgmt_rp_read_def_system_config *rp = (void *)params;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	return mgmt_cmd_complete(sk, hdev->id,
-				 MGMT_OP_READ_DEF_SYSTEM_CONFIG,
-				 0, rp, sizeof(params));
+	ret = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_READ_DEF_SYSTEM_CONFIG,
+				0, &rp, sizeof(rp));
+	return ret;
 }
 
 #define TO_TLV(x)		((struct mgmt_tlv *)(x))
-- 
2.29.2.222.g5d2a92d10f8-goog

