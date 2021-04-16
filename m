Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CBFC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 05:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CB161103
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 05:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhDPF40 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 01:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhDPF40 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 01:56:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E37C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 22:56:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d8so13381278plh.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Apr 2021 22:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5hK9mwe7yNzOikrmifuDlytwvVqDnrjH4YxG88PQ7n0=;
        b=O6lgANrXmV/YPVaW2XdOiDfuXcwnlclUt0u+5bO+MQBfrnTNnb8bwbNwM9bNVLxRf/
         zwLM1tKm71MjjZvKboLhEi4dKUqsEdMpRgxqKpZ8aw6aIFnOvbIlPsVO1QB5S1fXCdQO
         vgg+ToGJLSzAe/R/rf8FCfptIEKtB+9s4RQAkXFkcEXmEtI+qCHn8bQlUqzTC4LcPk8G
         XyVnMj8hljJtcZ9/msnj79HqHCVfC+VTbIlh3OMgKRt0jMF6plpCGVPscvIZp8peTqfL
         iaPmE+tc8dJvpjIiMCyASjSA5jOSusCBLue/dtaZZs/OGTlB/j8kO8OlEz7166NzxMgL
         8I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hK9mwe7yNzOikrmifuDlytwvVqDnrjH4YxG88PQ7n0=;
        b=WzDoGDE2chtjuMQOyL3CHtnSP48Zcgg0Gpjp8+h6xBjC+uGRRuyAp4Ft2kD8byiAGs
         kYv2jr6PpIbQLb0sV5XGmXRqaWUjtXFAcvY1s59lTURLAUM1Em0vqv+9mZLPtfOIztne
         1S9CUOE9+rfic3+R317IfUUjwBZ+dYw96z/DNwzl7nvGW60GnRZZ9qnlaZV8d5Fh2Zoi
         hYu3BI6pDBmEtzb41BzT1Njhiz/k52qj4GJxCYgaHZfHkjow94kMp5IONO0WDvEdzKv3
         KFr6pi/nqNCTUw4jeAO1YUb3HBeevOQJz0DXiF+Y01qk43TNDWCz7iHR9h3siUoHspqt
         5pBQ==
X-Gm-Message-State: AOAM5318nmC0KqnXeso6T4MIMpB4J4AFFe075G5wReVY4GdmN2w0d1oe
        snz/as8s9jZqOX6PbmoStQGil5G09aA=
X-Google-Smtp-Source: ABdhPJyeoECz7zZnmaVz0xnoNcD/+I8dN4YRCx6/AEgrRrhDMnDtHo3kPTXZKPHtcqWwBraPT245bw==
X-Received: by 2002:a17:902:be10:b029:e9:78a0:dd33 with SMTP id r16-20020a170902be10b02900e978a0dd33mr7724647pls.1.1618552561763;
        Thu, 15 Apr 2021 22:56:01 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:b679:8f6d:6528:e787])
        by smtp.gmail.com with ESMTPSA id e26sm3746157pfm.148.2021.04.15.22.56.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 22:56:01 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] monitor: Update manpage
Date:   Thu, 15 Apr 2021 22:56:00 -0700
Message-Id: <20210416055600.584533-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Tedd Ho-Jeong An <tedd.an@intel.com>
References: <Tedd Ho-Jeong An <tedd.an@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the manpage for btmon.
---
 Makefile.am     |  10 +---
 Makefile.tools  |   3 +
 doc/btmon.txt   |  35 -----------
 monitor/btmon.1 | 152 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+), 44 deletions(-)
 delete mode 100644 doc/btmon.txt
 create mode 100644 monitor/btmon.1

diff --git a/Makefile.am b/Makefile.am
index f98243f72..625a7ce3d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -579,14 +579,6 @@ if LIBRARY
 pkgconfig_DATA = lib/bluez.pc
 endif
 
-manual_pages = doc/btmon.1
-
-if MANPAGES
-dist_noinst_MANS += $(manual_pages)
-endif
-
-EXTRA_DIST += $(manual_pages:.1=.txt)
-
 DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
 						--enable-health \
 						--enable-midi \
@@ -597,7 +589,7 @@ DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
 						--disable-systemd \
 						--disable-udev
 
-DISTCLEANFILES = $(pkgconfig_DATA) $(unit_tests) $(manual_pages)
+DISTCLEANFILES = $(pkgconfig_DATA) $(unit_tests)
 
 MAINTAINERCLEANFILES = Makefile.in \
 	aclocal.m4 configure config.h.in config.sub config.guess \
diff --git a/Makefile.tools b/Makefile.tools
index 57e858290..069f40ec8 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -49,6 +49,9 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/tty.h
 monitor_btmon_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la $(UDEV_LIBS) -ldl
