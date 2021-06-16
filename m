Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C0C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 12:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1714360FDB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 12:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhFPMoq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFPMom (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 08:44:42 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580DAC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 05:42:34 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id o3so714654uaw.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nr+VYcU+b1B3PVHyuSk2+yV54kISvfCqGmxXpvEOah4=;
        b=T+yTAqA3blP2VKUJTg5xg0D1MGMuvNhG7bQNeJsZDLgZuEFxseWlVQL+aRkY7i84Dv
         JW1vpyFr6qzjn6VmoU+EVbMczbiybxc/HqXJB7jiUI0/2Pqpy1rUMSOhT3FIBgWSmszT
         P+cwMC1dvaeJ7UFpwOD/vufr+CqXAUxFHcc7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nr+VYcU+b1B3PVHyuSk2+yV54kISvfCqGmxXpvEOah4=;
        b=Umjhr3z6ezavJVlsFWQL3mys9YqbP1NWwbOM7dQUFVKFwWhcqAodxILxF0CNDmTlBj
         8YjOpcCCBWfucs1qFyLdSdicRS/ypjRBtS02v7WNtiPcCkQEEW7vu+xhUOuMP5ap5x72
         3n6PHU1GPBTT1iyBnIF8TQkI2BXUFV6JK6NiENt8udjNdeMtOQ/xGqn5zKZMqghvzSNK
         5M8ckS5r8DNEsg7nBddXMDeYXbZbQ3jtj11sirtgHdJCwRhs8j/QXZVp/lDrRBp9gSbh
         +VGvGLB99FQWEhSa1RSiXJeRj2zZ42EkQ2D5XAFNjFb80gUfh/thCD0/RGA7BA8vtUkJ
         48hw==
X-Gm-Message-State: AOAM533vdG8//HHX2+S/Ew/pYYdc8wGWQTyCG7bHCcI5pQg45940czbK
        7MGKxVx2/ki02+rzFw4D71LcV96gdWK1oQ==
X-Google-Smtp-Source: ABdhPJxcOzGMx4XpqDLPhEUJ/P3ObMBKboYJf0hgT9BRfUAV2G35aKSZMzgF0+fQe+hhvMtOu8MhLQ==
X-Received: by 2002:a9f:3010:: with SMTP id h16mr4318571uab.29.1623847353156;
        Wed, 16 Jun 2021 05:42:33 -0700 (PDT)
Received: from alain.c.googlers.com.com (162.116.74.34.bc.googleusercontent.com. [34.74.116.162])
        by smtp.gmail.com with ESMTPSA id f6sm308399vkb.2.2021.06.16.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 05:42:32 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>, Yu Liu <yudiliu@google.com>
Subject: [Bluez PATCH v2] monitor: Adding missing device found flag in the parser
Date:   Wed, 16 Jun 2021 12:42:29 +0000
Message-Id: <20210616124229.1059905-1-alainm@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A new flag was added to the kernel implementation of the Device Found
event, but had not been added to the parser leading to an "Unknown device
flag" error in btmon.

Reviewed-by: Yu Liu <yudiliu@google.com>

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2:
- Addressing Marcel's feedback

 monitor/packet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 82513a63c..5a928c296 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12030,9 +12030,10 @@ static void mgmt_print_io_capability(uint8_t capability)
 }
 
 static const struct bitfield_data mgmt_device_flags_table[] = {
-	{  0, "Confirm Name"	},
-	{  1, "Legacy Pairing"	},
-	{  2, "Not Connectable"	},
+	{  0, "Confirm Name"			},
+	{  1, "Legacy Pairing"			},
+	{  2, "Not Connectable"			},
+	{  3, "Connection Locally Initiated"	},
 	{ }
 };
 
-- 
2.32.0.272.g935e593368-goog

