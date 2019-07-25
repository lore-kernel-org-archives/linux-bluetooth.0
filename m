Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F630C76190
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 19:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B4F218EA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 19:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="fzY9KB2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfGYTtt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:49:49 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:35491 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGYTtt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 15:49:49 -0400
Received: by mail-lj1-f179.google.com with SMTP id x25so49220502ljh.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F+fJJZYoJvrHzHRyvMpQbtQFw8HzYTBlV3b4bduCiyQ=;
        b=fzY9KB2HgjEz7vLzt4joyWW3LaOBY2Duu8huZihffGkIUBmGXhfU0Vru6VB3ACNdB/
         5UtZ3cH6cN2sW5n833yFebxEw0KdZnnORmaybcVo7tSNAenx4sl4q+NhRZtB3YI+PmHJ
         NwtwDroF6wkB6XxAiqdK2h1kVLln51YXigLwjgn8rWzUbRhEQ433byulOzwVaQ4a0g2c
         OgS6RhGyR/BvjqBNo5TpNmgab5B8fPowRinUFalsJ9fiDKJ3HxBpozX1GQmPbozIqcMj
         RMrsRUXCojxj7a0wurhocCDEJFUTVJmocWYjea3Elp4fRXlnc1PwHXqsu86po8Ko/e+f
         ysqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+fJJZYoJvrHzHRyvMpQbtQFw8HzYTBlV3b4bduCiyQ=;
        b=MGk5u+lbDJIcbL4hW/2FlNW9SEfzsX8afGV++0IUld5DXKGSxkRXetNBamfQsVz9nX
         d/7X93bH5oTf57BpkCQ2sTjbJTzkdbqFgf+73gdQHlevDLO/utHqEkXTCrrPpwvWpihl
         5sQD2feGygOquVVyyFC3GzWSk6tQthWmhB9gqhTUMsiI8neol5ayBVdwHSgSmCD7WV0p
         5Jg/Jh5ZZ+oFhOCyaiQ4zarTTTR+qWeV8IVompveDUSjlszbcaRp7Y9xKPD4YTHPxGZ9
         ewiohWwsDPj54jMJa9HkrUsfi6lQTreRyB+fWEqJYxnyszC/WIt5vs64hd/7h6mVkjSR
         GSVA==
X-Gm-Message-State: APjAAAXDdBw2/vWwEXCmh+FnLx0XoeexHAFTO4k9iqF+vBQ7k/0DnPTQ
        8TfQ75jzTd41PmTH8MLJ6ii263PHwj0=
X-Google-Smtp-Source: APXvYqzHbfNPbXVPI4xRVIXWDBk0ywjqdZfbXJpmQ78vjm1PuFfFwI+eiVqBOQcU8c6I7ivB5aNgBA==
X-Received: by 2002:a2e:9a49:: with SMTP id k9mr46625196ljj.78.1564084187141;
        Thu, 25 Jul 2019 12:49:47 -0700 (PDT)
Received: from kynes.internet.domowy (apn-95-40-32-72.dynamic.gprs.plus.pl. [95.40.32.72])
        by smtp.gmail.com with ESMTPSA id e62sm9327693ljf.82.2019.07.25.12.49.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:49:46 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/5] mesh: Check that config server is present in primary element
Date:   Thu, 25 Jul 2019 21:49:33 +0200
Message-Id: <20190725194933.7321-6-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190725194933.7321-1-michal.lowas-rzechonek@silvair.com>
References: <20190725194933.7321-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This verifies that Config Server model is supported by element #0, and
is not supported by any other element.
---
 mesh/node.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index 1709a25ba..0b02089bf 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -899,6 +899,8 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 {
 	uint16_t n, features;
 	uint16_t num_ele = 0;
+	uint8_t *cfgmod_idx = NULL;
+
 	const struct l_queue_entry *ele_entry;
 
 	if (!node || !node->comp || sz < MIN_COMP_SIZE)
@@ -961,6 +963,9 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 			mod_id = mesh_model_get_model_id(
 					(const struct mesh_model *) mod);
 
+			if (mod_id == CONFIG_SRV_MODEL)
+				cfgmod_idx = &ele->idx;
+
 			if ((mod_id & VENDOR_ID_MASK) == VENDOR_ID_MASK) {
 				if (n + 2 > sz)
 					goto element_done;
@@ -1006,6 +1011,9 @@ element_done:
 	if (!num_ele)
 		return 0;
 
+	if (!cfgmod_idx || *cfgmod_idx != PRIMARY_ELE_IDX)
+		return 0;
+
 	return n;
 }
 
-- 
2.22.0

