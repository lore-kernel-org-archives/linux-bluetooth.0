Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06116ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 21:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiH3VmY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiH3VmX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 17:42:23 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC225590
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:42:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w28so9647409qtc.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=S3Xb8HQrFNZ6Qkf2GrFXhxzTLlBqF/OcAM4ZbE2n9I0=;
        b=ZoRDPHa7Rs9lIY1j93YkCf/LcgnV0hmVp3TAo+P2W/4uWf3qXRnioJywmrhwOc7DS6
         ntBnDh9I8qfUE68BUlbW12bqIDNTkJI0JeYdyCp01CcI9L1yYdqkgycOOJBrfjd0oWFK
         sz48ho6YrS8uJZwyKCfeojakN+/EJYt8WB5LxfscuQ3A+Gc0aOkty4wcmY3aT0Jb67rP
         YuFSiXfx+5MdP4M3sQN3y65ndPWBNada+X+hPhvL84pdTVFKWIp/U4yi3DYqmPPYucNZ
         58wXMihjmzIs/VrsdtRK64K1ekzxDMYZqjno3cadpGpjFPapAVZ7W78MQ6JQ0/L/0eA6
         5aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=S3Xb8HQrFNZ6Qkf2GrFXhxzTLlBqF/OcAM4ZbE2n9I0=;
        b=j/AKHU8XZIyi/cZqBhfwsFRBnnZBBDyjbX55nCJn8Grjncp2jIyLJ7XuZtdM7AYAHF
         0uHY3HgLGT4lkaBku2Drvc2hojISFpziKwk9s+igSm2EHFg28XVtpf4xfulP7mvj6MBQ
         2gqJpcqJOpejbGcKxJsb3rOxcgqeBgTYtq5grzGmCFbj4NJLR3BQE7qfGm8rp+nsEsvU
         sO99WcHB4a7C982nMMxMl/u1j+eLGLuMpkIauhUlKTzYPRVloRUDlHz0YomwiAI4Kdl2
         f6M37QBS0qfhrIH5b8Cz+mgsrm4G0etwm4Zn3hy4PAeAy+J0EEDND3Fk08bcnkETsKa9
         ST/g==
X-Gm-Message-State: ACgBeo0ZpNB/C5cYRalHzR+g1jLrjjn8Cl6l0blCaDtLJBvRE7WEDhEI
        qkSHtLMfSnly1kKasQd8/WSZeKPsSGg=
X-Google-Smtp-Source: AA6agR5/THLJr0P6W7ZcEdEVynuhYYYWDMbGqK40TlctaAzNi5cIG/UjxV4zS32PcHI4S6lHrPKw4A==
X-Received: by 2002:ac8:4e4c:0:b0:344:8819:9a7b with SMTP id e12-20020ac84e4c000000b0034488199a7bmr16326919qtw.368.1661895740026;
        Tue, 30 Aug 2022 14:42:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fz18-20020a05622a5a9200b0031eb393aa45sm7529050qtb.40.2022.08.30.14.42.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:42:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/shell: Fix scan-build error
Date:   Tue, 30 Aug 2022 14:42:15 -0700
Message-Id: <20220830214215.1137276-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830214215.1137276-1-luiz.dentz@gmail.com>
References: <20220830214215.1137276-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following error:

src/shared/shell.c:1135:19: warning: Null pointer passed to 1st
parameter expecting 'nonnull'
                        data.timeout = atoi(optarg);
                                       ^~~~~~~~~~~~
---
 src/shared/shell.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 4658819a4bde..46ba8112cfb0 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1101,6 +1101,7 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 	struct option options[256];
 	char optstr[256];
 	size_t offset;
+	char *endptr = NULL;
 
 	offset = sizeof(main_options) / sizeof(struct option);
 
@@ -1132,7 +1133,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			data.mode = 1;
 			goto done;
 		case 't':
-			data.timeout = atoi(optarg);
+			data.timeout = strtol(optarg, &endptr, 0);
+			if (!endptr || *endptr != '\0')
+				printf("Unable to parse timeout\n");
 			break;
 		case 'z':
 			data.zsh = 1;
-- 
2.37.2

