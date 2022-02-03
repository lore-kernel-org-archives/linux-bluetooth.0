Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CF9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 14:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiBCOiU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiBCOiS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 09:38:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE3EC061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 06:38:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z19so6332015lfq.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKaOL99AppxIlUmz5y1c380KiANg85e4PBvl5D7gEzE=;
        b=AHMfG9kZR/w4r0DOic9IbCFc1huMbhApy/RthiCInoQH3cHTUcyfo6skQzx9Ba1iD0
         5a+0UqvdqWE5MM1exlnNxiRPI/mcm0WDSeJI5YgWi9DNqvEWB2NVp8sf4UE8XdFpIVZ7
         PF/cuJ1/6aysnt4JsqlGu1nddtFUsnh/xWoOZDxoDmusewKRICu6ZgmvQO4f4S/tK5u4
         wiPbyGH6TG8ReV+E6l+Rc2Has+Hk3YAUvqTTetVEbS2BFE5Z2klgfWC+QsexEnLGhAzh
         pOlk2e+0/Kcuc4wTNwqBPEGWHuIznTLjYvIeKt63T9O3A5B//QDZNPIMCgyYgJdbvi8v
         Yr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKaOL99AppxIlUmz5y1c380KiANg85e4PBvl5D7gEzE=;
        b=XYD+fFLn9KUQ7i7Doa4oznSyozHgrhJW7fl4FzCjErHNL0bw0jgLgOx07o22SKNfVj
         6ck0pQEUD+uXLqv0JG2ZBr8kFMljazafHTW+fz3KkxdlVfUk8BbBgRLIJPgQw3y/Iz8V
         721MZjQtDdTSVsJ8qPA1Xcd6FY9Yf8IsGXvISJRc5/1SRyqKDYTmaOuEjO2QJ2CZbGW+
         gyCYf/jL3ejPZbUZWfnBXxOYY2IHH39jxQIcV2vjmRwNLRDE3QsRmLQs1gI0c6xyW+Lf
         FVCCMawbtgxp3cMLwy0oZp7c+hfIEzI9CX7X7+rLo0fko6cQZFSMxFRZRI1DAc8Ro05d
         oPNQ==
X-Gm-Message-State: AOAM530qzEypQRbtm6SMTgJXB3ExLDE6Z1jlpo6Vw/mW7ftkZ67Qitmp
        Idr+5BZr33DOirSRJBOTSs0Mi1ztwc57IPPN
X-Google-Smtp-Source: ABdhPJyRTQHqniNWEoGUKt6zzj5RABo5IEcu8Ty/2EObfsBg6igDGNXloPObAMIeARsNbTbl0DelGQ==
X-Received: by 2002:ac2:4e84:: with SMTP id o4mr27799590lfr.460.1643899096905;
        Thu, 03 Feb 2022 06:38:16 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id e7sm4657021lfc.64.2022.02.03.06.38.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:38:16 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Skip unneeded logs
Date:   Thu,  3 Feb 2022 15:38:00 +0100
Message-Id: <20220203143800.746093-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/keyring.c | 2 +-
 mesh/rpl.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index b44091154..d81e5e412 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -207,7 +207,7 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, dev_key_dir);
 
-	if (mkdir(key_file, 0755) != 0)
+	if (mkdir(key_file, 0755) != 0 && errno != EEXIST)
 		l_error("Failed to create dir(%d): %s", errno, key_file);
 
 	for (i = 0; i < count; i++) {
diff --git a/mesh/rpl.c b/mesh/rpl.c
index 6bb3532b2..1213ee66e 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -80,7 +80,7 @@ bool rpl_put_entry(struct mesh_node *node, uint16_t src, uint32_t iv_index,
 	iv_index--;
 	snprintf(src_file, PATH_MAX, "%s%s/%8.8x/%4.4x", node_path, rpl_dir,
 								iv_index, src);
-	if (remove(src_file) < 0)
+	if (remove(src_file) < 0 && errno != ENOENT)
 		l_error("Failed to remove(%d): %s", errno, src_file);
 
 	return result;
-- 
2.25.1

