Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC78C33CA1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46E22077B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="0eJnEtZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgAHLsC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:48:02 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:44229 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgAHLsC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 06:48:02 -0500
Received: by mail-lj1-f178.google.com with SMTP id u71so2955056lje.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 03:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRecKNJ4qdrMcD0dhtNiFMLXR1mz2rfeOaSdEJlv/ns=;
        b=0eJnEtZD3ces6e6SfW8qtYWngTAxkB1igG74eTVOfwib02m6aO7Uqk4H6qANflzTFg
         dfVGhJ3V3L0nRjKzp4WSuH/jDppfuhOxqqs1vpDItO+aX15h/cCdwxVFcxlS8UODVh2W
         LYlY97wqvcRIkTO2q76S2KDInIPUgzQ+zaLmJ8d5PQ0qt4toXEpoG41CoBNscsUj7u8A
         aH3DHnIkJz0yr6UcKxSzlpKOfubYtRYuOcpJeDsmBC008ZqaMc5Erh4SBOfmIwlWaGHL
         C1cbQ4eYWCwDomJTK6anBE1DkRpIyjUXj9G3KPw1VBAWn5AUNEh1gapuo5F0wYnsg95p
         4bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRecKNJ4qdrMcD0dhtNiFMLXR1mz2rfeOaSdEJlv/ns=;
        b=H+7w9KSNVuoM27lwEYBeZ+b3pn+mqP+6sMFcSa/2BSphAfZXWDt3AYgHr6wWqaaJM5
         D1i9mpdSFkCS4JhGs/13NGb3fwRDWjpxxjn2tYRUT3qw/opLQZvOeSo7NgxmpWPCyVVH
         JDzSuRKhS5a0rSFwF9cjfLftD3QoHjupJwbLBqn8+kJTJU8pYCVUODTm5cBe9wof+ZOF
         Ay7xyPZB6/80BwWOuyAhbkaAq75eq+M3D1wFAQCblSJS6rLmAy8Kqa/t9MN1bnucGH5m
         HA3GQrSv2R2JegQbyNb6fwMdqqO07mC+yxul1gpEVwi6ijx/rpIQijBp9LB96iqlrUEF
         xm+Q==
X-Gm-Message-State: APjAAAXdKY9Me5j6Y9l1fE07Mrk/Qy4jOaZeP8WRcDir4gjmLtEVtu8X
        5rzfZo01KVYRtULG8aXasGWbmUurblY=
X-Google-Smtp-Source: APXvYqxuoOGDlTkNEz5jwH+7opXlb08dkcW84ubwPokwUhaFf0aenAMc/xYCB5g5178vVfJQVJXAeQ==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr2565163ljj.55.1578484080285;
        Wed, 08 Jan 2020 03:48:00 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e17sm1130645ljg.101.2020.01.08.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:47:59 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH v2 4/8] monitor: Decode LE Periodic Advertising Sync Transfer command
Date:   Wed,  8 Jan 2020 12:47:48 +0100
Message-Id: <20200108114752.133076-4-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
References: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

< HCI Command: LE Periodic Advertising Sync Transfer (0x08|0x005a) plen 6
        Connection handle: 1
        Service data: 0x0001
        Sync handle: 1
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Sync Transfer (0x08|0x005a) ncmd 1
        Status: Unknown HCI Command (0x01)
---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index bb373b528..efaf80f55 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2467,6 +2467,13 @@ struct bt_hci_cmd_set_periodic_adv_rec_enable {
 	uint8_t  enable;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_PERIODIC_SYNC_TRANS	0x205a
+struct bt_hci_cmd_periodic_sync_trans {
+	uint16_t handle;
+	uint16_t service_data;
+	uint16_t sync_handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index e5681b5ff..23eb48374 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4019,6 +4019,14 @@ static void status_rsp(const void *data, uint8_t size)
 	print_status(status);
 }
 
+static void status_handle_rsp(const void *data, uint8_t size)
+{
+	uint8_t status = *((const uint8_t *) data);
+
+	print_status(status);
+	print_field("Connection handle: %d", get_u8(data + 1));
+}
+
 static void status_bdaddr_rsp(const void *data, uint8_t size)
 {
 	uint8_t status = *((const uint8_t *) data);
@@ -7592,6 +7600,15 @@ static void le_periodic_adv_rec_enable(const void *data, uint8_t size)
 	print_enable("Reporting", cmd->enable);
 }
 
+static void le_periodic_adv_sync_trans(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_periodic_sync_trans *cmd = data;
+
+	print_field("Connection handle: %d", cmd->handle);
+	print_field("Service data: 0x%4.4x", cmd->service_data);
+	print_field("Sync handle: %d", cmd->sync_handle);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8388,6 +8405,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2059, 325, "LE Periodic Advertising Receive Enable",
 				le_periodic_adv_rec_enable, 3, true,
 				status_rsp, 1, true },
+	{ 0x205a, 326, "LE Periodic Advertising Sync Transfer",
+				le_periodic_adv_sync_trans, 6, true,
+				status_handle_rsp, 3, true },
 	{ }
 };
 
-- 
2.24.1

