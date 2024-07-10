Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE86193455
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622157; cv=none; b=smbTaUqK7t6pL8zhQFWBAkxeeEUsn6uTFWKfxLf73eAKvWksJf8GStsoU8z4fr4rlnFhtjjQrrOY1lne2WQrlqSoGIidYr+DKsrIZrGpbq0JHI65yuM8pPc2CvrivbgkQ3scxCiYj/ixm3JFIbIPCFEV6aP1dWNbfCmEReAgEIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622157; c=relaxed/simple;
	bh=znEevpe9jUnLFxa70RihE8WyuOuAkWHItMvjP100g2k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WnyLFQzv7rmsqn9PpkYvA6yrLiQbTK9pJ7395vjAEqOEHFJDvZyWFi9WZVJGotgPOIoCBeIno0ioD9iHbCF6Nte+4e3D2V8cZlMyH1A0V8j601ET4kc71peAJuSY/rAV7Bg4P9RC2z1morOEAEcG2yQfnCeewkU10A/H4Rmbz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gRjdoWVU; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gRjdoWVU"
Received: from github.com (hubbernetes-node-9e45662.ash1-iad.github.net [10.56.164.51])
	by smtp.github.com (Postfix) with ESMTPA id A031A60100F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720622154;
	bh=tTCmi909Wd5MYtCX8DHT+UXdfTmElkDjDbIelHFJZG4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gRjdoWVUq1Eb3yAHuS/NZJmRIthIjurp3mWuszIDWd6rmw+ugUMrrSY5O0S7vrCw4
	 g/wKnlzhLTR9pvOtq0EW3UReH/1jh5FggKqBkkuxt39Kx7+clQ8L2tSgF6QFotAn9N
	 pHBhza1Jf58RL5+Q3V6u3+BqryRljHC4gnLuxw/g=
Date: Wed, 10 Jul 2024 07:35:54 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4ca662-7a4503@github.com>
Subject: [bluez/bluez] e56fc7: gatt: add return value check of io_get_fd() to
 soc...
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
  Commit: e56fc72fc66765f407473e4cb903fdc80784a4ff
      https://github.com/bluez/bluez/commit/e56fc72fc66765f407473e4cb903fdc80784a4ff
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-10 (Wed, 10 Jul 2024)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: add return value check of io_get_fd() to sock_io_send()

It is necessary to add a return value check.

Found with the SVACE static analysis tool.


  Commit: ba70a116d97108f21a853f5549758a720fdbefb3
      https://github.com/bluez/bluez/commit/ba70a116d97108f21a853f5549758a720fdbefb3
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-10 (Wed, 10 Jul 2024)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: add NULL checks to foreach_aics_service()

Make foreach_aics_service() safe for passing NULL pointers.

Found with the SVACE static analysis tool.


  Commit: 12525371ef082483d524447310da7d0f5866bf91
      https://github.com/bluez/bluez/commit/12525371ef082483d524447310da7d0f5866bf91
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-10 (Wed, 10 Jul 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: add error code handling to transport_recv()

It is necessary to add return value check as in sock_send().

Found with the SVACE static analysis tool.


  Commit: 7ffc08dd78d68eff15bb77e43efbc1b606fb4fd8
      https://github.com/bluez/bluez/commit/7ffc08dd78d68eff15bb77e43efbc1b606fb4fd8
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-10 (Wed, 10 Jul 2024)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: prevent dereferencing of NULL pointers

util_memdup() will terminate the program if memory
allocation fails.

Found with the SVACE static analysis tool.


  Commit: cf3d80a01f1f21538148cb9a5569b678dad0848b
      https://github.com/bluez/bluez/commit/cf3d80a01f1f21538148cb9a5569b678dad0848b
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-10 (Wed, 10 Jul 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: fix the order of args in cmd_register_endpoint()

Based on the function prototype, ep->cid and ep->vid should be swapped.

Found with the SVACE static analysis tool.


  Commit: 7a45038dc1e505afbaa49f8dd64fd41dab627f23
      https://github.com/bluez/bluez/commit/7a45038dc1e505afbaa49f8dd64fd41dab627f23
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-10 (Wed, 10 Jul 2024)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: add NULL check to discover_secondary_cb()

It is necessary to prevent dereferencing of a NULL pointer.

Found with the SVACE static analysis tool.


Compare: https://github.com/bluez/bluez/compare/4ca662fcea16...7a45038dc1e5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
