Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B508C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 21:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjEQV66 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 17:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjEQV65 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 17:58:57 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D20E2D53
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 14:58:56 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33456e09e7fso10471925ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684360735; x=1686952735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6bA2i7l2jAPhPz4hQzIcqKd5mqfmaUkS1umpLhKsZJw=;
        b=onspSmX7QQ203hHSNgGA0sdNr9SUnhRst6jiAXZup22FKBGbABAEXC3mpe8SgjAdcK
         ow8KmB7eF1BasJjeaP4dScbQZEq6gpd2sAK31v/3I5bfi5QmaMHEOTq/ozNWY191hZ5h
         VZLtrXb7259p/JcTBBJevi0Xn0rPLylOvE8QtNzG0dTsjTfyIFUFGON+oObyLqQKdsoc
         GAxp8CYcPVfzQFsT7iZELcl2DFRkjGh1utCaQVRsUHaJlpSaFfNhrC0+HL++rq6I9+Ib
         ZOE+C+QW7y7LRfcPkqef3omJo3ydXAnahxbDIa+FJYa7TecmvXukkil+TJElW7hCTsHS
         +3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684360735; x=1686952735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bA2i7l2jAPhPz4hQzIcqKd5mqfmaUkS1umpLhKsZJw=;
        b=bmBCaltZUcxDiU7pDniKsfgruG7d/FBLlGgwewRyFyGGq/jI4pRXquE5yWsCbjzewl
         v7C0Gpxa/lgW8ksin/LctzSZV2Nz//UJCsoYe3wu8N7aY8TRtZgdeaoHxu79OczQU0GS
         JHVpL/BVPsJ9FZzU/LOjfVMe1ZB57HfA9h4+cYRlnATFuI0UPksY/RAu22gpGJm+wLM1
         bOKeNG70SfZv9NhRk+v6j+wUerZpSBqfbdWoNJSf+/NbuM3888yXCZuzf/JP9VeR1xt5
         +UEAPIopuQbKD04gfgPRAJqQvEz8VWm1uyP0eLwMPEuso72CdyJCjcn2xCMjiFSfX5TV
         Kmaw==
X-Gm-Message-State: AC+VfDzItqke7fsBRyZqp/mAaLsvAgi0TTDffyLyElGK9RCbmFOgIZ1J
        sgaqXD/K3ffcuawrwnqMx+KBKG7iEcA=
X-Google-Smtp-Source: ACHHUZ5R1Fv7ejmZ1G6T7jOq6SyAkZfIp9jKthhawxON5mdr11rGvzuLR5Sbnrf3cBS+UUROBHAIQA==
X-Received: by 2002:a92:910:0:b0:32b:46b4:62 with SMTP id y16-20020a920910000000b0032b46b40062mr3261017ilg.6.1684360734775;
        Wed, 17 May 2023 14:58:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id f61-20020a0284c3000000b0040fa75e5a3fsm12326jai.132.2023.05.17.14.58.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:58:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Fix using PACKET_FILTER_SHOW_SCO_DATA for ISO packets
Date:   Wed, 17 May 2023 14:58:52 -0700
Message-Id: <20230517215852.1395512-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the uses of PACKET_FILTER_SHOW_SCO_DATA for ISO packets and
introduce a dedicated flag for it in the form of
PACKET_FILTER_SHOW_ISO_DATA which can be enabled with use of -I/--iso.
---
 monitor/main.c   | 9 +++++++--
 monitor/packet.c | 5 +++--
 monitor/packet.h | 1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 3ec3a5f08a01..decf7cc467f2 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -62,6 +62,7 @@ static void usage(void)
 		"\t-T, --date             Show time and date information\n"
 		"\t-S, --sco              Dump SCO traffic\n"
 		"\t-A, --a2dp             Dump A2DP stream traffic\n"
+		"\t-I, --iso              Dump ISO traffic\n"
 		"\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
 		"\t-P, --no-pager         Disable pager usage\n"
 		"\t-J  --jlink <device>,[<serialno>],[<interface>],[<speed>]\n"
@@ -89,6 +90,7 @@ static const struct option main_options[] = {
 	{ "date",      no_argument,       NULL, 'T' },
 	{ "sco",       no_argument,       NULL, 'S' },
 	{ "a2dp",      no_argument,       NULL, 'A' },
+	{ "iso",       no_argument,       NULL, 'I' },
 	{ "ellisys",   required_argument, NULL, 'E' },
 	{ "no-pager",  no_argument,       NULL, 'P' },
 	{ "jlink",     required_argument, NULL, 'J' },
@@ -126,8 +128,8 @@ int main(int argc, char *argv[])
 		struct sockaddr_un addr;
 
 		opt = getopt_long(argc, argv,
-					"r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C:c:vh",
-					main_options, NULL);
+				"r:w:a:s:p:i:d:B:V:MNtTSAIE:PJ:R:C:c:vh",
+				main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -197,6 +199,9 @@ int main(int argc, char *argv[])
 		case 'A':
 			filter_mask |= PACKET_FILTER_SHOW_A2DP_STREAM;
 			break;
+		case 'I':
+			filter_mask |= PACKET_FILTER_SHOW_ISO_DATA;
+			break;
 		case 'E':
 			ellisys_server = optarg;
 			ellisys_port = 24352;
diff --git a/monitor/packet.c b/monitor/packet.c
index 94561b65ea75..aafb81eefb13 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -66,6 +66,7 @@
 #define COLOR_HCI_EVENT_UNKNOWN		COLOR_WHITE_BG
 #define COLOR_HCI_ACLDATA		COLOR_CYAN
 #define COLOR_HCI_SCODATA		COLOR_YELLOW
+#define COLOR_HCI_ISODATA		COLOR_YELLOW
 
 #define COLOR_UNKNOWN_ERROR		COLOR_WHITE_BG
 #define COLOR_UNKNOWN_FEATURE_BIT	COLOR_WHITE_BG
@@ -12357,7 +12358,7 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	sprintf(handle_str, "Handle %d", acl_handle(handle));
 	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, hdr->dlen);
 
-	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_SCODATA,
+	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_ISODATA,
 				in ? "ISO Data RX" : "ISO Data TX",
 						handle_str, extra_str);
 
@@ -12368,7 +12369,7 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		return;
 	}
 
-	if (filter_mask & PACKET_FILTER_SHOW_SCO_DATA)
+	if (filter_mask & PACKET_FILTER_SHOW_ISO_DATA)
 		packet_hexdump(data, size);
 }
 
diff --git a/monitor/packet.h b/monitor/packet.h
index b07d5d18ce21..55ba854ec1f7 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -22,6 +22,7 @@
 #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 5)
 #define PACKET_FILTER_SHOW_A2DP_STREAM	(1 << 6)
 #define PACKET_FILTER_SHOW_MGMT_SOCKET	(1 << 7)
+#define PACKET_FILTER_SHOW_ISO_DATA	(1 << 8)
 
 struct packet_conn_data {
 	uint16_t index;
-- 
2.40.1

