Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAB0C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 07:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E097208B6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 07:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM3le/SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgKCHYy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Nov 2020 02:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHYy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Nov 2020 02:24:54 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B97C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 23:24:54 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so13411775pfr.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 23:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rWWtfKbHQ9Cf3mLK5ZVOIENiqFGX+hxAfcD3Q39AUko=;
        b=EM3le/SR5ZgCDnFNuV7cJm5DeVnU/W2JkCdkL1xWD268JNzBMHIjLZE2YQ8BMrOJUQ
         Us7mh0v9w2HajuaRG0qYaRgbzO53eYopdK1I/mo7F9HPYWWw7R3pIIhChXyD7oBRS0S3
         1sPvSsAq+4g+frj1AZ+0ZHu4XLu2EGfkRiXDi86jfTbOaZ5kje6uw4f9sfbMuBu/J8NG
         GAR08C6u1bbwztd/3qIfsgbvok/g6JNjzWdlOlANBMML+7jpzi4J0qus954w9vI2eDVt
         QeKG1hsVNyu4VAmQWDDiZ41OPVS0GmE5/qSFyze1pYrYRkXLf5TT04VCEycoY5HCc8yw
         z39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rWWtfKbHQ9Cf3mLK5ZVOIENiqFGX+hxAfcD3Q39AUko=;
        b=dd9WcjnNGiJRE5J+UZdyF4APYYGl3XdvY8lJK94e/RVLU/i4g65VxvLEz/j5Uycw7U
         vUu+maoilWYgFwfMUapwQDmz7oXsM17zz0cioymQXw/Zpi57/52v5Isem4BTplmxcyjM
         7Fel9oTLaR4tXamSl9Q+trO4+R2Kiuvrs1rn3AJ8RFK5a4hDNgjWRedKQ6LgVLtl/Qab
         sgs6uOXC1rXAubpJmttyyD+Ts/xCAfON7RcjCiM1Fj0iYVpDB2o4PTNZqndcDBZ25aHs
         A6xLrxDxHJ7f1QZTUDGxfZsMsRUfqx2hsfzUQI1JxeAMPrMZqfEEqiOCa4RvakYUlN1/
         euvg==
X-Gm-Message-State: AOAM533exFD7zqbCohvSX4Xo+dzyeLklGD4xtANBwSc4HmwUf1TCWg7d
        cptELCVzXpLVCQHficuQpRjqsA4miQ0=
X-Google-Smtp-Source: ABdhPJz6HznKO9bH6/3VjAfz/Rw7XbatFSatIbWQfTeFzThaezg08oQCzFXe1VRbNdmJbWab0QkTkg==
X-Received: by 2002:a63:4204:: with SMTP id p4mr16655081pga.219.1604388293701;
        Mon, 02 Nov 2020 23:24:53 -0800 (PST)
Received: from nsathish-Latitude-7480.iind.intel.com ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id l20sm1968934pfd.103.2020.11.02.23.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:24:52 -0800 (PST)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [Bluez PATCH] profile: GOEP Set IMTU to 32k
Date:   Tue,  3 Nov 2020 13:00:32 +0530
Message-Id: <20201103073032.4532-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

OPP-RX Throughput is low Due to Low MTU value in case of OBEX
over L2CAP. Changing the default L2CAP MTU from 672 to 32767.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 src/profile.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 5e460b639..99a5e1a4a 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -41,6 +41,8 @@
 #include "profile.h"
 #include "service.h"
 
+#define BTRX_MTU               32767
+
 #define DUN_DEFAULT_CHANNEL	1
 #define SPP_DEFAULT_CHANNEL	3
 #define HSP_HS_DEFAULT_CHANNEL	6
@@ -1358,6 +1360,11 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 			l2cap->adapter = btd_adapter_ref(adapter);
 			ext->servers = g_slist_append(ext->servers, l2cap);
 			DBG("%s listening on PSM %u", ext->name, psm);
+			if (g_strcmp0(ext->name, "Object Push") == 0) {
+				if (!bt_io_set(io, NULL, BT_IO_OPT_IMTU, BTRX_MTU,
+				    BT_IO_OPT_INVALID))
+					DBG("ERROR bt_io_set Unable to set MTU");
+			}
 		}
 	}
 
-- 
2.17.1

