Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65293363C56
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932810; cv=none; b=WtX2v1wS6FhXhdaQASIGlC7y6ulazYp8EWeByIuphnAiJZgZn0EZRWfL7mhrs/7u4jfNOhxsHmIGXIXIPNUrtNXF1WCkF36VG+ZBDM7u84pdtLHPk/AcS9kbc5n312gc/6nolM/NTQ9o9Y2BzzhH2DNQXsF4KTu6hZ+XMHbNqYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932810; c=relaxed/simple;
	bh=PQ/FGeYv1/7sOCo5lTmwGp7UvJZA8mi2wH7Kk0PdEZY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YlG/Wx2HZYPmIGlRgZ6ng70FMdbqGO9mrmMKabsam29jQ+xyHgPzwni25FZ5HVjjIwIDF2Ua0gP/g8zI7VI0BFJXb6G1sJQMcLi2nKyb8GgyR1W35Td2r74ekx53xdPA1HD54d1P67OMrsey8cfLu4d6SR9dOMpCWdEqfBknoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VVNcU2J7; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VVNcU2J7"
Received: from github.com (hubbernetes-node-4750e8f.ash1-iad.github.net [10.56.84.25])
	by smtp.github.com (Postfix) with ESMTPA id 69A88121113
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773932808;
	bh=RpnlckpnulsLhgizJggo876ggakS9e87q02b4wVmpFA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VVNcU2J7B3+axFIESHUPBZb5cZ4FUL27rRJSZTRdnmtEbCGLO4aXpzD62EgIXMzBJ
	 oHFCiEGytk0h8v4qUcmXAA05ieaMI7/iWPrtsEWEkr6pH9Yrv9hOL41UuzMoLKpzwE
	 GJLuMb+vAij8++2NHRBVmk1Qz8237shr9WENSPeg=
Date: Thu, 19 Mar 2026 08:06:48 -0700
From: Wouter <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1069318/000000-183f1a@github.com>
Subject: [bluez/bluez] 183f1a: shared/shell: Fix SIGSEGV on invalid input
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

  Branch: refs/heads/1069318
  Home:   https://github.com/bluez/bluez
  Commit: 183f1ac1578b41868c56b5527139f27a2d04a2a0
      https://github.com/bluez/bluez/commit/183f1ac1578b41868c56b5527139f27a2d04a2a0
  Author: Wouter <wouter@xesxen.nl>
  Date:   2026-03-19 (Thu, 19 Mar 2026)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix SIGSEGV on invalid input

This fixes a crash when handling "<space><tab>"

==3760495== Invalid read of size 1
==3760495==    at 0x4902187: strcmp (vg_replace_strmem.c:941)
==3760495==    by 0x4067408: menu_completion (shell.c:1126)
==3760495==    by 0x40675DE: shell_completion (shell.c:1177)
==3760495==    by 0x4B267AB: gen_completion_matches (complete.c:1282)
==3760495==    by 0x4B2F8C1: rl_complete_internal (complete.c:2104)
==3760495==    by 0x4B26B52: _rl_dispatch_subseq (readline.c:941)
==3760495==    by 0x4B27B71: readline_internal_char (readline.c:690)
==3760495==    by 0x4B48695: rl_callback_read_char (callback.c:275)
==3760495==    by 0x40655F2: bt_shell_input_line (shell.c:309)
==3760495==    by 0x406577E: input_read (shell.c:343)
==3760495==    by 0x4068CB4: watch_callback (io-glib.c:173)
==3760495==    by 0x49C1F4C: g_main_dispatch (gmain.c:3565)
==3760495==  Address 0x0 is not stack'd, malloc'd or (recently) free'd



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
