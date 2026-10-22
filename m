Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684041;
	b=X1QbhDbHPj6WzRIdxpzqb2NFvC3/OmGq7yWySBjrEQN2AMy0FWNjGMyECN9xmU2krA4V
	 M+FK2XaFKY4516RGmP+DqTQxE7W3rDDSb+djmchwyNMlll7vdHdcRvA3tyVBrMV/ukeCi
	 NqMKRZxN62q+UHYDHZ8VAUnOHDFpr8lbt0PPE1hVuJTLoa8V2Kmj6MMpO1RnFIPNYX2Rt
	 tiCVsk0hkh1XAczcRYe7LXHyN8qwQ9PAs/Arlm5SiQke1kEAwefWvpuoQQSZKiE1dJLB9
	 A42Ty0fVu2ZKCTZdOQ9yRZbuLZ3IBdUJ5d19OLKAtAGLjs+4AhDjCqkQZYHr63AIdpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BUpl1lfygDujmJjXPVqKQQ4cXgMxmJwku+xvzA0S5TA=;
	b=kF40qE+4pC2Fz1IYlMcwxEfBLmqjvVltmU/A3+5vO90adEmTMxpSoEpjfpyjs31JGsGM
	 W/xVXZMtGKXhfP4XwoQFoqNb6PoWRPXyJf0x7v4dBZwX8OClGqNrzNsx9ds8cMyEAhdcp
	 fP3TsZdpXjRs2pETy/JeHeJ5dCnFT3hyT/pNwbpZ+tSjqXJex6uwsrfg2i0rNGbk0asM7
	 FXSaX9S/esbwC/oYICrEKrK+rjH1Iw/73JRT+UD9nVRxMpEQ4lwPm9M+g35IxbaYLWwdR
	 vPYPECD5Oi5vYGc326+8g38bb60VjiDAbXoft/7h7H2Kx6/jAJt67mrNC4hFgcLMTGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tJMac8Kv;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26AC606A31D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B26AC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tJMac8Kv
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so937168e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684040; x=1793288840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BUpl1lfygDujmJjXPVqKQQ4cXgMxmJwku+xvzA0S5TA=;
        b=tJMac8Kvc0AgZ/YTxcfG/aqy7zpDl2Fbjzx5orz/uPzGOAWH45kRYV2BV3xcC557UP
         lWW14dSaBqql55F+LPHPWjhiqi2gdw5VoJatmg+4PXBk80pSDe8JqYW6CK2/bhk+Phn+
         Ds4pNPxAKEZA95w6XZbldNdFiYwNTXFneGfNB3fnZiTj5auRQq4hugl8Uy9mNSb80T+J
         3n95AYKAEeuKhiWpcLzjBbDzoTo5NaqKdEVRn3FWBquYq4nlZwCKyQXhc7bwRNna6kxy
         ypsPCkX5wdro0JFhn+tPoY+FukVzBa3qk17qXGhv0LIm3WFlNxVyInANw/eYO867B4rW
         Jz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684040; x=1793288840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BUpl1lfygDujmJjXPVqKQQ4cXgMxmJwku+xvzA0S5TA=;
        b=wxxDfUBVorYALOgC7w5Ri3Ceg/pzx7x79emijjM84GQDRBPUyVWFl5e+qaShfwWPYa
         Sk6+DfuwQQm0U8tCNSgR1E1mJUTzTB+UaqAw9d8zsF0feX/HVqflD6ui8mTQ5paZu8MN
         s5BH65ygY0I1ngjN69EkFGkWLucoOhpoghLeErQ9MCkHS8ovsEY5eIq/KUlTopNH7WTi
         0s+R+ayKyZtNgiOOtTdP14dPGCP1DJMK/xl6KNK5iloiLI2aI6f5o3sZk1Ti8AytNqI6
         cf9pUb7VC4x+euK8UnrkxclXE/BYUTHhJ4lgt/fhrPCxaJBvdxmJQ0QRQ6pMY94s/eQ/
         Dwyg==
