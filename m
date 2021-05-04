Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034BCC43461
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D237F611EE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhEDFDI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 01:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhEDFDG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 01:03:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE6AC061761
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 22:02:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h127so1481122pfe.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 22:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u25XIoVqobuwLiKTDjDkOMzO6oFDEJLZN1uFbvtpCII=;
        b=eZDhIVhCZTnKHUZCkEL7js5P/pRCpN1TtCSH4K+MrRZ+jVAOE1TSJ/Wxr5KVSN93fI
         JKMDLV0Q1HKz695bSVhq3vgtII/Oth8j+l9v9T8CB0gjnDnPIgq+HI5GYenZYXhDwBuE
         8UQY7ZmzeF1O4CCMUDwz3vAdIUOaJaPd1klBzWWccUutsauKf+PxX0T97NwCqmrVE/4Z
         IvATif8+f2Ta/OeR2CKO1VoXwXEQlv78ijxH64b0wuKcN5pnr9GL7FRFtOUQPeQj6yzV
         pN83P7lM4kbWwg0XOuWf2uZmll8yxefXaop6SjEAWT6V43sq1JjW3P5Ew/r0Ltzkj1wd
         prFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u25XIoVqobuwLiKTDjDkOMzO6oFDEJLZN1uFbvtpCII=;
        b=jYHbc1fEaN9ERf08KkRgeXJo3DhxHeMxoN4mVtKpyXf7F2NKttKBGDRO6xmV3hCorU
         IP6Kzy6LZnM2ys1rmus/ltYGc3Z/jlcEVBZ70ygkflGDsRJv+zjY9pCViHIFbgH5qAEH
         nAFnfYyNo6gZ1Tth+AJBUYKaE6aBREV1sz1zGw06Qw4WyWThsJkvFfOQTvTB5nZcW7+s
         iINL0PGh6b4GjLAbgb6+RVVLwr1VmCP8UDoxdGImB6O+gb0gHKyLpHhd6nYGvcLh2eZy
         qpgiBjTYPToJDy0wUwbEWG/1nSkuxVGG7KVIJ3TFheyaffaR3WHknG1KVG6qtEs0nBbs
         3S5g==
X-Gm-Message-State: AOAM5323dbUp5WsqZVT8bRgwla2iECNvgNkcD5U5LMC84bbTfv2bpQvu
        6huKBow2g4Tf+Le20CRhX2c3kTdth5W0tw==
X-Google-Smtp-Source: ABdhPJyeZ5nv/y5Q5ozewL7AT1xTlzj8d9FdlDqAXkZFqo/mKT+/qtMje25MsE4tKiGS/w1wEe6PTQ==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr2764620pjb.62.1620104531019;
        Mon, 03 May 2021 22:02:11 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id m20sm1508385pjq.40.2021.05.03.22.02.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 22:02:10 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 3/4] src: Convert manpage to rst format
Date:   Mon,  3 May 2021 22:02:06 -0700
Message-Id: <20210504050207.841261-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210504050207.841261-1-hj.tedd.an@gmail.com>
References: <20210504050207.841261-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch converts the existing manpage for bluetoothd into
reStructuredText format.
---
 Makefile.am           |  5 ++-
 configure.ac          |  2 +-
 src/bluetoothd.8.in   | 63 --------------------------------
 src/bluetoothd.rst.in | 84 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 65 deletions(-)
 delete mode 100644 src/bluetoothd.8.in
 create mode 100644 src/bluetoothd.rst.in

diff --git a/Makefile.am b/Makefile.am
index 4e9cae885..52e0e9ed8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -345,7 +345,7 @@ CLEANFILES += $(builtin_files) src/bluetooth.service
 if MANPAGES
 man_MANS += src/bluetoothd.8
 endif
-EXTRA_DIST += src/bluetoothd.8
+manual_pages += src/bluetoothd.8
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -631,6 +631,9 @@ endif
 %.1: %.rst Makefile
 	$(RST2MAN_PROCESS)
 
