Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADCBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C6A611C4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbhIVVfg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbhIVVff (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 17:35:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF22C061756
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:34:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23so3059572pji.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+PB981a7qDByaprXL3hi854zKSxcfEldtuqhLf1Lscw=;
        b=Os0yHmVHZ3J/vq/6M0fHKv6N55I1cB88coSpqgTkCqVnyvMweAokE6/xb98FJKpbCs
         w4nvjK0G9o8Z7M3qRgzboCWseLUDqLABh95EsvJ9SSA5SZPqeSey197Em8a7y114MiKe
         EX1ehg8+7z3Aw51oYpHDyEoJqlD8GmVrPQet1vsxrNSDCqdWByGrkg38Z58MaAjat5nR
         Nr21fEVieewJrkyWgom/pqgjjPbAIgygNKYk3t4vWpmG65wRPT+6rjPieVSYkPPWpxe4
         Nsh2kT44dtIPiJTlD+9hVr5it2xhZ9QE1g+JYD29KEi2MplzmjktiVfrrKk2XsBYj3GN
         Ry2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PB981a7qDByaprXL3hi854zKSxcfEldtuqhLf1Lscw=;
        b=3lgMo9nye3wWWNAlgFAiBlvN9s8ewS6Mxpeb2wGzJdf3zHRMAU0BvbeXEr53/UhB3T
         9b6dITiySFVfAAK5LxpuMgGYDqJ7aX+8yFSwh8qG1yR2B+qF/OBm/Lrg+/JlxQtpLCJX
         JbjWzfktmO2Ef3/NGXk9zXEzdSgUV1rjcL8Gl84bqm5DNmU712x2aAkCwUHYM0j8bm+6
         cMCQqMr/R/umv+9McHLiQhMtvPNZG5LeEblJQMZRw0NcM3JS8Tpi9rZcS69w2w0HrENM
         doWSqoXy4SafkAvvRiTLfqLFlaJsS1ZDPsvZfbjS9bEdfaQBXRarz2jbrNJDIqKkuvoV
         +q/Q==
X-Gm-Message-State: AOAM532SQsFYsTNfhTQmeK7ocI5QogpT1CHbUfHnHsi9k95CiZs5LJSq
        tyxgw8lHDwocG4lXpjKNazLPf1tszNw=
X-Google-Smtp-Source: ABdhPJwc+9tvkCepc8D/DNXgrUEHhtIbBmJ1YC71t3LotOSFwacMmFJFE63xYNqCWS2GFbaiDrtj6g==
X-Received: by 2002:a17:90b:4a52:: with SMTP id lb18mr13737985pjb.162.1632346444027;
        Wed, 22 Sep 2021 14:34:04 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i12sm6378596pjv.19.2021.09.22.14.34.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:34:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] lib: Fix HCI_MAX_ACL_SIZE
Date:   Wed, 22 Sep 2021 14:34:00 -0700
Message-Id: <20210922213402.1978215-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922213402.1978215-1-luiz.dentz@gmail.com>
References: <20210922213402.1978215-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HCI_MAX_ACL_SIZE actually includes the maximum frames in AMP controller
so this changes it to properly define the max ACL frames on non-AMP
controllers and introduces a dedicated define for AMP controller as
HCI_MAX_AMP_SIZE.
---
 lib/hci.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index a61568bce..50f385c1e 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -21,10 +21,11 @@ extern "C" {
 
 #define HCI_MAX_DEV	16
 
-#define HCI_MAX_ACL_SIZE	(1492 + 4)
+#define HCI_MAX_AMP_SIZE	(1492 + 4)
+#define HCI_MAX_ACL_SIZE	1024
 #define HCI_MAX_SCO_SIZE	255
 #define HCI_MAX_EVENT_SIZE	260
-#define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
+#define HCI_MAX_FRAME_SIZE	(HCI_MAX_AMP_SIZE + 4)
 
 /* HCI dev events */
 #define HCI_DEV_REG	1
-- 
2.31.1

