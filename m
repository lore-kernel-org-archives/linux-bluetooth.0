Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574036A35A;
	Thu, 10 Sep 2026 02:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006936; cv=none; b=cjYnLniwXxCXFWjAZU55bSAKyxyvS279Svkc7w4cpTnFBwURsb4gOizUdTu/DRiNuaUMeF3aZvjw2uXt+5oyDDWRC6Cr6gzFSUD1liYsE7790t3IfRiqsKh6SIjbd9fUBf8MmMBme1mheSyz4B1tFToGvcLck9uKRHZubBKdf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006936; c=relaxed/simple;
	bh=x4/XsLtg3dBCRnGLpnAha2EZXSvPlasziDAu2BB/s4Q=;
	h=Message-ID:MIME-Version:To:Cc:From:Subject:Content-Type:Date; b=ArkV6yWLa+v9IpoSuY/ARNjAQ6gVhjSTUy9jCe4HgiCYtToWzkuSgprl2TpTWiWDVNBA+GPEzUHHx2nYvfiXAeWucJgpJNAFan2jW642G6AuUI0PoOUcTLZGfKVJz5Bkk2pC/iy0+/GlJODKkNZbUVB8Pn2V5YWg7jTqjb8coeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=batcode.io; spf=pass smtp.mailfrom=batcode.io; dkim=pass (2048-bit key) header.d=batcode.io header.i=@batcode.io header.b=h1q2q9ZT; arc=none smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=batcode.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=batcode.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batcode.io header.i=@batcode.io header.b="h1q2q9ZT"
X-Sender-Id: hostingeremail|x-authuser|douglas@batcode.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 08260401F48;
	Thu, 10 Sep 2026 02:10:22 +0000 (UTC)
Received: from de-fra-smtpout6.hostinger.io (100-96-173-63.trex-nlb.outbound.svc.cluster.local [100.96.173.63])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1E98A40235D;
	Thu, 10 Sep 2026 02:10:20 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|douglas@batcode.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|douglas@batcode.io
