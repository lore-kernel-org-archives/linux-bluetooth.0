Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E205BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444790AbiEFWgn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444787AbiEFWgl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:36:41 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4B5B898
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:32:56 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d3so5669591ilr.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jphDCtdDfjaiIXtfG+mhEkeH7hPJrj01J7GaWljWSIs=;
        b=kDR/jefIGxDuPF5DlSFfejIti1PbS3XnRlTrYEzi7/kMFHoNpmPFuGmQVOcMJVaYmU
         NeEurmRFChmZ0ii/u9ODKuHJs8/JNTTAEjaEEFdMde+gp/sD2/1vtDTP4r3xFii2BKq4
         FDGeucHPR/sOBYo7SgQQ2XSMp45mBMqf8dFjil+r23so10t6ac3Q/T2m8c0lOE0lfyxf
         p/to25ZmlP4HrcOQywg7+4CxPJ42Qu8r5YKkF7jiG1xFDLgzYOfZG9HFyOPIv4L7Soqb
         HaUd+HPllq03Y/sBXtvmiuRy7iaFp71VI6Brvd5OjKe+UX0kBEcCkeyYUgfYwf4C5guP
         AIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jphDCtdDfjaiIXtfG+mhEkeH7hPJrj01J7GaWljWSIs=;
        b=poiW0f6jmE4jTsgnGnk0puz3IwybXySbsT/hZxiG3/bUB54PdCNRD9ixguE0T0ta3P
         gwiRKv3dbh8xY4Q1isE+30k90XUym7JtWsJ1JbjfxGqI9TSORt6+zeWHSMhURVRzbwKB
         O+C1UbwncFA8gfOFD6gyiHvDWZrAwof/pOxu1Jo/l8q2efAhHJ/kqseuwyZI6eLy9g+Z
         KJSXeEHGr8zpNcckFFxSsk4NTUcjj6Ch1FFvzRBgz2A/vqD71rW4jtZm6v83lDPVuNt8
         Jn8K1DKCQe4+q03RZ55V+hVgsDhJcfDZncVXDi3p7HC/waAfOn4g/mSkJf9/nE+4b6Ky
         W4xg==
X-Gm-Message-State: AOAM530S1NRdrIJQf3nua1azf4p391gVWIirqBzgeEPFm77BOZnr0lDv
        elFAAfMe4fQXcMmgaLpXL57B3ffVxgE=
X-Google-Smtp-Source: ABdhPJyIK83ulgGjZk+hr//TVBvPsw6pTWpgEYkHbiMaFOUtY0pWRHTQD9AyZGd4JgG7Dw53UuhhhA==
X-Received: by 2002:a05:6e02:2191:b0:2ce:7074:9da7 with SMTP id j17-20020a056e02219100b002ce70749da7mr2118184ila.28.1651876375361;
        Fri, 06 May 2022 15:32:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x20-20020a056638249400b0032b3a7817d3sm1647254jat.151.2022.05.06.15.32.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:32:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 8/8] isotest: Add documentation
Date:   Fri,  6 May 2022 15:32:45 -0700
Message-Id: <20220506223245.3950871-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506223245.3950871-1-luiz.dentz@gmail.com>
References: <20220506223245.3950871-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds isotest.rst which documents the modes and options of
isotest(1) and is then converted isotest.1 manpage.
---
 Makefile.tools    |   4 +-
 tools/isotest.rst | 202 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 tools/isotest.rst

diff --git a/Makefile.tools b/Makefile.tools
index 3e949c00c..3c5766728 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -320,7 +320,7 @@ profiles_iap_iapd_SOURCES = profiles/iap/main.c
 profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
 if MANPAGES
-man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1
+man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1
 endif
 
 if MESH
@@ -438,7 +438,7 @@ manual_pages += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
 			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1 \
 			tools/rctest.1 tools/l2ping.1 tools/btattach.1 \
