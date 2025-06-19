Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522628C2DE
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356908; cv=none; b=qLxhCSjFJ+VKOLTs1WZfnkrGsLgtG+XAMPkV8cL4k2fs0bWl4T9dNa+5HIRnVwR/93nh0Zap4W5l2XhwN9Cr1Tn6fvLNM4TSbD+zQ+Fz/3My0wx6ZZ/gWNiMxjTtmD9Ij71YP9nOE0XFuEWQiElAYKML4js4v3YgN0GGlNipmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356908; c=relaxed/simple;
	bh=jV2hpq7BEOCMGBJ+aDAg1NEgzb59TaatlGijaRUe970=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LAe07iVY0ebRIaDJDoMGuf5c52W4mQYNiVavTEfReN44c+rGsCKfppRbx+H5G2nn/xX3iGVHXV0gBMFglCVebbJevd17y9WoZ7wmeOyCkt5Zo1rNgQtMJpJAHERQqfCZiYTyMsq6/Cb2GaobdqEpgxnJB6kBc0kCTasrckRm+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KXtCoapv; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KXtCoapv"
Received: from github.com (hubbernetes-node-69fa3f5.ac4-iad.github.net [10.52.182.32])
	by smtp.github.com (Postfix) with ESMTPA id D31277008A5
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750356905;
	bh=kuw//fO+bKmRpMO/RXt8dB0OycU0NDfGUElQICttm/g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KXtCoapv5aHx4naSMjJMuQYhlkvt3iu0T9V+jcULVJmE0htO0wOTWSXBRA9fL8ypD
	 qmXlr3EHQOzEqeyz3FnPstXePHQ4JThP1rWSeq/Iu3J7iKjAabH4LV+8qO5JX+p/rv
	 uW1jZrDbtevrULeFcT1kUzvxxX2dyNYy8ZWPlwIg=
Date: Thu, 19 Jun 2025 11:15:05 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f5fd7e-ab13c2@github.com>
Subject: [bluez/bluez] 941dbc: device: Fix memory leak
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 941dbc5f3b56fea087a3b88bc73cf2776c02d4d5
      https://github.com/bluez/bluez/commit/941dbc5f3b56fea087a3b88bc73cf=
2776c02d4d5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-19 (Thu, 19 Jun 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix memory leak

This frees the LastUsedBearer string to avoid memory leak:

Direct leak of 12 byte(s) in 2 object(s) allocated from:
    #0 0x7ccf538fd9c7 in malloc ../../../../src/libsanitizer/asan/
						asan_malloc_linux.cpp:69
    #1 0x7ccf53665b09 in g_malloc (/lib/x86_64-linux-gnu/
						libglib-2.0.so.0+0x62b09)
    #2 0x7ccf53659b90  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x56b90)
    #3 0x7ccf53659cd4 in g_key_file_get_string (/lib/x86_64-linux-gnu/
						libglib-2.0.so.0+0x56cd4)
    #4 0x5c8c691f2811 in load_info src/device.c:4225


  Commit: b8bbd5236ee008e25148477fa6390006b6113e7f
      https://github.com/bluez/bluez/commit/b8bbd5236ee008e25148477fa6390=
006b6113e7f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-19 (Thu, 19 Jun 2025)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add -U/--usb option

This adds option to use a host controller plugged over USB:

> tools/test-runner -U "usb-host,vendorid=3D0x8087,productid=3D0x0036"...=
 -- /bin/bash
> dmesg
[    1.046214] usb 1-1: new full-speed USB device number 2 using xhci_hcd=

[    1.192623] Bluetooth: hci0: Firmware timestamp 2025.18 buildtype 2 bu=
ild 82364
[    1.192638] Bluetooth: hci0: Firmware SHA1: 0xa66e016b
[    1.197362] Bluetooth: hci0: Fseq status: Success (0x00)
[    1.197368] Bluetooth: hci0: Fseq executed: 00.00.04.196
[    1.197371] Bluetooth: hci0: Fseq BT Top: 00.00.04.197
> lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 8087:0036 Intel Corp. BE200 Bluetooth
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub


  Commit: 6f67234aa71bf9cdc6d939fc7c01427c85b19034
      https://github.com/bluez/bluez/commit/6f67234aa71bf9cdc6d939fc7c014=
27c85b19034
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-19 (Thu, 19 Jun 2025)

  Changed paths:
    M doc/test-runner.rst

  Log Message:
  -----------
  test-runner.rst: Add documentation for USB-passthrough

This documents the newly added option -U/--usb and adds a dedicated
section that explains the required the kernel image to build with
some extra config options to enable passing -device qemu-xhci in order
to use -device usb-host.


  Commit: ab13c24eab8759da1d0b696c76745329bc18cb95
      https://github.com/bluez/bluez/commit/ab13c24eab8759da1d0b696c76745=
329bc18cb95
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-19 (Thu, 19 Jun 2025)

  Changed paths:
    M doc/tester.config

  Log Message:
  -----------
  tester.config: Add config options for USB-passthrough and drivers

This adds the necessary options in order to enable USB-passthrough
configuration and also enable most of the drivers so they get
build-tested.


Compare: https://github.com/bluez/bluez/compare/f5fd7efee7c3...ab13c24eab=
87

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
