Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852146D573
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408306; cv=none; b=fujplvXmGP8yHNcU5LA8+UyFJ2z+b3xqDV9luZAPUVbkYKzn82L+vkE0/WI6PQHUvrs0gDzU/8NXvp6lX3nLnWPMWuGAPlQCf2H42cCfb4W2jPfxRvD2EC93yAJPjRdQx0wc2A3JyYcinAcqtL/UfqfLOwkb5hG4NsdCazOzpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408306; c=relaxed/simple;
	bh=gQbCRWn8jk+pKFd6VFXk9UDNeWIC9a6VDiEhXPZb9pE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=esO3daQpmW2oFYWE7pHpRNwOWEm2teV7WN2ooy0dqHsAmpfVnaxCrBiy0NgAiXBfxprOO2bx22DA192xU4fxC4hpYOG4tHygBgoTF30Xp13aE0jMYK85Pj7i6r1XZlAzpCPQa+531a+Ihyu/Fsxe6Jtr+iby0JLD1TiasCNvVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcZ9bcxC; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcZ9bcxC"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9828b5b20eeso2181387241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789408303; x=1790013103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjUIFmzDVKVLEgXOmh142GlgmNaVh+Dc96+5p/iohSo=;
        b=OcZ9bcxCkiGNICDHwusBXyaa8W0jpUvg1Lrr0VRTQvi8DAd84KDNKFF1pvwnvnQQIL
         6qyri4YTJlTQsMlJ6oCK9PcjVjhQofYRUGNY6ADV2w9UP4PZsBm07sfrFiT128Th7Zfa
         KcLninhLJpg91/UvC8L8SYwIFx4781eD8wSXRsERLum6E6oKysbi8I9S8Ou9ogSGRMUS
         xA4/UwGbhgjqJWCE3sRLxMxURE0+wJNbwMN5yZv/OHtWqueiqIOdsfy6twMn8KAuttEC
         pqnjwTWqPgeQ2r8KfrEdFylG5Pr9167bsUIXJFyF4EX5GFRYSVYJv326weD7HuBnZkJq
         qIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789408303; x=1790013103;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GjUIFmzDVKVLEgXOmh142GlgmNaVh+Dc96+5p/iohSo=;
        b=fWhDB1AuWkhPlvyyqOsgQCZtYL9HHPQrYIZK1qwY8QK5zU6B4qr15QOXCeXvbGW/D6
         s7+33fRPIzav1RmNZqlywuEjKGq7R5zrJSVa1WV2bpLWssZuqF3M/TSqfP/SneJMlvfc
         DDuO+gLA8K4Hdw0JadS0x+4gGg0i7BwD2+faEIP5v3O2QBfJJaDFYwfagr3TVy13hq8v
         tpv6b8jUARfnCBDD/SEzo3pAUlGti+UPAKrBBM6U2yIxSS6jjTSQJX80cHTpK0T4roNk
         Ny8QiXCDeHahvRo2dQo4WiTzhCg0srqs+P1YLn6Ixosf5eiF+wtueiXyj6LJk9NxPetY
         BnnA==
X-Gm-Message-State: AFuF++lYGaGLKBq9dHWPD1WZ5uJFRlam/5bsBTMCfPskjg1Ncfu852ju
	fUoqGrqUpMKy5lmvZRjEvppcI6glEy+HE8n1rlN3tX+xmRWz1tqQaxAr5jsUqQOw
