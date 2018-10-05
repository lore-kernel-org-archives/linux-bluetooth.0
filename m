Return-Path: <SRS0=1XHc=MR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBCFC00449
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0F208E7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujGPJXeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD0F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeJEP6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:58:19 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:35012 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeJEP6T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Oct 2018 11:58:19 -0400
Received: by mail-lf1-f48.google.com with SMTP id r191-v6so8834381lff.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Oct 2018 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=TpwWCpHenp/GogILBCyRX+o266wqgOyKW0+hlqSLLNk=;
        b=ujGPJXeX27e7B1c+lFtiCvhfLGfrCmFtRlaW98F/fr/HVa+RYaceLfMSUtSfJ/M0/s
         pWyiPVMy/j5j0j+WWv8TcGQxnWyyB6Xa7huvxIT4mb2HNRP8hFJzvsyyaOKvRE9Fpri7
         Ze3WRgWMX1HEBiglxTnRAt48MA7dFVVOsKUauoNdJHaWUj0Tany2GG+8QaBESFWWadbo
         RfrEhSWtJDzxvn0GE9WZrFiWWr5Ck2MQMulNmGn8BqIt/J6/F71LtPOoBAA0igmdLqsu
         KB2+Lu6wPnRIcHo/hFQL3Xlb3IWkMEN5juq4A6S7ZyZzhR3f0riJbOqs8qas5d0DCTPw
         mjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=TpwWCpHenp/GogILBCyRX+o266wqgOyKW0+hlqSLLNk=;
        b=eUp6A6Y3CewVEvlE2rVe34ORXzCJw0sKjd9UHK+eBSnfcTJoQIPdmRjS6VuikNjV4y
         OjP1rvE4q4qMaAKkSvWY7mhukG9GR+7Ffh4UJWzuYzxa2KD1Te4YlNjjDyh4ciDBMYQv
         4Q9VsKl0orIt5apg0H2tEQVIYboIGcMpf01JZKUQ3druxGj6fXL2XdI9QqDc2Y1NAgrO
         cf9Kg7g07kDvF5KCjufvJTCNHdvRPZ/8TmddUJ3aO/qkfprbeq1X7DfkesYbe+jGql6p
         Z3+keIyolQt8ykx4wHLSqRZQUZkzSHk23rNzSFCrGbG4r1maqiDTz2Ci6UnM/hY/jkhb
         9fow==
X-Gm-Message-State: ABuFfogheIidHGOUzDHMkXJPJ5bmGDzTN+FUk6ARbDFHHwJUV2KS/Sy3
        +qmDBiKr19TDUi5rfFmWkBrfQtjq
X-Google-Smtp-Source: ACcGV61t0tqi1Y6GtRvbA10QeVgqDXmlJB2oPLsuCB5sIPTeULh8P/GguvT29fJVsW+cXIkJWu8dpA==
X-Received: by 2002:a19:6544:: with SMTP id c4-v6mr5836118lfj.31.1538730029865;
        Fri, 05 Oct 2018 02:00:29 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id a12-v6sm241355lfe.73.2018.10.05.02.00.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 02:00:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] monitor: Add support for user input/output data
Date:   Fri,  5 Oct 2018 12:00:25 +0300
Message-Id: <20181005090026.7535-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005090026.7535-1-luiz.dentz@gmail.com>
References: <20181005090026.7535-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This detects if the user logging is an input/output and then proceed to
decode the header which inform for which CID and PSM the data is for.
---
 monitor/l2cap.c  | 35 ++++++++++++++++++++---------------
 monitor/l2cap.h  |  3 +++
 monitor/packet.c | 41 ++++++++++++++++++++++++++++++++++++++---
 monitor/packet.h |  3 ++-
 4 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index ef2a14410..05a33b903 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -1384,7 +1384,8 @@ static const struct sig_opcode_data le_sig_opcode_table[] = {
 
 static void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
 				uint16_t handle, uint8_t ident,
-				uint16_t cid, const void *data, uint16_t size)
+				uint16_t cid, uint16_t psm,
+				const void *data, uint16_t size)
 {
 	frame->index   = index;
 	frame->in      = in;
@@ -1393,10 +1394,10 @@ static void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
 	frame->cid     = cid;
 	frame->data    = data;
 	frame->size    = size;
-	frame->psm     = get_psm(frame);
+	frame->psm     = psm ? psm : get_psm(frame);
 	frame->mode    = get_mode(frame);
 	frame->chan    = get_chan(frame);
-	frame->seq_num = get_seq_num(frame);
+	frame->seq_num = psm ? 1 : get_seq_num(frame);
 }
 
 static void bredr_sig_packet(uint16_t index, bool in, uint16_t handle,
@@ -1479,7 +1480,7 @@ static void bredr_sig_packet(uint16_t index, bool in, uint16_t handle,
 			}
 		}
 
-		l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid,
+		l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid, 0,
 								data, len);
 		opcode_data->func(&frame);
 
@@ -1561,7 +1562,8 @@ static void le_sig_packet(uint16_t index, bool in, uint16_t handle,
 		}
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid, data, len);
+	l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid, 0,
+							data, len);
 	opcode_data->func(&frame);
 }
 
@@ -1592,7 +1594,7 @@ static void connless_packet(uint16_t index, bool in, uint16_t handle,
 		break;
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, 0, cid, data, size);
+	l2cap_frame_init(&frame, index, in, handle, 0, cid, 0, data, size);
 }
 
 static void print_controller_list(const uint8_t *data, uint16_t size)
