Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684046;
	b=rRI6QMFl2WSVPo5ERwNshN9FRxXdCYgRr7wnF9FEiF/R9rDcXq+AFYOit/RSfj+NQYeF
	 jCbl+z70OI9pnL0PeFLJqyS00I3Ndzmr1bSib7dR+T6RE0XH17MgaYOSsAD+mfgptLH7x
	 xH9/dBrbH+PWvcJeIVra7YfqfKuVpe4gYsZp0YehFNivBrj1gKYSdcwWoimMUaZ8+eaNr
	 8KVZEnLk0Uf8k1N/kHRULDSeuLXACer2OelstoNv2qhYv/MwoirEWOUE5oCg4FXQJ1qN7
	 SKhul5tJxYfjfEO8I3mE6PJgiHdwo406+RFHlddpLGoyRWVDFo/nGKpRZ3LEWGg2NGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OUXgyQJMAG11xkh65n6Ph1VuvkQAqhlt9VcmN9b/4MY=;
	b=Ddld6ZCXL1hPnHwiNEwvuHD7LNEq2BCAbtRP7axk8jOIYNAAfxabfLROI8j90vTQAqwW
	 u4hrvrZ5YiKE2QBfGQo3GLROUSf/3t+TXBbBWXHfaJMcMypdWGIzipMZzherAyeysRCvq
	 J77EhBDNc7j2jxONvWhsHz2GVPlew8tEzOdBgpFd+XfVdwOoGJl/KoqXPvxGXabbaNnpw
	 og7bJ/tStgFiee+VhR1emIB1YRu496RA0SL+djO0X1eROJEMbZwgKVWm0i5dLSdpFJp5u
	 xjp52A0AWRXIf+DwohXaHR9YfOEUhYMdeGIi7SgkG9Cjlgp0zDrBacSil3EtW3btr0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IfRBx5k8;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3D606A31F
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EC3D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IfRBx5k8
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so10998e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684045; x=1793288845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUXgyQJMAG11xkh65n6Ph1VuvkQAqhlt9VcmN9b/4MY=;
        b=IfRBx5k8wHq7zfXZHMoLPPp2wf/8hM+s4mNMv/inhr2c5nZ52JxwG6ApRM+i8S59iu
         6FEFj9mx78WXLA0PIL5A2a4fXaO3cW58XjNDQut6xhXfjmJBYjKDttn73G/4MYQaJ++X
         7JHVY7xO8Kj9bk9YZiAYQYuL1fyShIi7EQjF8YPV/gJAXXGCVqthGVj2KywLxXLXccIn
         U0OzdYN33a9d8L4QkEonAiux8kMmJJpTu4m7CtEb/9vEdIshpQk1uNgyPHmDwNjP86Hp
         Fzgv/RpL47og5G87a1C5uzIwU9zYpRcWmnSxmM+AAcA+N+PsN9ElQbBHR1qiyxxMbWmn
         zArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684045; x=1793288845;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUXgyQJMAG11xkh65n6Ph1VuvkQAqhlt9VcmN9b/4MY=;
        b=hx5JlQVKVZrRl9mNkITU921YD34SO8kc7sZnJ5JPHp+JcjYLJ0L8+jeD5sh1l8o04p
         5a7pPCCuI5XQITwHAQ9f9pCU1gvZto3tas7O+hQ4ONHi2uprgGdtuOrUnQJ9QpY6jk81
         ISgc7xaNS/vdE1/5H4rG8kel6Fhl/pQ1/Sv713M/YKBxPuQEWHY0+Lltdatqyy5DbaSX
         xpu5JNT933m0yt7imIUCTQw2HUiwkylFselvNYuJNoEKQf9n79VXt5teMfPjnj8EUeIU
         v+lMCeuvO3cubjbDPdrsSQFyNVlDdqnGLPc8Iwkwf1qxHRQ7plxRKQelQ2Sb5K2xpz6Q
         w3LA==
