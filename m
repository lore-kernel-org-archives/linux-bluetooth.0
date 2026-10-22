Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684055;
	b=K1A/c9kzvp54QhcGqkJyiTPmjPYeHb3RSkaGlqakhifuDETDGD8SMsFwMV9rgrDFfKP9
	 KS02Tu79avrRb6M5aBOBOVDzZ5BiWKLP8qwCzAwjh1ftla+x1cU8UwFnBl+qzK9z4WWiy
	 bN+RsQF9ZEaI57bcOy/w6tgQvPCuMaTDg/fR9zzkqqoONI9abBtSgG0E398sk0/fK/Poc
	 9KSdyWhP6X3HnAGVSDDcyhZagUXYt8iBNWehrXCjQXNxrNHFYoD2cOC28CanQSXkVqIgd
	 ocdZHzlXqLJOIp0f2X6bfGvVABKzN/hiWSpFyVzR5bDongaNhi/nOebhc7AlflIUPHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=otGUg3ExtB+lzwr2MaVWRztnn+ImdJR3v448pXdZBIE=;
	b=z5K2SkFMaHV7VpOEd77QXBjPgYJvAcGPgtHP6kBVAeRhihPDqzNbcU797GVJVJuplygG
	 05zgFh6JX9OK1hYPiKdAVuRIxFbvLqAThG8aocEONqh9zOY/EqVKx/E9K94F0Y6J1StrP
	 wKsOxggAAs+Y2d6TcmA6wCL4RHXnhCkL/pmoBlOTOFQ0+LTrMh0pA3ZBTdOeD3h+d/Rq4
	 VyoOpA3HonQ7WyfZTNrvAEowAsqiBC5eSFJVNbeAxfMQjc3FnFjBO2LC6GCp2idINgEIM
	 iV63ZbzJZvmYZ5G/+ZVfgElkgPGgi3RfQFLGNmAVI+eCA3bmuUCUuRH5hZyq07wOA4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NXJTpysb;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC04606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDC04606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NXJTpysb
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eadef147ffso3066e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684054; x=1793288854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=otGUg3ExtB+lzwr2MaVWRztnn+ImdJR3v448pXdZBIE=;
        b=NXJTpysbl83/GCjtgzwfsvysqwhjxmEzLCLmnFtj8XhyR2U9DtpirFI/YnsRO1xgtj
         zELY/WLh6Df/6v8+xknvRaMmpswFTir3NfkQOKZQjyLGuX3rtA4TM0dYJ25D2DNiSVui
         XIs6O+BFQS3XMBlP1ZHfQw3sx9VqEPMok1ZaxR+FDiv4Z7+onVtAARIg35Tj4xRPTZZO
         os0e2Nx0N76VsPpjmTWwpLwXP+jqf9MyeJvn2r23paP6tgo2QC24dKPobbPy8Ov+j9G2
         AkKnruAGK68t02abainIeTZkaRPj35trBsApYrM6PPhPoQe8qawdDxaJIA4i2vlNRqRp
         3niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684054; x=1793288854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=otGUg3ExtB+lzwr2MaVWRztnn+ImdJR3v448pXdZBIE=;
        b=quk0z8SQM642VD0DEmwAS4zGT4gxXj3B3IbPVdM3WLKylU1yoO0G28VmkAHfDfJbrb
         o4IX9meToXYTcL9Rs77B3NCEmJf5wwPqiYt0+bYbjd5/4avE9x3MXk65vJGSXMBTU4Zg
         so3BUcqGPaU4AvIWN8VUn7heuvbyx+6GH70tNuS6fOx2x9tvMitlzqJ/GqmThdkuTX0A
         uWMbdOiCwglpHH5WWri9mxO1NfUUgC3Pr50O/KSgWTKu3tUMoGlxPbR7FmbPuGdBvR4O
         6KgVwa1VNzo2mj+rEjs8mViGQhLKANBREtMI7zo/9Krw5p+HnJKUeBMKksVSCs3uvH+u
         XmLQ==
