Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5570CEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jul 2023 23:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGRXSM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGRXSL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jul 2023 19:18:11 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76672ED
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jul 2023 16:18:06 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a28de15c8aso4881764fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jul 2023 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689722285; x=1692314285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVxo4OWZW6z/7FUGBRCfvhPoAFoJOteL+vRqwtxthQ0=;
        b=TihFqg8WYiCl91+CO+C35tIJ5Fw+bC/jemXVyGbcVAU+YNymWPTjwMm6erhFDKbB8D
         xhVZG26S23i3xjhtojl8LnZ3By6gfKQT0uJk82U76GfN2aPPQkmYAg5MTH/DHRTqtgcZ
         IH9qpWJAQt4XQ/DCwgdZM/tDok4k0hQb0XEclz3fetxpre1O2djQxqKcKUA8Lf/F4aAz
         24kgBGtcaLexJ0Texew6KkD8vcViE7KY35iWwrXtyKFl6R7DNCvyOi97n8zpKzdLiikR
         a4sukAYc598u77lhojoyJhPa+R131d2qsJgNuBMGxpuFkLrjL6yYfDwuIY4pX3XtR4fa
         QUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689722285; x=1692314285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVxo4OWZW6z/7FUGBRCfvhPoAFoJOteL+vRqwtxthQ0=;
        b=UM+6YbmehJCQgaFSbDrKrEDWmdB1zncApA+Nn8gWUSthoVQH7ZZf76SXE9eA/YaT4I
         RU5FYIOdFFGUDRtQalJ6P+Sk5jdj6Sskpu5gdc7sarNfRHE1DM1GtyvN3NAbMS+mETh7
         9Ro271huW8NJAbaw3q7cWuSKRoK0J07WJdmV5Cdp/FxLFcRagp0JkrfMgns95no+vyq/
         DQ0QV2O0NA2Ww02OBrL0XM8waWxl3Z6GbZaiH4hqhkVas3/mRs1dG3A1saPFebHY+9kk
         XJK47O+LM4W5JC4g6cqZHNSlK0XcrGo7IVdpDTpBcw71hAG9wYZ6rwrKR4R6cRSczyaS
         kdgw==
X-Gm-Message-State: ABy/qLYmUKnjXKv1py8c0Nsbi/0XrAp/fcMQqssXMLovPLLkUM1TIUeX
        l2UQBcN6z0G2yCUUf9tsV0e6JqQSx9U=
X-Google-Smtp-Source: APBJJlHMF23F/lcMeUGC1RFepnO4SrhLhNY84mlE0EE5EcmOE0OA2OaF6dQMyuVGILaqp7EHZ9pRvw==
X-Received: by 2002:a05:6870:f58d:b0:1b7:8b42:f17 with SMTP id eh13-20020a056870f58d00b001b78b420f17mr4106309oab.59.1689722284734;
        Tue, 18 Jul 2023 16:18:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id f18-20020a633812000000b0052858b41008sm2158928pga.87.2023.07.18.16.18.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 16:18:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2] btmgmt: Add man page
Date:   Tue, 18 Jul 2023 16:18:02 -0700
Message-ID: <20230718231802.217170-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btmgmt.rst which is then converted to btmgmt.1 using rst2man.
---
 Makefile.tools   |   5 +-
 tools/btmgmt.rst | 164 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+), 2 deletions(-)
 create mode 100644 tools/btmgmt.rst

diff --git a/Makefile.tools b/Makefile.tools
index 7d9697001b75..c1de187bf72b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -347,7 +347,8 @@ profiles_iap_iapd_SOURCES = profiles/iap/main.c
 profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
 if MANPAGES
-man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1
+man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1 \
+		tools/btmgmt.1
 endif
 
 if MESH
@@ -468,7 +469,7 @@ manual_pages += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
 			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1 \
 			tools/rctest.1 tools/l2ping.1 tools/btattach.1 \
