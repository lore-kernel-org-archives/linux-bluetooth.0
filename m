Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F6CC001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 22:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjG1Wm7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjG1Wm6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 18:42:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF746421C
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686e29b058cso2012029b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690584176; x=1691188976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqtPrNOzG2zgD66FN9kCCGXtJuxydbI9dQmkP+yzwmg=;
        b=D/c/EuE0Q0PYZO2uGGIAEMmqGMEVtza8aDkdb2Yxp1hyS+xAl8grmUaNy9SrQYphlv
         RNPkaWOOLedy3ntJBm/ETHnRWs7Kt8wMTJqbTDm90UqmSWhcD12tM6XVXHAoi4/abMX+
         fL7uR5zWS8KTglW8if9D7c7qRwPBKXxnnKPNXHVVg/wYaQpdtrR5iiSidzThtDrzk9Cb
         NOik+TPa8pmLett2rVHKBih8r058VwvwQdvXzhcz80xTQFM4/rRzJ9K2j5ZGj9fxfJVA
         DxxWZYdRUHyLLpCO0y/jG2V9D2tN571Fs/fud7n9SlMJZmDkgRtCjYzl2EAK1kFu1ivt
         gA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584176; x=1691188976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqtPrNOzG2zgD66FN9kCCGXtJuxydbI9dQmkP+yzwmg=;
        b=JR74wiiGy4sq5i1PMslOJwlVEFL925tSYUK7BJAZcR6PUxg/KGZRoWdVq25NvQO224
         3ec0ly7fWVdeTmuEK6JL6u7/LYfjv94GVo0g2PMtqdi1Bn+OwdBlx7q0J4sRUEktj7Ff
         yTGabG9y+IlqnWW6/+bc4gim16L8vl12wU7N+hu1dar0CMDtSh0yEK7SFSkGMlcwlk/Z
         nqVq3SXmWEM3X8o4qHA0ljZthDVC3Rs/AJijsvy2HOJDWeRG6Mz6QCwF7xt+yiANOLJ4
         OL8Dj3onxVsNIvt2u92agVBnp1zJJxLssrno/aM6L+KWQQ/pzuHiynd0TI555IFzxuu7
         KX/g==
X-Gm-Message-State: ABy/qLaVMOnX/6D8uZLsvm2ENhiWaLicnu9sMetL+I5dfpdCkRsrkj8r
        yqi8/MFzUFdPuGaJbUoaytdPEN3lswo=
X-Google-Smtp-Source: APBJJlFOcvCHIzVeQdjcKdfzWvhLiTq5XCGU2i2ZcIGp00iLFDNPezHs5/oSFOAGKIn+AJKUajYWEA==
X-Received: by 2002:a05:6a00:1955:b0:686:bc23:e20a with SMTP id s21-20020a056a00195500b00686bc23e20amr3459914pfk.21.1690584176535;
        Fri, 28 Jul 2023 15:42:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b0068703879d3esm2731041pfu.113.2023.07.28.15.42.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:42:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v5 5/7] monitor: Fix not calculating latency for ISO/SCO packets
Date:   Fri, 28 Jul 2023 15:42:45 -0700
Message-ID: <20230728224247.102057-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728224247.102057-1-luiz.dentz@gmail.com>
References: <20230728224247.102057-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ISO/SCO packets latency was not being calculated because no connection
was assigned to them.
---
 monitor/packet.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index badc9b9c7785..b5a4fb1671b1 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10607,6 +10607,10 @@ static void sync_conn_complete_evt(struct timeval *tv, uint16_t index,
 	print_field("RX packet length: %d", le16_to_cpu(evt->rx_pkt_len));
 	print_field("TX packet length: %d", le16_to_cpu(evt->tx_pkt_len));
 	print_air_mode(evt->air_mode);
+
+	if (evt->status == 0x00)
+		assign_handle(index, le16_to_cpu(evt->handle), evt->link_type,
+					(void *)evt->bdaddr, BDADDR_BREDR);
 }
 
 static void sync_conn_changed_evt(struct timeval *tv, uint16_t index,
@@ -11566,6 +11570,10 @@ static void le_cis_established_evt(struct timeval *tv, uint16_t index,
 	print_field("Central to Peripheral MTU: %u", le16_to_cpu(evt->c_mtu));
 	print_field("Peripheral to Central MTU: %u", le16_to_cpu(evt->p_mtu));
 	print_slot_125("ISO Interval", evt->interval);
+
+	if (!evt->status)
+		assign_handle(index, le16_to_cpu(evt->conn_handle), 0x05,
+					NULL, BDADDR_LE_PUBLIC);
 }
 
 static void le_req_cis_evt(struct timeval *tv, uint16_t index,
@@ -11604,6 +11612,14 @@ static void le_big_complete_evt(struct timeval *tv, uint16_t index,
 	print_slot_125("ISO Interval", evt->interval);
 	print_list(evt->bis_handle, size, evt->num_bis,
 				sizeof(*evt->bis_handle), print_bis_handle);
+
+	if (!evt->status) {
+		int i;
+
+		for (i = 0; i < evt->num_bis; i++)
+			assign_handle(index, le16_to_cpu(evt->bis_handle[i]),
+					0x05, NULL, BDADDR_LE_PUBLIC);
+	}
 }
 
 static void le_big_terminate_evt(struct timeval *tv, uint16_t index,
@@ -11631,6 +11647,14 @@ static void le_big_sync_estabilished_evt(struct timeval *tv, uint16_t index,
 	print_slot_125("ISO Interval", evt->interval);
 	print_list(evt->bis, size, evt->num_bis, sizeof(*evt->bis),
 						print_bis_handle);
+
+	if (!evt->status) {
+		int i;
+
+		for (i = 0; i < evt->num_bis; i++)
+			assign_handle(index, le16_to_cpu(evt->bis[i]),
+					0x05, NULL, BDADDR_LE_PUBLIC);
+	}
 }
 
 static void le_big_sync_lost_evt(struct timeval *tv, uint16_t index,
-- 
2.41.0

