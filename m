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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9717AC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5621B6142D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhEYKcb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhEYKcI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 06:32:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAC1C06134C
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:08 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l19-20020a0ce0930000b02901efdf1c21ecso27218849qvk.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JQK1EHK4aOakeCprBWj7aKMHOh08lvflh7jGMcWacII=;
        b=dJgZMfAMc/NW7C1vk8k5bgZAfmX4Ja/MgezxZhsFsc2vGRBBtuwdh5YRMaYbxBb5Ze
         ohNxUIOK3XGyg3xDonu05+hbskjIrB7ww+0dG2aUnFB2NhAsMlohmxFR/8ZI6MVlIQQJ
         OSrPiszHyZ0mOIqrbdxZuv9SSNooosasWOIJCdVEHKJk6VV7YTSqUzMEYfsIzbzfwCfY
         AegO3cSNEWH7jCjS/7Yg8Yi/GwNd4ib/Mg7Miht2mmed54yD0FrtBStoYRsRvseUjcIp
         HlLuTYlhKkv2V7LnfiJ6ib/kh1bLxxRgflid3ruqklnQPxC+jlFNadBDWzVXuCFMn5QE
         wM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JQK1EHK4aOakeCprBWj7aKMHOh08lvflh7jGMcWacII=;
        b=pwMBdP8hkYESz+RtUowDvQ7ERPfdZU5JsGiSL3YsMixClz8eQEPEdmUWYvNzhtyuCa
         EBLW668NN1THU7OTP3CsvNL9e5djAWjTuXjgpRLj+ugZQtErFAOh2a5sXbJlyqtwySyM
         +vgS40ax01nKKwrw66R+gK0iGMDOpY/vzPOjcumXfvhdHTDeXn0uQM2d/6VWelOFPjAk
         rxowIQWZgrLf/+kwnZkpdDFzvrf1H7YZ0GToyAUveN+JCbk+D0xbJoO4G3/SHd1md3xp
         aZKto2lYZBYgHm/Bqm4LGmrvy+8x/994YFLdG71CkmknMGBLXfEebDiKsWb5sPutlx6X
         gz1A==
X-Gm-Message-State: AOAM531cPv+eU6lm+Yn3GDwxkAJRrgE1q98xVFtJYRv3n7Oo96Lc5DFH
        tpXkdwC8ie3R94skjPgCpnMp5lDjF1jKHchQEBfkFgLQRrGOhe9in9hm0UoVp6PseBotbpCS9iB
        F0GEZRDwAMz5mxhwuI9T6XpPmyIFFjA6XdEhMICOaICRRlfIq4FAZMSPu5UqfIqtokRRTEgPI7S
        2G
X-Google-Smtp-Source: ABdhPJwNpUGygtLBgz6MEnsU96mYHVIJWIP0Wk1azb58WqTF+GZ5rpkpB/PFe3h+lfupzWd76OYB13UFw8A7
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:8806:6b98:8ae6:8824])
 (user=apusaka job=sendgmr) by 2002:ad4:4c45:: with SMTP id
 cs5mr36050943qvb.6.1621938607208; Tue, 25 May 2021 03:30:07 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:33 +0800
In-Reply-To: <20210525102941.3958649-1-apusaka@google.com>
Message-Id: <20210525182900.4.I12d95340363056b05f656880e3dad40322eab39f@changeid>
Mime-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 04/12] Bluetooth: use inclusive language in HCI LE features
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

Use "central" and "peripheral".

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

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
2.31.1.818.g46aad6cb9e-goog