X-Gm-Message-State: AFq9FYKOlkMc559SVQCLkZgwZv3bUp2Q6OPGOsypalZ/OYbSsuVx5uCN
	0tzDsD/AF82VtxXSLeZZ5lJNRUGA0YGsWAJ7iwQyjSOZ1vJaT4T9G1YC0ZslsxSc1ME=
X-Gm-Gg: AYBFou1/e0Qp4wlD5OrG+7vQXUVWHDsBCyxIIQZxeNBkaX/6M9UX74KtiwGhmwFEvxu
	pFxRX6CdXeVi/4wPk19SjIsovRFEIb1HNZQtN1ufN3wXsvMKW4t8KXxRWw6BBqXAydr9XbeYfbo
	AgiQpacU5QmH/ELXsQUBbBdjwk9gxdqRwyHy8KVt+bw9oql2mLfHkIMOP3EAtJ+4nglJMwvLJSq
	tY6/4Ce7YzrA//hcwaDKtHfai+Otf12q+nE5QOskUv9p2Ug1o/ytzMANxijfBZHcuI76vGics2F
	VulNYE52y3pd8nWZI8fqVgixWp59VEhYX3Vh/VzjOqJ5UMBCF4W0qk33wr7atVlNo9MrfJ4NE7F
	ipB0bAJlXUPBI+pgP6C3LyiaoJx2br5xCnj6eGdTWuRYrx7lzvpgv/hwa/0R5MsuA2UtdIqj3jq
	nNl7n6SKX+TDTdfTDi/vBElJImLJfUskMiS+TXt/oOe1wau36AE/PthfzEbmGcfzZNvTskxUaLk
	bEk/8/89iqSZrwoBgyIVbZfb7Roq3R6jgCbAbzkGRLBD4SfVnz6N4kSuoigSghUGtJSWR61gME6
	DjHR6T+KJ8vkowqOPKwm/RuEZsxdrdlOEcRliUwYQUdUAA==
X-Received: by 2002:a05:6122:4a1b:10b0:5cd:a80c:102c with SMTP id 71dfb90a1353d-5eafa45db6cmr670523e0c.7.1792684039537;
        Thu, 22 Oct 2026 08:47:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/27] doc: Add btvirt documentation
Date: Thu, 22 Oct 2026 11:46:43 -0400
Message-ID: <20261022154701.3959500-11-luiz.dentz@gmail.com>
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

Document the btvirt options, the ways it exposes the emulated
controllers and which of them share the emulated air interface.

Assisted-by: Claude:claude-opus-5-5
---
 Makefile.am    |   1 +
 doc/btvirt.rst | 153 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 doc/btvirt.rst

diff --git a/Makefile.am b/Makefile.am
index f742458d113e..26884a54ea06 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -494,6 +494,7 @@ EXTRA_DIST += SECURITY.md
 EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/test-coverage.txt \
 				doc/test-runner.rst \
+				doc/btvirt.rst \
 				doc/test-functional.rst \
 				doc/functional-testing.rst \
 				doc/functional-a2dp.rst \
