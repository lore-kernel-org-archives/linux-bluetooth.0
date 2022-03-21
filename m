Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4878FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 20:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiCUU46 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiCUU46 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 16:56:58 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04219613C
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 13:55:32 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z6so8643473iot.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/j7e/CWw6oRrnkQVp/KphTi81K+8ZW6pXdZNgewlKz0=;
        b=GULFgGArGAX/tNzrRBW2+JTVXj8ug7wz/dVp3tGy4R6cm2mLBhhnCWM80RXF9OZBQy
         sYL1KCaQyLHoC3Tfov6/s8b/lPqIv61tM24ueNEEB3XSpVSyJ99hstHxTg9W98e2BvOT
         Jr2AfXbm+4/ZPzsX8se/SqhWgJQWfsg2yvWvF1pDsnhfo+6CLvg2Jn4tXlgTPbl8DEEJ
         wH+5IYNnJZOfLx5TkcF5X40kehEksJzA8MoCxh507CJzdtLbdEA/bSYg33WljNZvGJxJ
         nuyw2pMJtz3aucuxEMFJhaP6wKx8to9cBc8o70jpt9ev9GD9f8r5a6I6NE/ij2FF8lXj
         ALEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/j7e/CWw6oRrnkQVp/KphTi81K+8ZW6pXdZNgewlKz0=;
        b=1awgxzCSOexuU1Nv5mIyUqvMduj2ugZnkaAuh02ueId/K0WeluezhOsHRq9jx+2RFL
         7t0tybcwkK48Uhm0YETvUOWEVL0FfBz5Zx6pks4qPNYJUkgeSeljKhT6f0u5HmpmaFaI
         Qe+yTvsjtI7BLmWQ0WF0B4llpEyGbDgfFoipY8FaycpHlya9840ntvq/udknjZ4epk3W
         29YygwkPpNVPOOiHJoz8Th87JoyTXV8iekz11TUPxG/4wmZ8RYD7DU+UZIsAA0vFGybu
         Fi8Zd4+4ztiKDYo+Jzh9p0JS83Gt6bqWqI03c2oD+GWx7ZRV3CmQJmbg3eRhljyv0Bi4
         nULQ==
X-Gm-Message-State: AOAM5336B3rR9oOKM+1QpF5YjFIAm++P/8Ok9kk9Cs3kFmK7gUIo7wO8
        XZoa4OD0eShN7r+GhBwEDsedmZeag5U=
X-Google-Smtp-Source: ABdhPJxL9KNrheQECFwcCxkCFqs6OXhMNPBjTcb4WV1RZK1pSHnlSRbEqg89VJ6t/wmx+C/6Nz6siQ==
X-Received: by 2002:a05:6602:20d2:b0:641:23b1:b306 with SMTP id 18-20020a05660220d200b0064123b1b306mr10663290ioz.117.1647896131282;
        Mon, 21 Mar 2022 13:55:31 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q4-20020a056e0215c400b002c5fdff3087sm10962223ilu.29.2022.03.21.13.55.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:55:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] att: Log file and function names
Date:   Mon, 21 Mar 2022 13:55:25 -0700
Message-Id: <20220321205529.2469387-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
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