X-Gm-Message-State: AFq9FYL1OffDnmGyx+WxQ3d4cgH2g5o7AfUYt4j/+MJu7yJvKr9Dpldz
	7YTqQPtVB6GFihgaH8ZnHf+Vsn2b0PjWJ9E+XnpjvRa9WBC42ZIunt0itYoaHmgxKcQ=
X-Gm-Gg: AYBFou2uzp10Vdp1xHYJppqvmGOct5JueUO9QIARzkZfv4qz5C5w5E29BADV6U3akVp
	zfNcOg8Cx/haV+75TSXcK3Qus0Xu+WGb8gXH4nijPSyYbKfj9TrGhCmB7Nwwka+aEBAqPD4PpJs
	gYKoE756aaDWp+kYEIwDvkvoNssxbXWiDQiIrTJ5wcG9VGVNZCgf3xeR41ZyWcJ4d2sVzQsIzS0
	gzACeLMiT8m187gJUKnPnuCtjQVDX1o9BJ1jgonfwsuVzU53+AD++KRkyrHuAvNZnTXe1A9Qn1r
	WJxL+46aaAAbL3jAkLHkzXIxFgj4Trk62tXW2XBgms+aPJcCA3g6U4UoJTXYAqBQFcUNpq/YjDS
	bJ8yMk5DZ+MbiPnf2prDN+mf+8rH8wMGQwuFsqU4VSwNxP1eYcues2oVimVT5OorhEzgFRt2YFE
	Of2QzCVqJ4ZeUnnz4FdM9Rrq3+1z2v7Wbh5gVncZ4cVIjgxaDLji7F4MJPFA7fWHDNPu982kpJa
	Nar61rvdErC/w+jxxGTKhGyHiqEvjluGC4LQLcdHv/CLuII/iDlfJEVZBi9mdPwrTsGGnd2HmlY
	ZzXDlbLGjJlrrk1yPZQBWKQLUb5ELAgKhKGEjLcA55BTuwR7L6juZ3Cyo6UYlKsOhME=
X-Received: by 2002:a05:6122:616e:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5eaebd9857amr2628258e0c.4.1792684044609;
        Thu, 22 Oct 2026 08:47:24 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 16/27] doc: Add virtio documentation
Date: Thu, 22 Oct 2026 11:46:49 -0400
Message-ID: <20261022154701.3959500-17-luiz.dentz@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document the virtio Bluetooth device as implemented by the Linux driver
and what a vhost-user backend has to provide to serve controllers to
virtual machines, including User Mode Linux guests with time travel.

Explain how time travel works, with diagrams of the two clocks, the
calendar protocol, lock-step scheduling, FREE_UNTIL and how a virtio
notification ends it, and why busy-waiting is costly under it, and
compare KVM and User Mode Linux with the wall clock time of the kernel
testers with and without test-runner -T.

Assisted-by: Claude:claude-opus-5-5
---
 Makefile.am    |   1 +
 doc/virtio.rst | 406 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 407 insertions(+)
 create mode 100644 doc/virtio.rst

diff --git a/Makefile.am b/Makefile.am
index 26884a54ea06..453cc7c584e4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -495,6 +495,7 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/test-coverage.txt \
 				doc/test-runner.rst \
 				doc/btvirt.rst \
+				doc/virtio.rst \
 				doc/test-functional.rst \
 				doc/functional-testing.rst \
 				doc/functional-a2dp.rst \
