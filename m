Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF98C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 21:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387737AbiEBVsu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387723AbiEBVst (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 17:48:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E2665D0
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 14:45:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso475675pjj.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 May 2022 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=puHV4lHEPhBIF6BxH6MHgxYktSpGEnV7iPsNgsNSU6w=;
        b=AWP0OogXqdK35ZkpWHYmAsukjYI+Z4/6F3zfR74K49iyC5Rmldt5IR8890ggkCT2O9
         5KXmfILmHcQAP/XHKfSE7S2BxJXafv5jqjKOpwzgthVxsB1sxa0Db4pDQ1FIFVS9zH1f
         z5qPvanzftdwyBsWG/XeZWoNfunDKWBEMDM4YlgCcZvFEs0NzEhb2ZJAf6CaX20VLC/2
         kzWZUWmqxFbqHbIBcdrQKblCFu3d4nhbHO3aXUCGIYVZei92LIYoOj3svIlAeQ/wlCnn
         GEak7T5cQiMasyTvCZBd9Fs95vRN0CvlJly48Rgpu9FWw4OLyoMKp2lgLztqEvYax1hw
         voTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=puHV4lHEPhBIF6BxH6MHgxYktSpGEnV7iPsNgsNSU6w=;
        b=E/gtUxVMRcNvyN9jIvOSHZda9Y8AhWu0jpMDf5uxxkIre75smt6lhoIoH6ZDQCu3Lo
         OpIOFjPgpHvjjqK+wtCvv7aDwKD3lTziRMfDhdXbRzvdzUkfMJ07jINwTPFLaqEjNAAZ
         o/BUVc8DNC5jfwVnK1AOpH/iXrffAg2aHo1JzMdOdYzKa9Tjs6m2l/Er3qc5Frwb+3nD
         TrqwSIrKh1qM8cJR7Q09GfGiGy6D/VxwVDt3XjVUTG1SKr2Cq06GyYEeQlwtGPOnobCs
         gJLCt2XSn1yXMyM/HrbsjPy+yV2ezD36YECGjwLFJLaVb1wKp4RibXc3/LAm0esBX9Bh
         1RHw==
X-Gm-Message-State: AOAM532aXQCF4zulQwi6zME7BLiP042j35uVNAhl+QHpfO1REG1QpJ1u
        4z0zUrRX6nZ8MPUvLrpzW0re+N4jKwY=
X-Google-Smtp-Source: ABdhPJw1ODovcDbCVGkHhsQQM862VDwL9g5zh3tJ3NAF056J9f1w0KwxhcG2vPeS2s09nGv1Ut3bFw==
X-Received: by 2002:a17:902:ab59:b0:15c:f4f3:7e3b with SMTP id ij25-20020a170902ab5900b0015cf4f37e3bmr13970428plb.24.1651527918802;
        Mon, 02 May 2022 14:45:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709027d8500b0015e8d4eb2aasm5090282plm.244.2022.05.02.14.45.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:45:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Fix parsing of LE Terminate BIG Complete event
Date:   Mon,  2 May 2022 14:45:17 -0700
Message-Id: <20220502214517.2363950-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

LE Terminate BIG Complete event format Subevent_Code, BIG_Handle and
Reason but the last two were swapped.
---
 monitor/bt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 644c97c98..7aa016a0e 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3649,8 +3649,8 @@ struct bt_hci_evt_le_big_complete {
 
 #define BT_HCI_EVT_LE_BIG_TERMINATE		0x1c
 struct bt_hci_evt_le_big_terminate {
-	uint8_t  reason;
 	uint8_t  handle;
+	uint8_t  reason;
 } __attribute__ ((packed));
 
 #define BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED	0x1d
-- 
2.35.1

