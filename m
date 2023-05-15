Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CDC77B7D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 21:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbjEOVFu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjEOVFu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 17:05:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E81991
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64ab2a37812so691503b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684184747; x=1686776747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnB5yv9oZNhLgZuBAf3kZHHnyPDEbPfDsi/R/yytOW0=;
        b=NmScp0by6qPoT6YIURRHO+Ruo2K6rs4p+CScfA1zXNsno3PBOfE9ZGQlbiYJ3baCIz
         KqVq+Fav8AU3P11qqIBm3dQCg2kuDGHKglhntqvqIQ9PBGtDPjmXFHYg/HYghIPdSOVR
         o6Kf2QwsxhQKp03KacYoMFp34uXZdgLmdrCyIdL7V4yC2mirzBLHul1DVTp3Bz/AR4V0
         kBp8wOfSQ6XV4w/NEEcMa7GRcsKOi7Wm9eIzJ6Gucx+qUg4MuFN+mTuoDHlprSrkNuEb
         VsbNEps/pwxa4SsFvwGbkg8BW8f3VkLPEYzYkxRPEtM/CegtKZsgr6CtysLgCgpLU4Gt
         rjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184747; x=1686776747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnB5yv9oZNhLgZuBAf3kZHHnyPDEbPfDsi/R/yytOW0=;
        b=hmu1Z0TDTKk7fQ0aC+C/4twecdAuT0VuYid6gvAtEu9+xTSsdKnteJdWILjr07wNE7
         O1K9mLeVaJ7h79MSLEpwzu+ZssBl/JvTv1jFyYHQpFBIhcJJVv8ZZXlqxKBbC26ciVFF
         CnXtele8/d7zAoTAiQj8/A12ZNtmgyX7Zkweif/NcKSWc/KNHmBGjaAebxWeqMIdfqNw
         zsA9rjuDoRkQG23UCFS5JPNB26b+PrgqquDicYXX+5QM2D/PQhc8FwXpzpU8f+AKZYrU
         tnYHJ8wZIO+RN3jJmspwC3IJp3D3oS9x1aPIZvn2mX9lW6UeIRldWmic1NkUI24e3Mik
         SGow==
X-Gm-Message-State: AC+VfDwr4cY3gBmEHFQWsawC5xukR8l+HuEr7D6iaaLLgYsVFBV+1Gp8
        /IcEwU8HPsMwN1cG1a1vwc91CKMHuSQ=
X-Google-Smtp-Source: ACHHUZ6U0bNW6pdzoRzJVKS9P5BuTYUXVFbNKENefkRD1oq2x5696J9unHagftEF5HsB/COIN1otng==
X-Received: by 2002:a17:902:e80b:b0:1a9:57b4:9d5a with SMTP id u11-20020a170902e80b00b001a957b49d5amr46763118plg.31.1684184747093;
        Mon, 15 May 2023 14:05:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a04ff0e2eesm13990050plb.58.2023.05.15.14.05.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 14:05:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] profile: Add support for experimental flag
Date:   Mon, 15 May 2023 14:05:39 -0700
Message-Id: <20230515210545.718701-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds experimental field to btd_profile so the plugin can indicate
drivers that depends on experimental to be enabled.
---
 src/profile.c | 6 ++++++
 src/profile.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index e1bebf1ee19c..ea188f36b6dd 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -775,6 +775,12 @@ static struct btd_profile *btd_profile_find_uuid(const char *uuid)
 
 int btd_profile_register(struct btd_profile *profile)
 {
+	if (profile->experimental && !(g_dbus_get_flags() &
+					G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		DBG("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
 	profiles = g_slist_append(profiles, profile);
 	return 0;
 }
diff --git a/src/profile.h b/src/profile.h
index 6827f848148c..6871f2f0d7d8 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -28,6 +28,11 @@ struct btd_profile {
 	 */
 	bool external;
 
+	/* Indicates the profile is experimental and shall only be registered
+	 * when experimental has been enabled (see: main.conf:Experimental).
+	 */
+	bool experimental;
+
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
-- 
2.40.1

