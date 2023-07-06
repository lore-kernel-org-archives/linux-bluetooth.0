Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41539EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 23:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGFXKI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 19:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjGFXKG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 19:10:06 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBFB1BE9
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 16:10:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso956357a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 16:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688685002; x=1691277002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Sm5kG9VuTFpN8Yfdobll4GiKX2EnRVg7Dp382oYlg=;
        b=cyEAMPmn6GFoOrDTlSib8+98KcPo+3ebobdy9g1kuxCAqydoezD97LcTw6TxXo87xB
         yfxAQUDAEAs+QSWOhRghQkW0XkPc05gz5dxDjd4LQGTUgCLHlU3HGmyZRj/3MNi53Ywh
         CQqRVdGtImQtRdJVYMs8MOW/KniJEGWmowFcNfw9/dJH8z3cv8a0IM7Zo4TuBclv2smY
         XsvdXGbuQpv82RnhCcT9UMXTtyt2uLpiFNNcJkSYXOXr3xpsOVmgNKbz+DMLv7EZOmwd
         nPdWum0H+YVtuTwgmOA5roqLQu4nUsLFALFSN9GHfx2wvK4XFPhRfxqXr6dSNkur0Ehq
         hgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688685002; x=1691277002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Sm5kG9VuTFpN8Yfdobll4GiKX2EnRVg7Dp382oYlg=;
        b=PC1z5GzhzUomtv76+pX1yvhSWc58v+RnQPhikU496EzCMWJM2lRk/qIHRAeHc2ie1v
         JIpdZImDSjlfOz1ZfuOoEnKhPv1xExodp28fYjQ65mRWvYfXvHC5pvuCRPohbYxWRHnR
         9iY4cyR8h6QR8vQyAbq/yF6szFstfox0gne9qUAG/7UXLHq87eR/4MCFchenzB6lb6Vr
         oNNbfsvw/H4T/y7nbt84adYOgyy2IUS9GRZcmYq65TQp5K70DtRiUX3xNlo6n75NMq26
         DSBygAuNEXjVtqhrE4yoVyQ//1qfsX7j33AMgWzGQEVK3zljsxlYJtK5QCe8Zqel7LxG
         AOpw==
X-Gm-Message-State: ABy/qLZUGFbU8B0X9ABzf74JIgs6yiscs24P5oBgDXstoDdVRjQGXsK7
        jiuWJBxTWLqi5Xp3yYKIF3ALQeFUw84=
X-Google-Smtp-Source: APBJJlEE6C2DsRQxYogI4UZjKWPakJcIKYN8GQIuwdJ1x823w4bQWzo2BrEMdwoboMo/wI0H22PkwQ==
X-Received: by 2002:a05:6a20:3d87:b0:12b:e7de:6382 with SMTP id s7-20020a056a203d8700b0012be7de6382mr3694493pzi.34.1688685001930;
        Thu, 06 Jul 2023 16:10:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b895336435sm1919189plb.21.2023.07.06.16.10.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 16:10:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test-runner: Add documentation
Date:   Thu,  6 Jul 2023 16:10:00 -0700
Message-Id: <20230706231000.451145-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds test-runner.rst documentation with a few examples of how it
can be used to run kernel testers like mgmt-tester and also bluetoothd,
audio and Bluetooth controller plugged in the host system which is quite
useful when trying experimental features such LE Audio, etc.
---
 tools/test-runner.rst | 200 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)
 create mode 100644 tools/test-runner.rst

