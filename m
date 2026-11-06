Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.157.246.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962878;
	b=PzOdTv8YthyK/PKv/pPsfvRiYqyB/8U3tdMjDqmgr6TCO3EGYSueWYH7sN5iSGeFR8YP
	 RJKq7uhk8ypWGSTrDZ+XAcLlkxd1FZ5xAkKPiquKCCV883yNnYKeqcWWSeB0wvnPodUWX
	 WRHGLW2gw8BFUw0ju6ERadDd7it0aNOTyj33uUPqIeAbulvJ9sIk4Ot5JxlR0Sv+CRNV7
	 7MLoQeGsDeOlur6scLuV+uCcaxuePLNqVfCM/BDb1FhLeYJijNaei3uviLuHk4O+b+H38
	 pUph8cwpu1PZvzaMdgho0GDnCXnEz5Ia4iMVTxsAirh7O2Ay1EE9OJ133BQm74/vKog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962878;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=3OVWukCObF+HaNI3ZO5OFqNe+4QpKGocOyCTLOD3r/Q=;
	b=sxWd22nG1edFyFlUn7DekM9/o414KOCC6FX8WIoeLWkGq2fft489YDvJFmS7OLd6g1wv
	 9aDnh2YCYFXHesHOBKVqH7fsBLtjF1fm7yRBQmiteG25c4hc0sGnfNfN/u6SrxggrxD2R
	 Ng2zNg7kUZSzUVoslcgQvmGj1vtX7G3xHVVbnbbNsLV3cYpIdm0L4JRvdG0PDjTXJi8S6
	 q+QxPvM7ASr9mFW8lqXEcXEMdmUBxrgENLoCWnBIOVXnzYnsYRRBXlL5lHSe+MhqsYOcy
	 SfhN9kbga9/CycdjGtpcmMFuBMnjife2cCUjQlKlm5trCIr/hLUO3CqEHuzD67LX5Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.nuim.ie;
	spf=pass smtp.mailfrom=cs.nuim.ie;
	dkim=pass header.d=cs.nuim.ie header.i=@cs.nuim.ie header.a=rsa-sha256 header.s=selector1 header.b=rEEaSd7E;
	arc=none smtp.remote-ip=149.157.246.25
