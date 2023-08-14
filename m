Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8DBC001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Aug 2023 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjHNTQK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Aug 2023 15:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjHNTPl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Aug 2023 15:15:41 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0BB5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 12:15:39 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-790c24db283so131944339f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692040538; x=1692645338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a10Sprl2YU4bTmsGwrgwVtbD9vMAlgYwq+Z/gfdwUy0=;
        b=i0413K0z6kHdNOz36EGSgAYI1p0tLKog+QwuMDREPuwgzmgM0oh+J0edfjvLqByk4E
         I+gQOVtRaWOLMtRrJXUJqZ9n/Pr8pUPra9UKmYj5Cgsyck1+vV3fSpaVv9EGMqPN96b0
         MjkkyA2PeK058myb059iWkRJNs9Am07HD21QuyocK15ntpqJGfgTmN8q5fcrN7yzMG+v
         Ow03sNNjL6zdpzYSXB6fnmDDSODLXEOx9jzuQ5dyIf+QoXfQjp3nzQFO6nu7k0ldygDm
         LwDCPV9NPEC+vMdzvUDZjWfgdoI6oqyJq9ZTvinG3xccAEW/BnATUPaYmqrUdthcjOt/
         X98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692040538; x=1692645338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a10Sprl2YU4bTmsGwrgwVtbD9vMAlgYwq+Z/gfdwUy0=;
        b=UzWgCKn6c7icctJS8nrsNZkNbh6hFp1+ZsxtO7paNjkJL1N72yYI7ygHQv9aI9xy2x
         32eaRzl4ookGCuZ74ORewOw/mVEDDILxnQvPIBV5+VDJgcsYbvRihAXT1P/eDW7yUF/x
         QDwRlV5Ur4BOyHNsL2vU2DvSSzILNfjo9WLJ6U1NZTXrL5NcLP4zXVrnrgty+oS3pD0Q
         lPq7jPtubdk4dIUuaR7yhOTiI5iTN93Emo9f52F6pJfsLYSbhX6OtPNxTv22C61FpUmS
         ylk/kyp0rMrMnAFt778Q8joHKL9Tu1zPR23FbqXjapx1UnEoPtfSvHF+zq7MMU3LOqCk
         cd/g==
X-Gm-Message-State: AOJu0Yxnlvu0uJbqPYNiQLARadNAC1BWLIyNIQlKc/OvrMlFd1EMyn7b
        wgb5sR9HCWM1JcAhGcvTNqcw+jBHfOQ=
X-Google-Smtp-Source: AGHT+IFutcCcnljV61B4MC9JxJhxICv2gd7FieavI2Zcs5O75gItAc/y/PQNdAeveqZAo6UfsLZoJQ==
X-Received: by 2002:a05:6e02:1b81:b0:349:4776:7e01 with SMTP id h1-20020a056e021b8100b0034947767e01mr16098635ili.19.1692040537838;
        Mon, 14 Aug 2023 12:15:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id p10-20020a056638190a00b0042b46224650sm3117570jal.91.2023.08.14.12.15.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 12:15:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/test-runner: Update documentation using rst format
