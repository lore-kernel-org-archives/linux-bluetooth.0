Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD123C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 07:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414162085B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 07:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBsCDC/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKSHhy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 02:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKSHhx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 02:37:53 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46BFC0613CF;
        Wed, 18 Nov 2020 23:37:53 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a18so3640699pfl.3;
        Wed, 18 Nov 2020 23:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/3JMDRVZProLbkhyFdNZPSvqTlToyEj4ZGqnHUtqyw=;
        b=jBsCDC/ax1VmYPFKpUqNPYkvoEtI9Z5q7LgWeGaLKOInIL6lkS+TA9HtG3XxaXKxJ/
         mJMy+D//PDO1Z4EL30/whH83kB09TZqq61jZwlumHcVSvIgWG/ZcHdTz7SOVEj9Ywf7B
         XMAFpT/inCNbhBVUgAWajMrxjNEOZ23Hak60csLlyJzZCqws6NIMKyE0fd2BNqNvawxD
         5dDyhvrlQ3jQ/n79Bg+DZo0Iflvg6tqH9tX053OJWBcuG2FS1CACa9+PmhSD3lCHqUlR
         VGAUomrwSD1KRFCkJc4tQVq0b8SpSuKZOVzjQGz1UDuwYtAYWFA46gmG4B1MpClOIoxQ
         u0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/3JMDRVZProLbkhyFdNZPSvqTlToyEj4ZGqnHUtqyw=;
        b=MO2T8G+IP56WeZxvvnPET2IQnkauKRVNGvf42xExLxzmeh0ghqJoFwghsif+gQ1kgv
         uSthszz3UnebU55FqWl7qONrEbjV7OYWMeSNX5gWYXrHUQ9lfxqzJYYyAAnEorTCP+AP
         Ozu4jCG3LpHDaAhUeiHcRKHl6W16UyWCfV4Etkw9jOiAitXddtOkQOYd63/xc1DxnkCS
         DBvh9l2sow8AByagcJp3ocUHLFUcKGhrOVEJKDMwTzjJuKXa/chSe2bCgWKU161jTH4o
         GL3XWDupibpD1iMOczTZfz+SAq9NNSw4ud//+iSYOn8FrEWPzfFAOjp8q9hpmRfJTvSR
         1vxA==
X-Gm-Message-State: AOAM532RtOh5RxkB1I/obzbIul8nnkARctmgZPS+BostWLvLyuOpCkRv
        YYSdp0PyZO1YQe3MnSYS+Ol53Q0tGEhaeO1G
X-Google-Smtp-Source: ABdhPJzPbt7Ea2Xha1T7WKMC99KIUo0xz3SjrpF9fGF5MpNkWN6OLT95v2vamzggsn+fqT6A5K5Zbw==
X-Received: by 2002:a17:90a:e28a:: with SMTP id d10mr2592351pjz.70.1605771473052;
        Wed, 18 Nov 2020 23:37:53 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:ea:ea00:1b41:22b1:3b31:fc27])
        by smtp.gmail.com with ESMTPSA id b16sm5636678pju.16.2020.11.18.23.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 23:37:52 -0800 (PST)
From:   n01e0 <reoshiseki@gmail.com>
To:     linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, n01e0 <reoshiseki@gmail.com>
Subject: [PATCH] include/net/bluetooth/mgmt.h: fix typo in struct name
Date:   Thu, 19 Nov 2020 16:37:11 +0900
Message-Id: <20201119073710.385004-1-reoshiseki@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: n01e0 <reoshiseki@gmail.com>
---
 include/net/bluetooth/mgmt.h | 4 ++--
 net/bluetooth/mgmt.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 6b55155e05e9..d8367850e8cd 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -621,7 +621,7 @@ struct mgmt_cp_set_appearance {
 #define MGMT_SET_APPEARANCE_SIZE	2
 
 #define MGMT_OP_GET_PHY_CONFIGURATION	0x0044
-struct mgmt_rp_get_phy_confguration {
+struct mgmt_rp_get_phy_configuration {
 	__le32	supported_phys;
 	__le32	configurable_phys;
 	__le32	selected_phys;
@@ -658,7 +658,7 @@ struct mgmt_rp_get_phy_confguration {
 			     MGMT_PHY_LE_CODED_RX)
 
 #define MGMT_OP_SET_PHY_CONFIGURATION	0x0045
-struct mgmt_cp_set_phy_confguration {
+struct mgmt_cp_set_phy_configuration {
 	__le32	selected_phys;
 } __packed;
 #define MGMT_SET_PHY_CONFIGURATION_SIZE	4
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 12d7b368b428..3dfed4efa078 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3387,7 +3387,7 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 static int get_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 				 void *data, u16 len)
 {
-	struct mgmt_rp_get_phy_confguration rp;
+	struct mgmt_rp_get_phy_configuration rp;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
@@ -3451,7 +3451,7 @@ static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
 static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 				 void *data, u16 len)
 {
-	struct mgmt_cp_set_phy_confguration *cp = data;
+	struct mgmt_cp_set_phy_configuration *cp = data;
 	struct hci_cp_le_set_default_phy cp_phy;
 	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
-- 
2.25.1

