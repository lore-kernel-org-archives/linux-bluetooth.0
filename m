Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5122C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A92220657
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG8G5EFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgESUZY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 16:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESUZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 16:25:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9001CC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:25:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f6so365935pgm.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+Bzf40guqOxD9K2dyA9WhKKtNzznnTmwoNHb0gJSwjw=;
        b=XG8G5EFXwmUpOyRlNjM0abVyAvy7djt3dKplcVxpaThr7R+1hRDSOtqdHG2BbXhLYQ
         fnV8xAUdfXrM4CXzzvXy1TffqP1yqpdHS/mVwqqzqsRm4yWXe/c5UDTr+WRfHgaWR/y9
         1rjA1+Rj80S3oI01JEPJeLXtxTAGptI7h6foRMxssH2Twlc6bc0Cao4uibcEk+U5q9V0
         s1FSJReNUJg/4hzAPSb3zp5Km40BO/s1tBBvrhZxIDh3cR7KwnxFvSepH6HyBwdtU60T
         RuZOe/mBWNhM+tvGMMBjvxZO3GdcMt6ErO0QWdmQ/qXghb1ullfPxqA9jlvi6RBYnAIT
         FRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Bzf40guqOxD9K2dyA9WhKKtNzznnTmwoNHb0gJSwjw=;
        b=bIeMW4zkzIlCwgzerVIusrg1hK/4Oo/LNKYBTnBBCQbjdyXrK/Vp7OAUxfXjQtnqSr
         SSlkaRuNCWYClahu8x7cZMDMH5dfS8fYzuVQtAmLl16EOaHJ8EfNjABr/KyjPiFy7Ybw
         o4Bq0tGlcDOxfzgFHFABCith0EjdgPNpIXV//TLd7rjjI+Oz/bo3frLlOJabHm4EsAnR
         ANXlfrF73ed+4Aj40qIzrIQ0nk1e/oQ3siPvcPSS8QuWUEuQ4UpIqRE1PphubMsFA1GG
         iqnnl4yO0y1H0tOkCMXpDyQlAX2t7aGy44tBgyLoZFCQULRMNtUWjrB+LylieyQTqz+T
         wepw==
X-Gm-Message-State: AOAM532moN6iJyBtQ1gRM+CBJuSGvSFiyQHpMgtpqkJGFx2DpHJcn3x1
        BPWKHQouhpTl2IOm6co7CrosFmzB
X-Google-Smtp-Source: ABdhPJxV6elJ1PUgh/RpBRdpMmJd5vXfaGW9iFBPSAmx3DZoL8P3XFqPV5EwSxDysWURDXoc+CDlNw==
X-Received: by 2002:a63:5465:: with SMTP id e37mr784931pgm.300.1589919922773;
        Tue, 19 May 2020 13:25:22 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c184sm298808pfc.57.2020.05.19.13.25.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:25:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Fix assuming EIR flags can result in SSP authentication
Date:   Tue, 19 May 2020 13:25:17 -0700
Message-Id: <20200519202519.219335-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200519202519.219335-1-luiz.dentz@gmail.com>
References: <20200519202519.219335-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

EIR flags should just hint if SSP may be supported but we shall verify
this with use of the actual features as the SSP bits may be disabled in
the lower layers which would result in legacy authentication to be
used.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0c1cae83c8dc..6b2288d97ab7 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -225,8 +225,6 @@ static void hci_acl_create_connection(struct hci_conn *conn)
 		}
 
 		memcpy(conn->dev_class, ie->data.dev_class, 3);
-		if (ie->data.ssp_mode > 0)
-			set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
 	}
 
 	cp.pkt_type = cpu_to_le16(conn->pkt_type);
-- 
2.25.3

