Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99D0C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 00:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjEKACC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 20:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKACB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 20:02:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF035A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 17:01:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso8551210b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 17:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683763318; x=1686355318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d396uE3VXLd6FUrRqmByZsOsI6lFw5B++H5Y/yOU+0I=;
        b=MVYpPlVSJLKHgPXK+7Ry5KQSVGUn1yatLS8hrGoJxyFH1K3CGqH0cwNFWD2m2PLK/L
         kv1Ro6fyu94zQ67ndpSVEBdu5x+1ZnCZ8KsgdmNHc7kN5r+YmAXdFQC0xHBSZi2/h7lI
         HBMQ125soAgZeGvYvO+vMx9DkzEuQkbuGvFO2Q82+KNf6H8n399svzl1PdKNEFLI89H1
         W0WPtktwbv0n2zFZUv4q3hr8LOiE1J+T7NakKRu8Eiw7gCvuZApnfnae3Owery81Ptrk
         bAdnFsg4HgPLGHgWltyqllA+H1TUgrHIJe254VtydVujXb53anDmtUskdXGQhwJ9YfoY
         KUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683763318; x=1686355318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d396uE3VXLd6FUrRqmByZsOsI6lFw5B++H5Y/yOU+0I=;
        b=biBZGjzsBdRdsTYGs7hwMP2pUE1r0iq97Z907lstkEQQjqjuSCIciMSYRUhtr212yB
         oBlF2tq7UyElRnkaTS4/hmtJNXFQ7shTBfj55HWgdY/U3NKMc6iGGZhJpRLR3WAAOTgv
         +cmTDOFMvOqGsQ/LDX8bmwvyT5k6Zply1YCd1ybkRCZigvfFfnKjSso7tDsjqgu82Te9
         UcUayxd5DaP1Pu3CQ1r1XyOb3zD1MW+6as0s+WkUFIdO0Y3UmPgOlNLnXPJS3YjzzRMg
         78F6mMS4vexWwIeKLjy+61VSJtxtU1uHRBwDjQPAHJZssvqb7CLHHhv/GM6bJRMObTzf
         SkRA==
X-Gm-Message-State: AC+VfDwaHZRy9lEYBAUM9aYgefgXEaZfUuo/Q2bvIQ8z0YWx5qt7BxpJ
        huf02M3Cf7XC5dpns9MXc/cEdabZ2/4=
X-Google-Smtp-Source: ACHHUZ4olnmIIhU7Yu9+0kllnZZOpuv1vkT+vNiJbD+MmdDQDxxhUm+aJYccE+C3UM5/lgdUam2Tsg==
X-Received: by 2002:a05:6a20:1608:b0:f2:c2a3:3a1 with SMTP id l8-20020a056a20160800b000f2c2a303a1mr25047930pzj.43.1683763318038;
        Wed, 10 May 2023 17:01:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id g15-20020a63f40f000000b0053031f7a367sm3761604pgi.85.2023.05.10.17.01.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 17:01:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] client/player: Fix crashes accessing metadata
Date:   Wed, 10 May 2023 17:01:54 -0700
Message-Id: <20230511000155.3721222-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If metadata is not set the respective iovec is left NULL so it needs to
be checked before accessing its fields.
---
 client/player.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index f055ff941569..091d7005f42a 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1743,7 +1743,7 @@ static void append_properties(DBusMessageIter *iter,
 					DBUS_TYPE_BYTE, &cfg->caps->iov_base,
 					cfg->caps->iov_len);
 
-	if (cfg->meta->iov_len) {
+	if (cfg->meta && cfg->meta->iov_len) {
 		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
 				DBUS_TYPE_BYTE, &cfg->meta->iov_base,
 				cfg->meta->iov_len);
@@ -1850,7 +1850,8 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	cfg->target_latency = preset->target_latency;
 
 	/* Copy metadata */
-	iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->meta->iov_len);
+	if (ep->meta)
+		iov_append(&cfg->meta, ep->meta->iov_base, ep->meta->iov_len);
 
 	if (preset->qos.phy)
 		/* Set QoS parameters */
-- 
2.40.0

