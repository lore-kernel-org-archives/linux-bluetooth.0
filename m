Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B240BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiCEBX1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiCEBXZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:25 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004928E36
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:34 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a5so9007982pfv.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gkECUbgP6SwJ+vdtBxsDCIGBwm8Bgzi3GVBj8I4iC20=;
        b=Ev9b6z8Hu3KGcnmv0g6FIGv2OvbcQsRdHwJzyeqzuJADKP76JUUucSfXgKWx0wYsoR
         F/fNfzrGWjg7mVDdYKNhM5d/cYJFcjJcEp129CiY3Q0rQevfU2vVWAaiwvMOkxrtD14p
         tTLHCckMDviQ0hk6lhc624qw+VMJNU6cKsJaApI7IxusjuA/zteJCc6zGzBIAjNS5VrC
         F7VuAJuklbLOhAgvMPyYwZeEaogMNefroZi1Yhlg+h6/b5aqVkQNQ08zoGFiB4bZWfOP
         X1OfXogBY/VM39ml/FYIjUXdTLp3y8iaKnBq9VJeHTL7xlN2pe5NbKkT5y708wBkx8ZF
         dc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkECUbgP6SwJ+vdtBxsDCIGBwm8Bgzi3GVBj8I4iC20=;
        b=QiqhlhsLcx3eeXM0IBFAE/vCPZkmFnxMekO3yKm2Oj3jHQ0RDOE8Q3765UUWFKH4W7
         AW7EC3KSkN0TwRaMTEthKLoD0ak8IEHC+f+R/ij9t2nu8sRMxVmQXfsJoUpJCPt2thvm
         PNxpRGeK1ZSUcUzlaFblnX8w4Fi4Lg0dIIKNnOPfb7wYRhwm4lvGaJLylBTR5Dc2mpYv
         Njl4tV7bP08AZSx4msMzw/LBQBLPIFi9lBi0DSGdZMsjO8GGxqLgDv3sdgH3dti9vwbg
         5i3fkkFyMb7st0JQGfmBXPUsBu9EOkPtUhYV0KdDzIc6BO2Fuq0XxOYMrfogEUKoC9Z0
         dCrg==
X-Gm-Message-State: AOAM530IyhfOc4CDqtDux1wiFEpvGhacfSiYtqArpN32N0kDQdNicJs3
        VXhxAbH7FSiXh2uc7bycUJ4fiBd3fCM=
X-Google-Smtp-Source: ABdhPJwnvIsHSaYHM/XmvfblFF6bm1xSnq5njryOujUnDFOdZNdrd1CMMCXgsBB9iKFc7Dh7RePmzA==
X-Received: by 2002:aa7:8d47:0:b0:4f6:a7f9:1ead with SMTP id s7-20020aa78d47000000b004f6a7f91eadmr1338050pfe.42.1646443353320;
        Fri, 04 Mar 2022 17:22:33 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 03/12] btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL
Date:   Fri,  4 Mar 2022 17:22:20 -0800
Message-Id: <20220305012229.853784-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds implementation of
BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL generating
BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED if necessary.
---
 emulator/btdev.c | 30 +++++++++++++++++++++++++++---
 monitor/bt.h     |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 34469d986..09101a5df 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -48,6 +48,7 @@
 #define ISO_HANDLE 257
 #define SCO_HANDLE 257
 #define SYC_HANDLE 1
+#define INV_HANDLE 0xffff
 
 struct hook {
 	btdev_hook_func handler;
@@ -5301,7 +5302,7 @@ static int cmd_per_adv_create_sync(struct btdev *dev, const void *data,
 	if (dev->le_periodic_sync_handle)
 		status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 	else
-		dev->le_periodic_sync_handle = SYC_HANDLE;
+		dev->le_periodic_sync_handle = INV_HANDLE;
 
 	cmd_status(dev, status, BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC);
 
@@ -5351,11 +5352,14 @@ static void le_per_adv_sync_estabilished(struct btdev *dev,
 	ev.status = status;
 
 	if (status) {
+		dev->le_periodic_sync_handle = 0x0000;
 		le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev,
 							sizeof(ev));
 		return;
 	}
 
+	dev->le_periodic_sync_handle = SYC_HANDLE;
+
 	ev.handle = cpu_to_le16(dev->le_periodic_sync_handle);
 	ev.addr_type = cmd->addr_type;
 	memcpy(ev.addr, cmd->addr, sizeof(ev.addr));
@@ -5394,8 +5398,28 @@ static int cmd_per_adv_create_sync_complete(struct btdev *dev, const void *data,
 static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	/* If the Host issues this command while no
+	 * HCI_LE_Periodic_Advertising_Create_Sync command is pending, the
+	 * Controller shall return the error code Command Disallowed (0x0C).
+	 */
+	if (dev->le_periodic_sync_handle != INV_HANDLE)
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+
+	cmd_complete(dev, BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL,
+					&status, sizeof(status));
+
+	/* After the HCI_Command_Complete is sent and if the cancellation was
+	 * successful, the Controller sends an
+	 * HCI_LE_Periodic_Advertising_Sync_Established event to the Host with
+	 * the error code Operation Cancelled by Host (0x44).
+	 */
+	if (!status)
+		le_per_adv_sync_estabilished(dev, NULL, NULL,
+							BT_HCI_ERR_CANCELLED);
+
+	return 0;
 }
 
 static int cmd_per_adv_term_sync(struct btdev *dev, const void *data,
diff --git a/monitor/bt.h b/monitor/bt.h
index 51b1833dc..b6b6c49e1 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3660,6 +3660,7 @@ struct bt_hci_evt_le_req_peer_sca_complete {
 #define BT_HCI_ERR_ADV_TIMEOUT                 0x3c
 #define BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH	0x3e
 #define BT_HCI_ERR_UNKNOWN_ADVERTISING_ID	0x42
+#define BT_HCI_ERR_CANCELLED			0x44
 
 struct bt_l2cap_hdr {
 	uint16_t len;
-- 
2.35.1

