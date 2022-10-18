Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3958C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 21:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJRV2G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 17:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJRV2E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 17:28:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F401B56E9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 14:28:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y1so15353082pfr.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TjJI4Z5mKo0WkCCYEBgGhDf/q6wdCtS3DVL2EEYvvw=;
        b=QbzCJbou7ORjRu05AFnVOQgOXfOL0TXO7Rimh4lL7MX9d0Us1gniOiDraWEtAxZza1
         g33BT3Js+getxIZYU2BvvUHsHQTFwhlx3B5Di9YWmVpxwfLZ4Rm+G3xz4wn4rfyDHz68
         yEm7m23OcmCXi6kMaAI2iQZ0HfX10TOiRqQBL8jkN5lY24dPC5fPC0WNBuC6AGgEe54w
         7Z089ZRsUfLo4hU0sN10qyx1bL6JfYcnAHISFo8aWmwzrfDW0oVvlujztQPXwuSD24VC
         8lkn53alGngSdOdIci/q/4Hr5pzOPQSMIGy68EDkdG+NKzUgKDsyDchK2m+641tR46IN
         wvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TjJI4Z5mKo0WkCCYEBgGhDf/q6wdCtS3DVL2EEYvvw=;
        b=Cc+JNwnSrb1cAI7n9zZpbfOOh+QgMPCX8GMz4CtaESyuYhxiqRdZLICnUWNVg7oV4I
         tCe8L2zk7w/MWL8mEGxnK/rx5j8q40MpNUfZWKlyxcapgiiTJOpkbN4y1ZwOkB8OTimz
         29NK/JAsP9Z6+dZH+Orv+v/RhvqKYrdQDJQ6f0zT3i1imskxUkeo0byMJBEmwq8S2p8P
         gk75rZDSlXrx83DDYjpnTawS08OWk1g7gZ6pjDx29I3GXNhSKqICcHJFBJsoSPNuugR6
         H3NsF7ycoupbzfLXVv779bNnB8GzOEkNHfBzTvUrsHEZXbMwBLPV/zaAA8kMdBft/3Wt
         jUfQ==
X-Gm-Message-State: ACrzQf3bJ8YQgKXZ66rWDlVV55SF6cmKHMKmkQ1z7H2TvrDuzLEF+fWC
        zodoSSO3BnRrCbYJQA09lC5rQZifuKg=
X-Google-Smtp-Source: AMsMyM5Pr/W47VjpEYkiZeRduEXR2YmUEgk+XugWstKgAxRltKO83yGAKoFFbQE0IiXEaRY3PrUb5w==
X-Received: by 2002:a65:42c7:0:b0:462:7158:c863 with SMTP id l7-20020a6542c7000000b004627158c863mr4396553pgp.590.1666128482380;
        Tue, 18 Oct 2022 14:28:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n9-20020a170903110900b0017f7c4e260fsm9230653plh.150.2022.10.18.14.28.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 14:28:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] settings: Fix scan-build warning
Date:   Tue, 18 Oct 2022 14:27:59 -0700
Message-Id: <20221018212800.3967256-1-luiz.dentz@gmail.com>
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

