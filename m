Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1552EC001DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 19:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGTTCl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjGTTCi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 15:02:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F7E2D51
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 12:02:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6689430d803so771676b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689879750; x=1690484550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/+mox3v2KbxXdDwh9oMGpsXq/Zi8ycYrIlIRRzL0a4=;
        b=UCN0Ye/1Dj2O2vzSLL3zQkrHIEwDbvH4rF15zJBgFDeN6hN1AelC4skT0WoQPMQG9U
         68sJwc7/573z17dlcqvm6N/45jnYrcVESZ2BlINMOuaI2j5VZmnHe2j3JVmcQgBT4M0q
         UQeGqEVZNjfNFJkoSUsY4EQKszC4eApY19Uu794zamGDa/1qqTW4zI2iIi/KZPWz+gsr
         619F6V1XsCOWCGQeUjV6JHEtJeE0XTbPYr47W2Bb9Pd+Bnd4SrWEy3I+C6PgOCPFcNq/
         UyKnA7A2sUz2lf9Qtzd39kyrGaWX+sSIHZTRQ+3diQGEWdhXODdbVbD2f2ElRfYID2xk
         S/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879750; x=1690484550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/+mox3v2KbxXdDwh9oMGpsXq/Zi8ycYrIlIRRzL0a4=;
        b=innifFa/uUNnRhW4ZPYuIhruU2m5rp6sgqD6KgDLL0cRORoUWKQxUftT4sNH2fqPmy
         54X3Aftr6TjFbY+jvQDGQpjdnkTcq4SpIEb4+DGzCtmULwTNSY4UUr4LRDUQnFAxmw+l
         Omc7NpRktH/Wm6GQBBNCoZAdbrRjgt4tqxlcpKtwdUPNuSNy2ak6+wMF8pi374JYvbLE
         XBpj9dQRlciV42imlVA4AM/80UIAuvBVIc1gV09ts8y/dR1/tZx62fHJxyxCcau08zPJ
         3Xd667Z6ePWNJDIXksRw649c9ExJ1X/VzO3OffFIwNDKWaIQzm4m/V7gLV+pW/KudbD6
         5D7A==
X-Gm-Message-State: ABy/qLY7LArVeueVuUgINkM/0j9awdyg+yqo59/36zA/y98lSe1XsEIS
        fCT3cYIm5eKUGvbN1E4JYa30Qbw32Dc=
X-Google-Smtp-Source: APBJJlFuU7kRhvYPqnwPqP3zolBsXPSYW22vm8nVKNKxGYqHpqF7R7qY3pE1MG2hQtrYGkdRnU2t2g==
X-Received: by 2002:a05:6a00:1808:b0:668:8705:57dd with SMTP id y8-20020a056a00180800b00668870557ddmr3413232pfa.28.1689879749742;
        Thu, 20 Jul 2023 12:02:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78283000000b00682a9325ffcsm1544496pfm.5.2023.07.20.12.02.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:02:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v5 1/3] btmgmt: Add man page
Date:   Thu, 20 Jul 2023 12:02:26 -0700
Message-ID: <20230720190228.446570-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btmgmt.rst which is then converted to btmgmt.1 using rst2man.
---
 Makefile.tools   |  5 +--
 tools/btmgmt.rst | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 tools/btmgmt.rst

diff --git a/Makefile.tools b/Makefile.tools
index 7d9697001b75..c1de187bf72b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -347,7 +347,8 @@ profiles_iap_iapd_SOURCES = profiles/iap/main.c
 profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
 if MANPAGES
-man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1
+man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1 \
+		tools/btmgmt.1
 endif
 
 if MESH
@@ -468,7 +469,7 @@ manual_pages += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
 			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1 \
 			tools/rctest.1 tools/l2ping.1 tools/btattach.1 \
-			tools/bdaddr.1 tools/isotest.1
+			tools/bdaddr.1 tools/isotest.1 tools/btmgmt.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
diff --git a/tools/btmgmt.rst b/tools/btmgmt.rst
new file mode 100644
index 000000000000..0159ee128f62
--- /dev/null
+++ b/tools/btmgmt.rst
@@ -0,0 +1,79 @@
+======
+btmgmt
+======
+
+-------------------------------------
+interactive bluetooth management tool
+-------------------------------------
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
+**btmgmt** [--options] [commands]
+
+DESCRIPTION
+===========
+
+**btmgmt(1)** interactive bluetooth management tool. The tool issues commands
+to the Kernel using the Bluetooth Management socket, some commands may require
+net-admin capability in order to work since the Bluetooth Management interface
+is considered a low-level interface meant for the likes of **bluetoothd(8)**,
+it is not recommended for applications to use it directly as it may result in
+unexpected behavior.
+
+OPTIONS
+=======
+
+:-i/--index: Specify adapter index
+:-m-/-monitor: Enable monitor output
+:-t/--timeout: Timeout in seconds for non-interactive mode
+:-v/--version: Display version
+:-i/--init-script: Init script file
+:-h/--help: Display help
+
+COMMANDS
+========
+
+:main: See **bluetoothctl-mgmt(1)**
+:monitor: See **bluetoothctl-monitor(1)**
+
+AUTOMATION
+==========
+
+Two common ways to automate the tool are to pass the commands directly like in
+the follow example:
+
+.. code-block::
+
+    btmgmt <<EOF
+    list
+    show
+    EOF
+
+Or create a script and pass it as init-script:
+
+.. code-block::
+
+    $ vi test-script.bt
+    list
+    show
+    quit
+    :wq
+    $ btmgmt --init-script=test-script
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
-- 
2.41.0

