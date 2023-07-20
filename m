Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42723EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 19:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGTTCn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGTTCj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 15:02:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A32D5E
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 12:02:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6686c74183cso991711b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689879752; x=1690484552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwUeNMKfNG2aVHOiaLSmwzLqv5akrnYuI5vG7Wjwnz0=;
        b=J8KzXa2fLo4dhJMVnJEl7SRNYmzKGBY7UVw1u5iQqTKXcqdl04gSUOeUAQxDqKaxeK
         wjn3B9MCbO/sHV9pCzWGqGECcy++7AwKUuKuM85bcy+MX7H1Ra8ONm12CeeIXVQO6N9Z
         NPcOtKxJI7vUb8fva43Mp30ae/EqtLljydYDEjW9pwr6WvFBwadqZl6ynQaSlWs4ZQhP
         ebQcCS+Lb8clb/WoJDNa91dzq+FL43pGDswSltD5a4gk5wVfLMgxn8dFXN5704GYRrIe
         TKbvSKJvv0+TjJxKP5VYHBWnyrHMrvm5nHBPwBrYU0NGWctzXfNKl4dJeAac/0D/LMqb
         5oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879752; x=1690484552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwUeNMKfNG2aVHOiaLSmwzLqv5akrnYuI5vG7Wjwnz0=;
        b=UD7DbRf7BEZRU8vPg1orW8QfeuO2v+xemGJGsGeYKYsX2xfqFrN35yUqJ32cyjsBah
         lVKibV/O7P3qz/H6Qmb6nSBnTyZEERx/R4qXfgt2qUS+nHSs9hnVsxopFB/KEx4t/1rP
         mTLeZrrSxUc4OetNagc1sp/URHcFjRaqkmscRCxOM2P/wz9wEHBdRouguMMpB0eQYdDG
         8tME7dJyLnBYEAJc9OehMXqhfsT8KyihQEPVs3w8p5HLW2Y6YfL1QQGM+IwnDSTmndNF
         5BSmEi6oj8hI9nBMgZIMdYoc9Gbcz367O39EbWzU2wd47nLK1Ei7eeQfXGfglp9r8y/8
         UGqg==
X-Gm-Message-State: ABy/qLaTQFhZK6l1RPqWUW9sfigJz15bDhQJPle8QD8sGvxpHVE5K2yO
        rM1UCC+8rDR2xq78EspDxTURr62Ss2w=
X-Google-Smtp-Source: APBJJlEuKcbAg0AgazAnNTfmjWGV3iCqJhTLZXr5SaIGrpbV35nt84VHtcWvhfFTf8EuLe51f0qFxg==
X-Received: by 2002:a05:6a20:3aa6:b0:137:db14:e88b with SMTP id d38-20020a056a203aa600b00137db14e88bmr85995pzh.29.1689879751672;
        Thu, 20 Jul 2023 12:02:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78283000000b00682a9325ffcsm1544496pfm.5.2023.07.20.12.02.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:02:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v5 2/3] client: Add bluetoothctl-mgmt.1 man page
Date:   Thu, 20 Jul 2023 12:02:27 -0700
Message-ID: <20230720190228.446570-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720190228.446570-1-luiz.dentz@gmail.com>
References: <20230720190228.446570-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bluetoothctl-mgmt.rst which is then converted to
bluetooth-mgmt.1 using rst2man.
---
 Makefile.tools               |   5 +-
 client/bluetoothctl-mgmt.rst | 559 +++++++++++++++++++++++++++++++++++
 2 files changed, 562 insertions(+), 2 deletions(-)
 create mode 100644 client/bluetoothctl-mgmt.rst

diff --git a/Makefile.tools b/Makefile.tools
index c1de187bf72b..10d29108ce19 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -348,7 +348,7 @@ profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
 if MANPAGES
 man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1 \
-		tools/btmgmt.1
+		tools/btmgmt.1 client/bluetoothctl-mgmt.1
 endif
 
 if MESH
@@ -469,7 +469,8 @@ manual_pages += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
 			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1 \
 			tools/rctest.1 tools/l2ping.1 tools/btattach.1 \
