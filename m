Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1FE4779E
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343927; cv=none; b=UIq686vesfvnNAYgIeGJ3j8TN4pzmo0+Aw9Xq0PIeLb4q5Ld0L2DNEOuVulsE/vRwuNl+vTAwvlrpXVxbFuILoQEfMa/chLMNra7tJPTWDODIFm6wJcAdhJVqcFkTA/ucNC3o0zQGenvlNmyXHMcyz3RUZrOLDlZCYvBPlIkUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343927; c=relaxed/simple;
	bh=/0dcY+0Ln+Pl0w3iXhii7Fbd3IzKB7GpbAmAa+0CLx0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DXgeyscupd6MDwZTr2JPCjxibYXoDqBHk4a7WypOFzaGGDVZ473pOOdtGXTSGuA3c5RTMye3uLTnVNzWcvSHMCWjt0QdOpvHph21f7utYK8VIxeckBmiqg/cDAaoPkCFIyhIVnd0rO/c8ORKZfHdUNLQFdVGPKKtqwzyblxSO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BZZTDBo5; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BZZTDBo5"
Received: from github.com (hubbernetes-node-21e7085.ac4-iad.github.net [10.52.125.27])
	by smtp.github.com (Postfix) with ESMTPA id 6C473641100
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1710343925;
	bh=khOZX8ci8IzFeeFNpXBmc5nj5iQpgR/wkCULIk2scoY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BZZTDBo5/gy/kcQa/cXnPgRvTVHlreDKD/Vs4z/BP2lF7qunZNuuJf9+FHRv6EW+/
	 npeHEEGXFq/BbPsPyNunvgSZMXmMf71SxeJymZuLwv/njzPrcFsypdXW4iSTv8HGbK
	 wBBLY6PqODl9ORFuUG0hSATJ1aJhj6rQM/Cszd3o=
Date: Wed, 13 Mar 2024 08:32:05 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c9dddb-f5fecf@github.com>
Subject: [bluez/bluez] 92ed63: shared/uhid: Add dedicated functions for each
 UHID...
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
  Commit: 92ed637ab2bc44b812fd8c7bff5b5f41fcc48255
      https://github.com/bluez/bluez/commit/92ed637ab2bc44b812fd8c7bff5b5f41fcc48255
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-11 (Mon, 11 Mar 2024)

  Changed paths:
    M src/shared/uhid.c
    M src/shared/uhid.h

  Log Message:
  -----------
  shared/uhid: Add dedicated functions for each UHID opcode

This adds bt_uhid_create which uses UHID_CREATE2 and tracks progress of
when the device is ready to receive events and in the meantime queues
them while waiting for UHID_START and other dedicated functions for each
UHID opcode so users don't need to build each command manually.


  Commit: 256d0b594d044222975f55e3b2d02990e0f88f87
      https://github.com/bluez/bluez/commit/256d0b594d044222975f55e3b2d02990e0f88f87
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-11 (Mon, 11 Mar 2024)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Use bt_uhid functions

This makes use of bt_uhid function instead of directly submitting
events directly using bt_uhid_send.


  Commit: c0c9e462be465ae3e9458256636f10f4d6acbedb
      https://github.com/bluez/bluez/commit/c0c9e462be465ae3e9458256636f10f4d6acbedb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-11 (Mon, 11 Mar 2024)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input/device: Use bt_uhid functions

This makes use of bt_uhid function instead of directly submitting
events directly using bt_uhid_send.

Fixes: https://github.com/bluez/bluez/issues/771


  Commit: f5fecf037b1ea31612cb0226cc2634994a4671c4
      https://github.com/bluez/bluez/commit/f5fecf037b1ea31612cb0226cc2634994a4671c4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-11 (Mon, 11 Mar 2024)

  Changed paths:
    M unit/test-uhid.c

  Log Message:
  -----------
  test-uhid: Test bt_uhid functions

This tests bt_uhid_create, bt_uhid_input and bt_uhid_destroy instead of
directly submitting UHID_CREATE, UHID_INPUT and UHID_DESTROY.


Compare: https://github.com/bluez/bluez/compare/c9dddb642663...f5fecf037b1e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
