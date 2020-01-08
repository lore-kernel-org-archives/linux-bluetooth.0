Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60697C33CA2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FEB206DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ZaTLlk8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgAHVBP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:01:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37758 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgAHVBP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:01:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so3517783lfc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 13:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86tQQFoJuyx30gvEgh9kjWt7y0yJSEbwFKiGrXdjYhw=;
        b=ZaTLlk8k2aUI4QFEpHbIDk1QUjqGMPtojEYRLFRv2fcxucdTWYPFKLnqYo0UbWVT17
         PWABxhxR2RQptd72Sm6x53nLnhtkFA3GLtlRqPM6yD2yodNvF1CzUikEiFXOKLDzd/D8
         dIie0dkzC0Od3W8Z3/Qhc3pasYOXbJhTOBKkoJUbRzViUJsC77N62xTZ4Z7Of3oymLC5
         gTI1sug1EfsIHCWFtNqbzJV+4V77Elqj+S/H8ts2vJJxsxUEu55KD2E7OPA+fdIgJCAA
         bwcSXKQe2sBDv8IAaQs6QGaRkeWcHUNdcK+xQyRpWU1uySMHT4aAnPY7JGz38V9d/Qcy
         rCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86tQQFoJuyx30gvEgh9kjWt7y0yJSEbwFKiGrXdjYhw=;
        b=KdQ8lMzGklG6dLPFLdEQoYcKwrWzHalpDXWqNcrybYbwkUAbtf5eH+gdnPL/Syv4Eg
         LIops59NzVEaDGUt7uNgOR3Prg3rQbm5/wn76QgMnIdR3dkZ6Wixx5CqVIBz6q9BZQFZ
         9piz/Zv/Etv7jgwDow10TUFxlOOZuCK6YVodm1d2YmeNO9JpZWZgeVpNmWSKLryEBbAA
         eR9vXriGopgWIHsAKkAVNTHjGG5J84h5fcw7sMJQGcjNFpzMpwt6NU4nIV7G9WgzOUF0
         2ZhB1Y4LgdmsblEXzOBK/pYF1eWvVmhe6Hx1oKgOyd+4IuTGFe7TBHmasOUFT7iVKj79
         fCYQ==
X-Gm-Message-State: APjAAAVdj8s8cyThpStsPNCwwJmSOgDZiGmsXdf6hKeroWz6cpPuKJ7/
        1oeomhJMaZxWNNRGCHHPRCj8aBUM6mY=
X-Google-Smtp-Source: APXvYqwpPtc7YbUU38wy2i5azESPrY0sBhUdp903DLqXfD4pd04DDMx70C6Naa2KjCvXm/EPBn4X1Q==
X-Received: by 2002:a19:2389:: with SMTP id j131mr3812788lfj.86.1578517273316;
        Wed, 08 Jan 2020 13:01:13 -0800 (PST)
Received: from kynes.internet.domowy (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id w19sm1951773lfl.55.2020.01.08.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:01:12 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
Subject: [PATCH BlueZ v2 1/2] mesh: Fix IV recovery
Date:   Wed,  8 Jan 2020 22:01:02 +0100
Message-Id: <20200108210103.32220-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200108210103.32220-1-michal.lowas-rzechonek@silvair.com>
References: <20200108210103.32220-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Rafał Gajda <rafal.gajda@silvair.com>

This patch fixes saving IV received in SNB to storage.

Previously after creating new node with IV 0 (or loading node with
IV > 0 but after long inactivity) first received SNB should update IV
(and reset sequence number to 0 if necessary).

The bug would prevent new IV being saved in storage which resulted in
sequence number being set to 0 on first SNB received after every daemon
reset but IV never being updated.
---
 mesh/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index 23565c11d..d7ce5493d 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2657,7 +2657,7 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 	if ((iv_index - ivu) > (local_iv_index - local_ivu))
 		mesh_net_set_seq_num(net, 0);
 
-	if (ivu != net->iv_update || local_iv_index != net->iv_index) {
+	if (ivu != net->iv_update || iv_index != net->iv_index) {
 		struct mesh_config *cfg = node_config_get(net->node);
 
 		mesh_config_write_iv_index(cfg, iv_index, ivu);
-- 
2.23.0

