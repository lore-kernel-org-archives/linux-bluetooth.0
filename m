Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43244C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345306AbiCWWln (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbiCWWlj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:41:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E0A37A87
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so3323087pjm.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/j7e/CWw6oRrnkQVp/KphTi81K+8ZW6pXdZNgewlKz0=;
        b=gaN6Sk3iynJub0LEby4Jvvie7+P0Mavk4AtDvEVqxc78dnUQgfvr+BzEfB/si20Nb6
         FupS2cZ9m+rhuVHOm1SJH31OrNUSnZFZ4ZM1L+ydHSZX8f7qzOyzCnKF/zafflrOEz26
         FPYJIrhc8IHElcRWayR2D9tRQsP9vUXuzNhc65HKggqlOmA1vsa4nUhKQL1W1oBPX/+l
         WgJ0GVxVrFy1aYCCskqgeSV0GZ/xo4XqIea9s7RSqUD1re9bxaZdZvDsaCvLBhBI2U4g
         4kIOHmMoV0Fn5DKtbg+kp1ujOwWyE8E2SnP/YQFJw3vZcqfzJauKCVUFc/GXwHc6u6ZD
         090Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/j7e/CWw6oRrnkQVp/KphTi81K+8ZW6pXdZNgewlKz0=;
        b=VDvWaHoqdEx2Y7coAXS3kDkvbtYDUtVHSq7jf0nvlwhyLccZni+5Ayno+uAM3ADTPz
         k/gH8aZLd39p9k6bVPAhPxYdViOfxhIM4AAyCdL2BFnv03LsQWBOwtzVJbsnSIhd1XR5
         pphwMUDRSuJ4B5mekq1z8uoT3GK95IKwKGQEDEyxPbZ5B8ptaAhTQvhPS13Ue3DKWLmN
         LkpkcRWIWiuTIB68df+dfQ3IF4xNV5oSrpPdyX/GOOW0tWvBwa3SNchBqmrelpXPD75l
         KfxmoINZrxc00xvLE3W6RgV9NmNzR03ydVPyTvPgH9SFNnseUCy+aYxATpD7qpl/ivVo
         4C2Q==
X-Gm-Message-State: AOAM531j9nQJ4Igz5XOUGwj21mloRgTJrtDFs/FSaNh/Pybq1k/Mm4RR
        2OyYRf8HoyxY8jewd+V5R5E2P3RHRlo=
X-Google-Smtp-Source: ABdhPJw9nWfr6yGgypcQ9M5fFHAyxFkPj1jUddw0Uofc2LtkJMYr3VBM9koBsmZ6kjeoF/jNmanXXg==
X-Received: by 2002:a17:903:32c7:b0:154:4156:f384 with SMTP id i7-20020a17090332c700b001544156f384mr2457714plr.34.1648075208508;
        Wed, 23 Mar 2022 15:40:08 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm825109pfe.139.2022.03.23.15.40.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:40:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/9] att: Log file and function names
Date:   Wed, 23 Mar 2022 15:39:59 -0700
Message-Id: <20220323224003.3736525-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323224003.3736525-1-luiz.dentz@gmail.com>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds logging of file and function names.
---
 src/shared/att.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 169f726e4..7344b0c46 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -308,10 +308,12 @@ static void att_log(struct bt_att *att, uint8_t level, const char *format,
 }
 
 #define att_debug(_att, _format, _arg...) \
-	att_log(_att, BT_ATT_DEBUG, _format, ## _arg)
+	att_log(_att, BT_ATT_DEBUG, "%s:%s() " _format, __FILE__, __func__,\
+		## _arg)
 
 #define att_verbose(_att, _format, _arg...) \
-	att_log(_att, BT_ATT_DEBUG_VERBOSE, _format, ## _arg)
+	att_log(_att, BT_ATT_DEBUG_VERBOSE, "%s:%s() " _format, __FILE__, \
+		__func__, ## _arg)
 
 static void att_hexdump(struct bt_att *att, char dir, const void *data,
 							size_t len)
-- 
2.35.1

