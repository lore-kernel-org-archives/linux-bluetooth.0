Return-Path: <SRS0=EM7j=WB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22164C433FF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Aug 2019 07:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B2D2067D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Aug 2019 07:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="exLFjaut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHEHzH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:55:07 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36628 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEHzH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Aug 2019 03:55:07 -0400
Received: by mail-lf1-f52.google.com with SMTP id j17so3133806lfp.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2019 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JUiXgTGpVbO60qhcPzO7yJeZwIi/gvrMNbL7/8cKQY=;
        b=exLFjaut0V+HBOaETOrm9fo52lXdqoMQ3QIrghun7GcttKV+lMXwiE4Sxd8+T2hKP7
         T5j8f/aIYesZp47b+B118f7hyzjVdEZWpWTbwwe9h4CgpQejV5+/pQpnI31NVlmgP6bw
         /W4yM9iEt663wc6bFStLNaJklsgME4SXEPlhADZzwfy/XATduX0VTKgbrzk5EgER8zjS
         0HQET+btxkHpM0tDjpPettErhcieB7vPLv+e7yVM5qPGHfzkvaPQhDyd8d0L+zAyt2iL
         tZNaBzQzYIMF8J6BLJspkAnB+zR11SjsHA7SNNyc54aAABLK6fjhtVh9WfaldA0jRFhw
         bAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JUiXgTGpVbO60qhcPzO7yJeZwIi/gvrMNbL7/8cKQY=;
        b=FWjrbbYkoC/eamsiCaPTuEnuQfna1d3z7g/Cytvnq7yOSJlK0XvUwF+KLbIsySH615
         qbqXU5Y2/PWRItggfcKqEB+4zEmd1s7TjAQV6xBsJFDL9QbbWQQ7q/hERp2JlbaASU3E
         USX4mNyIezPuo/jo6v1O7VlqxYPPdniePW4vLpFeqfIqIfixlorseehepqWzBTE/z9k1
         5husm0izEDDmr6/H6YNfuuDQJCl5ndlrqijvbJuuAnGGHRewp4cJZaRQ2LrOatdM3m5l
         1hgQcONAUylD/Kchqd/sTBDobGo4ubs9AjNBvW5AF/QZxKZ/Wuw+U/MK3yKpabIr/oQP
         VVpA==
X-Gm-Message-State: APjAAAWf3wM58eAmRKwMzYgvk6A9YtuNbJAZ4qCm/AqHpV4XItO9OiDj
        uqw/4xxYAFdpTTfkOoXeEopHdidzm8I=
X-Google-Smtp-Source: APXvYqyH3cYhSbNUEu7OTRXJxpl11HiE7NhbtVeE96kxebaH2AzQ9OsyoJ3jKfyRL/KEvGLWO/gxWw==
X-Received: by 2002:a19:4c57:: with SMTP id z84mr2602656lfa.87.1564991704826;
        Mon, 05 Aug 2019 00:55:04 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id q17sm1661313lfb.26.2019.08.05.00.55.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 00:55:03 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix storing network retransmission in config
Date:   Mon,  5 Aug 2019 09:54:58 +0200
Message-Id: <20190805075458.15694-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-config-json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 177aaac7b..d49f5226a 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1553,7 +1553,7 @@ bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 	jnode = cfg->jnode;
 
 	jretransmit = json_object_new_object();
-	if (jretransmit)
+	if (!jretransmit)
 		return false;
 
 	if (!write_int(jretransmit, "count", cnt))
-- 
2.19.1

