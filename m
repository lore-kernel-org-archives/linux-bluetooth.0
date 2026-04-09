Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29691F91D6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764986; cv=none; b=NEkhNGWE/fbjmdlNO/3/9HMNBjqp9IvyveRwQ/RdaMsvFQPyJefVBi55JK/+QhMvyihBK0+ncUUWFAaVBeN9RjdIRIK3YWbx+LOz8ZkA4eEJsLl/QWa4qyZyuK+CPCVSgaTiM0KEPy4dTysObahCJptjGRqL7b3Od2hcuaIT3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764986; c=relaxed/simple;
	bh=fwQMI4GsDtWMT2GpiWOdh2qMbfQCTGRFxv0Zn28Y+rc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VOonOnjUnlomQCzvycVEF6s1f9ymUtdr5IZefR3IuSNKUmjOSnrOe9av/d61JyE5Jw94zli8ifpg2amRgR2PzR0jreqfh8zFXNKJ3GcUkuSpRrrWOfIGkwq2GPLJf/Zox8LTngPopnknWmA+1nQwSt4G2uaw2hfKwftX3N/F4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UekJdYhv; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UekJdYhv"
Received: from github.com (hubbernetes-node-873c785.va3-iad.github.net [10.48.142.39])
	by smtp.github.com (Postfix) with ESMTPA id 0BA1D4E06AD
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775764984;
	bh=a0ztasdWAyRwuQ/5cAHXnfxTC1Bl323Zhd8sV2ibLoE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UekJdYhvPCQv4R0ASiMJ4BZ6xKaW8RHrLsFys7XqwcatF97FCV94SXmISKK63M7bP
	 9Ze2X+iOsaAD3C6xrfEqk5AS1m3ds7nA71zdysSA+uTsztHV1idMcq1P2SqOcu6+Dw
	 8+ocNWYJ1/sWq2q2CzGnui5wP+WpiWrgRNI++yFg=
Date: Thu, 09 Apr 2026 13:03:04 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a73fcb-516099@github.com>
Subject: [bluez/bluez] 418306: device: Fix btd_device_connect_services not
 discov...
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
  Commit: 418306daec600cdb20afec5763a2a1f2f29f1616
      https://github.com/bluez/bluez/commit/418306daec600cdb20afec5763a2a1f2f29f1616
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-07 (Tue, 07 Apr 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c

  Log Message:
  -----------
  device: Fix btd_device_connect_services not discovering

btd_device_connect_services would not attempt to discover in case the
selected bearer is BR/EDR and once discover is complete then it shall
proceed with connecting the services.


  Commit: c8527a27723baa4acbeaba59e60fd6e28a63425e
      https://github.com/bluez/bluez/commit/c8527a27723baa4acbeaba59e60fd6e28a63425e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-07 (Tue, 07 Apr 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Prompt user to start scanning on connect command

If connect command don't find the device object make it prompt the
user to start scanning and set discovery filter pattern to given
address and mark it to auto-connect:

[bluetoothctl]> connect XX:XX:XX:XX:XX:XX
Device XX:XX:XX:XX:XX:XX not available
[XX:XX:XX:XX:XX:XX] Scan and connect (yes,no): y
SetDiscoveryFilter success
Discovery started
[NEW] Device XX:XX:XX:XX:XX:XX
[NEW] BREDR /org/bluez/hci0/dev_XX:XX:XX:XX:XX:XX
[CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
[CHG] BREDR XX:XX:XX:XX:XX:XX Connected: yes


  Commit: 44e54e39ae1ac0f95c61e7c0b923bd8a0c163f4c
      https://github.com/bluez/bluez/commit/44e54e39ae1ac0f95c61e7c0b923bd8a0c163f4c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Stop discovery when connected with filter.auto_connect

If device was connected via filter.auto_connect method (e.g. connect or
scan.auto_connect) stop the discovery session after the device connects.


  Commit: 950853f328610ccc20332f1175413935f8de1aef
      https://github.com/bluez/bluez/commit/950853f328610ccc20332f1175413935f8de1aef
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

  Changed paths:
    M src/shared/gatt-server.c
    M src/shared/gatt-server.h

  Log Message:
  -----------
  shared/gatt-server: Add bt_gatt_server_set_permissions

This adds bt_gatt_server_set_permissions which can be used to
enabled/disable permission checking before operations which can be
useful on testing only environment where encryption/pairing is not
desirable/needed.


  Commit: 516099a9d40515e8cead446634bc25270152f5b0
      https://github.com/bluez/bluez/commit/516099a9d40515e8cead446634bc25270152f5b0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

  Changed paths:
    M src/btd.h
    M src/device.c
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add GATT.Security option

This adds GATT.Security option which by default is set to auto to
detect if encryption/authentication is required on demand, but if
Testing is set enables the user to enter a desirable security level.

In case the security level is low it then proceeds to disable checking
GATT attribute permissions for server operations.


Compare: https://github.com/bluez/bluez/compare/a73fcbf207d3...516099a9d405

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
