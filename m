Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9A4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 17:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiBXRcE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 12:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiBXRcC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 12:32:02 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460EC2DC4
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 09:31:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j22so726926wrb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8I2dcmWfMsSk6pQibuUG7vw4XZRdaUJSxw/t1am3k4=;
        b=Z3kWRjZf3QKBjx64VVmJrC+9/TiZuob1vtCokCL99mEvqCbG6t95lRnfVZ7l28grwM
         fWdfLfhDTMpEZetM5oOyPK0TWQG+4wE5mmNM9QIG6ZKSC/GBKGsFS4uewS3B83eQCum4
         xsViaRofA7HY7rjIDlXWG1oMc1s1KgppGEXBl+iNVHzdlcP7NFdCcjbkUYFCDCgHhfH6
         7OMv3d1ZLekwnI3gy6rlklcozg/XiTTFZthsFRRFhLmyd4ggjBgxqNH5YxT6bwYxeyxu
         JqBUkpAaAGJV94AvT3Msr/GemqZSIovOa9RryxVfx7dOZtSscQAIMylShLiSN8YSdnxx
         PVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8I2dcmWfMsSk6pQibuUG7vw4XZRdaUJSxw/t1am3k4=;
        b=BskkObkh2XRfBjmeaMaCR7qotByC0WW+6ygNjQDoJD5z4EZyQ3fr/bwA965fFFKhx8
         TD6lXOj00kKWk7lgPg0k+3EQhLL0+t4nIqkq92sEY3PB9cOmi8GTKK4ebsoueDtygd1c
         aXE7k06L9+TqY1Qnm/XPIMOAp1hcSicLMtG1Nng11Pr4SDRkjXOoOxS9T2+E2+Y+5XFF
         P/yV1CvEFoCoYBJoWgEFzw14sCYpjvQJHvnqJ60dEFo7b23e5PsDJZV5omfAwlVOhX9S
         7fTLB968utoi7IbCOW+bYwyNACIlZoP6GxsueoUoV/H2+PRTY8/Y/b4xEwvhefnWsB2r
         LrXw==
X-Gm-Message-State: AOAM532SReKkKjXhWOnc81HAMAYyDfEwHozWIlM56G8Af4bjMhTKQTsj
        61GLS+kIr0aG5i6LFMcSXX3Do/ahRGQ=
X-Google-Smtp-Source: ABdhPJy4q5EJn8Rc2842YGfx33UJZ2RPImAC4CrRXxkCDbm0Cmd2dfhHADlrdAvgbtbnISfUbD03eg==
X-Received: by 2002:a05:6000:18af:b0:1ea:85d3:a2d with SMTP id b15-20020a05600018af00b001ea85d30a2dmr3125110wri.621.1645723889531;
        Thu, 24 Feb 2022 09:31:29 -0800 (PST)
Received: from kali.home (2a01cb088e0b5b002be75de2a1caa253.ipv6.abo.wanadoo.fr. [2a01:cb08:8e0b:5b00:2be7:5de2:a1ca:a253])
        by smtp.gmail.com with ESMTPSA id w4sm3304216wre.102.2022.02.24.09.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 09:31:29 -0800 (PST)
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH BlueZ] src/shared/util.h: include sys/types.h
Date:   Thu, 24 Feb 2022 18:31:04 +0100
Message-Id: <20220224173104.479809-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Include sys/types.h to avoid the following build failure on musl raised
since commit fb57ad9b9d107856e5f1c8135da04ffa2f7a11ac:

In file included from src/shared/queue.c:15:
./src/shared/util.h:106:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?
  106 | ssize_t util_getrandom(void *buf, size_t buflen, unsigned int flags);
      | ^~~~~~~
      | size_t

Fixes:
 - http://autobuild.buildroot.org/results/83eaeb3863040645409f5787fdbdde79385c5257
---
 src/shared/util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index c01eccf8a..554481e1e 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -14,6 +14,7 @@
 #include <alloca.h>
 #include <byteswap.h>
 #include <string.h>
+#include <sys/types.h>
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define BIT(n)  (1 << (n))
-- 
2.34.1