+%.8: %.rst Makefile
+	$(RST2MAN_PROCESS)
+
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
diff --git a/configure.ac b/configure.ac
index d7e4766e4..f445589b0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -412,4 +412,4 @@ fi
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
-AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
+AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc)
diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
deleted file mode 100644
index d61dcc5b3..000000000
--- a/src/bluetoothd.8.in
+++ /dev/null
@@ -1,63 +0,0 @@
-.\"
-.TH "BLUETOOTHD" "8" "March 2004" "Bluetooth daemon" "System management commands"
-.SH "NAME"
-bluetoothd \- Bluetooth daemon
-
-.SH "SYNOPSIS"
-.B bluetoothd [--version] | [--help]
-
-.B bluetoothd [--nodetach] [--compat] [--experimental] [--debug=<files>] [--plugin=<plugins>] [--noplugin=<plugins>]
-
-.SH "DESCRIPTION"
-This manual page documents briefly the
-.B bluetoothd
-daemon, which manages all the Bluetooth devices.
-.B bluetoothd
-can also provide a number of services via the D-Bus message bus
-system.
-.SH "OPTIONS"
-.TP
-.B -v, --version
-Print bluetoothd version and exit.
-.TP
-.B -h, --help
-Print bluetoothd options and exit.
-.TP
-.B -n, --nodetach
-Enable logging in foreground. Directs log output to the controlling terminal \
-in addition to syslog.
-.TP
-.B -f, --configfile
-Specifies an explicit config file path instead of relying on the default path \
-(@CONFIGDIR@/main.conf) for the config file.
-.TP
-.B -d, --debug=<file1>:<file2>:...
-Sets how much information bluetoothd sends to the log destination (usually \
-syslog's "daemon" facility). If the file options are omitted, then debugging \
-information from all the source files are printed. If file options are \
-present, then only debug prints from that source file are printed. The option \
-can be a pattern containing "*" and "?" characters.
-
-Example: --debug=src/adapter.c:src/agent.c
-.TP
-.B -p, --plugin=<plugin1>,<plugin2>,..
-Load these plugins only. The option can be a pattern containing "*" and "?" \
-characters.
-.TP
-.B -P, --noplugin=<plugin1>,<plugin2>,..
-Never load these plugins. The option can be a pattern containing "*" and "?" \
-characters.
-.TP
-.B -C, --compat
-Provide deprecated command line interfaces.
-.TP
-.B -E, --experimental
-Enable experimental interfaces. Those interfaces are not guaranteed to be
-compatible or present in future releases.
-.SH "FILES"
-.TP
-.I @CONFIGDIR@/main.conf
-Location of the global configuration file.
-
-.SH "AUTHOR"
-This manual page was written by Marcel Holtmann, Philipp Matthias Hahn and Fredrik Noring.
diff --git a/src/bluetoothd.rst.in b/src/bluetoothd.rst.in
new file mode 100644
index 000000000..6bce349ef
--- /dev/null
+++ b/src/bluetoothd.rst.in
@@ -0,0 +1,84 @@
+==========
+bluetoothd
+==========
+
+----------------
+Bluetooth daemon
+----------------
+
+:Authors: - Marcel Holtmann
+          - Philipp Matthias Hahn
+          - Fredrik Noring
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: March, 2004
+:Manual section: 8
+:Manual group: System management commands
+
+SYNOPSIS
+========
+
+**bluetoothd** [--version] | [--help]
+
+**bluetoothd**  [--nodetach]  [--compat] [--experimental] [--debug=<*files*>]
+[--plugin=<*plugins*>] [--noplugin=<*plugins*>]
+
+DESCRIPTION
+===========
+
+This manual page documents briefly the **bluetoothd** daemon, which manages
+all the Bluetooth devices. **bluetoothd** can also provide a number of services
+via the D-Bus message bus system.
+
+OPTIONS
+=======
+
+-v, --version       Print bluetoothd version and exit.
+
+-h, --help          Print bluetoothd options and exit.
+
+-n, --nodetach      Enable logging in foreground. Directs log output to the
+                    controlling terminal in addition to syslog.
+
+-f, --configfile    Specifies an explicit config file path instead of relying
+                    on the default path(*@CONFIGDIR@/main.conf*)
+                    for the config file.
+
+-d, --debug=<file1>:<file2>:...
+    Sets how much information bluetoothd sends to the log destination (usually
+    syslog's "daemon" facility). If the file options are omitted, then
+    debugging information from all the source files are printed. If file
+    options are present, then only debug prints from that source file are
+    printed. The option can be a pattern containing "*" and "?" characters.
+
+    Example: --debug=src/adapter.c:src/agent.c
+
+-p, --plugin=<plugin1>,<plugin2>,..
+    Load these plugins only. The option can be a pattern containing  "*" and
+    "?" characters.
+
+-P, --noplugin=<plugin1>,<plugin2>,..
+    Never load these plugins. The option can be a pattern containing "*" and
+    "?"  characters.
+
+-C, --compat        Provide deprecated command line interfaces.
+
+-E, --experimental  Enable experimental interfaces. Those interfaces are not
+                    guaranteed to be compatible or present in future releases.
+
+FILES
+=====
+
+*@CONFIGDIR@/main.conf*
+    Location of the global configuration file.
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
2.26.3

