Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3B1C291
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258986; cv=none; b=sV/19cpYabN8tK70/SVCmGszIiTB+/8WBdz4ROhdvbJFqUM3pyfnOdaGsOGxFne50BDGtG9XENMkbw+e9on83FSJM+e4REWJbzihS/6DSF0CYWatD9bJpbZy/rDq6tvL4WMEhxWqnWJL8CtasD21jg6cART+RqQ10nEQLVqOMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258986; c=relaxed/simple;
	bh=8b9+uapxfH7dPsVQuxwpzm8LONeZiIAVj1XjNyHvbwY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EPFTbias5BNbeT0TA2dn2L16muwIzg0eWib1aAN1vWyIgmznr0c2UNxIs5bVYWGpMS+WjirW1B2Yihs/zxY5YoOM1/VynqkMX6TcYg9v2zkDJGajyI3qRh4uGP1pRlLGPTxYGAfrxWUeyCRt6EOsLIwFtWnEu31bpA1RLx7/Gdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fi74VCi4; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fi74VCi4"
Received: from github.com (hubbernetes-node-c64fbb9.ash1-iad.github.net [10.56.207.102])
	by smtp.github.com (Postfix) with ESMTPA id E648A1004E5
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 14:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1707258983;
	bh=/LCveJmwx7KO9E7E3Jz/wJ1xPladfRe/yQ8oYtkpe7M=;
	h=Date:From:To:Subject:From;
	b=fi74VCi48xYYyrO2vLRZuJLzcM1/MXJWPOE+Oh6+a8CoVe4RJUSp4PfToNOBrF8WU
	 qaC00v9rdpeqKb4fvMu4YMZ/EaAOVW0XsErSiBW/6PFUCbuhRwLraPJTlXRd0G5pBO
	 s3MXULCrmiRZPclnMi29//pEYRgZR4ErnzcK1Kl0=
Date: Tue, 06 Feb 2024 14:36:23 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/de8c24-cfbaa6@github.com>
Subject: [bluez/bluez] 141513: mgmt-tester: Add a 0-entry to expect_hci_list
 lists
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
  Commit: 141513cd0229ef47cc96031666eb758b1824f43f
      https://github.com/bluez/bluez/commit/141513cd0229ef47cc96031666eb7=
58b1824f43f
  Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
  Date:   2024-02-06 (Tue, 06 Feb 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add a 0-entry to expect_hci_list lists

In add_expect_hci_list() we iterate through the entries of the
expect_hci_list as long as there is an opcode, which means currently
this relies on overflowing the buffer to detect the end of the list.

This is not great and when running with address sanitizer, the
out-of-bounds read gets detected and mgmt-tester aborts. Fix it by
adding a trailing zero-entry to all those lists.


  Commit: 6a264df7200b3350712decf5d09d7bcef7a50fc2
      https://github.com/bluez/bluez/commit/6a264df7200b3350712decf5d09d7=
bcef7a50fc2
  Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
  Date:   2024-02-06 (Tue, 06 Feb 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Adjust a test for recent kernel changes

With the changes in the kernel to move to hci_sync for connecting ACL
devices (see kernel commit "Bluetooth: hci_conn: Only do ACL connections
sequentially"), the "ETIMEDOUT" error path for the "HCI Create
Connection" command was changed, sending a "HCI Create Connection
Cancel" command after the timeout.

This leads to the returned error in the "Pair Device - Power off 1"
test to change from NOT_POWERED to DISCONNECTED, so adjust for that.


  Commit: d5c1c0e80f4ac26edd29e45ea3c8a4679a5eab60
      https://github.com/bluez/bluez/commit/d5c1c0e80f4ac26edd29e45ea3c8a=
4679a5eab60
  Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
  Date:   2024-02-06 (Tue, 06 Feb 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator/btdev: Send page timeout after 5.12 secs delay

Real bluetooth adapters wouldn't send the page timeout immediately
when trying to page a device, instead it would take a few seconds.

Try to behave more realistically in the emulator and send the page
timeout after 5.12 seconds, which is the default page timeout.


  Commit: c3613b8a933d62bef10a8f4258976c41156e095f
      https://github.com/bluez/bluez/commit/c3613b8a933d62bef10a8f4258976=
c41156e095f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-02-06 (Tue, 06 Feb 2024)

  Changed paths:
    M monitor/a2dp.c

  Log Message:
  -----------
  monitor: parse Google's Opus A2DP vendor codec capabilities

Support parsing Opus (Google) A2DP vendor codec capabilities.
AOSP & Google Pixel Buds Pro has this implemented.

> ACL Data RX: Handle 256 flags 0x02 dlen 21       #419 [hci0] 26.905032
      Channel: 65 len 17 [PSM 25 mode Basic (0x00)] {chan 4}
      AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00=
 label 3 nosp 0
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: Non-A2DP (0xff)
            Vendor ID: Google (0x000000e0)
            Vendor Specific Codec ID: Opus (Google) (0x0001)
              Frequency: 0x80
                48000
              Frame Duration: 0x18
                10 ms
                20 ms
              Channel Mode: 0x07
                Mono
                Stereo
                Dual Mono
              Reserved: 0x60
        Service Category: Delay Reporting (0x08)


  Commit: 1c60eb02e6c3d0e639d8edb82c251caef2e41f9a
      https://github.com/bluez/bluez/commit/1c60eb02e6c3d0e639d8edb82c251=
caef2e41f9a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-02-06 (Tue, 06 Feb 2024)

  Changed paths:
    M client/player.c
    M profiles/audio/a2dp-codecs.h

  Log Message:
  -----------
  client/player: parse Google's Opus A2DP vendor codec capabilities

Support parsing Opus (Google) A2DP vendor codec capabilities.

Transport /org/bluez/hci0/dev_B8_7B_D4_32_44_15/sep3/fd2
        UUID: 0000110a-0000-1000-8000-00805f9b34fb
        Codec: 0xff (255)
        Media Codec: Vendor Specific A2DP Codec
        Vendor ID 0x000000e0
        Vendor Specific Codec ID 0x0001
        Vendor Specific Data: 0x92
                Vendor Specific Value (Opus [Google])
                Frequencies: 48kHz
                Channel modes: Stereo
                Frame durations: 20 ms
        Device: /org/bluez/hci0/dev_B8_7B_D4_32_44_15
        State: idle
        Delay: 0x0898 (2200)
        Volume: 0x001e (30)
        Endpoint: /org/bluez/hci0/dev_B8_7B_D4_32_44_15/sep3


  Commit: cfbaa68e5134e636ca3f3c095bb2d86d1dc6401a
      https://github.com/bluez/bluez/commit/cfbaa68e5134e636ca3f3c095bb2d=
86d1dc6401a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-06 (Tue, 06 Feb 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix Read Ext Controller Info tests

This fixes Read Ext Controller Info now that BT_HS has been removed.


Compare: https://github.com/bluez/bluez/compare/de8c249f785d...cfbaa68e51=
34