@@ -1961,7 +1963,7 @@ static void amp_packet(uint16_t index, bool in, uint16_t handle,
 		}
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, 0, cid, data + 6, len);
+	l2cap_frame_init(&frame, index, in, handle, 0, cid, 0, data + 6, len);
 	opcode_data->func(&frame);
 }
 
@@ -2544,7 +2546,8 @@ static void att_packet(uint16_t index, bool in, uint16_t handle,
 		}
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, 0, cid, data + 1, size - 1);
+	l2cap_frame_init(&frame, index, in, handle, 0, cid, 0,
+						data + 1, size - 1);
 	opcode_data->func(&frame);
 }
 
@@ -3000,12 +3003,13 @@ static void smp_packet(uint16_t index, bool in, uint16_t handle,
 		}
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, 0, cid, data + 1, size - 1);
+	l2cap_frame_init(&frame, index, in, handle, 0, cid, 0,
+						data + 1, size - 1);
 	opcode_data->func(&frame);
 }
 
-static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
-			uint16_t cid, const void *data, uint16_t size)
+void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
+			uint16_t psm, const void *data, uint16_t size)
 {
 	struct l2cap_frame frame;
 	uint32_t ctrl32 = 0;
@@ -3033,7 +3037,8 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 		smp_packet(index, in, handle, cid, data, size);
 		break;
 	default:
-		l2cap_frame_init(&frame, index, in, handle, 0, cid, data, size);
+		l2cap_frame_init(&frame, index, in, handle, 0, cid, psm,
+							data, size);
 
 		if (frame.mode > 0) {
 			ext_ctrl = get_ext_ctrl(&frame);
@@ -3136,7 +3141,7 @@ void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 
 		if (len == size) {
 			/* complete frame */
-			l2cap_frame(index, in, handle, cid, data, len);
+			l2cap_frame(index, in, handle, cid, 0, data, len);
 			return;
 		}
 
@@ -3181,7 +3186,7 @@ void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 		if (!index_list[index][in].frag_len) {
 			/* complete frame */
 			l2cap_frame(index, in, handle,
-					index_list[index][in].frag_cid,
+					index_list[index][in].frag_cid, 0,
 					index_list[index][in].frag_buf,
 					index_list[index][in].frag_pos);
 			clear_fragment_buffer(index, in);
@@ -3216,7 +3221,7 @@ void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 		}
 
 		/* complete frame */
-		l2cap_frame(index, in, handle, cid, data, len);
+		l2cap_frame(index, in, handle, cid, 0, data, len);
 		break;
 
 	default:
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 813c7932a..07864caee 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -170,6 +170,9 @@ static inline bool l2cap_frame_get_be128(struct l2cap_frame *frame,
 	return true;
 }
 
+void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
+		uint16_t psm, const void *data, uint16_t size);
+
 void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 					const void *data, uint16_t size);
 
diff --git a/monitor/packet.c b/monitor/packet.c
index aca0761fd..6932f592d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3947,7 +3947,8 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 		ident = ul->ident_len ? data + sizeof(*ul) : NULL;
 
 		packet_user_logging(tv, cred, index, ul->priority, ident,
-					data + sizeof(*ul) + ul->ident_len);
+					data + sizeof(*ul) + ul->ident_len,
+					size - (sizeof(*ul) + ul->ident_len));
 		break;
 	case BTSNOOP_OPCODE_CTRL_OPEN:
 		control_disable_decoding();
@@ -9873,9 +9874,36 @@ void packet_system_note(struct timeval *tv, struct ucred *cred,
 					"Note", message, NULL);
 }
 
+struct monitor_l2cap_hdr {
+	uint16_t cid;
+	uint16_t psm;
+};
+
+static void packet_decode(struct timeval *tv, struct ucred *cred, char dir,
+				uint16_t index, const char *color,
+				const char *label, const void *data,
+				uint16_t size)
+{
+	const struct monitor_l2cap_hdr *hdr = data;
+
+	if (size < sizeof(*hdr)) {
+		print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+			"Malformed User Data packet", NULL, NULL);
+	}
+
+	print_packet(tv, cred, dir, index, NULL, COLOR_HCI_ACLDATA, label,
+				dir == '>' ? "User Data RX" : "User Data TX",
+				NULL);
+
+	/* Discard last byte since it just a filler */
+	l2cap_frame(index, dir == '>', 0, hdr->cid, hdr->psm,
+			data + sizeof(*hdr), size - (sizeof(*hdr) + 1));
+}
+
 void packet_user_logging(struct timeval *tv, struct ucred *cred,
 					uint16_t index, uint8_t priority,
-					const char *ident, const char *message)
+					const char *ident, const void *data,
+					uint16_t size)
 {
 	char pid_str[140];
 	const char *label;
@@ -9930,7 +9958,14 @@ void packet_user_logging(struct timeval *tv, struct ucred *cred,
 			label = "Message";
 	}
 
-	print_packet(tv, cred, '=', index, NULL, color, label, message, NULL);
+	if (ident[0] == '<' || ident[0] == '>') {
+		packet_decode(tv, cred, ident[0], index, color,
+				label == ident ? &ident[2] : label,
+				data, size);
+		return;
+	}
+
+	print_packet(tv, cred, '=', index, NULL, color, label, data, NULL);
 }
 
 void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
diff --git a/monitor/packet.h b/monitor/packet.h
index 03279e114..199e15e58 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -83,7 +83,8 @@ void packet_system_note(struct timeval *tv, struct ucred *cred,
 					uint16_t index, const void *message);
 void packet_user_logging(struct timeval *tv, struct ucred *cred,
 					uint16_t index, uint8_t priority,
-					const char *ident, const char *message);
+					const char *ident, const void *data,
+					uint16_t size);
 
 void packet_hci_command(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size);
-- 
2.17.1

