Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DEFC43460
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A67B6139A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhEDFDH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 01:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDFDG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 01:03:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E5BC061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 22:02:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t22so5698940pgu.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 22:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lDzNN+8kFjAwC9cd7rrJcQ2maIfc7/D0ME3NRvAnLqQ=;
        b=t8cMQsotHYE7H50YFU8iBmk0zNylRbroHFaEPHPQW2mQ5aBNmZxvsfl8OiN7PIkOBd
         tM2D47oWp8kXAP6UAk1/QjAgCVvH++imJQ0N57Ukij7QjrX3hqWIk+EwKOC/dLix+zU8
         RB4jWFW+47Yi2U62Ph0PTApN57Grih9uHQqKOlCEZKFVkgzbDtboaJbTrTSc1mfMYysU
         inRRfG04szRgPQ2T8nf5+dRR5kmhwf5W/CXJKCVjMBBnDFMzXGjf1MvfZ8N0OJ4c4lDt
         I8IV67H7OODCw7qFnU9dt7A/3nvKj8vzF79PwFJ3su/Wp/fn7Zylr1AM0TZeHETNN4og
         dfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDzNN+8kFjAwC9cd7rrJcQ2maIfc7/D0ME3NRvAnLqQ=;
        b=JuYjfsnwy9w2sTc0dOmXgdgT078ji++KcwUujJR3CkR+M5l7VaX3yJiOQT4J30n7al
         zfILrcLnpoGNm/q5sx9fHS+PLwM4n+KKXRuhmBVVLUhYrZ2cdF67vZ0N7lSuBSoBuX9E
         z6c3BPLJ0epMbPmH8Khx6R5nHokaEeQFGiim/ucYZk+UGrddAXaK10OV66tM/M0+mWO1
         aqpmuQJvZehMNSAt+XEqCTXJwJux4wjtMQX1DXG3TUOKEKV3EGET1KPrIR5DlOLv4zKS
         5QS8GEPLy8ssJP/U/3d4bkIISoAx8b52y9IjNis5MHKBcjwyly9HrDz4Tji/eE9dML00
         3wZA==
X-Gm-Message-State: AOAM530xQ90TZ+XuXHP/3zZfWBPUK1UkobS6H3+diDPp9qM4tDBdJptL
        yFR5wYd1bipEpDrgk4nj6V77+mMqkFgFUg==
X-Google-Smtp-Source: ABdhPJw8VJH+wMxPt8lX624YXRm1pS+PDUp0LOQHwZtK9kZJMbDgd+7yX9J69zL/QbkEYEKPk9S4yw==
X-Received: by 2002:a63:7c42:: with SMTP id l2mr21448751pgn.98.1620104530478;
        Mon, 03 May 2021 22:02:10 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id m20sm1508385pjq.40.2021.05.03.22.02.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 22:02:10 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 2/4] monitor: Convert manpage to rst format
Date:   Mon,  3 May 2021 22:02:05 -0700
Message-Id: <20210504050207.841261-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210504050207.841261-1-hj.tedd.an@gmail.com>
References: <20210504050207.841261-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support to convert reStructuredText formatted btmon
manpage to manpage with rst2man tool.
---
 Makefile.am       |  15 +++-
 Makefile.tools    |   4 +-
 configure.ac      |   4 ++
 doc/btmon.txt     |  35 ----------
 monitor/btmon.rst | 171 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 189 insertions(+), 40 deletions(-)
 delete mode 100644 doc/btmon.txt
 create mode 100644 monitor/btmon.rst

diff --git a/Makefile.am b/Makefile.am
index cb0d5fc0a..4e9cae885 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -594,7 +594,7 @@ if LIBRARY
 pkgconfig_DATA = lib/bluez.pc
 endif
 
-EXTRA_DIST += $(manual_pages:.1=.txt)
+EXTRA_DIST += $(manual_pages:.1=.rst)
 
 DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
 						--enable-health \
@@ -616,11 +616,20 @@ SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
 		$(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
 		< $< > $@
 
+if RUN_RST2MAN
+RST2MAN_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
+			$(RST2MAN) --strict --no-raw \
+			--no-generator --no-datestamp $< $@
+else
+RST2MAN_PROCESS = $(AM_V_GEN)test -f $@ || \
+		{ echo "Generated manual page $@ does not exist"; false; }
+endif
+
 %.service: %.service.in Makefile
 	$(SED_PROCESS)
 
-%.1: %.txt
-	$(AM_V_GEN)a2x --doctype manpage --format manpage $(srcdir)/$<
+%.1: %.rst Makefile
+	$(RST2MAN_PROCESS)
 
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
diff --git a/Makefile.tools b/Makefile.tools
index 160272212..a39e3e334 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -51,10 +51,10 @@ monitor_btmon_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la $(UDEV_LIBS) -ldl
 
 if MANPAGES
-man_MANS += doc/btmon.1
+man_MANS += monitor/btmon.1
 endif
 endif
-manual_pages += doc/btmon.1
+manual_pages += monitor/btmon.1
 
 if LOGGER
 pkglibexec_PROGRAMS += tools/btmon-logger
diff --git a/configure.ac b/configure.ac
index dbd98c9ad..d7e4766e4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -326,7 +326,11 @@ AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" != "no")
 AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
 			[enable building of manual pages]),
 					[enable_manpages=${enableval}])
+if (test "${enable_manpages}" != "no"); then
+	AC_CHECK_PROGS(RST2MAN, [rst2man rst2man.py], "no")
+fi
 AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
+AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" = "yes" && test "${RST2MAN}" != "no")
 
 AC_ARG_ENABLE(testing, AC_HELP_STRING([--enable-testing],
 			[enable testing tools]),
diff --git a/doc/btmon.txt b/doc/btmon.txt
deleted file mode 100644
index 7a7fc537b..000000000
--- a/doc/btmon.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-BTMON(1)
-========
-:doctype: manpage
-
-
-NAME
-----
-btmon - Bluetooth monitor
-
-
-SYNOPSIS
---------
-*btmon* ['OPTIONS']
-
-
-DESCRIPTION
------------
-The btmon(1) command provides access to the Bluetooth subsystem monitor
-infrastructure for reading HCI traces.
-
-
-AUTHOR
-------
-btmon was originally written by Marcel Holtmann.
-
-
-RESOURCES
----------
-See <http://www.bluez.org/>
-
-
-COPYING
--------
-Free use of this software is granted under ther terms of the GNU Lesser
-General Public Licenses (LGPL).
diff --git a/monitor/btmon.rst b/monitor/btmon.rst
new file mode 100644
index 000000000..c59fdde62
--- /dev/null
+++ b/monitor/btmon.rst
@@ -0,0 +1,171 @@
+=====
+btmon
+=====
+
+-----------------
+Bluetooth monitor
+-----------------
+
+:Authors: - Marcel Holtmann <marcel@holtmann.org>
+          - Tedd Ho-Jeong An <tedd.an@intel.com>
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Version: BlueZ
+:Date: April 2021
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSYS
+========
+
+**btmon** [*OPTIONS* ...]
+
+DESCRIPTION
+===========
+
+The  btmon(1) command  provides  access  to the Bluetooth subsystem monitor
+infrastructure for reading HCI traces.
+
+OPTIONS
+=======
+
+-r FILE, --read FILE        Read traces in btsnoop format from *FILE*.
+-w FILE, --write FILE       Save traces in btsnoop format to *FILE*.
+-a FILE, --analyze FILE     Analyze traces in btsnoop format from *FILE*.
+                            It displays the devices found in the *FILE* with
+                            its packets by type.
+-s SOCKET, --server SOCKET  Start monitor server socket.
+-p PRIORITY, --priority PRIORITY  Show only priority or lower for user log.
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+   :stub-columns: 1
+
+   * - *PRIORITY*
+     - NAME
+
+   * - **3**
+     - Error
+
+   * - **4**
+     - Warning
+
+   * - **6**
+     - Information (Default)
+
+   * - **7**
+     - Debug. **debug** can be used.
+
+-i NUM, --index NUM         Show only specified controller. *hciNUM* is also
+                            acceptable. This is useful to capture the traces
+                            from the specific controller when the multiple
+                            controllers are presented.
+
+-d TTY, --tty TTY           Read data from *TTY*.
+
+-B SPEED, --rate SPEED      Set TTY speed. The default *SPEED* is 115300
+
+-V COMPID, --vendor COMPID  Set the default company identifier. The *COMPID* is
+                            a unique number assigned by the Bluetooth SIG to
+                            a member company and can be found/searched from the
+                            Bluetooth SIG webpage.
+
+                            For example, Intel is 2 and Realtek is 93.
+
+-M, --mgmt                  Open channel for mgmt events.
+
+-t, --time                  Show a time instead of time offset.
+
+-T, --date                  Show a time and date information instead of
+                            time offset.
+
+-S, --sco                   Dump SCO traffic in raw hex format.
+
+-A, --a2dp                  Dump A2DP stream traffic in a raw hex format.
+
+-E IP, --ellisys IP         Send Ellisys HCI Injection.
+
+-P, --no-pager              Disable pager usage while reading the log file.
+
+-J OPTIONS, --jlink OPTIONS     Read data from RTT.  Each options are comma(,)
+                                seprated without spaces.
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+   :stub-columns: 1
+
+   * - *OPTIONS*
+     - Description
+
+   * - **DEVICE**
+     - Required. Set the target device.
+
+   * - **SERIALNO**
+     - (Optional) Set the USB serial number. Default is **0**.
+
+   * - **INTERFACE**
+     - (Optional) Target interface. Default is **swd**.
+
+   * - **SPEED**
+     - (Optional) Set target interface speed in kHz. Default is **1000**.
+
+-R OPTIONS, --rtt OPTIONS   RTT control block parameters. Each options are
+                            comma(,) seprated without spaces.
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+   :stub-columns: 1
+
+   * - *OPTIONS*
+     - Description
+
+   * - **ADDRESS**
+     - (Optional) Address of RTT buffer. Default is **0x00**
+
+   * - **AREA**
+     - (Optional) Size of range to search in RTT buffer. Default is **0**
+
+   * - **NAME**
+     - (Optional) Buffer name. Default is **btmonitor**
+
+-C WIDTH, --columns WIDTH   Output width if not a terminal
+
+-c MODE, --color MODE       Set output color. The possible *MODE* values are:
+                            **auto|always|never**.
+
+                            Default value is **auto**
+
+-v, --version               Show version
+
+-h, --help                  Show help options
+
+EXAMPLES
+========
+
+Capture the traces from hci0 to hcidump.log file
+------------------------------------------------
+
+.. code-block:: bash
+
+   $ btmon -i hci0 -w hcidump.log
+
+Open the trace file
+-------------------
+
+.. code-block:: bash
+
+   $ btmon -r hcidump.log
+
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

