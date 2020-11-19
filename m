Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F36C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 07:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9B621D7F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 07:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9jlgDFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgKSH3N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 02:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgKSH3N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 02:29:13 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE882C0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 23:29:11 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t21so3444917pgl.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 23:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5+/4pAixRqg8Qib2CVi+X3JetDXdV+N2EObNHVq1jU=;
        b=Q9jlgDFwmzZURfsjScA8YmBy3DILkBWBKRt5omOpegmEBBr8St9VCu9KC8OLiFZJr3
         YiHbb8C1vQmftq6AmlVNm1fwEvruZm6kveV5dEcs5F7y+A5UcTeNBtLxTzb5EhYqJqBb
         kdUmjnFWsisrzSJ7Mp8zxMQWujoOEp5hlpNGvKGevCV7h8UxEmme8BEImfSvzwfwjxNT
         LJ4L1pqsrN2iQBiusNrzgjo8GJBUl01LRZ+2UndC57Yx8Si6vn3O1Xs0+G4l1tl0hgR/
         QF7Ff2O/wkIvnKSVXHeKwBlK2mnJrQ6kZ9T+wKKNqEajVevSZZs8gFLyxH7DgJICUTAQ
         PLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5+/4pAixRqg8Qib2CVi+X3JetDXdV+N2EObNHVq1jU=;
        b=joES7K7yfr99Xg8WwGfwNnGckzZhuDTRceTxKlVsnIlDlaGTyfrL608QIVq8vhB6KG
         2IhySBZ3Y9goA4tN09LRFSkzdzekyrwB5UM+s/++dVIfqYhmkS5qz34zra49AsqHcmGl
         zPTv2OOFbBh6QI60Paod7Uwde4bWsuPttb/EZwdMWpQCanguc7vfjB+jJSWLn1mrOi3Z
         go3rUAvZ0ZCayX+mKEMw0AeTdp2oKe+fWNAmkxzXrd4OmTuw5HjxFkq0N2vYsrg7sLKz
         KatxREVjcCBjqWW8ibaY9QeYByDMd/d8sC5PwrIdlHfws76A0YHfbFNxI3XszLmOGTQg
         tx8g==
X-Gm-Message-State: AOAM531+Z59Qff9ZOP5Kw1CXhS6yEgCX/JK01/e1B68VpxoVRzlD+cc5
        8Xd3PIckkvase1AT3GipXZOH8KPmX8+l97IQ
X-Google-Smtp-Source: ABdhPJwzdUd/iNFg55ASYzBVV6NMqCop7n+HiTutIQde3fzVrkVFQYknJz53kqAfVk4zvDp16+JDSg==
X-Received: by 2002:a17:90a:f3d1:: with SMTP id ha17mr3241645pjb.164.1605770951256;
        Wed, 18 Nov 2020 23:29:11 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:ea:ea00:1b41:22b1:3b31:fc27])
        by smtp.gmail.com with ESMTPSA id go8sm5155907pjb.56.2020.11.18.23.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 23:29:10 -0800 (PST)
From:   n01e0 <reoshiseki@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, Reo Shiseki <reoshiseki@gmail.com>
Subject: [PATCH] include/net/bluetooth/mgmt.h: fix typo in struct name
Date:   Thu, 19 Nov 2020 16:28:20 +0900
Message-Id: <20201119072819.384182-1-reoshiseki@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Reo Shiseki <reoshiseki@gmail.com>

Signed-off-by: Reo Shiseki <reoshiseki@gmail.com>
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

