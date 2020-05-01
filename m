Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D8C4724C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 19:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48862173E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 19:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S5LO/hb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEATWY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 15:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726649AbgEATWX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 15:22:23 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C40C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 12:22:23 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id s11so6940347vsq.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2020 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqE507qe+ySVOyK0pIlcNPRGG7hMEjlFYwYV9to09nE=;
        b=S5LO/hb9pjphE8IgAi5tHEVukzCvIe2Yu62488tkxmBunMCpJE/CragDCeYyzXOLlA
         XektLvtaxMFHENr/Sdkug5/EFalDD6vR+2C3FlwfMRQqSeLbwETQgmoQnaRnyyih67WG
         ceKeL0NkzSC8wvqh2aKxWt08qjxmdDYWa7svo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqE507qe+ySVOyK0pIlcNPRGG7hMEjlFYwYV9to09nE=;
        b=iMJnm/orDvUOaJfAteKNgMj76u5IkS9Td+q3SHz3VpaE762nGsNi258EKICLXUxiGX
         5xEQtjXzmyEF5n7SHJYl05Qrp6mgc/WkioxSVYgScs+xZfiH+wt2mUl4pZzfK9xJYgce
         DFU/H8cvdgOjDKxJP14l8SFfmla8HRBNBTbx2lO9ii/Ua1GMCXU1ca1Ssnc8qFJSp9rt
         cv7+K6xXzFaLLyUegz9k6ADCFwnzaiggJaVJt9gN0ghXTmTTjSPIehz8kqHw2DvnMdFF
         +BT0D2DgXVo9PdFyBr0V9lAfjCFVrHT0dYLwJB9TOI0B4qlsU4cDbgHOpp+6b7x+yTFy
         bEnQ==
X-Gm-Message-State: AGi0PuZFIBWWenMUXAwzqVu2xc9fFMgyVxV5tA0LhpGTv/0yWTQ7ul5B
        ewuLyCL6vV0mVs0NBSEh9v50+WtfLws=
X-Google-Smtp-Source: APiQypIrRYhWfNGLUu0J3ZBJ70iUumNgw4R+C6p/rxKVpooovh7Sfou18ebAU0/x84Cwl3TCTtPXTQ==
X-Received: by 2002:a67:e3b9:: with SMTP id j25mr4268584vsm.110.1588360941958;
        Fri, 01 May 2020 12:22:21 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id u196sm1024318vku.11.2020.05.01.12.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 12:22:21 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2] shared/gatt-client:Ignore orphaned characteristics
Date:   Fri,  1 May 2020 19:22:17 +0000
Message-Id: <20200501192218.73993-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The gatt discovery proceedure simplification to discover all
characteristics at once has exposed a device side issue where some
device implementation reports orphaned characteristics.  While this
technically shouldn't be allowed, some instances of this were observed
(namely on some Android phones).

The fix is to simply skip over orphaned characteristics and continue
with everything else that is valid.

This has been tested as part of the Android CTS tests against an
affected platform and was confirmed to have worked around the issue.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 src/shared/gatt-client.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 963ad619f..507b4d304 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -632,7 +632,13 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 			util_debug(client->debug_callback, client->debug_data,
 				"Failed to insert characteristic at 0x%04x",
 				chrc_data->value_handle);
-			goto failed;
+
+			/* Some devices have been seen reporting orphaned
+			 * characteristics.  In order to favor interoperability
+			 * we skip over characteristics in error
+			 */
+			free(chrc_data);
+			continue;
 		}
 
 		if (gatt_db_attribute_get_handle(attr) !=
-- 
2.26.2.526.g744177e7f7-goog

