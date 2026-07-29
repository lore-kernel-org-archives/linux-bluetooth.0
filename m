Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76124D8D80
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343233; cv=none; b=ODNzHsqFn3SOvVAvDAj1/mpemzm3jFo2QWZdOZ8ZfPZDNiGmq/0ItAPPIERzP0ELrNPJLDRoCMOU9fULcno9zKkHZ5jFE9SfXWeJ4PZ0JdNSHksvBkMFzWgHF/k1nqHoLHPeIbI4QX/knxm63yOt2kKo2ZonMESBryF2tE+TUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343233; c=relaxed/simple;
	bh=WkIjlD4ynPBX2yXYJJOiCRgMOzfRRfk9PHxaxeFJNiM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ua0z/iRJV42VsUYs2m8XpdDQroozqinvU8xMO3QpElaELF/ArsN47yYUCF06sJ1LZt2erTfi3zSyrSxNwvv65TQM+6APyZrmc/9hAeNBz3DF6FnMFtJx/ZcoO4tQqxLbN5Wsqc3NXQFCl8NrLc70wwKVSW+b6Y+YC+OcIaHqKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cqrP8Hpz; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cqrP8Hpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785343226;
	bh=d1EoZU9ca1Kx/DO7blFRxH7qZ8fYp/WKIMv8wbvnTIM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cqrP8HpzsfD/NZrVTMJwTP1nhx39Grz4GSP27qm+z+doBCznfJRedJXj4+F54WLM6
	 lb8zKNF+ZnRvEVIJu0ayLCfTUeL82RAJLQOyuFUbwhlFWHtEA3OPfhti90vjRdjZtq
	 n7q8KenSxHIoNFBeekObf7kTudS6RM0txB+Wx2XY=
Received: from github.com (hubbernetes-node-56b66b9.ash1-iad.github.net [10.56.83.28])
	by smtp.github.com (Postfix) with ESMTPA id D56381800DC
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 09:40:26 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:40:26 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/729f96-98e5a7@github.com>
Subject: [bluez/bluez] 66d19b: bap: fixed the return value of GIOFunc
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
  Commit: 66d19bb2a02792cf30cd723b65d4c2110930a31e
      https://github.com/bluez/bluez/commit/66d19bb2a02792cf30cd723b65d4c2110930a31e
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-07-29 (Wed, 29 Jul 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: fixed the return value of GIOFunc

The GIOFunc should return FALSE if the event source should be removed.

Fixes: 322c39a64 ("bap: Start BIG sync after receiving BIGInfo")


  Commit: fee4813d90af02c5f3882461ee6a1bc1d84931f2
      https://github.com/bluez/bluez/commit/fee4813d90af02c5f3882461ee6a1bc1d84931f2
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-29 (Wed, 29 Jul 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  rap: use session lookup for RAS operations

Store disconnect information in RAP state and
centralize attachment handling through dedicated helpers.
Add bt_rap_get_session() and use it from all RAS
GATT server callbacks


  Commit: 98e5a74736e218f08b9928a931e4d537735fd2d8
      https://github.com/bluez/bluez/commit/98e5a74736e218f08b9928a931e4d537735fd2d8
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-29 (Wed, 29 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c

  Log Message:
  -----------
  profiles: centralize reflector setup

Add a helper for reflector initialization and track D-Bus registration
state in rap_data. Simplify connection handling, move interface cleanup
to object destruction, and streamline removal logic.


Compare: https://github.com/bluez/bluez/compare/729f96089cf6...98e5a74736e2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
