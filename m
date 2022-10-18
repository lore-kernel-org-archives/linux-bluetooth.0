Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0805DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 23:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJRXqH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 19:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJRXqG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 19:46:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D92CD5C3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 16:46:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z20so15299267plb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TjJI4Z5mKo0WkCCYEBgGhDf/q6wdCtS3DVL2EEYvvw=;
        b=cdfG4UHWshMEFMShafTRZy6qaGTTxzEPWjmr7POBYXhJkvgnS7TUdH3t9So1JARWX9
         qzOhebTxpC8q4M//NTRoN+7FcHvzrLHp5uukVdrYhEPHJdE7/htz5brkiC//Ux22zmvW
         G7q9NciSUdXNtoR+HnFUarPasHt0c3FmZacsCZR/6t4/GSOo7pUan1SyEiSNHcz2hwnq
         rzLPsycjwO+elC70HAsMmV3KBmv6yJVHQn9dKZaK0AowgbmcPHHO5hAi7pex/phAS6GO
         rZwPkf+Gxjen9t6nUza9IM3XrgI3dZ7JJTlX1lqfjNnuvdcd5gTVt8Q9Yq4iR6UuI2Bh
         +W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TjJI4Z5mKo0WkCCYEBgGhDf/q6wdCtS3DVL2EEYvvw=;
        b=kfsKElqwZaEs6LlHSm0xn8rpbhQncjPridUMcqGL6ELx91++SXYKoIMYq0nDdRmsif
         /JLRL6iG1pHhBi6peJGbLw1ko9DyNySziez28ydL0bio8U7OglfTjrRgHeQSDoghaid0
         R0n38Kbfqi8DS6456O8WfkGWanDlTxZjNaYQlHHUUbzXthvUOSEsIu8FUJVY7gdumix5
         4WdUWTdXTNmeljjkW+FiZvGlfHoLnApFCeyiWgpiJecK0j9sz8LAzHTtbN2SVlIsJs3T
         dgjfMyD8S+dYk0EfY0K2Z8qZuuKYh813fwlp3f87k38UfRfJM8mf5rjBHEMkcfGlugag
         XNPw==
X-Gm-Message-State: ACrzQf3UhX0p4oI5IjnqblLT8Efz1t+y1ctVoaSVQtqPs7Bs6qzTHU/1
        UJkdV3rcBtAbxkykEmxKiDhRHsRMdN4=
X-Google-Smtp-Source: AMsMyM64UnzrM4bmLuhCS78fJnD1AuW/ycs9kCbPzaIeesjjmeWWKTJfyIzWj6PYFU1WtxQiTpi4CA==
X-Received: by 2002:a17:902:e982:b0:17f:ca1f:aa44 with SMTP id f2-20020a170902e98200b0017fca1faa44mr5477067plb.76.1666136764650;
        Tue, 18 Oct 2022 16:46:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ik3-20020a170902ab0300b00170d34cf7f3sm9137783plb.257.2022.10.18.16.46.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:46:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] settings: Fix scan-build warning
Date:   Tue, 18 Oct 2022 16:45:58 -0700
Message-Id: <20221018234600.3990980-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warning:

src/settings.c:281:7: warning: Branch condition evaluates to a garbage
value [core.uninitialized.Branch]
                if (ret) {
                    ^~~
---
 src/settings.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/settings.c b/src/settings.c
index 0f053000610b..85534f2c7aca 100644
--- a/src/settings.c
+++ b/src/settings.c
@@ -269,6 +269,7 @@ static int gatt_db_load(struct gatt_db *db, GKeyFile *key_file, char **keys)
 							&primary, &uuid);
 
 			bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+			ret = 0;
 		} else if (g_str_equal(type, GATT_INCLUDE_UUID_STR)) {
 			ret = load_incl(db, *handle, value, current_service);
 		} else if (g_str_equal(type, GATT_CHARAC_UUID_STR)) {
-- 
2.37.3

