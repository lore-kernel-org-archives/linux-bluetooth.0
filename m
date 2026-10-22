Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684032;
	b=T25Yi4OpEE9uGWN7vYVSvaUvJHQOEAaInEwm5H8zv56HDL4L0qBWI9wIOZCySVZgMe6M
	 CnFF5AvaOJXlCV6fKCweMkLr3mBwf6TlXAtDCKwGwYZzSUiC2oKMI+xL6WnKUzFDHz/+P
	 YfKhboTBW2Bh7evn3zdOuyRdlAEbfcp8rlFcBFeDFoClsl4lcyNF3JsAQJgX6fR3Wbqcf
	 0RY1DHwTdb76ddhrZO+7dN3hYUMEBKU3ZRLJKK+3s4MMcBJEUJgXeMS0q28y7eiU7EWGw
	 gPek3bB7TXCcmqRyojDRACmGyEomfQt7Dz47/YZBgGecvW2YmgoXPYxrF3QvD5h/zHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/i3VUZ/geYXA3sQyMXecnL8IfepFKDf+8S1bTMs35/U=;
	b=ssVIxjG6e4hCleKHF6h9RTqAbl6aDD+A90di8CQvu+ESrXonELNH2Ido/mF9yvx/IjFO
	 j9OsUUyJjM/v2fzruzzoT52bFnL79Ubcw+0El36jlK8hit2RhGUsLGuNE73g4KVtsyhq7
	 f5sa3d4S0t4NFZFXM2GS46v+MfXmfLV2iA2VKNxHNI7aw7fuVtLCtz9SyMDQshpL8DnQM
	 vzJXT7cRQYJ8WcuDLcbGLNLY+sMqlXyaRV43rwFdrUjzz3uJZRGzyhRsvRei4GSjZ00lW
	 Z8v6gc2djklkKBsU5o1ZmWQ1hZvQvd28lAQcNMZaq1N4w8AZaB/fH4+TmD9QHgSUfRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gHzTVqps;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08879606A322
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08879606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gHzTVqps
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-98c5876f2b0so1219241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684031; x=1793288831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/i3VUZ/geYXA3sQyMXecnL8IfepFKDf+8S1bTMs35/U=;
        b=gHzTVqps8LB0Tkcb9yTd7X6g2BQniim3GmL40G6aIhbEoKNFm2gQCLSEBZwxKLPXE5
         NtasNVYMFMatFnLY6YJZ3k9+t0xYt3LjZO4nZkpaqFXvdW1Wo3fztXCg7j5+ho8b3x98
         d3NpOHnli6nJBrW4CECKTiQY/6oHXL6hD2YqHLYLdeE+9nbqKEOve/GJ0xAXj07cDCqN
         K6kh8V4T2Z9YQvhpkxxZGWhPVth0fcENJYLZKZJlTRF38PK3TBR+zQwNtZYQdC/IhpI4
         QmQQN8wjFCcaWe1EHfRqub7S5GVTdc1B44JeWR3o75WIs+t+OkBlwjiSsDeOfuaTUIzY
         EGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684031; x=1793288831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/i3VUZ/geYXA3sQyMXecnL8IfepFKDf+8S1bTMs35/U=;
        b=I/axwS7EViXr8CZus1O5vBe0zCS4gNNcFaaZkglog4cD65z6vZrQVjjH6krtOcs4kH
         m5KZc/TDCnYemFt9cTyPomUWgbftpBKZhy/vkVLkOcTW8c3LpE+iVqYnsC9377SjrFdX
         dZtMvbG7+RDsDknxri+36PxjRmY+Koh0N09ll8kgivCYkuYHPpZFn28rcelZ+D+XLZyL
         oK36WOzNdvSMwbHqka5Rr5+bNsokswqfexJro6bamovAEdoiYjIplIW5d6OclTLfE9i9
         JQ4Kc5IY+Om6LbnlctLd5dIs1epV79NU27scQ0nxFpkMuWk3YNUOE/hzg17hqgeYR0R0
         fOug==
X-Gm-Message-State: AFq9FYIjewRRUsAN39tJnCWe7srLTgOow0ydx8XP8DMmkoyihEqwkehO
	RzKmz2xeZ2AuaqZ+uMTCcZ06dGYLf3FfNilb2dC9Qh2Uvg9AwMaWNz8/m3Cm97wXeLg=
