Return-Path: <SRS0=1eqz=OF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D114CC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A6420659
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Nov 2018 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khaF3Qy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A6420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeK0Dn5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:43:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46949 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeK0Dn4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Nov 2018 22:43:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so19658594wrt.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Nov 2018 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u4UQRApNL+/ofhIjOPfwQAV3Krh/P8s/9H0T86zXbcs=;
        b=khaF3Qy2+q36Aws0Aff7/b44Lui39ckMpMUs9nhWqc718ij9fmpEUT/Ilo+94oV26Y
         4H90CSkKBZHFsud0DABAzc3y5MmA1kgQsKo4ut4Kwng6bglIvEhmYOpX8K/GKWmiVr75
         0/jp9RVifC0JNeXbKy9H9hl/xq6YoqLT9vtaApWgevXMhr5PkZVY3dVM4B702o7kPaa+
         pGGvFT6we09yxS7/EP7byN6Jxiy9Tc8QIqPUx7Bd3Gjhg1uh7UA/YBaC85qrm9Rx1KqI
         oBP850Tamt9ULHHH7iVYJ8ssoY7rZ7i5VPohMfaEgsTBn4sHlZX2bspGLe50Ogr5+699
         YKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u4UQRApNL+/ofhIjOPfwQAV3Krh/P8s/9H0T86zXbcs=;
        b=M3CMbW9dgpyZxLPVpkV+8cW3ebgHG/Lxma3CDwSHvJRtJzrU0Ghda9Ww1RjVPB17Fn
         RircpJW0M0/BPde+9OfeF1CBtsr0jI01U0axNz4tlJXycYr9T4cy/eTHwPAktMFcBKTi
         A6wvArfdDQes5IkjIMaJNbsIVl4obQ+d1khKq+us7D+2GDI4ThIGi/NK76MZYeqP2rtw
         OWDXodujX36tZvBPp/KZRFDkcJD0OETLE3StXCSTy1yzWY0U8ettNsDDORnLkOQ3O6r1
         Uasb6wM0bvAO8CFW2OIzwnZnbtm4OE+hwC3GqphPyXFEkoBulNX4zbHqyhlg5VZ1GDON
         XqCA==
X-Gm-Message-State: AA+aEWbONZGYy30jP87RIFbfOFTD07BQJ2+mvLs5WyrVL9cAIg8OY49F
        zCxmR0Ot5KaXm5auvlB4WhC3l+PY
X-Google-Smtp-Source: AFSGD/Xc1VdrQ0Jn3gXIb/gjbhZJeHloMvMGihdDsrP7C8z3qKQUYFb9zBfhVg3svpD1dDwJq+OOiQ==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr26057124wrw.113.1543250955620;
        Mon, 26 Nov 2018 08:49:15 -0800 (PST)
Received: from Buero.fritz.box ([2001:a62:15c7:f600:d580:4377:eac4:b277])
        by smtp.gmail.com with ESMTPSA id q9sm1245736wrp.0.2018.11.26.08.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:49:15 -0800 (PST)
From:   Christian Zimmermann <zimmermach@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Christian Zimmermann <zimmermach@gmail.com>
Subject: [PATCH BlueZ 1/2] Added config conversion for Bluez4 as shell script during install
Date:   Mon, 26 Nov 2018 17:49:06 +0100
Message-Id: <20181126164907.15659-1-zimmermach@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.am                                |  8 +++
 tools/bluez4_conversion/convert_config.sh  | 89 ++++++++++++++++++++++++++++++
 tools/bluez4_conversion/convert_devices.sh |  3 +
 3 files changed, 100 insertions(+)
 create mode 100755 tools/bluez4_conversion/convert_config.sh
 create mode 100644 tools/bluez4_conversion/convert_devices.sh

diff --git a/Makefile.am b/Makefile.am
index 0b26ccc3e..6dc5711d9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -477,6 +477,8 @@ endif
 
 EXTRA_DIST += $(manual_pages:.1=.txt)
 
