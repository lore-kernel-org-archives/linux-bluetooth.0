Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFC221F1F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775476692; cv=none; b=usJ1OIzPfK5C+k+YhZuPaUy5cYxAMenuxsokew+NES7ZQFuOZoa4JR/AZhfZFI5t4nvIn1KubHcYuuRSg1P/L+dJn5waBOUyX/3IeWk34yku3y2SIteqThG0+f2A7WmDVz416nwGdjSmIypPzG714JK8OnHVe/bpR9bLCE1isGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775476692; c=relaxed/simple;
	bh=teWncE+NUqCHj72xG7j9rvjtsuXQoytTowUdOUmN7xo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KJWaAR5ha/DCdsMcSCMnHPlcKz7uEgw+3QVe4O6x/rUkGYKBm/Yby0YlBNUvNwQEmjSQnEGY1B3N8KfVz8MwozEsz4Nj43QmN4E+nSxm2XethsI7lXDLDWJinDziq+KBMm4rxQDyqVB9vEByi44LJ+1k5IDWTsehkMto5HQCtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GCBz2PdY; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GCBz2PdY"
Received: from github.com (hubbernetes-node-38aa448.va3-iad.github.net [10.48.180.49])
	by smtp.github.com (Postfix) with ESMTPA id 5A2A8E079A
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 04:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775476690;
	bh=fhfCeAXPKyleKCK2940ArOZDlqEVTndGMuQlZ1FuHCA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GCBz2PdY2F0jqA2gZEMvPq1BLxPt3vsAPtb3KBR5T6oJNbKxcqs292PXRM41dmgMw
	 Oy57STg2TvMV4DVnoImmygVR5znyA1yPZTtovJx3CERJJsKPVzhKsoYsUBVQa6MRG6
	 P9Kpb5CKzhnscJk8QfyqAwjemuydw4yH0kOP2aXA=
Date: Mon, 06 Apr 2026 04:58:10 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077640/000000-40f101@github.com>
Subject: [bluez/bluez] 0deb87: monitor: check data size properly in
 evt_num_compl...
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

  Branch: refs/heads/1077640
  Home:   https://github.com/bluez/bluez
  Commit: 0deb87882b0041007156b034aff458a7f62a3772
      https://github.com/bluez/bluez/commit/0deb87882b0041007156b034aff458a7f62a3772
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: check data size properly in evt_num_completed_packets

Use util_iov_pull to check data size before dereferencing.


  Commit: 2df021bda138bc5ecb5564eeb4a02f59b8b8b037
      https://github.com/bluez/bluez/commit/2df021bda138bc5ecb5564eeb4a02f59b8b8b037
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  emulator: Remove assigned but unused variables

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about.

Fixes build on gcc 16.


  Commit: 11cad0fc854df35e54ffbf0ca34d98dfceef1a34
      https://github.com/bluez/bluez/commit/11cad0fc854df35e54ffbf0ca34d98dfceef1a34
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M monitor/avctp.c

  Log Message:
  -----------
  monitor: Remove assigned but unused variables

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about.

Fixes build on gcc 16.


  Commit: 6dd5b2c31dba3c096d43c63a143a64dab44756ec
      https://github.com/bluez/bluez/commit/6dd5b2c31dba3c096d43c63a143a64dab44756ec
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M src/sdpd-request.c
    M src/shared/shell.c

  Log Message:
  -----------
  src: Remove assigned but unused variables

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about, or silence by void cast.

Fixes build on gcc 16.


  Commit: 40f101a36a12aac436ed77e69c48d2ded8dcc974
      https://github.com/bluez/bluez/commit/40f101a36a12aac436ed77e69c48d2ded8dcc974
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M tools/btsnoop.c
    M tools/seq2bseq.c

  Log Message:
  -----------
  tools: Remove assigned but unused variables

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about.

Fixes build on gcc 16.


Compare: https://github.com/bluez/bluez/compare/0deb87882b00%5E...40f101a36a12

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
