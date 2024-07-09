Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1171DFCF
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552287; cv=none; b=u7bNUW6QKZNokormIsoNw2Z/dzvwR+0JhOiP9mBhuqbI8QFjKMRykbWN3IMa5TFTQcmFWZx61+G0Nhtuw5jp7nzVm+wx7dXD4bJsnZTbknX+LhA7/kS2sbLMcAStxBZ2wykXzhpacA7h5cA4oqgqWka68q3duKZaie4BGB89qbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552287; c=relaxed/simple;
	bh=+RGOVH+3+B4oHPH/Wu+3ue5KUNGiiDCqxTxO8D4c7m8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lB4hq9lq2AG8icjPrAjPPcetCZobsmZJZDGHQUXEHT/zHSNmbMuPVd3z1gAAC7XIkoGU+B8dlIZQFiInjbie0tlOKu2UTme2MWDBD5Ouio39DPGxb+TK1IG3RLrWPqn+v6bZp0ZdaNWuJ4oZfl2tjcOsYQlF0YeLAra6LB9C/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FteuFP15; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FteuFP15"
Received: from github.com (hubbernetes-node-3d3a7bc.ac4-iad.github.net [10.52.153.33])
	by smtp.github.com (Postfix) with ESMTPA id 0A76F5E0C70
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720552284;
	bh=+kearqplcRNCtHqrCAByGlwkH8TDytQKDHc2j4XL79U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FteuFP15mURMilulo6GsuEpqrUhyWdX52l3y5tCY+yvkdzJUiESUtGj7n9HJHq5Vt
	 GY9/MfAqHFZThbHzOk1UJ8nxd5oA/EMP1iuCiyuvQoo82BrWnIiOTgSumy0/Vr8j2i
	 GDnsdxqkaklB9+AHOK5Sprw0DQsL8O1gRJGcotWU=
Date: Tue, 09 Jul 2024 12:11:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/34aca9-4ca662@github.com>
Subject: [bluez/bluez] 2748c6: bap: Wait for BIG Info report event before
 creatin...
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
  Commit: 2748c60a2c6b1b090a7507fdd23865a598129d61
      https://github.com/bluez/bluez/commit/2748c60a2c6b1b090a7507fdd23865a598129d61
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-07-09 (Tue, 09 Jul 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Wait for BIG Info report event before creating streams

This makes it so that stream for each BIS is created after BIG
Info report is received. This ensures that when the stream is
created the encryption field is correctly set.


  Commit: aa6063aa66954ac8321211145d1ae6b434b2555c
      https://github.com/bluez/bluez/commit/aa6063aa66954ac8321211145d1ae6b434b2555c
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-09 (Tue, 09 Jul 2024)

  Changed paths:
    M profiles/health/mcap.c

  Log Message:
  -----------
  health: mcap: add checks for NULL mcap_notify_error()

It is necessary to prevent dereferencing of NULL pointers.

Found with the SVACE static analysis tool.


  Commit: 11dcc9bf0dba61c83269fb3cf234579d6f9ef192
      https://github.com/bluez/bluez/commit/11dcc9bf0dba61c83269fb3cf234579d6f9ef192
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-09 (Tue, 09 Jul 2024)

  Changed paths:
    M src/shared/micp.c
    M src/shared/vcp.c

  Log Message:
  -----------
  shared: prevent dereferencing of NULL pointers

It is necessary to add checks for NULL before dereferencing pointers.

Found with the SVACE static analysis tool.


  Commit: 755091581336dd6b6a710e599da9e1e52037851a
      https://github.com/bluez/bluez/commit/755091581336dd6b6a710e599da9e1e52037851a
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-09 (Tue, 09 Jul 2024)

  Changed paths:
    M src/settings.c

  Log Message:
  -----------
  settings: limit string size in load_service()

It is necessary to prevent buffer overflow by limiting
the maximum string length.

Found with the SVACE static analysis tool.


  Commit: 4ca662fcea1604e937bde1bddd5de2c50bcb6e00
      https://github.com/bluez/bluez/commit/4ca662fcea1604e937bde1bddd5de2c50bcb6e00
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-09 (Tue, 09 Jul 2024)

  Changed paths:
    M src/settings.c

  Log Message:
  -----------
  settings: limit string size in gatt_db_load()

It is necessary to prevent buffer overflow by limiting
the maximum string length.

Found with the SVACE static analysis tool.


Compare: https://github.com/bluez/bluez/compare/34aca9a4fbcf...4ca662fcea16

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
