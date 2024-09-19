Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E963B1B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766100; cv=none; b=hJ0Xlnh2aD9KesASbaee45h9tDkwqHLIL0KgCOlk8ZZxv6WPxRE4c5nRqPTI+jbRTNvpp9j3ubhjJgiUcrY+uFQskCTyy5Jo7di8R7MqPcA/wcVUMTSFyHF8Ac4fBBrW29hYWSodAfvIU9MNnUYtLVAMiAxwq/Tbn3REhSUk7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766100; c=relaxed/simple;
	bh=3RdIuSIR+XiLjtI6xOBczz9jzFTZ/YZNbmeNjcBCILo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ACZ2J+rT75eA4WWBls4pMAT1KrlK/VR1zAxF5sL3J4rwuC8UstjZAhpoUu46mV+0l5rZgu3mMjGW74gWN6G8M4Y8vBh1mj4Ju3+pVW8Wq/sYiZJqDND0A+IYaGGeyIQoyfT39QehT8TuDJW3vnsbHY2zHhzGvFIvgOKvl9BFOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FKgHJ4QN; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FKgHJ4QN"
Received: from github.com (hubbernetes-node-83815a0.ac4-iad.github.net [10.52.152.30])
	by smtp.github.com (Postfix) with ESMTPA id 8F00B700A09
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1726766098;
	bh=0bu203AyBkvJsnaPoH7qbu+e6aK1EpjByvKDrItLi2c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FKgHJ4QN8BIPcrp+DoP7rqb33CsDJsCItSHIlcW9QUhVM/RyA/B2iWbwDdbmrSsjw
	 9K8bGKHb+Vc6FlFah0Mc31qWkPgbeJynJ5XgE7RAK7kQGTglWdaZb4CoMphJizNWQO
	 SzP+m/3kuynibDA0vL+hx5ldyQJTT/VVcVvBf+4c=
Date: Thu, 19 Sep 2024 10:14:58 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7aa245-ce6462@github.com>
Subject: [bluez/bluez] 0ea4e4: doc: Remove Pygments dependency from manpage
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
  Commit: 0ea4e4d52c55daa1a032ae53805f8d256317bf49
      https://github.com/bluez/bluez/commit/0ea4e4d52c55daa1a032ae53805f8d256317bf49
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-18 (Wed, 18 Sep 2024)

  Changed paths:
    M doc/l2cap.rst
    M doc/rfcomm.rst

  Log Message:
  -----------
  doc: Remove Pygments dependency from manpage

This patch removes the Pygments dependency from l2cap/rfcomm.rst file.
When the code-block type is specified, the rst2man throws a warning
asking for Pygments package.

Fixes: https://github.com/bluez/bluez/issues/950


  Commit: b22859e3cc0b31959f76ec4f1682613f102e256b
      https://github.com/bluez/bluez/commit/b22859e3cc0b31959f76ec4f1682613f102e256b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-18 (Wed, 18 Sep 2024)

  Changed paths:
    M client/main.c
    M client/print.c
    M client/print.h

  Log Message:
  -----------
  client/print: Add decoding for UUID properties

This adds proper decoding for UUID properties with usage of
bt_uuidstr_to_str so it can print the 'friendly' name as bellow:

bluetoothctl# transport.show /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep4/fd0
Transport /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep4/fd0
	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
