Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ED3EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jul 2023 01:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjGSBUT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jul 2023 21:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSBUS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jul 2023 21:20:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB812F
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jul 2023 18:20:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6689430d803so4315706b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jul 2023 18:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689729615; x=1692321615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VL36ZdRbee3dnqsoK7hBy9LzW1uY+GIUS7q9EPsodAQ=;
        b=mIf/5m0o65iXEqXK39NDDFwCVg/3Xdqr3W1DFycFTwWX5OFwwCWQo301icyjOxJlPq
         h/Xx4vT/Gcjlo29jQ6Zyo6/80eDrT9BBa0FgjXnm7q3dC55MEufT169zwTIdsg677Vzf
         S1cbafeVL1yuo0Waipn3XWsiKUyNqCnlrH1f5MrsYRV5Bnwl2FeJJgIY6N5ZCoXFOI5G
         cTU++PB3Y6zD95KNme++LL+utD5OlkhgaqGEpojF4B9c26XtTOifPoQ0Z5Ac500/ymE5
         AWERkH8+6JtHYMYYizP0dJfpVeowdsIPs6TwpOzmkqW3Q/PecjcqQfPqD/7cM3gxWYh/
         0ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689729615; x=1692321615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VL36ZdRbee3dnqsoK7hBy9LzW1uY+GIUS7q9EPsodAQ=;
        b=iy5LaY1dtPUR1Kn8PrFhxytPEKMk9F/wPP+1OLf2FN9+ev/4a5kYGqTj3MIPX5mzdz
         0K+S1U6G/R4TO/VPmtEQjc3VIMaL7Vzf1IQf/KEQkqfY/PYC1E4Y2avk5fu9KMjJejtZ
         PKUODG0YAbTgkD0UrgmsMYrKjpV//wLeIgn+1NY52D8gfolzz4wzc7QWq7xc26E75dGp
         zIaMGYHvQqBlq+c+LH2kPZFawqHU+B6Jwr0h90rMa/Ot8t/i3nqxepDRaFDzWZCH8pLY
         trLmXa/rTz5j4D7SWC92UEdFnxIzXgq8EMDdSG3FJQSFP9ozUMr7uObZIqlbFhagOAbE
         68jQ==
X-Gm-Message-State: ABy/qLbYAx5hTA9/zM2Pu5/WR2xXqVZcV2y2aTb3x27qbYdgpgC/s8Eq
        mShqE1n+NyRMiBANHT8JYC6OdcsTTmE=
X-Google-Smtp-Source: APBJJlEzEu6TnOL7QKvfHDfuFRGFL1KmcpUS9RN7yNZIkV+UlSot+zMrloo0uaLcw08uOO4IB03nbA==
X-Received: by 2002:a05:6a00:b93:b0:66a:5466:25c6 with SMTP id g19-20020a056a000b9300b0066a546625c6mr19986508pfj.18.1689729614234;
        Tue, 18 Jul 2023 18:20:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id u21-20020aa78395000000b0065434edd521sm2056834pfm.196.2023.07.18.18.20.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 18:20:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3] btmgmt: Add man page
Date:   Tue, 18 Jul 2023 18:20:12 -0700
Message-ID: <20230719012012.232725-1-luiz.dentz@gmail.com>
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
 tools/btmgmt.rst | 166 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+), 2 deletions(-)
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
index 000000000000..36cccb889f33
--- /dev/null
+++ b/tools/btmgmt.rst
@@ -0,0 +1,166 @@
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
+it is not recommended for applications to use it directly as it may result in
+unexpected behavior.
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
+
+Two common ways to automate the tool are to pass the commands directly like in
+the follow example:
+
+.. code-block::
+
+    btmgmt <<EOF
+    list
+    show
+    EOF
+
+Or create a script and pass it as init-script:
+
+.. code-block::
+
+    $ vi test-script.bt
+    list
+    show
+    quit
+    :wq
+    $ btmgmt --init-script=test-script
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

