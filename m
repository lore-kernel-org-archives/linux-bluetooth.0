Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1CDC001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 00:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGTA3Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jul 2023 20:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjGTA3W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jul 2023 20:29:22 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AD91A8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 17:29:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76731802203so24791185a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689812960; x=1692404960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yA6UUXyFTO5GmXU2zsZoTlaLvLg/A1iycqt2aCfaztw=;
        b=HwrJ/CjO5myzwDIpIsle4u+YBT5DbD/42kq8rssi5BncEnp374kaXEt7Mvm74dKYSb
         VaLGMi14kGyMdlNZwsSalk1iPxZcEHZb1EzvEQairGXuymVaggLe+ujFacG+iOmHsKXF
         YDrxfSYkB7mIMReyAQpPult9P3HPfcPU0avEos0RJUswByIi51kT38t5MZB5QNFeHgB9
         frBqJO+rqb8O5RUZ9Cum5nIDl4LA0GJxaovWOULBnb7Hhs4AvYQQh+C84vzHUFFpS1+4
         a0GJNRXl5KalQpmZP47loI+VHfMA1/tQymDSfuOfUO/EJyWa/JfCZfpd+b6N9CEwLdSN
         n66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689812960; x=1692404960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA6UUXyFTO5GmXU2zsZoTlaLvLg/A1iycqt2aCfaztw=;
        b=aHsBm9jykV17wkZtR7YRYLZOYFKYEPMhZgEUj8yi0Yx3itfc66VaDDvro1wum6PtV9
         MQ4AYNf620RAVl1H4rmq0hm21gy9Gj11SmIcuhVUV8XM4eDGVUQFUWNH28aQX8wHgXdK
         pUmwxeP/JKh34YgQz2oR+AaRPZYrBgKModYUXDfpZkxRC8N/DYBLlFtVNKegFjPgufw2
         1nBSJ7QxbFPHU0zReZdfBaFhYz+J9LLFoCVgfAGe2qoE5uPIbGOWQ6K4oJs0XOaYzkvv
         qgNu66LDkMDi/RAz54VIbHM+0MTH5VSaPR8ieW0XX1PiTLxVgwbYZ5dnTlPViRDtmrqI
         807Q==
X-Gm-Message-State: ABy/qLYR7FGeeDiwN1M0LgLSsJgamstROMg2mQJy4J2RlY6xJ95U7XAs
        isaY0ZWfDAx0bCe+YiOuUfeTJnQXeCI=
X-Google-Smtp-Source: APBJJlGJqA4jutSGqonEeP8+fPZViMCEPhTua1Km4Z5WbZ8Bt1WpeVQ20a0sbXGiJtXLoqKr677eCw==
X-Received: by 2002:a05:620a:4707:b0:767:eb51:ac27 with SMTP id bs7-20020a05620a470700b00767eb51ac27mr24347225qkb.5.1689812959925;
        Wed, 19 Jul 2023 17:29:19 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b007623c96430csm1619472qkm.111.2023.07.19.17.29.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 17:29:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 3/3] client: Add bluetoothctl-monitor.1 man page
Date:   Wed, 19 Jul 2023 17:29:13 -0700
Message-ID: <20230720002913.342733-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720002913.342733-1-luiz.dentz@gmail.com>
References: <20230720002913.342733-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bluetoothctl-monitor.rst which is then converted to
bluetoothctl-mgmt.1 using rst2man.
---
 Makefile.tools                  |  3 +-
 client/bluetoothctl-monitor.rst | 89 +++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 client/bluetoothctl-monitor.rst

diff --git a/Makefile.tools b/Makefile.tools
index 6c5835bbd65d..09e41dd07469 100644
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