X-MailChannels-Auth-Id: hostingeremail
X-Befitting-Exultant: 3d479abd7f979d61_1789006221681_1435759830
X-MC-Loop-Signature: 1789006221681:2207788445
X-MC-Ingress-Time: 1789006221680
Received: from de-fra-smtpout6.hostinger.io (de-fra-smtpout6.hostinger.io
 [148.222.55.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.173.63 (trex/8.0.2);
	Thu, 10 Sep 2026 02:10:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=batcode.io;
	s=hostingermail-a; t=1789006219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x4/XsLtg3dBCRnGLpnAha2EZXSvPlasziDAu2BB/s4Q=;
	b=h1q2q9ZTdfKm0R2d794l1aTGzpQ2YcgS45C1P0WikBY7r5jGSLty5cB0EabnTGbOGZ3mSR
	r1/aBP2MFZoCd9Sh7Khrztef3+D7S/wmsGwhuxvBJdS/xBOnnZfMsEfmyXhqrRQNlnr3Gf
	LIkGLK4TivrFJhMfNzu6QAH1zTi/NDPl2VTcysZj23pv/UpStlCfUNNuzfbE+CIrfLrPsS
	Oa6BBKZVM/m0mx3+bs3pCeQhabXMiMtFXXkMRiNIqSJRJISIGq+ohmcUXu8kEvrRAgxF3Z
	hdVXYkY2DRflATGgKcXaSPBbKZgepV9jWX7VuOZQ7CeG7eVMPNe3pMYwuYfhHg==
Received: from [IPV6:2804:7f0:b101:870f:93b8:2e99:e7c0:2c71] (unknown [IPv6:2804:7f0:b101:870f:93b8:2e99:e7c0:2c71])
	(Authenticated sender: douglas@batcode.io)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4hgLjk68Gjz44bS;
	Thu, 10 Sep 2026 02:10:18 +0000 (UTC)
Message-ID: <6a87fe0d-6a58-4e85-830d-ffbf7fe84c8c@batcode.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, pt-BR
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Douglas Santos <douglas@batcode.io>
Subject: Subject: [BUG] Bluetooth: btusb: unbounded firmware retry loop wedges
 MT6639
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 10 Sep 2026 02:10:18 +0000 (UTC)
X-CM-Envelope: MS4xfOPV16/PCjS9RVZt2ywpJMXzoP6oL7CklCubhdJD8yYR/htxU1MPRZxLg57nauG05qt/TLngywAzxJNNGJ/7MvFLKNd8vK1tsBixmRAf4HWJMw6RTm/j CaMTs1PTt9VJDUJK9dfg3ccvxHvVQW0+VYU4rwbTiFv5C0KDjfR5MAmXHyqwpaQowP73fTVzmtF89w3YXgBpTlHVesYqRi+FkjlCMjbs84e575tqwcZyKRS2 2MPiH6O+jo8h99ZQUTckNhOk6UkM2br2ArZA0H8/or1AsTjhLx8kWuUFGoeajaaUN3cKWc3FOkwtTr2hgZA7iCccgKn4jwNgv9mNIQLN7kiHyrParbUxLWIi MvnXflAZ
X-CM-Analysis: v=2.4 cv=etGNzZpX c=1 sm=1 tr=0 ts=6aa2118b a=dMjScEcvWitagQ6r3Lgs9A==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dtVPPefSXg_n69G0GmsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-AuthUser: douglas@batcode.io

Hi,

When the MediaTek MT6639 firmware file is missing, btusb retries the
firmware setup indefinitely, USB-resetting the device on every attempt.
The retries never succeed, and after a few hundred of them the controller
firmware wedges into a state that survives reboots and requires cutting
standby power to clear.

The missing file is a packaging matter and not the subject of this report.
The problem is that a permanent, non-recoverable error is retried without
a limit, and that the retries actively damage the device state.

Hardware and system
-------------------

   Board:      ASUS ProArt X870E-Creator WiFi rev 2
   Bluetooth:  MediaTek MT6639, USB 0489:e13a
   Kernel:     7.2.3 (Fedora 44)
   Firmware:   mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin, absent

The Wi-Fi side of the same chip (mt7925e) is unaffected and works
throughout, since its firmware is present in linux-firmware.

Observed behaviour
------------------

On a clean cold start the controller enumerates normally.  btusb binds,
creates hci0, requests the firmware, and gets -ENOENT:

[    3.068951] usb 1-6: New USB device found, idVendor=0489, idProduct=e13a
[    8.221018] usbcore: registered new interface driver btusb
[    8.233139] Bluetooth: hci0: Failed to load firmware file (-2)
[    8.233145] Bluetooth: hci0: Failed to set up firmware (-2)
[    8.564037] usb 1-6: reset high-speed USB device number 4 using xhci_hcd
[    8.817354] Bluetooth: hci0: Failed to load firmware file (-2)
[    9.147127] usb 1-6: reset high-speed USB device number 4 using xhci_hcd
[    9.402354] Bluetooth: hci0: Failed to load firmware file (-2)
[    9.727020] usb 1-6: reset high-speed USB device number 4 using xhci_hcd

This repeats roughly every 0.58 s and does not stop.  Two boots were
captured in full; USB resets and firmware failures correlate exactly:

   boot A:   398 resets,   398 firmware failures
   boot B:  1335 resets,  1335 firmware failures

In boot B the loop ran for 780 s, until the machine was shut down.

After enough resets the controller stops responding to USB entirely.  On
every subsequent boot the port detects the device electrically but never
completes enumeration:

   usb 1-6: device descriptor read/64, error -110
   usb usb1-port6: attempt power cycle
   usb 1-6: Device not responding to setup address.
   usb 1-6: device not accepting address 7, error -71
   usb usb1-port6: unable to enumerate USB device

This state persists across reboots because the controller keeps standby
power.  Only removing power clears it.  In the captured journal the
device stayed dead for five consecutive boots after one such loop, and
the cycle repeated a second time after power was cut and restored.

Secondary effect: systemd-udev-settle.service sits on the boot critical
path, and the failed enumeration retries hold it.  Measured on the same
machine, udev-settle takes 8.6-9.7 s when the device is absent and 67.8 s
when it is wedged, adding roughly 59 s to boot.

Reproducer
----------

Note that running this to completion wedges the controller and requires
a power cut to recover.

   1. Take a machine with an MT6639 Bluetooth controller (0489:e13a, or
      13d3:3588 on other boards) and a kernel with btmtk MT6639 support.
   2. Ensure the firmware is absent from every search path.  On a stock
      distribution it already is:

        find /usr/lib/firmware /lib/firmware -name 'BT_RAM_CODE_MT6639*'

   3. Cold boot.  If the controller is already wedged, remove power first.
   4. Watch the counters climb together and never stop:

        journalctl -k -b 0 | grep -c 'reset high-speed USB device'
        journalctl -k -b 0 | grep -c 'Failed to load firmware file'

   5. Power off, cold boot again.  The device no longer enumerates.

Suggested direction
-------------------

request_firmware() returning -ENOENT is not a transient condition: the
file will still be missing on the next attempt.  Retrying it without a
bound cannot succeed, and here it drives the hardware into a state the
user cannot recover in software.

Bounding the retries, backing off, or not retrying at all when setup
failed with -ENOENT and the previous attempt failed the same way, would
reduce this to a single log line reporting the missing firmware, instead
of an unusable controller.

I did not send a patch because I am not sure at which layer the fix
belongs -- the retry appears to be driven from the btusb probe/setup
path rather than from btmtk itself -- and I would rather follow the
maintainers' preference on that.

Happy to test patches on this hardware.

Thanks,
Douglas Santos

