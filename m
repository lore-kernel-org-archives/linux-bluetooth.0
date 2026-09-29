Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FD5733E
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 01:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644514; cv=none; b=Y3oadjlzWRduNYuQ0IH3wuASKpKs2bNtJzqh2GKuymBlVvFPfbmqqAtUu5pHujNV63cVc0Rqh3RlDj/0Hgo2sbBnLzOtPmM1Lb/hK14bkusj5VqdH/zlAOLnJO+k8pOlmHW3MgsTTIEqsBps3DSuM+hRbFD84/8F1dnUyR71XH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644514; c=relaxed/simple;
	bh=JKMo63pnniDS0MVg9RMJNwB0uj+1ecZDU15WGva6J6w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BJNnvJxuotLGrgd1EZheV1zsZPCrrXW5GD7cNyS0bvNxjsPtLF7E0ImOTKEeP5ni6OW9k6Rm9tZ6p9FH4pvstPVATY3l035dMOSAx6UCFlBeErnMeHlgU5Bi7HqeG6KS/ekbXIVdoUbRUFsM7K5atXzw23m2NVEUIHFUtzTLD70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=YiiBMo6B; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="YiiBMo6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790644511;
	bh=0OYtmx+F1Z+kqXYWH/wWH48evf0HxB0zMzBKiirEcXc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YiiBMo6BLbXjquq1zyJwAO4P+0PWGUyDA9hjZN4M3j7oX9CK8tORQ08Tej0JyWqqA
	 KPxfkjsMuVtbuNigCxPrDr5E3o0x0c53V2FCtrFkqkkKdsgGjZI/O3hkrW0CRo9WZY
	 3MaNss+yNEToDs5eMYg/eggv+7yZBD2ptxTv7lT33+8lp9fgfAXydwKOhZGrKrkUyZ
	 CMk2Kb75jv/jyoTZyxNYW1Si/EqPyIi2DicCh91V62S7wCYiaFQFYLB4VkluKtICcq
	 UKJM2amkGOtha6weYcZWmpwE5oGqIL/76F3P2AN/oZlBHiZJShDOuOh4T+O/3um8J0
	 44Icmwnp3Vfxg==
Received: from github.com (hubbernetes-node-e9a5497.ash1-iad.github.net [10.56.14.58])
	by smtp.github.com (Postfix) with ESMTPA id AFE4C360A72
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 18:15:11 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:15:11 -0700
From: "Seonggon, Cho" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175670/000000-361fbb@github.com>
Subject: [bluez/bluez] 361fbb: mpris-proxy: Line-buffer stdout
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

  Branch: refs/heads/1175670
  Home:   https://github.com/bluez/bluez
  Commit: 361fbb38d786522b7a2add85b4d656b5e5cd49da
      https://github.com/bluez/bluez/commit/361fbb38d786522b7a2add85b4d656b5e5cd49da
  Author: Seonggon Cho <jmsmg1@me.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  mpris-proxy: Line-buffer stdout

mpris-proxy reports adapter and player changes with printf() but never
flushes stdout. When it runs as a service (tools/mpris-proxy.service)
stdout is a pipe to the journal, so glibc fully buffers it and nothing
is written until 4 KiB have accumulated or the process exits.

On a system whose Bluetooth adapter went away and came back every two
minutes, the "Bluetooth Adapter /org/bluez/hci0 removed" and "... found"
messages reached the journal in bursts of exactly 100 lines (about
4096 bytes), all carrying the timestamp of the flush rather than of the
event, i.e. up to about 80 minutes late.

Set stdout to line buffered at startup, as bt_shell_init() already does,
so every message reaches the journal with an accurate timestamp.

Assisted-by: Claude:claude-fable-5-1



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
