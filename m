Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCBC636D4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 22:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBMWas (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBMWaq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 17:30:46 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0F31DB8A
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:30:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d2so13298875pjd.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+1SIKPQbZyXNxoWF1sOuN681PhVFf4YYd4/NhTCsmg=;
        b=h+ooCrO/N2sZob+NYlV65ihOp4LxG4aqYchZsNjb6DfxxXGqk3EqvZKHC7dGCRsm3O
         fOGOXUlFi3Q9FPBjwkWi0SdDElxSQpL/9eC31oNbJkQAhLaaZt9rnMMGScyGLAMsw/tD
         FDHt6/SGiwcV9BGT4dFWVr64KYUHNoolMKOUbuy37UEGbT48CjaKk2xDKmk7Hq/pMlvN
         rmjTuiYbTJiIlSC+HJM/bHuMIllZetYwfULBPWGytwigVgUgcHBkqki2f7Ogfp5OAiIm
         f9iZmQIsekkzCjrTKHW43jlZPgL/wC4lue98NdoBfzBWLc4c5sTvXR8rO/LOaMWulO21
         4wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+1SIKPQbZyXNxoWF1sOuN681PhVFf4YYd4/NhTCsmg=;
        b=LGtlOGdRniglw8Twi/amn6c3l5uJGI7nVRzTasw3FBkdXj+JpwTbqzNq0MDCiFFF1Q
         8Pyon9utJZxL3rRejWulUfn3riIdEyYk2wOOZl3OnHHYbg5rALTneNtSbJewx8fdLthH
         THOMvzucvDGzrzpMgcLaxetskQVh1k0cWKGh9FdoPGpAUteekM10kasgWVaVSRpIX5kM
         A2BbLftuL5ZRdI55ZUdoqs/TQ5wxzvplA9+8EWFOVJNZaAnP1+oEQoOLZEF0z5g9tLzz
         9Ow3E0cA850mgWQg91aHf7GpacuGDvhAIK6lBs6HRfJADlUkF+vZP+9iCQTF8hKRiVAn
         ubVQ==
X-Gm-Message-State: AO0yUKUJVrrBSUKllC7EVZQiZqcGiEnzh6kSYIUcTEqJ0UloBXeB/z5y
        k3MTskt6LZvYlWrfu17NCtCLD1KhDos=
X-Google-Smtp-Source: AK7set+y/MgYxcD9HMclG6Xp1HxXObg+l1kk+Up1tUoyjx9723LLen2PQ3FPuDRKl2uJAAhn5qkGgw==
X-Received: by 2002:a17:902:f54f:b0:199:26b1:17b3 with SMTP id h15-20020a170902f54f00b0019926b117b3mr475953plf.28.1676327444516;
        Mon, 13 Feb 2023 14:30:44 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d21-20020a170902aa9500b0019a71017ab2sm6774199plr.91.2023.02.13.14.30.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 14:30:43 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Use BIT macro when defining bitfields
Date:   Mon, 13 Feb 2023 14:30:42 -0800
Message-Id: <20230213223042.575952-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of BIT macro when defining bitfields which makes it
clearer what bit it is toggling.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/mgmt.h | 80 ++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e18a927669c0..a5801649f619 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -91,26 +91,26 @@ struct mgmt_rp_read_index_list {
 #define MGMT_MAX_NAME_LENGTH		(HCI_MAX_NAME_LENGTH + 1)
 #define MGMT_MAX_SHORT_NAME_LENGTH	(HCI_MAX_SHORT_NAME_LENGTH + 1)
 
-#define MGMT_SETTING_POWERED		0x00000001
-#define MGMT_SETTING_CONNECTABLE	0x00000002
-#define MGMT_SETTING_FAST_CONNECTABLE	0x00000004
-#define MGMT_SETTING_DISCOVERABLE	0x00000008
-#define MGMT_SETTING_BONDABLE		0x00000010
-#define MGMT_SETTING_LINK_SECURITY	0x00000020
-#define MGMT_SETTING_SSP		0x00000040
-#define MGMT_SETTING_BREDR		0x00000080
-#define MGMT_SETTING_HS			0x00000100
-#define MGMT_SETTING_LE			0x00000200
-#define MGMT_SETTING_ADVERTISING	0x00000400
-#define MGMT_SETTING_SECURE_CONN	0x00000800
-#define MGMT_SETTING_DEBUG_KEYS		0x00001000
-#define MGMT_SETTING_PRIVACY		0x00002000
-#define MGMT_SETTING_CONFIGURATION	0x00004000
-#define MGMT_SETTING_STATIC_ADDRESS	0x00008000
-#define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
-#define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
-#define MGMT_SETTING_CIS_CENTRAL	0x00040000
-#define MGMT_SETTING_CIS_PERIPHERAL	0x00080000
+#define MGMT_SETTING_POWERED		BIT(0)
+#define MGMT_SETTING_CONNECTABLE	BIT(1)
+#define MGMT_SETTING_FAST_CONNECTABLE	BIT(2)
+#define MGMT_SETTING_DISCOVERABLE	BIT(3)
+#define MGMT_SETTING_BONDABLE		BIT(4)
+#define MGMT_SETTING_LINK_SECURITY	BIT(5)
+#define MGMT_SETTING_SSP		BIT(6)
+#define MGMT_SETTING_BREDR		BIT(7)
+#define MGMT_SETTING_HS			BIT(8)
+#define MGMT_SETTING_LE			BIT(9)
+#define MGMT_SETTING_ADVERTISING	BIT(10)
+#define MGMT_SETTING_SECURE_CONN	BIT(11)
+#define MGMT_SETTING_DEBUG_KEYS		BIT(12)
+#define MGMT_SETTING_PRIVACY		BIT(13)
+#define MGMT_SETTING_CONFIGURATION	BIT(14)
+#define MGMT_SETTING_STATIC_ADDRESS	BIT(15)
+#define MGMT_SETTING_PHY_CONFIGURATION	BIT(16)
+#define MGMT_SETTING_WIDEBAND_SPEECH	BIT(17)
+#define MGMT_SETTING_CIS_CENTRAL	BIT(18)
+#define MGMT_SETTING_CIS_PERIPHERAL	BIT(19)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -635,21 +635,21 @@ struct mgmt_rp_get_phy_configuration {
 } __packed;
 #define MGMT_GET_PHY_CONFIGURATION_SIZE	0
 
-#define MGMT_PHY_BR_1M_1SLOT	0x00000001
-#define MGMT_PHY_BR_1M_3SLOT	0x00000002
-#define MGMT_PHY_BR_1M_5SLOT	0x00000004
-#define MGMT_PHY_EDR_2M_1SLOT	0x00000008
-#define MGMT_PHY_EDR_2M_3SLOT	0x00000010
-#define MGMT_PHY_EDR_2M_5SLOT	0x00000020
-#define MGMT_PHY_EDR_3M_1SLOT	0x00000040
-#define MGMT_PHY_EDR_3M_3SLOT	0x00000080
-#define MGMT_PHY_EDR_3M_5SLOT	0x00000100
-#define MGMT_PHY_LE_1M_TX		0x00000200
-#define MGMT_PHY_LE_1M_RX		0x00000400
-#define MGMT_PHY_LE_2M_TX		0x00000800
-#define MGMT_PHY_LE_2M_RX		0x00001000
-#define MGMT_PHY_LE_CODED_TX	0x00002000
-#define MGMT_PHY_LE_CODED_RX	0x00004000
+#define MGMT_PHY_BR_1M_1SLOT		BIT(0)
+#define MGMT_PHY_BR_1M_3SLOT		BIT(1)
+#define MGMT_PHY_BR_1M_5SLOT		BIT(2)
+#define MGMT_PHY_EDR_2M_1SLOT		BIT(3)
+#define MGMT_PHY_EDR_2M_3SLOT		BIT(4)
+#define MGMT_PHY_EDR_2M_5SLOT		BIT(5)
+#define MGMT_PHY_EDR_3M_1SLOT		BIT(6)
+#define MGMT_PHY_EDR_3M_3SLOT		BIT(7)
+#define MGMT_PHY_EDR_3M_5SLOT		BIT(8)
+#define MGMT_PHY_LE_1M_TX		BIT(9)
+#define MGMT_PHY_LE_1M_RX		BIT(10)
+#define MGMT_PHY_LE_2M_TX		BIT(11)
+#define MGMT_PHY_LE_2M_RX		BIT(12)
+#define MGMT_PHY_LE_CODED_TX		BIT(13)
+#define MGMT_PHY_LE_CODED_RX		BIT(14)
 
 #define MGMT_PHY_BREDR_MASK (MGMT_PHY_BR_1M_1SLOT | MGMT_PHY_BR_1M_3SLOT | \
 			     MGMT_PHY_BR_1M_5SLOT | MGMT_PHY_EDR_2M_1SLOT | \
@@ -974,11 +974,11 @@ struct mgmt_ev_auth_failed {
 	__u8	status;
 } __packed;
 
-#define MGMT_DEV_FOUND_CONFIRM_NAME		0x01
-#define MGMT_DEV_FOUND_LEGACY_PAIRING		0x02
-#define MGMT_DEV_FOUND_NOT_CONNECTABLE		0x04
-#define MGMT_DEV_FOUND_INITIATED_CONN		0x08
-#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	0x10
+#define MGMT_DEV_FOUND_CONFIRM_NAME		BIT(0)
+#define MGMT_DEV_FOUND_LEGACY_PAIRING		BIT(1)
+#define MGMT_DEV_FOUND_NOT_CONNECTABLE		BIT(2)
+#define MGMT_DEV_FOUND_INITIATED_CONN		BIT(3)
+#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	BIT(4)
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
-- 
2.37.3

