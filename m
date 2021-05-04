Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC520C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6805B611EE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhEDFDL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 01:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhEDFDJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 01:03:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF14C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 22:02:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b21so4190414plz.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 22:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jp0Mn9l7EE7o/NWosxIkK1m9CZDiY+FQQHvaAm0Kyf4=;
        b=velgee/0TOzbyFbCglGW9ekhjQ+fURfpAhXccF9/AvoAxtqXocZ42SwaYuApVpiKnL
         mH9QTqG/ZO0gqdhgJi4aYpBfNCTrkvU44UOE+lWC2S2I+r4ALlR3S54/rNUqUS8o4/B5
         JzCM4xOUpmxqyC8A23meMlO/aRiJ3BlV/xSugRvnZaD5X7kpoCEZM6EmUdLT3jD7Xw4v
         0F4fFMnrOFb4bgD6WQ9uhf3/2gzq1sihRwU5CbP6CicvRV7NoaE8z5LtjJtJHyVtYAOb
         pUj00Zn6Ei+6T6OKP786bSA9PtdqWSencMpyoHzDWg7RYPRfEmeHhjHPvkqYUKBVE3lF
         eHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jp0Mn9l7EE7o/NWosxIkK1m9CZDiY+FQQHvaAm0Kyf4=;
        b=I8eCQTWjIQVlzss2JdjzLf1tCKoWx/zmFbHLxn72KcYyGs55u0YZTrgkaY+97FdtMG
         NG0KZHwnBfQ0P5zeDbTG52j+GUpa477kkXsM1a6OFtu/0a8PqpQe7YOuIs+3MrwVqEBP
         bWnwaYYAk0MtUC+wP1IewzIBAZAjbI/nChsdo1IFr8PPRNGym4Rx/kEGIelIRPEkjDSd
         ZoBheeECiROscxaDhJvJo695k3xbgA2jpyLEpI6ehLDjr1pHjjMjVUHtziD7EWXHcbqM
         w3l5X4wLkSXJoPbhBpiZFf2cEgBnfcWT7Rdo+kplQbQ7A/AdIKjnbRXKW0eFACi/Vg79
         UwjQ==
X-Gm-Message-State: AOAM532MY0JAqld+avRb6K3AMt635NW1FNk4ULss+XFakArTFcnukovn
        bHL+B76/Qlri30Mwg+6TSPgfTXbW5E8PyA==
X-Google-Smtp-Source: ABdhPJyfq2zGQ5sxiWaBdePAtaRVb54TlHoM2O6ddfdIttbDK6/dbYPJw7ZENSOOKUsIdcDAFK+sYg==
X-Received: by 2002:a17:902:7d89:b029:ec:c084:d4bc with SMTP id a9-20020a1709027d89b02900ecc084d4bcmr24835044plm.18.1620104531902;
        Mon, 03 May 2021 22:02:11 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id m20sm1508385pjq.40.2021.05.03.22.02.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 22:02:11 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 4/4] tools: Convert manpages to rst format
Date:   Mon,  3 May 2021 22:02:07 -0700
Message-Id: <20210504050207.841261-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210504050207.841261-1-hj.tedd.an@gmail.com>
References: <20210504050207.841261-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch converts existing manpages in tools into the reStructuredText
format.
---
 Makefile.tools      |   4 +-
 tools/bdaddr.1      |  68 -----------
 tools/bdaddr.rst    |  76 +++++++++++++
 tools/btattach.1    |  53 ---------
 tools/btattach.rst  |  79 +++++++++++++
 tools/ciptool.1     |  68 -----------
 tools/ciptool.rst   |  71 ++++++++++++
 tools/hciattach.1   | 158 -------------------------
 tools/hciattach.rst | 166 +++++++++++++++++++++++++++
 tools/hciconfig.1   | 272 --------------------------------------------
 tools/hciconfig.rst | 271 +++++++++++++++++++++++++++++++++++++++++++
 tools/hcidump.1     | 118 -------------------
 tools/hcidump.rst   | 119 +++++++++++++++++++
 tools/hcitool.1     | 255 -----------------------------------------
 tools/hcitool.rst   | 213 ++++++++++++++++++++++++++++++++++
 tools/hid2hci.1     |  46 --------
 tools/hid2hci.rst   |  50 ++++++++
 tools/l2ping.1      |  76 -------------
 tools/l2ping.rst    |  69 +++++++++++
 tools/rctest.1      |  90 ---------------
 tools/rctest.rst    |  81 +++++++++++++
 tools/rfcomm.1      | 113 ------------------
 tools/rfcomm.rst    | 100 ++++++++++++++++
 tools/sdptool.1     | 132 ---------------------
 tools/sdptool.rst   | 103 +++++++++++++++++
 25 files changed, 1400 insertions(+), 1451 deletions(-)
 delete mode 100644 tools/bdaddr.1
 create mode 100644 tools/bdaddr.rst
 delete mode 100644 tools/btattach.1
 create mode 100644 tools/btattach.rst
 delete mode 100644 tools/ciptool.1
 create mode 100644 tools/ciptool.rst
 delete mode 100644 tools/hciattach.1
 create mode 100644 tools/hciattach.rst
 delete mode 100644 tools/hciconfig.1
 create mode 100644 tools/hciconfig.rst
 delete mode 100644 tools/hcidump.1
 create mode 100644 tools/hcidump.rst
 delete mode 100644 tools/hcitool.1
 create mode 100644 tools/hcitool.rst
 delete mode 100644 tools/hid2hci.1
 create mode 100644 tools/hid2hci.rst
 delete mode 100644 tools/l2ping.1
 create mode 100644 tools/l2ping.rst
 delete mode 100644 tools/rctest.1
 create mode 100644 tools/rctest.rst
 delete mode 100644 tools/rfcomm.1
 create mode 100644 tools/rfcomm.rst
 delete mode 100644 tools/sdptool.1
 create mode 100644 tools/sdptool.rst

diff --git a/Makefile.tools b/Makefile.tools
index a39e3e334..c836b5984 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -412,7 +412,7 @@ man_MANS += tools/hciattach.1 tools/hciconfig.1 \
 endif
 endif
 endif
-EXTRA_DIST += tools/hciattach.1 tools/hciconfig.1 \
+manual_pages += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
 			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1 \
 			tools/rctest.1 tools/l2ping.1 tools/btattach.1 \
@@ -429,7 +429,7 @@ if MANPAGES
 man_MANS += tools/hid2hci.1
 endif
 endif
-EXTRA_DIST += tools/hid2hci.1
+manual_pages += tools/hid2hci.1
 
 if READLINE
 noinst_PROGRAMS += tools/btmgmt tools/obex-client-tool tools/obex-server-tool \
