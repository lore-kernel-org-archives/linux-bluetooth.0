Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661BCC761A6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 23:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDEXLS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 19:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDEXLR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 19:11:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF396E95
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 16:11:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x15so35571482pjk.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Apr 2023 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680736276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udgKUuvoAAIiKllWPDbOGdoo0D4vW0uJyPpDUwLddTM=;
        b=q0UBGAH1rL16KK/AAocui/fjjDLgOnfyrXV1DI3a86N/MSD4GmHGGlHbot4UdfeOPj
         9lMdWPmhKzwrUXud7UNEEErAE++a6qseCDHM8Fs/gWqkVU2v7YJk6075dKnXWjOTe/mE
         lvoILM2ZYBeIS1b0o7TXQ8x2dD31reR2v4jtukO7X8zcIIbxNZhqIAr/GTe3OmJbTIQV
         YTI1tgUgy9R39jgxgl9obav7B/KsOQYE35+JCIday7y91kgRoxhECDREyQnqKNO9qQ01
         tS2WX6AMLbVhsX4LkLa72ggtwooxNWTBae2ECeKmP4rp+sgknJtKuzdVKWNi3noW3dwm
         uktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680736276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udgKUuvoAAIiKllWPDbOGdoo0D4vW0uJyPpDUwLddTM=;
        b=3RJJ29IDoEj8H4sIj6EkYg8joFRSp/JJtwFagTbsDtJrt4pjaNuDqKWZmmhOy72vUN
         /gXMDQSCuxoJFB74QjHOByqzGVoQs/r1zqLEnXZEG/rZfIROS3kLWijg+aXfemCStYHY
         FwVlVxF28Pd9Uxm/lJsuJ8l1Wipcx1FkLIiRspMmJ2pb2qTTRd1Lekz5BFoulHJVBf2+
         eIz1EqXsOW60oEp9GVu6KstNRo+uxJQ3sTHUQu3kF2AVLd0ccFLv8me26jfS9xVQGGH4
         AoRF5oWrCWMAIqyScQQk+IaR/UPe3r5NGhAoTgL1NEHpdCzJGIDJOZ1ZjYR9p0I599lk
         b4lw==
X-Gm-Message-State: AAQBX9dGt85dT0mNNFER8tISThYzJY8WOx9VWiGZbm7kOmCoaXZFZ68X
        kOerJkALUIw4yRkNrzfr8u9lKnu+52o=
X-Google-Smtp-Source: AKy350YLR0smyAL/vEWSnzcP9aq1mxljp7HOJAkIecefyN70mN8OD1OJtzNDj6pXl2hfe4N6b3bOLQ==
X-Received: by 2002:a05:6a20:c746:b0:d9:6c8b:e9aa with SMTP id hj6-20020a056a20c74600b000d96c8be9aamr871182pzb.0.1680736275784;
        Wed, 05 Apr 2023 16:11:15 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7808c000000b006254794d5b2sm11537752pff.94.2023.04.05.16.11.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:11:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] advertising-api: Add rsi to SupportedIncludes
Date:   Wed,  5 Apr 2023 16:11:09 -0700
Message-Id: <20230405231111.2636523-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405231111.2636523-1-luiz.dentz@gmail.com>
References: <20230405231111.2636523-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds "rsi" as possible value to SupportedIncludes so when it is
available it means client and set it on its Includes property so a
proper RSI is generated and included as part of the Advertising Data.
---
 doc/advertising-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index c6ee93450ee4..a0077843defd 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -224,6 +224,7 @@ Properties	byte ActiveInstances
 			Possible values: "tx-power"
 					 "appearance"
 					 "local-name"
+					 "rsi"
 
 		array{string} SupportedSecondaryChannels [Experimental]
 
-- 
2.39.2