X-Gm-Message-State: AFq9FYLqef2POAhsC2g+qamFvr/44UoN6XZJMH8KGCb9mx7dgLu35YOz
	WI5yvypmy7z3tRGPpyCqlJMl/5r4ItaEEcYjT1jnNP3cX1D7eN8XipC9H7IxO/tXnWo=
X-Gm-Gg: AYBFou1DyD3kHPrGp3OMgIz8wR8JtBUJU2WLlNAX5iDHvceu6eCGKcbo1uqp0YhaaNJ
	LRn62rlOpng7m8+X8r7nhx8X2Tj/dP5MDRbaodwLQAuii33euS5HCfvQEkJlaknwSiysyRplpVi
	4fJyG6mNZCRP1YRu03LR7PZDY5Lkj+tqFwOI4H0U7FC1ORD7YwibU1kyk0ivkZ/XJIZiLw8HlzT
	6hnbEngF1BScgFHgcTQGo/LxBloaQN5k738WL9TRbKSI/6ElXgXhuYy3OT3pQkROc8DqXwiOrun
	Zsx48XKRRXaocn5tpzjPITCXstplaDnbiApQXqrRYWMGvHTMuJK5U0Ay0R/lNCrSOIboKlE5vdM
	HfxGTHXp/Z20LutjVADUOj+ysVNxZdFjbsRZ/fO9LkfC+uJZf7D0c4sqt8MAqH2AI2RZQTHgZbI
	6LR49kvJOJANYjRMoXDiXiTV28n4Ex0OZJ6BwS9FTpq+e2PuX6qNIkdRmLXVYDtLA+vnJCrUKc3
	E/XZOdMkamb9FsIdQtXX0cq/yF4NOiMCg1SZ1/AscCy+SHlJxLjFXxz5YW/R9b8mvObibZve7bb
	cTRJkFGzZYnPcpd85FEoCPPaF82k/JD+cPyNBMu7iV6XEA==
X-Received: by 2002:a05:6122:488f:b0:5e9:731b:850a with SMTP id 71dfb90a1353d-5eaebe17275mr2986465e0c.11.1792684053609;
        Thu, 22 Oct 2026 08:47:33 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 27/27] doc: Split tester.config for QEMU and User Mode Linux
Date: Thu, 22 Oct 2026 11:47:00 -0400
Message-ID: <20261022154701.3959500-28-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Rename tester.config to tester.kvm.config, keeping tester.config as a
link to it for existing users, and add tester.uml.config for a User Mode
Linux kernel, which uses hostfs and virtio_uml instead of the QEMU
devices and needs time travel support for test-runner -T.

Both build every Bluetooth protocol and device driver, with the buses
and subsystems they depend on and COMPILE_TEST, so a tester kernel also
verifies that they all build, and a single User Mode Linux kernel can
verify the drivers and run the testers. CONFIG_BT_HS, which no longer
exists, is removed. CONFIG_BT_INTEL_PCIE depends on ACPI, which User Mode
Linux does not have, unless built with COMPILE_TEST in kernels allowing
it.

Document each configuration in test-runner.

Assisted-by: Claude:claude-opus-5-5
---
 doc/test-functional.rst |   4 +-
 doc/test-runner.rst     | 118 +++++++++++++++++++++++++++-----
 doc/tester.config       | 119 +--------------------------------
 doc/tester.kvm.config   | 144 ++++++++++++++++++++++++++++++++++++++++
 doc/tester.uml.config   | 120 +++++++++++++++++++++++++++++++++
 5 files changed, 370 insertions(+), 135 deletions(-)
 mode change 100644 => 120000 doc/tester.config
 create mode 100644 doc/tester.kvm.config
 create mode 100644 doc/tester.uml.config

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index e2fcf34138b3..917653bfef5a 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -90,7 +90,7 @@ The following additional options apply:
 
 ``--kernel=<image>``
         Kernel image (or built Linux source tree root) to
-	use.  See **test-runner(1)** and `tester.config` for required
+	use.  See **test-runner(1)** and `tester.kvm.config` for required
 	kernel config.
 
 	If not provided, value from `FUNCTIONAL_TESTING_KERNEL`
@@ -300,7 +300,7 @@ Simplest setup is
 
 .. code-block::
 
