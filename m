Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964E2C54EBD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Jan 2023 23:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjALXVb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Jan 2023 18:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjALXV3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Jan 2023 18:21:29 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE626147C
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 15:21:28 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso11421902oto.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH1jB2ACJ5fP7hG9Jn/Wvk9MeHbVLm6lmEmwmLcdcys=;
        b=Pczet5Lus6POaGn1Ew7RANWCjDkkxGiy56U020JYjf9FR9j1kqoEsX8TZ7692cUTaM
         0z/vrrd5NOCVDdDZ7pfMeZgNxWVI8zSYdnMxGKg470LbGlSUURpmrePUXdS2+0P0EOBg
         wMXzkZ741p9hxXa53aArCHAIK2TpDd+v3hklBhOiUjKjICAKoYE7RmDk8/gA8zACPx7b
         PflkorEwWiReYGiq/NJ3jiK4qr/tXx4cPgLk2V2z5gwk8p/L9CXnfyR8NRUKO38GObUs
         +8O1dmfwQAuC74GqgPxeaInSewJxjZpvyih92MaMOOUbJ8TEarzKSUng4aq0k5S7ySKs
         EQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PH1jB2ACJ5fP7hG9Jn/Wvk9MeHbVLm6lmEmwmLcdcys=;
        b=GwTuEktV9yZL4YwU2+iBn0DhiGlIbsbTiIz8mf5zAFEIcUQjhflx/NZup0A85rh7O+
         pTIgn6JIT2IMVPiEptbvcQFd1XkG7Y2TljdiBDmwIBFDimfbDxkps24S2JhZQlsKv9V3
         3iW6LbaZtEF8oky8K2S91mGgQbWhM0b/eBFz4EOM0OJOOFP2zWfxwO+SKYDO8ycPdMzI
         /Gi4ilAUX0+MTFQdxFGv9/pIvRiD8Tp9R/xpzylbbQthsnJKGmjKloeKqyCyBExZMoea
         bHDPN+585+17ZR3GOlIm8hQsoTg/U6IzhJukIL0Fn/7uvN0F+tDgAiy7Wumsqv5T761y
         DcvA==
X-Gm-Message-State: AFqh2kq4JpDz5ejlxOcC6Il0KOaSE10ovjENMsUAUsr/kKuieDNfmltA
        pqZGyQ0mjII9eYzpR4qkVnPop1k+FIw=
X-Google-Smtp-Source: AMrXdXu19S0f49Lmaou2fXyZ6BBAX+peJ7ZRmB8BdOQPgMgk32HeipU7jfM3Eycu9UI4T9qFU9sE9Q==
X-Received: by 2002:a05:6830:1152:b0:677:a9e7:dee7 with SMTP id x18-20020a056830115200b00677a9e7dee7mr42349838otq.15.1673565688078;
        Thu, 12 Jan 2023 15:21:28 -0800 (PST)
Received: from EDP-LAB-JQIAN2.PD.CalAmpCorp.com ([69.110.165.186])
        by smtp.gmail.com with ESMTPSA id k22-20020a056830169600b00684c7de281fsm1028827otr.6.2023.01.12.15.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:21:27 -0800 (PST)
From:   Jing Qian <jingq77@gmail.com>
X-Google-Original-From: Jing Qian <jqian@calamp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jing Qian <jqian@calamp.com>
Subject: [PATCH BlueZ 1/1] hcidump:fix array boundary issue le_meta_ev_dump()
Date:   Thu, 12 Jan 2023 17:21:11 -0600
Message-Id: <20230112232112.212021-2-jqian@calamp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112232112.212021-1-jqian@calamp.com>
References: <20230112232112.212021-1-jqian@calamp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

le_meta_ev_dump() print array content without checking index boundary.
hcidump would crash if the event index is out-of-boundary
---
 tools/parser/hci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index db7d32c011b9..30feafaed36c 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -3657,7 +3657,11 @@ static inline void le_meta_ev_dump(int level, struct frame *frm)
 	frm->len -= EVT_LE_META_EVENT_SIZE;
 
 	p_indent(level, frm);
-	printf("%s\n", ev_le_meta_str[subevent]);
+	if (subevent <= LE_EV_NUM) {
+		printf("%s\n", ev_le_meta_str[subevent]);
+	} else {
+		printf("Undefined--> %d\n", subevent);
+	}
 
 	switch (mevt->subevent) {
 	case EVT_LE_CONN_COMPLETE:
-- 
2.25.1

