Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1FAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444732AbiEFWWQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444724AbiEFWWM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:22:12 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2430E008
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:18:26 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y11so5659313ilp.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jphDCtdDfjaiIXtfG+mhEkeH7hPJrj01J7GaWljWSIs=;
        b=L2iaTzysFpsmJpDRYkcithFYfPSqN93QaJ9PUpBEKvKhlXvnPDDR7TCcTf6xjWDtkO
         TUcYSAhrYhSH7e9bqb4f5IsCIdBZcgjM/j22yNtgpE3l60Un1D8GJ9zXivoubsourvc5
         aWsUTNtGSKSpyS761sny4qJ3rbbQ2xfu2agS4HKaUIxhdUcriv5EUzwVxxFGqS4nF1+X
         6TNyyH8U3iYhOpaiJVMfg0ldIBZ/hI0ImoeSkhje18xO343UFYa6v29ZMlSjpyWQrYiT
         Royc2QOn3NCkAcTrvfxwOr517JNUe+Z14vfBDJtM1IAQneGTtTjLY3KYudlsaF+4llW2
         rW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jphDCtdDfjaiIXtfG+mhEkeH7hPJrj01J7GaWljWSIs=;
        b=g9rq6ukwA3SU0lT+fb8HRj58oJkK2BzAQH6tPUVQ6SLXh2xbXNv4e3Ui88Po08Pky0
         g6mOn27dAu10ZHVgtmffPxfj+i3mUIPrjfEvgjnrD7+ZpO470EhN/XJnh3Yd9iFeenP9
         +fCdnLSi31bwWzXZioM4XoU08EbdASCQ7zEHtnmlrPXYzV8aplAwWtNuyImRk7Bwonjq
         RECOHjfAQKPxm2HGG89xWuioKV1aRQaKND4gcLuM9d4S9+y/+IQt/wbDMradYmQ/7L+9
         YNXInHAHoqMKxypbOO47OxjKuzDWBJixFJdayHsQhS+eabRRDzIFulKTske53vO5RXdL
         UJlQ==
X-Gm-Message-State: AOAM531xb0loCXcTMU0KMjqJLH766V7Y4ZXEVPmt7BG/4F6ZTNHaJ4CZ
        or6sseKRIqoLe4f7PqTrQMCAfEUdgik=
X-Google-Smtp-Source: ABdhPJzWUQJS0t4qfXuKrFeiiCUxo0AHze10CQPDo8kw23d55eAEr+29v2KHFdQt/0F5p572QUJyuQ==
X-Received: by 2002:a92:cac4:0:b0:2c8:1095:b352 with SMTP id m4-20020a92cac4000000b002c81095b352mr1994022ilq.103.1651875506268;
        Fri, 06 May 2022 15:18:26 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g4-20020a056e02130400b002cde6e352c8sm1480822ilr.18.2022.05.06.15.18.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:18:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 7/7] isotest: Add documentation
Date:   Fri,  6 May 2022 15:18:18 -0700
Message-Id: <20220506221818.3933843-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506221818.3933843-1-luiz.dentz@gmail.com>
References: <20220506221818.3933843-1-luiz.dentz@gmail.com>
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