-	cp ../bluez/doc/tester.config .config
+	cp ../bluez/doc/tester.kvm.config .config
 	make olddefconfig
 	make -j8
 
diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 02d69b06f54c..e59a2dd141aa 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -143,8 +143,8 @@ User Mode Linux
 When ``-k`` is a User Mode Linux (UML) binary, recognized by its
 ``.uml.setup.init`` section, test-runner runs it directly instead of QEMU,
 with the host filesystem mounted as root through hostfs, and powers it off
-at the end since rebooting UML starts it again. The kernel needs
-``CONFIG_HOSTFS``, and ``CONFIG_VIRTIO_UML`` for virtio devices.
+at the end since rebooting UML starts it again. See `User Mode Linux kernel`_
+for its configuration.
 
 ``-o`` then adds kernel parameters, which is how UML attaches devices served
 from the host, e.g. ``virtio_uml.device=<socket>:40`` for a virtio
@@ -162,16 +162,50 @@ the guest sees the same timings on every run. This needs a kernel with
 Kernel
 ======
 
-The test-runner tool requires a kernel that is at least build with these
-minimal options for a successful boot. These options should be installed as
-.config in the kernel source directory followed by:
+Two configuration fragments with everything the testers need are provided:
+``doc/tester.kvm.config`` for a kernel run with QEMU and KVM, and
+``doc/tester.uml.config`` for a User Mode Linux kernel. ``doc/tester.config``
+is the same as ``doc/tester.kvm.config``. The options they contain are
+described below.
+
+Both also build every Bluetooth protocol and device driver into the kernel,
+with the buses and subsystems they depend on, so a tester kernel verifies
+that they all build, even those the testers do not use, and those for other
+platforms with ``CONFIG_COMPILE_TEST``:
 
 .. code-block::
 
-	make olddefconfig
+	CONFIG_COMPILE_TEST=y
+	CONFIG_USB_SUPPORT=y
+	CONFIG_USB=y
+	CONFIG_MMC=y
+	CONFIG_SERIAL_DEV_BUS=y
+	CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
+	CONFIG_GPIOLIB=y
+	CONFIG_PM=y
+	CONFIG_NVMEM=y
+	CONFIG_POWER_SEQUENCING=y
+	CONFIG_HID=y
+	CONFIG_NEW_LEDS=y
+	CONFIG_LEDS_CLASS=y
 
-After that a default kernel with the required options can be built. More
-option (like the Bluetooth subsystem) can be enabled on top of this.
+QEMU and KVM kernel
+-------------------
+
+With QEMU, the kernel is a bzImage, and test-runner reaches the guest
+through virtio devices: the console, the shared host filesystem
+(virtio-fs or 9p) and the emulated serial ports of ``-u``. Build it with
+``doc/tester.kvm.config`` installed as .config in the kernel source
+directory:
+
+.. code-block::
+
+	cp <bluez>/doc/tester.kvm.config .config
+	make olddefconfig
+	make
+
+The minimal options for a successful boot are the following, on top of
+which more options, like the Bluetooth subsystem, can be enabled:
 
 .. code-block::
 
@@ -192,7 +226,7 @@ option (like the Bluetooth subsystem) can be enabled on top of this.
 
 	CONFIG_SERIAL_8250=y
 	CONFIG_SERIAL_8250_CONSOLE=y
-	CONFIG_SERIAL_8250_PCI=yCONFIG_DEBUG_KERNEL=y
+	CONFIG_SERIAL_8250_PCI=y
 	CONFIG_SERIAL_8250_NR_UARTS=4
 
 	CONFIG_TMPFS=y
@@ -205,6 +239,60 @@ option (like the Bluetooth subsystem) can be enabled on top of this.
 Filesystem passthrough uses virtio-fs when ``virtiofsd`` is installed on the
 host, otherwise 9p. Use ``-Fno`` for kernels without ``CONFIG_VIRTIO_FS``.
 
