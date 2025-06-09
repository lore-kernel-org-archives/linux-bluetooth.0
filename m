Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EEB1990D9
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480596; cv=none; b=SCnkGwntRvyvXwb5ENjFYv9C48nBR974319yUqEdS/GVdsxSfwIYGm3JC1wejD4Pk70bhmcoVIAYneKuRt8nE2MTARmJ1LLkkR2b+lci/Xr/D8Rzo0reId+8ao2BA6Mdjz95gLFIeU4BOiTkfoknWDSBA+g31yYBSNniMKDOd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480596; c=relaxed/simple;
	bh=pyuEN8cR42Iy/aftkaZHtnx2lK+afrOfA7Bsi8mbwIs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZBsx4PfWHk3xi2Apf7LoyKrH1KiPvGwXkDuVFJjTpAZvg+7HJM4DxN6wUAmReckOCyTpl0Cv3c0FfBeso/ByUJP1vWGfIyCdd2u/PiR+ZfQ7nkLPlimeWipTtD0JEmAb/J/PsciOAKVufkQ3IHjw5ortMl+0hAgALlS26uAOMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QWFsIslk; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QWFsIslk"
Received: from github.com (hubbernetes-node-a19dd88.ac4-iad.github.net [10.52.139.34])
	by smtp.github.com (Postfix) with ESMTPA id 247007009E8
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749480594;
	bh=2PVDHtzXh3nbQXesZ01TbaAeTmXJgDesBn/B+oaEQa0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QWFsIslkk016nRzxlfZ7E6onuslOJIQk2IXLYEDOj7RBY6Jb6QaJE3VDRgjt2qW3m
	 1KIGscuiS98NAWY8MlJ2YhGSM3SsnxzwfQSHNQ5sQGQEX+VNp5ogidaFlQcfdMp31q
	 M9sYk2u2AewDCaoba6QeoGEn6M6pCiSv5SxBTaLU=
Date: Mon, 09 Jun 2025 07:49:54 -0700
From: Dmitry Sharshakov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969870/000000-3ba7e4@github.com>
Subject: [bluez/bluez] 96efce: btdev: implement extended advertising
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

  Branch: refs/heads/969870
  Home:   https://github.com/bluez/bluez
  Commit: 96efced991dd3d3b6b01aeb0007ba2695928f76e
      https://github.com/bluez/bluez/commit/96efced991dd3d3b6b01aeb0007ba2695928f76e
  Author: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: implement extended advertising

Increase maximum advertising data length and implement
LE Read Maximum Advertising Data Length command.

As expected by Zephyr BAP Server


  Commit: 569cce3a98713a1092c573996419c8cee85b3bcf
      https://github.com/bluez/bluez/commit/569cce3a98713a1092c573996419c8cee85b3bcf
  Author: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: fix LE Remove ISO Data Path command

Fix errors in BAP server


  Commit: cd489c31880a04ee70d8204e827498e7a2118a35
      https://github.com/bluez/bluez/commit/cd489c31880a04ee70d8204e827498e7a2118a35
  Author: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M emulator/main.c
    M emulator/server.c
    M emulator/server.h

  Log Message:
  -----------
  emulator: add option to listen on TCP


  Commit: 3ba7e4396bc50bcf11fc1a35f9e81525390eabce
      https://github.com/bluez/bluez/commit/3ba7e4396bc50bcf11fc1a35f9e81525390eabce
  Author: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M emulator/server.c
    M lib/hci.h

  Log Message:
  -----------
  emulator: server: handle ISO, use BR/EDR+LE 5.2 by default

Allow passing of ISO packets via the socket by parsing their header.

Set version to 5.2 to expose ISO/CIS and other LE Audio related
features when using server mode.


Compare: https://github.com/bluez/bluez/compare/96efced991dd%5E...3ba7e4396bc5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
