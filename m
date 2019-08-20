Return-Path: <SRS0=V5YL=WQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9026C3A589
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Aug 2019 07:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE6823A43
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Aug 2019 07:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="HONDMr9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfHTH7B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:59:01 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36091 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfHTH7B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Aug 2019 03:59:01 -0400
Received: by mail-wm1-f52.google.com with SMTP id g67so1755020wme.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2019 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hE1OSvPT++HS4cvs1fyow4uSf63tSRBmAEiCoUOh84o=;
        b=HONDMr9lGAbYHarE+ar4CxrUp9hIaVFWy/sdPAUlc1A8pgCYb0o1r3Eyc6lk5tbIeu
         zQhUpZqG7TCa6iRxBV3/uQaIQD7Q7UL/hFtxkipkBwUahf4wZ9FJIzun2xBcs7gzGVel
         M/TJzkIqmOkcUtNvOjRm44BuSx9BwBB+sK2skRicZmP7Kbhl+K4NuGMw99oPJmG7Bt1A
         FXOP4Znq+SN2+bAJ+PdAkWRzZvV55555X7Dz/IUmB77ryb7Oh3sXDHRLofqyLGp9ZYYL
         LOmet8UcW1Fj8fvvgQKV+NPVob2z067qVkqTeX2STHCRmxFaBIMDsN6wBsI4xTy7fMUW
         m+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hE1OSvPT++HS4cvs1fyow4uSf63tSRBmAEiCoUOh84o=;
        b=ZFhv/BcGXnL3OptIn1h4aJHxODYjBqlYtH0ymYaGmvOUjhfvzavVT69P0X9rdADu/T
         fN/o7bQwXWcFyLSkEKRWb/gZ8UBZrAzTTgn03GDO18Kewfz3Dd9EnrPkyJrFucG7rMQu
         3p4Xl+Ldd1FpI71bQoVPFkOer4FfPDto3yaTpCyJGJG01n+caa+a7yXy+ylsvVvKt2mP
         3TU+UNGDzQV+LqpYL8FNkTSHTVDdJ47OYpMfBljrVcjQW6IS1Z8Nt0Gy2l4ZOv6PZPkI
         qFzKdHDjhTHAwnkCXMIH6GERIgkEqfCQQDSe+wxNkFmKVOY4FD7+mw/fPf1k1YIp+jm3
         gLfw==
X-Gm-Message-State: APjAAAWWG6+HPXrr7DM7i0AMMo5G4aQcyjnxcWewz2Jlv+sGsfliWtti
        KimDoYWkOdcnTNof4meDGbjMxX+71no=
X-Google-Smtp-Source: APXvYqwAjJIUNS8j/zZ3+XoyK1yMzb/wd9xes653INWG9HsWxtg0D5eFVvvfaxr0ikqKeIBf0O4WnQ==
X-Received: by 2002:a1c:f016:: with SMTP id a22mr20895752wmb.170.1566287938575;
        Tue, 20 Aug 2019 00:58:58 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v12sm18039321wrr.87.2019.08.20.00.58.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:58:58 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Show error message when io initialization fails
Date:   Tue, 20 Aug 2019 09:58:52 +0200
Message-Id: <20190820075852.2932-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-io-generic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index cc91f494e..42bf64a0b 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -21,6 +21,8 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+#include <string.h>
 #include <sys/time.h>
 #include <ell/ell.h>
 
@@ -285,7 +287,8 @@ static bool hci_init(struct mesh_io *io)
 {
 	io->pvt->hci = bt_hci_new_user_channel(io->pvt->index);
 	if (!io->pvt->hci) {
-		l_error("Failed to start mesh io (hci %u)", io->pvt->index);
+		l_error("Failed to start mesh io (hci %u): %s", io->pvt->index,
+							strerror(errno));
 		return false;
 	}
 
-- 
2.19.1

