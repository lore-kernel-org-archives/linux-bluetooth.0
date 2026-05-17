Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0326F29C
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014402; cv=none; b=D2ncyKxyapncqLz1PWFXirSEpySLXKQ0Xh1MbwkO9JG8az6xDR488XDf5RJ/OQqOQ/9f1M18xx+urIkiY/WLL5EriQw3e/5LsFw3z3LSe5QTmh37ulldHfpX+jQIKq/RHYwDghyPMEJMPGChXTIERZnSAfNVM98ar6W3MyaeNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014402; c=relaxed/simple;
	bh=NP5vAkngPvObR9AcMga/9NFFilHwtCSSa5hUPf2f8vY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Pwd+HGfNNNfgQbttBKUxqAjg7Z+3aT804XyWWY19MzId0pgwU1TMmhzRWHImGk5q+mPrYVrYveDMRC4qqgtd4Neqp0GOoYHSMF4dhdwgRItUFDQY3bPd6pnQ1op9r52d51dOKhQSYOxjcDp7b2nW5JxfJ/EUhO41nzoBJYNrIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AEF3q6XH; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AEF3q6XH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779014400;
	bh=pgXkvDtaQG9o+M48ir1lvbIJIym1fBIjqXYDaFlbGhQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AEF3q6XHQQWYlCTri20rATU/hOzz/fZNkApnLQEFYXfDTN4T1C6U8IHikkWRx9JLy
	 Cli66XBF9LyGXbq4Wwz+nzgbgVcWikaq9BEihIkEA3wjCfd6BI+GNeT9PXrFidqgeE
	 s3QvkTBmAZjdBSUIb1R/HdEbU/nj+F01GLIUgGmk=
Received: from github.com (hubbernetes-node-af43752.ash1-iad.github.net [10.56.202.79])
	by smtp.github.com (Postfix) with ESMTPA id 98B0F5210B5
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 03:40:00 -0700 (PDT)
Date: Sun, 17 May 2026 03:40:00 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096011/000000-59e580@github.com>
Subject: [bluez/bluez] 59e580: media: use custom DBus timeouts only when
 remote s...
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

  Branch: refs/heads/1096011
  Home:   https://github.com/bluez/bluez
  Commit: 59e580a3a123be492d9a3361a367a72566bddb8b
      https://github.com/bluez/bluez/commit/59e580a3a123be492d9a3361a367a72566bddb8b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-17 (Sun, 17 May 2026)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: use custom DBus timeouts only when remote side is waiting

Under high system load (VM instance on boot) it's observed the 3 sec
timeout BlueZ uses for BAP broadcast SetConfiguration may be missed by
Wireplumber, as these are set up immediately on startup together with
any other setup (eg ALSA) that may need time.

There's no actual need for using a short custom timeout in BlueZ for
this, as in this case there is no remote side that is waiting for a reply.

Fix by limiting custom timeouts to cases where there is a waiting
remote.  A2DP-specific timeout should be used only for A2DP
SetConfiguration.  Similarly, using timeout for BAP only makes sense for
unicast, and should derive from the ATT timeout.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