X-Gm-Gg: AYBFou25i4xprvn42J29X817kJzJcLyVjkpEA2Cj635E0DOF8K+Tw3mJqID0Re+PeXF
	0rA8fZOFjEnSAaij+2r2jgTKcYpzTq4clWqq+TT9iptPIiRh08GD0qKD0J65VM+wvi7cQaZ8VUO
	odQY9DrEziEvJMvfM4tS2/yJDSf+kv5KaL/1dVw+sMpcXGKZvhFWvAKGB/yujxGlf4h+4rJG+Gv
	aFv3xPZbBe2oCKh/MWYOV/90PFowMbo0fdSwaHYgT4Z4ccHOa5kr6Dh8qDp2SBelzIHRDF2llvG
	8+dhmmoGxSvSO+T52+JaqRaf34IkcV1wENdh3LtInC9EBZ+fLcbKj7+SXSLpG5Zh9m+DoNxr7Pc
	SUCyeh/uYNQKyUToF8QA42Z2/EMavDvRxwz0HSnC6dcEnDJIoILgm2QvKOrQn69yQyqTXjwmJts
	DCgoI2/TiF144QR1a5eBYIFzkEdd+KJvhFIIayTey2VXWnYD8hrBJtHbZNE0hTOjGQOzi4rDaPD
	fPa/8nmMc8Z9snuoO/nDzdmUI3yCTehE2Ekuw8hukwpLecmkgclDysr4b748G3mZRPyxonnSqk+
	FvD4gmeWirNFUnP/mdg4sqLfnqw82kvOS6yeN+R63jYz/Q==
X-Received: by 2002:a05:6102:424d:b0:79e:373e:8216 with SMTP id ada2fe7eead31-7cc922517dcmr2361527137.0.1792684030845;
        Thu, 22 Oct 2026 08:47:10 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 00/27] Run the testers under User Mode Linux with time travel
Date: Thu, 22 Oct 2026 11:46:33 -0400
Message-ID: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

This makes test-runner run the kernel testers in a User Mode Linux guest
as well as with QEMU/KVM, and with -T on a simulated clock: btvirt is the
guest's time travel calendar, so timers and timeouts take no real time
and timing is the same on every run. btvirt can also serve controllers to
UML guests as vhost-user virtio devices sharing the calendar, e.g. for
firmware simulators.

Time travel made test races and busy loops visible, fixed first in the
series, and showed that GLib's main loop reads the clock for every source
on every iteration, a system call through the host under UML, so the
testers now run on the mainloop instead.

Wall clock time in seconds, same kernel version and machine, all tests
passing, single runs:

  tester            tests    KVM    UML   UML -T  UML -T
                                          (GLib)  (mainloop)
  mgmt-tester         514   78.2   94.0     42.6    20.3
  l2cap-tester        111    9.2   10.2     10.2     5.6
  iso-tester          141    8.1   11.7     16.3     7.6
  sco-tester           30    4.6    3.1      3.6     2.0
  rfcomm-tester        11    3.6    1.5      2.6     1.5
  smp-tester            8    3.6    1.5      1.5     1.0
  ioctl-tester         28    4.1    2.1      3.1     1.5
  userchan-tester       4    2.6    1.0      1.5     1.0
  bnep-tester           1    2.6    1.0      1.0     1.0

doc/tester.config is split into tester.kvm.config and tester.uml.config,
both building every Bluetooth driver, so a single UML kernel can verify
the drivers and run the testers.

Usage, with a UML kernel built from doc/tester.uml.config:

  tools/test-runner -T -k <linux>/linux -- tools/mgmt-tester