X-Gm-Gg: AYBFou1BFkC5GBmdcgvscmimDlyhOMzJfxQrzv6b3yWiQm8nkin7VsMTPXgVyKBfvpi
	lGdbAwSD492Wvq/pPgMkTSbvGR8Bqc70lyYt55KShJuYk5NWBWY11XHn8mNsnHkTG2GVjcHCfUV
	O3MARE4LdOohpQF9fmgHU4Bbtztyhw0MQEcUZy/lVbjSkwc3plC07nG3b0dNxnQ4+oOmWBKzSkA
	RaI4epI7DpWtj0OXJqq4MBl4NZI6I7mzsy245mW4R6xksd4bhaNu/xZAJhZSXSG3oOv8Uqm7sTt
	uPWN4w3PNdlHDYpAZ558UE24FDXvBxv6f4cwH02NgDIGsyaUKoQ6ay+6RXBFOO4bGXW+NHJk9Ex
	jg3M9OV2vEBb4kMXGEQ9mbs2jrkdTaAYMGn/UtL7aX1jZM0epjcHIxBgakGN2ut4RxmgljO3Vwl
	we1pxheHLwNLuLqk4RCCpxN3QJotKMXqW2WH9ntxn+QYzJEgTKWN/y6LSwu7xZxU9e1a7jteqh1
	I657uvUDxsm1o4SI83iLVk/CbhltaKjvruqHYykVSmnbDLOERFh0SWLS5rfypHnqw==
X-Received: by 2002:a05:6102:370b:b0:79c:476a:aae8 with SMTP id ada2fe7eead31-79c476af184mr3750561137.10.1789408303178;
        Mon, 14 Sep 2026 10:51:43 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7927ed7d0absm10957654137.9.2026.09.14.10.51.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 10:51:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] doc: test-runner: document the virtual machine architecture
Date: Mon, 14 Sep 2026 13:51:33 -0400
Message-ID: <20260914175136.613532-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add an ARCHITECTURE section describing how the virtual machine instance
is created and how it communicates with the launcher.

Document that the tool is both the launcher and the guest init, that
there is no disk image and the launcher root filesystem is shared
read-only over 9p, the TEST* variables passed on the kernel command
line, the sandbox mounts and the writable overlays needed on top of the
read-only root.

Also document the console and controller attachment: the guest console
is /dev/hvc0, and '-u' attaches the given socket as a second virtio
console, /dev/hvc1, on which the N_HCI line discipline is set so the
transport is HCI H:4 to the hci_uart driver. Mention '-o' as the way
additional channels are added, as done by test-functional.

While at it, add the missing '-H' and '-o' entries to OPTIONS.

Assisted-by: opencode:claude-opus-5
---
 doc/test-runner.rst | 105 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 12f80df04964..6429e80fc75b 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -25,10 +25,115 @@ OPTIONS
 :-U/--usb=<qemu_args>: Provide USB device
 :-P/--pcie=<qemu_args>: Provide PCIe device
 :-q/--qemu=<path>: QEMU binary
+:-H/--qemu-host-cpu: Use host CPU (requires KVM support)
 :-k/--kernel=<image>: Kernel image (bzImage)
 :-F/--virtiofs[=<path>]: Path to virtiofsd, or no to disable virtio-fs
+:-o/--option=<opt>: Additional argument passed to QEMU
 :-h/--help: Show help options
 
