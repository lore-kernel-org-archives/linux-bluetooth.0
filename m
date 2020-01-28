Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64736C33CB2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A17D20708
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1CoOCK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgA1UNk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:13:40 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:40014 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgA1UNk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 15:13:40 -0500
Received: by mail-pl1-f181.google.com with SMTP id y1so2021245plp.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 12:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MkpruhzJdUMGjYESt/x6uM/NOFnLCe0CUgXZj3Q27qE=;
        b=Q1CoOCK7yQTdIHZX1ZFDK/x3EAWsTiMFUy8sPVCNdJxHKAOCDextP3zjxzDOrD238p
         zbIwbPWju+uHS/l0m+ug71+OkM0vb2pYboQF9VrzxIvUskwWpnqGiYKj58yPOnpcqD7Z
         mOA6ruD3QTBCx92XimXrHX+iCNWOXUBjVR76MIX45aSjUdAJjVQy9bhIpgDvFP30xp1B
         V/NqXmLMZNL7WsRf9560BoRRG0cfs9WczkNI/peuy7WwPmzFSLcaa5Ft+w6zqwYKZ0S/
         MTM6cXD+Lm194t+y1UJH1oV0lWToPtLa+uY48T/07gpG35AhzSvPcTl9AsHpEJvpChQY
         FvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkpruhzJdUMGjYESt/x6uM/NOFnLCe0CUgXZj3Q27qE=;
        b=WmODPqFYydjZSQFn302ExVvGxFbR4KcOSl3e87kvgAG4VqsSNLPNR5QhHmtTM2sW34
         DzqF/eQUaBfosfbYJsXqQiEzNGQoyLfUPkIBmr34EidzIypHt3mtUV8o8rbDi4nPNu0C
         z9GnYtp1uUqgiQtrQEb0AOqXu2JyFO+m7diAFl/CJsskkqTRg9r4C1vGwh42O2vf4x+i
         9Q47vSZJi1tGMpm5T4O0r2rBOVvigGi++fcFuA3orxDIUowFIGm7hmaWx/zsxTXQPcbU
         +/dx8Kt60lMdcWeZdcf30O3g8F2vpF4/lbopWU917erJNS95GObDYbnO9hdTac9SUUwP
         1eDQ==
X-Gm-Message-State: APjAAAXcR1VxvKBd1OmWAMmn/Ep6pT/AFviFrrkzUZJOk+26Qk0Uqu8g
        B/YRwGriW8TdJIxz55SW9mIlWSZao1k=
X-Google-Smtp-Source: APXvYqwmdbRv+1KqzgoI+lDQYVkhQKTe9uBE2A/hGSBqZ5ohHQ2T5vAWu5vtwRf6Uty5Qhsg11JtUg==
X-Received: by 2002:a17:902:41:: with SMTP id 59mr25259495pla.39.1580242419622;
        Tue, 28 Jan 2020 12:13:39 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.38])
        by smtp.gmail.com with ESMTPSA id x8sm3367504pfr.104.2020.01.28.12.13.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 12:13:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] monitor: Add support for ISO packets
Date:   Tue, 28 Jan 2020 12:13:32 -0800
Message-Id: <20200128201335.6165-3-luiz.dentz@gmail.com>
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

This enables decoding of ISO packets.
---
 monitor/bt.h         |  2 +-
 monitor/packet.c     | 53 ++++++++++++++++++++++++++++++++++++++++++++
 monitor/packet.h     |  2 ++
 src/shared/btsnoop.h |  2 ++
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index b1b24afeb..c2e6964ff 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -514,7 +514,7 @@ struct bt_hci_sco_hdr {
 
 struct bt_hci_iso_hdr {
 	uint16_t handle;
-	uint8_t  dlen;
+	uint16_t dlen;
 } __attribute__ ((packed));
 
 struct bt_hci_iso_data_start {
diff --git a/monitor/packet.c b/monitor/packet.c
index 007887181..a6d958910 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3934,6 +3934,12 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 	case BTSNOOP_OPCODE_SCO_RX_PKT:
 		packet_hci_scodata(tv, cred, index, true, data, size);
 		break;
+	case BTSNOOP_OPCODE_ISO_TX_PKT:
+		packet_hci_isodata(tv, cred, index, false, data, size);
+		break;
+	case BTSNOOP_OPCODE_ISO_RX_PKT:
+		packet_hci_isodata(tv, cred, index, true, data, size);
+		break;
 	case BTSNOOP_OPCODE_OPEN_INDEX:
 		if (index < MAX_INDEX)
 			addr2str(index_list[index].bdaddr, str);
@@ -11336,6 +11342,53 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		packet_hexdump(data, size);
 }
 
+void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size)
+{
+	const struct bt_hci_iso_hdr *hdr = data;
+	uint16_t handle = le16_to_cpu(hdr->handle);
+	uint8_t flags = acl_flags(handle);
+	char handle_str[16], extra_str[32];
+
+	if (index > MAX_INDEX) {
+		print_field("Invalid index (%d).", index);
+		return;
+	}
+
+	index_list[index].frame++;
+
+	if (size < sizeof(*hdr)) {
+		if (in)
+			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+				"Malformed ISO Data RX packet", NULL, NULL);
+		else
+			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+				"Malformed ISO Data TX packet", NULL, NULL);
+		packet_hexdump(data, size);
+		return;
+	}
+
+	data += sizeof(*hdr);
+	size -= sizeof(*hdr);
+
+	sprintf(handle_str, "Handle %d", acl_handle(handle));
+	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, hdr->dlen);
+
+	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_SCODATA,
+				in ? "ISO Data RX" : "ISO Data TX",
+						handle_str, extra_str);
+
+	if (size != hdr->dlen) {
+		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
+							size, hdr->dlen);
+		packet_hexdump(data, size);
+		return;
+	}
+
+	if (filter_mask & PACKET_FILTER_SHOW_SCO_DATA)
+		packet_hexdump(data, size);
+}
+
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size)
 {
diff --git a/monitor/packet.h b/monitor/packet.h
index 199e15e58..19ea04c68 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -94,6 +94,8 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
 void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
+void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size);
 
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size);
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 3043d33e2..5fb084aa2 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -53,6 +53,8 @@
 #define BTSNOOP_OPCODE_CTRL_CLOSE	15
 #define BTSNOOP_OPCODE_CTRL_COMMAND	16
 #define BTSNOOP_OPCODE_CTRL_EVENT	17
+#define BTSNOOP_OPCODE_ISO_TX_PKT	18
+#define BTSNOOP_OPCODE_ISO_RX_PKT	19
 
 #define BTSNOOP_MAX_PACKET_SIZE		(1486 + 4)
 
-- 
2.21.0

