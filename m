Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C15C33C99
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA326206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bai50ikX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgAHAdx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45872 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgAHAdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so365118pls.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2huxQ0NpI2OvRyaQkNaSZk+YNddQsneUPoeWl1cling=;
        b=bai50ikXyT5jhHt6nUgOarlEL56gR92zz4aG+1wn+y5loyqDu1CZtbJWjYMKInDT69
         kOLUeY8wQIZenEGUCys2tuE66b9n8P2DLpBHTA+ByYDiqB2K8BnjBru2x99eZIbCC2oS
         vvXHVus8IsqPdoPwRXGSpEOLgS9TwRXWm9bKpT7enY5/btkl6MMegIX8BLmqplwaksja
         DbDw7UK0Gmv7NgpLsTwtMirXKUxK6wZQ1gPHwbidUlNlh+k4laie5YmaO1LRLjQJt0/t
         GairOyqJdT0nZkZmuy34hZ7agH9NQyCGkq39OaRDJbR8uvqtd9aDjieduCUsgmaewJ9K
         RPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2huxQ0NpI2OvRyaQkNaSZk+YNddQsneUPoeWl1cling=;
        b=o2OvJD3nZMyYApHg14bnscSMpdFFVQc2SQfUl+kSJITe3M9UxMfMf7OSLuKemIYMwI
         k82bAWaIx2ILWCf5Q8dCrvuoclZAEa/vAWofIKONxp+cYs1QKyZZfsdGcv18nXagsRxA
         Nxykn3raq59Uvh8lP/+qpXQs0/U4KtKahGz9tSeSEnWnB01yhh8nsnXMjj7z6Zb9/Dlf
         D4y6wuUCWTP9QUgjap6IOfn7J8FGdscxcrRCtgwFaxEN1DNmTGvy8oDjm8sdmvLIrWW9
         6Bw7odBFRSlQcRSci/Up8+VS5AvSy4Lxw7uGb2MQ3IX26Papsw7HPPvflJDT1pzU8qRz
         MvEw==
X-Gm-Message-State: APjAAAVq++EcTRyLe9UP9aE6OT4k0OREXkbnxFA1dAP1/vXpiNFOUAoU
        LEBTlRaCobhnJzgLiB4NrcRxWMIGhjY=
X-Google-Smtp-Source: APXvYqxaELRxrtTADCacxX8dxMIinO1elU4z7jH+Rt4P2V4ez0IDoDo9MRtrR7WyI0AHacH6UgUT6Q==
X-Received: by 2002:a17:90a:6:: with SMTP id 6mr1404702pja.71.1578443631812;
        Tue, 07 Jan 2020 16:33:51 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/22] monitor: Fix decoding of CIS estabilished event
Date:   Tue,  7 Jan 2020 16:33:28 -0800
Message-Id: <20200108003342.15458-9-luiz.dentz@gmail.com>
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

The event has been changed in r06.
---
 monitor/bt.h     | 1 +
 monitor/packet.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index b08f145ab..c90338096 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3445,6 +3445,7 @@ struct bt_hci_evt_le_cis_established {
 	uint8_t  s_ft;
 	uint16_t m_mtu;
 	uint16_t s_mtu;
+	uint16_t interval;
 } __attribute__ ((packed));
 
 #define BT_HCI_EVT_LE_CIS_REQ			BT_HCI_SUBEVT_5_2 + 1
diff --git a/monitor/packet.c b/monitor/packet.c
index 0ef8a5b86..377944284 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10278,20 +10278,21 @@ static void le_cis_established_evt(const void *data, uint8_t size)
 	const struct bt_hci_evt_le_cis_established *evt = data;
 
 	print_status(evt->status);
-	print_field("Connection Handle: %d", le16_to_cpu(evt->status));
+	print_field("Connection Handle: %d", le16_to_cpu(evt->conn_handle));
 	print_usec_interval("CIG Synchronization Delay", evt->cig_sync_delay);
 	print_usec_interval("CIS Synchronization Delay", evt->cis_sync_delay);
 	print_usec_interval("Master to Slave Latency", evt->m_latency);
 	print_usec_interval("Slave to Master Latency", evt->s_latency);
 	print_le_phy("Master to Slave PHY", evt->m_phy);
-	print_le_phy("Slave to Master PHY", evt->m_phy);
+	print_le_phy("Slave to Master PHY", evt->s_phy);
 	print_field("Number of Subevents: %u", evt->nse);
 	print_field("Master to Slave Burst Number: %u", evt->m_bn);
 	print_field("Slave to Master Burst Number: %u", evt->s_bn);
 	print_field("Master to Slave Flush Timeout: %u", evt->m_ft);
 	print_field("Slave to Master Flush Timeout: %u", evt->s_ft);
-	print_field("Master to Slave MTU: %u", evt->m_ft);
-	print_field("Slave to Master MTU: %u", evt->s_ft);
+	print_field("Master to Slave MTU: %u", le16_to_cpu(evt->m_mtu));
+	print_field("Slave to Master MTU: %u", le16_to_cpu(evt->s_mtu));
+	print_field("ISO Interval: %u", le16_to_cpu(evt->interval));
 }
 
 static void le_req_cis_evt(const void *data, uint8_t size)
-- 
2.21.0

