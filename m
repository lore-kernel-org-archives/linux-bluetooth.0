Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30032611E
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775993032; cv=none; b=U2+NDs+iFD0/oSE+DQ2ZbJGJ1CcLcrKbTD7rZxhXbHC7vw22wXrX20UnwW+myJvUfzvRxm821EkMZ29YWhsrhTvEBZR3rMRsno8Pv4tC2DbchBGWTsKqXLer52Yb9egzW3wKYtO/rDgo4szemiiqw2jS1px607TCnCQr+29p12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775993032; c=relaxed/simple;
	bh=Fib7Hot7SWoS/st7k+QD42jVvzpACJhMMi5J/hihpI8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bC+pf2ikkWHN8Xe35WszbH/bO+BjwojVxcpi1ChZdU1/0FSaflbERZmKwnmWfyRVv1Ae1vq2tOFbZ6NPAhPJTlO97jFWR5tKOUN8AJaNtR1a6wiw6LP1Brt6QA2sFJChO2klSJAwD6IsDAwTFG6hsguhBA8rK04qEC7OqN6LN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GXUYeqIv; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GXUYeqIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775993030;
	bh=lVS8nMgLKP/552avKWLuB0SV548Ky4vpzIIEm3035yQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GXUYeqIv9T25SydhampFNX2vgv27LzBAE+0eUkI3TV8CWCnqspjfLoPyRHdD166NH
	 U6sY5e6B2psxkMj//1PwS89n5+4cWVTfm6BZWhLW9ii6lpAzdGt0+us/3ZaR82Pwio
	 iCwRCmVcWcP4jLuhVlKIzhpqdh/jzTWBrSwcZ8sg=
Received: from github.com (hubbernetes-node-5a39f86.ac4-iad.github.net [10.52.208.29])
	by smtp.github.com (Postfix) with ESMTPA id 6903F36111B
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 04:23:50 -0700 (PDT)
Date: Sun, 12 Apr 2026 04:23:50 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1080317/000000-f3626f@github.com>
Subject: [bluez/bluez] f3626f: gatt-database: remove database from dbs list
 when ...
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

  Branch: refs/heads/1080317
  Home:   https://github.com/bluez/bluez
  Commit: f3626f6349fece2f1f4f464381c56efd07cac5c6
      https://github.com/bluez/bluez/commit/f3626f6349fece2f1f4f464381c56efd07cac5c6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-12 (Sun, 12 Apr 2026)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: remove database from dbs list when destroyed

btd_gatt_database_new() adds btd_gatt_database to the dbs lookup queue,
but nothing removes it from there even when destroying.

Fix by removing databases from the lookup queue before destroy.

Fixes crash on adapter removal in some cases:

ERROR: AddressSanitizer: heap-use-after-free on address 0x7bd476be1308
READ of size 8 at 0x7bd476be1308 thread T0
    #0 0x00000064562a in match_db
    #1 0x000000865410 in queue_find
    #2 0x000000645671 in btd_gatt_database_get
0x7bd476be1308 is located 8 bytes inside of 128-byte region [0x7bd476be1300,0x7bd476be>
freed by thread T0 here:
    #0 0x7f1478cee4cf in free.part.0
    #1 0x000000621625 in gatt_database_free
    #2 0x000000645582 in btd_gatt_database_destroy



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
