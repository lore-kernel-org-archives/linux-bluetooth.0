Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74253603C9
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755993; cv=none; b=N6HuKFR+rZba4hFfWLLEbd/HbKsDdGf3iSMLhrFU97k1gzG1hzrtX/HuvuQ+3VioKUT+AGvVG5IYRkOhEcrlG6yHoZtJ18nz50KiaziXLSulAuy5zwV0jrqqvumHZt9ufq6TbsiaMgV5GC/l6O9CCByg6NzKdiKgyJOms5XvZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755993; c=relaxed/simple;
	bh=adDMeCvFYxJLbaiqq3VJ4ZNvJuIX5amP17MScyh2rFk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XCq0EkeKPSC4KJSIFOfQxLggsIDuvrNGSK8BKWUt/N8dyIeRCe75tPiwqqUefYHkcoRhXBT3PKxMYkWZYlf2rKqZbQ1nYaH6oudiE7OUBmv6j3yj2snsnzBjWe6V+2SC4muZbIdfpVkV/q2gQFanLygrjrbX5L25U8Oza+uC0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eJBwLcZF; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eJBwLcZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783755991;
	bh=otGiszwPwz5630suYa4TNZwB3/wn/AKQ1StLSc8HJb8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eJBwLcZFuVJMG5h1beierVVdD0ap6vZ0faoBwLSGIozoRNQ4wvzekBsQK9+msC3Y4
	 S/r/XFeARkNnKYYWR6D3I3NqcdKhDvuxhQyJX4j6X+WMuSJOYMotMIBd/C4+ZjAESj
	 +dyLlxF+hBh6+ZvCtwnfMjGWp7TU1zM28rI2O5aI=
Received: from github.com (hubbernetes-node-8adc48b.va3-iad.github.net [10.48.67.52])
	by smtp.github.com (Postfix) with ESMTPA id 1BE128003BA
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 00:46:31 -0700 (PDT)
Date: Sat, 11 Jul 2026 00:46:31 -0700
From: ferose <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125740/000000-c8a8a1@github.com>
Subject: [bluez/bluez] c8a8a1: shared/bap: Fix rejecting re-attach of the same
 fd
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

  Branch: refs/heads/1125740
  Home:   https://github.com/bluez/bluez
  Commit: c8a8a1b931bbdf2f7de7142d4bd0836aec76cc93
      https://github.com/bluez/bluez/commit/c8a8a1b931bbdf2f7de7142d4bd0836aec76cc93
  Author: Ferose <ferose2@gmail.com>
  Date:   2026-07-11 (Sat, 11 Jul 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix rejecting re-attach of the same fd

When the remote's STREAMING ASE notification arrives before
iso_connect_cb() fires, the race handler in bap_state()
(profiles/audio/bap.c) already attaches the io to the stream; the
comment there notes "Order of STREAMING and iso_connect_cb() is
nondeterministic". When iso_connect_cb() then calls
bt_bap_stream_set_io() with the same fd, the guard in
bap_ucast_set_io() sees an attached, non-connecting io and returns
false. iso_connect_cb() treats that as fatal:

  profiles/audio/bap.c:iso_connect_cb() Unable to set IO
  profiles/audio/transport.c:bap_state_changed() Unable to get stream IO

and tears down a CIS that btmon shows was established successfully
(CIS Established status 0, both ISO data paths set up). With a device
whose STREAMING notifications consistently win the race, streaming is
never possible.

Treat re-attaching the fd that is already attached as a no-op success,
without re-running the per-stream state actions (which would send a
duplicate Receiver Start Ready to a linked source ASE). Attaching a
different fd to a non-connecting io remains an error.

Fixes: https://github.com/bluez/bluez/issues/2223



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
