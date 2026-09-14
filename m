Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0361351C13
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408307; cv=none; b=LE43nqhJQQ2kyClDBtJ1zaG0s7fJCfSVZwSJsLRmySJTaeEBf3Qv2TVAjihcDb9xf0gFQOG4g0n7hJrXCjUCTuH8o5QyI8bvn/1nYClUbthv6kJEwTl/FZshios6gbJw3YGUJQmGUHDABEIO98I8FR8mvum4Iypi51ZE41eGeEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408307; c=relaxed/simple;
	bh=kXQg7fScnN5CSbZVAm3FmH9CtaiT0uWyy43YRDJRWDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqchnWZaYh7lFSsT5J+UDajchLBzsEA+L/5zjeHmjV2jTerhQpQoy4ecUsboxt+pSpgas7vFl4G912JOT6qzkeODt8vy74mI+7FKGET6HoMWarTpGsd+mC6GGUk7c4zO8oBdhNP+JedSl6eTd/JUva5q39hz2b0bKtiefzw3cVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvhFSd0p; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvhFSd0p"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e96a8ba8cso2007390241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789408304; x=1790013104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OdL9Iy/IFPcIg0cK+E2j1iCFNw/VyL99vZL+0tP5k6c=;
        b=IvhFSd0plUe6f734N0Kc5bkIdH0ZhHcR6knMTfPi+0/fP48MJW1COpk3TtaMkCl1+V
         GxoYtAM6mT+gbHoNLSgPsCu9fqqhMQw+5gUztFFu6wThAwnMy72/JcYA7jVfVJEjSQl5
         BpkS67UILKS1PSTsBOvv2/I0AJQaBrkpDNzly06HvG4Uh5Uj85PvqLHAXW068rX7al5d
         T/WEO/Ph2UQtp9ji5BlfTDY741jqX8hF2ROIH6SUfGsrhT2DVSkDPJE7S7jI5pvbfrK8
         6aGqV9Jg4ESRFb2e9O0pJghwMgLjRoQVMn6A07ytTWKZCJwnaV4yxbq0B+pDGMqCg50j
         wGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789408304; x=1790013104;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OdL9Iy/IFPcIg0cK+E2j1iCFNw/VyL99vZL+0tP5k6c=;
        b=hImYl1lnz1nH3BwVTX4wK0UF39Nd5MNOVqpcfBpmoi2xCx8vyHbLyrKJPAV4eirm6R
         hl9YqDTtNgGANFmjr4sr3xb654rv8P+wDOLn3u+pum9zsrnyfU8BT8FyqHf31c3vjr3t
         S37Ezq4GnjJufVY9hKqAoPnlYnhMxO9X4CdD+82sde1Zs3HP9DdTR3Q/DWxP5EaJ27AR
         g+AuMuV6lwP56mAt/JFRMGBzT8CXeYN+aYPmHEjwXJpkw6+jXlgWqThYXI0evU4nhSPD
         PNb9mhoMn4Fpbc3Nd47+F9z1/RZGJj20VzxrA5lnOf/qikET5PzAoImGIYPOweybMMGL
         r2VQ==
X-Gm-Message-State: AFuF++kGOrYDi6IKCX86YjrTeJJtlfCQjDYJq2ztMUiWdxD7N7xhWiVW
	Z5x41Tr+EyECg240ptb9bOzrwJ/1SXnH90KWalUAjPVSWvPy5SSCUM0phXsXEb9/
X-Gm-Gg: AYBFou0lOhSahGFiL8RIOwgYU1q4qSIvDUMJiTDInFgLydIy1yUacjjsTymTbmQunIU
	75vI24sGvMfOqoYNAPpcQdMgjS0hVCr0bz8+FdxHD5Pa8Q9gBFz6hhnZ5kyD60cUwW5ZfskUIBs
	T1id4oAMCG3pa3GhK+026w1fIGwwlt13k36U8LbwmAXNu2WtFvUKdMwZwmY+A+n4Uthc4NNOmJD
	pW9cEZUsr36g1FcoI0nT/w0/4RWnXKwDFqo6UX+XBMsos+opmFh/+/cVSmehjDpsseSH+rdEQ2b
	2UPBPeWCQSLWaaG4Hdcvc7thpinvmCvnU1/SFy+VyD2kG9CC7WqM+ew6ZdDh8Jt63Sol9ZeMuvS
	TBdfkpZOs5XZ+vckfGNcA9Sr1eRqozzBxWc2MQdbd20/8kuK01Rfj8ICIGZNf6qjfyMSREpQ5+b
	lPR2z5YaV6jWlYaUvjLiaEGNRQo4aTdptBueD1uify4CSLUPqZ7svK9q4RiJquVpv/+0WAy9ypl
	UcFie2X/u0Xw/ahPR1EzgA061fjjtGMwyj8tOBRpzK620u4hhAQGbNvNFwa3OtHzQ==
X-Received: by 2002:a05:6102:8097:b0:790:235e:4209 with SMTP id ada2fe7eead31-79b5c028e07mr2269134137.12.1789408304334;
        Mon, 14 Sep 2026 10:51:44 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7927ed7d0absm10957654137.9.2026.09.14.10.51.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 10:51:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] doc: test-functional: document the test environment architecture
Date: Mon, 14 Sep 2026 13:51:34 -0400
Message-ID: <20260914175136.613532-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914175136.613532-1-luiz.dentz@gmail.com>
References: <20260914175136.613532-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add an ARCHITECTURE section describing the split between the Pytest
upper tester, which runs on the developer machine and drives the test,
and the VM hosts started via test-runner, which run the BlueZ and kernel
instances under test.