-			tools/bdaddr.1 tools/isotest.1 tools/btmgmt.1
+			tools/bdaddr.1 tools/isotest.1 tools/btmgmt.1 \
+			client/bluetoothctl-mgmt.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
diff --git a/client/bluetoothctl-mgmt.rst b/client/bluetoothctl-mgmt.rst
new file mode 100644
index 000000000000..4baed6480c14
--- /dev/null
+++ b/client/bluetoothctl-mgmt.rst
@@ -0,0 +1,559 @@
+=================
+bluetoothctl-mgmt
+=================
+
+------------------
+Management Submenu
+------------------
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
+**bluetoothctl** [--options] [mgmt.commands]
+
+Mgmt Commands
+=============
+
+select
+------
+
+Select a different index
+
+:Usage: **# select <index>**
+
+revision
+--------
+
+Get the MGMT Revision
+
+:Usage: **# revision**
+
+commands
+--------
+
+List supported commands
+
+:Usage: **# commands**
+
+config
+------
+
+Show configuration info
+
+:Usage: **# config**
+
+info
+----
+
+Show controller info
+
+:Usage: **# info**
+
+extinfo
+-------
+
+Show extended controller info
+
+:Usage: **# extinfo**
+
+auto-power
+----------
+
+Power all available features
+
+:Usage: **# auto-power**
+
+power
+-----
+
+Toggle powered state
+
+:Usage: **# power <on/off>**
+
+discov
+------
+
+Toggle discoverable state
+
+:Usage: **# discov <yes/no/limited> [timeout]**
+
+connectable
+-----------
+
+Toggle connectable state
+
+:Usage: **# connectable <on/off>**
+
+fast-conn
+---------
+
+Toggle fast connectable state
+
+:Usage: **# fast-conn <on/off>**
+
+bondable
+--------
+
+Toggle bondable state
+
+:Usage: **# bondable <on/off>**
+
+pairable
+--------
+
+Toggle bondable state
+
+:Usage: **# pairable <on/off>**
+
+linksec
+-------
+
+Toggle link level security
+
+:Usage: **# linksec <on/off>**
+
+ssp
+---
+
+Toggle SSP mode
+
+:Usage: **# spp <on/off>**
+
+sc
+--
+
+Toggle SC support
+
+:Usage: **# sc <on/off/only>**
+
+hs
+--
+
+Toggle HS support
+
+:Usage: **# hs <on/off>**
+
+le
+--
+
+Toggle LE support
+
+:Usage: **# le <on/off>**
+
+advertising
+-----------
+
+Toggle LE advertising
+
+:Usage: **# advertise <on/off>**
+
+bredr
+-----
+
+Toggle BR/EDR support
+
+:Usage: **# bredr <on/off>**
+
+privacy
+-------
+
+Toggle privacy support
+
+:Usage: **# privacy <on/off> [irk]**
+
+class
+-----
+
+Set device major/minor class
+
+:Usage: **# class <major> <minor>**
+
+disconnect
+----------
+
+Disconnect device
+
+:Usage: **# disconnect [-t type] <remote address>**
+
+con
+---
+
+List connections
+
+:Usage: **# con**
+
+find
+----
+
+Discover nearby devices
+
+:Usage: **# find [-l|-b] [-L]**
+
+find-service
+------------
+
+Discover nearby service
+
+:Usage: **# find-service [-u UUID] [-r RSSI_Threshold] [-l|-b]**
+
+stop-find
+---------
+
+Stop discovery
+
+:Usage: **# stop-find [-l|-b]**
+
+name
+----
+
+Set local name
+
+:Usage: **# name <name> [shortname]**
+
+pair
+----
+
+Pair with a remote device
+
+:Usage: **# pair [-c cap] [-t type] <remote address>**
+
+cancelpair
+----------
+
+Cancel pairing
+
+:Usage: **# cancelpair [-t type] <remote address>**
+
+unpair
+------
+
+Unpair device
+
+:Usage: **# unpair [-t type] <remote address>**
+
+keys
+----
+
+Load Link Keys
+
+:Usage: **keys**
+
+ltks
+----
+
+Load Long Term Keys
+
+:Usage: **# ltks**
+
+irks
+----
+
+Load Identity Resolving Keys
+
+:Usage: **# irks [--local index] [--file file path]**
+
+block
+-----
+
+Block Device
+
+:Usage: **# block [-t type] <remote address>**
+
+unblock
+-------
+
+Unblock Device
+
+:Usage: **# unblock [-t type] <remote address>**
+
+add-uuid
+--------
+
+Add UUID
+
+:Usage: **# add-uuid <UUID> <service class hint>**
+
+rm-uuid
+-------
+
+Remove UUID
+
+:Usage: **# rm-uuid <UUID>**
+
+clr-uuids
+---------
+
+Clear UUIDs
+
+:Usage: **# clear-uuids**
+
+local-oob
+---------
+
+Local OOB data
+
+:Usage: **# local-oob**
+
+remote-oob
+----------
+
+Remote OOB data
+
+:Usage: **# remote-oob [-t <addr_type>] [-r <rand192>] [-h <hash192>]
+	[-R <rand256>] [-H <hash256>] <addr>**
+
+did
+---
+
+Set Device ID
+
+:Usage: **# did <source>:<vendor>:<product>:<version>**
+
+static-addr
+-----------
+
+Set static address
+
+:Usage: **# static-addr <address>**
+
+public-addr
+-----------
+
+Set public address
+
+:Usage: **# public-addr <address>**
+
+ext-config
+----------
+
+External configuration
+
+:Usage: **# ext-config <on/off>**
+
+debug-keys
+----------
+
+Toggle debug keys
+
+:Usage: **# debug-keys <on/off>**
+
+conn-info
+---------
+
+Get connection information
+
+:Usage: **# conn-info [-t type] <remote address>**
+
+io-cap
+------
+
+Set IO Capability
+
+:Usage: **# io-cap <cap>**
+
+scan-params
+-----------
+
+Set Scan Parameters
+
+:Usage: **# scan-params <interval> <window>**
+
+get-clock
+---------
+
+Get Clock Information
+
+:Usage: **# get-clock [address]**
+
+add-device
+----------
+
+Add Device
+
+:Usage: **# add-device [-a action] [-t type] <address>**
+
+del-device
+----------
+
+Remove Device
+
+:Usage: **# del-device [-t type] <address>**
+
+clr-devices
+-----------
+
+Clear Devices
+
+:Usage: **# clr-devices**
+
+bredr-oob
+---------
+
+Local OOB data (BR/EDR)
+
+:Usage: **# bredr-oob**
+
+le-oob
+------
+
+Local OOB data (LE)
+
+:Usage: **# le-oob**
+
+advinfo
+-------
+
+Show advertising features
+
+:Usage: **# advinfo**
+
+advsize
+-------
+
+Show advertising size info
+
+:Usage: **# advsize [options] <instance_id>**
+
+add-adv
+-------
+
+Add advertising instance
+
+:Usage: **# add-adv [options] <instance_id>**
+
+rm-adv
+------
+
+Remove advertising instance
+
+:Usage: **# rm-adv <instance_id>**
+
+clr-adv
+-------
+
+Clear advertising instances
+
+:Usage: **# clr-adv**
+
+add-ext-adv-params
+------------------
+
+Add extended advertising params
+
+:Usage: **# add-ext-adv-parms [options] <instance_id>**
+
+add-ext-adv-data
+----------------
+
+Add extended advertising data
+
+:Usage: **# add-ext-adv-data [options] <instance_id>**
+
+appearance
+----------
+
+Set appearance
+
+:Usage: **# appearance <appearance>**
+
+phy
+---
+
+Get/Set PHY Configuration
+
+:Usage: **# phy [LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] [LECODEDTX] [LECODEDRX]
+	[BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT][EDR2M1SLOT] [EDR2M3SLOT]
+	[EDR2M5SLOT][EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]**
+
+wbs
+---
+
+Toggle Wideband-Speech support
+
+:Usage: **# wbs <on/off>**
+
+secinfo
+-------
+
+Show security information
+
+:Usage: **# secinfo**
+
+expinfo
+-------
+
+Show experimental features
+
+:Usage: **# expinfo**
+
+exp-debug
+---------
+
+Set debug feature
+
+:Usage: **# exp-debug <on/off>**
+
+exp-privacy
+-----------
+
+Set LL privacy feature
+
+:Usage: **# exp-privacy <on/off>**
+
+exp-quality
+-----------
+
+Set bluetooth quality report feature
+
+:Usage: **# exp-quality <on/off>**
+
+exp-offload
+-----------
+
+Toggle codec support
+
+:Usage: **# exp-offload <on/off>**
+
+read-sysconfig
+--------------
+
+Read System Configuration
+
+:Usage: **# read-sysconfig**
+
+set-sysconfig
+-------------
+
+Set System Configuration
+
+:Usage: **# set-sysconfig <-v|-h> [options...]**
+
+get-flags
+---------
+
+Get device flags
+
+
+set-flags
+---------
+
+Set device flags
+
+:Usage: **# set-flags [-f flags] [-t type] <address>**
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

