Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4477ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 21:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiH2Vho (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiH2Vhm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 17:37:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74A82D19
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 14:37:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so9916968pjj.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=EeANEH16Ms+JkkMMUAw9jnizxEOLZbp4y3uAH4CSXVI=;
        b=coeQ5XDgiBPBfpTCLTA5k3CaIGUF8wVYSbrUiqfdSy2gLZ61O4bIjunKVXjmkoX0IB
         iVeGCKRHhaqgTuq+w0g0kzA4gPFy8HWMsZydbORPZC4EGSe/11k3jSZ0xVE5uIV19xdN
         0jz1zQlvoWylcPBvftTZ2HQ+d81Ke5qQ366vV7feVWVabpu+gxyA+Pj3FqRjE0xn0nXP
         xHbPoUWxz7nit5T6RxGQDgB3R97DuT43KvZuRVLJlgKCLzlewUrtbrmRVn2oTM38axgR
         YcFZzcQ8kOZqWmdaCfVJRxZD9bV8wniJFSWbpw+hHfRUUFwKSj8PaLTxKGE3SY3iuzX+
         jDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=EeANEH16Ms+JkkMMUAw9jnizxEOLZbp4y3uAH4CSXVI=;
        b=O7HhHbFGMOSoq8hfrnNXuBwmSIdbQebu+cLgKnaIEw+jONkJqYe06HSrnBLCDnh+Yd
         4zkBKpzvdRDz9Ap12Zq34JIDI1k16H7lpp+36WoCQ+/6BgFO52nEKZQSIkQdlrxvkz9P
         wrkEaehBW2LtfyGz9aTRRJW/79+PtRZOKwwRyPK35RzX4Rujt3915H3W7LHmyH/BWjYn
         BUqVFA+jTtNcEc2vAjvOu7jDgHwjUFvRyy4X9Inb7ncHly2x18CDIua30yhOAapunkFy
         bXfgGTQutSrllRUnP7NTfIwXGOC3rR/TImcsye6uvO3adjxoU7dCPvgy377muEFw8wPw
         eAkA==
X-Gm-Message-State: ACgBeo063LkmDdHmpkRCWksbVKQ6dfATY+ZshSyfgx3ov8uiBL3DCPnb
        KPQV00x5/caHOkRZkaH4KxXMPC3pGRTMUw==
X-Google-Smtp-Source: AA6agR5SjSyzdVT1exK4BsA2vUoGJ26dQhPiCT5CauY9DFNME5LWceWbVeWvZz+BWwH49/m3WEy6SA==
X-Received: by 2002:a17:902:d2c1:b0:16e:ea4e:36d3 with SMTP id n1-20020a170902d2c100b0016eea4e36d3mr18076660plc.98.1661809060843;
        Mon, 29 Aug 2022 14:37:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p186-20020a62d0c3000000b005367c28fd32sm7722765pfg.185.2022.08.29.14.37.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:37:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shell: Set empty argument if optarg is NULL
Date:   Mon, 29 Aug 2022 14:37:37 -0700
Message-Id: <20220829213738.779598-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets enmpty string ("") when argument don't set any optarg so the
application can tell when an option was set or not.
---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index dfda8128af91..4658819a4bde 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1158,7 +1158,7 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 				return;
 			}
 
-			*opt->optarg[index - offset] = optarg;
+			*opt->optarg[index - offset] = optarg ? : "";
 		}
 
 		index = -1;
-- 
2.37.2

