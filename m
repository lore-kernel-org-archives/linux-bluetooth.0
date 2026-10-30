Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395794;
	b=1DbpyrY3ylNidOEmwIbPXdInDQSk3UI1N/Mwi4MotSrX1Zcsz9cKgrDKSzn/dxsVbfXg
	 aJ3EveTOoqmzceapqP9HqTKVrcy8KQKV6iIeN4CfhswSXWBPo8Wn1U47dn+PY5JYNAra7
	 SvjdVLg+8cCW4TV5gvjqHVY5toYUtgUWGSDuHoGGPwWbCYs7A8X6Iva6qZpsAKGArdV5V
	 i4k1COiP+Oty4J6MX6tmlVDRmHuYF7yEKIokF7PCzQ4Eh7xZVYhbKWrnD9OCgBTn9zRPt
	 aSMnpGz5JncIph6+FMw0u7FXnkK7nOew+D78gZUJTiQB9iGMMGebQ+IDXdxrdOlaVag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LlEzGUAeQ+C9NAODFVnjP/8YdhsugoJk8PBpSWa/9iU=;
	b=pvm6UfCJTKCDRZmTMmM6Ar7I4r+TFloWiiOmUMWK/geLyxnQ05VVU2IECdYSzOkCMHKh
	 RfwZgmmfce9ypOll6SnZSvp6su7dW8bivhrfMm49QuojJQB7+Rs7+T4vnIHRyN3RrIJJ0
	 GQonl5PISJ1E5Jng5024UxHjL/fYd2Dpj71/P2r0UJEEYGBGxEpBoiiQvcMWsPnNZbTab
	 3hwGky6uWQrw2qgAXzAAfOYMAiWatgdnUaokIk97x/POJgnOpukaBe0sTt+M1F13S1ej0
	 p4s+/Yhp2hEKI5OeIrqNEBnQvRWXQaeo2sv2x+9UttrRlgoIbBukfZa3nZxsFt/Zyvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ufrWobLS;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769C606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A769C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ufrWobLS
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc53938a8fso730003137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395792; x=1794000592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LlEzGUAeQ+C9NAODFVnjP/8YdhsugoJk8PBpSWa/9iU=;
        b=ufrWobLS9wj2g44ZVamjEm5nKz4GwOS0FFGMfpSW7vvYPkz9AeeS7vKEDINAxFRVFE
         EKalPkcouxBPE0LoiftoGt0GjkA+nAfBXk0MmR5O3VXj70z05qPRPhhNSlvlLR0JsDOW
         016A5PFS7IP6Mi7DEGfj5JMtRQCNEXu2XWkrepqBpWp18G2XK9ZtYasTWvx/aLQTFKo8
         30hvul7DfIoSrh2CT5AvZrPbiGmAFOFXkwVI29PLLlZnsskEnzP3SVQaszJO4jzKhrBR
         LHeQz4hf8LFFXg/YvQfRAMiy0IKgYeLBLn6FJnU5cfwypUYUSGUAreidg7iEoxrhJ8N0
         qxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395792; x=1794000592;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LlEzGUAeQ+C9NAODFVnjP/8YdhsugoJk8PBpSWa/9iU=;
        b=ptQ4gPVT3EKoStuZhz/QelopzUY8JgxHkAtVyIXUFCx6Y0mdybtLM4tZyBiJOUDuFr
         Rwi4YWyUfLyjSk6iykgsm03e70fIefl/JTh5uNHJrEolFdglvdRMEJTb3OZ8PXwypLOx
         zHAOwHkc8ld0hshhNw5TFYT583h0kAkxRuqdi1kL5GD/cQnOaYLqRqtbiiQiDeq0Pj+Y
         iioWK7lD2tLSRFHxiM87rHrufgFqrtIXo2ZkFVXzYS+PVgyqniQXqASWxCtCO333bXhn
         zfdxug2f2bkjON5t0Atf3lymj+LYXZ/J4UO1Mhn6eoCmbQc6F3EmapgHonhjZDQ+ZXXa
         Kj3Q==
