Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6C5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 22:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8083207D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 22:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFwyPhrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgE0Wnq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 18:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0Wnp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 18:43:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6615C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 15:43:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 124so6280596pgi.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 15:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRNf3g0aaybUiuE5w1c4KF1fNLd5dCJGW6FPC9eQZFg=;
        b=HFwyPhrUCvfqrkpQHrZaDVJKKYz4eUwOiXb7qOkozL+pxN53YD/flmYYos/GXdidND
         8H3rSJbXTLs/wbJgXoV6YAGeu+Nx/vvRnth/bSeaaBLElCP0rPhoEKrJK3um6OJHoNRT
         0ZL5K/yJRSUctVqZSJjYJqx8i5a6zc3RFNjEKT6N6FfXCOXYVjO+quw3HRii6eh76jIp
         sD7A/49ipOXA0fSsWlLGf77D8Ze7gDnKkOMyT6+s3BFiTNSjujvBmKAHBpuJeqOy3+IN
         lKmt0uhtaGofDpMNdt+qB5/ffOPvrECB3bVPmUVvYpZZ8wbxwPRmlNCh1tlN4UqbtPQY
         6Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRNf3g0aaybUiuE5w1c4KF1fNLd5dCJGW6FPC9eQZFg=;
        b=DeDKUc1nk/Zc6N+8vRnxoGlmQGxSOdJwMjmiw6hGBMWPofI8W/qCrx5whW8i6DKah0
         DYYE7VunhRs+kDj5RNRbACdV5em/WxJWx3xxz78RVgcl7sgYflY5WWkvwQkgw3ah/PYX
         cgdzOQRY02bKlFrB15rmjxgBawJ46bCOpI7mtsXEB27ssIYx1TnpJArweA9/EtsPK1pr
         qDutVuOAU+uKXNmMjM79/kimMkR8c4QeueJ+DXQT8ymO1NotkFy81KCjknVHUDxFDnTE
         yMF0Jfrw1OukX90/UM9aC2jkOLx9YqzAnfUCOyvxlzgubcJlL4Gz25OL631f+CIh8SrH
         pLpg==
X-Gm-Message-State: AOAM532m8aAIOig0qARUj/wTePP6FUPjN5/bELs+TljqFpvcuryml87A
        4plT2+EgzXGxkxfWr8YPuZodoOXr
X-Google-Smtp-Source: ABdhPJyV5jeW3b7IBQVTw4kG3yRegmwfzpB9XLgv+04Yuwi++pH1HebrJF2E9g/p05Z+GnyLSIRRrQ==
X-Received: by 2002:a63:fc0e:: with SMTP id j14mr28410pgi.264.1590619424944;
        Wed, 27 May 2020 15:43:44 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r31sm3308304pjg.2.2020.05.27.15.43.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:43:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avrcp: Fix always requesting player settings for category 1
Date:   Wed, 27 May 2020 15:43:43 -0700
Message-Id: <20200527224343.182610-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Player Application settings is not mandatory for category 1 so instead
of always listing the settings the code now checks if
AVRCP_FEATURE_PLAYER_SETTINGS is enabled.
---
 profiles/audio/avrcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 773ccdb60..75811bf98 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3814,7 +3814,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 	if (!session->controller || !session->controller->player)
 		return FALSE;
 
-	if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
+	if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
+			!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
 		avrcp_list_player_attributes(session);
 
 	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
-- 
2.25.3