+dist_man_MANS += monitor/btmon.1
+else
+EXTRA_DIST += monitor/btmon.1
 endif
 
 if LOGGER
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
diff --git a/monitor/btmon.1 b/monitor/btmon.1
new file mode 100644
index 000000000..a9d8430c8
--- /dev/null
+++ b/monitor/btmon.1
@@ -0,0 +1,152 @@
+.\" Manpage for btmon
+.TH btmon 1 "April 2021" BlueZ "Linux System Administration"
+
+.SH NAME
+btmon - Bluetooth monitor
+
+.SH SYNOPSIS
+.B btmon
+.RI [ OPTIONS ]
+.SH DESCRIPTION
+The btmon(1) command provides access to the Bluetooth subsystem monitor
+infrastructure for reading HCI traces.
+.SH OPTIONS
+.TP
+.BR \-r , " \-\-read " \fIFILE\fR
+Read traces in btsnoop format.
+
+.TP
+.BR \-w , " \-\-write " \fIFILE\fR
+Save traces in btsnoop format.
+
+.TP
+.BR \-a , " \-\-analyze " \fIFILE\fR
+Analyze traces in btsnoop format. It displays the devices found in the
+\fIFILE\fR with its packets by type.
+
+.TP
+.BR \-s , " \-\-server " \fISOCKET\fR
+Start monitor server socket.
+
+.TP
+.BR \-p , " \-\-priority " \fIPRIORITY\fR
+Show only priority or lower for user log.
+.sp
+\fIPRIORITY\fR
+.IP
+.TS
+tab(:);
+l l.
+3:Error
+4:Warning
+6:Information (default)
+7:Debug. 'debug' can be to use.
+.TE
+
+.TP
+.BR \-i , " \-\-index " \fINUM\fR
+Show only specified controller. \fBhci\fINUM\fR is also acceptable.
+This is useful to capture the traces from the specific controller when the
+multiple controllers are presented.
+
+.TP
+.BR \-d , " \-\-tty " \fITTY\fR
+Read data from TTY.
+
+.TP
+.BR \-B , " \-\-rate " \fISPEED\fR
+Set TTY speed. The default \fISPEED\fR is 115300q
+
+.TP
+.BR \-V , " \-\-vendor " \fICOMPID\fR
+Set the default company identifier. The \fICOMPID\fR is a unique number
+assigned by the Bluetooth SIG to a member company and can be found/searched
+from the Bluetooth SIG webpage. For example, Intel is 2 and Realtek is 93.
+
+.TP
+.BR \-M ", " \-\-mgmt
+Open channel for mgmt events.
+
+.TP
+.BR \-t ", " \-\-time
+Show a time instead of time offset.
+
+.TP
+.BR \-T ", " \-\-date
+Show a time and date information instead of time offset.
+
+.TP
+.BR \-S ", " \-\-sco
+Dump SCO traffic in raw hex format.
+
+.TP
+.BR \-A ", " \-\-a2dp
+Dump A2DP stream traffic in a raw hex format.
+
+.TP
+.BR \-E , " \-\-ellisys " \fIIP\fR
+Send Ellisys HCI Injection.
+
+.TP
+.BR \-P ", " \-\-no\-pager
+Disable pager usage while reading the log file.
+
+.TP
+.BR \-J , " \-\-jlink " \fIDEVICE\fR,[\fISERIALNO\fR],[\fIINTERFACE\fR],[\fISPEED\fR]
+Read data from RTT
+
+.TP
+.BR \-R , " \-\-rtt " [\fIADDRESS\fR],[\fIAREA\fR],[\fINAME\fR]
+RTT control block parameters
+
+.TP
+.BR \-C , " \-\-columns " \fIWIDTH\fR
+Output width if not a terminal
+
+.TP
+.BR \-c , " \-\-color " \fIMODE\fR
+Set output color. The possible \fImode\fR values are:
+.sp
+\fIMODE\fR
+.IP
+.TS
+l.
+auto
+always
+never
+.TE
+
+.TP
+.BR \-v , " \-\-version
+Show version
+
+.TP
+.BR \-h , " \-\-help
+Show help options
+
+.SH EXAMPLES
+.TP
+.B Capture the traces from hci0 to hcidump.log file
+.IP
+$ btmon -i hci0 -w hcidump.log
+
+.TP
+.B Open the trace file
+.IP
+$ btmon -r hcidump.log
+
+.SH RESOURCES
+.TP
+<http://www.bluez.org/>
+
+.SH AUTHOR
+Written by Marcel Holtmann <marcel@holtmann.org>.
+.sp
+man page by Tedd Ho-Jeong An <tedd.an@intel.com>.
+
+.SH REPORTING BUGS
+linux-bluetooth@vger.kernel.org
+
+.SH COPYRIGHT
+Free use of this software is granted under ther terms of the GNU Lesser
+General Public Licenses (LGPL).
-- 
2.25.1