-			tools/bdaddr.1 tools/isotest.1
+			tools/bdaddr.1 tools/isotest.1 tools/btmgmt.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
diff --git a/tools/btmgmt.rst b/tools/btmgmt.rst
new file mode 100644
index 000000000000..19c949133edc
--- /dev/null
+++ b/tools/btmgmt.rst
@@ -0,0 +1,164 @@
+======
+btmgmt
+======
+
+-------------------------------------
+interactive bluetooth management tool
+-------------------------------------
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
+**btmgmt** [--options] [commands]
+
+DESCRIPTION
+===========
+
+**btmgmt(1)** interactive bluetooth management tool. The tool issues commands
+to the Kernel using the Bluetooth Management socket, some commands may require
+net-admin capability in order to work since the Bluetooth Management interface
+is considered a low-level interface meant for the likes of **bluetoothd(1)**,
+so it is not recommended for applications to use it directly.
+
+OPTIONS
+=======
+
+.. csv-table::
+   :header: "Options", "Description"
+   :align: left
+
+   *-i/--index*, Specify adapter index
+   *-m-/-monitor*, Enable monitor output
+   *-t/--timeout*, Timeout in seconds for non-interactive mode
+   *-v/--version*, Display version
+   *-i/--init-script*, Init script file
+   *-h/--help*, Display help
+
+COMMANDS
+========
+
+.. csv-table::
+   :header: "Command", "Arguments", "Description"
+   :align: left
+
+   *select*, "<index>", Select a different index
+   *revision*, , Get the MGMT Revision
+   *commands*, , List supported commands
+   *config*, , Show configuration info
+   *info*, , Show controller info
+   *extinfo*, , Show extended controller info
+   *auto-power*, , Power all available features
+   *power*, <on/off>, Toggle powered state
+   *discov*, <yes/no/limited> [timeout], Toggle discoverable state
+   *connectable*, <on/off>, Toggle connectable state
+   *fast-conn*, <on/off>, Toggle fast connectable state
+   *bondable*, <on/off>, Toggle bondable state
+   *pairable*, <on/off>, Toggle bondable state
+   *linksec*, <on/off>, Toggle link level security
+   *ssp*, <on/off>, Toggle SSP mode
+   *sc*, <on/off/only>, Toggle SC support
+   *hs*, <on/off>, Toggle HS support
+   *le*, <on/off>, Toggle LE support
+   *advertising*, <on/off>, Toggle LE advertising
+   *bredr*, <on/off>, Toggle BR/EDR support
+   *privacy*, <on/off> [irk], Toggle privacy support
+   *class*, <major> <minor>, Set device major/minor class
+   *disconnect*, [-t type] <remote address>, Disconnect device
+   *con*, , List connections
+   *find*, [-l|-b] [-L], Discover nearby devices
+   *find-service*, [-u UUID] [-r RSSI_Threshold] [-l|-b], Discover nearby service
+   *stop-find*, [-l|-b], Stop discovery
+   *name*, <name> [shortname], Set local name
+   *pair*, [-c cap] [-t type] <remote address>, Pair with a remote device
+   *cancelpair*, [-t type] <remote address>, Cancel pairing
+   *unpair*, [-t type] <remote address>, Unpair device
+   *keys*, ,Load Link Keys
+   *ltks*, ,Load Long Term Keys
+   *irks*, [--local index] [--file file path], Load Identity Resolving Keys
+   *block*, [-t type] <remote address> Block Device
+   *unblock*, [-t type] <remote address>, Unblock Device
+   *add-uuid*, <UUID> <service class hint>, Add UUID
+   *rm-uuid*, <UUID>, Remove UUID
+   *clr-uuids*, ,Clear UUIDs
+   *local-oob*, ,Local OOB data
+   *remote-oob*, [-t <addr_type>] [-r <rand192>] [-h <hash192>] [-R <rand256>] [-H <hash256>] <addr>, Remote OOB data
+   *did*, <source>:<vendor>:<product>:<version>, Set Device ID
+   *static-addr*, <address>, Set static address
+   *public-addr*, <address>, Set public address
+   *ext-config*, <on/off>, External configuration
+   *debug-keys*, <on/off>, Toggle debug keys
+   *conn-info*, [-t type] <remote address>, Get connection information
+   *io-cap*, <cap>, Set IO Capability
+   *scan-params*, <interval> <window>, Set Scan Parameters
+   *get-clock*, [address], Get Clock Information
+   *add-device*, [-a action] [-t type] <address>, Add Device
+   *del-device*, [-t type] <address>, Remove Device
+   *clr-devices*, ,Clear Devices
+   *bredr-oob*, ,Local OOB data (BR/EDR)
+   *le-oob*, ,Local OOB data (LE)
+   *advinfo*, ,Show advertising features
+   *advsize*, [options] <instance_id>, Show advertising size info
+   *add-adv*, [options] <instance_id>, Add advertising instance
+   *rm-adv*, <instance_id>, Remove advertising instance
+   *clr-adv*, ,Clear advertising instances
+   *add-ext-adv-params*, [options] <instance_id>, Add extended advertising params
+   *add-ext-adv-data*, [options] <instance_id>, Add extended advertising data
+   *appearance*, <appearance>, Set appearance
+   *phy*, [LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] [LECODEDTX] [LECODEDRX] [BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT][EDR2M1SLOT] [EDR2M3SLOT] [EDR2M5SLOT][EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT], Get/Set PHY Configuration
+   *wbs*, <on/off>, Toggle Wideband-Speech support
+   *secinfo*, ,Show security information
+   *expinfo*, ,Show experimental features
+   *exp-debug*, <on/off>, Set debug feature
+   *exp-privacy*, <on/off>, Set LL privacy feature
+   *exp-quality*, <on/off>, Set bluetooth quality report feature
+   *exp-offload*, <on/off>, Toggle codec support
+   *read-sysconfig*, ,Read System Configuration
+   *set-sysconfig*, <-v|-h> [options...], Set System Configuration
+   *get-flags*, [-t type] <address>, Get device flags
+   *set-flags*, [-f flags] [-t type] <address>, Set device flags
+   *menu*, <name>, Select submenu
+   *version*, ,Display version
+   *quit*, , Quit program
+   *exit*, , Quit program
+   *help*, , Display help about this program
+   *export*, ,Print environment variables
+
+AUTOMATION
+==========
+Two common ways to automate the tool are to pass the commands directly like in
+the follow example:
+
+::
+
+   btmgmt <<EOF
+   list
+   show
+   EOF
+
+Or create a script and give it as init-script:
+
+::
+
+  vi test-script.bt
+  list
+  show
+  quit
+  :wq
+  btmgmt --init-script=test-script
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
2.41.0

