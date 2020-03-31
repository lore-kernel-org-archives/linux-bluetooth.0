Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D2EC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E068520B1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="qv4McKkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgCaIah (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:30:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56212 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgCaIah (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 04:30:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id r16so1469518wmg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDWh3DZ5NCFsjNdxv0kUkXCUq+AttxLWLiBeX4JFPTE=;
        b=qv4McKkwK5PQMfLWDE2zzjxi5ghnL5CXdgFrmjcemBo7aFjAO9wmxSJkZIB2LT6s2c
         z4Buzuyj1jdnrOF9xJAaCk8rzBls/zYP7LM9V5NYeocUfiwSn1kUV+32TQKahLzjSX8j
         zQj5zJ9XIFpiV6brwXy9soW6hqcPYb5YKuE1dxi9cVd6ZBntijcNZjgSrX/lpBwyat7d
         K1vV/GSqR0ZJQhgL6IK7rVbbFu1ZmnwusTPdm1qXNSVqU34HGBCXqsSoFVSGZy1wwESg
         GXt79qhnGWQMpYAvohE7wwHjjmkcn2l5CsSMbxZSdcnj+4kc9IsXiVta03h+5nV67pFU
         8xJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDWh3DZ5NCFsjNdxv0kUkXCUq+AttxLWLiBeX4JFPTE=;
        b=iKwyRPQ0Cxvp/wDc0V4fvGU2JNdNhOtDxz9wdX5J+GT38sYh4qbb2JJmeLywhTfuVU
         KL71azZrfKDLcEdeztKuLujvUu9K6z2t9YheP8vPCa/lwJU7lyc4IKSr0H/z9O8QRLOu
         Pn1jYYHHG1hBLdAm1bK64XNsXiGNETyoV3L1bns73ozC5SOWnc9Ft6xilwuI1eL2sRZI
         64mW6ZFMfe7ljw3/dPhN+wRlI/St9a1Wip05bJgTsv4KoPInzDJ8qgIPmjPwPkUTLmI3
         u4boBY7QlXlRfeaBjJTht85UWi2VoY6cz9dPzDV2Z1UEf3s1FdODn7nq+zVmKvyXN+jp
         RKiQ==
X-Gm-Message-State: ANhLgQ0TReFA0TiE1L4WLRSP0SzvM9kt0o8uHZkT87B+qY0s19tGIkgH
        /auv5Zu8KGhU4u0j5O1gnQCY4Jpe8HLCvg==
X-Google-Smtp-Source: ADFU+vtsFDzjWcc3lSLAkxs9cBMdnekyjb4YqsNvuv+QyyvOv1e+BHNa7ZPgvqmhqUCuj/Sauyxcfg==
X-Received: by 2002:a1c:e30b:: with SMTP id a11mr2124151wmh.7.1585643433330;
        Tue, 31 Mar 2020 01:30:33 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d7sm11206529wrr.77.2020.03.31.01.30.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:30:32 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ]  SG-311: Fix FPE in overcommit logic.
Date:   Tue, 31 Mar 2020 10:30:41 +0200
Message-Id: <20200331083041.13108-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During overcommit, mesh_config_save is called in asynchronous mode to
avoid blocking Send() calls. This means that update of cfg->write_time
is scheduled via l_idle_oneshot, so if the next Send() gets scheduled
first, the code may see elapsed time of zero.

If this happens, then the overcommit logic was already executed and the
overcommit is pending, so we can just return.
---
 mesh/mesh-config-json.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index ad2d4d0f8..21f2cfc37 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -2014,6 +2014,12 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 		timersub(&now, &cfg->write_time, &elapsed);
 		elapsed_ms = elapsed.tv_sec * 1000 + elapsed.tv_usec / 1000;
 
+		/* If time since last write is zero, this means that
+		 * idle_save_config is already pending, so we don't need to do
+		 * anything. */
+		if (!elapsed_ms)
+			return true;
+
 		cached = seq + (seq - cfg->write_seq) *
 					1000 * MIN_SEQ_CACHE_TIME / elapsed_ms;
 
-- 
2.20.1

