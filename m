Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23342C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 20:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347356AbiEaUzp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347841AbiEaUzd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 16:55:33 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC119D064
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:20 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i9so2013516ioa.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5uSUhYYOLV+bPaAUFw7vYaWVL65B7sVoLtj+R1g3UM0=;
        b=TwhcEa4oPTsraH4GA74ZCUBDiUdK08R9Sv5Hkq0Bx1Z2ylI/5cF/FgW+DR0aSQ2qaX
         Y9dSsyZFCNLJunTG4U7OD3LoxubEx27XDawiQQE9j2h7UMYvfQjcNynAkuH7jBn9Bln1
         DI3Ek6NFjeRzZSZ1Cgl71gF36HacHw5YnF1BT0Ob9CIB4XFNEtQW6//XqoHw00+iULgC
         z2oz7okBynitGXfSKB5AOGAsiPEmCw44akxaSiU+lAeSeoRUVWXQWWapvXtepEOVOc0T
         tDlMGvvCl1Rq3eLvYeNSmnOJBVDm5fBgxMTg8o0LzbxD3DRwyL90ga2v3nCnEqqA20VC
         YIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uSUhYYOLV+bPaAUFw7vYaWVL65B7sVoLtj+R1g3UM0=;
        b=wlAhhoBpJSlFgktsmeTqoi6jGmf1feSoF1KYII4ZU20CQDBYB2Dz5StL1juUCvrbKL
         P8ojILWbQjvIb+ASXthHbkGWCz5SrIdVTXrbUVaZliWaj3wjjwujrBPpbuJBDOV8znwW
         gTPSefkTc6SS03eryHkP8S1SR1md2kMZQi79BBI3zi0562+qqQHgv8yWBgIr3aj2Lq30
         oH0zZOb9OMa8ozO6Z1OTZ9HRrHlaztIPTSlVe6URxHVdGVCfEJBuBpeCkLh8i9PZs9wm
         PnzJKRSzcWGFF/AN/g8X3gdfnNVN2QwqbowSeC/aCkS+OR3So01Rs38dpDejLzuSazxD
         M4zw==
X-Gm-Message-State: AOAM533VHcOJWrrux/AH44JiIF0OEL759oLfrquF+o3eB/iI1irY2Etg
        REJIh8wCADYqRN78Q2mXVW1y2U3exn4=
X-Google-Smtp-Source: ABdhPJx89xqlmyBpbylAH9juT+MGTMfooGrX3NkR02HOb8HQ5yYF/TwWXUAkGhrEliHCjVwurmv/Zw==
X-Received: by 2002:a05:6638:1446:b0:32e:a9c4:10c3 with SMTP id l6-20020a056638144600b0032ea9c410c3mr26322229jad.280.1654030519930;
        Tue, 31 May 2022 13:55:19 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v1-20020a922e01000000b002d10dc367a1sm4808460ile.49.2022.05.31.13.55.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 13:55:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 8/8] isotest: Add documentation
Date:   Tue, 31 May 2022 13:55:09 -0700
Message-Id: <20220531205509.1062466-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531205509.1062466-1-luiz.dentz@gmail.com>
References: <20220531205509.1062466-1-luiz.dentz@gmail.com>
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
2.35.1