+The controllers that can be passed through to the guest, see the USB and
+PCIe passthrough examples, also need the host controller drivers of
+``doc/tester.kvm.config``, and ``CONFIG_PCI`` and ``CONFIG_ACPI`` for the
+PCIe ones.
+
+User Mode Linux kernel
+----------------------
+
+A User Mode Linux kernel is a program run on the host, built with
+``ARCH=um``, and has no PCI, USB or serial devices: the host filesystem is
+mounted with hostfs, controllers are emulated inside the guest through
+``/dev/vhci`` or served from the host as virtio devices with
+``virtio_uml``, and **-T** needs time travel support. Build it from the
+default configuration with ``doc/tester.uml.config`` merged in:
+
+.. code-block::
+
+	make ARCH=um defconfig
+	scripts/kconfig/merge_config.sh -m .config <bluez>/doc/tester.uml.config
+	make ARCH=um olddefconfig
+	make ARCH=um linux
+
+The resulting ``linux`` binary is given to test-runner with ``-k``. The
+options specific to User Mode Linux are the following, with the Bluetooth
+and debugging ones below in addition:
+
+.. code-block::
+
+	CONFIG_HOSTFS=y
+	CONFIG_VIRTIO_UML=y
+	CONFIG_UML_PCI_OVER_VIRTIO=y
+	CONFIG_UML_TIME_TRAVEL_SUPPORT=y
+
+	CONFIG_NET=y
+	CONFIG_INET=y
+	CONFIG_IPV6=y
+
+	CONFIG_TMPFS=y
+	CONFIG_DEVTMPFS=y
+	CONFIG_DEBUG_FS=y
+
+	CONFIG_BT_HCIVHCI=y
+	CONFIG_BT_VIRTIO=y
+
+The User Mode Linux default configuration does not enable IPv6, which
+6lowpan-tester needs. ``CONFIG_UML_PCI_OVER_VIRTIO`` provides the PCI bus
+for the PCI drivers to build. User Mode Linux has no ACPI, so
+``CONFIG_BT_INTEL_PCIE`` is only built with ``CONFIG_COMPILE_TEST``, in
+kernels where it does not depend on ACPI otherwise.
+
+As it builds every driver and runs the testers, a single User Mode Linux
+kernel can verify both; a QEMU kernel is only needed for what QEMU
+provides, such as passing controllers through to the guest.
+
 Bluetooth
 ---------
 
@@ -268,7 +356,8 @@ options may be useful:
 Other
 -----
 
-For tests requiring accurate time inside the VM, possible with KVM:
+For tests requiring accurate time inside the VM, possible with KVM, part of
+``doc/tester.kvm.config``:
 
 .. code-block::
 
@@ -414,15 +503,14 @@ interrupt delivery.
 Running mgmt-tester under User Mode Linux
 -----------------------------------------
 
+With a kernel built from ``doc/tester.uml.config``, see
+`User Mode Linux kernel`_:
+
 .. code-block::
 
-	$ make ARCH=um defconfig
-	$ scripts/kconfig/merge_config.sh -m .config <bluez>/doc/tester.config
-	$ make ARCH=um olddefconfig linux
 	$ tools/test-runner -k <linux>/linux -- tools/mgmt-tester
 
-On simulated time, with a kernel that also has
-``CONFIG_UML_TIME_TRAVEL_SUPPORT=y``:
+On simulated time:
 
 .. code-block::
 
