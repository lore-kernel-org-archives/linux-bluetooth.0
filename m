Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75913FD72
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037941; cv=none; b=eNbTRh/c9owXVDHY9iKiOmZXpxSjUuWVvVsiaTN+V5tErpzsHIdyYPJP3jJBcI2nWJ2Gx7kJrdBqmCxtW1RoKbDxsO3xwCrwd9+cVT464BNsFDWz4zcPV/8vdQWl8rAeQp0Txp9okLpCsXdolbhLnaeHdSZKfcxXbOjSw0gJb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037941; c=relaxed/simple;
	bh=l6LQF6IgRoySvyY4xlIC+NZv4S3Kw5thxPT7/hUoChE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DHkd5BTqh7TBfrLbkMKb+p0oCVQTP17qkTYAhXvEoqtJ8YVPhG24mnz2tL9keJKiMvp8LP5zXIaI1cLo1BJcpSLdoXoWIS2XyGQjrCxjDPzaUhUn6JeQIdqzuU+l+phT28YvGxNkV5gVRcBF9uHN0iG7AKJv80aTpgLVQvlsvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BIh612Zr; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BIh612Zr"
Received: from github.com (hubbernetes-node-0243b98.va3-iad.github.net [10.48.131.41])
	by smtp.github.com (Postfix) with ESMTPA id 709A24E0978
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 13:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1734037939;
	bh=cNnOkEP8OlFGTgdL9FN4qYLWFK8wG0KVarRaeWLAXPI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BIh612Zr1wrA2cC0UizTCmsBdEXinU/OxIjTxBv1C1Kjt3VemHxazWt4qeKcu9W9U
	 oD/tjRGtPe7/922MllTksjSNflTIyfqkX15Jm0Qlb+EtoVbCmJBFjweHH3Edpv7Nit
	 5ozi3bobN+in2iPito/NWkh9vM96gF4KCcc/ZvEw=
Date: Thu, 12 Dec 2024 13:12:19 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/40e5eb-92f3a3@github.com>
Subject: [bluez/bluez] c9d70c: main.conf: Add LE.CentralAddressResolution
 option
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
  Commit: c9d70ca65f9ad84740d5ba0d3447ddc682a18ab7
      https://github.com/bluez/bluez/commit/c9d70ca65f9ad84740d5ba0d3447ddc682a18ab7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-12 (Thu, 12 Dec 2024)

  Changed paths:
    M lib/mgmt.h
    M src/adapter.c
    M src/btd.h
    M src/device.c
    M src/device.h
    M src/gatt-database.c
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add LE.CentralAddressResolution option

This adds CentralAddressResolution option to LE group which controls the
GATT attribute of the same name using the new MGMT Device Flag with the
fallback to LL Privacy experimental UUID.

Fixes: https://github.com/bluez/bluez/issues/1028


  Commit: 7e0fe7d5c143052613b27ec3986b70e65ff88ac4
      https://github.com/bluez/bluez/commit/7e0fe7d5c143052613b27ec3986b70e65ff88ac4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-12 (Thu, 12 Dec 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for Address Resoluton flag

This adds proper decoding for Address Resolution flag.


  Commit: 92f3a3b108c22e3395c9dab0acefdfb894404cfe
      https://github.com/bluez/bluez/commit/92f3a3b108c22e3395c9dab0acefdfb894404cfe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-12 (Thu, 12 Dec 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix LL Privacy tests

Now that LL Privacy is triggered via Set Device Flags tests that used
the Set Experimental features needs to be fixed so they work as
intended.


Compare: https://github.com/bluez/bluez/compare/40e5ebd0cb2c...92f3a3b108c2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
