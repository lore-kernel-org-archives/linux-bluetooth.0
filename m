Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF23C25B08
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 21:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbiHEV7E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241728AbiHEV6l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 17:58:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDC680480
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 14:56:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so8261926pjz.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihsODam4fhUsGf7+sq5s4Ez5Ukgxqbms2G1kVORuuRE=;
        b=ZTGUqgMkYIN99pth/0dZn5rDsOr4/kaw+SRkIeUYGmWqf/PEAWDb4qammQ/AZkh+tM
         q70PBKFDC1I5UiaGvt8cRf1M585xqEejOdt8cYgJ9k0P/VbLJQdB54yJqyxPEdfXfZMd
         vv8mjsjOiSwcK9wsrGt8Ne3RPzclflkzejxLHl7Usnu5MKiG85eJTC5qkL2GXsd25JjY
         /EjgDIB/VnMu1iRqAtIYHR9uZdsno0U2f+oLJXQlezv2q3pN/9DvuVLy6iJxJTIqcsqq
         C3ioXo5Z6IhPdghFBPYdDwoJXplIfViodg39DEMcltud882wiAmMi0T8oa57DCauX1gc
         Grhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihsODam4fhUsGf7+sq5s4Ez5Ukgxqbms2G1kVORuuRE=;
        b=qTreyyxpWXmLR0AqzmO6Kap6/qjFxs3SegOYihKjfQDNbcR6eVhPf1X14e8tzFbIah
         mCZLHTkl3h3HuDJlamk9r55pfopeZhXXacw/hpEVS7GneGe/8Eabj0NWz5ISas3KzV86
         7EQHwPqxZPe5KRVZv8pII5P3BCp7POjNsn/ungOn7rdotzG+hZ0fjWDv8VX+ctrKZSQ4
         2qLDl/HBZbdwXxkjzMd3efTh0+oaGlTy8ZJcJ5O9qkQ/iwVXqGkE8FSIB3MgEgx/jaJ5
         0RKBUVsLsHhgm7/uM4hbDN+CKpXVqj0w7qXCi47HI68x6XaWl9DhvhH10usr3FQ4fOXt
         g0Tw==
X-Gm-Message-State: ACgBeo0yTRqD4nvLIqa0jzJ6iu/rxh+d9NncvQvyjQJDG4EiHnREp4yG
        ZvUrUK9DpUTjLVUh0ur6VYiLN3ECUFyl3g==
X-Google-Smtp-Source: AA6agR7sfvsNxvZ/CgcEUch0E8fSWxkWll3lJrdxWHQzAxZkLPyMLSaOcKRwxJVNeqkw11EZjbmLHA==
X-Received: by 2002:a17:90b:3711:b0:1f5:179c:ad64 with SMTP id mg17-20020a17090b371100b001f5179cad64mr17612851pjb.11.1659736585039;
        Fri, 05 Aug 2022 14:56:25 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 13-20020a62190d000000b0052d4ffac466sm3447036pfz.188.2022.08.05.14.56.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:56:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] bthost: Add qos support to bthost_set_cig_params
Date:   Fri,  5 Aug 2022 14:56:21 -0700
Message-Id: <20220805215622.3958723-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables setting QoS other then the mandatory 16_2_1.
---
 emulator/bthost.c | 26 +++++++++++++++-----------
 emulator/bthost.h |  4 +++-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 75fa625b1..f067d39a0 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3131,25 +3131,29 @@ bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
 }
 
 void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
-						uint8_t cis_id)
+				uint8_t cis_id, const struct bt_iso_qos *qos)
 {
 	struct bt_hci_cmd_le_set_cig_params *cp;
 
 	cp = malloc(sizeof(*cp) + sizeof(*cp->cis));
 	memset(cp, 0, sizeof(*cp) + sizeof(*cp->cis));
 	cp->cig_id = cig_id;
-	put_le24(10000, cp->c_interval);
-	put_le24(10000, cp->p_interval);
-	cp->c_latency = cpu_to_le16(10);
-	cp->p_latency = cpu_to_le16(10);
+	put_le24(qos->in.interval ? qos->in.interval : qos->out.interval,
+							cp->c_interval);
+	put_le24(qos->out.interval ? qos->out.interval : qos->in.interval,
+							cp->p_interval);
+	cp->c_latency = cpu_to_le16(qos->in.latency ? qos->in.latency :
+							qos->out.latency);
+	cp->p_latency = cpu_to_le16(qos->out.latency ? qos->out.latency :
+							qos->in.latency);
 	cp->num_cis = 0x01;
 	cp->cis[0].cis_id = cis_id;
-	cp->cis[0].c_sdu = 40;
-	cp->cis[0].p_sdu = 40;
-	cp->cis[0].c_phy = 0x02;
-	cp->cis[0].p_phy = 0x02;
-	cp->cis[0].c_rtn = 2;
-	cp->cis[0].p_rtn = 2;
+	cp->cis[0].c_sdu = qos->in.sdu;
+	cp->cis[0].p_sdu = qos->out.sdu;
+	cp->cis[0].c_phy = qos->in.phy ? qos->in.phy : qos->out.phy;
+	cp->cis[0].p_phy = qos->out.phy ? qos->out.phy : qos->in.phy;
+	cp->cis[0].c_rtn = qos->in.rtn;
+	cp->cis[0].p_rtn = qos->out.rtn;
 
 	send_command(bthost, BT_HCI_CMD_LE_SET_CIG_PARAMS, cp,
 				sizeof(*cp) + sizeof(*cp->cis));
diff --git a/emulator/bthost.h b/emulator/bthost.h
index fd177ac29..3d7a124f0 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -12,6 +12,8 @@
 #include <stdint.h>
 #include <sys/uio.h>
 
+#include "lib/bluetooth.h"
+
 typedef void (*bthost_send_func) (const struct iovec *iov, int iovlen,
 							void *user_data);
 
@@ -101,7 +103,7 @@ void bthost_create_big(struct bthost *bthost, uint8_t num_bis);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
 void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
-						uint8_t cis_id);
+				uint8_t cis_id, const struct bt_iso_qos *qos);
 void bthost_create_cis(struct bthost *bthost, uint16_t cis_handle,
 						uint16_t acl_handle);
 
-- 
2.37.1