Date:   Mon, 14 Aug 2023 12:15:35 -0700
Message-ID: <20230814191535.2304664-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates test-runner documentation with a few examples using rst
format.
---
 doc/test-runner.rst   | 175 ++++++++++++++++++++++++++++++++++++
 doc/test-runner.txt   |  85 ------------------
 tools/test-runner.rst | 200 ------------------------------------------
 3 files changed, 175 insertions(+), 285 deletions(-)
 create mode 100644 doc/test-runner.rst
 delete mode 100644 doc/test-runner.txt
 delete mode 100644 tools/test-runner.rst

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
new file mode 100644
index 000000000000..1566487fe4d0
--- /dev/null
+++ b/doc/test-runner.rst
@@ -0,0 +1,175 @@
+===========
+test-runner
+===========
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
+:-a:--auto: Find tests and run them
+:-b/--dbus: Start D-Bus system daemon
+:-s/--dbus-session: Start D-Bus session daemon
+:-d/--daemon: Start bluetoothd
+:-m/--monitor: Start btmon
+:-l/--emulator: Start btvirt
+:-A/-audio[=path]: Start audio server
+:-u/--unix[=path]: Provide serial device
+:-q/--qemu=<path>: QEMU binary
+:-k/--kernel=<image>: Kernel image (bzImage)
+:-h/--help: Show help options
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
diff --git a/doc/test-runner.txt b/doc/test-runner.txt
deleted file mode 100644
index 43ce42be6b53..000000000000
--- a/doc/test-runner.txt
+++ /dev/null
@@ -1,85 +0,0 @@
-Notes for test-runner usage
-***************************
-
-
-Kernel configuration
-====================
-
-The test-runner tool requires a kernel that is at least build with these
-minimal options for a successful boot.
-
-	CONFIG_VIRTIO=y
-	CONFIG_VIRTIO_PCI=y
-
-	CONFIG_NET=y
-	CONFIG_INET=y
-
-	CONFIG_NET_9P=y
-	CONFIG_NET_9P_VIRTIO=y
-
-	CONFIG_9P_FS=y
-	CONFIG_9P_FS_POSIX_ACL=y
-
-	CONFIG_SERIAL_8250=y
-	CONFIG_SERIAL_8250_CONSOLE=y
-	CONFIG_SERIAL_8250_PCI=y
-	CONFIG_SERIAL_8250_NR_UARTS=4
-
-	CONFIG_TMPFS=y
-	CONFIG_TMPFS_POSIX_ACL=y
-	CONFIG_TMPFS_XATTR=y
-
-	CONFIG_DEVTMPFS=y
-	CONFIG_DEBUG_FS=y
-
-For Bluetooth functionality:
-
-	CONFIG_BT=y
-	CONFIG_BT_BREDR=y
-	CONFIG_BT_RFCOMM=y
-	CONFIG_BT_BNEP=y
-	CONFIG_BT_HIDP=y
-	CONFIG_BT_LE=y
-
-	CONFIG_BT_HCIUART=y
-	CONFIG_BT_HCIUART_H4=y
-	CONFIG_BT_HCIVHCI=y
-
-	CONFIG_CRYPTO_CMAC=y
-	CONFIG_CRYPTO_USER_API=y
-	CONFIG_CRYPTO_USER_API_HASH=y
-	CONFIG_CRYPTO_USER_API_SKCIPHER=y
-
-	CONFIG_UNIX=y
-
-	CONFIG_UHID=y
-
-For Audio functionality:
-	CONFIG_SYSVIPC=y
-	CONFIG_SOUND=y
-	CONFIG_SND=y
-	CONFIG_SND_INTEL8X0=y
-
-These options should be installed as .config in the kernel source directory
-followed by this command.
-
-	make olddefconfig
-
-After that a default kernel with the required options can be built. More
-option (like the Bluetooth subsystem) can be enabled on top of this.
-
-Lock debuging
--------------
-
-To catch locking related issues the following set of kernel config
-options may be useful:
-
-	CONFIG_DEBUG_KERNEL=y
-	CONFIG_LOCKDEP_SUPPORT=y
-	CONFIG_DEBUG_SPINLOCK=y
-	CONFIG_DEBUG_LOCK_ALLOC=y
-	CONFIG_DEBUG_ATOMIC_SLEEP=y
-	CONFIG_PROVE_LOCKING=y
-	CONFIG_PROVE_RCU=y
-	CONFIG_LOCKDEP=y
-	CONFIG_DEBUG_MUTEXES=y
diff --git a/tools/test-runner.rst b/tools/test-runner.rst
deleted file mode 100644
index ac3986ab14c0..000000000000
--- a/tools/test-runner.rst
+++ /dev/null
@@ -1,200 +0,0 @@
-===========
-test-runner
-===========
-
-------------------
-Kernel test runner
-------------------
-
-:Authors: - Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
-:Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
-            Lesser General Public Licenses (LGPL).
-:Date: Jul 6, 2023
-:Manual section: 1
-:Manual group: Linux System Administration
-
-SYNOPSIS
-========
-
-**test-runner** [*OPTIONS*] -- <test-name>
-
-DESCRIPTION
-===========
-
-**test-runner(1)** is used to test Kernel changes to the Bluetooth subsystem,
-it lunches a virtual machine using the local filesystem.
-
-OPTIONS
-=======
-
--a, --auto             Find tests and run them
-
--b, --dbus             Start D-Bus system daemon
-
--s, --dbus-session     Start D-Bus session daemon
-
--d, --daemon           Start bluetoothd
-
--m, --monitor          Start btmon
-
--l, --emulator         Start btvirt
-
--A, --audio[=path]      Start audio server
-
--u, --unix [path]      Provide serial device
-
--q, --qemu <path>      QEMU binary
-
--k, --kernel <image>   Kernel image (bzImage)
-
--h, --help             Show help options
-
-Kernel
-======
-
-The test-runner tool requires a kernel that is at least build with these
-minimal options for a successful boot. These options should be installed as
-.config in the kernel source directory followed by:
-
-.. code-block::
-
-	make olddefconfig
-
-After that a default kernel with the required options can be built. More
-option (like the Bluetooth subsystem) can be enabled on top of this.
-
-.. code-block::
-
-	CONFIG_VIRTIO=y
-	CONFIG_VIRTIO_PCI=y
-
-	CONFIG_NET=y
-	CONFIG_INET=y
-
-	CONFIG_NET_9P=y
-	CONFIG_NET_9P_VIRTIO=y
-
-	CONFIG_9P_FS=y
-	CONFIG_9P_FS_POSIX_ACL=y
-
-	CONFIG_SERIAL_8250=y
-	CONFIG_SERIAL_8250_CONSOLE=y
-	CONFIG_SERIAL_8250_PCI=y
-	CONFIG_SERIAL_8250_NR_UARTS=4
-
-	CONFIG_TMPFS=y
-	CONFIG_TMPFS_POSIX_ACL=y
-	CONFIG_TMPFS_XATTR=y
-
-	CONFIG_DEVTMPFS=y
-	CONFIG_DEBUG_FS=y
-
-Bluetooth
----------
-
-.. code-block::
-
-	CONFIG_BT=y
-	CONFIG_BT_BREDR=y
-	CONFIG_BT_RFCOMM=y
-	CONFIG_BT_BNEP=y
-	CONFIG_BT_HIDP=y
-	CONFIG_BT_LE=y
-
-	CONFIG_BT_HCIUART=y
-	CONFIG_BT_HCIUART_H4=y
-	CONFIG_BT_HCIVHCI=y
-
-	CONFIG_CRYPTO_CMAC=y
-	CONFIG_CRYPTO_USER_API=y
-	CONFIG_CRYPTO_USER_API_HASH=y
-	CONFIG_CRYPTO_USER_API_SKCIPHER=y
-
-	CONFIG_UNIX=y
-
-	CONFIG_UHID=y
-
-Lock debuging
--------------
-
-To catch locking related issues the following set of kernel config
-options may be useful:
-
-.. code-block::
-
-	CONFIG_DEBUG_KERNEL=y
-	CONFIG_LOCKDEP_SUPPORT=y
-	CONFIG_DEBUG_SPINLOCK=y
-	CONFIG_DEBUG_LOCK_ALLOC=y
-	CONFIG_DEBUG_ATOMIC_SLEEP=y
-	CONFIG_PROVE_LOCKING=y
-	CONFIG_PROVE_RCU=y
-	CONFIG_LOCKDEP=y
-	CONFIG_DEBUG_MUTEXES=y
-
-EXAMPLES
-========
-
-Running mgmt-tester
--------------------
-
-.. code-block::
-
-	$ tools/test-runner -k /pathto/bzImage -- tools/mgmt-tester
-
-Running a specific test of mgmt-tester
---------------------------------------
-
-.. code-block::
-
-	$ tools/test-runner -k /pathto/bzImage -- tools/mgmt-tester -s "<name>"
-
-Running bluetoothctl with emulated controller
----------------------------------------------
-
-.. code-block::
-
-	$ tools/test-runner -l -d -k /pathto/bzImage -- client/bluetoothctl
-	[CHG] Controller 00:AA:01:00:00:00 Pairable: yes
-	[bluetooth]#
-
-Running bluetoothctl with emulated controller and audio support
----------------------------------------------------------------
-
-.. code-block::
-
-	$ tools/test-runner -l -d -A -k /pathto/bzImage -- client/bluetoothctl
-	[CHG] Controller 00:AA:01:00:00:00 Pairable: yes
-	[bluetooth]#
-	[CHG] Controller 00:AA:01:00:00:00 Pairable: yes
-	[CHG] Controller 00:AA:01:00:00:00 Class: 0x00600000 (6291456)
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 Class: 0x006c0000 (7077888)
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
-	[CHG] Controller 00:AA:01:00:00:00 UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
-
-Running shell with host controller using btproxy
-------------------------------------------------
-
-.. code-block::
-
-	$ tools/btproxy -u [1]
-	$ tools/test-runner -u -d -k /pathto/bzImage -- /bin/bash [2]
-- 
2.41.0