Received: from mta-srv-01.cs.nuim.ie (mta-srv-01.cs.nuim.ie [149.157.246.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA84606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 11:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AA84606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.nuim.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.nuim.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.nuim.ie header.i=@cs.nuim.ie header.a=rsa-sha256 header.s=selector1 header.b=rEEaSd7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.nuim.ie;
 i=@cs.nuim.ie; q=dns/txt; s=selector1; t=1793962875; h=date : from :
 to : subject : message-id : mime-version : content-type : from;
 bh=O2COWLoBrQWGA5GPsR7n+J1mv/36a3c54n+fLu5kR+0=;
 b=rEEaSd7E9f8yvAlRApGkd8wg8amNbc79f3NDD7nY65omRocvWkHWF+b34WHUaUNR+gs32
 2VRNbUH4dm2lyHXqxVyGq3cmwBYGMiFucupweUudR3cJDR4pKGTZ0xh4y3rPiSdbmTk646H
 2Sv+sG62zRHuwyJ3vcBg7MEPBqt8g4nijdp8g0wqQHjlGflg4Ct6whKAkFItKjnooYuJ+Wj
 IR8gQNs0w4e6AoZOTA7sCNDlbOolRQMBmwCRKicRZs/uIw1kB2BFYu9QhPkgvShM3UbI2p+
 31DxlQn2CGizE0FyvIDXxH6KN2oPGSw5GD5wg3etMUOxvkqvM2vzEWGwYKrA==
Received: from port-kadr (port-kadr.cs.nuim.ie [149.157.248.96])
	by mta-srv-01.cs.nuim.ie (Postfix) with ESMTPS id 5530B600A7;
	Fri,  6 Nov 2026 11:01:15 +0000 (GMT)
Received: from barak by port-kadr with local (Exim 4.100.1)
	(envelope-from <barak@port-kadr.cs.nuim.ie>)
	id 1xPHh5-0000000AgAP-0hsA;
	Fri, 06 Nov 2026 11:01:15 +0000
Date: Fri, 6 Nov 2026 11:01:15 +0000
From: Barak Pearlmutter <barak@cs.nuim.ie>
To: linux-bluetooth@vger.kernel.org
Subject: btrtl/btusb: RTL8761BU enters unrecoverable USB reset storm after
 autosuspend
Message-ID: <au2ze1UbFsDuQvVs@port-kadr.cs.nuim.ie>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reporting a bug where a Realtek RTL8761BU Bluetooth USB adapter enters an
infinite reset loop (~every 2 seconds) after coming out of USB autosuspend,
from which it cannot recover without a physical power cycle (unplugging
and replugging the dongle).

Device:
  Realtek Bluetooth 5.1 Radio
  USB ID: 0bda:a725 (RTL8761BU)
  Firmware: rtl_bt/rtl8761bu_fw.bin, version 0xdfc6d922
  Driver: btusb/btrtl (in-tree)
  Kernel: 7.2.15+deb14-amd64 (Debian 13 / linux-image-amd64)
  Note: this is a Debian-patched kernel; Debian-specific patches may be
  relevant, though the btusb/btrtl driver is unlikely to be heavily patched.
  USB autosuspend delay at time of failure: 2 seconds (default)

Failure sequence:

The adapter is idle (nothing paired/connected).  After ~2 seconds the
kernel autosuspends the USB device.  On the next activity, the firmware
fails to respond to register reads (-ETIMEDOUT / error -110):

  Bluetooth: hci0: command 0xfc61 tx timeout
  Bluetooth: hci0: RTL: Failed to generate devcoredump
  Bluetooth: hci0: Resetting usb device.
  Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)
  usb 3-3: reset full-speed USB device number 2 using xhci_hcd

This repeats every ~2 seconds indefinitely.  The driver's own USB reset
does not clear the firmware hang state.  Workarounds attempted without
success:

  - sudo usbreset 0bda:a725       (USB reset, same as driver does)
  - driver unbind/rebind           (echo "3-3" to unbind then bind)
  - deauthorize/reauthorize        (echo 0/1 to authorized)

None of these recover the device.  Only a physical unplug/replug works.

Secondary effect:

The BT reset storm generates substantial USB bus traffic on a shared
xhci_hcd controller.  On this machine a companion RTL8822BU WiFi adapter
(0bda:b812) on a different USB port begins emitting "failed to get tx
report from firmware" kernel messages within 21 seconds of the BT storm
starting, and the WiFi interface eventually deauthenticates (~20 minutes
later).  Fixing the BT autosuspend issue therefore also fixes spurious
WiFi failures.

Workaround:

Disabling USB autosuspend for the device via udev prevents the failure
from occurring in the first place:

  ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda",
    ATTRS{idProduct}=="a725", ATTR{power/autosuspend}="-1"

With this rule in place and the device freshly power-cycled the adapter
initialises cleanly and has remained stable.

Possibly related: Red Hat bug #2521504 describes an RTL8761BU (TP-Link
UB500, 2357:0604) entering an infinite USB reset loop, but with a
different error (0x200c timeout rather than "Read reg16 failed (-110)")
and reportedly fixed in kernel 7.1.13.  Our kernel is 7.2.15 and the
bug is present, suggesting this may be a distinct failure mode, or the
fix was not complete.

Log excerpt (storm onset):

  Nov 06 06:49:50 kernel: Bluetooth: hci0: command 0xfc61 tx timeout
  Nov 06 06:49:50 kernel: Bluetooth: hci0: RTL: Failed to generate devcoredump
  Nov 06 06:49:50 kernel: Bluetooth: hci0: Resetting usb device.
  Nov 06 06:49:50 kernel: Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)
  Nov 06 06:49:51 kernel: usb 3-3: reset full-speed USB device number 2 using xhci_hcd
  Nov 06 06:49:53 kernel: Bluetooth: hci0: command 0xfc61 tx timeout
  Nov 06 06:49:53 kernel: Bluetooth: hci0: RTL: Failed to generate devcoredump
  Nov 06 06:49:53 kernel: Bluetooth: hci0: Resetting usb device.
  Nov 06 06:49:53 kernel: Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)
  Nov 06 06:49:53 kernel: usb 3-3: reset full-speed USB device number 2 using xhci_hcd
  [continues every ~2 seconds for 20+ minutes until manual intervention]

Log excerpt (clean initialisation after power cycle, with autosuspend fix applied):

  kernel: usb 3-3: New USB device found, idVendor=0bda, idProduct=a725, bcdDevice= 2.00
  kernel: usb 3-3: Product: Bluetooth 5.1 Radio
  kernel: usb 3-3: Manufacturer: Realtek
  kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
  kernel: Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
  kernel: Bluetooth: hci0: RTL: fw version 0xdfc6d922
  kernel: Bluetooth: MGMT ver 1.23
  [no further errors]

Happy to test a patched kernel or provide further information.

Barak Pearlmutter <barak@cs.nuim.ie>
