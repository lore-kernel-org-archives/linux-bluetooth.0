Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B829C35A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043429; cv=none; b=Ur+szmLYYSfuUVnGE+5BGpC9OdQazts9elGB8ANBNNRCTbmNWGDoYZs5FKF6kVsDWgd/hFR9UmBP0a2W3J/KONRXY7I5zMwWF/FC8TLZpCff+V0yvrxP8zwpGF2WIUXE3WFz2ZMY2lyhqKr5euVslQfKgwjc6CPlJlyQhD7tc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043429; c=relaxed/simple;
	bh=hYqwIhVwZUgNe7MCdsAckeKnDmFlf7Xg+Cn5RaqHpq4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IT742B4yAbT2Y44CtP9+WhFdGUVEyC9TJ+1uL+fsB+EoW2MKRgkGAPdMgCYWHCf0ooZaRHbuyAbXe5gIPHMFXcKm+Q9ApbyhBKbs5Ek/6NuePIYw++e+9LBw/T8IPvCsxB3WbUgJmnd481cVOz0bhM4GokCpx2NdIxpNZ5IS+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WItfmTsc; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WItfmTsc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777043427;
	bh=yWYF0ehBgutJvoRlqxyCNGK+lF1lEHwhDq5iOXJCGQg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WItfmTsca/S3ANTx2Lop9lHk+O6tvuSPBsKYvfMLnWXu5k4xGxtVtc4Kds5tZkHtE
	 Q47g+ZkVg3efKFZW4YOU+AJ5SjXm7d5Jfk0hghYC3fBwYH5OS9ZDDy6H7Jh/x1MX2h
	 c9Eo1/JFuJw0WTGHCGefJsaGZWjmDO2waJzMYSUI=
Received: from github.com (hubbernetes-node-9dea707.va3-iad.github.net [10.48.124.34])
	by smtp.github.com (Postfix) with ESMTPA id 869E334114C
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 08:10:27 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:10:27 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bc87ee-83ddf4@github.com>
Subject: [bluez/bluez] 756da3: input: Fix checking LE bonding on HIDP
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
  Commit: 756da3fa17b9a892ce22bc340b9a293a6c68931f
      https://github.com/bluez/bluez/commit/756da3fa17b9a892ce22bc340b9a293a6c68931f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Fix checking LE bonding on HIDP

HIDP is classic only, LE uses HOG, so there is no point in checking the
bonding with the address type which in case the device supports
dual-mode will map to LE random/public address.

Fixes: https://github.com/bluez/bluez/issues/2034


  Commit: aca0a01c3f5e73e4ab44b186b6a0a00c589be87c
      https://github.com/bluez/bluez/commit/aca0a01c3f5e73e4ab44b186b6a0a00c589be87c
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M src/shared/hci.c
    M src/shared/hci.h
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: Introduce Channel Sounding HCI raw interface support

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP


  Commit: c34ed95fa59b4a61882794f329f74a32a5b1f949
      https://github.com/bluez/bluez/commit/c34ed95fa59b4a61882794f329f74a32a5b1f949
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M src/bluetooth.service.in
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add Channel Sounding config parsing support

Add support for parsing Channel Sounding (CS) configuration options
from the configuration file.

Add CAP_NET_RAW to CapabilityBoundingSet in bluetooth.service.
bluetoothd requires CAP_NET_RAW to receive and process HCI LE events
when running under a constrained systemd capability bounding set


  Commit: f1363b27467197525f60f3bbbf43ad1d905719af
      https://github.com/bluez/bluez/commit/f1363b27467197525f60f3bbbf43ad1d905719af
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M Makefile.plugins
    M profiles/ranging/rap.c
    A profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: ranging: Add HCI LE Event Handling in Reflector role

Open RAW HCI Channel for CS Event Handling
Parse the following HCI LE CS Events in reflector role
and route the events to RAP Profile.
 1. HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE
 2. HCI_EVT_LE_CS_CONFIG_COMPLETE
 3. HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE
 4. HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE
 5. HCI_EVT_LE_CS_SUBEVENT_RESULT
 6. HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE
Send HCI_OP_LE_CS_SET_DEFAULT_SETTINGS to the controller
with default settings selected by the user.
Map connection handle received to device connection


  Commit: 6cbdfc70601364435b97276ba9a4feac6179a1ff
      https://github.com/bluez/bluez/commit/6cbdfc70601364435b97276ba9a4feac6179a1ff
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  rap: Cleanup coding style and unnecessary code


  Commit: 49e2a15adc79eeb082d6eb52fc5ba7c2cf94c20c
      https://github.com/bluez/bluez/commit/49e2a15adc79eeb082d6eb52fc5ba7c2cf94c20c
  Author: Marek Czerski <ma.czerski@gmail.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  sixaxis: Fix pairing Esperanza EGG109k controller

This change is required for Esperanza EGG109k ps controller clone.
EGG109k looks like PS3 controller but presents itself to the system
as PS4 controller. It does not respond to 0x81 command.
Command 0x12 contains both the device bluetooth address as well as
configured host bluetooth address, so it can be used to query
both. Kernel driver hid-playstation also uses 0x12 command for that.

Manufacturer link:
https://esperanza.pl/esperanza-gamepad-bezprzewodowy-ps3-marine-czarny,176,1701.html


  Commit: 83ddf46ccc0653fb2aa460b57eb60db92ab37597
      https://github.com/bluez/bluez/commit/83ddf46ccc0653fb2aa460b57eb60db92ab37597
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-24 (Fri, 24 Apr 2026)

  Changed paths:
    M src/shared/gatt-db.c
    M src/shared/gatt-db.h

  Log Message:
  -----------
  src/shared: add custom CCC callbacks

Introduce custom CCC callbacks to allow interception of
client notification subscription changes. This enables
stack-level handling of CCC writes.


Compare: https://github.com/bluez/bluez/compare/bc87ee6b0c56...83ddf46ccc06

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
