Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE6AC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 18:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A1E61244
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 18:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbhERSlC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 14:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbhERSlB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 14:41:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AED8C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 11:39:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 22so7683690pfv.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ot0DntzaYSgGQ31gvBNcBTx9/HZZ2Rd8zN+tqeN2Iog=;
        b=vbPmK5cDMIp93aeZEvkUJ7Agd0tUGp8tb1CdglL7JOjGLJzcewLxRPIohquU0CF0lC
         bny9ooRjQjqF9dL24dkULDQyerAW19QYG6SQboiZ4wt6nUSpI0MsfZXAUeZyNYbZ/4Eh
         KCb64mGh0dRCLlEhs37/EHLZPW+AXFO9tGeKCAJwLKOBJaxy2hV+0WruzCjrAiqWW04G
         m2g0IEqNJSyTDmt/ryaYHHo+9K9waGiUofurmKoCPn0rOCFxRdkjQ8qO5fuVY9ZVKbaf
         5xHGu+1Vh+8PzpG0HshDOP2/pHd4HwZ1sgon1qBaz/faQq/zN/C61RzqwUIJt9tsDKiL
         fNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ot0DntzaYSgGQ31gvBNcBTx9/HZZ2Rd8zN+tqeN2Iog=;
        b=p+Z8dFGuzUJLyeoPpibjyf6qLadUp4wNHFYRsv1bEMZc8z/AK2u7ReHMY7VFjwKU6j
         FxIrw7vNkWU7Bbsh7fGs9pb2ShWPAgQZ9F1mC5X7Gsg2hPk3dhOCGTKqcaqgUFXuNTrg
         OLrAmkIDhUwb6bwB/j1lbbZpoP6K9C7E8szBUaHazOZqIySE9gpEp9BAM1f8O+i4s59w
         gMi+SMkGkP/mr62I/FiwF1NBIsL3MDsam73E/G2nhPUUpebS2ApC2R1LOZqi8xFDtEJO
         +Wxvku7QBU0fMUNjX4dbohbwlIUMS+Yhm51JDPHsOF0x+gzkJMMIxdlmtoLzaP+P4kIo
         D0TQ==
X-Gm-Message-State: AOAM5330lr1tJjzKGxABaaQNK27plXQiMazQn614gzO+Y8z49jVnmN3G
        8z1u6eeljhNMQUGvv5sJOnsx4WkX3Yg=
X-Google-Smtp-Source: ABdhPJywqU0NOufHecBIAh6wI3JKTpxg+jP5qacci1JO0pZkCMLKChMJSj5G/dLzWGV7iNt8yTSRrQ==
X-Received: by 2002:a62:ac1a:0:b029:2db:7c55:7f4 with SMTP id v26-20020a62ac1a0000b02902db7c5507f4mr6462000pfe.26.1621363180840;
        Tue, 18 May 2021 11:39:40 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r22sm13157121pgr.1.2021.05.18.11.39.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:39:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared/util: Add bt_uuid128_to_str
Date:   Tue, 18 May 2021 11:39:35 -0700
Message-Id: <20210518183937.786605-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_uuid128_to_str which can be used to convert UUID 128 bit
binary format into string.
---
 src/shared/util.c | 12 ++++++++++++
 src/shared/util.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 9c2054211..7fb1c01dc 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1042,6 +1042,18 @@ const char *bt_uuid32_to_str(uint32_t uuid)
 	return "Unknown";
 }
 
+const char *bt_uuid128_to_str(const uint8_t uuid[16])
+{
+	char uuidstr[37];
+
+	sprintf(uuidstr, "%8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
+				get_le32(&uuid[12]), get_le16(&uuid[10]),
+				get_le16(&uuid[8]), get_le16(&uuid[6]),
+				get_le32(&uuid[2]), get_le16(&uuid[0]));
+
+	return bt_uuidstr_to_str(uuidstr);
+}
+
 const char *bt_uuidstr_to_str(const char *uuid)
 {
 	uint32_t val;
diff --git a/src/shared/util.h b/src/shared/util.h
index d6de55885..9920b7f76 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -107,6 +107,7 @@ void util_clear_uid(unsigned int *bitmap, uint8_t id);
 
 const char *bt_uuid16_to_str(uint16_t uuid);
 const char *bt_uuid32_to_str(uint32_t uuid);
+const char *bt_uuid128_to_str(const uint8_t uuid[16]);
 const char *bt_uuidstr_to_str(const char *uuid);
 const char *bt_appear_to_str(uint16_t appearance);
 
-- 
2.30.2

