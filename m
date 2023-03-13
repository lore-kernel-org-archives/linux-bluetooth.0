Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB613C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 22:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCMWwp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 18:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCMWwZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 18:52:25 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840028ABC4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 15:51:59 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b5so5691292iow.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678747916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVhH1FenjO23iPOz9PWDVrqP8gmDYaGiFkkC/dXtHy8=;
        b=KquCkPJDlsj/WXmzP7jhpIGYp/8/L9yMbjBDbiFcghKR7/DDOA5v2HTXT+MGVFSktF
         vFIDJMLQkMXzHEYODZt7WcV871KQeE6ApdZ68J3Eu4SvsAaoJ/rkOqGyEPlbP6pSPAfD
         ORSzcuwgu2mn8MDeOZ/ihGSX5cBwTwxPVSLkeaSUMHIKA2wTKje8eolzjk8fbrDRqk/G
         8xaNmaoSKPnHJoHvVyk3VKVB9lIIoXU2dlbM1KcW+fEsSaHPeK2MxMk3V/XnkhuIIxUG
         UTud0o53VZs4lGO4cALUt5mPLr9XHTHTHUxAz8rDeyvKXtTFOPGnceR3qdSTvx2AtK0q
         zw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVhH1FenjO23iPOz9PWDVrqP8gmDYaGiFkkC/dXtHy8=;
        b=t3Ws7RST31ZwJldJ4KgX9WULhb0E5Tkj2YAf77OSR9AXKuC+KxReT6YePeTOB/rp23
         a5QvXxqkmyaXak7qeftX8v7U9FnXQaNXOny69N9K4FjdzpMXhJBP8pHEy92sMy7KYimU
         2uzafTsENTnYzDZUJxSYDMbYHQGjlvxO3ZZcGQ0tulbPt5QCJERPFyPIycl8Jwjk0bwf
         XLvFsZ+vyW3P6NTd1SyEBC1GpDazg+4PbEpPrxJxy1JMsobGyUI8Fw/TH917dC0VXptZ
         T5HDIljumm0D8dVGuMH5G+RrJ0rx0z6X7/GbJ3pNPXWQjs9k1uhCuRJoRrgVuRq5UJD4
         WI8Q==
X-Gm-Message-State: AO0yUKWOUylE1vbN6NA0tzkGMGN84Vxcj7ziTHJLbekOCYXjC26gWZtM
        Sfxx4ZcXwAVr+KiD/jrHUqCYIJMMo6M=
X-Google-Smtp-Source: AK7set+jlnOXigurCT1Pbsxl+6n373Ovol4FGrnl6vuaLoBEp2eG5GS1sY+EPnLE7OFU6CUMGxGQUQ==
X-Received: by 2002:a5d:889a:0:b0:713:7b7c:46d7 with SMTP id d26-20020a5d889a000000b007137b7c46d7mr10208556ioo.21.1678747916388;
        Mon, 13 Mar 2023 15:51:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id m17-20020a02cdd1000000b003c4d71489aasm278318jap.6.2023.03.13.15.51.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:51:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] shared/csip: Fix crash on bt_csip_get_sirk
Date:   Mon, 13 Mar 2023 15:51:50 -0700
Message-Id: <20230313225150.267896-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313225150.267896-1-luiz.dentz@gmail.com>
References: <20230313225150.267896-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following trace:

Invalid read of size 1
   at 0x1F4282: bt_csip_get_sirk (csip.c:812)
   by 0x176B21: csip_ready (csip.c:259)
   by 0x1F3C74: csip_notify_ready (csip.c:578)
   by 0x1F3C74: csip_idle (csip.c:659)
   by 0x1DCDCC: idle_notify (gatt-client.c:171)
   by 0x1D579A: queue_remove_if (queue.c:279)
   by 0x1D584F: queue_remove_all (queue.c:321)
   by 0x1E036F: notify_client_idle (gatt-client.c:180)
   by 0x1E036F: request_unref (gatt-client.c:199)
   by 0x1DC60D: destroy_att_send_op (att.c:211)
   by 0x1DC60D: handle_rsp (att.c:874)
   by 0x1DC60D: can_read_data (att.c:1064)
   by 0x1F43F4: watch_callback (io-glib.c:157)
   by 0x48BBC7E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7400.6)
   by 0x4912117: ??? (in /usr/lib64/libglib-2.0.so.0.7400.6)
   by 0x48BB24E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.7400.6)
 Address 0x0 is not stack'd, malloc'd or (recently) free'd
---
 src/shared/csip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index 094f448a3532..7e90a3c97614 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -810,6 +810,9 @@ bool bt_csip_get_sirk(struct bt_csip *csip, uint8_t *type,
 	if (!csis)
 		return false;
 
+	if (!csis->sirk_val)
+		return false;
+
 	if (type)
 		*type = csis->sirk_val->type;
 
-- 
2.39.2

