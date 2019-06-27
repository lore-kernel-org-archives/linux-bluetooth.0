Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19938C48BD9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 07:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B0820843
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 07:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="xXKFe45x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfF0Hkw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:40:52 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:43997 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfF0Hkw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 03:40:52 -0400
Received: by mail-lf1-f51.google.com with SMTP id j29so837003lfk.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2019 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3L9xhlFNz4UzM7u/q7yjK6bEpZeW56jRiYdkwBlY+sk=;
        b=xXKFe45x3AVUNImsUezuHjGiiyChHSnF6PZzwn4baMgLcnjflmMWhsJq4eu7hZqkHU
         JuLtpIMVS13Qw/7FI3BX+trQnIBw6EVYgqMtZ/FjAKtiR+NVPVVo35d//dg+MfAOZ7K7
         g8ipzXpAJ+frwDAX+5WtzCmxX0SfhvF3uJMTufJtrdeQaidIwG4INqodELrAVLC6vE05
         E8IFm2jZ16408KBzaIKI5dm+2Lsem0zFj5IjGZO8R0D11BhEoyHarHiCUcKh/9J9ix1U
         EAAHGrJhzVnntZz4DbswCs1hhdc7/v/t6Ea1gTxqugwjWId/eQCZ6OWwGXmR9F8ViIsj
         GtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3L9xhlFNz4UzM7u/q7yjK6bEpZeW56jRiYdkwBlY+sk=;
        b=t9+05LLye+gHg5zp0LXWmjF21rgM7a5tACfMsF3qlaMtEqjwH+/ZWyLA7UDIhZkDy8
         ZQ6OxatsN+gRRay9+cAMi4rlpEpN/BYojHhgRG+Wzp3wqhGpqQeyvyT+Kl2RX3fhqQ9x
         Ck4pU0qjeFpbT3GjIaWPY29xB+0DCji8spYThItVf2IC/unnkqGck8cl+BaYpFoxgIgp
         dJkjvnaTAwl4+Nb2yttHRr3bZGG059Q7+ROFS4L6bArwZvkh9rDVGMDxL7Iaw+0XInWH
         /oArinVjd7+TL0K36OPchLxmf5ptHm83FmiHrCivWoOajv5w0QxKc0iPST0PZjCFW4S4
         8NFw==
X-Gm-Message-State: APjAAAXZs7loMEhIjjoeV4E2ItbFkYFcDS8zmQM5ifWHdhDQjSymvwyy
        IFYbxx35gid0Nq8vpyat1Mr137zCcWA=
X-Google-Smtp-Source: APXvYqygsXxr6x0eA4bAGKjA2rsvZgz6RA5qONJZrTA9l/4wkdJD6xYE/m60PdbuNuIZejA83110xQ==
X-Received: by 2002:ac2:546a:: with SMTP id e10mr1312134lfn.75.1561621250063;
        Thu, 27 Jun 2019 00:40:50 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 199sm223775ljf.44.2019.06.27.00.40.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 00:40:49 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v3 2/2] mesh: Use current IV Index when relaying
Date:   Thu, 27 Jun 2019 09:40:43 +0200
Message-Id: <20190627074043.22891-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627074043.22891-1-michal.lowas-rzechonek@silvair.com>
References: <20190627074043.22891-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If we are in IV Update state, packets shall be transmitted using IV
Index - 1, including relayed packets.
---
 mesh/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index a5693f154..0a6ff8eac 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2512,7 +2512,7 @@ static void net_rx(void *net_ptr, void *user_data)
 	relay_advice = packet_received(net, key_id, iv_index,
 							out, out_size, rssi);
 	if (relay_advice > data->relay_advice) {
-		data->iv_index = iv_index;
+		data->iv_index = mesh_net_get_iv_index(net);
 		data->relay_advice = relay_advice;
 		data->key_id = key_id;
 		data->net = net;
-- 
2.19.1

