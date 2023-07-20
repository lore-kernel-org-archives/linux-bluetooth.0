Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C6C001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 00:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGTA3U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jul 2023 20:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGTA3T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jul 2023 20:29:19 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0097F1A8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 17:29:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7658430eb5dso27708285a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 17:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689812956; x=1692404956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dA8wc46dxfw24mLtAU0WMcChEuY9TK9kc2Owzhe/cE=;
        b=n1mK8R9yyHKoIpDTnJEjYMK9l6M0gnfVAB4h0ZNejg8Qu0nVDV52I1BYdaR6Xx90kJ
         ZR5SFAt6HXdFJdfDf9bILOesD/aaqmQGapUcd1OK58oWzKjn5Z7FzokEIuY3B4ytT5h6
         upxD0+xaTGMMyx1yNKddqSo8Q9XFOPzVCiOjvQabQrT+FlAbfo1bh1L85tP3+Fn3b9a8
         Xe7mW+0kKK9RWMWdnlZ5gldVXi7nq8imUkWMyeXG8p3LVsIhnf+s543YhCEUJ5vghxc+
         +NZbJd01kGrUuedQr81he7EQ+sRI3FwEiGq7PCyW/ZNP4xKuxKJ7qHWjjMHqgD6w0v0i
         ywUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689812956; x=1692404956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dA8wc46dxfw24mLtAU0WMcChEuY9TK9kc2Owzhe/cE=;
        b=lei9MVcyPES3o038RhZRgEAlt3bhjkJgxGd+c/ltovHZR31v88Qpx/pdzVkAnQTbSQ
         h1ebdRwBWOYfBszPQzkw/U9EOftzTsAgr5A5bU353gqhQ9KR7kWU/TWoUCSBdUtGRe5l
         i1wwZ7QRDoK3O9lq1pqoi6bXVD2IXT+jGZqF7TZnVYbY2ppG0XWkiPfPXeRhpCn186e/
         eDDkRGGUUQy3FiuoFGFN5/Um5QhtPdA8DK0z6iZ5MvIuRsj+IMJlC48k+Kcr1cKEYx0q
         Tf6nSjVf0n4KwpiU5l7/U+uIeZOAOLySv3arTPxOmtW3mPn8fFuAK92mJXCvBZElOtNc
         0X/Q==
X-Gm-Message-State: ABy/qLYIPyMKXrEGIhswiG/zG9OCoFrmrNsPyiyWMbw3oOiP/4cQgFB0
        IiobSVZxR/BuEFsO0gLfulFSYLE6Bsk=
X-Google-Smtp-Source: APBJJlG1Ib4T6E0nhcxJOV/f3GFfTq/G2bxsyLQnXYPu0mw/OzITnpuQgDEDVkS5x7tXBVlZPr2EzA==
X-Received: by 2002:a05:620a:4001:b0:767:f50e:533 with SMTP id h1-20020a05620a400100b00767f50e0533mr26157894qko.77.1689812956277;
        Wed, 19 Jul 2023 17:29:16 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b007623c96430csm1619472qkm.111.2023.07.19.17.29.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 17:29:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 1/3] btmgmt: Add man page
Date:   Wed, 19 Jul 2023 17:29:11 -0700
Message-ID: <20230720002913.342733-1-luiz.dentz@gmail.com>
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
index 000000000000..8e3b5787ae9b
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
+is considered a low-level interface meant for the likes of **bluetoothd(1)**,
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

