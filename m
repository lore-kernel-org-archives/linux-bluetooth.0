Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB24C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99655214F1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="knx/vDdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgILGuR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgILGuR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:50:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAB7C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:50:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 7so7975642pgm.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2F5IK3qZINJFDEk93oe4o+MOz1G8iOkBit6CICWcYW8=;
        b=knx/vDdp2ikbYFIZuV4k+QJjodS/ahJZgTZuC6ePrx+RE8wliaRTR0Sv1KWnC4uJP2
         IvJeb4eycDhGl2bNtaS8F6STBD814f+wH3ivLAXA7kfQaJ3PZVwo0OockY8gX6S79GCT
         51yINhH1loU8M9W1VNjkffK7D7ERZKRRAVomA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2F5IK3qZINJFDEk93oe4o+MOz1G8iOkBit6CICWcYW8=;
        b=b1BzezFiSmu1jLbTRYm2prRYYCBbr08JSb7u7a5w42oGDCXwEbusJVCL1w8Ge2ITEX
         fX6tTEk59R2IQjcLKbqyAK3T7efu5FQT+3LtO5yv8qU7YiX97sXDYyNuTTigftdpx6Go
         ngtBiNqfgF/YFRVekyhjQC4PIexu9oOVTHzX6Y7mgIRX42HSscRyxsYQtHZ5EIQOcxp2
         JbjrWIixxDYIai1s/RczhxDpfoSBJhEH/jbDXK0rogXEDjLVLpG0OOR37tT6I4bPtrdQ
         0tfqVM8FAfD+bRc5xKwQtkLGEGOZVC1y/lbttDZsqPKey2ILJq22OsWK2D947hEnTuLB
         CnDw==
X-Gm-Message-State: AOAM533FPesJUrCsCUDCQ93XZqVxSv2QHePVXquUqmDp7adjzzcfBDiy
        G6zMy52XEiKVEVoO2123+v0sl4500uzbMA==
X-Google-Smtp-Source: ABdhPJwnG3zZJKY82hnEz5p5VNCCWg7/+GghC3lXTlEp/0Shd3k2Df2kpKDe8ZEJ5u87sGhTaISprA==
X-Received: by 2002:aa7:9592:0:b029:13e:d13d:a054 with SMTP id z18-20020aa795920000b029013ed13da054mr5286825pfj.26.1599893415956;
        Fri, 11 Sep 2020 23:50:15 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id 131sm4162467pfc.20.2020.09.11.23.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:50:15 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 1/8] adapter: Remove indirect dependency of headers
Date:   Fri, 11 Sep 2020 23:49:59 -0700
Message-Id: <20200911234949.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Given that adapter.h refers symbols from lib/bluetooth.h and lib/sdp.h,
these two headers should be included directly in adapter.h.

Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 src/adapter.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/adapter.h b/src/adapter.h
index f8ac20261..c70a7b0da 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -26,6 +26,9 @@
 #include <dbus/dbus.h>
 #include <glib.h>
 
+#include <lib/bluetooth.h>
+#include <lib/sdp.h>
+
 #define MAX_NAME_LENGTH		248
 
 /* Invalid SSP passkey value used to indicate negative replies */
-- 
2.26.2