-			tools/bdaddr.1
+			tools/bdaddr.1 tools/isotest.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
diff --git a/tools/isotest.rst b/tools/isotest.rst
new file mode 100644
index 000000000..b2f4e4b38
--- /dev/null
+++ b/tools/isotest.rst
@@ -0,0 +1,202 @@
+=======
+isotest
+=======
+
+-----------
+ISO testing
+-----------
+
+:Authors: - Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: May 4, 2022
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**isotest** <*MODE*> [*OPTIONS*] [*bdaddr*] [*bdaddr1*]...
+
+DESCRIPTION
+===========
+
+**isotest(1)** is used to test Isochronous (CIS/BIS) communications on the
+BlueZ stack
+
+MODES
+=====
+
+-d, --dump=[FILE]        Listen and dump incoming data
+                         (CIS server/BIS broadcaster) and optionally save the
+			 contents to *FILE*.
+
+-c, --reconnect          Reconnect (CIS client).
+
+-m, --multiple           Multiple connects (CIS client).
+
+-r, --receive=[FILE]     Receive (CIS server/BIS broadcast receiver) and
+                         optionally save the contents to *FILE*.
+
+-s, --send=[FILE]        Connect and send (CIS client/BIS broadcaster), can
+                         optionally use contents from *FILE*.
+
+-n, --silent             Connect and be silent (CIS client/BIS broadcaster).
+
+OPTIONS
+=======
+
+-b, --bytes=<SIZE>      Send or Receive packet size
+
+-i, --index=<NUM>        Select the specified HCI device index. *hciNUM* is
+                         also acceptable.
+
+-j, --jitter=<JITTER>    Socket jitter buffer.
+
+-h, --help
+
+-q, --quiet              Disables packet logging.
+
+-t, --timeout=<USEC>     Socket send timeout.
+
+-C, --continue           Continuously send packets starting over in case of a
+                         file.
+
+-W, --defer=<SEC>        Enable deferred setup.
+
+-M, --mtu=<SDU>          Socket QoS SDU.
+
+-S, --sca/adv-interval=<SCA/INTERVAL>
+                         Socket QoS CIS SCA/BIS advertising interval.
+
+-P, --packing=<PACKING>  Socket QoS Packing.
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+   :stub-columns: 1
+   :align: left
+
+   * - *PACKING*
+     - Description
+
+   * - **0x00**
+     - Sequential
+
+   * - **0x01**
+     - Interleaved
+
+-F, --framing=<FRAMING>  Socket QoS Framing.
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+   :stub-columns: 1
+   :align: left
+
+   * - *FRAMING*
+     - Description
+
+   * - **0x00**
+     - Unframed
+
+   * - **0x01**
+     - Framed
+
+-I, --interval=<USEC>    Socket QoS Interval.
+
+-L, --latency=<MSEC>     Socket QoS Latency.
+
+-Y, --phy=<PHY>          Socket QoS PHY.
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+   :stub-columns: 1
+   :align: left
+
+   * - *PHY*
+     - Description
+
+   * - **0x01**
+     - LE 1M
+
+   * - **0x02**
+     - LE 2M
+
+   * - **0x03**
+     - LE Coded
+
+-R, --rtn=<NUM>          Socket QoS retransmissions.
+
+-B, --preset=<PRESET>    Socket QoS preset.
+
+-G, --CIG/BIG=<ID>       Socket QoS CIG/BIG ID.
+
+-T, --CIS/BIS=<ID>       Socket QoS CIS/BIS ID.
+
+-V, --type=<TYPE>        Socket destination address type:
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+   :stub-columns: 1
+   :align: left
+
+   * - *TYPE*
+     - Description
+
+   * - **le_public**
+     - LE Public Address
+
+   * - **le_random**
+     - LE Random Address
+
+EXAMPLES
+========
+
+Unicast Central
+---------------
+
+.. code-block::
+
+    $ tools/isotest -s XX:XX:XX:XX:XX:XX
+
+Unicast Central connecting to 2 peers using CIG 0x01
+----------------------------------------------------
+
+.. code-block::
+
+    $ tools/isotest -G 0x01 -s XX:XX:XX:XX:XX:XX YY:YY:YY:YY:YY:YY
+
+Unicast Peripheral
+------------------
+
+.. code-block::
+
+    $ tools/isotest -d
+
+Broadcaster
+-----------
+
+.. code-block::
+
+    $ tools/isotest -s 00:00:00:00:00:00
+
+Broadcast Receiver using hci1
+-----------------------------
+
+.. code-block::
+
+    $ tools/isotest -i hci1 -d XX:XX:XX:XX:XX:XX
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
2.35.1

