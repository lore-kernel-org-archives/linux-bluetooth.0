Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320AC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358109AbiFQWVj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349580AbiFQWVe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 18:21:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC7562101
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m14so4969951plg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pf1spZWRVVmzlCkdIoNQHP94yvKyL48SphUGzWr78oI=;
        b=hpP9UXPtX0/HflA7YjMu20nK6QDL3JvuK92gvF3GTuUg51AWocGgTEfx1kQCR2TYRv
         4p7vXgvhq8iHZVzfEJL9KlIObw2JnE8avECuRHByzL6OGYbHM4kPcQ7c8MsenN757rJu
         nu6VTMRjHUHc12qPqeGXs9ytEdvfwN4EjyS3z3CstJv8O1fTzheVUhMLQH0X7/eWQI83
         tVyWH1ylKFvcmP+ILQ5TBHaGEZuJrSiTqs2fuEphATUGvzf2eKX1Cjp6WhhZSJtuD63G
         Hu92NqZEkHx7qDqu157ICP3t9lvZ133WiSmJytdhCsKipsoqH0p7TINfSrvCl1xGjWnj
         0IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pf1spZWRVVmzlCkdIoNQHP94yvKyL48SphUGzWr78oI=;
        b=tlSu0Y5cUZ7kwTgZPPEUoX20C26XlKnSEsOPDdyRpw/VCaOTL1IfahpSHzjwZ5Ilr6
         WMMPP4K0fqeL1e1VaZDfwpCejEk1tTlhGg8d0oNydeF5DR/Jo9hhdw7wqKQhkp6bb2dc
         3nCYqPuW9a8vKNDAWjsWSyXYB0ielSBV8hnvFCVdQo7ed333Xi4eICD4aPMLGHIhJ59W
         NjN4XLg261wrultQmLw4IiwKlflsoNB/pkoEJB350FVrvPiF0XzfAYZWrEfWKwyMfBxW
         IM4CEmxtuYvk2281hwNIWxzBXpsZsJJWNQ6F/MPITiSNVPJe4Pcd32OI91KmE2dcSpaP
         qvxQ==
X-Gm-Message-State: AJIora8zwmKqSC/bW/a3Zl+H4BDTW6dExvm8W2k+8nu3UtGC8iMibf+P
        qwnscaY8QZ5Y+cCO84Z74NFdavr6uLg=
X-Google-Smtp-Source: AGRyM1t9RzwlaeYH+LGReseTVawQeoeSCHsfWDWXx5PtTicVYPSSWM0/y0oAQvsd0tyPplF/Oexzjg==
X-Received: by 2002:a17:902:b684:b0:168:a438:ee26 with SMTP id c4-20020a170902b68400b00168a438ee26mr11912783pls.10.1655504490244;
        Fri, 17 Jun 2022 15:21:30 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v9-20020a056a00148900b0051829b1595dsm4165392pfu.130.2022.06.17.15.21.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:21:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v6 8/8] isotest: Add documentation
Date:   Fri, 17 Jun 2022 15:21:19 -0700
Message-Id: <20220617222119.1413958-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220617222119.1413958-1-luiz.dentz@gmail.com>
References: <20220617222119.1413958-1-luiz.dentz@gmail.com>
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

