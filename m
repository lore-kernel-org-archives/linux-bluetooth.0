Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB52FC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 22:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358655AbiFVW2X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358311AbiFVW2Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 18:28:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38B26D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so734828pjm.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pf1spZWRVVmzlCkdIoNQHP94yvKyL48SphUGzWr78oI=;
        b=jhxXc0Zq7LrLaA1EVaLU4OiAlj5SARtO1kd5eKLD3WdOPIMQVOIWbylHEevbjUlih0
         s0iivKQ1HTE+fWMspWioD4auOyGNwbsAPwHavIaSfeO8jigiIqSp1oS8GwA/z2oFTkkS
         vbcxOxARxLqCnjPNqNlqdWT2Q9iFCoEGuqZRUUdX/0XhBcKOvP7ESEn0pe0jHZyr1phO
         NKMgTmbdRaDNZm4V9mWZWZ6wGtyIGcLOgBZ6NWnsMGPR5ZK7sLR1R+A2t3J4Pifu0dyu
         v9cSIhV061zHx7vfkMzGDhy8YDmTWmld+Ii1brie6LS6C3Qcs12czZPc2Vm3V/5jqazo
         JUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pf1spZWRVVmzlCkdIoNQHP94yvKyL48SphUGzWr78oI=;
        b=aRNvG59v5m0ckxG2p5PaMTE4/302+ab441VVtyujbCzgfO157n57fe4wkrgDZD8URx
         VnusUBBa6wOf3y8xmdOHHSaPolpN/FR1eP3VoWFaXcbbQ4DoiSo2uotdnNYK7hzh1NAr
         tg8XqTmC3WdgRVgAfGOW1aCHfdLhb1v66CmAr0QN4vd5PSUSJuUMhLqXJbt5+xWHzLe5
         uaG8tf5ZrEKwpoI6B0uMEArXvE/Px/16muCSKuwMLvYEGn/wKw1k2JS2Dvf2xb26prM7
         oh5QFNmifviD51+8FwGQJ40mkJX7ARu0E3Kh6q97zB3j+UZ4SnEXiKUeB9lthAeV1ORg
         Ak9g==
X-Gm-Message-State: AJIora/B2Fg8xKaPOTgZ/5yET+2lHnqe981Cf1Ul9tTH5YfD8ymPZI8B
        Pq0lpzp6PnbuZS631Ymw5qMz5nUYeLEKTw==
X-Google-Smtp-Source: AGRyM1vKgL3RUF9NNTwCy8xgLGTZxdxynrmGZm9NKvf6jVNDOkpGZcpNnr8aii40R6GrCOfxmxSCPw==
X-Received: by 2002:a17:90a:4f0a:b0:1ec:89bd:725c with SMTP id p10-20020a17090a4f0a00b001ec89bd725cmr630489pjh.172.1655936893091;
        Wed, 22 Jun 2022 15:28:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0016368840c41sm11710482plo.14.2022.06.22.15.28.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:28:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v7 8/8] isotest: Add documentation
Date:   Wed, 22 Jun 2022 15:28:01 -0700
Message-Id: <20220622222801.2676431-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220622222801.2676431-1-luiz.dentz@gmail.com>
References: <20220622222801.2676431-1-luiz.dentz@gmail.com>
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
index 4e5ff73b0..9412aed36 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -325,7 +325,7 @@ profiles_iap_iapd_SOURCES = profiles/iap/main.c
 profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
 if MANPAGES
-man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1
+man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1
 endif
 
 if MESH
@@ -443,7 +443,7 @@ manual_pages += tools/hciattach.1 tools/hciconfig.1 \
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
2.35.3

