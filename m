Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0961A9B3D
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749235410; cv=none; b=lEd0wRn1oywRpiGBdpUNDX7dJPrq84RKt6i3PDQ89ltfAleT0TvHSAEk2idEe4rD4jUbQGvefeq+Bh4iTS2Cnz5QKcwHmmY6XT5bTexbZKBVVoodz6OD4ZFz3b395VnPs9MzRrBm/rWl8wgBXkA0kzsH8/FRRe4xNlebh25aLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749235410; c=relaxed/simple;
	bh=l//rGjECMYkMrgyQQZXi0/SJlWVZP0fcDRV7g6s9WKU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U8xWkmLPXvkfnoGYMf+OGpqCmyn0ziDPzhT6T4Mgc9On7NJCrBF2apVsUTS8gcEOTVf+xPYxwB7AYZg3byL6S7bYHKi86ImI2fqHr046gXxXDWoF7ZFS+euA0XjujGbRpv4WX5gQtRpkz/YdDhsphQUkuSC3m6kPgQKC3uFvl5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CXVdRGRz; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CXVdRGRz"
Received: from github.com (hubbernetes-node-ab3b86b.va3-iad.github.net [10.48.138.25])
	by smtp.github.com (Postfix) with ESMTPA id 614ED4E051A
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749235408;
	bh=8Y/s6r+lpnpvD83lUUpnqyGpdQGgnMr8Ip1Z1rl8FtQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CXVdRGRzp1jnhzVB9SAOrL2HTn91Lq090+76nQJT9OskoVT40cGRg03IhHLVdRm7v
	 xkOEldLLQz08GEHl5xeVcqy1zFufTSqwFindbvLEYG29PBhEiHv1cy6dsfnula+tES
	 fvFXhXAtyVmiAMVL7NhbhS0IOM8Bo6vbbdQx83Zc=
Date: Fri, 06 Jun 2025 11:43:28 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8ad12f-bbd10b@github.com>
Subject: [bluez/bluez] 4a7ee3: adapter: Fix exposing coordinate sets if LE
 Audio ...
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
  Commit: 4a7ee30978da919cc820116be6ced323b35e4ebd
      https://github.com/bluez/bluez/commit/4a7ee30978da919cc820116be6ced323b35e4ebd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-04 (Wed, 04 Jun 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix exposing coordinate sets if LE Audio is disabled

This fixes exposing non-discoverable coordinate set members if LE Audio
is disabled since it may lead system device setting showing them to user
that may attempt to pair them and end up not working.

Fixes: https://github.com/bluez/bluez/issues/523


  Commit: 04c32f3d312905bf7bece70735e6b2ca4bf3ca05
      https://github.com/bluez/bluez/commit/04c32f3d312905bf7bece70735e6b2ca4bf3ca05
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-04 (Wed, 04 Jun 2025)

  Changed paths:
    M client/assistant.c
    M client/bluetoothctl-assistant.rst

  Log Message:
  -----------
  client: Add assistant.list

This adds assistant.list command:

assistant.list --help
List available assistants
Usage:
	 list


  Commit: f09f33199858d103489c7064b7488209d02b9ce8
      https://github.com/bluez/bluez/commit/f09f33199858d103489c7064b7488209d02b9ce8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-04 (Wed, 04 Jun 2025)

  Changed paths:
    M client/assistant.c
    M client/bluetoothctl-assistant.rst

  Log Message:
  -----------
  client: Add assistant.show

This adds assistant.show command:

assistant.show --help
Assistant information
Usage:
	 show [assistant]


  Commit: 7d59391bb783c60f15803f97860094a6817894b2
      https://github.com/bluez/bluez/commit/7d59391bb783c60f15803f97860094a6817894b2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-05 (Thu, 05 Jun 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Add support for -EINPROGRESS to bt_shell_noninteractive_quit

This enables commands to call bt_shell_noninteractive_quit with status
set to -EINPROGRESS to indicate their execution is in progress and shall
not exit in case of MODE_NONINTERACTIVE but it can proceed to the next
command for MODE_INTERACTIVE.


  Commit: 5499681bc63226c03984e3493eebd0dc4cd2243f
      https://github.com/bluez/bluez/commit/5499681bc63226c03984e3493eebd0dc4cd2243f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-05 (Thu, 05 Jun 2025)

  Changed paths:
    M client/advertising.c
    M client/main.c

  Log Message:
  -----------
  client: Use -EINPROGRESS with scan and advertise command

This uses -EINPROGRESS with commands scan and advertise since they need
to keep running in the background so they don't exit but shouldn't block
other command from executing in case they are invoked from a script.


  Commit: bbd10bb9bc5e3504b24dc65132d65b34d6188d69
      https://github.com/bluez/bluez/commit/bbd10bb9bc5e3504b24dc65132d65b34d6188d69
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-06 (Fri, 06 Jun 2025)

  Changed paths:
    A client/scripts/broadcast-source-pbp.bt

  Log Message:
  -----------
  client: Add script to PBP

This adds a client script for testing Public Broadcast Profile.


Compare: https://github.com/bluez/bluez/compare/8ad12fe7b4b9...bbd10bb9bc5e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
