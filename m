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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C173FC71155
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 04:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785C621741
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 04:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTydQWsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbgKZEWq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Nov 2020 23:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbgKZEWq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Nov 2020 23:22:46 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B14BC061A04
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 20:22:46 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id g17so407794qtr.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 20:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cp7XWeYCe0e6iXMYc1MnVs3YoynGsT/DIsB1UMkVw5s=;
        b=HTydQWsksovCQ1sBhhS+eG162ekmiDlrdtMuvFpF2lhJEnkwUw3qx9/O063obBGLhi
         CxisPe51ECLvsM++4S6Sg7vjFUa1tXuAt8Ksi/Me+UHcNFMqIhGSxtdYe67O5QsCHhwx
         w9Ncby5x052VJNG3ruClH0QKpnAXuGba7EOazSngGFN2LLGlJ0G1AczHvFY5tuitOQtw
         JZyYbcO5BeTyG/+b3lfeg9KYNE/CS3B/0S3BcWPVQG+el7rW7LxrBnwXVDY8aOKU1Mwu
         uqY27YYipzPt3pWiV/p+Zy6A4XNu1uHGgfZomq0mTfznhunNvRoQy0X4NkvZ+Qt30cPa
         gbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cp7XWeYCe0e6iXMYc1MnVs3YoynGsT/DIsB1UMkVw5s=;
        b=M7l1SZAuZo6mxNyKFYFl9oU+AM63hma6jSft4jvL6R2TCcRnba93ynW5ZfttE+v4b8
         yWz63g1yYHVhme3NpAAxcNcbgoN3U+KRc1e+MTQz1+Z9qZ9ZpIoDanhNFfvpkoRlZPay
         ssguFBcg2czHYsj2mUrAALDhXmouvSiqeMOTuzQJQ3kw+HA3tZ3sRvrY/1kaHZd6zHE4
         8A/Su6cVqqQQE1JTR83xba2ec5QXNtx+BY5HSxaM/BBph9X6zgiM2WSorKfNz/N83lWP
         Vx8u0TPzYPfA0ZT4QQNBSzwp31BdkCo+8mxrqRza1LLbJVU+FAgMSOoDIt+UMUFVPBzN
         gzlw==
X-Gm-Message-State: AOAM532H+5B3B3mUrmCac+DpkZvabIHCOwWVpZ/jhgD3h6yYrdBy+i5V
        jAeWOHavAXjdsToC0jamj1mDl/8F7NU58XaJwVUjcvQ7Dsr3GSISxr1qhHQrxCXJzxclUNNDm7R
        yJPYaxR09NnqAY3eoyCGRKduP2Sv5wmrhk1u4K+qADoiEG5HXpTopZKonB2OqVjPpQf29QZPhV1
        Qv6wawJzKdBO8=
X-Google-Smtp-Source: ABdhPJxNvURFDRXZZXQtQ229PVfSw3Gy7ehSRZN3oIIxRTH8pyCkjYwjjiDvcC4HqmAqTVVY1mvpGzyOL8LIkks4PA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:4745:: with SMTP id
 c5mr1466805qvx.2.1606364565011; Wed, 25 Nov 2020 20:22:45 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:22:24 +0800
In-Reply-To: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201126122109.v11.4.I9231b35b0be815c32c3a3ec48dcd1d68fa65daf4@changeid>
Mime-Version: 1.0
References: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v11 4/5] Bluetooth: Refactor read default sys config for
 various types
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mcchou@chromium.org, mmandlik@chromium.org,
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

(no changes since v8)

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
2.29.2.454.gaff20da3a2-goog