Document the control, log, tty and shared channels set up on top of
test-runner and how they relate to the existing options, and the btvirt
and USB controller topologies. Details of the virtual machine setup
itself are left to test-runner, and writing VM-side test code to the
pytest-bluezenv documentation.

Also fix the temporary directory paths, which are named after
pytest-bluezenv rather than bluez-func-test.

Assisted-by: opencode:claude-opus-5
---
 doc/test-functional.rst | 92 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index f45867f2dbe3..4a784e7850a3 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -143,9 +143,97 @@ Tests that require kernel image or USB controllers are skipped if none
 are available. Normally, tests use `btvirt`.
 
 VM instances share a directory ``/run/shared`` with host machine,
-located on host usually in ``/tmp/bluez-func-test-*/shared-*``.  Core
+located on host usually in ``/tmp/pytest-bluezenv-*/shared-*``.  Core
 dumps etc. are copied out from it before test instance is shut down.
 
+ARCHITECTURE
+============
+
+A test run consists of the Pytest process (the *upper tester*, running on
+the developer machine) and one or more *VM hosts*.  Each VM host is a
+separate **test-runner(1)** instance, i.e. a QEMU virtual machine booting
+the given kernel image with the developer machine's root filesystem passed
+through read-only.  The VM hosts are wired together by a Bluetooth
+controller: either the emulated **btvirt(1)** controller, or a real USB
+controller passed through to the VM::
+
+    developer machine (upper tester)            VM hosts (lower testers)
+    ┌──────────────────────────────┐           ┌────────────────────────┐
+    │ pytest                       │  control  │ test-runner / qemu #0  │
+    │  ├ host #0 ──────────────────┼───────────┤  └ bluetoothd, obexd,  │
+    │  ├ host #1 ─────────┐        │    log    │    bluetoothctl, ...   │
+    │  │                  │        │           └───────────┬────────────┘
+    │  └ btvirt ──────────┼────────┼── HCI ────────────────┘
+    │                     │        │           ┌────────────────────────┐
+    └─────────────────────┼────────┘           │ test-runner / qemu #1  │
+                          └────────── control ─┤  (same as above)       │
+                                     log, HCI  └────────────────────────┘
+
+The upper tester never runs Bluetooth code itself; it only drives the VM
+hosts.  Test code executes inside the VMs, which is what makes it possible
+to test two independent BlueZ and kernel instances talking to each other.
+
+VM hosts are started lazily and reused between tests where possible, since
+booting is the expensive part of a run.
+
+Channels
+--------
+
+Each VM host is started by ``test-runner`` with additional QEMU devices
+(``-o``), providing the following channels between the upper tester and
+the VM:
+
+control
+	Virtio-serial port used for the RPC connection over which the
+	upper tester drives the VM: starting daemons, running commands,
+	collecting results and exceptions.
+
+log
+	Virtio-serial port carrying the log records produced inside the
+	VM, with their timestamps.  This is what ``--log-filter`` and
+	``--no-log-reorder`` operate on, and why accurate guest time
+	(``chronyd`` plus the KVM PTP clock) matters.
+
+tty
+	A serial port with a root shell on it, used by
+	``test/test-functional-attach``.  The socket path is printed at
+	startup as a ``socat`` command line.
+
+shared
+	Writable shared directory, ``/run/shared`` in the VM and
+	``/tmp/pytest-bluezenv-*/shared-*`` on the developer machine.
+	Core dumps and ``btmon`` captures are written there and collected
+	before the VM is shut down.
+
+The ``test-runner`` console (``/dev/hvc0``) additionally carries kernel
+messages and is captured as the host log.
+
+Controllers
+-----------
+
+By default a single ``btvirt`` process runs on the developer machine and
+provides an emulated BR/EDR/LE controller to every VM host over a UNIX
+socket, also bridging the air interface between them::
+
+    VM host #0                 developer machine              VM host #1
+    ┌────────────┐            ┌─────────────────┐            ┌────────────┐
+    │ bluetoothd │            │     btvirt      │            │ bluetoothd │
+    │  hci0      ├─ HCI H:4 ──┤ (emulated air   ├── HCI H:4 ─┤  hci0      │
+    └────────────┘            │      link)      │            └────────────┘
+                              └─────────────────┘
+
+See **test-runner(1)** for how the socket is attached to the VM.
+
+With ``--usb`` the ``btvirt`` process is not started; each VM host gets a
+real USB controller passed through instead, and the VMs talk over the
+actual radio.  Tests still prefer ``btvirt`` unless ``--force-usb`` is
+given.
+
+Writing test code that runs in the VM, and the available VM-side
+facilities, are documented by `pytest-bluezenv
+<https://pypi.org/project/pytest-bluezenv/>`__.
+
+
 REQUIREMENTS
 ============
 
@@ -357,7 +445,7 @@ e.g. by running with ``--trace`` option.
 
 To do it manually, when starting the tester will log a line like::
 
-	TTY: socat /tmp/bluez-func-test-q658swgi/bluez-func-test-tty-0 STDIO,rawer
+	TTY: socat /tmp/pytest-bluezenv-q658swgi/pytest-bluezenv-tty-0 STDIO,rawer
 
 with the location of the socket where the serial is connected to.
 
-- 
2.55.0