diff --git a/tools/bdaddr.1 b/tools/bdaddr.1
deleted file mode 100644
index efb77d2e5..000000000
--- a/tools/bdaddr.1
+++ /dev/null
@@ -1,68 +0,0 @@
-.TH BDADDR 1 "Sep 27 2005" BlueZ "Linux System Administration"
-.SH NAME
-bdaddr \- Utility for changing the Bluetooth device address
-.SH SYNOPSIS
-.B bdaddr
-.br
-.B bdaddr -h
-.br
-.B bdaddr [-i <dev>] [-r] [-t] [new bdaddr]
-
-.SH DESCRIPTION
-.LP
-.B
-bdaddr
-is used to query or set the local Bluetooth device address (BD_ADDR). If run
-with no arguments,
-.B
-bdaddr
-prints the chip manufacturer's name, and the current BD_ADDR. If the IEEE OUI
-index file "oui.txt" is installed on the system, the BD_ADDR owner will be
-displayed. If the optional [new bdaddr] argument is given, the device will be
-reprogrammed with that address. This can either be permanent or temporary, as
-specified by the -t flag. In both cases, the device must be reset before the
-new address will become active. This can be done with a 'soft' reset by
-specifying the -r flag, or a 'hard' reset by removing and replugging the
-device. A 'hard' reset will cause the address to revert to the current
-non-volatile value.
-.PP
-.B
-bdaddr
-uses manufacturer specific commands to set the address, and is therefore
-device specific. For this reason, not all devices are supported, and not all
-options are supported on all devices.
-Current supported manufacturers are:
-.B Ericsson, Cambridge Silicon Radio (CSR), Texas Instruments (TI), Zeevo
-and
-.B ST Microelectronics (ST)
-
-.SH OPTIONS
-.TP
-.BI -h
-Gives a list of possible commands.
-.TP
-.BI -i\ <dev>
-Specify a particular device to operate on. If not specified, default is the
-first available device.
-.TP
-.BI -r
-Reset device and make new BD_ADDR active.
-.B
-CSR
-devices only.
-.TP
-.BI -t
-Temporary change. Do not write to non-volatile memory.
-.B
-CSR
-devices only.
-.SH FILES
-.TP
-.I
-/usr/share/misc/oui.txt
-IEEE Organizationally Unique Identifier master file.
-Manually update from: http://standards.ieee.org/regauth/oui/oui.txt
-.SH AUTHORS
-Written by Marcel Holtmann <marcel@holtmann.org>,
-man page by Adam Laurie <adam@algroup.co.uk>
-.PP
diff --git a/tools/bdaddr.rst b/tools/bdaddr.rst
new file mode 100644
index 000000000..1d21e2ca3
--- /dev/null
+++ b/tools/bdaddr.rst
@@ -0,0 +1,76 @@
+======
+bdaddr
+======
+
+-------------------------------------------------
+Utility for changing the Bluetooth device address
+-------------------------------------------------
+
+:Authors: - Marcel Holtmann <marcel@holtmann.org>
+          - Adam Laurie <adam@algroup.co.uk>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: Sep 27, 2005
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**bdaddr**
+
+**bdaddr** -h
+
+**bdaddr** [-i <*dev*>] [-r] [-t] [*new_bdaddr*]
+
+DESCRIPTION
+===========
+
+**bdaddr(1)** is used to query or set the local Bluetooth device address
+(BD_ADDR). If run with no arguments, **bdaddr** prints the chip manufacturer's
+name, and the current BD_ADDR. If the IEEE OUI index file "oui.txt" is
+installed on the system, the BD_ADDR owner will be displayed. If the optional
+[*new_bdaddr*]  argument is given, the device will be reprogrammed with that
+address. This can either be permanent or temporary, as specified by the -t
+flag. In both cases, the device must be reset before the new address will
+become active. This can be done with a 'soft' reset by specifying the  -r
+flag, or a 'hard' reset by removing and replugging the device. A 'hard' reset
+will cause the address to revert to the current non-volatile value.
+
+**bdaddr** uses manufacturer specific commands to set the address, and is
+therefore device specific. For this reason, not all devices are supported,
+and not all options are supported on all devices. Current supported
+manufacturers are: **Ericsson**, **Cambridge Silicon Radio (CSR)**,
+**Texas  Instruments (TI)**, **Zeevo** and **ST Microelectronics (ST)**.
+
+OPTIONS
+=======
+
+-h      Gives a list of possible commands.
+
+-i <dev>    Specify a particular device to operate on. If not specified,
+            default is the first available device.
+
+-r          Reset device and make new BD_ADDR active.  CSR devices only.
+
+-t          Temporary change. Do not write to non-volatile memory.
+            CSR devices only.
+
+FILES
+=====
+
+/usr/share/misc/oui.txt
+    IEEE Organizationally Unique Identifier master file.
+    Manually update from: http://standards.ieee.org/regauth/oui/oui.txt
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
diff --git a/tools/btattach.1 b/tools/btattach.1
deleted file mode 100644
index ffd653d26..000000000
--- a/tools/btattach.1
+++ /dev/null
@@ -1,53 +0,0 @@
-.TH "btattach" "1" "November 2015" "BlueZ" "Linux System Administration"
-.SH NAME
-btattach \- attach serial devices to BlueZ stack
-
-.SH SYNOPSIS
-.B btattach
-.RB [\| \-B
-.IR device \|]
-.RB [\| \-A
-.IR device \|]
-.RB [\| \-P
-.IR protocol \|]
-.RB [\| \-R \|]
-
-.SH DESCRIPTION
-.LP
-btattach is used to attach a serial UART to the Bluetooth stack as a
-transport interface.
-
-.SH OPTIONS
-.TP
-.BI \-B " device" , " " \--bredr " device"
-Attach a BR/EDR controller.
-.TP
-.BI \-A " device" , " " \--amp " device"
-Attach an AMP controller.
-.TP
-.BI \-P " protocol" , " " \--protocol " protocol"
-Specify the protocol type for talking to the device.
-Supported values are:
-.RS
-.IP \(bu 2
-.B h4
-.IP \(bu 2
-.B bcsp
-.IP \(bu 2
-.B 3wire
-.IP \(bu 2
-.B h4ds
-.IP \(bu 2
-.B ll
-.IP \(bu 2
-.B ath3k
-.IP \(bu 2
-.B intel
-.IP \(bu 2
-.B bcm
-.IP \(bu 2
-.B qca
-.RE
-.TP
-.B \-R
-Set the device into raw mode (the kernel and bluetoothd will ignore it).
diff --git a/tools/btattach.rst b/tools/btattach.rst
new file mode 100644
index 000000000..787d5c49e
--- /dev/null
+++ b/tools/btattach.rst
@@ -0,0 +1,79 @@
+========
+btattach
+========
+
+------------------------------------
+Attach serial devices to BlueZ stack
+------------------------------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: November 2015
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**btattach** [**-B** *device*] [**-A** *device*] [**-P** *protocol*] [**-R**]
+
+DESCRIPTION
+===========
+
+**btattach(1)** is used to attach a serial UART to the Bluetooth stack as a
+transport interface.
+
+OPTIONS
+=======
+
+-B device, --brder device   Attach a BR/EDR controller
+
+-A device, --amp device     Attach an AMP controller
+
+-P protocol, --protocol protocol    Specify the protocol type for talking to the
+                                    device.
+
+                                    Supported values are:
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+
+   * - *protocol*
+
+   * - h4
+
+   * - bcsp
+
+   * - 3wire
+
+   * - h4ds
+
+   * - ll
+
+   * - ath3k
+
+   * - intel
+
+   * - bcm
+
+   * - qca
+
+-S baudrate, --speed baudrate       Specify wich baudrate to use
+
+-N, --noflowctl            Disable flow control
+
+-v, --version              Show version
+
+-h, --help                 Show help options
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
diff --git a/tools/ciptool.1 b/tools/ciptool.1
deleted file mode 100644
index 65d903d3c..000000000
--- a/tools/ciptool.1
+++ /dev/null
@@ -1,68 +0,0 @@
-.\"
-.\"	This program is free software; you can redistribute it and/or modify
-.\"	it under the terms of the GNU General Public License as published by
-.\"	the Free Software Foundation; either version 2 of the License, or
-.\"	(at your option) any later version.
-.\"
-.\"	This program is distributed in the hope that it will be useful,
-.\"	but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\"	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\"	GNU General Public License for more details.
-.\"
-.\"	You should have received a copy of the GNU General Public License
-.\"	along with this program; if not, write to the Free Software
-.\"	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-.\"
-.\"
-.TH CIPTOOL 1 "JUNE 6, 2003" "" ""
-
-.SH NAME
-ciptool \- Bluetooth Common ISDN Access Profile (CIP)
-.SH SYNOPSIS
-.BR "ciptool
-[
-.I options
-] <
-.I command
->
-.SH DESCRIPTION
-.B ciptool
-is used to set up, maintain, and inspect the CIP configuration
-of the Bluetooth subsystem in the Linux kernel.
-.SH OPTIONS
-.TP
-.BI -h
-Gives a list of possible commands.
-.TP
-.BI -i " <hciX> | <bdaddr>"
-The command is applied to device
-.I
-hciX
-, which must be the name or the address of an installed Bluetooth
-device. If not specified, the command will be use the first
-available Bluetooth device.
-.SH COMMANDS
-.TP
-.BI show
-Display information about the connected devices.
-.TP
-.BI search
-Search for Bluetooth devices and connect to first one that
-offers CIP support.
-.TP
-.BI connect " <bdaddr> [psm]"
-Connect the local device to the remote Bluetooth device on the
-specified PSM number. If no PSM is specified, it will use the
-SDP to retrieve it from the remote device.
-.TP
-.BI release " [bdaddr]"
-Release a connection to the specific device. If no address is
-given and only one device is connected this will be released.
-.TP
-.BI loopback " <bdaddr> [psm]"
-Create a connection to the remote device for Bluetooth testing.
-This command will not provide a CAPI controller, because it is
-only for testing the CAPI Message Transport Protocol.
-.SH AUTHOR
-Written by Marcel Holtmann <marcel@holtmann.org>.
-.br
diff --git a/tools/ciptool.rst b/tools/ciptool.rst
new file mode 100644
index 000000000..bd7112f08
--- /dev/null
+++ b/tools/ciptool.rst
@@ -0,0 +1,71 @@
+========
+ciptool
+========
+
+------------------------------------------
+Bluetooth Common ISDN Access Profile (CIP)
+------------------------------------------
+
+:Author: Marcel Holtmann <marcel@holtmann.org>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: June 3, 2003
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**ciptool** [*OPTIONS*] *COMMANDS*
+
+DESCRIPTION
+===========
+
+**ciptool(1)** is used to set up, maintain, and inspect the CIP configuration
+of the Bluetooth subsystem in the Linux kernel.
+
+OPTIONS
+=======
+
+-i <hciX|BDADDR>    The command is applied to device *hciX* , which must be the
+                    name or the address of an installed Bluetooth device.
+
+                    If not specified, the command will be use the first
+                    available Bluetooth device.
+
+-h, --help          Show help options
+
+COMMANDS
+========
+
+show
+    Display information about the connected devices.
+
+search
+    Search for Bluetooth devices and connect to first one that offers CIP
+    support.
+
+connect <*BDADDR*> [*PSM*]
+    Connect the local device to the remote Bluetooth device on the specified
+    *PSM* number. If no *PSM* is specified,  it will use the SDP to retrieve
+    it from the remote device.
+
+release [*BDADDR*]
+    Release a connection to the specific device. If no *BDADDR* is given and
+    only one device is connected this will be released.
+
+loopback <*BDADDR*> [*PSM*]
+    Create a connection to the remote device for Bluetooth testing. This
+    command will not provide a CAPI controller, because it is only for
+    testing the CAPI Message Transport Protocol.
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
diff --git a/tools/hciattach.1 b/tools/hciattach.1
deleted file mode 100644
index d50603470..000000000
--- a/tools/hciattach.1
+++ /dev/null
@@ -1,158 +0,0 @@
-.TH HCIATTACH 1 "Jan 22 2002" BlueZ "Linux System Administration"
-.SH NAME
-hciattach \- attach serial devices via UART HCI to BlueZ stack
-.SH SYNOPSIS
-.B hciattach
-.RB [\| \-b \|]
-.RB [\| \-n \|]
-.RB [\| \-p \|]
-.RB [\| \-t
-.IR timeout \|]
-.RB [\| \-s
-.IR speed \|]
-.RB [\| \-l \|]
-.RB [\| \-r \|]
-.I tty
-.IR type \||\| id
-.I speed
-.I flow
-.I bdaddr
-.SH DESCRIPTION
-.LP
-Hciattach is used to attach a serial UART to the Bluetooth stack as HCI
-transport interface.
-.SH OPTIONS
-.TP
-.B \-b
-Send break.
-.TP
-.B \-n
-Don't detach from controlling terminal.
-.TP
-.B \-p
-Print the PID when detaching.
-.TP
-.BI \-t " timeout"
-Specify an initialization timeout.  (Default is 5 seconds.)
-.TP
-.BI \-s " speed"
-Specify an initial speed instead of the hardware default.
-.TP
-.B \-l
-List all available configurations.
-.TP
-.B \-r
-Set the HCI device into raw mode (the kernel and bluetoothd will ignore it).
-.TP
-.I tty
-This specifies the serial device to attach. A leading
-.B /dev
-can be omitted. Examples:
-.B /dev/ttyS1
-.B ttyS2
-.TP
-.IR type \||\| id
-The
-.I type
-or
-.I id
-of the Bluetooth device that is to be attached, i.e. vendor or other device
-specific identifier. Currently supported types are
-.RS
-.TP
-.B type
-.B description
-.TP
-.B any
-Unspecified HCI_UART interface, no vendor specific options
-.TP
-.B ericsson
-Ericsson based modules
-.TP
-.B digi
-Digianswer based cards
-.TP
-.B xircom
-Xircom PCMCIA cards: Credit Card Adapter and Real Port Adapter
-.TP
-.B csr
-CSR Casira serial adapter or BrainBoxes serial dongle (BL642)
-.TP
-.B bboxes
-BrainBoxes PCMCIA card (BL620)
-.TP
-.B swave
-Silicon Wave kits
-.TP
-.B bcsp
-Serial adapters using CSR chips with BCSP serial protocol
-.TP
-.B ath3k
-Atheros AR300x based serial Bluetooth device
-.TP
-.B intel
-Intel Bluetooth device
-.RE
-
-Supported IDs are (manufacturer id, product id)
-.RS
-.TP
-.B 0x0105, 0x080a
-Xircom PCMCIA cards: Credit Card Adapter and Real Port Adapter
-.TP
-.B 0x0160, 0x0002
-BrainBoxes PCMCIA card (BL620)
-.RE
-
-.TP
-.I speed
-The
-.I speed
-specifies the UART speed to use. Baudrates higher than 115.200bps require
-vendor specific initializations that are not implemented for all types of
-devices. In general the following speeds are supported:
-
-.B 9600, 19200, 38400, 57600, 115200, 230400, 460800, 921600
-
-Supported vendor devices are automatically initialised to their respective
-best settings.
-.TP
-.I flow
-If the keyword
-.I flow
-is appended to the list of options then hardware flow control is forced on
-the serial link (
-.B CRTSCTS
-). All above mentioned device types have
-.B flow
-set by default. To force no flow control use
-.B noflow
-instead.
-.TP
-.I sleep
-Enables hardware specific power management feature. If
-.I sleep
-is appended to the list of options then this feature is enabled. To disable
-this feature use
-.B nosleep
-instead.
-All above mentioned device types have
-.B nosleep
-set by default.
-
-Note: This option will only be valid for hardware which support
-hardware specific power management enable option from host.
-.TP
-.I bdaddr
-The
-.I bdaddr
-specifies the Bluetooth Address to use.  Some devices (like the STLC2500)
-do not store the Bluetooth address in hardware memory.  Instead it must
-be uploaded during the initialization process.  If this argument
-is specified, then the address will be used to initialize the device.
-Otherwise, a default address will be used.
-
-.SH AUTHORS
-Written by Maxim Krasnyansky <maxk@qualcomm.com>
-.PP
-Manual page by Nils Faerber <nils@kernelconcepts.de>
diff --git a/tools/hciattach.rst b/tools/hciattach.rst
new file mode 100644
index 000000000..d3eb7ef66
--- /dev/null
+++ b/tools/hciattach.rst
@@ -0,0 +1,166 @@
+=========
+hciattach
+=========
+
+-------------------------------------------------
+attach serial devices via UART HCI to BlueZ stack
+-------------------------------------------------
+
+:Authors: - Maxim Krasnyansky <maxk@qualcomm.com>
+          - Nils Faerber <nils@kernelconcepts.de>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: Jan 22, 2002
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**hciattach** [*OPTIONS*] <*tty*> <*type|id*> [*speed*] [*flow*] [*sleep*] [*bdaddr*]
+
+**hciattach** -1
+
+DESCRIPTION
+===========
+
+**hciattach(1)** is used to attach a serial UART to the Bluetooth stack as HCI
+transport interface.
+
+OPTIONS
+=======
+
+-i          Send break
+-n          Don't detach from controlling terminal.
+-p          Print the PID when detaching.
+-t timeout  Specify an initialization timeout. Default is 5 seconds.
+-s speed    Specify an initial speed instead of the hardware default.
+-l          List all available configurations.
+-r          Set the HCI device into raw mode. The kernel and bluetooth daemon
+            will ignore it.
+-h, --help  Show help options
+
+ARGUMENTS
+=========
+
+*show*
+    This specifies the serial device to attach. A leading /dev can be omitted.
+
+    Examples: **/dev/ttyS1 ttyS2**
+
+*type|id*
+    The *type* or *id* of the Bluetooth device that is to be attached,
+    i.e. vendor or other device specific identifier.
+    Currently supported types are
+
+.. list-table::
+    :header-rows: 1
+    :widths: auto
+
+    * - *type*
+      - Description
+
+    * - any
+      - Unspecified HCI_UART interface, no vendor specific options
+
+    * - ericsson
+      - Ericsson based modules
+
+    * - digi
+      - Digianswer based cards
+
+    * - xircom
+      - Xircom PCMCIA cards: Credit Card Adapter and Real Port Adapter
+
+    * - csr
+      - CSR Casira serial adapter or BrainBoxes serial dongle (BL642)
+
+    * - bboxes
+      - BrainBoxes PCMCIA card (BL620)
+
+    * - swave
+      - Silicon Wave kits
+
+    * - bcsp
+      - Serial adapters using CSR chips with BCSP serial protocol
+
+    * - ath3k
+      - Atheros AR300x based serial Bluetooth device
+
+    * - intel
+      - Intel Bluetooth device
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+
+   * - | Supported ID
+       | (manufacturer id, product id)
+     - Description
+
+   * - 0x0105, 0x080a
+     - Xircom PCMCIA cards: Credit Card Adapter and Real Port Adapter
+
+   * - 0x0160, 0x0002
+     - BrainBoxes PCMCIA card (BL620)
+
+*speed*
+    The *speed* specifies the UART speed to use. Baudrates higher than 115200bps
+    require vendor specific  initializations that are not implemented for all
+    types of devices. In general the following speeds are supported:
+
+    Supported vendor devices are automatically initialised to their respective
+    best settings.
+
+.. list-table::
+   :header-rows: 0
+   :widths: auto
+
+   * - 9600
+
+   * - 19200
+
+   * - 38400
+
+   * - 57600
+
+   * - 115200
+
+   * - 230400
+
+   * - 460800
+
+   * - 921600
+
+*flow*
+    If the *flow* is appended to the list of options then hardware flow control
+    is forced on the serial link (**CRTSCTS**). All above mentioned device
+    types have flow set by default. To force no flow control use *noflow*
+    instead.
+
+*sleep|nosleep*
+    Enables hardware specific power management feature. If *sleep* is appended
+    to the list of options then this feature is enabled. To disable this
+    feature use *nosleep* instead. All above mentioned device types have
+    *nosleep* set by default.
+
+    Note: This option will only be valid for hardware which support hardware
+    specific power management enable option from host.
+
+*bdaddr*
+    The bdaddr specifies the Bluetooth Address to use. Some devices (like
+    the STLC2500) do not store the Bluetooth address in hardware memory.
+    Instead it must be uploaded during the initialization process. If this
+    argument is specified, then the address will be used to initialize the
+    device. Otherwise, a default address will be used.
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
diff --git a/tools/hciconfig.1 b/tools/hciconfig.1
deleted file mode 100644
index 633ffa3ff..000000000
--- a/tools/hciconfig.1
+++ /dev/null
@@ -1,272 +0,0 @@
-.TH HCICONFIG 1 "Nov 11 2002" BlueZ "Linux System Administration"
-.SH NAME
-hciconfig \- configure Bluetooth devices
-.SH SYNOPSIS
-.B hciconfig
-.B \-h
-.br
-.B hciconfig
-.RB [\| \-a \|]
-.br
-.B hciconfig
-.RB [\| \-a \|]
-.B hciX
-.RI [\| command
-.RI [\| "command parameters" \|]\|]
-
-.SH DESCRIPTION
-.LP
-.B hciconfig
-is used to configure Bluetooth devices.
-.I hciX
-is the name of a Bluetooth device installed in the system. If
-.I hciX
-is not given,
-.B hciconfig
-prints name and basic information about all the Bluetooth devices installed in
-the system. If
-.I hciX
-is given but no command is given, it prints basic information on device
-.I hciX
-only. Basic information is
-interface type, BD address, ACL MTU, SCO MTU, flags (up, init, running, raw,
-page scan enabled, inquiry scan enabled, inquiry, authentication enabled,
-encryption enabled).
-.SH OPTIONS
-.TP
-.B \-h, \-\-help
-Gives a list of possible commands.
-.TP
-.B \-a, \-\-all
-Other than the basic info, print features, packet type, link policy, link mode,
-name, class, version.
-.SH COMMANDS
-.TP
-.B up
-Open and initialize HCI device.
-.TP
-.B down
-Close HCI device.
-.TP
-.B reset
-Reset HCI device.
-.TP
-.B rstat
-Reset statistic counters.
-.TP
-.B auth
-Enable authentication (sets device to security mode 3).
-.TP
-.B noauth
-Disable authentication.
-.TP
-.B encrypt
-Enable encryption (sets device to security mode 3).
-.TP
-.B noencrypt
-Disable encryption.
-.TP
-.B secmgr
-Enable security manager (current kernel support is limited).
-.TP
-.B nosecmgr
-Disable security manager.
-.TP
-.B piscan
-Enable page and inquiry scan.
-.TP
-.B noscan
-Disable page and inquiry scan.
-.TP
-.B iscan
-Enable inquiry scan, disable page scan.
-.TP
-.B pscan
-Enable page scan, disable inquiry scan.
-.TP
-\fBptype\fP [\fItype\fP]
-With no
-.I type
-, displays the current packet types. Otherwise, all the packet types specified
-by
-.I type
-are set.
-.I type
-is a comma-separated list of packet types, where the possible packet types are
-.BR DM1 ,
-.BR DM3 ,
-.BR DM5 ,
-.BR DH1 ,
-.BR DH3 ,
-.BR DH5 ,
-.BR HV1 ,
-.BR HV2 ,
-.BR HV3 .
-.TP
-.BI name " [name]"
-With no
-.IR name ,
-prints local name. Otherwise, sets local name to
-.IR name .
-.TP
-.BI class " [class]"
-With no
-.IR class ,
-prints class of device. Otherwise, sets class of device to
-.IR class .
-.I
-class
-is a 24-bit hex number describing the class of device, as specified in section
-1.2 of the Bluetooth Assigned Numers document.
-.TP
-.BI voice " [voice]"
-With no
-.IR voice ,
-prints voice setting. Otherwise, sets voice setting to
-.IR voice .
-.I voice
-is a 16-bit hex number describing the voice setting.
-.TP
-.BI iac " [iac]"
-With no
-.IR iac ,
-prints the current IAC setting. Otherwise, sets the IAC to
-.IR iac .
-.TP
-.BI inqtpl " [level]"
-With no
-.IR level ,
-prints out the current inquiry transmit power level. Otherwise, sets
-inquiry transmit power level to
-.IR level .
-.TP
-.BI inqmode " [mode]"
-With no
-.IR mode ,
-prints out the current inquiry mode. Otherwise, sets inquiry mode to
-.IR mode .
-.TP
-.BI inqdata " [data]"
-With no
-.IR name ,
-prints out the current inquiry data. Otherwise, sets inquiry data to
-.IR data .
-.TP
-.BI inqtype " [type]"
-With no
-.IR type ,
-prints out the current inquiry scan type. Otherwise, sets inquiry scan type to
-.IR type .
-.TP
-\fBinqparams\fP [\fIwin\fP:\fIint\fP]
-With no
-.IR win : int ,
-prints inquiry scan window and interval. Otherwise, sets inquiry scan window
-to
-.I win
-slots and inquiry scan interval to
-.I int
-slots.
-.TP
-\fBpageparms\fP [\fIwin\fP:\fIint\fP]
-With no
-.IR win : int ,
-prints page scan window and interval. Otherwise, sets page scan window to
-.I win
-slots and page scan interval to
-.I int
-slots.
-.TP
-.BI pageto " [to]"
-With no
-.IR to ,
-prints page timeout. Otherwise, sets page timeout
-to .I
-to
-slots.
-.TP
-.BI afhmode " [mode]"
-With no
-.IR mode ,
-prints out the current AFH mode. Otherwise, sets AFH mode to
-.IR mode .
-.TP
-.BI sspmode " [mode]"
-With no
-.IR mode ,
-prints out the current Simple Pairing mode. Otherwise, sets Simple Pairing mode to
-.IR mode .
-.TP
-\fBaclmtu\fP \fImtu\fP:\fIpkt\fP
-Sets ACL MTU to
-to
-.I mtu
-bytes and ACL buffer size to
-.I pkt
-packets.
-.TP
-\fBscomtu\fP \fImtu\fP:\fIpkt\fP
-Sets SCO MTU to
-.I mtu
-bytes and SCO buffer size to
-.I pkt
-packets.
-.TP
-.BI delkey " <bdaddr>"
-This command deletes the stored link key for
-.I bdaddr
-from the device.
-.TP
-.BI oobdata
-Get local OOB data (invalidates previously read data).
-.TP
-.BI commands
-Display supported commands.
-.TP
-.BI features
-Display device features.
-.TP
-.BI version
-Display version information.
-.TP
-.BI revision
-Display revision information.
-.TP
-.BI lm " [mode]"
-With no
-.I mode
-, prints link mode.
-.B MASTER
-or
-.B SLAVE
-mean, respectively, to ask to become master or to remain slave when a
-connection request comes in. The additional keyword
-.B ACCEPT
-means that baseband  connections will be accepted even if there are no
-listening
-.I AF_BLUETOOTH
-sockets.
-.I mode
-is
-.B NONE
-or a comma-separated list of keywords, where possible keywords are
-.B MASTER
-and
-.B "ACCEPT" .
-.B NONE
-sets link policy to the default behaviour of remaining slave and not accepting
-baseband connections when there are no listening
-.I AF_BLUETOOTH
-sockets. If
-.B MASTER
-is present, the device will ask to become master if a connection request comes
-in. If
-.B ACCEPT
-is present, the device will accept baseband connections even when there are no
-listening
-.I AF_BLUETOOTH
-sockets.
-.SH AUTHORS
-Written by Maxim Krasnyansky <maxk@qualcomm.com> and Marcel Holtmann <marcel@holtmann.org>
-.PP
-man page by Fabrizio Gennari <fabrizio.gennari@philips.com>
diff --git a/tools/hciconfig.rst b/tools/hciconfig.rst
new file mode 100644
index 000000000..7d59b4046
--- /dev/null
+++ b/tools/hciconfig.rst
@@ -0,0 +1,271 @@
+=========
+hciconfig
+=========
+
+---------------------------
+Configure Bluetooth devices
+---------------------------
+
+:Authors: - Maxim Krasnyansky <maxk@qualcomm.com>
+          - Marcel Holtmann <marcel@holtmann.org>
+          - Fabrizio Gennari <fabrizio.gennari@philips.com>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: Nov 11, 2002
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**hciconfig** -h
+
+**hciconfig** [-a]
+
+**hciconfig** [-a] *hciX* [*COMMAND* [*PARAMETERS*]]
+
+DESCRIPTION
+===========
+
+**hciconfig(1)** is used to configure Bluetooth devices. *hciX* is the name of a
+Bluetooth device installed in the system. If hciX is not given, hciconfig
+prints name and basic information about all the Bluetooth devices installed
+in the system.
+
+If *hciX* is given but no command is given, it prints basic information on
+device *hciX* only. Basic information is interface type, BD address, ACL MTU,
+SCO MTU, flags (up, init, running, raw, page scan enabled, inquiry scan
+enabled, inquiry, authentication enabled, encryption enabled).
+
+OPTIONS
+=======
+
+-a, --all   Print features, packet type, link policy, link mode, class, Version
+            other than the basic info.
+-h, --help  Show help options
+
+COMMANDS
+========
+
+up
+    Open and initialize HCI device.
+
+down
+    Close HCI device.
+
+reset
+    Reset HCI device.
+
+rstat
+    Reset statistic counters.
+
+auth
+    Enable authentication (sets device to security mode 3).
+
+noauth
+    Disable authentication.
+
+encrypt
+    Enable encryption (sets device to security mode 3).
+
+noencrypt
+    Disable encryption.
+
+secmgr
+    Enable security manager (current kernel support is limited).
+
+nosecmgr
+    Disable security manager.
+
+piscan
+    Enable page and inquiry scan.
+
+noscan
+    Disable page and inquiry scan.
+
+iscan
+    Enable inquiry scan, disable page scan.
+
+pscan
+    Enable page scan, disable inquiry scan.
+
+ptype [*type*]
+    With  no *type* , displays the current packet types. Otherwise, all the
+    packet types specified by *type* are set. *type* is a comma-separated list
+    of packet types, where the possible packet types are **DM1**, **DM3**,
+    **DM5**, **DH1**, **DH3**, **DH5**, **HV1**, **HV2**, **HV3**.
+
+name [*name*]
+    With no *name*, prints local name. Otherwise, sets local name to *name*.
+
+class [*class*]
+    With  no *class*, prints class of device. Otherwise, sets class of device
+    to *class*. *class* is a 24-bit hex number describing the class of device,
+    as specified in section 1.2 of the Bluetooth Assigned Numers document.
+
+voice [*voice*]
+    With no *voice*, prints voice setting. Otherwise, sets voice setting to
+    *voice*. *voice* is a 16-bit hex number describing the voice setting.
+
+iac [*iac*]
+    With no *iac*, prints the current IAC setting. Otherwise, sets the IAC to
+    *iac*.
+
+inqtpl [*level*]
+    With no *level*, prints out the current inquiry transmit power level.
+    Otherwise, sets inquiry transmit power level to *level*.
+
+inqmode [*mode*]
+    With no *mode*, prints out the current inquiry mode. Otherwise, sets
+    inquiry mode to *mode*.
+
+ .. list-table::
+    :header-rows: 1
+    :widths: auto
+
+    * - *mode*
+      - Description
+
+    * - 0
+      - Standard Inquiry
+
+    * - 1
+      - Inquiry with RSSI
+
+    * - 2
+      - Inquiry with RSSI or Extended Inquiry
+
+inqdata [*data*]
+    With no *data*, prints out the current inquiry data. Otherwise, sets
+    inquiry data to *data*.
+
+inqtype [*type*]
+    With no *type*, prints out the current inquiry scan type. Otherwise, sets
+    inquiry scan type to *type*.
+
+inqparams [*win:int*]
+    With no *win:int*, prints inquiry scan window and interval. Otherwise,
+    sets inquiry scan window  to *win* slots and inquiry scan interval to
+    *int* slots.
+
+pageparms [*win:int*]
+    With no *win:int*, prints page scan window and interval. Otherwise,
+    sets page scan window to *win* slots and page scan interval to *int* slots.
+
+pageto [*to*]
+    With no *to*, prints page timeout. Otherwise, sets page timeout *to* to
+    slots.
+
+afhmode [*mode*]
+    With no *mode*, prints out the current AFH mode. Otherwise, sets AFH mode
+    to *mode*.
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+
+   * - *mode*
+     - Description
+
+   * - 0
+     - Enable
+
+   * - 1
+     - Disable
+
+sspmode [*mode*]
+    With no *mode*, prints out the current Simple Pairing mode. Otherwise,
+    sets Simple Pairing mode to *mode*.
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+
+   * - *mode*
+     - Description
+
+   * - 0
+     - Enable
+
+   * - 1
+     - Disable
+
+aclmtu *mtu:pkt*
+    Sets ACL MTU to *mtu* bytes and ACL buffer size to *pkt* packets.
+
+scomtu *mtu:pkt*
+    Sets SCO MTU to *mtu* bytes and SCO buffer size to *pkt* packets.
+
+delkey <*bdaddr*>
+    This command deletes the stored link key for *bdaddr* from the device.
+
+oobdata
+    Get local OOB data (invalidates previously read data).
+
+commands
+    Display supported commands.
+
+features
+    Display device features.
+
+version
+    Display version information.
+
+revision
+    Display revision information.
+
+lm [*mode*]
+    With no *mode*, prints link mode. **MASTER** or **SLAVE** mean,
+    respectively, to ask to become master or to remain slave when a connection
+    request comes in. The additional keyword **ACCEPT** means that baseband
+    connections will be accepted even if there are no listening *AF_BLUETOOTH*
+    sockets. *mode* is **NONE** or a comma-separated list of keywords, where
+    possible keywords are **MASTER** and **ACCEPT**. **NONE** sets link policy
+    to the default behaviour of remaining slave and not accepting baseband
+    connections when there are no listening *AF_BLUETOOTH* sockets.  If
+    **MASTER** is  present, the device will ask to become master if a
+    connection request comes in. If **ACCEPT** is present, the device will
+    accept baseband connections even when there are no listening *AF_BLUETOOTH*
+    sockets.
+
+block <*bdaddr*>
+    Add a device to the blacklist
+
+unblock <*bdaddr*>
+    Remove a device from the blacklist
+
+lerandaddr <*bdaddr*>
+    Set LE Random Address
+
+leadv [*type*]
+    Enable LE Advertising.
+
+.. list-table::
+    :header-rows: 1
+    :widths: auto
+
+    * - *type*
+      - Description
+
+    * - 0
+      - Connectable undirected advertising (default)
+
+    * - 3
+      - Non connectable undirected advertising
+
+noleadv
+    Disable LE Advertising
+
+lestates
+    Display the supported LE states
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
diff --git a/tools/hcidump.1 b/tools/hcidump.1
deleted file mode 100644
index 5c1441bf7..000000000
--- a/tools/hcidump.1
+++ /dev/null
@@ -1,118 +0,0 @@
-.TH HCIDUMP 1 "Nov 12 2002" BlueZ "Linux System Administration"
-.SH NAME
-hcidump \- Parse HCI data
-.SH SYNOPSIS
-.B hcidump [-h]
-.br
-.B hcidump [option [option...]] [filter]
-
-.SH DESCRIPTION
-.LP
-.B
-hcidump
-reads raw HCI data coming from and going to a Bluetooth device (which can be
-specified with the option
-.BR -i ,
-default is the first available one) and prints to screen commands, events and
-data in a human-readable form. Optionally, the dump can be written to a file
-rather than parsed, and the dump file can be parsed in a subsequent moment.
-.SH OPTIONS
-.TP
-.BI -h
-Prints usage info and exits
-.TP
-.BI -i " <hciX>"
-Data is read from
-.IR hciX ,
-which must be the name of an installed Bluetooth device. If not specified,
-and if
-.B
--r
-option is not set, data is read from the first available Bluetooth device.
-.TP
-.BI -l " <len>" "\fR,\fP \-\^\-snap-len=" "<len>"
-Sets max length of processed packets to
-.IR len .
-.TP
-.BI -p " <psm>" "\fR,\fP \-\^\-psm=" "<psm>"
-Sets default Protocol Service Multiplexer to
-.IR psm .
-.TP
-.BI -m " <compid>" "\fR,\fP \-\^\-manufacturer=" "<compid>"
-Sets default company id for manufacturer to
-.IR compid .
-.TP
-.BI -w " <file>" "\fR,\fP \-\^\-save-dump=" "<file>"
-Parse output is not printed to screen, instead data read from device is saved in file
-.IR file .
-The saved dump file can be subsequently parsed with option
-.BR -r .
-.TP
-.BI -r " <file>" "\fR,\fP \-\^\-read-dump=" "<file>"
-Data is not read from a Bluetooth device, but from file
-.IR file .
-.I
-file
-is created with option
-.BR -t ", " "\-\^\-timestamp"
-Prepend a time stamp to every packet.
-.TP
-.BR -a ", " "\-\^\-ascii"
-For every packet, not only is the packet type displayed, but also all data in ASCII.
-.TP
-.BR -x ", " "\-\^\-hex"
-For every packet, not only is the packet type displayed, but also all data in hex.
-.TP
-.BR -X ", " "\-\^\-ext"
-For every packet, not only is the packet type displayed, but also all data in hex and ASCII.
-.TP
-.BR -R ", " "\-\^\-raw"
-For every packet, only the raw data is displayed.
-.TP
-.BR -C ", " "\-\^\-cmtp=" "<psm>"
-Sets the PSM value for the CAPI Message Transport Protocol.
-.TP
-.BR -H ", " "\-\^\-hcrp=" "<psm>"
-Sets the PSM value for the Hardcopy Control Channel.
-.TP
-.BR -O ", " "\-\^\-obex=" "<channel>"
-Sets the RFCOMM channel value for the Object Exchange Protocol.
-.TP
-.BR -P ", " "\-\^\-ppp=" "<channel>"
-Sets the RFCOMM channel value for the Point-to-Point Protocol.
-.TP
-.BR -D ", " "\-\^\-pppdump=" "<file>"
-Extract PPP traffic with pppdump format.
-.TP
-.BR -A ", " "\-\^\-audio=" "<file>"
-Extract SCO audio data.
-.TP
-.BR -Y ", " "\-\^\-novendor"
-Don't display any vendor commands or events and don't show any pin code or link key in plain text.
-.SH FILTERS
-.B
-filter
-is a space-separated list of packet categories: available categories are
-.IR lmp ,
-.IR hci ,
-.IR sco ,
-.IR l2cap ,
-.IR rfcomm ,
-.IR sdp ,
-.IR bnep ,
-.IR cmtp ,
-.IR hidp ,
-.IR hcrp ,
-.IR avdtp ,
-.IR avctp ,
-.IR obex ,
-.IR capi
-and
-.IR ppp .
-If filters are used, only packets belonging to the specified categories are
-dumped. By default, all packets are dumped.
-.SH AUTHORS
-Written by Maxim Krasnyansky <maxk@qualcomm.com>
-and Marcel Holtmann <marcel@holtmann.org>
-.PP
-man page by Fabrizio Gennari <fabrizio.gennari@philips.com>
diff --git a/tools/hcidump.rst b/tools/hcidump.rst
new file mode 100644
index 000000000..c5d2866da
--- /dev/null
+++ b/tools/hcidump.rst
@@ -0,0 +1,119 @@
+=======
+hcidump
+=======
+
+--------------
+Parse HCI data
+--------------
+
+:Authors: - Maxim Krasnyansky <maxk@qualcomm.com>
+          - Marcel Holtmann <marcel@holtmann.org>
+          - Fabrizio Gennari <fabrizio.gennari@philips.com>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: Nov 12, 2002
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**hcidump** -h
+
+**hcidump** [OPTIONS ...] [FILTERS]
+
+DESCRIPTION
+===========
+
+**hcidump(1)** reads raw HCI data coming from and going to a Bluetooth device
+(which can be specified with the option **-i**, default is the first available
+one) and prints to screen commands, events and data in a human-readable form.
+Optionally, the dump can be written to a file rather than parsed, and the dump
+file can be parsed in a subsequent moment.
+
+OPTIONS
+=======
+
+-i <hciX>
+    Data is read from *hciX*, which must be the name of an installed Bluetooth
+    device. If not specified, and if **-r** option is not set, data is read from
+    the first available Bluetooth device.
+
+-l <len>, --snap-len=<len>
+    Sets max length of processed packets to *len*.
+
+-p <psm>, --psm=<psm>
+    Sets default Protocol Service Multiplexer to *psm*.
+
+-m <compid>, --manufacturer=<compid>
+    Sets default company id for manufacturer to *compid*.
+
+-w <file>, --save-dump=<file>
+    Parse output is not printed to screen, instead data read from device is
+    saved in *file*. The saved dump file can be subsequently parsed with
+    option **-r**.
+
+-r <file>, --read-dump=<file>
+    Data is not read from a Bluetooth device, but from *file*. *file* is
+    created with option **-t**, **--timestamp** prepend a time stamp to every
+    packet.
+
+-a, --ascii
+    For every packet, not only is the packet type displayed, but also all data
+    in ASCII.
+
+-x, --hex
+    For every packet, not only is the packet type displayed, but also all data
+    in hex.
+
+-X, --ext
+    For every packet, not only is the packet type displayed, but also all data
+    in hex and ASCII.
+
+-R, --raw
+    For every packet, only the raw data is displayed.
+
+-C <psm>, --cmtp=<psm>
+    Sets the PSM value for the CAPI Message Transport Protocol.
+
+-H <psm>, --hcrp=<psm>
+    Sets the PSM value for the Hardcopy Control Channel.
+
+-O <channel>, --obex=<channel>
+    Sets the RFCOMM channel value for the Object Exchange Protocol.
+
+-P <channel>, --ppp=<channel>
+    Sets the RFCOMM channel value for the Point-to-Point Protocol.
+
+-D <file>, --pppdump=<file>
+    Extract PPP traffic with pppdump format.
+
+-A <file>, --audio=<file>
+    Extract SCO audio data.
+
+-Y, --novendor
+    Don't display any vendor commands or events and don't show any pin code or
+    link key in plain text.
+
+-h
+    Prints usage info and exits
+
+FILTERS
+=======
+
+filter is a space-separated list of packet categories: available categories are
+*lmp*, *hci*, *sco*, *l2cap*, *rfcomm*, *sdp*, *bnep*, *cmtp*, *hidp*, *hcrp*,
+*avdtp*, *avctp*, *obex*, *capi* and *ppp*. If filters are used, only packets
+belonging to the specified categories are dumped. By default, all packets are
+dumped.
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
diff --git a/tools/hcitool.1 b/tools/hcitool.1
deleted file mode 100644
index 7d065563d..000000000
--- a/tools/hcitool.1
+++ /dev/null
@@ -1,255 +0,0 @@
-.TH HCITOOL 1 "Nov 12 2002" BlueZ "Linux System Administration"
-.SH NAME
-hcitool \- configure Bluetooth connections
-.SH SYNOPSIS
-.B hcitool [-h]
-.br
-.B hcitool [-i <hciX>] [command [command parameters]]
-
-.SH DESCRIPTION
-.LP
-.B
-hcitool
-is used to configure Bluetooth connections and send some special command to
-Bluetooth devices. If no
-.B
-command
-is given, or if the option
-.B
--h
-is used,
-.B
-hcitool
-prints some usage information and exits.
-.SH OPTIONS
-.TP
-.BI -h
-Gives a list of possible commands
-.TP
-.BI -i " <hciX>"
-The command is applied to device
-.I
-hciX
-, which must be the name of an installed Bluetooth device. If not specified,
-the command will be sent to the first available Bluetooth device.
-.SH COMMANDS
-.TP
-.BI dev
-Display local devices
-.TP
-.BI inq
-Inquire remote devices. For each discovered device, Bluetooth device address,
-clock offset and class are printed.
-.TP
-.BI scan
-Inquire remote devices. For each discovered device, device name are printed.
-.TP
-.BI name " <bdaddr>"
-Print device name of remote device with Bluetooth address
-.IR bdaddr .
-.TP
-.BI info " <bdaddr>"
-Print device name, version and supported features of remote device with
-Bluetooth address
-.IR bdaddr .
-.TP
-.BI spinq
-Start periodic inquiry process. No inquiry results are printed.
-.TP
-.BI epinq
-Exit periodic inquiry process.
-.TP
-.BI cmd " <ogf> <ocf> [parameters]"
-Submit an arbitrary HCI command to local device.
-.IR ogf ,
-.IR ocf
-and
-.IR parameters
-are hexadecimal bytes.
-.TP
-.BI con
-Display active baseband connections
-.TP
-.BI cc " [--role=m|s] [--pkt-type=<ptype>] <bdaddr>"
-Create baseband connection to remote device with Bluetooth address
-.IR bdaddr .
-Option
-.I
---pkt-type
-specifies a list of allowed packet types.
-.I
-<ptype>
-is a comma-separated list of packet types, where the possible packet types are
-.BR DM1 ,
-.BR DM3 ,
-.BR DM5 ,
-.BR DH1 ,
-.BR DH3 ,
-.BR DH5 ,
-.BR HV1 ,
-.BR HV2 ,
-.BR HV3 .
-Default is to allow all packet types. Option
-.I
---role
-can have value
-.I
-m
-(do not allow role switch, stay master) or
-.I
-s
-(allow role switch, become slave if the peer asks to become master). Default is
-.IR m .
-.TP
-.BI dc " <bdaddr> [reason]"
-Delete baseband connection from remote device with Bluetooth address
-.IR bdaddr .
-The reason can be one of the Bluetooth HCI error codes. Default is
-.IR 19
-for user ended connections. The value must be given in decimal.
-.TP
-.BI sr " <bdaddr> <role>"
-Switch role for the baseband connection from the remote device to
-.BR master
-or
-.BR slave .
-.TP
-.BI cpt " <bdaddr> <packet types>"
-Change packet types for baseband connection to device with Bluetooth address
-.IR bdaddr .
-.I
-packet types
-is a comma-separated list of packet types, where the possible packet types are
-.BR DM1 ,
-.BR DM3 ,
-.BR DM5 ,
-.BR DH1 ,
-.BR DH3 ,
-.BR DH5 ,
-.BR HV1 ,
-.BR HV2 ,
-.BR HV3 .
-.TP
-.BI rssi " <bdaddr>"
-Display received signal strength information for the connection to the device
-with Bluetooth address
-.IR bdaddr .
-.TP
-.BI lq " <bdaddr>"
-Display link quality for the connection to the device with Bluetooth address
-.IR bdaddr .
-.TP
-.BI tpl " <bdaddr> [type]"
-Display transmit power level for the connection to the device with Bluetooth address
-.IR bdaddr .
-The type can be
-.BR 0
-for the current transmit power level (which is default) or
-.BR 1
-for the maximum transmit power level.
-.TP
-.BI afh " <bdaddr>"
-Display AFH channel map for the connection to the device with Bluetooth address
-.IR bdaddr .
-.TP
-.BI lp " <bdaddr> [value]"
-With no
-.IR value ,
-displays link policy settings for the connection to the device with Bluetooth address
-.IR bdaddr .
-If
-.IR value
-is given, sets the link policy settings for that connection to
-.IR value .
-Possible values are RSWITCH, HOLD, SNIFF and PARK.
-.TP
-.BI lst " <bdaddr> [value]"
-With no
-.IR value ,
-displays link supervision timeout for the connection to the device with Bluetooth address
-.IR bdaddr .
-If
-.I
-value
-is given, sets the link supervision timeout for that connection to
-.I
-value
-slots, or to infinite if
-.I
-value
-is 0.
-.TP
-.BI auth " <bdaddr>"
-Request authentication for the device with Bluetooth address
-.IR bdaddr .
-.TP
-.BI enc " <bdaddr> [encrypt enable]"
-Enable or disable the encryption for the device with Bluetooth address
-.IR bdaddr .
-.TP
-.BI key " <bdaddr>"
-Change the connection link key for the device with Bluetooth address
-.IR bdaddr .
-.TP
-.BI clkoff " <bdaddr>"
-Read the clock offset for the device with Bluetooth address
-.IR bdaddr .
-.TP
-.BI clock " [bdaddr] [which clock]"
-Read the clock for the device with Bluetooth address
-.IR bdaddr .
-The clock can be
-.BR 0
-for the local clock or
-.BR 1
-for the piconet clock (which is default).
-.TP
-.BI lescan " [--privacy] [--passive] [--whitelist] [--discovery=g|l] \
-[--duplicates]"
-Start LE scan
-.TP
-.BI leinfo " [--static] [--random] <bdaddr>"
-Get LE remote information
-.TP
-.BI lewladd " [--random] <bdaddr>"
-Add device to LE White List
-.TP
-.BI lewlrm " <bdaddr>"
-Remove device from LE White List
-.TP
-.BI lewlsz
-Read size of LE White List
-.TP
-.BI lewlclr
-Clear LE White List
-.TP
-.BI lerladd " [--local irk] [--peer irk] [--random] <bdaddr>"
-Add device to LE Resolving List
-.TP
-.BI lerlrm " <bdaddr>"
-Remove device from LE Resolving List
-.TP
-.BI lerlclr
-Clear LE Resolving List
-.TP
-.BI lerlsz
-Read size of LE Resolving List
-.TP
-.BI lerlon
-Enable LE Address Resolution
-.TP
-.BI lerloff
-Disable LE Address Resolution
-.TP
-.BI lecc " [--static] [--random] <bdaddr> | [--whitelist]"
-Create a LE Connection
-.TP
-.BI ledc " <handle> [reason]"
-Disconnect a LE Connection
-.TP
-.BI lecup " <handle> <min> <max> <latency> <timeout>"
-LE Connection Update
-.SH AUTHORS
-Written by Maxim Krasnyansky <maxk@qualcomm.com> and Marcel Holtmann <marcel@holtmann.org>
-.PP
-man page by Fabrizio Gennari <fabrizio.gennari@philips.com>
diff --git a/tools/hcitool.rst b/tools/hcitool.rst
new file mode 100644
index 000000000..f59d69407
--- /dev/null
+++ b/tools/hcitool.rst
@@ -0,0 +1,213 @@
+=======
+hcitool
+=======
+
+-------------------------------
+Configure Bluetooth connections
+-------------------------------
+
+:Authors: - Maxim Krasnyansky <maxk@qualcomm.com>
+          - Marcel Holtmann <marcel@holtmann.org>
+          - Fabrizio Gennari <fabrizio.gennari@philips.com>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: Nov 12, 2002
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**hcitool** -h
+
+**hcitool** *COMMAND* --help
+
+**hcitool** [-i *hciX*] [*COMMAND* [*PARAMETERS*]]
+
+DESCRIPTION
+===========
+
+**hcitool(1)** is used to configure Bluetooth connections and send some special
+command to Bluetooth devices. If no **command** is given, or if the option
+**-h** is used, *hcitool* prints some usage information and exits.
+
+OPTIONS
+=======
+
+-i <hciX>   The command is applied to device *hciX*, which must be the name of
+            an installed Bluetooth device. If not specified, the command will
+            be sent to the first available Bluetooth device.
+
+-h          Gives a list of possible commands
+
+COMMANDS
+========
+
+dev
+    Display local devices
+
+inq
+    Inquire remote devices. For each discovered device, Bluetooth device
+    address, clock offset and class are printed.
+
+scan
+    Inquire remote devices. For each discovered device, device name are printed.
+
+name <*bdaddr*>
+    Print device name of remote device with Bluetooth address *bdaddr*.
+
+info <*bdaddr*>
+    Print device name, version and supported features of remote device with
+    Bluetooth address *bdaddr*.
+
+spinq
+    Start periodic inquiry process. No inquiry results are printed.
+
+epinq
+    Exit periodic inquiry process.
+
+cmd <*ogf*> <*ocf*> [*parameters*]
+    Submit an arbitrary HCI command to local device. *ogf*, *ocf* and
+    parameters are hexadecimal bytes.
+
+con
+    Display active baseband connections
+
+cc [--*role*\=m|s] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
+    Create baseband connection to remote device with Bluetooth address *bdaddr*.
+
+    Option **--pkt-type** specifies a list  of  allowed packet types.
+    <*ptype*> is a comma-separated list of packet types, where the possible
+    packet types are **DM1**, **DM3**, **DM5**, **DH1**, **DH3**, **DH5**,
+    **HV1**, **HV2**, **HV3**. Default is to allow all packet types.
+
+    Option  **--role** can have value **m** (do not allow role switch, stay
+    master) or **s** (allow role switch, become slave if the peer asks to become
+    master). Default is **m**.
+
+dc <*bdaddr*> [*reason*]
+    Delete baseband connection from remote device with Bluetooth address
+    *bdaddr*.
+
+    The reason can be one of the Bluetooth HCI error codes.
+    Default is **19** for user ended connections. The value must be given in
+    decimal.
+
+sr <*bdaddr*> <*role*>
+    Switch role for the baseband connection from the remote device to
+    **master** or **slave**.
+
+cpt <*bdaddr*> <*ptypes*>
+    Change packet types for baseband connection to device with Bluetooth
+    address *bdaddr*. *ptypes* is a comma-separated list of packet types,
+    where the possible packet types are **DM1**, **DM3**, **DM5**, **DH1**,
+    **DH3**, **DH5**, **HV1**, **HV2**, **HV3**.
+
+rssi <*bdaddr*>
+    Display received signal strength information for the connection to the
+    device with Bluetooth address *bdaddr*.
+
+lq <*bdaddr*>
+    Display link quality for the connection to the device with Bluetooth
+    address *bdaddr*.
+
+tpl <*bdaddr*> [*type*]
+    Display transmit power level for the connection to the device with
+    Bluetooth address *bdaddr*.
+
+    The *type* can be **0** for the current transmit power level (which is
+    default) or **1** for the maximum transmit power level.
+
+afh <*bdaddr*>
+    Display AFH channel map for the connection to the device with Bluetooth
+    address *bdaddr*.
+
+lp <*bdaddr*> [*value*]
+    With no value, displays link policy settings for the connection to the
+    device with Bluetooth address *bdaddr*.
+
+    If *value* is given, sets the link policy settings for that connection to
+    *value*. Possible values are **RSWITCH**, **HOLD**, **SNIFF** and **PARK**.
+
+lst <*bdaddr*> [*value*]
+    With no value, displays link supervision timeout for the connection to
+    the device with Bluetooth address *bdaddr*.
+
+    If *value* is given, sets the link supervision timeout for that connection
+    to *value* slots, or to infinite if value is 0.
+
+auth <*bdaddr*>
+    Request authentication for the device with Bluetooth address *bdaddr*.
+
+enc <*bdaddr*> [*encrypt*]
+    **enable** or **disable** the encryption for the device with Bluetooth
+    address *bdaddr*.
+
+key <*bdaddr*>
+    Change the connection link key for the device with Bluetooth address
+    *bdaddr*.
+
+clkoff <*bdaddr*>
+    Read the clock offset for the device with Bluetooth address *bdaddr*.
+
+clock [*bdaddr*] [*clock*]
+    Read the clock for the device with Bluetooth address *bdaddr*.
+
+    The *clock* can be **0** for the local clock or **1** for the piconet
+    clock (which is default).
+
+lescan [--*privacy*] [--*passive*] [--*whitelist*] [--*discovery*\=g|l] [--*duplicates*]
+    Start LE scan
+
+leinfo [--*static*] [--*random*] <*bdaddr*>
+    Get LE remote information
+
+lewladd [--*random*] <*bdaddr*>
+    Add device to LE White List
+
+lewlrm <*bdaddr*>
+    Remove device from LE White List
+
+lewlsz
+    Read size of LE White List
+
+lewlclr
+    Clear LE White List
+
+lerladd [--*local_irk*] [--*peer_irk*] [--*random*] <*bdaddr*>
+    Add device to LE Resolving List
+
+lerlrm <*bdaddr*>
+    Remove device from LE Resolving List
+
+lerlclr
+    Clear LE Resolving List
+
+lerlsz
+    Read size of LE Resolving List
+
+lerlon
+    Enable LE Address Resolution
+
+lerloff
+    Disable LE Address Resolution
+
+lecc [--*static*] [--*random*] <*bdaddr*> | [--*whitelist*]
+    Create a LE Connection
+
+ledc <*handle*> [*reason*]
+    Disconnect a LE Connection
+
+lecup <*handle*> <*min*> <*max*> <*latency*> <*timeout*>
+    LE Connection Update
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
diff --git a/tools/hid2hci.1 b/tools/hid2hci.1
deleted file mode 100644
index c6876a309..000000000
--- a/tools/hid2hci.1
+++ /dev/null
@@ -1,46 +0,0 @@
-.\"
-.\"	This program is free software; you can redistribute it and/or modify
-.\"	it under the terms of the GNU General Public License as published by
-.\"	the Free Software Foundation; either version 2 of the License, or
-.\"	(at your option) any later version.
-.\"
-.\"	This program is distributed in the hope that it will be useful,
-.\"	but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\"	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\"	GNU General Public License for more details.
-.\"
-.\"	You should have received a copy of the GNU General Public License
-.\"	along with this program; if not, write to the Free Software
-.\"	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-.\"
-.\"
-.TH HID2HCI 1 "MAY 15, 2009" "" ""
-
-.SH NAME
-hid2hci \- Bluetooth HID to HCI mode switching utility
-.SH SYNOPSIS
-.BR "hid2hci
-[
-.I options
-]
-.SH DESCRIPTION
-.B hid2hci
-is used to set up switch supported Bluetooth devices into the HCI
-mode and back.
-.SH OPTIONS
-.TP
-.B --mode= [hid, hci]
-Sets the mode to switch the device into
-.TP
-.B --method= [csr, csr2, logitech-hid, dell]
-Which vendor method to use for switching the device.
-.TP
-.B --devpath=
-Specifies the device path in /sys
-.TP
-.B --help
-Gives a list of possible options.
-.TP
-.SH AUTHOR
-Written by Marcel Holtmann <marcel@holtmann.org>.
-.br
diff --git a/tools/hid2hci.rst b/tools/hid2hci.rst
new file mode 100644
index 000000000..6aa31154e
--- /dev/null
+++ b/tools/hid2hci.rst
@@ -0,0 +1,50 @@
+========
+hid2hci
+========
+
+-------------------------------------------
+Bluetooth HID to HCI mode switching utility
+-------------------------------------------
+
+:Author: Marcel Holtmann <marcel@holtmann.org>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: May 15, 2009
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**hid2hci** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+**hid2hci(1)** is used to set up switch supported Bluetooth devices into the
+HCI mode and back.
+
+OPTIONS
+=======
+
+--mode=[*mode*]         Sets the mode to the device into. The possible values
+                        for *mode* are **hid**, **hci**.
+
+--method=[*method*]     Which vendor method to use for switching the device.
+                        The possible values for *method* are **csr**, **csr2**,
+                        **logitech-hdi**, **dell**.
+
+--devpath               Specifies the device path in /sys
+
+--help                  Gives a list of possible options.
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
diff --git a/tools/l2ping.1 b/tools/l2ping.1
deleted file mode 100644
index 4d09b0528..000000000
--- a/tools/l2ping.1
+++ /dev/null
@@ -1,76 +0,0 @@
-.TH L2PING 1 "Jan 22 2002" BlueZ "Linux System Administration"
-.SH NAME
-l2ping \- Send L2CAP echo request and receive answer
-.SH SYNOPSIS
-.B l2ping
-.RB [\| \-i
-.IR <hciX> \|]
-.RB [\| \-s
-.IR size \|]
-.RB [\| \-c
-.IR count \|]
-.RB [\| \-t
-.IR timeout \|]
-.RB [\| \-d
-.IR delay \|]
-.RB [\| \-f \|]
-.RB [\| \-r \|]
-.RB [\| \-v \|]
-.I bd_addr
-
-.SH DESCRIPTION
-.LP
-L2ping sends a L2CAP echo request to the Bluetooth MAC address
-.I bd_addr
-given in dotted hex notation.
-.SH OPTIONS
-.TP
-.BI \-i " <hciX>"
-The command is applied to device
-.BI
-hciX
-, which must be the name of an installed Bluetooth device (X = 0, 1, 2, ...)
-If not specified, the command will be sent to the first available Bluetooth
-device.
-.TP
-.BI \-s " size"
-The
-.I size
-of the data packets to be sent.
-.TP
-.BI \-c " count"
-Send
-.I count
-number of packets then exit.
-.TP
-.BI \-t " timeout"
-Wait
-.I timeout
-seconds for the response.
-.TP
-.BI \-d " delay"
-Wait
-.I delay
-seconds between pings.
-.TP
-.B \-f
-Kind of flood ping. Use with care! It reduces the delay time between packets
-to 0.
-.TP
-.B \-r
-Reverse ping (gnip?). Send echo response instead of echo request.
-.TP
-.B \-v
-Verify response payload is identical to request payload. It is not required for
-remote stacks to return the request payload, but most stacks do (including
-Bluez).
-.TP
-.I bd_addr
-The Bluetooth MAC address to be pinged in dotted hex notation like
-.B 01:02:03:ab:cd:ef
-or
-.B 01:EF:cd:aB:02:03
-.SH AUTHORS
-Written by Maxim Krasnyansky <maxk@qualcomm.com> and Marcel Holtmann <marcel@holtmann.org>
-.PP
-man page by Nils Faerber <nils@kernelconcepts.de>, Adam Laurie <adam@algroup.co.uk>.
diff --git a/tools/l2ping.rst b/tools/l2ping.rst
new file mode 100644
index 000000000..5076b7abf
--- /dev/null
+++ b/tools/l2ping.rst
@@ -0,0 +1,69 @@
+======
+l2ping
+======
+
+------------------------------------------
+Send L2CAP echo request and receive answer
+------------------------------------------
+
+:Authors: - Maxim Krasnyansky <maxk@qualcomm.com>
+          - Marcel Holtmann <marcel@holtmann.org>
+          - Nils Faerber <nils@kernelconcepts.de>
+          - Adam Laurie <adam@algroup.co.uk>.
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: Jan 22, 2002
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**l2ping** [*OPTIONS*] *bd_addr*
+
+DESCRIPTION
+===========
+
+**l2ping(1)** sends a L2CAP echo request to the Bluetooth MAC address bd_addr
+given in dotted hex notation.
+
+OPTIONS
+=======
+
+-i <hciX>       The command is applied to device *hciX*, which must be the
+                name of an installed Bluetooth device (X = 0, 1, 2, ...)
+                If not specified, the command will be sent to the first
+                available Bluetooth device.
+
+-s size         The size of the data packets to be sent.
+
+-c count        Send count number of packets then exit.
+
+-t timeout      Wait timeout seconds for the response.
+
+-d delay        Wait delay seconds between pings.
+
+-f              Kind of flood ping. Use with care! It reduces the delay time
+                between packets to 0.
+
+-r              Reverse ping (gnip?). Send echo response instead of echo
+                request.
+
+-v              Verify response payload is identical to request payload.
+                It is not required for remote stacks to return the request
+                payload, but most stacks do (including Bluez).
+
+bd_addr
+    The Bluetooth MAC address to be pinged in dotted hex notation
+    like **01:02:03:ab:cd:ef** or **01:EF:cd:aB:02:03**
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
diff --git a/tools/rctest.1 b/tools/rctest.1
deleted file mode 100644
index dfedbefd5..000000000
--- a/tools/rctest.1
+++ /dev/null
@@ -1,90 +0,0 @@
-.TH RCTEST 1 "Jul 6 2009" BlueZ ""
-.SH NAME
-rctest \- RFCOMM testing
-.SH SYNOPSIS
-.B rctest
-<\fImode\fR> [\fIoptions\fR] [\fIbdaddr\fR]
-
-.SH DESCRIPTION
-.LP
-.B
-rctest
-is used to test RFCOMM communications on the BlueZ stack
-
-.SH MODES
-.TP
-.B -r
-listen and receive
-.TP
-.B -w
-listen and send
-.TP
-.B -d
-listen and dump incoming data
-.TP
-.B -s
-connect and send
-.TP
-.B -u
-connect and receive
-.TP
-.B -n
-connect and be silent
-.TP
-.B -c
-connect, disconnect, connect, ...
-.TP
-.B -m
-multiple connects
-
-.SH OPTIONS
-.TP
-.BI -b\  bytes
-send/receive \fIbytes\fR bytes
-.TP
-.BI -i\  device
-select the specified \fIdevice\fR
-.TP
-.BI -P\  channel
-select the specified \fIchannel\fR
-.TP
-.BI -U\  uuid
-select the specified \fIuuid\fR
-.TP
-.BI -L\  seconds
-enable SO_LINGER options for \fIseconds\fR
-.TP
-.BI -W\  seconds
-enable deferred setup for \fIseconds\fR
-.TP
-.BI -B\  filename
-use data packets from \fIfilename\fR
-.TP
-.BI -N\  num
-send \fInum\fR frames
-.TP
-.BI -C\  num
-send \fInum\fR frames before delay (default: 1)
-.TP
-.BI -D\  milliseconds
-delay \fImilliseconds\fR after sending \fInum\fR frames (default: 0)
-.TP
-.B -A
-request authentication
-.TP
-.B -E
-request encryption
-.TP
-.B -S
-secure connection
-.TP
-.B -M
-become master
-.TP
-.B -T
-enable timestamps
-
-.SH AUTHORS
-Written by Marcel Holtmann <marcel@holtmann.org> and Maxim Krasnyansky
-<maxk@qualcomm.com>, man page by Filippo Giunchedi <filippo@debian.org>
-.PP
diff --git a/tools/rctest.rst b/tools/rctest.rst
new file mode 100644
index 000000000..23595112d
--- /dev/null
+++ b/tools/rctest.rst
@@ -0,0 +1,81 @@
+======
+rctest
+======
+
+--------------
+RFCOMM testing
+--------------
+
+:Authors: - Maxim Krasnyansky <maxk@qualcomm.com>
+          - Marcel Holtmann <marcel@holtmann.org>
+          - Filippo Giunchedi <filippo@debian.org>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: Jul 6, 2009
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**rctest** <*MODE*> [*OPTIONS*] [*bdaddr*]
+
+DESCRIPTION
+===========
+
+**rctest(1)** is used to test RFCOMM communications on the BlueZ stack
+
+MODES
+=====
+
+-r      listen and receive
+-w      listen and send
+-d      listen and dump incoming data
+-s      connect and send
+-u      connect and receive
+-n      connect and be silent
+-c      connect, disconnect, connect, ...
+-m      multiple connects
+
+OPTIONS
+=======
+-b bytes        send/receive bytes
+
+-i device       select the specified device
+
+-P channel      select the specified channel
+
+-U uuid         select the specified uuid
+
+-L seconds      enable SO_LINGER options for seconds
+
+-W seconds      enable deferred setup for seconds
+
+-B filename     use data packets from filename
+
+-N num          send num frames
+
+-C num          send num frames before delay (default: 1)
+
+-D milliseconds     delay milliseconds after sending num frames (default: 0)
+
+-A              request authentication
+
+-E              request encryption
+
+-S              secure connection
+
+-M              become master
+
+-T              enable timestamps
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
diff --git a/tools/rfcomm.1 b/tools/rfcomm.1
deleted file mode 100644
index a10860984..000000000
--- a/tools/rfcomm.1
+++ /dev/null
@@ -1,113 +0,0 @@
-.\"
-.\"	This program is free software; you can redistribute it and/or modify
-.\"	it under the terms of the GNU General Public License as published by
-.\"	the Free Software Foundation; either version 2 of the License, or
-.\"	(at your option) any later version.
-.\"
-.\"	This program is distributed in the hope that it will be useful,
-.\"	but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\"	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\"	GNU General Public License for more details.
-.\"
-.\"	You should have received a copy of the GNU General Public License
-.\"	along with this program; if not, write to the Free Software
-.\"	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-.\"
-.\"
-.TH RFCOMM 1 "APRIL 28, 2002" "" ""
-
-.SH NAME
-rfcomm \- RFCOMM configuration utility
-.SH SYNOPSIS
-.BR "rfcomm
-[
-.I options
-] <
-.I command
-> <
-.I dev
->
-.SH DESCRIPTION
-.B rfcomm
-is used to set up, maintain, and inspect the RFCOMM configuration
-of the Bluetooth subsystem in the Linux kernel. If no
-.B command
-is given, or if the option
-.B -a
-is used,
-.B rfcomm
-prints information about the configured RFCOMM devices.
-.SH OPTIONS
-.TP
-.BI -h
-Gives a list of possible commands.
-.TP
-.BI -a
-Prints information about all configured RFCOMM devices.
-.TP
-.BI -r
-Switch TTY into raw mode (doesn't work with "bind").
-.TP
-.BI -i " <hciX> | <bdaddr>"
-The command is applied to device hciX, which must be the name or the address of
-an installed Bluetooth device. If not specified, the command will be use the
-first available Bluetooth device.
-.TP
-.BI -A
-Enable authentification
-.TP
-.BI -E
-Enable encryption
-.TP
-.BI -S
-Secure connection
-.TP
-.BI -M
-Become the master of a piconet
-.TP
-.BI -L " <seconds>"
-Set linger timeout
-.SH COMMANDS
-.TP
-.BI show " <dev>"
-Display the information about the specified device.
-.TP
-.BI connect " <dev> [bdaddr] [channel]"
-Connect the RFCOMM device to the remote Bluetooth device on the
-specified channel. If no channel is specified, it will use the
-channel number 1. This command can be terminated with the key
-sequence CTRL-C.
-.TP
-.BI listen " <dev> [channel] [cmd]"
-Listen on a specified RFCOMM channel for incoming connections.
-If no channel is specified, it will use the channel number 1, but
-a channel must be specified before cmd. If cmd is given, it will be
-executed as soon as a client connects. When the child process
-terminates or the client disconnect, the command will terminate.
-Occurrences of {} in cmd will be replaced by the name of the device
-used by the connection. This command can be terminated with the key
-sequence CTRL-C.
-.TP
-.BI watch " <dev> [channel] [cmd]"
-Watch is identical to
-.B listen
-except that when the child process terminates or the client
-disconnect, the command will restart listening with the same
-parameters.
-.TP
-.BI bind " <dev> [bdaddr] [channel]"
-This binds the RFCOMM device to a remote Bluetooth device. The
-command does not establish a connection to the remote device, it
-only creates the binding. The connection will be established right
-after an application tries to open the RFCOMM device. If no channel
-number is specified, it uses the channel number 1.
-.TP
-.BI release " <dev>"
-This command releases a defined RFCOMM binding.
-
-If
-.B all
-is specified for the RFCOMM device, then all bindings will be removed.
-.SH AUTHOR
-Written by Marcel Holtmann <marcel@holtmann.org>.
-.br
diff --git a/tools/rfcomm.rst b/tools/rfcomm.rst
new file mode 100644
index 000000000..3c1b8cd68
--- /dev/null
+++ b/tools/rfcomm.rst
@@ -0,0 +1,100 @@
+======
+rfcomm
+======
+
+----------------------------
+RFCOMM configuration utility
+----------------------------
+
+:Author: Marcel Holtmann <marcel@holtmann.org>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: April 28, 2002
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**rfcomm** [*OPTIONS*] <*COMMAND*> <*dev*>
+
+DESCRIPTION
+===========
+
+**rfcomm(1)** is used to set up, maintain, and inspect the RFCOMM configuration
+of the Bluetooth subsystem in the Linux kernel. If no **command** is given,
+or if the option **-a** is used, **rfcomm** prints information about the
+configured RFCOMM devices.
+
+OPTIONS
+=======
+
+-h      Gives a list of possible commands.
+
+-a      Prints information about all configured RFCOMM devices.
+
+-r      Switch TTY into raw mode (doesn't work with "bind").
+
+-i <*hciX*> | <*bdaddr*>
+    The command is applied to device *hciX*, which must be the name or the
+    address of an installed Bluetooth device. If not specified, the command
+    will be use the first available Bluetooth device.
+
+-A     Enable authentication
+
+-E     Enable encryption
+
+-S     Secure connection
+
+-M     Become the master of a piconet
+
+-L <seconds>    Set linger timeout
+
+COMMANDS
+========
+
+show <*dev*>
+    Display the information about the specified device.
+
+connect <*dev*> [*bdaddr*] [*channel*]
+    Connect the RFCOMM device to the remote Bluetooth device on the specified
+    channel. If no  channel  is  specified, it will use the channel
+    number **1**. This command can be terminated with the key sequence CTRL-C.
+
+listen <*dev*> [*channel*] [*cmd*]
+    Listen  on  a specified RFCOMM channel for incoming connections.  If no
+    channel is specified, it will use the channel number **1**, but a channel
+    must be specified before cmd. If cmd is given, it will be executed as soon
+    as a  client  connects.  When the child process terminates or the client
+    disconnect, the command will terminate. Occurrences of {} in cmd will be
+    replaced by the name of the device used by the connection. This command
+    can be terminated with the key sequence CTRL-C.
+
+watch <*dev*> [*channel*] [*cmd*]
+    Watch is identical to listen except that when the child process
+    terminates or the client disconnect, the command will restart listening
+    with the same parameters.
+
+bind <*dev*> [*bdaddr*] [*channel*]
+    This binds the RFCOMM device to a remote Bluetooth device. The command
+    does not establish a connection to the remote  device, it only creates
+    the binding. The connection will be established right after an application
+    tries to open the RFCOMM device. If no channel number is specified, it
+    uses the channel number **1**.
+
+release <*dev*>
+    This command releases a defined RFCOMM binding.
+
+    If **all** is specified for the RFCOMM device, then all bindings will be
+    removed.
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
diff --git a/tools/sdptool.1 b/tools/sdptool.1
deleted file mode 100644
index ea959333d..000000000
--- a/tools/sdptool.1
+++ /dev/null
@@ -1,132 +0,0 @@
-.\" $Header$
-.\"
-.\"	transcript compatibility for postscript use.
-.\"
-.\"	synopsis:  .P! <file.ps>
-.\"
-.de P!
-.fl
-\!!1 setgray
-.fl
-\\&.\"
-.fl
-\!!0 setgray
-.fl			\" force out current output buffer
-\!!save /psv exch def currentpoint translate 0 0 moveto
-\!!/showpage{}def
-.fl			\" prolog
-.sy sed -e 's/^/!/' \\$1\" bring in postscript file
-\!!psv restore
-.
-.de pF
-.ie     \\*(f1 .ds f1 \\n(.f
-.el .ie \\*(f2 .ds f2 \\n(.f
-.el .ie \\*(f3 .ds f3 \\n(.f
-.el .ie \\*(f4 .ds f4 \\n(.f
-.el .tm ? font overflow
-.ft \\$1
-..
-.de fP
-.ie     !\\*(f4 \{\
-.	ft \\*(f4
-.	ds f4\"
-'	br \}
-.el .ie !\\*(f3 \{\
-.	ft \\*(f3
-.	ds f3\"
-'	br \}
-.el .ie !\\*(f2 \{\
-.	ft \\*(f2
-.	ds f2\"
-'	br \}
-.el .ie !\\*(f1 \{\
-.	ft \\*(f1
-.	ds f1\"
-'	br \}
-.el .tm ? font underflow
-..
-.ds f1\"
-.ds f2\"
-.ds f3\"
-.ds f4\"
-'\" t
-.ta 8n 16n 24n 32n 40n 48n 56n 64n 72n
-.TH "sdptool" "1"
-.SH "NAME"
-sdptool \(em control and interrogate SDP servers
-.SH "SYNOPSIS"
-.PP
-\fBsdptool\fR [\fIoptions\fR]  {\fIcommand\fR}  [\fIcommand parameters\fR \&...]
-.SH "DESCRIPTION"
-.PP
-\fBsdptool\fR provides the interface for
-performing SDP queries on Bluetooth devices, and administering a
-local SDP database.
-.SH "COMMANDS"
-.PP
-The following commands are available.  In all cases \fBbdaddr\fR
-specifies the device to search or browse.  If \fIlocal\fP is used
-for \fBbdaddr\fP, then the local SDP database is searched.
-.PP
-Services are identified and manipulated with a 4-byte \fBrecord_handle\fP
-(NOT the service name).  To find a service's \fBrecord_handle\fP, look for the
-"Service RecHandle" line in the \fBsearch\fP or \fBbrowse\fP results
-.IP "\fBsearch [--bdaddr bdaddr] [--tree] [--raw] [--xml] service_name\fP" 10
-Search for services..
-.IP "" 10
-Known service names are DID, SP, DUN, LAN, FAX, OPUSH,
-FTP, HS, HF, HFAG, SAP, NAP, GN, PANU, HCRP, HID, CIP,
-A2SRC, A2SNK, AVRCT, AVRTG, UDIUE, UDITE and SYNCML.
-.IP "\fBbrowse [--tree] [--raw] [--xml] [bdaddr]\fP" 10
-Browse all available services on the device
-specified by a Bluetooth address as a parameter.
-.IP "\fBrecords [--tree] [--raw] [--xml] bdaddr\fP" 10
-Retrieve all possible service records.
-.IP "\fBadd [ --handle=N --channel=N ]\fP" 10
-Add a service to the local
-SDP database.
-.IP "" 10
-You can specify a handle for this record using
-the \fB--handle\fP option.
-.IP "" 10
-You can specify a channel to add the service on
-using the \fB--channel\fP option.
-.IP "" 10
-NOTE: Local adapters configuration will not be updated and this command should
-be used only for SDP testing.
-.IP "\fBdel record_handle\fP" 10
-Remove a service from the local
-SDP database.
-.IP "" 10
-NOTE: Local adapters configuration will not be updated and this command should
-be used only for SDP testing.
-.IP "\fBget [--tree] [--raw] [--xml] [--bdaddr bdaddr] record_handle\fP" 10
-Retrieve a service from the local
-SDP database.
-.IP "\fBsetattr record_handle attrib_id attrib_value\fP" 10
-Set or add an attribute to an SDP record.
-
-.IP "\fBsetseq record_handle attrib_id attrib_values\fP" 10
-Set or add an attribute sequence to an
-SDP record.
-.SH "OPTIONS"
-.IP "\fB--help\fP" 10
-Displays help on using sdptool.
-
-.SH "EXAMPLES"
-.PP
-sdptool browse 00:80:98:24:15:6D
-.PP
-sdptool browse local
-.PP
-sdptool add DUN
-.PP
-sdptool del 0x10000
-.SH "BUGS"
-.PP
-Documentation needs improving.
-.SH "AUTHOR"
-.PP
-Maxim Krasnyansky <maxk@qualcomm.com>. Man page written
-by Edd Dumbill <ejad@debian.org>.
-.\" created by instant / docbook-to-man, Thu 15 Jan 2004, 21:01
diff --git a/tools/sdptool.rst b/tools/sdptool.rst
new file mode 100644
index 000000000..a4f416cd3
--- /dev/null
+++ b/tools/sdptool.rst
@@ -0,0 +1,103 @@
+=======
+sdptool
+=======
+
+-----------------------------------
+control and interrogate SDP servers
+-----------------------------------
+
+:Authors: - Maxim Krasnyansky <maxk@qualcomm.com>
+          - Edd Dumbill <ejad@debian.org>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**sdptool** [*OPTIONS*] [*COMMAND* [*PARAMETERS*]]
+
+DESCRIPTION
+===========
+
+**sdptool(1)** provides the interface for performing SDP queries on Bluetooth
+devices, and administering a local SDP database.
+
+COMMANDS
+========
+
+The following commands are available.  In all cases **bdaddr** specifies the
+device to search or browse.  If *local* is used for **bdaddr**, then the local
+SDP database is searched.
+
+Services are identified and manipulated with a 4-byte **record_handle** (NOT
+the service name). To find a service's **record_handle**, look for the
+"Service RecHandle" line in the **search** or **browse** results
+
+search [--bdaddr bdaddr] [--tree] [--raw] [--xml] service_name
+    Search for services..
+
+    Known  service  names  are  **DID**, **SP**, **DUN**, **LAN**, **FAX**,
+    **OPUSH**, **FTP**, **HS**, **HF**, **HFAG**, **SAP**, **NAP**, **GN**,
+    **PANU**, **HCRP**, **HID**, **CIP**, **A2SRC**, **A2SNK**, **AVRCT**,
+    **AVRTG**, **UDIUE**, **UDITE** and **SYNCML**.
+
+browse [--tree] [--raw] [--xml] [bdaddr]
+    Browse all available services on the device specified by a Bluetooth
+    address as a parameter.
+
+records [--tree] [--raw] [--xml] bdaddr
+    Retrieve all possible service records.
+
+add [ --handle=N --channel=N ]
+    Add a service to the local SDP database.
+
+    You can specify a handle for this record using the **--handle** option.
+
+    You can specify a channel to add the service on using the **--channel**
+    option.
+
+    NOTE: Local adapters configuration will not be updated and this command
+    should  be used only for SDP testing.
+
+del record_handle
+    Remove a service from the local SDP database.
+
+    NOTE: Local adapters configuration will not be updated and this command
+    should be used only for SDP testing.
+
+get [--tree] [--raw] [--xml] [--bdaddr bdaddr] record_handle
+    Retrieve a service from the local SDP database.
+
+setattr record_handle attrib_id attrib_value
+    Set or add an attribute to an SDP record.
+
+setseq record_handle attrib_id attrib_values
+    Set or add an attribute sequence to an SDP record.
+
+OPTIONS
+=======
+
+--help      Displays help on using sdptool.
+
+EXAMPLES
+========
+
+.. code-block::
+
+   $ sdptool browse 00:80:98:24:15:6D
+   $ sdptool browse local
+   $ sdptool add DUN
+   $ sdptool del 0x10000
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