...


  Commit: 17f485f207e6fd6b8fad7b1d1f8a30087c72cf36
      https://github.com/bluez/bluez/commit/17f485f207e6fd6b8fad7b1d1f8a30087c72cf36
  Author: Vibhav Pant <vibhavp@gmail.com>
  Date:   2024-09-19 (Thu, 19 Sep 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Add support for the Connectable property.

To not break previous behavior, allow enabling the Discoverable
property even if Connectable is currently false.


  Commit: bf6bfc3356ef02af1eaa8248695e7e61635aff4b
      https://github.com/bluez/bluez/commit/bf6bfc3356ef02af1eaa8248695e7e61635aff4b
  Author: Vibhav Pant <vibhavp@gmail.com>
  Date:   2024-09-19 (Thu, 19 Sep 2024)

  Changed paths:
    M doc/org.bluez.Adapter.rst

  Log Message:
  -----------
  org.bluez.Adapter: Add documentation for the Connectable property.


  Commit: 84d0b5e2bb8424a203a46847671424b091594a24
      https://github.com/bluez/bluez/commit/84d0b5e2bb8424a203a46847671424b091594a24
  Author: Celeste Liu <coelacanthushex@gmail.com>
  Date:   2024-09-19 (Thu, 19 Sep 2024)

  Changed paths:
    A .b4-config

  Log Message:
  -----------
  contribution: add b4 config

Add b4[1] config so b4 user can contribute more smoothly, especially
send prefix.

[1]: https://github.com/mricon/b4


  Commit: cd1c6b666fa95555eeb3e43965c2b36106fa3694
      https://github.com/bluez/bluez/commit/cd1c6b666fa95555eeb3e43965c2b36106fa3694
  Author: Ismael Luceno <ismael@iodev.co.uk>
  Date:   2024-09-19 (Thu, 19 Sep 2024)

  Changed paths:
    M android/ipc-tester.c
    M android/system-emulator.c
    M android/tester-main.c
    M client/mgmt.c
    M emulator/serial.c
    M emulator/vhci.c
    M monitor/att.c
    M peripheral/efivars.c
    M profiles/audio/a2dp.c
    M src/adapter.c
    M src/device.c
    M src/gatt-database.c
    M src/main.c
    M src/rfkill.c
    M src/storage.c
    M src/textfile.c
    M tools/bluemoon.c
    M tools/hciattach.c
    M tools/hciattach_ath3k.c
    M tools/hciattach_intel.c
    M tools/hciattach_st.c
    M tools/hciattach_ti.c
    M tools/test-runner.c

  Log Message:
  -----------
  Fix missing inclusion of <limits.h>

Needed for PATH_MAX.


  Commit: 95eb34ee2ee2b7495d9b4f54cc63c0182f24e327
      https://github.com/bluez/bluez/commit/95eb34ee2ee2b7495d9b4f54cc63c0182f24e327
  Author: Vibhav Pant <vibhavp@gmail.com>
  Date:   2024-09-19 (Thu, 19 Sep 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Add method GetServiceRecords

GetServiceRecords returns all currently known BR/EDR service records
for the device, as an array of array of bytes. Each individual byte
array represents a raw SDP record, as defined by the Bluetooth Service
Discovery Protocol spec.
This method is intended to be only used by compatibility layers like
Wine, that need to provide access to raw SDP records to implement the
Win32 Bluetooth API. Applications should instead use the Profile API
for services-related functionality.


  Commit: 44a1930479b70d531b00b88a21a5b11cb732886f
      https://github.com/bluez/bluez/commit/44a1930479b70d531b00b88a21a5b11cb732886f
  Author: Vibhav Pant <vibhavp@gmail.com>
  Date:   2024-09-19 (Thu, 19 Sep 2024)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add documentation for GetServiceRecords()


  Commit: 7104f37735cd74ef57a4e18d61e6f55a99edd7a8
      https://github.com/bluez/bluez/commit/7104f37735cd74ef57a4e18d61e6f55a99edd7a8
  Author: Khem Raj <raj.khem@gmail.com>
  Date:   2024-09-19 (Thu, 19 Sep 2024)

  Changed paths:
    M Makefile.mesh
    M mesh/mesh-config-json.c
    R mesh/missing.h
    M mesh/rpl.c
    M mesh/util.c
    M mesh/util.h

  Log Message:
  -----------
  mesh: Move local basename into utility file

Defining an override via a missing.h can prove difficult when a file
needs to use basename and dirname both the APIs and needs to include
libgen.h for them, in such situations there will be signature clash
for basename function.


  Commit: ce6462eba2dbf310728a2ae6b10110032fb39285
      https://github.com/bluez/bluez/commit/ce6462eba2dbf310728a2ae6b10110032fb39285
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-19 (Thu, 19 Sep 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Set bap debug func at broadcast probe

When a Broadcast Sink acting as a Scan Delegator probes a Broadcaster with
the help of a Broadcast Assistant, a new BAP session is added for the
Broadcaster device before additional session information is initialized
(like the bt_bap session). This causes the bap debug func to not be set
in bap_data_add.

This commit adds an explicit call to set the function after the bt_bap
session is created.


Compare: https://github.com/bluez/bluez/compare/7aa245979db6...ce6462eba2db

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
