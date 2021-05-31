Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D45C4708F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 08:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5FA1610C9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 08:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEaIk5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 May 2021 04:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhEaIkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 May 2021 04:40:24 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BEDC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 May 2021 01:38:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l2-20020a170902d342b02901017016fb83so1909985plk.19
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 May 2021 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3+0/7GJy4fkrHP3hKVJR1L2AmsjDQlSpYCZGYRpnWTE=;
        b=Cy6GZdM5lWEWKgTCbLbvSXh9hXk1kKp3brjUcsmQkfCJUKfLRw9xR7EiOZJQCneBdP
         ScbabMQN33PM9AZiJyXaQu2gKB9WLTi1a4GnW1jXxJiSzbTUaC78K/WkCqwsz7Z9XLWb
         X8bsXsut/sB87NIw3/UVqmPoevGf714tyIuGoDgqXpFZVJ84elXXEIvlSroJA5OvgfAN
         G41Wc/a+v+S7wo+L7kh8kvsCcXEDNkCtMffDOzvHfb+GTjtI9ajXh4zx1PcvX8g14HyO
         UUr0WxyFmyyAsVFts7Iu1ZpiYIFnNE1FdqNEeucr4WVdhhfd45KmBaW60FLPmaxxxVl0
         1dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3+0/7GJy4fkrHP3hKVJR1L2AmsjDQlSpYCZGYRpnWTE=;
        b=TxXmOYgTVN9FRvfT1LQ+l1B8X0f/Unyti6xWLZMo4EuLpJ1dnxMVNeUw8M4wNsg4yr
         kCGawgR3U9GaPY/n9Xqf2YlWyV8A1C3ogswTm7MINXyaKbho/VVSk8+IAGJSogt259dv
         8/v/nhYczltrXvH9B3kxnbA1knno7Bu/qzAf19UPW5t9zQtCVXClCperLfLql+a7IrOU
         PBULcPObWLvNPtyu4NoThb+D/dRJC6ofWCxzpntO5zeHTftEBFvuLep2mhWf37fAJdHx
         hvI8XjWS1tvByxgPkz+dWDhRS/NdIsxZ/Vm+vjOdtARwXVCGzlWHE2sZRYp5c99Pm4rE
         /Jnw==
X-Gm-Message-State: AOAM532fnBUvQnG2CmmsaXyXyNax3WJNeNqOZYzuY5MksDPa+N1cVC73
        SkKMpm4MYdt+rg54KGWhMcQQb3olt4oc/C4b0+f23q7/1H/p8IB1tP9s3242VGK/zANPoxs7AkK
        UMyDn688nGCFCwheoC3+1AvRAnEXfFo1NXdZz5wLQI0S4oUmBSXWWeJSveGRwRuATzMQTaJoBss
        Y8
X-Google-Smtp-Source: ABdhPJxVbyu6n1vVsDPmT3MbD9VSi2Nnv6spvRMc2YBC7aqFtGSLbrVlC0/zS2XNIS8B2aVawT6PRg34mAdC
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:a6d1:a727:b17d:154e])
 (user=apusaka job=sendgmr) by 2002:aa7:8392:0:b029:2db:4a7:d866 with SMTP id
 u18-20020aa783920000b02902db04a7d866mr15810561pfm.66.1622450323599; Mon, 31
 May 2021 01:38:43 -0700 (PDT)
Date:   Mon, 31 May 2021 16:37:23 +0800
In-Reply-To: <20210531083726.1949001-1-apusaka@google.com>
Message-Id: <20210531163500.v2.4.I12d95340363056b05f656880e3dad40322eab39f@changeid>
Mime-Version: 1.0
References: <20210531083726.1949001-1-apusaka@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 4/8] Bluetooth: use inclusive language in HCI LE features
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This patch replaces some non-inclusive terms based on the appropriate
language mapping table compiled by the Bluetooth SIG:
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

Specifically, these terms are replaced:
master -> central
slave  -> peripheral

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

Changes in v2:
* Add details in commit message

 include/net/bluetooth/hci.h |  6 +++---
 net/bluetooth/hci_event.c   | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a7cf5a2d87c5..441125f6b616 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -489,7 +489,7 @@ enum {
 /* LE features */
 #define HCI_LE_ENCRYPTION		0x01
 #define HCI_LE_CONN_PARAM_REQ_PROC	0x02
-#define HCI_LE_SLAVE_FEATURES		0x08
+#define HCI_LE_PERIPHERAL_FEATURES	0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
 #define HCI_LE_LL_PRIVACY		0x40
@@ -498,8 +498,8 @@ enum {
 #define HCI_LE_PHY_CODED		0x08
 #define HCI_LE_EXT_ADV			0x10
 #define HCI_LE_CHAN_SEL_ALG2		0x40
-#define HCI_LE_CIS_MASTER		0x10
-#define HCI_LE_CIS_SLAVE		0x20
+#define HCI_LE_CIS_CENTRAL		0x10
+#define HCI_LE_CIS_PERIPHERAL		0x20
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e5f3840abd1a..a809e90326d7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5243,17 +5243,17 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
 
-	/* The remote features procedure is defined for master
+	/* The remote features procedure is defined for central
 	 * role only. So only in case of an initiated connection
 	 * request the remote features.
 	 *
-	 * If the local controller supports slave-initiated features
-	 * exchange, then requesting the remote features in slave
+	 * If the local controller supports peripheral-initiated features
+	 * exchange, then requesting the remote features in peripheral
 	 * role is possible. Otherwise just transition into the
 	 * connected state without requesting the remote features.
 	 */
 	if (conn->out ||
-	    (hdev->le_features[0] & HCI_LE_SLAVE_FEATURES)) {
+	    (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES)) {
 		struct hci_cp_le_read_remote_features cp;
 
 		cp.handle = __cpu_to_le16(conn->handle);
@@ -5774,7 +5774,7 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 		if (conn->state == BT_CONFIG) {
 			__u8 status;
 
-			/* If the local controller supports slave-initiated
+			/* If the local controller supports peripheral-initiated
 			 * features exchange, but the remote controller does
 			 * not, then it is possible that the error code 0x1a
 			 * for unsupported remote feature gets returned.
@@ -5783,8 +5783,8 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 			 * transition into connected state and mark it as
 			 * successful.
 			 */
-			if ((hdev->le_features[0] & HCI_LE_SLAVE_FEATURES) &&
-			    !conn->out && ev->status == 0x1a)
+			if (!conn->out && ev->status == 0x1a &&
+			    (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES))
 				status = 0x00;
 			else
 				status = ev->status;
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

