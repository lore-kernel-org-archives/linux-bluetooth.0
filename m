Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC36E328B6C
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089134; cv=none; b=h8o7yel2ps3/VQEliPwap1oBxMeBCWogynSQX4gnqgblzKJt8fegqElwqARHNDpxA3+HQkIlk2SPmdTcgtaVCZUEhywamWaO9JeV3wBe8CF2jB3pWmbuNsXcbgAebBn/2BdfaYpUvT3v81gaUEIQsXSToCb9hHsyQDtwySiB9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089134; c=relaxed/simple;
	bh=FmXdo6ahwPKYhWn9B9ARkz8CuEXK+P8EMOyk84JC06g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LxWEtCxUxy0AJegCyDh2+tDO8bydRHfr9V+ItJLm+OGPzi4kFm+K6p+Jyc0JILk0Q5C21n0sVCEDJPX+GWaD1m/fojKjP9gCf6dXDdCYK1mmTugS3/RE6o9nowcMm0NkCKeDp1oeU494zkoKzbTGOTKwxuTrSOxzCIYmWn+ehU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hdyic8ma; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hdyic8ma"
Received: from github.com (hubbernetes-node-32a6497.va3-iad.github.net [10.48.180.48])
	by smtp.github.com (Postfix) with ESMTPA id C39854E0844
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764089131;
	bh=I4KBzXWauvQJLjwNy/7dREuUifWg3wd6Gv8URtH97q0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hdyic8ma4UvOMeibAwIjUgTSKJ2Zgwq1aCRxhRo5LAewBFdnLtEx4zFynY3jwtU3r
	 z79yhZd7hMrJ4MS6Vh07rNWKyamgQZOyNiz6G4W8uKLPLe0/70kLZVp+umJNWJ0Imo
	 jEwhyUUA78mXZEaGvfcob6enSaXg7G5lbV9fUYeE=
Date: Tue, 25 Nov 2025 08:45:31 -0800
From: Peter Seiderer <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f6f6ab-0b7395@github.com>
Subject: [bluez/bluez] 0b7395: transport/audio: fix build with a2dp support
 disabled
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
  Commit: 0b7395a3479686f46afe508a345bfa50fc20767e
      https://github.com/bluez/bluez/commit/0b7395a3479686f46afe508a345bfa50fc20767e
  Author: Peter Seiderer <ps.report@gmx.net>
  Date:   2025-11-25 (Tue, 25 Nov 2025)

  Changed paths:
    M profiles/audio/media.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport/audio: fix build with a2dp support disabled

Fixes:
    CCLD     src/bluetoothd
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `endpoint_init_a2dp_sink':
  .../bluez-5.85/profiles/audio/media.c:728:(.text.endpoint_init_a2dp_sink+0x2b): undefined reference to `a2dp_add_sep'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `endpoint_init_a2dp_source':
  .../bluez-5.85/profiles/audio/media.c:715:(.text.endpoint_init_a2dp_source+0x28): undefined reference to `a2dp_add_sep'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `set_configuration':
  .../bluez-5.85/profiles/audio/media.c:512:(.text.set_config+0x35): undefined reference to `a2dp_setup_get_device'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: .../bluez-5.85/profiles/audio/media.c:525:(.text.set_config+0x8c): undefined reference to `a2dp_setup_remote_path'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `media_endpoint_remove':
  .../bluez-5.85/profiles/audio/media.c:250:(.text.media_endpoint_remove+0xc): undefined reference to `a2dp_remove_sep'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `endpoint_reply':
  .../bluez-5.85/profiles/audio/media.c:361:(.text.endpoint_reply+0x267): undefined reference to `a2dp_parse_config_error'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:5491: src/bluetoothd] Error 1
  make: *** [Makefile:4096: all] Error 2

Fixes: https://github.com/bluez/bluez/issues/1675



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