diff --git a/doc/btvirt.rst b/doc/btvirt.rst
new file mode 100644
index 000000000000..2e016406a4fc
--- /dev/null
+++ b/doc/btvirt.rst
@@ -0,0 +1,153 @@
+======
+btvirt
+======
+
+-----------------------------
+Bluetooth controller emulator
+-----------------------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under the terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: October 2026
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**btvirt** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+**btvirt(1)** emulates Bluetooth controllers in software. It is used to test
+the kernel Bluetooth subsystem and BlueZ without real hardware, most notably
+by **test-runner(1)** and **test-functional(1)**.
+
+The controllers are implemented by the BlueZ emulator (``emulator/btdev.c``)
+and speak HCI. They can be exposed to a Bluetooth stack in several ways:
+
+- as local virtual controllers through ``/dev/vhci`` (**-l**), which then
+  appear as ``hciN`` on the machine running btvirt;
+- as H:4 streams on Unix socket servers (**-s**) or a TCP server (**-t**),
+  one controller per client connection;
+- as an H:4 stream on a pseudo terminal (**-S**).
+
+All controllers created by one btvirt process share an emulated air
+interface: they can discover, connect to and exchange data with each other,
+regardless of how each one is exposed. Controllers in different btvirt
+processes cannot see each other, except for the test LE controllers created
+with **-U**, see below.
+
+btvirt runs until it receives **SIGINT** or **SIGTERM**.
+
+OPTIONS
+=======
+
+At least one of **-l**, **-s**, **-t**, **-S** or **-U** must be given.
+Optional arguments must be attached to the option, as in **-l2**,
+**-t45551** or **--server=/tmp/bt**.
+
+-l[num], --local[=num]      Create *num* local virtual controllers through
+                            ``/dev/vhci`` (default: 1). Requires access to
+                            ``/dev/vhci``. The controller type is selected
+                            with **-L**, **-B**, **-A** or **-C**.
+
+-s[path], --server[=path]   Create Unix socket servers in the directory
+                            *path* (default: ``/tmp``). Each client that
+                            connects gets a new controller of the server's
+                            type, attached as an H:4 stream. The following
+                            sockets are created:
+
+                            ``bt-server-bredrle``
+                                BR/EDR/LE controllers, of the version given
+                                with **-C**
+                            ``bt-server-bredr``
+                                BR/EDR-only controllers
+                            ``bt-server-le``
+                                LE-only controllers
+                            ``bt-server-amp``
+                                AMP controllers
+                            ``bt-server-mon``
+                                monitor socket, no controller is created
+
+-t[port], --tcp[=port]      Create a TCP server on *port* (default: 45550).
+                            Each client that connects gets a new BR/EDR/LE
+                            controller, of the version given with **-C**,
+                            attached as an H:4 stream. The server listens on
+                            127.0.0.1 only.
+
+-S, --serial                Create a pseudo terminal with a BR/EDR/LE
+                            controller attached as an H:4 stream. The path of
+                            the terminal is printed on startup; attach it
+                            with **btattach(1)**.
+
+-U[num], --letest[=num]     Create *num* test LE controllers (default: 1)
+                            through ``/dev/vhci``. Unlike the other
+                            controllers, these exchange radio traffic with
+                            test LE controllers in other btvirt processes,
+                            using UDP broadcasts on port 45023.
+
+-L, --le                    Make the controllers created with **-l** LE-only.
+
+-B, --bredr                 Make the controllers created with **-l**
+                            BR/EDR-only.
+
+-A, --amp                   Make the controllers created with **-l** AMP
+                            controllers.
+
+-C version, --core=version  Core Specification version of the BR/EDR/LE
+                            controllers created with **-l**, **-s** (on
+                            ``bt-server-bredrle``) and **-t**. Supported
+                            values are ``5.0``, ``5.2``, ``6.0`` and ``6.2``
+                            (default).
+
+-d, --debug                 Enable debug output for the **-l** and **-s**
+                            controllers.
+
+-v, --version               Show version.
+
+-h, --help                  Show help options.
+
+VENDOR COMMANDS
+===============
+
+Controllers created with **-l** answer two vendor commands, so the kernel
+treats them as supporting the corresponding extensions:
+
+- opcode ``0xfc10``: emulator-specific vendor command;
+- opcode ``0xfc1e``: Microsoft vendor extension (MSFT).
+
+EXAMPLES
+========
+
+Create two local controllers, which show up as ``hciN`` and can connect to
+each other::
+
+    $ sudo btvirt -l2
+
+Serve controllers to virtual machines, one per connecting VM, the way
+**test-functional(1)** does::
+
+    $ btvirt --server=/tmp/bt
+    $ test-runner -u/tmp/bt/bt-server-bredrle -k bzImage -- ...
+
+Emulate a Bluetooth 5.2 controller over TCP::
+
+    $ btvirt -C 5.2 -t
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
+
+SEE ALSO
+========
+
+**test-runner(1)**, **test-functional(1)**, **btattach(1)**
-- 
2.56.0

