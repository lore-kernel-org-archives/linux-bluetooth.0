Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC058C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 01:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiENBmN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 21:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiENBmL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 21:42:11 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173C3ACA2F
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:46:25 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id n6so6773960ili.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3DZNAkRxrKZ2IrtkklqnnZvSJg+0ZftVA00mm61Dk4k=;
        b=oXQhp9Vk6coiHKOaQbcWt0MLHOhvkkF5KVA3WGBeqWnjAsmUSmw2OShQueiyySUKyX
         UblFT99sQ835Fd5xV4ORGrJ7+BBtPjyoIuHKzNyZ0787nyHg6wIWac/oQ32w61Ea3xms
         pKkCT7RoUvXPo8LVSYsQ1jD3FxhPZbJIm74dUnKR3UJdmCbl9mDnr1rw8GFnxJRTWPkN
         Nj69Zsc6ysk+MY6TK2X7aEq1B0v0WRZOOsyt4wDqTT59Dtta1ahzvC2mJw/VlMXUO+25
         t8aUAxf5ifE5YQvO7VLX2E8Az9bLBiucAq+CE0/qJQltm1LZspzHeI6OFbm9rXBR7SA7
         JNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DZNAkRxrKZ2IrtkklqnnZvSJg+0ZftVA00mm61Dk4k=;
        b=h2pr8kQ/vMX7fdLA9wxhE4LsTruDPyBCVc/RNtP4ZRwJ4gHxFQwc99dGN8DzPvxmAn
         lG/qWD8Rbnfjw7d2ZJOnKsoJfmfm7XZKs7mCh6fco8ZKZVLwBrhdwdF6bTVP9gbHtAte
         ubuAkZpPWKXlILrU8rcYD+zF95eiXD8XX238qJgzddnWEKlf9apCKGS0He7cCqwyAmaL
         tBicN76CwtYbE4hIVw232Jl6hJunJ6kKuW/s5E+4tKqjHs6sv60NZT0/AGOAT3BzMPhc
         pV1WJBwi+RxRMgSW3tJDIEeEC3tIJfzeP8LKSbpt9FKXDnVQ9cNmq2RVgaFtXQfYEdpi
         Wk5A==
X-Gm-Message-State: AOAM533rCG8IzpwAZv6MLsQHimeAcN5EWaWEMo5ozlRbXGs/RSghboWe
        Cb/yhBqbdnhjTLfnQ1yuiyDD5ggEeqM=
X-Google-Smtp-Source: ABdhPJzA2Bi/hVOFBEA0UCyuNmamX3O//YmM9Cwiki3EAfaPVdH1SLpQoK4qh768stI8TSiOjQEgtw==
X-Received: by 2002:a92:d708:0:b0:2d0:ecd5:894c with SMTP id m8-20020a92d708000000b002d0ecd5894cmr3552488iln.201.1652485575714;
        Fri, 13 May 2022 16:46:15 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k9-20020a02cb49000000b0032b3a78178fsm1045203jap.83.2022.05.13.16.46.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:46:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Use bt_status to convert from errno
Date:   Fri, 13 May 2022 16:46:10 -0700
Message-Id: <20220513234611.1360704-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513234611.1360704-1-luiz.dentz@gmail.com>
References: <20220513234611.1360704-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a command cannot be sent or there is a internal error an errno maybe
set instead of a command status.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 882a7df13005..4a5193499b77 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -946,7 +946,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	if (!conn)
 		goto done;
 
-	hci_le_conn_failed(conn, err);
+	hci_le_conn_failed(conn, bt_status(err));
 
 done:
 	hci_dev_unlock(hdev);
-- 
2.35.1

