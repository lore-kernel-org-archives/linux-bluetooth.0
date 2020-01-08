Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5318C33C9B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79417206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN8GygVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgAHAdy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:54 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:46281 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgAHAdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:53 -0500
Received: by mail-pl1-f182.google.com with SMTP id y8so364796pll.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qylhapiw6j9mT7HBQGG+i/xdsf/ElNGXrCeMwI/nKbs=;
        b=KN8GygVcQLhuqcyPHxXUkNT/GWzIgYX5z5J9N0QyKaJ4MebB2WsWFhwl5eWScF4ey5
         l52IK3T8QciLO6k8btyGl0bJrI2DdzHkAZQ2SYmQEOjdXnN9KqHV1LsSNa3lFkYFKkby
         +umC05CSLwvoa365mYLRIF9VS5JmJK8yot8QKSNikSknjPqjJTWfAxWgfraGaPI4mNep
         0FQGMKG3wOakXP30CIxMrxhY0Uki6e04W3EOlCA6Jsy4ZMah5IKnF0oTcgouTVf+o+iV
         6s2cbPE+ooaSfV8IPNAhre4UjnAbZmHtbXxTzdrZCGqIJL3GA+HUUZoZlgIYWuSmncXC
         v/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qylhapiw6j9mT7HBQGG+i/xdsf/ElNGXrCeMwI/nKbs=;
        b=U8p3ms5OVrh/ulOC3AFUtVBzCfSyJJClsEogmludY0KvMQWNUivZRpNTNSLewfDXVT
         GnX7EJezmfm5f2llkwW/FTHKztR7dh5CY5QRadQMyO/KxwjEKxN4hf94lQfkHVV2DAie
         JZO7luIZumFAHNZPfgRYvV5u4AkgkvPMsYbKS798T36fMGssqRxALcloV53OUWperfDq
         Wwl5c7yg6ntKeDZDgofucL9G6Qx+i7lRfqeJRCnwMourrIZK0Tn6x5Uvn8n3XEV8l5p7
         FHMqtn51VuvYgJaZvrd2h/lVuB/ASr6C+Q088CkCou2OkQ+8Q7ZDbP74v/MiQEcT95s5
         CbYA==
X-Gm-Message-State: APjAAAU771EWR7jhVXKZI7TBYo7DXrqeC31fEn0nJxl6MOF5Ov66t9G5
        fzCLTGyad0wuznjU+/tfv6gIDUtdnkY=
X-Google-Smtp-Source: APXvYqwePlTQBLtcK9EhkRfO2UfwfAMr2QRI0vvnvicj3PAQWTByzgeHt28pdYyFHwae4/AAEriVpA==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr1370342pjt.131.1578443632573;
        Tue, 07 Jan 2020 16:33:52 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:52 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/22] emulator/btdev: Add parameter to CIS Estabilished
Date:   Tue,  7 Jan 2020 16:33:29 -0800
Message-Id: <20200108003342.15458-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use Set CIG params to fill CIS Estabilished.
---
 emulator/btdev.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 02f408dd5..0de273e53 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -144,6 +144,10 @@ struct btdev {
 	uint8_t  le_filter_dup;
 	uint8_t  le_adv_enable;
 	uint8_t  le_ltk[16];
+	struct {
+		struct bt_hci_cmd_le_set_cig_params params;
+		struct bt_hci_cis_params cis;
+	} __attribute__ ((packed)) le_cig;
 
 	uint8_t le_local_sk256[32];
 
@@ -1412,8 +1416,25 @@ static void le_cis_estabilished(struct btdev *dev, uint8_t status)
 
 	if (!evt.status) {
 		evt.conn_handle = cpu_to_le16(ISO_HANDLE);
-		evt.m_phy = 0x01;
-		evt.m_phy = 0x01;
+		/* TODO: Figure out if these values makes sense */
+		memcpy(evt.cig_sync_delay, dev->le_cig.params.m_interval,
+				sizeof(dev->le_cig.params.m_interval));
+		memcpy(evt.cis_sync_delay, dev->le_cig.params.s_interval,
+				sizeof(dev->le_cig.params.s_interval));
+		memcpy(evt.m_latency, &dev->le_cig.params.m_latency,
+				sizeof(dev->le_cig.params.m_latency));
+		memcpy(evt.s_latency, &dev->le_cig.params.s_latency,
+				sizeof(dev->le_cig.params.s_latency));
+		evt.m_phy = dev->le_cig.cis.m_phy;
+		evt.s_phy = dev->le_cig.cis.s_phy;
+		evt.nse = 0x01;
+		evt.m_bn = 0x01;
+		evt.s_bn = 0x01;
+		evt.m_ft = 0x01;
+		evt.s_ft = 0x01;
+		evt.m_mtu = dev->iso_mtu;
+		evt.s_mtu = dev->iso_mtu;
+		evt.interval = dev->le_cig.params.m_latency;
 	}
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
@@ -3804,6 +3825,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_LE_SET_CIG_PARAMS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
+		memcpy(&btdev->le_cig, data, len);
 		lscp.params.status = BT_HCI_ERR_SUCCESS;
 		lscp.params.cig_id = 0x00;
 		lscp.params.num_handles = 1;
-- 
2.21.0

