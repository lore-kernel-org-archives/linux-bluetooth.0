Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FB2EACEB
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281816; cv=none; b=GHGvAyKLaAErNWOpRrdLWfgI/VeAeRICnW/lnGIL3Xu1MEN7lZ7kwx7QRV7Ui32hRhO9MsaHIc8LV2Lm1+dffeuFQD4wcVjmn3l6y3+AhogpkwRDcJfrVvW2xQls9GxSNfrFJp45kZYzgO6fnVeodBKqrenkt8T8QV53zZplzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281816; c=relaxed/simple;
	bh=vnMOmyAvhwx6EQ0bfJGncms38ub4Wr1PTzjpfxOHzc0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qFAIQ2wsQm+CQIY4+8MfbPY9yPcOzPkb/AoCwASdosY1w5avuRv0UrP0KSADXOT0HRbEzITKeHXL4LJ7dWIBEiW0BfJIOjMEdBR5/Q8eFVLQJjNTDaDPLH1VAzKVZiEoq54MCdlICdQbaD8l5sStlIpKlxKtgTvyJ8aJFTPLUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m3qw1RZ1; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m3qw1RZ1"
Received: from github.com (hubbernetes-node-bf898a9.ash1-iad.github.net [10.56.170.17])
	by smtp.github.com (Postfix) with ESMTPA id DF791141579
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753281813;
	bh=8ybqRjHy3BYohU3VFsb0V8PVHJ556d7CBCcElH3W9a0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m3qw1RZ1SNBd4q/RpBgodglxLB7Jw725x2Dkp9H5xZNnnX42gSyeaJpnkSN4V1/S+
	 05/onW10LDVphYQgoJfjr22O6rpOyRQWtIfWkxsZAOHb8ruLeKbFdr40l8FDR8MHW0
	 YgiPHBR6UxgC/QsURpjXljGtAO0SlQl7eU7KgB1I=
Date: Wed, 23 Jul 2025 07:43:33 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/52de8d-3c0693@github.com>
Subject: [bluez/bluez] 06d73a: client: Fix gatt.{read, write} not working on
 scripts
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
  Commit: 06d73a43a854aee75ff94a82dbbf30ac2c020622
      https://github.com/bluez/bluez/commit/06d73a43a854aee75ff94a82dbbf30ac2c020622
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-21 (Mon, 21 Jul 2025)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client: Fix gatt.{read, write} not working on scripts

If gatt.{read, write} are called within a script they don't indicate
completion so they block commands to be run after them.


  Commit: 4549772bb228b27a0ce5222f4897344113d9ebb3
      https://github.com/bluez/bluez/commit/4549772bb228b27a0ce5222f4897344113d9ebb3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-22 (Tue, 22 Jul 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add write support to Metadata property

This adds initial support from writing to Metadata property.


  Commit: 75628226ff83606e3676088bb3882d4fd73f8962
      https://github.com/bluez/bluez/commit/75628226ff83606e3676088bb3882d4fd73f8962
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-22 (Tue, 22 Jul 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix not updating MediaTransport.Metadata

MediaTransport.Metadata needs to be checked for updates when state
changes to Enabling or Streaming otherwise it remains blank.


  Commit: 3c0693c5d22606f786da4389103740424a04213b
      https://github.com/bluez/bluez/commit/3c0693c5d22606f786da4389103740424a04213b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-22 (Tue, 22 Jul 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Add transport.metadata command

This adds transport.metadata command which can be used to update the
MediaTransport.Metadata property:

> transport.metadata <transport> "0x03 0x02 0x02 0x00"
[CHG] Transport <transport> Metadata:
  03 02 02 00
> transport.show <transport>
...
	Metadata.#0: len 0x03 type 0x02
	Metadata.Context: 0x0002
	Metadata.Context	Conversational (0x0002)


Compare: https://github.com/bluez/bluez/compare/52de8da1a99c...3c0693c5d226

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
