Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732D23D7DF
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179358; cv=none; b=uorrhcimsYMxn+hSHBPYUaCCKrIkUt0dOBiSzEBPs20gnpVEhzBDA51vGTdbUYjtZVkkX+6spXlSiSYh7LsouWgCOO9/ahr074m+58Ty0H3TLn1g9p5TPyNyapRBL+39UMsRsWrrpR6J5VJtMRDbTA7gomn641euO3cC1FE44e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179358; c=relaxed/simple;
	bh=r3WHbgEb22jNuSGRIU/rUmK4oniC07W2ux6b3FVZSWg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jmWU0HmgPqpazT0jYbq+UIW1gyVz6p9xccKVX/82JC/U3OIWA1hoYmNDW1x2O+zJQhSYK6ZEF9r97E4z5mGJVf3DEKEhi8z6Nbs9or0tiFaq3kmgzRvzKzN5D5NxnnThY0QPmUYnJuiBPU/ZwqqFIXijWv1vwH2oHc67KsizteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WqONqqxd; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WqONqqxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786179356;
	bh=T2qPcJAh+Af6RFepMAaRFEx/ePlVsBfyOdvnklxAMoY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WqONqqxdTwHt900iQuAtxTMFjqsfjYffzxwxH4AZqqsbm6oFBZMwwX7HAFUYg9qbd
	 zXvMwHXn08rikGDg+atRtSaYx7ZlN1dz6q4/zl4tvWBm7nq96HM+sheDjG4LIBINNR
	 fK/UKOZkm2fJ3Op9RwKdRaFPn84caDzg6ciwpXaU=
Received: from github.com (hubbernetes-node-04d8ddf.ac4-iad.github.net [10.52.205.84])
	by smtp.github.com (Postfix) with ESMTPA id 9D255A061D
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 01:55:56 -0700 (PDT)
Date: Sat, 08 Aug 2026 01:55:56 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142579/000000-beebaf@github.com>
Subject: [bluez/bluez] beebaf: emulator: btvirt: support debug for -s socket
 server
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

  Branch: refs/heads/1142579
  Home:   https://github.com/bluez/bluez
  Commit: beebaf12ef5072d30ee6b7f272ca329059818d0c
      https://github.com/bluez/bluez/commit/beebaf12ef5072d30ee6b7f272ca329059818d0c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-08 (Sat, 08 Aug 2026)

  Changed paths:
    M emulator/main.c
    M emulator/server.c
    M emulator/server.h

  Log Message:
  -----------
  emulator: btvirt: support debug for -s socket server

Support btdev debug -d when using socket server -s.

$ btvirt -d -s
Bluetooth emulator ver 5.87
Request for /tmp/bt-server-bredrle
bredrle: host10: > 01 01 10 00                                      ....
bredrle: host10: command 0x1001
bredrle: host10: event 0x0e opcode 0x1001
...



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
