Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE45FC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 01:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCPBQh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 21:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPBQg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 21:16:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A63CE2C
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:16:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i5so142847pla.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678929391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It02UyW2f2ZA/0vpvxYAhLaJMnV6tE3GwBT/VOn+yi4=;
        b=Q1u6w8z+bbg/XiY77bZ3oAPIgBY4al+w4VpYRvbQ9sCNUUk7RMyEgrMh6QvblHhJDM
         lFfl1KjgzEx2bHL9lR4z+cCilEYy9vZUGGmKAZXUkneNN3oJVyM8eBVcDFo7i2GjI7j4
         x6vhdZW2MrGGVVbk1EtfXIXpMIKBhTEEzp3K8XHafFsZ8BMeLstU6coS3TiZbXh705JO
         0cqcWBD+o6o1LrYuM2bn+S+hzKHrgIhmz8C+9WyQ6t7A28b30+DGjZryHF2rDkan9n8F
         VgpyOrwsO+o7D7IwsHQ7TP/6A9+SH/rlo1CMsjAG1kNiFZN1XI9d7xb3z7X9SfgJavzX
         4i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678929391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It02UyW2f2ZA/0vpvxYAhLaJMnV6tE3GwBT/VOn+yi4=;
        b=HkSqsN0W9yJicYmTmTImXAd8IBycupokVsahJ3lePY33Epfka0374LXlaCnzHgk3VN
         Jjfu7DGQGUvCGqhp8j5QvZN8L1uUD6bR/H7Axo9QiAHIPs9zeAYKYcckgMTQZhfYmPh4
         3l+gQJYFCoDJ3bjIj6L20YUPZIwtRKTG2BWMQCt01gt9YLOYHEzQ8kzdXFkcUk3cXviV
         Bc25DaAkMOY0acNzfVG7FntNRhE0yII0dJzIdXpORKcmG5adDvVYmlJVanFGZAj1PoEz
         62HcVYGH0m4mSZTz9lTfAxxrhhy349a3drCrKw9KyskC5DEp6ntzS6Fdrw3hzvpykldL
         tVMQ==
X-Gm-Message-State: AO0yUKWNmAhu03hxEd/PRESbYsGLvIVVBoox7lLnWMLHYKUjhqUGqRi2
        c3I1xSlf1kg/XuwMRHNYaoi64QsIfbo=
X-Google-Smtp-Source: AK7set83ETzqPqK3mZ4GrpRNJq7vToK7RBE/+6f+DM295cEOiIrQ7sktSoypOhZ6eObS8jcW9lInIA==
X-Received: by 2002:a05:6a21:3292:b0:d6:93bc:d94 with SMTP id yt18-20020a056a21329200b000d693bc0d94mr2123734pzb.4.1678929391223;
        Wed, 15 Mar 2023 18:16:31 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id g3-20020a631103000000b00502ecb91940sm3914328pgl.55.2023.03.15.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:16:30 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 2/3] mesh: Make MGMT mesh-io less noisy
Date:   Wed, 15 Mar 2023 18:16:26 -0700
Message-Id: <20230316011627.27322-2-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316011627.27322-1-brian.gix@gmail.com>
References: <20230316011627.27322-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove excessive logging traffic
---
 mesh/mesh-io-mgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index 65994f058..f1385edcc 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -227,7 +227,7 @@ static void process_rx(uint16_t index, struct mesh_io_private *pvt, int8_t rssi,
 static void send_cmplt(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	print_packet("Mesh Send Complete", param, length);
+	/* print_packet("Mesh Send Complete", param, length); */
 }
 
 static void event_device_found(uint16_t index, uint16_t length,
@@ -506,7 +506,7 @@ static void send_cancel(struct mesh_io_private *pvt)
 
 	if (pvt->handle) {
 		remove.handle = pvt->handle;
-		l_debug("Cancel TX");
+		/* l_debug("Cancel TX"); */
 		mesh_mgmt_send(MGMT_OP_MESH_SEND_CANCEL, pvt->send_idx,
 						sizeof(remove), &remove,
 						NULL, NULL, NULL);
@@ -560,7 +560,7 @@ static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
 
 	mesh_mgmt_send(MGMT_OP_MESH_SEND, index,
 			len, send, send_queued, tx, NULL);
-	print_packet("Mesh Send Start", tx->pkt, tx->len);
+	/* print_packet("Mesh Send Start", tx->pkt, tx->len); */
 	pvt->tx = tx;
 }
 
-- 
2.39.2