diff --git a/doc/virtio.rst b/doc/virtio.rst
new file mode 100644
index 000000000000..e1148a50c797
--- /dev/null
+++ b/doc/virtio.rst
@@ -0,0 +1,406 @@
+======
+virtio
+======
+
+------------------------------------------------------------
+Virtio Bluetooth device and vhost-user controller backends
+------------------------------------------------------------
+
+Introduction
+============
+
+The virtio Bluetooth device (device ID 40) carries HCI packets between
+a guest kernel and a Bluetooth controller provided by the host. The Linux
+driver is ``drivers/bluetooth/virtio_bt.c``; it registers the device as an
+``hciN`` with bus type ``HCI_VIRTIO``, without any attach step such as
+**btattach(1)**.
+
+The controller behind the device can be anything that speaks HCI: an
+emulator, a firmware simulation or a proxy to real hardware. When the
+controller runs as a separate host process, the device is provided through
+the vhost-user protocol: the guest's virtio transport talks to the process
+over a Unix socket.
+
+This document describes the device as implemented by Linux and what a
+vhost-user backend has to provide, as **btvirt(1)** does with **-V**; see
+`btvirt support`_.
+
+Why virtio and vhost-user
+=========================
+
+The two are separate layers:
+
+- **virtio** is the device: how HCI packets are framed in virtqueues and
+  which configuration the guest reads.
+- **vhost-user** is the transport between the guest and the process that
+  implements the device.
+
+QEMU guests can get a controller without either of them, through an emulated
+serial port and **btattach(1)**; this is what **test-runner(1)** **-u** does.
+User Mode Linux (UML) has no serial device that can connect to a Unix socket;
+its only way to attach an externally implemented device is ``virtio_uml``,
+which speaks vhost-user. On UML, vhost-user virtio is therefore the
+natural way to provide controllers.
+
+It is also required for deterministic simulation. With UML time travel
+(``time-travel=ext``), the guest's clock is driven by an external time
+controller, and all inputs to the guest have to be scheduled through it.
+Data arriving on a plain file descriptor, such as a serial line, is not; a
+vhost-user backend can coordinate every message with the time controller
+(see `Time travel`_).
+
+Device
+======
+
+Feature bits
+------------
+
+The device must offer ``VIRTIO_F_VERSION_1``; the Linux driver refuses
+devices without it. The device specific feature bits are
+(``include/uapi/linux/virtio_bt.h``):
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+
+   * - Bit
+     - Name
+     - Meaning
+
+   * - 0
+     - ``VIRTIO_BT_F_VND_HCI``
+     - The ``vendor`` configuration field is valid; the driver applies the
+       vendor specific setup (see `Configuration`_).
+
+   * - 1
+     - ``VIRTIO_BT_F_MSFT_EXT``
+     - The controller supports the Microsoft vendor extension, using the
+       opcode in ``msft_opcode``.
+
+   * - 2
+     - ``VIRTIO_BT_F_AOSP_EXT``
+     - The controller supports the Android (AOSP) vendor extension.
+
+   * - 3
+     - ``VIRTIO_BT_F_CONFIG_V2``
+     - The configuration uses the ``virtio_bt_config_v2`` layout.
+
+Configuration
+-------------
+
+Version 1 layout, packed:
+
+.. code-block::
+
+    struct virtio_bt_config {
+            __u8  type;          /* 0: primary controller */
+            __u16 vendor;
+            __u16 msft_opcode;
+    } __attribute__((packed));
+
+Version 2 layout, used if ``VIRTIO_BT_F_CONFIG_V2`` is negotiated:
+
+.. code-block::
+
+    struct virtio_bt_config_v2 {
+            __u8  type;
+            __u8  alignment;
+            __u16 vendor;
+            __u16 msft_opcode;
+    };
+
+``type`` must be ``VIRTIO_BT_CONFIG_TYPE_PRIMARY`` (0); the driver rejects
+other values.
+
+``vendor`` selects the driver's setup and quirks when ``VIRTIO_BT_F_VND_HCI``
+is negotiated:
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+
+   * - Value
+     - Vendor
+     - Driver behavior
+
+   * - 0
+     - none
+     - generic controller
+
+   * - 1
+     - Zephyr
+     - manufacturer 1521, Zephyr setup and set-address commands
+
+   * - 2
+     - Intel
+     - manufacturer 2, Intel setup and set-address commands
+
+   * - 3
+     - Realtek
+     - manufacturer 93, Realtek setup
+
+A backend emulating a generic controller should not offer
+``VIRTIO_BT_F_VND_HCI``, or should set ``vendor`` to 0.
+
+Virtqueues
+----------
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+
+   * - Index
+     - Name
+     - Direction
+
+   * - 0
+     - tx
+     - guest to device: HCI commands, ACL, SCO and ISO data
+
+   * - 1
+     - rx
+     - device to guest: HCI events, ACL, SCO and ISO data
+
+Each buffer holds exactly one HCI packet in H:4 format: the packet type byte
+(``0x01`` command, ``0x02`` ACL, ``0x03`` SCO, ``0x04`` event, ``0x05`` ISO)
+followed by the packet. There is no other header.
+
+The Linux driver keeps a single receive buffer of 1000 bytes posted on the rx
+queue and posts the next one only after it has processed a packet. A backend
+must therefore expect to find no rx buffer available when it has several
+packets to deliver back to back (for example an advertising report followed
+by its scan response report), and has to queue them until the guest posts a
+buffer, instead of dropping them. Packets longer than the posted buffer are
+rejected by the driver.
+
+The driver performs an HCI Reset when the device is opened, so the backend
+must answer it within the kernel's HCI command timeout.
+
+vhost-user backend
+==================
+
+A backend implements the vhost-user protocol as the slave (back-end) side, on
+a Unix socket that the guest's VMM (QEMU, or the UML kernel itself) connects
+to. Beyond the base protocol it must support:
+
+- ``VHOST_USER_F_PROTOCOL_FEATURES``;
+- protocol feature ``VHOST_USER_PROTOCOL_F_CONFIG``, so the guest can read
+  the configuration with ``VHOST_USER_GET_CONFIG``;
+- two virtqueues, tx and rx as above.
+
+For time travel, it should also support ``VHOST_USER_PROTOCOL_F_SLAVE_REQ``
+and ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS``, see `Time travel`_.
+
+The backend reads packets from the tx queue and passes them to its
+controller, and writes the controller's packets into rx buffers and notifies
+the guest.
+
+Attaching to a guest
+====================
+
+UML
+---
+
+Pass one ``virtio_uml.device`` parameter per controller, with the backend's
+socket and the virtio Bluetooth device ID::
+
+    linux ... virtio_uml.device=/tmp/bt-0:40 virtio_uml.device=/tmp/bt-1:40
+
+The UML kernel needs ``CONFIG_VIRTIO_UML`` and ``CONFIG_BT_VIRTIO``.
+
+QEMU
+----
+
+QEMU has no dedicated vhost-user Bluetooth device, but its generic
+``vhost-user-test-device-pci`` attaches a backend by device ID. The guest
+memory must be shared, for example with a ``memory-backend-memfd`` and
+``share=on``, as **test-runner(1)** sets up for virtio-fs::
+
+    -chardev socket,id=bt0,path=/tmp/bt-vhost-bredrle
+    -device vhost-user-test-device-pci,chardev=bt0,virtio-id=40,num_vqs=2,config_size=5
+
+Time travel
+===========
+
+With ``time-travel=ext:[<id>:]<socket>``, the UML kernel's time only advances
+when an external time controller allows it, and every process taking part in
+the simulation connects to the same controller using the protocol in
+``include/uapi/linux/um_timetravel.h``. A controller backend that takes part
+in the simulation:
+
+- takes part in the scheduling of the time controller (calendar), so its
+  own events (such as radio activity) happen at simulated times; btvirt
+  does this by being the calendar itself;
+- uses in-band notifications, which ``virtio_uml`` enables when both
+  ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` and
+  ``VHOST_USER_PROTOCOL_F_SLAVE_REQ`` are negotiated. Kicks and calls are then
+  messages on the vhost-user sockets instead of eventfds or pipes. This is
+  required: a call file descriptor is a regular interrupt, which UML does not
+  handle while it waits for the time controller, whereas on a back-end
+  request it asks the time controller to run at the current time before
+  acknowledging it. The backend therefore has to keep serving the time
+  controller while it waits for the acknowledgment.
+
+Packet timing, controller timeouts and the guest's HCI command timeouts are
+then all measured on the same simulated clock, and runs are reproducible.
+
+btvirt support
+==============
+
+**btvirt(1)** **-V** creates a vhost-user server socket,
+``bt-vhost-bredrle``. Each connection gets a new BR/EDR/LE controller that
+shares btvirt's emulated air, like the Unix socket servers of **-s**, so one
+socket path can be given to several devices. Packets for the driver are
+queued until it posts receive buffers.
+
+With **--time**, btvirt is also the guests' time travel calendar and
+offers in-band notifications, see `Time travel`_.
+
+User Mode Linux and KVM
+=======================
+
+**test-runner(1)** runs guests under QEMU, normally with KVM. A User Mode
+Linux guest with btvirt as calendar differs in where the controllers run and
+which clock everything follows.
+
+With QEMU and KVM, the guest's clock follows the host's real time; the
+controllers are reached over emulated serial ports (**btvirt(1)** **-s**) or
+are inside the guest (``/dev/vhci``, used by the kernel testers)::
+
+    host                                          real time
+    ┌──────────────────────────────────────────────────────────────┐
+    │ btvirt -s                                                    │
+    │   └ bt-server-bredrle ── H:4 ──┐                             │
+    │ qemu (KVM)                     │                             │
+    │   ┌ guest ─────────────────────┴───────────────────────────┐ │
+    │   │ kernel ── hci_uart (btattach) ── hciN                  │ │
+    │   │ bluetoothd, bluetoothctl                               │ │
+    │   │ or: mgmt-tester ── hciemu ── /dev/vhci ── hciN         │ │
+    │   └────────────────────────────────────────────────────────┘ │
+    └──────────────────────────────────────────────────────────────┘
+
+With User Mode Linux and time travel, the guests run as host processes, but
+their clocks only advance when btvirt, as calendar, lets them; the
+controllers are virtio devices served by btvirt, and their timers run on
+the same simulated clock::
+
+    host                                          simulated time
+    ┌──────────────────────────────────────────────────────────────┐
+    │ btvirt --time -V                                             │
+    │   ├ bt-time ─────────── calendar ───────┬─────────────┐      │
+    │   └ bt-vhost-bredrle ── vhost-user ──┬──┼─────────┐   │      │
+    │                                      │  │         │   │      │
+    │   ┌ linux (UML) ─────────────────────┴──┴┐  ┌─────┴───┴──┐   │
+    │   │ time-travel=ext:.../bt-time          │  │ linux (UML)│   │
+    │   │ virtio_uml ── virtio_bt ── hciN      │  │ ...        │   │
+    │   │ bluetoothd, bluetoothctl             │  │            │   │
+    │   └──────────────────────────────────────┘  └────────────┘   │
+    └──────────────────────────────────────────────────────────────┘
+
+How time travel works
+---------------------
+
+Two clocks matter: the host's real time, which flows continuously, and the
+simulated time of the guests, which only advances when every participant
+waits and then jumps straight to the next event. Computing takes no
+simulated time, and idle time takes no real time::
+
+    simulated time
+          ▲
+    250 ms┤                      ┌────────   computing: real time passes,
+          │                      │           simulated time stands still
+          │                      │
+          │                      │ ◀──────── idle until the next timer:
+     10 ms┤           ┌──────────┘           skipped, no real time passes
+          │           │
+      0 ms┼───────────┘
+          └──────────────────────────────────────────────▶ real time
+
+A guest joins the calendar with ``time-travel=ext:<socket>`` and talks to it
+with the messages of ``include/uapi/linux/um_timetravel.h``. When it has
+nothing left to do before its next timer, it asks to run again at that time
+and waits; the calendar answers with RUN once every other participant waits
+too and no earlier event is due::
+
+    guest                                   calendar (btvirt)
+      │ REQUEST(t=10 ms)  next timer        │
+      ├────────────────────────────────────▶│
+      │◀──────────────────────────── ACK ───┤
+      │ WAIT              nothing to do     │
+      ├────────────────────────────────────▶│ all others wait,
+      │                                     │ earliest event: 10 ms
+      │◀─────────────────────── RUN(10 ms) ─┤
+      │ runs its timer at 10 ms             │
+
+The calendar always runs the earliest event, a guest's request or one of
+btvirt's own timers, e.g. those of the emulated controllers, so every
+participant sees the same order of events on every run (lock-step)::
+
+    guest A   ──run── WAIT ·············· RUN(t1) ──run── WAIT ·····
+    guest B   ──run──────── WAIT ·························· RUN(t2) ─
+    btvirt                        timer(t0)
+    time      ─────────────────t0────────t1─────────────────t2─────▶
+                               (no real time passes while all wait)
+
+Asking before each timer costs about four messages per event. With
+``FREE_UNTIL``, the calendar instead tells a guest how far it may run on its
+own, up to the next event of any other participant, so a guest only waits
+when it has to::
+
+    guest A   ── RUN(t1) + FREE_UNTIL(t3) ─▶ runs its own events at
+              t1 < ta < tb < t3 without any message, then WAITs for t3
+    guest B   ············ request at t3 ·············· RUN(t3) ──▶
+    time      ────t1─────ta──────tb──────────────────────t3────────▶
+
+A virtio notification (kick) from the guest to btvirt may cause an event for
+it at the current time, e.g. the controller's reply. The guest sends its
+time (UPDATE) before each kick, and btvirt lowers its limit to that time
+before acknowledging it, so the guest cannot run past the reply::
+
+    guest     ─ UPDATE(tk) ─ kick ─┐ stopped at tk  ┌─ IRQ at tk ──▶
+    btvirt         FREE_UNTIL(tk) ─┘ reply event ───┘
+    time      ───────────────────tk──────────────────────────────▶
+
+Busy-waiting does not work under time travel: as computing takes no
+simulated time, a loop waiting for time to pass only advances by the 256 ns
+UML charges for each system call. A main loop woken up over and over by a
+socket it does not handle, e.g. one that hung up while only ``G_IO_IN`` is
+watched, then needs tens of thousands of iterations for a 250 ms timer.
+
+Which tests benefit
+-------------------
+
+Wall clock time of the kernel testers with **test-runner(1)**, same kernel
+version and machine, User Mode Linux with seccomp, with and without
+**-T**, all tests passing::
+
+    tester            tests    KVM    UML    UML -T
+    mgmt-tester         514   83.6  111.6     42.6
+    l2cap-tester        111    9.6   13.7     10.2
+    iso-tester          141   13.7   24.3     16.3
+    sco-tester           30    5.1    4.1      3.6
+    rfcomm-tester        11    3.6    2.0      2.6
+    smp-tester            8    4.1    1.5      1.5
+    ioctl-tester         28    4.1    2.6      3.1
+    userchan-tester       4    2.6    1.5      1.5
+    bnep-tester           1    2.6    1.0      1.0
+
+UML runs the guest's system calls and context switches considerably slower
+than KVM, as each one goes through the host, so testers exchanging many
+small messages are slower without time travel. With it, tests that wait,
+like most of mgmt-tester, take no real time for timers and timeouts. Small
+testers are faster under UML, which starts in a fraction of a second.
+
+Time travel helps most when tests wait: timers, timeouts and idle time take
+no real time, and the timing is the same on every run. It also lets
+controllers outside the guests, such as btvirt's or a firmware simulation,
+share the guests' clock, as in **test-functional(1)**.
+
+SEE ALSO
+========
+
+**btvirt(1)**, **test-runner(1)**, **test-functional(1)**, **btattach(1)**
+
+- vhost-user protocol: ``docs/interop/vhost-user.rst`` in the QEMU sources
+- ``drivers/bluetooth/virtio_bt.c`` and
+  ``include/uapi/linux/virtio_bt.h`` in the Linux sources
-- 
2.56.0

