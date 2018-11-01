Return-Path: <SRS0=ihQD=NM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9250EC0044C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4692064C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4Tvn2/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4692064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeKAXUz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:20:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38761 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbeKAXUz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Nov 2018 19:20:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1-v6so16680546ede.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Nov 2018 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=BMoJdJBlS0/Tyeck7eg5vs6zf6QBGuUM6CwU44UfYcQ=;
        b=f4Tvn2/fWDO/5uhpqwOed82xVw4QF837pELuvvN79PTqX56lR1DfiUVc1fFtcDNNxz
         SIROuCZ4YmQU5QqvY+NKKql3LdYIyjrO3o35f9JLdaZwyBfotaANuKU/cmMnmxL1hxyf
         DATxhnX8d2q1fhy7uQG2RlxbXmdGS6ZGav1KXpHnoy6erH86S3jp0SqWxjKbllAS8zXT
         dlgNWqGs8l+JX/EtO0FQjJSTpzCUWG2wgepUZI2qzvIzf3Mg/fWSfIefoqPHFYOdJg/g
         mP+x94DWOkSOkP+qJhFAWOTM9IkoCzEfsYUrglvGrcQWdrcYX6U/+yVqI/m2Dh4+t6W6
         d5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=BMoJdJBlS0/Tyeck7eg5vs6zf6QBGuUM6CwU44UfYcQ=;
        b=rcfa1c3LWqBXzb19HGSBM3j1shFGDBjEosjJj6iVPeBgzCXhdSE0vFc3TZpvgZTCTa
         9YLR+sdBdQsysxve3Qjj0pGyPBFMz+D4YSfRAANMZxLgl3nyi9YVZALWKFGAV4WVIcmN
         lhFl+DaDq24ytes40afGNLN+7ljf64OoZ3YoXI49RvDYF0lUwF+9ZSvudh5BZWZVWvwQ
         MiWYkgGjv6E5LE3Vado3v+/WlWCVOpkn9p0S2DUWHnFxGfctfefSHsr1Lrnwf6vsGiL4
         agCbCjS8YqN0RE3U4p+/T6475CEtHpdYbapRZesRB7Vw0x+fvHqr/0cn5qipC/w22ZpA
         84/Q==
X-Gm-Message-State: AGRZ1gLzPnTPg4qWbPfbbslq+NHe/quJDfmK8owA/vS8/3Xyyv7HTtj1
        j56hHZ6KPN8fj9XIQgjB8T63SJrE
X-Google-Smtp-Source: AJdET5cKMMp6pn+bNWU3ujg5MuAkqJbP+nsj1F74ikRQy9zW1aFBO51ou1jCvjXaAY180Qw/EGXPiw==
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr5209226eds.25.1541081864437;
        Thu, 01 Nov 2018 07:17:44 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id g15-v6sm5452219ejj.67.2018.11.01.07.17.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:17:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] monitor: Decode error response
Date:   Thu,  1 Nov 2018 16:17:38 +0200
Message-Id: <20181101141741.11449-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding for the error code in the error response:

> test-sdp: User Data RX
      Channel: 0 len 7 [PSM 1 mode 0] {chan 0}
      SDP: Error Response (0x01) tid 2 len 2
        Error code: Invalid Continuation State (0x0005)
---
 monitor/sdp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/monitor/sdp.c b/monitor/sdp.c
index 36708f426..1df26a0ca 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -532,6 +532,24 @@ static uint16_t common_rsp(const struct l2cap_frame *frame,
 	return bytes;
 }
 
+static const char *error_str(uint16_t code)
+{
+	switch (code) {
+	case 0x0001:
+		return "Invalid Version";
+	case 0x0002:
+		return "Invalid Record Handle";
+	case 0x0003:
+		return "Invalid Syntax";
+	case 0x0004:
+		return "Invalid PDU Size";
+	case 0x0005:
+		return "Invalid Continuation State";
+	default:
+		return "Unknown";
+	}
+}
+
 static void error_rsp(const struct l2cap_frame *frame, struct tid_data *tid)
 {
 	uint16_t error;
@@ -546,7 +564,7 @@ static void error_rsp(const struct l2cap_frame *frame, struct tid_data *tid)
 
 	error = get_be16(frame->data);
 
-	print_field("Error code: 0x%2.2x", error);
+	print_field("Error code: %s (0x%4.4x)", error_str(error), error);
 }
 
 static void service_req(const struct l2cap_frame *frame, struct tid_data *tid)
-- 
2.17.2

