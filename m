Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D49C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 22:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiEPWNK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 18:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbiEPWNI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 18:13:08 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF62AC51
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 15:13:08 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s6so6701159ilp.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=eC0yJoD/610cfC2UxgkpbcsXgIZnr3ORvm94a+6ka7/20CsUNR702uaArER3kCJ74a
         nqN7bn6ICZ/PbMcFNEkgl/4y3SAz4VN6A4GR/pqHXVxOoF96+dASvafiS7+lmGT4zn7m
         D1PuY28fGo9qHcCsrTRH11JX3W5QdAsdcKQcLCOBPXEV7LrFzbmyeI+4nhyN6jVE6C2y
         IOafhYESUI9ILUj87SaopaiXKVrFlcjzWwIFANcs+a+Sjpb/083YNKMcYuCCA3hwnvGy
         i2WgZCQ4kJUI3yg++wtimpUexpiT1z/UY3Cwhtflnr8MwR5LIc/zFBmKUfAlMyppDbTB
         Sq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=kgaQDTiP4Xc7U7qEIq/L9E9pcL2CdoIpcKGTeLxby4SrHHNfrk7sfaozMGCUgO1VZu
         EV2Pci2AAspcS7I6Y45hj4dwwCh7aAbbi1URmLA6kWcGXqsLlJB1vWVrNKRA5+sGfpYa
         V1xhTbVKl7XWsEglR6kYRyn5nJxEGBa+ZocuKt2k9SPbYvM5laS5vEL+ZzZl6JGjWNB/
         GBOPkXQp7K1S5+PZ/DmgYTJlpYnpr0jxxW+Y9nEuGfOj3FnmOmYvAIYxNrIJDvrIH4L5
         9TNSDmC/lg06vB98YlOzcVr9Od6KSxWVTWcAUlpIkiDvkI+Y9gV27rdn4E9ke626+Nmi
         bAiA==
X-Gm-Message-State: AOAM533txTZk5+uBuLe9O2MBMNv+VTgOQaneW4RcPMWUcaNS0/LC9eL2
        eYEwDsaZGV/6SeEgy1e3XbluCrhbNgI=
X-Google-Smtp-Source: ABdhPJx7Dxj7LI9KUiijB29SIo2UlEZi0VaHA3YlyZx1jf9m/yXjZ3PiPnlMOwghu/+RiDP53wKsGQ==
X-Received: by 2002:a92:d20b:0:b0:2d1:1588:385e with SMTP id y11-20020a92d20b000000b002d11588385emr5324598ily.23.1652739187124;
        Mon, 16 May 2022 15:13:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t9-20020a6b5f09000000b005e1729b55ccsm166426iob.1.2022.05.16.15.13.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:13:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/8] shared/util: Decode BlueZ Experimental ISO Socket UUID
Date:   Mon, 16 May 2022 15:12:58 -0700
Message-Id: <20220516221304.1744026-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516221304.1744026-1-luiz.dentz@gmail.com>
References: <20220516221304.1744026-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BlueZ experimental ISO Socket UUID to uuid128_table so it is
decoded by the likes of btmon.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 33196bf8b..b74a005ce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1149,6 +1149,8 @@ static const struct {
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
+	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
+		"BlueZ Experimental ISO Socket"},
 	{ }
 };
 
-- 
2.35.1

