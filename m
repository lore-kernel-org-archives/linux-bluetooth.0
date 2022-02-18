Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13002C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 19:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiBRTqk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:46:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbiBRTqj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 14:46:39 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FF1A343D
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 11:46:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id l9so8003632plg.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 11:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0m45Zhw7zCeDsmXMroAoMl4uUdTXGWfXVtgGbuqoOAI=;
        b=UN+Kn9vnKIB9MqvA+1V5t3YTYSzvCUMhSDkTnOcPGVXcybCMh0Hn8KyOTjYoTXI5F+
         pffeN9y+kfFIyVzHGTwJf4Mqjh1pu/uQENvblhJrX05sYVx5GdDVn/Ehzufek+7DX5cJ
         +6K2Ouw9dMl2G3liXfduxsQBW+cI0RdVRMks2cY491zXgSvjWHQTPeit3ecmjLCCdoGO
         yC4FPjDgMkequHZGtOU1VekTghV9Wylv3FGUIYwEPKyYbEtgBW4S9f6ywVaUsF7ydxmb
         IZvOiWVXh16+0PiqrCpwCf0msaUxk0mTOfsJ6FOV0lbEjKCrasPChAZmJuOm+PzACY2n
         QMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0m45Zhw7zCeDsmXMroAoMl4uUdTXGWfXVtgGbuqoOAI=;
        b=4Cp1zaRAIVpVU85QQwmDwSrB23vBlo/jQ3a3Ibj8XhTDqI0j5XvKbbagl2FF+StBt/
         4ZJFRzhW2h6z7wepZL5CkxoIduVKUeWXXOoluMaIdyBZkIcz2071xdGtSL6SIHJuYhsb
         OtxmnNWea6hK1FqtSYP5cBlHyDWn2TjqIW5qz4sHs7NyfVmr+s+GxmnJbeXUcypTr6Fg
         k74wtifiSF0ioCtyONOBJNTDexZvZ7yU45g/01uoHh5lurUkdQnG+2j2UcjbuKVYmU2j
         Ws4azJIWK3VWgrXmr2stVfX9x1LGFq/u+o7GQNftN5UKfzQgCWOESI+jP0c14fLQ9H6s
         V81A==
X-Gm-Message-State: AOAM533cazZRbaRMJEX1RdTz/NBjvWTNe88bZVSlLiVhgcCUdnw5zksg
        fU3UyOlWtANFRE3UZuQkW4Bl55dmSf4=
X-Google-Smtp-Source: ABdhPJy9547ulEHnXCEjD1dfr0ScnsYvLp1Hwqso9+JeV5YSigh0+hh2CvUke6niEtIy/2ma+KsRcA==
X-Received: by 2002:a17:902:f24a:b0:14d:b2cf:20cc with SMTP id j10-20020a170902f24a00b0014db2cf20ccmr8573653plc.118.1645213578513;
        Fri, 18 Feb 2022 11:46:18 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::55c3])
        by smtp.gmail.com with ESMTPSA id h21sm3782311pfo.12.2022.02.18.11.46.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:46:18 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] gobex: Fix read from pointer after free
Date:   Fri, 18 Feb 2022 11:46:17 -0800
Message-Id: <20220218194617.160812-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch sets the pointer to null after free since the g_free(p)
doesn't set the pointer to NULL.

This is reported by the Coverity.

Fixes: 7e7d826aa1db ("gobex: Print error if data cannot be written")
---
 gobex/gobex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 185eed4d7..e9b89cead 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -471,6 +471,8 @@ encode:
 				check_srm_final(obex,
 						obex->tx_buf[0] & ~FINAL_BIT);
 			pending_pkt_free(p);
+			/* g_free() doesn't set the pointer to NULL */
+			p = NULL;
 		}
 
 		obex->tx_data = len;
-- 
2.25.1

