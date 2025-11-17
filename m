Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202325A62E
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397969; cv=none; b=epATaVwIW/C5pGiOkIEjkvAJDDrv+xsiVCOoj1xq+o13Knz3vGVHgcKqhxHXwnbmgRw+eSuMmg9HgkvOmH8Q62TT8tzywLFu9qDjrs9RTuaXOcQp6P2sOR54deaZOqO1sagyRZ09+LX1rIzpzyJ74yU80dbn9lG/We4GLwVYxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397969; c=relaxed/simple;
	bh=d/2OdfXMHCDlmY8WTWzdtkAQCz0Le8eTCVxSNDsZr9I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MCwvcmS5ehbQ0WvPLCDAXbhzwLxXS3o7fQU64mzOwZQJ0Yd5qIMsPESOGrOPiEFNiWVUVr2yUxGswuYiQJdgm7Rak9Jsi2QO18gA40cBJCujQv8zUk19Cy5LcaV80ISAXUmNJt2KTdif3zIpXivXYiMggm/L33E/ECfiz7kK1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KxV9Pxup; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KxV9Pxup"
Received: from github.com (hubbernetes-node-c64f7f6.ac4-iad.github.net [10.52.183.52])
	by smtp.github.com (Postfix) with ESMTPA id B7A334011B2
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 08:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763397965;
	bh=N0AOYH2cfUUd51EnoSwzp3OYLa3pRBm94wKM2W5HinU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KxV9Pxupot7ppiQRObzF7vkgiaU1OEg2ckeZJ+08GsjK0ghmW5hGLWtPft1oy0RPe
	 bRHBU780vCQl/gA6stLzvAF2gNr7QY6MaUEqgxbOFgSAodq5H9BcT60mxym7JT5PgT
	 dCwYuTqKE3PajY3ddyiFYdYfU3IhHS3Obi2ldPqk=
Date: Mon, 17 Nov 2025 08:46:05 -0800
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4bf47f-c1493c@github.com>
Subject: [bluez/bluez] 078a04: device: Fix the return type of device_irk_cmp()
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
  Commit: 078a047f6a40b0acf67861d01f1f2cb7bb50d024
      https://github.com/bluez/bluez/commit/078a047f6a40b0acf67861d01f1f2cb7bb50d024
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix the return type of device_irk_cmp()

The return value from device_irk_cmp() is returned directly from
device_addr_type_cmp() which implements a memcmp()-like interface, so
we need to return an int() and a zero for equality. Returning bool
will cause false positives since false is 0 and true is 1.

Fixes: f1fb4f95f49e ("core: Fix not resolving addresses")


  Commit: f5043771c27b5d9c19b1415e4e4c1eb5f7d470f8
      https://github.com/bluez/bluez/commit/f5043771c27b5d9c19b1415e4e4c1eb5f7d470f8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: add tests for discoverable timeout

Test that the discoverable timeout can be set successfully and that the
timeout actually triggers:

Set discoverable on timeout - Success 1
Set discoverable on timeout - Success 2 (Timeout)


  Commit: c5d4a041483c52f16f9f47adae41225d8ad90595
      https://github.com/bluez/bluez/commit/c5d4a041483c52f16f9f47adae41225d8ad90595
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

  Changed paths:
    M Makefile.am
    M src/battery.c
    A src/shared/battery.c
    A src/shared/battery.h

  Log Message:
  -----------
  shared/battery: improve the display of the charge level

The battery charge level may fluctuate due to uncalibrated
sensors. Commit smooths out such fluctuations.

The algorithm for determining uncalibrated sensors consists of
finding the number of changes in charge direction (i.e., "spikes").
If the number of spikes is zero, the device is charging or discharging.
If there is one spike, it may mean that the device has started charging
or has been disconnected from charging. If there are two or more spikes,
this is a clear indication of an uncalibrated sensor.

Check that the battery charge is fluctuating. If the battery charge
is fluctuating, use the average charge value, otherwise use the current
value.

Fixes: https://github.com/bluez/bluez/issues/1612


  Commit: c1493c32d7da270329d0ac2ca02117b905c04362
      https://github.com/bluez/bluez/commit/c1493c32d7da270329d0ac2ca02117b905c04362
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    M doc/test-coverage.txt
    A unit/test-battery.c

  Log Message:
  -----------
  unit: Add basic unit tests for battery charge handling


Compare: https://github.com/bluez/bluez/compare/4bf47f880d06...c1493c32d7da

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