Luiz Augusto von Dentz (27):
  tools/test-runner: Do not report filesystems already mounted
  shared/tester: Time out teardown
  mgmt-tester: Wait for LL Privacy setup to complete
  iso-tester: Fix leaking socket watches
  l2cap-tester: Fix race in LE Client - Close socket 2
  iso-tester: Fix busy waiting in PAST tests
  doc: Enable IPv6 in tester.config
  6lowpan-tester: Find the interface of the controller
  emulator: Remove -T option from btvirt
  doc: Add btvirt documentation
  emulator: Add vhost-user backend
  emulator: Add vhost-user virtio server to btvirt
  emulator: Add time travel calendar to btvirt
  emulator: Add virtio console and time travel client to btvirt
  tools/test-runner: Add User Mode Linux support
  doc: Add virtio documentation
  shared/mainloop: Add idle callbacks
  shared/timeout: Run timeouts of 0 once idle
  shared/tester: Remove GLib dependency
  emulator/hciemu: Remove GLib dependency
  tools: Build testers that do not need GLib with the mainloop
  shared/mainloop: Add deferred callbacks
  tools: Add socket watches for testers without GLib
  tools: Run sco-tester, rfcomm-tester and 6lowpan-tester on the
    mainloop
  tools: Run l2cap-tester and iso-tester on the mainloop
  doc/virtio: Update measurements of the testers
  doc: Split tester.config for QEMU and User Mode Linux

 Makefile.am                   |    5 +-
 Makefile.tools                |   47 +-
 doc/btvirt.rst                |  189 ++++++
 doc/test-functional.rst       |    4 +-
 doc/test-runner.rst           |  150 ++++-
 doc/tester.config             |  118 +---
 doc/tester.kvm.config         |  144 +++++
 doc/tester.uml.config         |  120 ++++
 doc/virtio.rst                |  412 +++++++++++++
 emulator/hciemu.c             |  122 ++--
 emulator/main.c               |  116 +++-
 emulator/timeout.c            |  102 ++++
 emulator/timetravel.c         |  743 ++++++++++++++++++++++++
 emulator/timetravel.h         |   55 ++
 emulator/ttclient.c           |  313 ++++++++++
 emulator/ttclient.h           |   50 ++
 emulator/vconsole.c           |  701 +++++++++++++++++++++++
 emulator/vconsole.h           |   26 +
 emulator/vhost.c              | 1018 +++++++++++++++++++++++++++++++++
 emulator/vhost.h              |   67 +++
 emulator/virtio.c             |  356 ++++++++++++
 emulator/virtio.h             |   20 +
 src/shared/mainloop-ell.c     |   12 +
 src/shared/mainloop-glib.c    |   12 +
 src/shared/mainloop.c         |  177 +++++-
 src/shared/mainloop.h         |    4 +
 src/shared/tester.c           |  306 +++++++---
 src/shared/timeout-glib.c     |   10 +-
 src/shared/timeout-mainloop.c |    9 +-
 tools/6lowpan-tester.c        |  111 +++-
 tools/bnep-tester.c           |    7 -
 tools/ioctl-tester.c          |    6 +-
 tools/iso-tester.c            |  358 +++++++-----
 tools/l2cap-tester.c          |  347 +++++------
 tools/mesh-tester.c           |    1 -
 tools/mgmt-tester.c           |  204 ++++++-
 tools/rfcomm-tester.c         |  105 ++--
 tools/sco-tester.c            |  108 ++--
 tools/smp-tester.c            |   30 +-
 tools/test-runner.c           |  404 ++++++++++++-
 tools/tester-io.c             |  400 +++++++++++++
 tools/tester-io.h             |   52 ++
 tools/tester.h                |    8 +-
 tools/userchan-tester.c       |    1 -
 44 files changed, 6721 insertions(+), 829 deletions(-)
 create mode 100644 doc/btvirt.rst
 mode change 100644 => 120000 doc/tester.config
 create mode 100644 doc/tester.kvm.config
 create mode 100644 doc/tester.uml.config
 create mode 100644 doc/virtio.rst
 create mode 100644 emulator/timeout.c
 create mode 100644 emulator/timetravel.c
 create mode 100644 emulator/timetravel.h
 create mode 100644 emulator/ttclient.c
 create mode 100644 emulator/ttclient.h
 create mode 100644 emulator/vconsole.c
 create mode 100644 emulator/vconsole.h
 create mode 100644 emulator/vhost.c
 create mode 100644 emulator/vhost.h
 create mode 100644 emulator/virtio.c
 create mode 100644 emulator/virtio.h
 create mode 100644 tools/tester-io.c
 create mode 100644 tools/tester-io.h

-- 
2.56.0

