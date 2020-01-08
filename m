Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9840DC33CA1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E88F206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3c7Ff2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgAHAdw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42262 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgAHAdv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so664699pgb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MsTuvN1FD4rrDl4eGlKLR6oGF2OUswmNU0jA2C+EVlY=;
        b=N3c7Ff2/1rkGyZxLJXWpHc0IkMShrzSzHGRdTtPnQa7rzYBPfhn7hOjJrI2SktldJQ
         br2G3stpIEBzuGRkgeUtuM8/c0iT4CBYsY/eMxKxkAUvZ8Rq6tdJ9H43F0cez0WjwO4p
         Q/dkXB7ZF3nGMriJamXJtqN6GGUFnNeP/MQGV4DVE1PKsqKTx42lxQUQS7MoomANVGx+
         GK/XPgkoqTs99GUyoENIuwclsB+1vfkYDEKLq78MbrKJC4VFJRCC4cqOXm+xQXSlmHjA
         se82avEOVdLWtNoCUtm7nMlIkXA3m18zvRr9igGiKAckPGn+pw0L4e1BLptb+VlvtnhY
         /gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsTuvN1FD4rrDl4eGlKLR6oGF2OUswmNU0jA2C+EVlY=;
        b=YiEP3l2buhPZkws/S7uwHPiUpq7N+hi1eCgx6p5D/NioT40U1yKgSV8lxP+JKTIy1H
         0z7nLwcbYMG2vZHZk+2YZz3kHxYoqa+Zj1C7GtA7KoVnbtwHHtqAXkAfTNYHTGb7dT+f
         T2MSpU9JhBfnNcPpYGwJ6no/mWjhTRe8YTI4ja/hPAKLOF8g/wymnzcfL6jx0DhgmoKQ
         xOMPkVyczWvC0zMw++8vGGcDgK8cb8DUt3Tcdbw+Fkk/yw/waw8zhPdRSlSHo7eDSmMh
         vOpELvrGVRp9pldrJc2Rk85jwfRWmHWWwr2rFUQ715Mwx+JgHlhubgHm1cGkEPX4ANQC
         +ryA==
X-Gm-Message-State: APjAAAWgy3boSSVy2NU90jQmITvO+KqYI6/Bwl4gyczqQS2g0proONr5
        3eZy8q1VUbQwHuRtE+G1kvu96CAL5Nc=
X-Google-Smtp-Source: APXvYqwWb57alHr2LvZpZCYufai0P5xCFuoCuOvygzaDYOmnP+qQ3oyosoF/4hU6DHnEoXmLxUJwIg==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr2445155pgt.145.1578443630687;
        Tue, 07 Jan 2020 16:33:50 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/22] tools/btproxy: Add support for ISO packets
Date:   Tue,  7 Jan 2020 16:33:27 -0800
Message-Id: <20200108003342.15458-8-luiz.dentz@gmail.com>
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