diff --git a/doc/tester.config b/doc/tester.config
deleted file mode 100644
index 58b7c592335c..000000000000
--- a/doc/tester.config
+++ /dev/null
@@ -1,118 +0,0 @@
-CONFIG_PCI=y
-CONFIG_VIRTIO=y
-CONFIG_VIRTIO_PCI=y
-CONFIG_VIRTIO_CONSOLE=y
-CONFIG_VIRTIO_FS=y
-CONFIG_FUSE_FS=y
-
-CONFIG_HYPERVISOR_GUEST=y
-CONFIG_PARAVIRT=y
-CONFIG_KVM_GUEST=y
-
-CONFIG_PTP_1588_CLOCK=y
-CONFIG_PTP_1588_CLOCK_KVM=y
-CONFIG_PTP_1588_CLOCK_VMCLOCK=y
-
-CONFIG_NET=y
-CONFIG_INET=y
-CONFIG_IPV6=y
-
-CONFIG_NET_9P=y
-CONFIG_NET_9P_VIRTIO=y
-
-CONFIG_9P_FS=y
-CONFIG_9P_FS_POSIX_ACL=y
-
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_PCI=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_TMPFS_XATTR=y
-
-CONFIG_DEVTMPFS=y
-CONFIG_DEBUG_FS=y
-
-CONFIG_BT=y
-CONFIG_BT_BREDR=y
-CONFIG_BT_RFCOMM=y
-CONFIG_BT_BNEP=y
-CONFIG_BT_HIDP=y
-CONFIG_BT_LE=y
-CONFIG_BT_HS=y
-CONFIG_BT_MSFTEXT=y
-CONFIG_BT_AOSPEXT=y
-CONFIG_BT_FEATURE_DEBUG=y
-
-CONFIG_CRYPTO_AES=y
-CONFIG_CRYPTO_CMAC=y
-CONFIG_CRYPTO_USER_API=y
-CONFIG_CRYPTO_USER_API_HASH=y
-CONFIG_CRYPTO_USER_API_SKCIPHER=y
-
-CONFIG_UNIX=y
-
-CONFIG_UHID=y
-CONFIG_HIDRAW=y
-
-CONFIG_DEBUG_KERNEL=y
-CONFIG_LOCKDEP_SUPPORT=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_PROVE_LOCKING=y
-CONFIG_PROVE_RCU=y
-CONFIG_LOCKDEP=y
-CONFIG_DEBUG_MUTEXES=y
-CONFIG_KASAN=y
-
-CONFIG_USB=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_PLATFORM=y
-
-CONFIG_SERIAL_DEV_BUS=y
-
-CONFIG_6LOWPAN=y
-CONFIG_6LOWPAN_DEBUGFS=y
-CONFIG_BT_6LOWPAN=y
-CONFIG_PACKET=y
-
-#
-# Bluetooth device drivers
-#
-CONFIG_BT_INTEL=y
-CONFIG_BT_BCM=y
-CONFIG_BT_RTL=y
-CONFIG_BT_QCA=y
-CONFIG_BT_MTK=y
-CONFIG_BT_HCIBTUSB=y
-CONFIG_BT_HCIBTUSB_POLL_SYNC=y
-CONFIG_BT_HCIBTUSB_BCM=y
-CONFIG_BT_HCIBTUSB_MTK=y
-CONFIG_BT_HCIBTUSB_RTL=y
-CONFIG_BT_HCIUART=y
-CONFIG_BT_HCIUART_SERDEV=y
-CONFIG_BT_HCIUART_H4=y
-CONFIG_BT_HCIUART_BCSP=y
-CONFIG_BT_HCIUART_ATH3K=y
-CONFIG_BT_HCIUART_LL=y
-CONFIG_BT_HCIUART_3WIRE=y
-CONFIG_BT_HCIUART_QCA=y
-CONFIG_BT_HCIUART_AG6XX=y
-CONFIG_BT_HCIUART_MRVL=y
-CONFIG_BT_HCIUART_AML=y
-CONFIG_BT_HCIBCM203X=y
-CONFIG_BT_HCIBCM4377=y
-CONFIG_BT_HCIBPA10X=y
-CONFIG_BT_HCIBFUSB=y
-CONFIG_BT_HCIVHCI=y
-CONFIG_BT_MRVL=y
-CONFIG_BT_ATH3K=y
-CONFIG_BT_MTKSDIO=y
-CONFIG_BT_MTKUART=y
-CONFIG_BT_VIRTIO=y
-CONFIG_BT_NXPUART=y
-CONFIG_BT_INTEL_PCIE=y
-# end of Bluetooth device drivers
diff --git a/doc/tester.config b/doc/tester.config
new file mode 120000
index 000000000000..9f68726afd0a
--- /dev/null
+++ b/doc/tester.config
@@ -0,0 +1 @@
+tester.kvm.config
\ No newline at end of file
diff --git a/doc/tester.kvm.config b/doc/tester.kvm.config
new file mode 100644
index 000000000000..d8066f78aade
--- /dev/null
+++ b/doc/tester.kvm.config
@@ -0,0 +1,144 @@
+CONFIG_PCI=y
+CONFIG_ACPI=y
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_FS=y
+CONFIG_FUSE_FS=y
+
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_KVM_GUEST=y
+
+CONFIG_PTP_1588_CLOCK=y
+CONFIG_PTP_1588_CLOCK_KVM=y
+CONFIG_PTP_1588_CLOCK_VMCLOCK=y
+
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_IPV6=y
+
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+
+CONFIG_9P_FS=y
+CONFIG_9P_FS_POSIX_ACL=y
+
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_XATTR=y
+
+CONFIG_DEVTMPFS=y
+CONFIG_DEBUG_FS=y
+
+CONFIG_BT=y
+CONFIG_BT_BREDR=y
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=y
+CONFIG_BT_LE=y
+CONFIG_BT_LE_L2CAP_ECRED=y
+CONFIG_BT_LEDS=y
+CONFIG_BT_MSFTEXT=y
+CONFIG_BT_AOSPEXT=y
+CONFIG_BT_DEBUGFS=y
+CONFIG_BT_SELFTEST=y
+CONFIG_BT_SELFTEST_ECDH=y
+CONFIG_BT_SELFTEST_SMP=y
+CONFIG_BT_FEATURE_DEBUG=y
+
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_CMAC=y
+CONFIG_CRYPTO_USER_API=y
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
+
+CONFIG_UNIX=y
+
+CONFIG_HID=y
+CONFIG_UHID=y
+CONFIG_HIDRAW=y
+
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+CONFIG_DEBUG_KERNEL=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_PROVE_RCU=y
+CONFIG_LOCKDEP=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_KASAN=y
+
+CONFIG_6LOWPAN=y
+CONFIG_6LOWPAN_DEBUGFS=y
+CONFIG_BT_6LOWPAN=y
+CONFIG_PACKET=y
+
+#
+# Buses and subsystems the Bluetooth device drivers depend on
+#
+CONFIG_COMPILE_TEST=y
+CONFIG_USB_SUPPORT=y
+CONFIG_USB=y
+CONFIG_MMC=y
+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
+CONFIG_GPIOLIB=y
+CONFIG_PM=y
+CONFIG_NVMEM=y
+CONFIG_POWER_SEQUENCING=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PLATFORM=y
+
+#
+# Bluetooth device drivers
+#
+CONFIG_BT_HCIBTUSB=y
+CONFIG_BT_HCIBTUSB_POLL_SYNC=y
+CONFIG_BT_HCIBTUSB_BCM=y
+CONFIG_BT_HCIBTUSB_MTK=y
+CONFIG_BT_HCIBTUSB_RTL=y
+CONFIG_BT_HCIBTUSB_QCOM=y
+CONFIG_BT_HCIBTSDIO=y
+CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_SERDEV=y
+CONFIG_BT_HCIUART_H4=y
+CONFIG_BT_HCIUART_NOKIA=y
+CONFIG_BT_HCIUART_BCSP=y
+CONFIG_BT_HCIUART_ATH3K=y
+CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_HCIUART_3WIRE=y
+CONFIG_BT_HCIUART_INTEL=y
+CONFIG_BT_HCIUART_BCM=y
+CONFIG_BT_HCIUART_RTL=y
+CONFIG_BT_HCIUART_QCA=y
+CONFIG_BT_HCIUART_AG6XX=y
+CONFIG_BT_HCIUART_MRVL=y
+CONFIG_BT_HCIUART_AML=y
+CONFIG_BT_HCIBCM203X=y
+CONFIG_BT_HCIBCM4377=y
+CONFIG_BT_HCIBPA10X=y
+CONFIG_BT_HCIBFUSB=y
+CONFIG_BT_HCIVHCI=y
+CONFIG_BT_MRVL=y
+CONFIG_BT_MRVL_SDIO=y
+CONFIG_BT_ATH3K=y
+CONFIG_BT_MTKSDIO=y
+CONFIG_BT_MTKUART=y
+CONFIG_BT_VIRTIO=y
+CONFIG_BT_NXPUART=y
+CONFIG_BT_INTEL_PCIE=y
+CONFIG_BT_QCOMSMD=y
+# end of Bluetooth device drivers
diff --git a/doc/tester.uml.config b/doc/tester.uml.config
new file mode 100644
index 000000000000..f7ff4eb64b45
--- /dev/null
+++ b/doc/tester.uml.config
@@ -0,0 +1,120 @@
+CONFIG_HOSTFS=y
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
+CONFIG_UML_TIME_TRAVEL_SUPPORT=y
+
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_IPV6=y
+
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_XATTR=y
+
+CONFIG_DEVTMPFS=y
+CONFIG_DEBUG_FS=y
+
+CONFIG_BT=y
+CONFIG_BT_BREDR=y
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=y
+CONFIG_BT_LE=y
+CONFIG_BT_LE_L2CAP_ECRED=y
+CONFIG_BT_LEDS=y
+CONFIG_BT_MSFTEXT=y
+CONFIG_BT_AOSPEXT=y
+CONFIG_BT_DEBUGFS=y
+CONFIG_BT_SELFTEST=y
+CONFIG_BT_SELFTEST_ECDH=y
+CONFIG_BT_SELFTEST_SMP=y
+CONFIG_BT_FEATURE_DEBUG=y
+
+CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_CMAC=y
+CONFIG_CRYPTO_USER_API=y
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
+
+CONFIG_UNIX=y
+
+CONFIG_HID=y
+CONFIG_UHID=y
+CONFIG_HIDRAW=y
+
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+CONFIG_DEBUG_KERNEL=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_PROVE_RCU=y
+CONFIG_LOCKDEP=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_KASAN=y
+
+CONFIG_6LOWPAN=y
+CONFIG_6LOWPAN_DEBUGFS=y
+CONFIG_BT_6LOWPAN=y
+CONFIG_PACKET=y
+
+#
+# Buses and subsystems the Bluetooth device drivers depend on
+#
+CONFIG_COMPILE_TEST=y
+CONFIG_USB_SUPPORT=y
+CONFIG_USB=y
+CONFIG_MMC=y
+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
+CONFIG_GPIOLIB=y
+CONFIG_PM=y
+CONFIG_NVMEM=y
+CONFIG_POWER_SEQUENCING=y
+
+#
+# Bluetooth device drivers
+#
+CONFIG_BT_HCIBTUSB=y
+CONFIG_BT_HCIBTUSB_POLL_SYNC=y
+CONFIG_BT_HCIBTUSB_BCM=y
+CONFIG_BT_HCIBTUSB_MTK=y
+CONFIG_BT_HCIBTUSB_RTL=y
+CONFIG_BT_HCIBTUSB_QCOM=y
+CONFIG_BT_HCIBTSDIO=y
+CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_SERDEV=y
+CONFIG_BT_HCIUART_H4=y
+CONFIG_BT_HCIUART_NOKIA=y
+CONFIG_BT_HCIUART_BCSP=y
+CONFIG_BT_HCIUART_ATH3K=y
+CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_HCIUART_3WIRE=y
+CONFIG_BT_HCIUART_INTEL=y
+CONFIG_BT_HCIUART_BCM=y
+CONFIG_BT_HCIUART_RTL=y
+CONFIG_BT_HCIUART_QCA=y
+CONFIG_BT_HCIUART_AG6XX=y
+CONFIG_BT_HCIUART_MRVL=y
+CONFIG_BT_HCIUART_AML=y
+CONFIG_BT_HCIBCM203X=y
+CONFIG_BT_HCIBCM4377=y
+CONFIG_BT_HCIBPA10X=y
+CONFIG_BT_HCIBFUSB=y
+CONFIG_BT_HCIVHCI=y
+CONFIG_BT_MRVL=y
+CONFIG_BT_MRVL_SDIO=y
+CONFIG_BT_ATH3K=y
+CONFIG_BT_MTKSDIO=y
+CONFIG_BT_MTKUART=y
+CONFIG_BT_VIRTIO=y
+CONFIG_BT_NXPUART=y
+CONFIG_BT_QCOMSMD=y
+CONFIG_BT_INTEL_PCIE=y
+# end of Bluetooth device drivers
-- 
2.56.0

