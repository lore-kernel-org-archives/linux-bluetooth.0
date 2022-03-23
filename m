Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807CAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbiCWWlq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345303AbiCWWln (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:41:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE41C381BB
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x2so2950502plm.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JQd7+rMFUQKBJW1Dugx9ash6Vc9jS9PWkT5mnwXt32w=;
        b=gtej16MkQjFGX5FckYPmI080fHE6CeM9NNAGeixVVCl/YZg263RMZbU77w4P856Bbl
         GUCpQCGPgC0z4uTEgT6RMVNf4WBWCt5JThI7+uYOdXYeGxv5Cq4q06PvRcVDG57dYF3q
         qnh9fduFop+392SO0/HKIIPHDbaybdii6rSsIhrGfrvZC+gc+yaoBuamE7ZY3P7X8XU2
         dfEoRgSMcyx1/ts2DegyDyHV5cU335JxOLgCqoIZCgc87Vun4b32wKf+1HRINQ0h+4p+
         jEtv94QDRjc5oIsuk/h+yiEwrIdxsxvc3qbZyhP72jFg3jrvoOO0mSSwESK8/FMZCFFa
         mwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQd7+rMFUQKBJW1Dugx9ash6Vc9jS9PWkT5mnwXt32w=;
        b=hVqsBeh+LlYsqs9K3tFaLgH6rCMxqiiQfLJRHzheWpius105/Mwqdu9l0hofj9rEYx
         hwS/FIVVKUwNVjgUOgFJYhkrpuUF4v/OuoNLoIF0FVWM7tkKBDyGYiUwM2trksljb+NC
         mbHiD0e1e99fBLphHbddVKAHVHwIajpl1WU1ysWBLFrd/CLdiq7NioLmiVv3P+YMDdLP
         jpLz9MgFXNdxm3OaFCjsfvKaOo30Y9PDMGquBT2XMpwEKnZMydxnlQVAZFNbt44ygcok
         3q+Bl30knNceEbs8YZfkAVZCqeaOMpvB8kK5tweAHjBVpArWuo420Hwk+lhtFIe8GYZB
         26jw==
X-Gm-Message-State: AOAM530sbcMIoFVQdbKrvzx44TFzrqbbzURHEIn0EWcTKWiQMLM5UmKl
        ylKiAote/CN/IqxlSJK+JQ5nRpJLbPU=
X-Google-Smtp-Source: ABdhPJxxi7886NMnYfVShPLU/jGsEd6fwqbNOzbfGYga6KmlvTw7Cu9HFjUAks4P4dGpJfwheCBY1A==
X-Received: by 2002:a17:902:9a46:b0:14e:ea0f:28cf with SMTP id x6-20020a1709029a4600b0014eea0f28cfmr2405179plv.43.1648075211259;
        Wed, 23 Mar 2022 15:40:11 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm825109pfe.139.2022.03.23.15.40.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:40:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 9/9] device: Don't use DBG in gatt_debug
Date:   Wed, 23 Mar 2022 15:40:03 -0700
Message-Id: <20220323224003.3736525-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323224003.3736525-1-luiz.dentz@gmail.com>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt_debug callback is used to print debug strings from bt_att which
includes the file and function names so using DBG would add yet another
set of file and function prefixes which makes the logs confusing.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 3992f9a0c..381faf91c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5545,7 +5545,7 @@ static void gatt_client_service_changed(uint16_t start_handle,
 
 static void gatt_debug(const char *str, void *user_data)
 {
-	DBG("%s", str);
+	DBG_IDX(0xffff, "%s", str);
 }
 
 static void gatt_client_init(struct btd_device *device)
-- 
2.35.1

