Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037BFC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 20:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjEEUcD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 16:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjEEUcC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 16:32:02 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DCC46AF
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 13:32:01 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-32b47d6792dso16125285ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 May 2023 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683318720; x=1685910720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSt3r01zkwaXGNSAImYKmxDp2AYuwlOkuQWolsaOpm0=;
        b=GU1G4l1x5wf0opPzkKDpnc2shsHz6/FpmvtpPvjY0Hmkku/nSL8dMCRI+cW/imJere
         yLQcJdqHKrg2R5nC5+Y7HeyYKeR89L6SnrKqk5FreSaNbAQHXM5Ah5o+e+8hHvbbCzxw
         dB91vb5HSqvIiVTzlQUjSmLUgYE+prnTd4UMdZUD7XKfGiSdWCThWaobHqgliEOtI7Ak
         /rQ1TH0dmXrRI5JlWQpxxaNeslPUO3JwywdlTU7eQkAvd82d9X0GMmOj67WDtmmJLwFW
         a+UTO76wVlFBT5gmo9k4kxt5ay0+AUASD7ghzjI77Vw0IPNwjceaycisl4wa7y1XWFB4
         q/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683318720; x=1685910720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSt3r01zkwaXGNSAImYKmxDp2AYuwlOkuQWolsaOpm0=;
        b=hHyO3H0VX6/+Sh8RkwyAGTlpNNrsx+crInx87gooWiOBeXIhxZ450d/0kiIdR1D05y
         w1jSZTZ9kldSm13KZhlYYc6+0CqO1uJSJGaSzq7383D1XdfvcdBJBVNwumYXw5G/kuCd
         t7VyK0AFuj9Fry+5cpfiv5VTIvuN14LWDhiMAc+gagMJ9rfLM697l2IN4zseiGwnurhn
         9G0b9tkyIxj2wm6KR4CZ0pQT6eEGFw1MZHNar8GJM+Sf0GAIa6B2U/zUjjPKhvUOnFRu
         xPRIJ/qeyf/V/PSzqrFgxuNrXZLIRl9HT7gSEJo1khhnPRXF4dyIAY5XmMXWjhVdKGc2
         FxjA==
X-Gm-Message-State: AC+VfDwja0eUi7g7NPzgFwEHKzkz0gZBbiLeEt7QPUVVNmv00GW3ovzW
        NKmlszsa0E/DrfIb0bmzLsK71JV5Wsk=
X-Google-Smtp-Source: ACHHUZ6m34KOkTH3UuwczZNv1S5aWu/BCdVY+qpJ9Kpg7oNJb+av1H3Z43Iro3hp84h2g5L0Tj1jbQ==
X-Received: by 2002:a92:d449:0:b0:331:3564:7834 with SMTP id r9-20020a92d449000000b0033135647834mr1724497ilm.18.1683318720350;
        Fri, 05 May 2023 13:32:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id s187-20020a0251c4000000b0040f9c31784csm190678jaa.87.2023.05.05.13.31.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 13:31:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor: Fix misaligment errors
Date:   Fri,  5 May 2023 13:31:56 -0700
Message-Id: <20230505203156.2561265-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230505203156.2561265-1-luiz.dentz@gmail.com>
References: <20230505203156.2561265-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following errors:

monitor/packet.c:11968:27: runtime error: member access within
misaligned address 0x565448026d55 for type
'const struct monitor_l2cap_hdr', which requires 2 byte alignment
monitor/packet.c:11968:4: runtime error: member access within
misaligned address 0x565448026d55 for type
'const struct monitor_l2cap_hdr', which requires 2 byte alignment
---
 monitor/packet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 645e3f97ef40..94561b65ea75 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11945,7 +11945,7 @@ void packet_system_note(struct timeval *tv, struct ucred *cred,
 struct monitor_l2cap_hdr {
 	uint16_t cid;
 	uint16_t psm;
-};
+} __attribute__((packed));
 
 static void packet_decode(struct timeval *tv, struct ucred *cred, char dir,
 				uint16_t index, const char *color,
@@ -11964,7 +11964,8 @@ static void packet_decode(struct timeval *tv, struct ucred *cred, char dir,
 				NULL);
 
 	/* Discard last byte since it just a filler */
-	l2cap_frame(index, dir == '>', 0, hdr->cid, hdr->psm,
+	l2cap_frame(index, dir == '>', 0,
+			le16_to_cpu(hdr->cid), le16_to_cpu(hdr->psm),
 			data + sizeof(*hdr), size - (sizeof(*hdr) + 1));
 }
 
-- 
2.40.0

