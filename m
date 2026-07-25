Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B72F8E85
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785011603; cv=none; b=MPjuWGzLC3+X7D0dnCOt6wdLKu7frmCq5NLmkw7USBvhvMH2s1ryEKnyBiCQbskM5eXTfSs5kR5yVs79bmTjtHDaLPCNpPhOxgTyrintlvKlelYNspS4S1CliIe9IEQ0soYkdt7hSIUrdBv79JsoK0GDyEXoX+2GVMiRM0k/bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785011603; c=relaxed/simple;
	bh=F/6mpGpccPSNaQK/lcdOEZnnhfCfI/mEq8kEKUm+0i8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JcytY245SP6yF/iKWAn7Uz+fOKiV5eE4EwklcnFo4BSnQ4P0pIZcW2obFDMOSXSl5lQBAnN4ZD037H6m2+LCrmWgwZhND01q4LNcKfiwFSSYy+YEa9rAklwinWB0RMyBhJYJwLq/kxOIM9/BMI4xTGr+rv2FRnz3WzbyiksagHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DcFk5AqC; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DcFk5AqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785011600;
	bh=sSCrtuVBgy7PPqmugGclhaK4KxRshUfJIcMch0tX654=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DcFk5AqCCiO8JpCui9i+gAuYTh1P0Z4dzAMn4DDB00MzAsrkkd17ISUy0gRdQWuV+
	 LgktgqTqpVLKDQnDSx9gJMC01CBmNSaP0OFLkoa8k13GaAMEi4/bl1E7hr3lDYl2hU
	 5FSc6nxEtNdy+o7tZBFK0xV5YJnR26Pm6By3CNQc=
Received: from github.com (hubbernetes-node-890be91.va3-iad.github.net [10.48.144.43])
	by smtp.github.com (Postfix) with ESMTPA id E4D69340E19
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 13:33:20 -0700 (PDT)
Date: Sat, 25 Jul 2026 13:33:20 -0700
From: Matthew Schwartz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1134469/000000-68cf12@github.com>
Subject: [bluez/bluez] 1a9634: adapter: Add btd_adapter_may_wake()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1134469
  Home:   https://github.com/bluez/bluez
  Commit: 1a96346c93b24fdc4c67a5dea420badbfd083736
      https://github.com/bluez/bluez/commit/1a96346c93b24fdc4c67a5dea420badbfd083736
  Author: Matthew Schwartz <matthew.schwartz@linux.dev>
  Date:   2026-07-25 (Sat, 25 Jul 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  adapter: Add btd_adapter_may_wake()

The kernel provides no interface for querying whether a controller is
currently configured to wake the host from suspend. hci_register_dev()
marks HCI_CONN_FLAG_REMOTE_WAKEUP as supported whenever a driver
provides a wakeup callback, and btusb always does, so the supported
flags reported through mgmt say nothing about the runtime setting. The
value that matters, device_may_wakeup() on the underlying USB device,
is only evaluated during the suspend flow, and the wakeup callback is
not a pure query (btmtksdio's variant sends vendor HCI commands), so
mgmt could not simply re-evaluate it on Get Device Flags without new
kernel infrastructure.

Add btd_adapter_may_wake(), which reconstructs what btusb reports by
walking the adapter's sysfs ancestry to the closest USB device and
reading its power/wakeup attribute. A missing attribute means the
device cannot generate wake events at all, which is what btusb
arranges for the fake CSR clones by clearing the USB device's wakeup
capability. The attribute is read per call so that each query
reflects the current setting.

Only USB is handled. Controllers on other buses keep the current
behavior. btmtksdio exposes the same attribute on its SDIO function
device, but its wakeup callback can also depend on a vendor command.

Assisted-by: Claude:claude-fable-5


  Commit: 31789e8ae046cb4673634c42d5a65e8f1d29e2e1
      https://github.com/bluez/bluez/commit/31789e8ae046cb4673634c42d5a65e8f1d29e2e1
  Author: Matthew Schwartz <matthew.schwartz@linux.dev>
  Date:   2026-07-25 (Sat, 25 Jul 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Hide WakeAllowed when adapter cannot wake

dev_property_wake_allowed_exist() only checks whether the device has a
profile that supports wake configuration (HID/HoG), so WakeAllowed is
exposed on every input device even when the host controller cannot or
will not wake the system.

Gate the property on btd_adapter_may_wake() as well. The remote
wakeup device flag itself remains settable through mgmt and is still
stored. The kernel independently ignores it during suspend when the
controller may not wake the host, and the stored preference reapplies
once wakeup is enabled again. No PropertiesChanged signal is emitted
when the sysfs attribute changes, so clients observe the state that
is current at the time they query the property.

Assisted-by: Claude:claude-fable-5


  Commit: 68cf12fa3ae5a8a3eafacbaa3381a4b9834478c8
      https://github.com/bluez/bluez/commit/68cf12fa3ae5a8a3eafacbaa3381a4b9834478c8
  Author: Matthew Schwartz <matthew.schwartz@linux.dev>
  Date:   2026-07-25 (Sat, 25 Jul 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc: Mark WakeAllowed as optional

WakeAllowed is only present on devices with a profile that supports
wake configuration, and now only when the adapter itself is able to
wake the host. Mark it optional like the other conditional Device1
properties and document when it is present.


Compare: https://github.com/bluez/bluez/compare/1a96346c93b2%5E...68cf12fa3ae5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
