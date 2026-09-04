Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BCC3546EB
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549994; cv=none; b=B3QF95Tj7HJEiMKU2mriNsYVTlv7SXEf31Ewh4i4JiQVkemsHnMFImZXsuSn3kf/Bfeq+RQtoCBIjgsZa1ZKVbdEdS25OscZ5M39dBmtoECsMjRze5CRvioaWlcnsCz8TmFcIIGtfrX2sWHbfJW2gauMr47MlWGChO2xytwc+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549994; c=relaxed/simple;
	bh=Damm1HKLQVD1f7gANXTYXT5LVAlvbmxLjUSZ320j5mg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IBFLitQuJl7qAAZrCqUh2qIMjnvAdxm89lxFf10+cjjuZrhFYfTLCjchbj4pVT0LNj86AkAf7SrLy5RFGsuerzQXhQO5P3Xn4jH4JLQwuN6O2zV+tiT5dKohRUduk4+LUf1ALyjqVVEOjXUkgf3TfMSdX607d4hP27d0EBIX850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=faJrDjjj; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="faJrDjjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788549991;
	bh=WVCqfHenvu3vj5rk5qKq7pTs1xtRGvW2fzfgsBg8scQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=faJrDjjjkrmebe1sMzI2R9hUVuIDaWCdZWEFBPUANFqRAcNxX74zKcUcgat4WNfFO
	 OH8d/d0mYHW7bV839lOximWEXo+ITR9op/DRzVTj0Kq4LM0LgYHbpY0JD+/EjpRzLm
	 iLHPsr6D22d8jCLlMZUd3pKrEGmCvLQ/+9ePp2jc=
Received: from github.com (hubbernetes-node-384b8b9.ac4-iad.github.net [10.52.86.26])
	by smtp.github.com (Postfix) with ESMTPA id B85014062A
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 12:26:31 -0700 (PDT)
Date: Fri, 04 Sep 2026 12:26:31 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ed3d4c-4b92dd@github.com>
Subject: [bluez/bluez] 5ef24e: test-runner: Add support for PCIe passthrough
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5ef24e77a6427499dc8fecb2ebe5495c0141e3b5
      https://github.com/bluez/bluez/commit/5ef24e77a6427499dc8fecb2ebe5495c0141e3b5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M doc/test-runner.rst
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add support for PCIe passthrough

Add a -P/--pcie option which passes the given QEMU device arguments
through to QEMU, in the same way -U/--usb does for USB devices, so a
host controller can be handed to the guest:

  $ tools/test-runner -P "vfio-pci,host=0000:00:14.3" \
        -d -k /pathto/bzImage -- /bin/bash

The device does not have to be prepared by hand: the BDF is taken from
the host= argument and bound to vfio-pci, and the driver it was bound to
before is restored once the guest exits. As VFIO can only pass through a
device if the rest of its IOMMU group is unbound or already handled by
VFIO, the group is checked before the device is taken away from its
driver, so a group that cannot be used is reported instead of leaving
the device behind on vfio-pci.

Restoring the driver means QEMU can no longer simply replace this
process, so with -P it is started as a child and SIGINT, SIGTERM and
SIGHUP are forwarded to it, leaving this process to restore the driver
once QEMU is reaped.

Since vfio-pci requires ACPI for device enumeration and an APIC for MSI
delivery, the guest command line drops "acpi=off pci=noacpi noapic" when
-P is given. All other modes keep the previous command line and are
still exec'ed directly.

Tested by passing a PCIe card reader through to the guest, checking that
it is bound to vfio-pci while the guest runs and bound back to its own
driver afterwards.

The model drafted the option handling, the vfio binding, the command
line change and the documentation section; all of it was reviewed and
tested by the author.

Assisted-by: Claude:claude-opus-5


  Commit: 24a46bbd3b78e287ac1d49a26859d7c5e1872d12
      https://github.com/bluez/bluez/commit/24a46bbd3b78e287ac1d49a26859d7c5e1872d12
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M Makefile.tools
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add latency standard deviation

The latency range and moving average alone do not tell a link that is
consistently slow apart from one that is unstable. A high average with a
low deviation points at the scheduling or the interval configuration,
while a low average with a high deviation points at interference,
retransmissions or controller buffer stalls.

Track the sample count along with the sum and the sum of the squares in
struct packet_latency, and report the resulting standard deviation on
the latency lines of both the live decoding and the analyze mode.

The samples are squared in usec and only scaled down to msec^2
afterwards, so that the sub-msec resolution is not lost while the
running sum stays clear of an overflow.

The model derived the accumulator layout and the scaling, which the
author reviewed and verified against an independently computed
deviation.

Assisted-by: opencode:claude-opus-5


  Commit: 7bcf6c42721e91c387fdf15639f0a0185f563fc7
      https://github.com/bluez/bluez/commit/7bcf6c42721e91c387fdf15639f0a0185f563fc7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add ISO packet loss counters

Isochronous streams are the one place where HCI hands the host enough
information to tell whether data actually arrived: the ISO data packet
header carries an SDU sequence number and a packet status flag.

Track both per connection and report them during the live decoding and
in the analyze mode. Gaps in the sequence number are counted as lost
SDUs, a packet status flag of 2 is counted as dropped and a flag of 1 as
possibly invalid. Duplicates and reordered sequence numbers are not
counted as loss.

During the live decoding the counters are only printed on the packet
where a discontinuity is detected, so a clean stream produces no extra
output.

The model wrote the sequence number accounting and the ISO header
walking, which the author reviewed and verified against a trace with
known gaps.

Assisted-by: opencode:claude-opus-5


  Commit: 4b92dddc8e540649304db38c37a369117c99762b
      https://github.com/bluez/bluez/commit/4b92dddc8e540649304db38c37a369117c99762b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document the deviation and loss counters

Describe how to read the latency standard deviation and each of the ISO
packet loss counters, and correct the description of the moving average,
which was documented as a median even though it has always been computed
as a moving average.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/ed3d4c3f91b2...4b92dddc8e54

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