diff --git a/tools/test-runner.rst b/tools/test-runner.rst
new file mode 100644
index 000000000000..ac3986ab14c0
--- /dev/null
+++ b/tools/test-runner.rst
@@ -0,0 +1,200 @@
+===========
+test-runner
+===========
+
+------------------
+Kernel test runner
+------------------
+
+:Authors: - Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: Jul 6, 2023
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**test-runner** [*OPTIONS*] -- <test-name>
+
+DESCRIPTION
+===========
+
+**test-runner(1)** is used to test Kernel changes to the Bluetooth subsystem,
+it lunches a virtual machine using the local filesystem.
+
+OPTIONS
+=======
+
+-a, --auto             Find tests and run them
+
+-b, --dbus             Start D-Bus system daemon
+
+-s, --dbus-session     Start D-Bus session daemon
+
+-d, --daemon           Start bluetoothd
+
+-m, --monitor          Start btmon
+
+-l, --emulator         Start btvirt
+
+-A, --audio[=path]      Start audio server
+
+-u, --unix [path]      Provide serial device
+
+-q, --qemu <path>      QEMU binary
+
+-k, --kernel <image>   Kernel image (bzImage)
+
+-h, --help             Show help options
+
+Kernel
+======
+
+The test-runner tool requires a kernel that is at least build with these
+minimal options for a successful boot. These options should be installed as
+.config in the kernel source directory followed by:
+
+.. code-block::
+
+	make olddefconfig
+
+After that a default kernel with the required options can be built. More
+option (like the Bluetooth subsystem) can be enabled on top of this.
+
+.. code-block::
+
+	CONFIG_VIRTIO=y
+	CONFIG_VIRTIO_PCI=y
+
+	CONFIG_NET=y
+	CONFIG_INET=y
+
+	CONFIG_NET_9P=y
+	CONFIG_NET_9P_VIRTIO=y
+
+	CONFIG_9P_FS=y
+	CONFIG_9P_FS_POSIX_ACL=y
+
+	CONFIG_SERIAL_8250=y
+	CONFIG_SERIAL_8250_CONSOLE=y
+	CONFIG_SERIAL_8250_PCI=y
+	CONFIG_SERIAL_8250_NR_UARTS=4
+
+	CONFIG_TMPFS=y
+	CONFIG_TMPFS_POSIX_ACL=y
+	CONFIG_TMPFS_XATTR=y
+
+	CONFIG_DEVTMPFS=y
+	CONFIG_DEBUG_FS=y
+
+Bluetooth
+---------
+
+.. code-block::
+
+	CONFIG_BT=y
+	CONFIG_BT_BREDR=y
+	CONFIG_BT_RFCOMM=y
+	CONFIG_BT_BNEP=y
+	CONFIG_BT_HIDP=y
+	CONFIG_BT_LE=y
+
+	CONFIG_BT_HCIUART=y
+	CONFIG_BT_HCIUART_H4=y
+	CONFIG_BT_HCIVHCI=y
+
+	CONFIG_CRYPTO_CMAC=y
+	CONFIG_CRYPTO_USER_API=y
+	CONFIG_CRYPTO_USER_API_HASH=y
+	CONFIG_CRYPTO_USER_API_SKCIPHER=y
+
+	CONFIG_UNIX=y
+
+	CONFIG_UHID=y
+
+Lock debuging
+-------------
+
+To catch locking related issues the following set of kernel config
+options may be useful:
+
+.. code-block::
+
+	CONFIG_DEBUG_KERNEL=y
+	CONFIG_LOCKDEP_SUPPORT=y
+	CONFIG_DEBUG_SPINLOCK=y
+	CONFIG_DEBUG_LOCK_ALLOC=y
+	CONFIG_DEBUG_ATOMIC_SLEEP=y
+	CONFIG_PROVE_LOCKING=y
+	CONFIG_PROVE_RCU=y
+	CONFIG_LOCKDEP=y
+	CONFIG_DEBUG_MUTEXES=y
+
+EXAMPLES
+========
+
+Running mgmt-tester
+-------------------
+
+.. code-block::
+
+	$ tools/test-runner -k /pathto/bzImage -- tools/mgmt-tester
+
+Running a specific test of mgmt-tester
+--------------------------------------
+
+.. code-block::
+
+	$ tools/test-runner -k /pathto/bzImage -- tools/mgmt-tester -s "<name>"
+
+Running bluetoothctl with emulated controller
+---------------------------------------------
+
+.. code-block::
+
+	$ tools/test-runner -l -d -k /pathto/bzImage -- client/bluetoothctl
+	[CHG] Controller 00:AA:01:00:00:00 Pairable: yes
+	[bluetooth]#
+
+Running bluetoothctl with emulated controller and audio support
+---------------------------------------------------------------
+
+.. code-block::
+
+	$ tools/test-runner -l -d -A -k /pathto/bzImage -- client/bluetoothctl
+	[CHG] Controller 00:AA:01:00:00:00 Pairable: yes
+	[bluetooth]#
+	[CHG] Controller 00:AA:01:00:00:00 Pairable: yes
+	[CHG] Controller 00:AA:01:00:00:00 Class: 0x00600000 (6291456)
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 Class: 0x006c0000 (7077888)
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
+	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
+
+Running shell with host controller using btproxy
+------------------------------------------------
+
+.. code-block::
+
+	$ tools/btproxy -u [1]
+	$ tools/test-runner -u -d -k /pathto/bzImage -- /bin/bash [2]
-- 
2.40.1

