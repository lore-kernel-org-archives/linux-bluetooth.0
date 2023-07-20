Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F892C001DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 00:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGTA3W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jul 2023 20:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGTA3V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jul 2023 20:29:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B726519A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 17:29:19 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-763a2e39b88so25899385a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 17:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689812958; x=1692404958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEEQPaHbXzlMLDjOLcsMEWg7RxMf3QZJqNQO0A/xiaE=;
        b=TVcJommCz5CeU5jaSzJQt6OBrLvUek2RRPEVakKF0Ote38zjgRYJYHmiX+HF2ZJ0EO
         /l21dCTcYqn8bDZ9TupJVF+u10TYjHK0JlK4hD/v1H/5oZ6OyOW5XLLj8Tfpj+PBprrB
         9UUaZuHmt6xop097Mvyk+2gXo++QFROfFX4uPSSP5EUbeNItuZa9C/kls/gs0aOP1kfT
         y1rRkNg7MKZ3B2z8eciCQ26NpiY5sS5FxOxbb6Ad1R9SgL0ZByv3uItK4oNqGW4dFEYm
         WOpnUkF8i/CqNftVGZPsc1q3v5LzaGcOPPYIEBQSJ7yjwRD9U1vfIVH1E5Y7M9BkKu1o
         NgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689812958; x=1692404958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEEQPaHbXzlMLDjOLcsMEWg7RxMf3QZJqNQO0A/xiaE=;
        b=QnscbarqA2VrRDgP48JNdqEyGjVXmGrunByEHA7FbWK1YEwsDtufREc+QMgECOpwI5
         4dnWlNJa49hmeHjLT3klAMgeOe2TRttWGTsWn8En9VnXqD2MOQIjMUWB0R7XwehdlLjJ
         v0zMayWt1QziTGY5H30Q+tB3SiTl1CJC5QfX5SOJbv7xvvyCR79CaVaXnP7CpwzlvFYR
         Qm3eLi3iXo4epXaElmnAha6drlW9DjoIvV/X3hvqEby89y3MNVZvOlwvY72mTnQy2uqO
         q2l81cjAUS3xH8GCRof2anZc9xgrlUDbUQbCFmVR4q0zkX/hs3cTkwv6Z4zP3/wPpdsT
         Mntg==
X-Gm-Message-State: ABy/qLYt/QsIK17FlDZFFKBkYUPmarDX+0fXHIkbuLIPd88/fgDIfsV3
        noMLWOc74WaDGsVYkY7flPzBxcQVYJY=
X-Google-Smtp-Source: APBJJlE31iGVH3W9qD7avLxbbT84aA2hWYwEg0U3l3R2k8ErCHjHDRq6UZqSFlgVZKDVgfGJ+yn3VA==
X-Received: by 2002:a05:620a:371c:b0:763:c8be:819b with SMTP id de28-20020a05620a371c00b00763c8be819bmr5581910qkb.22.1689812958025;
        Wed, 19 Jul 2023 17:29:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b007623c96430csm1619472qkm.111.2023.07.19.17.29.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 17:29:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 2/3] client: Add bluetoothctl-mgmt.1 man page
Date:   Wed, 19 Jul 2023 17:29:12 -0700
Message-ID: <20230720002913.342733-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720002913.342733-1-luiz.dentz@gmail.com>
References: <20230720002913.342733-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bluetoothctl-mgmt.rst which is then converted to
bluetooth-mgmt.1 using rst2man.
---
 Makefile.tools               |   2 +-
 client/bluetoothctl-mgmt.rst | 559 +++++++++++++++++++++++++++++++++++
 2 files changed, 560 insertions(+), 1 deletion(-)
 create mode 100644 client/bluetoothctl-mgmt.rst

diff --git a/Makefile.tools b/Makefile.tools
index c1de187bf72b..6c5835bbd65d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -348,7 +348,7 @@ profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
 if MANPAGES
 man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1 \
-		tools/btmgmt.1
+		tools/btmgmt.1 client/bluetoothctl-mgmt.1
 endif
 
 if MESH
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

