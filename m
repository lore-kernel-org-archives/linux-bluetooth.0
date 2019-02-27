Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0CCC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F9D20863
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBSoxLiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfB0LqZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:46:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33149 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbfB0LqZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 06:46:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id c55so13652592edb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=8qoJWWHratzrWbKdgD2FDdUcGxIomTzSk+SMGwb7qL4=;
        b=rBSoxLiNc9R7KyRQER37j6h0ibJ599EM6eXH/bTF6shAdy/DEI+HR2YzpAlmpjH9Df
         jfHYhc5fQW/+TKrBQPCWbf+mouBthZ4C50o7zemrHZmZUtOOklmZuy3MgzI91fmcfEeq
         5X8KkD2IKYFpydVUafJmf2jf7yD6K9lc6I+jdZc/fIXirz9s4KHKbjqfDTUtYfuLotrF
         IXnyquz2lVm3wbYoNrrMF41D6K+iShVvfRNS2SUcr4Lh6btKkfWWgbv5Zkv9KTZtNO8q
         VGSwqgP2clQTK20gHe+IqvVLH3sn1uDb+VfaFSsLIXCuTk9oekAzWA3er25OGGIsnXB3
         RHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=8qoJWWHratzrWbKdgD2FDdUcGxIomTzSk+SMGwb7qL4=;
        b=sq6PbcrLqRrgI4U872CGiwxHbjkuj1EbjJfuRJUlHJ0AXoNs1+Mz2ZW+QtXxqwIYU+
         y/HVfRD1pBZ+HgychyzTDLwL9w2GP+N0Di0SLuBuYJir3g1BHL5QnrJ95QI1WwE1Ax+P
         c1l87QblEFij8EMjOG3w/0BCR/2eAv6T7RC0DdJBCUm/bnS2bIYTAOEu/PTQnSpBNLHq
         CiuMosHKolD4tF0S4jVJZMYdbESMd/mGjMzsovqXHIKiQb9hwKOLEnRP/vlLdqc7e64D
         h0/cyLxLsc5HJNJBP292yUfM9DP1TXm7e83+uuL3udZN2yr5EIpflRzC0MEIRDFPbaPA
         8IwA==
X-Gm-Message-State: AHQUAuY8+tQXXnKKfKm9rY1kmnpXI1lJbsjXRr1uAtUJy0EoTscPuoo4
        2r2thnK7kb0h1IDaAx3sM+A2MCewpVk=
X-Google-Smtp-Source: AHgI3IZxOSh6pNPwS6dwpM6rGC3BTggUgSn6v+KU427nKvBMBeYCAFwbJZbGtPXfb/uwDl5YwjapGg==
X-Received: by 2002:aa7:d987:: with SMTP id u7mr1968053eds.194.1551267983471;
        Wed, 27 Feb 2019 03:46:23 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id l24sm2652333eja.57.2019.02.27.03.46.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 03:46:22 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] monitor: Add decoding support for LL_LENGTH_*
Date:   Wed, 27 Feb 2019 13:46:14 +0200
Message-Id: <20190227114620.21630-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints makes the fields to be printed instead of just decoding
the PDU name.
---
 monitor/bt.h |  6 ++++++
 monitor/ll.c | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 1fbb40efc..59d5c20af 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -119,6 +119,12 @@ struct bt_ll_reject_ind_ext {
 #define BT_LL_PING_RSP		0x13
 
 #define BT_LL_LENGTH_REQ	0x14
+struct bt_ll_length {
+	uint16_t rx_len;
+	uint16_t rx_time;
+	uint16_t tx_len;
+	uint16_t tx_time;
+} __attribute__ ((packed));
 
 #define BT_LL_LENGTH_RSP	0x15
 
diff --git a/monitor/ll.c b/monitor/ll.c
index 3ddbf7a07..c70c1166f 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -476,6 +476,16 @@ static void reject_ind_ext(const void *data, uint8_t size)
 	packet_print_error("Error code", pdu->error);
 }
 
+static void length_req_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_length *pdu = data;
+
+	print_field("MaxRxOctets: %u", pdu->rx_len);
+	print_field("MaxRxTime: %u", pdu->rx_time);
+	print_field("MaxTxOctets: %u", pdu->tx_len);
+	print_field("MaxtxTime: %u", pdu->tx_time);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -505,8 +515,8 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x11, "LL_REJECT_IND_EXT",        reject_ind_ext,     2, true },
 	{ 0x12, "LL_PING_REQ",              null_pdu,           0, true },
 	{ 0x13, "LL_PING_RSP",              null_pdu,           0, true },
-	{ 0x14, "LL_LENGTH_REQ",            NULL,               8, true },
-	{ 0x15, "LL_LENGTH_RSP",            NULL,               8, true },
+	{ 0x14, "LL_LENGTH_REQ",            length_req_rsp,     8, true },
+	{ 0x15, "LL_LENGTH_RSP",            length_req_rsp,     8, true },
 	{ 0x16, "LL_PHY_REQ",               NULL,               2, true },
 	{ 0x17, "LL_PHY_RSP",               NULL,               2, true },
 	{ 0x18, "LL_PHY_UPDATE_IND",        NULL,               4, true },
-- 
2.17.2