+ARCHITECTURE
+============
+
+**test-runner(1)** is both the launcher and the guest ``init``.  When run
+normally it builds a QEMU command line and starts QEMU, replacing itself
+with it unless it has to stay around to clean up after a ``virtiofsd`` or
+a passed-through PCIe device.  The same binary is re-executed inside the
+guest as PID 1, where it sets up the sandbox and runs the requested
+command::
+
+    ┌────────────────────────────────────────────────────────┐
+    │ test-runner (launcher)                                 │
+    │   ├ virtiofsd (optional)  ←─── vhost-user ───┐         │
+    │   └ qemu                                     │         │
+    │      ┌──── guest ─────────────────────────────┴─────┐  │
+    │      │ kernel (bzImage), init=test-runner           │  │
+    │      │   ├ prepare_sandbox()                        │  │
+    │      │   ├ attach controller (optional)             │  │
+    │      │   ├ start dbus / bluetoothd / btmon / btvirt │  │
+    │      │   ├ fork+exec <command>                      │  │
+    │      │   └ reboot() when it exits                   │  │
+    │      └──────────────────────────────────────────────┘  │
+    └────────────────────────────────────────────────────────┘
+
+There is no disk image.  The launcher's root filesystem is passed through
+read-only and used as the guest root, so the guest runs the very same
+BlueZ build tree that was just compiled.
+
+Two passthrough implementations are supported.  When ``virtiofsd`` is
+available, a ``virtiofsd`` process is started alongside QEMU and exports
+``/`` over a vhost-user socket::
+
+    virtiofsd --socket-path <tmpdir>/virtiofs --shared-dir / --readonly
+              --tag /dev/root ...
+    -chardev socket,id=virtiofs0,path=<tmpdir>/virtiofs
+    -device  vhost-user-fs-pci,queue-size=1024,chardev=virtiofs0,tag=/dev/root
+    -object  memory-backend-memfd,id=mem0,size=<mem>,share=on
+    -numa    node,memdev=mem0
+    -append  "... rootfstype=virtiofs root=/dev/root ..."
+
+Since vhost-user requires the guest memory to be shareable, the machine
+memory is backed by a memfd object.  Otherwise, the fallback is 9p::
+
+    -fsdev local,id=fsdev-root,path=/,readonly=on,security_model=none
+    -device virtio-9p-pci,fsdev=fsdev-root,mount_tag=/dev/root
+    -append "... rootfstype=9p rootflags=trans=virtio,version=9p2000.u ..."
+
+9p passthrough is noticeably more CPU intensive, so virtio-fs is used by
+default whenever possible.
+
+Either way the kernel command line also carries the launcher settings::
+
+    -append "... init=<test-runner> TESTHOME=<cwd> TESTARGS='<command>' ..."
+
+The ``TEST*`` variables carry the options given to the launcher over to
+the guest instance.
+
+As PID 1, ``prepare_sandbox()`` mounts ``sysfs``, ``proc``, ``devtmpfs``,
+``devpts``, ``debugfs`` and ``tmpfs`` on ``/dev/shm``, ``/run`` and
+``/tmp``.  Since the root is read-only, writable ``tmpfs`` instances are
+also overlaid on ``/var/lib/bluetooth``, ``/etc/bluetooth``,
+``/etc/dbus-1`` and ``/usr/share/dbus-1``.
+
+Console and controller
+----------------------
+
+The guest console is a virtio console, ``/dev/hvc0``, multiplexed onto the
+launcher's stdio, so kernel messages and the command output appear on the
+terminal that started test-runner.
+
+With ``-u``, the given UNIX socket (typically a **btproxy(1)** or
+**btvirt(1)** server socket) is attached as a second virtio console::
+
+    -chardev socket,path=<socket>,id=bt0
+    -device  virtconsole,chardev=bt0,name=bt.0
+
+In the guest this is ``/dev/hvc1``.  test-runner sets the ``N_HCI`` line
+discipline with the H:4 protocol on it, so the kernel ``hci_uart`` driver
+registers an ``hciX`` device.  The transport is therefore plain HCI H:4
+carried over a virtio console to a UNIX socket on the launcher side::
+
+    guest                                             launcher
+    ┌───────────────────────────┐                 ┌──────────────────┐
+    │ bluetoothd                │                 │ btvirt/btproxy   │
+    │   ↕ mgmt / HCI sockets    │                 │                  │
+    │ hci_uart  hci0            │   virtconsole   │                  │
+    │   ↕ H:4                   │     bt.0        │                  │
+    │ /dev/hvc1  ───────────────┼─────────────────┤  AF_UNIX socket  │
+    └───────────────────────────┘                 └──────────────────┘
+
+With ``-U`` a host USB controller is passed through instead (a
+``qemu-xhci`` controller plus the given ``usb-host`` device), and with
+``-P`` a PCIe controller is passed through via vfio-pci.  In both cases
+the guest uses the normal ``btusb``/``btintel_pcie`` drivers.
+
+Extra QEMU devices
+------------------
+
+``-o`` appends raw arguments to the QEMU command line.  This is how
+additional channels between the launcher and the guest are added, for
+example by **test-functional(1)**, which attaches its own virtio-serial
+ports and a writable shared directory this way.
+
 Kernel
 ======
 
-- 
2.55.0

