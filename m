Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB479C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 21:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiC1V10 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 17:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiC1V1Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 17:27:24 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3580366BD
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 14:25:33 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id u13so2043681ilv.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUnZZkpAtCGYhG0xquYVq1FLXPsLmtJdyg3Y9Tk5yE8=;
        b=O6rtRJzLicCYIbgWpE6qYGUJ8O9F+YBEwnifJ2/uyKkEX4bBr1GcjN/WkKlcwNvop4
         EXXYq5qeqWplVwjO9kA6lbP+gpNyN+/2nnYm7qLdE/3FXsha4IgRM3idEDvrFOUJlkhU
         Jmip6ZxK4evrwJQQdp2iiaMaSQXeuooRYjN9CBTA8HeK6WTS6YSl0UcsmJ/gLCCZHwXa
         Io1NlKt0x5VZVc5xTnij2QRyvpB97pXFclfeZdX86I80inZxL7Dg/C9HwcGQaLtdQ9Zr
         20+37Ih11CQWErwHhBPaD01YyyNKuNEOVSJ0iiOkdl8x4Gqkwm/2xRUlCg6VNcRIDpgf
         TIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUnZZkpAtCGYhG0xquYVq1FLXPsLmtJdyg3Y9Tk5yE8=;
        b=XEyqReTFeW327iFofAMXUi46y62XT0/qtZ6Fcapk5dQDoxT2iUad+jI6cZEpV5c6q2
         4aN6tMSPnTzG2hKXgGDWw1PHhBcrj0iK3QRUZNOnao5H21lk+srkfPTYhppV2R235lvd
         OtRRw2bPvAYBE/vGVwVHl11zV2jjpnxY326/qk4DDGkN7EhFs3S0wniVV2Onlw8bbGwv
         x5rWiOecDYJhziSXfo1aDYfMQue0Vyu/JgxkfAKGnjH9PhR2hly0H8iWMHVl7X49O0oI
         6QZQuh/vR5c7JnpGgn1kYoE/9viVy0rV46Y7Lew2o+VoSb9mLe8e79h0vaksBmOMd65/
         1S9w==
X-Gm-Message-State: AOAM532gnGAUb6r4YDoHr47DuENbQs9WxFtchk3hu7icjd3EUQYNoggV
        ys8NFzWWXnJZgBoSDUUPBliO0DRGU8c=
X-Google-Smtp-Source: ABdhPJw1CxD+7DxSMRrFx+3Ngf8W5RJRdpGYmL7ssrdi5YiNw6H6V0PRSZdaIBY0XjIB7p6fcYxgsA==
X-Received: by 2002:a92:ca06:0:b0:2c6:250d:bc53 with SMTP id j6-20020a92ca06000000b002c6250dbc53mr7095580ils.253.1648502719777;
        Mon, 28 Mar 2022 14:25:19 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n3-20020a056e0208e300b002c9c9974c48sm925030ilt.36.2022.03.28.14.25.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:25:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shell: Make bt_shell_add_submenu set main menu if none has been set
Date:   Mon, 28 Mar 2022 14:25:17 -0700
Message-Id: <20220328212518.1890451-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If not main menu has been set when calling bt_shell_add_submenu then
turns it on it main menu.
---
 src/shared/shell.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 0d82bc282..7ba264b99 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1248,6 +1248,9 @@ bool bt_shell_add_submenu(const struct bt_shell_menu *menu)
 	if (!menu)
 		return false;
 
+	if (!data.main)
+		return bt_shell_set_menu(menu);
+
 	if (!data.submenus)
 		data.submenus = queue_new();
 
-- 
2.35.1

