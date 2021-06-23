Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D1CC48BC2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 04:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9F661289
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 04:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFWEwI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 00:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhFWEwG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 00:52:06 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24DDC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 21:49:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id p9so737380pgb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fijeLYxAajiOMQuAFN30hNSlRkp9xloU3BMCsZB7sQs=;
        b=ZGHwVB8BXii6/bZFD4MPHL/tWRMNRJ4GyOcpweSofQ+NffIcLxYqkIttyp5U/wYa2K
         GC1b0jPVcdWJ8jGBLFhU5ZyVWk6T2zPzdfkKd8TjOjxYUWOxAmsw+/0vBBgThTtwOVZy
         YWwNfEK++U9I4c6pbEnC2AgxNGKPDtsWXXFmnYH3WplL7KrJHCAVZ1nFmBxPSYeL3oEy
         SJx9B/9cOFZaUFmLYcDg4B/Q7xTxAZbSPl2P70kYziKJlSxO1xV97kLOqihCmHDa4Hmf
         iTm4pT2EkQOvkh+cBclbCla5Yq83a8IITHrTJJgLzkieF8CW6VSKdzLeXOVsi1HG0ViH
         bCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fijeLYxAajiOMQuAFN30hNSlRkp9xloU3BMCsZB7sQs=;
        b=f0w4VTh49qLu6EXA7uCV/KZXMTGANI3M3cdnBUCVimroXsjIdhahbts4OmdFD9JF4I
         Uu6aZpvxm/42U9CYCvFkVpX31eMTgIvR853NVPWWnfni8TlVDaS0XPkMENyJ5G684YsK
         oFtUbGrJ/UlZ5TQ2Q/fq+u0MoOyG8U1hjYtV0jXz5yIke/YgqeagVXujVA2THf/SVLTh
         12zrYnvpszAYEEVhm6M6PB4k2f2fwXi/TZBftfPxY2MgNJdmQs2dyRuAnMe61RDi2bTc
         k3/cky+DjR3vdtnVCWE5/89YmgSZPLx7vzedSGU5uSDLyz0Yetk/4FpoQN5OlH0T/KnQ
         VdoA==
X-Gm-Message-State: AOAM530v3QqOwtEGdHsVnwnkOWdqGSC9r5rGD6PQV7dzvFFsHGCZFdge
        94qS+exLqGP5XvVTiNV26hDk8qAuv4c=
X-Google-Smtp-Source: ABdhPJzdFbLFMJWJl/xbFZxktfggDTt/7pklQmQQD5xg8novntAT6f8Rbrp7imFwnplslRUnfgS+lw==
X-Received: by 2002:a63:7d4e:: with SMTP id m14mr2051854pgn.421.1624423789379;
        Tue, 22 Jun 2021 21:49:49 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id c184sm900129pfa.38.2021.06.22.21.49.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:49:49 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 4/5] emulator/bthost: Create ext adv params before setting adv data
Date:   Tue, 22 Jun 2021 21:49:43 -0700
Message-Id: <20210623044944.602205-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623044944.602205-1-hj.tedd.an@gmail.com>
References: <20210623044944.602205-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Based on the SPEC 5.2 Vol 4, Part E, Section 7.8.54, the
LE_Set_Extended_Advertising_Data_Command may be issued after an
advertising set identifed by the Advertising_Handle has been created
using the HCI_LE_Set_Extended_Advertising_Parameters command.
---
 emulator/bthost.c | 26 ++++++++++++++++++++------
 emulator/bthost.h |  1 +
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 16934d35a..62f5a1bae 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2549,6 +2549,7 @@ void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
 	memset(adv_cp, 0, sizeof(*adv_cp));
 	memset(adv_cp->data, 0, 31);
 
+	adv_cp->handle = 1;
 	adv_cp->operation = 0x03;
 	adv_cp->fragment_preference = 0x01;
 
@@ -2572,20 +2573,33 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_ENABLE, &enable, 1);
 }
 
-void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
+void bthost_set_ext_adv_params(struct bthost *bthost)
 {
 	struct bt_hci_cmd_le_set_ext_adv_params cp;
-	struct bt_hci_cmd_le_set_ext_adv_enable cp_enable;
 
 	memset(&cp, 0, sizeof(cp));
+	cp.handle = 0x01;
 	cp.evt_properties = cpu_to_le16(0x0013);
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 							&cp, sizeof(cp));
+}
+
+void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
+{
+	struct bt_hci_cmd_le_set_ext_adv_enable *cp_enable;
+	struct bt_hci_cmd_ext_adv_set *cp_set;
+	uint8_t cp[6];
+
+	memset(cp, 0, 6);
+
+	cp_enable = (struct bt_hci_cmd_le_set_ext_adv_enable *)cp;
+	cp_set = (struct bt_hci_cmd_ext_adv_set *)(cp + sizeof(*cp_enable));
+
+	cp_enable->enable = enable;
+	cp_enable->num_of_sets = 1;
+	cp_set->handle = 1;
 
-	memset(&cp_enable, 0, sizeof(cp_enable));
-	cp_enable.enable = enable;
-	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, &cp_enable,
-					sizeof(cp_enable));
+	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, cp, 6);
 }
 
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 7e5286df3..5a85b7232 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -80,6 +80,7 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
 
 void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
 								uint8_t len);
+void bthost_set_ext_adv_params(struct bthost *bthost);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
 
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode);
-- 
2.26.3

