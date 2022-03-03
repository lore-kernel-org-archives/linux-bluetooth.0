Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8327BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 22:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiCCWR6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiCCWR5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Mar 2022 17:17:57 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A943EB0EA9
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Mar 2022 14:17:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id p8so5939591pfh.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Mar 2022 14:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t8/a5oNDnoQ1v3SOkMkoJxQX9XnOyFK1eDpMszGVWQU=;
        b=jllXWEElRztodk5INXxeUM2sqeuJf/ugP/Z1xloTFDdZ7FSMrowKN1Sb90bHQLPsK2
         0n/h+HyAEjvFCb5pcfjcmnIca6ZCAllatiwRUYzPoYlDupJaRGjojuAbSpYocwDz+RQt
         fmo7tbicRbJz19vUgm8DQ/jB40k4k9bJE/Dmviv4sgoIpVam4z08FSp6XVHwyldH0vvL
         liF/iQkyTPFZmT3x/szzlnTAAxVAY/iOQ1J8Tg3LY9jcIudZ2TLQAgS1Eo+pNXtXuKWD
         MI8aDvFeIxwqtvVMu8B1nEEagh/WnAvotyE54GtYKBBe9b5+aThehq9vj6rhikvPGCIq
         Cfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8/a5oNDnoQ1v3SOkMkoJxQX9XnOyFK1eDpMszGVWQU=;
        b=HOFw+bNgV1PUz+S4dPHiRi7UGNLlYoa0oewHaiQTGtJldwLjUVK6Bkf0A7Db7FEE8T
         DP2fr732JngeB+wvd4eksVKBcG3/AW0bFKOaLZiYtIChcjtN/oVcUH67fP43dCUTSdb3
         5ik4da5BpJJil5QnxLxYbDpBEZmMnLnk5AxDnuJ7whWIMT4MDUQ4xS+4jiAivCxM46pr
         0nUogoGCIDnXyBD/9TPJi9FFNdL96d38rGXfzUIA8EVyCe1C1Tq0OOAxlGsUB3OOdeYq
         6RFBH9ubg/JwSbv0tFXMcHY7Vs7ZnxhgquSYsLQGgotDWIHfiiHdUw3VcnGS5Unps1Te
         IGqw==
X-Gm-Message-State: AOAM533E8GWlgkE3UFYnNE1W+BGN+lsbSOQVhu/FOCNz0hysOAmiHJ8G
        S99Q/vc1SQuJSCMOTKsW/GaGwQRinnY=
X-Google-Smtp-Source: ABdhPJwbE0+W+b5eM//bMAz7c0OJHL7hflGEXA5uepFE/EIqH8ndld/yhU6w/9JG11qBVqDIF+XN1A==
X-Received: by 2002:a62:ee08:0:b0:4f6:b522:ca with SMTP id e8-20020a62ee08000000b004f6b52200camr131292pfi.48.1646345830891;
        Thu, 03 Mar 2022 14:17:10 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f6519e61b7sm3856932pfh.21.2022.03.03.14.17.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:17:10 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO quirk
Date:   Thu,  3 Mar 2022 14:17:08 -0800
Message-Id: <20220303221709.387865-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303221709.387865-1-luiz.dentz@gmail.com>
References: <20220303221709.387865-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO quirk which can be used
to mark HCI_Enhanced_Setup_Synchronous_Connection as broken even if its
support command bit are set since some controller report it as supported
but the command don't work properly with some configurations
(e.g. BT_VOICE_TRANSPARENT/mSBC).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      | 9 +++++++++
 include/net/bluetooth/hci_core.h | 8 ++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 35c073d44ec5..a4da339aab07 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -255,6 +255,15 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
+
+	/*
+	 * When this quirk is set, disables the use of
+	 * HCI_OP_ENHANCED_SETUP_SYNC_CONN command to setup SCO connections.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d5377740e99c..7a9795783850 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1492,8 +1492,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
 				   (hdev->commands[39] & 0x04))
 
-/* Use enhanced synchronous connection if command is supported */
-#define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
+/* Use enhanced synchronous connection if command is supported and its quirk
+ * has not been set.
+ */
+#define enhanced_sco_capable(dev) (((dev)->commands[29] & 0x08) && \
+				   !test_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SCO, \
+					     &(dev)->quirks))
 
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
-- 
2.35.1