+EXTRA_DIST += tools/bluez4_conversion/convert_config.sh tools/bluez4_conversion/convert_devices.sh
+
 DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
 						--enable-health \
 						--enable-midi \
@@ -535,3 +537,9 @@ clean-local:
 	-find $(top_builddir) -name "*.gcda" -delete
 	$(RM) -r lib/bluetooth
 endif
+
+BLUEZ4_CONFIG_CONVERSION = $(srcdir)/tools/bluez4_conversion/convert_config.sh
+BLUEZ4_DEVICE_CONVERSION = $(srcdir)/tools/bluez4_conversion/convert_devices.sh
+install-exec-hook:
+	$(BLUEZ4_CONFIG_CONVERSION)
+	$(BLUEZ4_DEVICE_CONVERION)
\ No newline at end of file
diff --git a/tools/bluez4_conversion/convert_config.sh b/tools/bluez4_conversion/convert_config.sh
new file mode 100755
index 000000000..477e18fae
--- /dev/null
+++ b/tools/bluez4_conversion/convert_config.sh
@@ -0,0 +1,89 @@
+!/bin/sh
+
+CONFIG_DIR="/var/lib/bluetooth"
+
+convert_on_mode()
+{
+    config_file=$1
+    #Read on_mode from config file
+    on_mode=$( cat $config_file | grep -Po 'mode \K(.*)')
+    if [ ! -z "$on_mode" ]
+    then
+        if [ $on_mode == "discoverable" ]
+        then
+            #Write on mode to new INI file
+            echo -e "Discoverable=true" >> settings
+        else
+            #Write on mode to new INI file
+            echo -e "Discoverable=false" >> settings
+        fi
+    else
+        echo "On mode not found"
+    fi
+}
+
+convert_discoverable_timeout()
+{
+    config_file=$1
+    #Read discoverable timeout from config file
+    discoverable_timeout=$( cat $config_file | grep -Po 'discovto \K([0-9]+)')
+    if [ ! -z "$discoverable_timeout" ]
+    then
+        #Write discoverable timeout to new INI file
+        echo -e "DiscoverableTimeout=$discoverable_timeout" >> settings
+    else
+        echo "Discoverable Timeout not found"
+    fi
+}
+
+convert_pairable_timeout()
+{
+    config_file=$1
+    #Read pairable timeout from config file
+    pairable_timeout=$( cat $config_file | grep -Po 'pairto \K([0-9]+)')
+    if [ ! -z "$pairable_timeout" ]
+    then
+        #Write discoverable timeout to new INI file
+        echo -e "PairableTimeout=$pairable_timeout" >> settings
+    else
+        echo "Pairable Timeout not found"
+    fi
+}
+
+convert_local_name()
+{
+    config_file=$1
+    #Read local name from config file
+    local_name=$( cat $config_file | grep -Po 'name \K(.*)')
+    if [ ! -z "$local_name" ]
+    then
+        #Write local_name to new INI file
+        echo -e "Alias=$local_name" >> settings
+    else
+        echo "Local name not found"
+    fi
+}
+
+###
+# Main script body
+###
+for entry in `ls $CONFIG_DIR`; do
+    cd $CONFIG_DIR
+    cd $entry
+    if [ -f "config" ]
+    then
+        if [ ! -f "settings" ]
+        then
+            #Create new settings INI file
+            touch settings
+            echo -e "[General]" >> settings
+            convert_pairable_timeout config
+            convert_discoverable_timeout config
+            convert_on_mode config
+            convert_local_name config
+            rm config
+        else
+            echo "Settings already available"
+        fi
+    fi
+done
diff --git a/tools/bluez4_conversion/convert_devices.sh b/tools/bluez4_conversion/convert_devices.sh
new file mode 100644
index 000000000..a8a013b06
--- /dev/null
+++ b/tools/bluez4_conversion/convert_devices.sh
@@ -0,0 +1,3 @@
+# TODO
+# This file is intended for replacing the conversion of Bluez4 device datas when upgrading to Bluez5 INI format
+# This is currently checked at every bluetoothd startup in src/adapter.c
\ No newline at end of file
-- 
2.11.0