X-Gm-Message-State: AFq9FYJp99W1bP0vPbL7L39+EGvB+Z8jVgxHByZzCD1ExXP1WR22qyxy
	wk/RcDFzeyiu2t2sWD8iRiXfybEgbiW2ivRVnuPYhOa8uaw85hLJMkunAG8LVQ==
X-Gm-Gg: AYBFou3BH8al5XV0DzecG7S7aGGTDklXfqMeDt4xRLz9p9rUJcSbHzcr8bIddkaB7pz
	dkzY5eRF7LHPiekbg/dStnvUM2Yg+NpO94m9RgDrGUPafjZx2N8gbgkUhFsvu4h4+t7DVGlkChS
	zB9ZNe7TZznmbRv+m3Yed51XCT00NAH7h35SMeUYfJQeiGF5YmeKcKfdSEFLj9pOZC2unbZ9VJv
	OjlwVGrgrRNRWmj5fTyCu84QAgIPwtlMKLya2hQ6kgoUWxjw6H+1annRZv4PjX3rNa9L+IFSseU
	pUisay/G76BO0pzaINTXoLrkydu7KFqfKc5kTUCHNcP7qxGIUosd7htl5V3Ac319PaTjNq3DGDk
	btqcq33nHdrYsGv2888QbMlIFyXD2luLhQBaa9YsyxHb0mHM3aT8+szjXKLv8++/EmNh10k9ua5
	KyWFy//FffDi1qx3v+X9VwMJf68yKBGm4BWwPhWA3PQuyT0gvfTx/wjdaQpmHniIImEppx9bLZt
	FaPqYcKW3ZrMknr2GEaWCQe635hnp+PfTl78jyPfSu/ANoxlD2Q4GkbRks+rJFqajSQohvY70z6
	yoKi8NWUpaYZWxUJYbzVjklQR7eSEQNLRUNLTpgxz0a6FPznefseleZkXGvrM1GT0BdHZ67cPQv
	d54AwzV2+N0kjsFzCDZQX78w6ua4mk0sFgbVZKrkhYF+0dMXnu/RyQqjsLwQg9fCC1iBJeO0O4i
	zS5HY=
X-Received: by 2002:a05:6102:5494:b0:7cb:bc5e:7d9f with SMTP id ada2fe7eead31-7d072bb3829mr1876769137.11.1793395792519;
        Fri, 30 Oct 2026 14:29:52 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/10] doc/test-functional: Document User Mode Linux VM hosts
Date: Fri, 30 Oct 2026 17:29:36 -0400
Message-ID: <20261030212940.753771-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
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

Document running the VM hosts as User Mode Linux guests through
test-runner, e.g. on machines without KVM support, with btvirt serving
their controllers and channels over vhost-user, and the kernel
configuration this needs.

The hosts run on real time, as time travel makes these tests slower:
document the measurements and why.

Assisted-by: Claude:claude-opus-5-5
---
 doc/test-functional.rst | 74 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index e2fcf34138b3..a50cd441189c 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -90,8 +90,9 @@ The following additional options apply:
 
 ``--kernel=<image>``
         Kernel image (or built Linux source tree root) to
-	use.  See **test-runner(1)** and `tester.config` for required
-	kernel config.
+	use, either a QEMU ``bzImage`` or a User Mode Linux binary, see
+	`User Mode Linux`_.  See **test-runner(1)** and `tester.config`
+	for required kernel config.
 
 	If not provided, value from `FUNCTIONAL_TESTING_KERNEL`
 	environment variable is used. If none, no image is used.
@@ -167,7 +168,9 @@ A test run consists of the Pytest process (the *upper tester*, running on
 the developer machine) and one or more *VM hosts*.  Each VM host is a
 separate **test-runner(1)** instance, i.e. a QEMU virtual machine booting
 the given kernel image with the developer machine's root filesystem passed
