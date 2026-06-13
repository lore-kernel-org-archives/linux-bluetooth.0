Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B6282F1D
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367244; cv=none; b=lAIJyGw5G0T2VAAa9nSjRQAHOr7ernfWNy5JJlIA9FAIfzKy7w3jg02Wn6C3UN12vTnO2ADMWgbA7MPBdmdmn7xyMyzaKJNW41e1YJcEzmhm3ClcswHunDZ28z19X1nnGVmYz538S1bkN4VAiyex2zy7hhW4qSp6NvM+XktO3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367244; c=relaxed/simple;
	bh=JCQYHIBgauNjms8Qi/PdGs7SAM3w4m8rKOYzsoh3A8Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a9/eTCrSxWMWsu0Wm+ahqFSTpWeHghQEdVPv3Je5ndyxYdXyBwxhFhl/hZE8tHGGJh6LtMMtUROy/AQ+790bAcGrgNTmFq+67wN0LGmfagraOpS8BIgHZcSCnLGvWJuXpQElqJbBVtkDVMQiSYPegOtvxOySlwxrTnBOUyBECXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iTgEWbSk; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iTgEWbSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781367242;
	bh=nP/rpXYBXffgEp3AAVJBAOcDWrTR2pAjklhfvOIodmo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iTgEWbSkgWZveMQyQFmEaxdLBchZJo6qKen5hwnkSawwbGn04htngjNn5cHxmWgv4
	 8p/q1rxky/9m09zN8l64hHBxIafKrtyBR74G8iY+SvbNYu2EMRabMKH61Ga8MyMftX
	 74sGnKndY3dAzp7s1yHVDor1aQ3atkVWZYVqrPHU=
Received: from github.com (hubbernetes-node-639220e.ac4-iad.github.net [10.55.89.35])
	by smtp.github.com (Postfix) with ESMTPA id AB2BB740C1E
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 09:14:02 -0700 (PDT)
Date: Sat, 13 Jun 2026 09:14:02 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111062/000000-13b4ac@github.com>
Subject: [bluez/bluez] 13b4ac: emulator: btvirt: support debug for -s socket
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

  Branch: refs/heads/1111062
  Home:   https://github.com/bluez/bluez
  Commit: 13b4acfd7e2369e64d7b4e8d0f7b6c029d7768d0
      https://github.com/bluez/bluez/commit/13b4acfd7e2369e64d7b4e8d0f7b6c029d7768d0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-13 (Sat, 13 Jun 2026)

  Changed paths:
    M emulator/main.c
    M emulator/server.c
    M emulator/server.h

  Log Message:
  -----------
  emulator: btvirt: support debug for -s socket server

Support btdev debug -d when using socket server -s.

$ btvirt -d -s
...
bredrle: host10: > 01 13 0c f8 00 00 00 00 00 00 00 00 00 00 00 00  ................
bredrle: host10:   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
...



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
