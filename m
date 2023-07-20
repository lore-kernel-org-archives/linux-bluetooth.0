Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E89C001DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 19:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjGTTCp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGTTCk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 15:02:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6312D70
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 12:02:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666ecf9a081so984355b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689879753; x=1690484553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbfdkufRNOJQU/a0ykvT+J03mTPh81jbTpSPr0lKDz8=;
        b=hDPcCkEHWVUMSpoECJ5d9QW1nc6hl/k8yuocd4DfhT4YJMHMWaAfbemtOrd1LFSQGT
         0dUH56vaRhj4qMvmpcz3i0bvN8fQ3xg19yLK7Q/BWQVDD7nMLL74j+dLLhJlm6ALXDvV
         LElezlOtoqGmpfa4+7nepYQ8ToETBSeHmoawZ7rdKAPYps44Pk/YTKg4Bas+z+CYWh8b
         UTH0Rgh1tKPtt+7UPhiK9WceHPuCADOsrtqoinMHPIB+olTcdyIF6uzKtgrT8I47qnHL
         zBlRDXUMHFiGDnsF57DY1mDKkQtb5Ygy7RfE5oPS5HdVViQAzPZV6d9TQaLJQSHtF6LT
         a0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879753; x=1690484553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbfdkufRNOJQU/a0ykvT+J03mTPh81jbTpSPr0lKDz8=;
        b=I6kZpcL5lSzpyc9/Ij2xXV6jLXTJBkaSItetJdZcYVpfUL126DAU/Z24t2dCPt1oH3
         CeigIQPOg13IGPeoRlJclgF6bT60mCe4dBSqUGT1ZXuwrsmol1llYd53W8nGzFx3w7im
         ng1p9c5RPlHzvUME1DynYnKloT+wh4L001c8gwvr9nk/rsq1HKzt9hLICTL6HeUV5xgI
         W9TPCPMWvNiS8qRL6wXeidC8FOWbU5PYYqgD8/htenyj6W9F3YIlH4xHgzxVVa9lhII+
         tGH2vhRkSu5Fly4MfZTsWyvVEHHtmo+w3UUp+yZDUIvdwb/8gNMBneJUAOcDytR8ezgJ
         2Cig==
X-Gm-Message-State: ABy/qLaBAb/AyNmhlEnoEAqgO87QGRThoMukLKzgdDkfAgUSn1X1Skgd
        ZsIhlJOslfd7wI5MrOxSoWhgzmsAO9U=
X-Google-Smtp-Source: APBJJlEAa+yCQVy8hSy3qre2BNjedsyzkPKkWcNy2I0XRZQ+9Jj0XY2WUUkvTwqbQbICJ3AIwlipsA==
X-Received: by 2002:a05:6a00:21d4:b0:686:22de:6365 with SMTP id t20-20020a056a0021d400b0068622de6365mr11524493pfj.8.1689879753554;
        Thu, 20 Jul 2023 12:02:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78283000000b00682a9325ffcsm1544496pfm.5.2023.07.20.12.02.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:02:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v5 3/3] client: Add bluetoothctl-monitor.1 man page
Date:   Thu, 20 Jul 2023 12:02:28 -0700
Message-ID: <20230720190228.446570-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720190228.446570-1-luiz.dentz@gmail.com>
References: <20230720190228.446570-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bluetoothctl-monitor.rst which is then converted to
bluetoothctl-mgmt.1 using rst2man.
---
 Makefile.tools                  |  6 ++-
 client/bluetoothctl-monitor.rst | 89 +++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 2 deletions(-)
 create mode 100644 client/bluetoothctl-monitor.rst

diff --git a/Makefile.tools b/Makefile.tools
index 10d29108ce19..0bc0f232da91 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -348,7 +348,8 @@ profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
 if MANPAGES
 man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1 \
-		tools/btmgmt.1 client/bluetoothctl-mgmt.1
+		tools/btmgmt.1 client/bluetoothctl-mgmt.1 \
+		client/bluetoothctl-monitor.1
 endif
 
 if MESH
@@ -470,7 +471,8 @@ manual_pages += tools/hciattach.1 tools/hciconfig.1 \
 			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1 \
 			tools/rctest.1 tools/l2ping.1 tools/btattach.1 \
 			tools/bdaddr.1 tools/isotest.1 tools/btmgmt.1 \
-			client/bluetoothctl-mgmt.1
+			client/bluetoothctl-mgmt.1 \
+			client/bluetoothctl-monitor.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
diff --git a/client/bluetoothctl-monitor.rst b/client/bluetoothctl-monitor.rst
new file mode 100644
index 000000000000..2357a56ace36
--- /dev/null
+++ b/client/bluetoothctl-monitor.rst
@@ -0,0 +1,89 @@
+====================
+bluetoothctl-monitor
+====================
+
+---------------
+Monitor Submenu
+---------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: July 2023
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**bluetoothctl** [--options] [monitor.commands]
+
+Monitor Commands
+================
+
+set-rssi-threshold
+------------------
+
+Set RSSI threshold parameter
+
+:Usage: **# set-rssi-threshold <low_threshold> <high_threshold>**
+
+set-rssi-timeout
+----------------
+
+Set RSSI timeout parameter
+
+:Usage: **# set-rssi-timeout <low_timeout> <high_timeout>**
+
+set-rssi-sampling-period
+-------------------------
+
+Set RSSI sampling period parameter
+
+:Usage: **# set-rssi-timeout <low_timeout> <high_timeout>**
+
+add-or-pattern
+--------------
+
+Register 'or pattern' type monitor with the specified RSSI parameters
+
+:Usage: **# add-or-pattern [patterns=pattern1 pattern2 ...]**
+
+get-pattern
+-----------
+
+Get advertisement monitor
+
+:Usage: **# get-pattern <monitor-id/all>**
+
+remove-pattern
+--------------
+
+Remove advertisement monitor
+
+:Usage: **# remove-pattern <monitor-id/all>**
+
+get-supported-info
+------------------
+
+Get advertisement manager supported features and supported monitor types
+
+:Usage: **# get-supported-info**
+
+print-usage
+-----------
+
+Print the command usage
+
+:Usage: **# print-usage <add-or-pattern>**
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
+
-- 
2.41.0

