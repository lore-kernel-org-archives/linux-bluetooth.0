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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1179BC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 07:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EE92222A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 07:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLYI5x8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgKSHN0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 02:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgKSHN0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 02:13:26 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B5C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 23:13:25 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id j19so3401479pgg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2020 23:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKNEFIomBxfnbi+4NT6e6WwCIFMZAm6X4zxu6XPRGMk=;
        b=uLYI5x8sUXamBZlJyASasIJRcAuPkOdzOd7myCOTNCIpb68oF63Pcd981S0e1KuS92
         qeD1u87JkW/yEdWTMMxH5vfr7unedLPuH4SortqVZpfqieHFQw2yn8a0SX++U2ukKJ72
         8QbuJeQL0dI9nOkD6GQQY2kKTbJUZmNUYhRIMQCXv7wtGLd2V6YaXqyN64KVGwXOPbg2
         ebANwmsPrpys1sf9r0M+lkZcBXAOenGW+p7w/TobTEN2lbb1614WmyuCJZQyOssh6k20
         tPLZmyhsJVQPEYXe4yt3gRM0R8MTYKUsDp5f3NY17OtGilhFAlQ7QgDWpbN0GbWFT0U7
         fAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKNEFIomBxfnbi+4NT6e6WwCIFMZAm6X4zxu6XPRGMk=;
        b=M9CdOmrXHzkt8lUSXX7ps6ySFUuS3GHP7OBufp8LTlR/bnGNDMWg1Dfz7gtQ+7j16E
         jhuUxPeaKuTTSUDbrBYGT+vK6FPeT9Q6gYb0HOJOAJ98EDgk9++2yUhp/KJAQpv+1FQt
         k38dAlPi8HSWLPEfaKvJ+mBtCMCduXq6JJjxKtBEdWsvgwcvX8eeC2sVlM+ppc5GX2g+
         Pvg+eDkG7oEu2IAqdNY8X56w10dDs8vXafjlrjvQSW0fIbzflkRSOzk4aFUcNkzSYN0/
         E/wKIGrmhKw1RT69FpbAGafdNWUSJott6OBdUGptV4akjAYAZo3YcV8YqI+WYy+tPx8n
         NU9A==
X-Gm-Message-State: AOAM530vq9Ow24wLWfVJ+cAsDZah8XCSYoM0AcMz0S4jm2q5jWzZQFCt
        XdEg1QW8MAUVZOUQNlsBcTJa3utKD0RrM5bc
X-Google-Smtp-Source: ABdhPJzooAfR+8k82iZ04Na2PMl5GJlmw4y3OeoQozaRp6lktQX1fhSIHK+xFYMX8kzJ+9YPN/Ltpw==
X-Received: by 2002:a17:90b:1195:: with SMTP id gk21mr2897526pjb.163.1605770005416;
        Wed, 18 Nov 2020 23:13:25 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:ea:ea00:1b41:22b1:3b31:fc27])
        by smtp.gmail.com with ESMTPSA id c12sm26703607pgi.14.2020.11.18.23.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 23:13:24 -0800 (PST)
From:   n01e0 <reoshiseki@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, Reo Shiseki <reoshiseki@gmail.com>
Subject: [PATCH] include/net/bluetooth/mgmt.h: fix typo in struct name
Date:   Thu, 19 Nov 2020 16:10:39 +0900
Message-Id: <20201119071038.380502-1-reoshiseki@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Reo Shiseki <reoshiseki@gmail.com>

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