-through read-only.  The VM hosts are wired together by a Bluetooth
+through read-only.  With a User Mode Linux kernel the VM hosts are UML
+processes instead, see `User Mode Linux`_.  The VM hosts are wired
+together by a Bluetooth
 controller: either the emulated **btvirt(1)** controller, or a real USB
 controller passed through to the VM::
 
@@ -249,6 +252,46 @@ Writing test code that runs in the VM, and the available VM-side
 facilities, are documented by `pytest-bluezenv
 <https://pypi.org/project/pytest-bluezenv/>`__.
 
+User Mode Linux
+---------------
+
+When ``--kernel`` is a User Mode Linux (UML) binary, or a built kernel tree
+with a ``linux`` binary and no ``bzImage``, **test-runner(1)** runs the VM
+hosts as UML processes instead of QEMU, e.g. on machines without KVM
+support, with the developer machine's root filesystem mounted read-only
+through hostfs. The channels are passed to it with ``-o`` as kernel
+parameters: a single ``btvirt`` process serves every device of the VM hosts
+over vhost-user (see `virtio.rst <virtio.rst>`_), the controllers with
+``-V``, and the control and log channels as virtio consoles with
+``--console``::
+
+    VM host #0 (UML)            developer machine              VM host #1 (UML)
+    ┌────────────┐            ┌─────────────────┐            ┌────────────┐
+    │ virtio_bt  ├─ vhost ────┤     btvirt      ├──── vhost ─┤ virtio_bt  │
+    │ hvc        ├─ vhost ────┤ controllers,    ├──── vhost ─┤ hvc        │
+    └────────────┘            │ consoles        │            └────────────┘
+                              └────────┬────────┘
+                                       │ control, log
+                                    pytest
+
+The shared directory is mounted with hostfs instead of 9p. There is no
+``tty`` channel, so ``test/test-functional-attach`` is not available, and
+controllers cannot be passed through, so ``--usb`` and ``--pcie`` need
+QEMU.
+
+The VM hosts run on real time, with test-runner ``-R``. Time travel, which
+makes the kernel testers faster, makes the functional tests slower: they
+exchange traffic between two or three guests, and in lock-step only one
+guest runs at a time, each exchange taking a round trip to the calendar.
+Wall clock time of ``make check-functional`` with 4 workers, same kernel
+version and machine, UML with seccomp, cut off at 78 s, and of
+``-k test_bluetoothctl``::
+
+    VM hosts             check-functional        test_bluetoothctl
+    KVM                  68 s, 49 tests run      20.1 s
+    UML                  78 s, 41 tests run      20.4 s
+    UML time travel      78 s, 12 tests run      25.8 s
+
 
 REQUIREMENTS
 ============
@@ -258,7 +301,7 @@ General
 
 The following are needed:
 
-- QEmu (x86_64)
+- QEmu (x86_64), unless running User Mode Linux VM hosts
 - ``dbus-daemon`` available
 
 Recommended:
@@ -317,6 +360,22 @@ configuration enabled:
 	CONFIG_PTP_1588_CLOCK_KVM=y
 	CONFIG_PTP_1588_CLOCK_VMCLOCK=y
 
+A User Mode Linux kernel is built with ``ARCH=um`` from the same config,
+and needs in addition:
+
+.. code-block::
+
+	CONFIG_HOSTFS=y
+	CONFIG_VIRTIO_UML=y
+
+.. code-block::
+
+	make ARCH=um defconfig
+	scripts/kconfig/merge_config.sh -m .config ../bluez/doc/tester.config
+	make ARCH=um olddefconfig linux
+
+The KVM and PTP options above do not apply to User Mode Linux.
+
 USB
 ---
 
@@ -348,6 +407,13 @@ Run all tests
 
 Test output is logged in ``test-functional.log``.
 
+Run all tests under User Mode Linux
+-----------------------------------
+
+.. code-block::
+
+	$ test/test-functional --kernel=/pathto/linux
+
 Show output during run
 ----------------------
 
-- 
2.56.0

