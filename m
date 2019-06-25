Return-Path: <SRS0=Xyfj=UY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76491C48BD5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jun 2019 11:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407A020656
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jun 2019 11:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Z9TP+jrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfFYLZi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:25:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35064 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfFYLZi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jun 2019 07:25:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so12367585lfg.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2019 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/PpAKWApr2iPqAv22nVepO/MPcRLHhRovvaZUJ0fQo=;
        b=Z9TP+jrASdP3rw6+Cx7FjEq6HQqr4SbtlSSW6jFuz89486R6s+WfuipxLd57JSL1A1
         bgo6fFZ7Oci4aWa9Wg0TS0AJ2kdpma5f4RISq++FMLuvVtdJy8laEhLB1/8RkFtr6zIa
         jZks7voBbWSOR9KozTsQhz59dR3Tg1lvlQ5SFM3Zrratc8lORPPrGcJntHJTl6/g+xCR
         bz7y/gHePkLPyYwQpmETmIcliRNXxi8PMvDCH0b8/5iKfwsm+whk/2tHu+Yrz0dXThWy
         dQcIrdlkNaQuAQQBNs0JHalZZu1lyORggj/QPxycghl/6sJGw+S513xs13WqKyfjbXA1
         3o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/PpAKWApr2iPqAv22nVepO/MPcRLHhRovvaZUJ0fQo=;
        b=SeEPGG6WlTQgVFTsbVAGeMccAcPnaiymO7Uy+kN3vmShbw/YrRnhU6fFKJPcnPqz0Y
         HHxfG72kNZ1msfCoaAjn3D5RFubyE4wyfiEp+e2eIaf3KWZK7Dn4jppogSr4n8CEpCHf
         2gtwkcOrXykd/JqFv4bqqu5iUZOgBe+uxgwSvx4CvexLcXBz4EYSWQQ5LtRSeBq5CEmI
         5mfMeV5btshPMqobZDMAs82uAygsmmcRLcEyZf4/r3gnhroq6arcQBUJeXAOB4VMgGge
         QSbczBFAfvc8bEctTlS/2MdgnCGiDb75sFzW4fzhKGi4T/mIdO2eDcg78CTt3UKZd2JS
         Fd8g==
X-Gm-Message-State: APjAAAWZj27f0rxxyHtJ7IF8FQh6mmaezi2OpFNPSx51rzMVehk5mfrM
        9BDQX5+x1xhpkFNChSvGOIo/8+eyl2Y=
X-Google-Smtp-Source: APXvYqyy+8J8O6KeverQ9GbOqfbUKlVcuSlolvkqR9D+USG7TCRgvCxhZfD8ZGnt2uonRW0VFVhybQ==
X-Received: by 2002:ac2:5981:: with SMTP id w1mr13712250lfn.48.1561461936351;
        Tue, 25 Jun 2019 04:25:36 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id i195sm1895799lfi.87.2019.06.25.04.25.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:25:35 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>,
        Jakub Witowski <jakub.witowski@silvair.com>
Subject: [PATCH BlueZ] mesh: Honor IV Update flag in app layer crypto
Date:   Tue, 25 Jun 2019 13:25:30 +0200
Message-Id: <20190625112530.21870-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since IV Index is used in application nonces, we need to honor IV Update
flag not only in network layer crypto, but also in application layer.
Otherwise, we cannot decode application payloads from nodes that are in
IV Update state.
---
 mesh/net.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index a597b8794..1aa1c4cfa 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2489,6 +2489,14 @@ static void net_rx(void *net_ptr, void *user_data)
 	size_t out_size;
 	uint32_t key_id;
 	int8_t rssi = 0;
+	uint32_t iv_index;
+	bool iv_flag = !!(net->iv_index & 1);
+	bool iv_pkt = !!(data->data[0] & 0x80);
+
+	if (iv_pkt == iv_flag)
+		iv_index = net->iv_index;
+	else
+		iv_index = net->iv_index - 1;
 
 	key_id = net_key_decrypt(net->iv_index, data->data, data->len,
 							&out, &out_size);
@@ -2504,16 +2512,10 @@ static void net_rx(void *net_ptr, void *user_data)
 		rssi = data->info->rssi;
 	}
 
-	relay_advice = packet_received(net, key_id, net->iv_index,
+	relay_advice = packet_received(net, key_id, iv_index,
 							out, out_size, rssi);
 	if (relay_advice > data->relay_advice) {
-		bool iv_flag = !!(net->iv_index & 1);
-		bool iv_pkt = !!(data->data[0] & 0x80);
-
-		data->iv_index = net->iv_index;
-		if (iv_pkt != iv_flag)
-			data->iv_index--;
-
+		data->iv_index = iv_index;
 		data->relay_advice = relay_advice;
 		data->key_id = key_id;
 		data->net = net;
-- 
2.19.1

