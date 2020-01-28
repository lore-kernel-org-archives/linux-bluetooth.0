Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B97C33CB3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85B82465B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+f0L26l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgA1UNo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:13:44 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52390 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA1UNn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 15:13:43 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so1554512pjh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 12:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MsTuvN1FD4rrDl4eGlKLR6oGF2OUswmNU0jA2C+EVlY=;
        b=q+f0L26lJk0Khcl8QMYKXK7s7zSIDPH9TuoYBKffMZ2ILnoHojHKWCIQDRoBLrxSFj
         BscF4DEqw0ElwNn4X58N3sYryCZWXpT/CLS5HRivQO5yVpv+cKz3uAi2Xlph7gP1v8uP
         OH6E4nh44V6nPWlEZKzaIOiM+altLiTiZhk8av9if6lqLge2Ry0Td9WXTvU0L1axa4wc
         ZHI8W3H4O4W6wydAoRSW0X2FDJNY62a0wA533HBuUd2cN4fdR43ZpZYjp5db2e0/I6jV
         WXq9Ok5iCj8vBIp3N0gf0BF63vESTDEmkl1ZsIDL68i8S4+jZsu1IUGsiJq0wotcDkr5
         szcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsTuvN1FD4rrDl4eGlKLR6oGF2OUswmNU0jA2C+EVlY=;
        b=aWOPuINjMyHYfjD8wrE/k3GzyOvvrGbZl5pNGjxBG4g3GtZyJLUm2kf9Ly55D5Sv55
         45TmOvq9GySKD37g0xprET0Vnh1kJ1Kxn8EWc3Ue80THb0bUpKceWmqZZvinvN95MUh8
         J/yruIU73HMrWWdOprxEUF9W43dxiZcvU+q+6TqE/pfJv3Aez/xQUWXEkcvXlQDohLaZ
         q9avolqJfo2q3qYe8+ckM1cH+P6gu6XgPrwNOwGe9IKlYdDm6CzDveXaRiR2WAhVEyBb
         AnVmHzF0XnF6cfYCNftlmjgYtlgmJqC6xx5YGI8RlgWpvYnOtAh+csiuXRSOe6GqbFuS
         07Hg==
X-Gm-Message-State: APjAAAVc7QcRGbWGBhAsbtaLU5E1vL5aW0d1IFMS6fJbOQhemAW1foGJ
        BnhAbn21HzG03/awsl9SshSNHJYFNeM=
X-Google-Smtp-Source: APXvYqwEZ1oVECka5P/wEQ/BI28sVxJf4jGAxNO7adDrxpl5gFC8C5rGKz2enhMUK1dwGdKc6KiXrQ==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr22581768plo.98.1580242422708;
        Tue, 28 Jan 2020 12:13:42 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.38])
        by smtp.gmail.com with ESMTPSA id x8sm3367504pfr.104.2020.01.28.12.13.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 12:13:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] tools/btproxy: Add support for ISO packets
Date:   Tue, 28 Jan 2020 12:13:35 -0800
Message-Id: <20200128201335.6165-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128201335.6165-1-luiz.dentz@gmail.com>
References: <20200128201335.6165-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables proxing ISO packets.
---
 tools/btproxy.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index fb67a5735..a98bbb73f 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -73,14 +73,14 @@ static void hexdump_print(const char *str, void *user_data)
 }
 
 struct proxy {
-	/* Receive commands, ACL and SCO data */
+	/* Receive commands, ACL, SCO and ISO data */
 	int host_fd;
 	uint8_t host_buf[4096];
 	uint16_t host_len;
 	bool host_shutdown;
 	bool host_skip_first_zero;
 
-	/* Receive events, ACL and SCO data */
+	/* Receive events, ACL, SCO and ISO data */
 	int dev_fd;
 	uint8_t dev_buf[4096];
 	uint16_t dev_len;
@@ -296,6 +296,7 @@ static void host_read_callback(int fd, uint32_t events, void *user_data)
 	struct bt_hci_cmd_hdr *cmd_hdr;
 	struct bt_hci_acl_hdr *acl_hdr;
 	struct bt_hci_sco_hdr *sco_hdr;
+	struct bt_hci_iso_hdr *iso_hdr;
 	ssize_t len;
 	uint16_t pktlen;
 
@@ -364,6 +365,13 @@ process_packet:
 		sco_hdr = (void *) (proxy->host_buf + 1);
 		pktlen = 1 + sizeof(*sco_hdr) + sco_hdr->dlen;
 		break;
+	case BT_H4_ISO_PKT:
+		if (proxy->host_len < 1 + sizeof(*iso_hdr))
+			return;
+
+		iso_hdr = (void *) (proxy->host_buf + 1);
+		pktlen = 1 + sizeof(*iso_hdr) + cpu_to_le16(iso_hdr->dlen);
+		break;
 	case 0xff:
 		/* Notification packet from /dev/vhci - ignore */
 		proxy->host_len = 0;
@@ -418,6 +426,7 @@ static void dev_read_callback(int fd, uint32_t events, void *user_data)
 	struct bt_hci_evt_hdr *evt_hdr;
 	struct bt_hci_acl_hdr *acl_hdr;
 	struct bt_hci_sco_hdr *sco_hdr;
+	struct bt_hci_iso_hdr *iso_hdr;
 	ssize_t len;
 	uint16_t pktlen;
 
@@ -476,6 +485,13 @@ process_packet:
 		sco_hdr = (void *) (proxy->dev_buf + 1);
 		pktlen = 1 + sizeof(*sco_hdr) + sco_hdr->dlen;
 		break;
+	case BT_H4_ISO_PKT:
+		if (proxy->dev_len < 1 + sizeof(*iso_hdr))
+			return;
+
+		iso_hdr = (void *) (proxy->dev_buf + 1);
+		pktlen = 1 + sizeof(*iso_hdr) + cpu_to_le16(iso_hdr->dlen);
+		break;
 	default:
 		fprintf(stderr, "Received unknown device packet type 0x%02x\n",
 							proxy->dev_buf[0]);
-- 
2.21.0

