Return-Path: <SRS0=5fy2=7I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57B7C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 19:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B1020849
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 19:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5sGfDSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389769AbgEZTdZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 May 2020 15:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390915AbgEZTdS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 May 2020 15:33:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360C4C03E96D
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 12:33:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t7so9091739plr.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sb3IGk3IadbvIg9F9PjQc1MIE0EJRTYN/eWToOWUisw=;
        b=P5sGfDSRlbLhyxgJeu5/f3dZHe9umSHCyDDSmfS+i/heYJv02t/5qeV5mC5SwRfoeH
         Fk+9ebMi4MyPJyro7HrVZ6hV9Vsaaotuc3i1qq+1lZExXDbpcTGi1/KXDTpiHwailPTZ
         IbDUiVw075mOz+vp41l2NrSizCGEbJlAKND9ZxytSNNDpjqRpVK7X3NVrdHB6GuqFo6P
         MoQHaXUynnYQOVh/6ydvfk1NmfO2TbFgphqLfKudH2MeaqoVx1cjKFXcdFomWTbfa2/g
         6Ap97yGKbSC/ZdkSukQUr4npyXWwEi+aWzshJxe4hVokELF059JY+PuZEEWK5/2QBFt7
         z4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sb3IGk3IadbvIg9F9PjQc1MIE0EJRTYN/eWToOWUisw=;
        b=DT/zECDojWyiUP0yi8mqru/YEzzjwg9n8PoxxsleqcUPARJgesdNTIoNsPgA0md2h3
         u1jY3hstQ0IQewBxKJriaQKxqJ+9+SZUcgfJcs6aacNJgG+GkAIXf9DhBdcvQStrD6BA
         veLD+FiPm9XaiN8Vc2RZMbAgwFfmwJ3ZiJXEdtZIjtFXxpPtFzbrhnjwdunNEAqbYNht
         E8+VRiV5AXZGcEDinp60aZzCXKTJunBOonNF8PTc31UIyeKGGWeSsnpZ0O/mPQUbXeVw
         ZGJp61c7YSwwNZtb87/pHsrEzjootE86TTR+SieTtSVTMiG9E8mbqUQd60DCu0x4BNxV
         qcew==
X-Gm-Message-State: AOAM531TMklrp0cLaOf6FwXAlbaMaw/3dO+MepO7X6GL4z+NTB0C+hK2
        j0HuHst9/4/3ony2PQvhaSzvgDON
X-Google-Smtp-Source: ABdhPJwmcnMgfKzCVbk0EhOjx2Kb10cEvitXfw0HdFRnYRVZzTV3M3TC/eccOSRGI0Z0DcngBQ9new==
X-Received: by 2002:a17:90b:80f:: with SMTP id bk15mr833623pjb.51.1590521596307;
        Tue, 26 May 2020 12:33:16 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q8sm283718pfl.92.2020.05.26.12.33.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:33:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] advertising: Fix advertising flags
Date:   Tue, 26 May 2020 12:33:14 -0700
Message-Id: <20200526193314.25036-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When an instance wants to force being discoverable the code shall
actually check if the adapter is in general disverable mode already and
if not set BR/EDR as not supported so that devices scanning don't
assume BR/EDR PHY is connectable when in fact it isn't.
---
 src/advertising.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 45ff19fa0..829c481f6 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -697,9 +697,12 @@ static bool parse_discoverable(DBusMessageIter *iter,
 
 	dbus_message_iter_get_basic(iter, &discoverable);
 
-	if (discoverable)
-		flags = 0x02;
-	else
+	if (discoverable) {
+		/* Set BR/EDR Not Supported if adapter is no discoverable */
+		if (!btd_adapter_get_discoverable(client->manager->adapter))
+			flags = 0x04;
+		flags |= 0x02;
+	} else
 		flags = 0x00;
 
 	if (!set_flags(client , flags))
-- 
2.25.3

