Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603411D86FF
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788050845; cv=none; b=JFR/4QgUqpoBaGEDQa9GbWQ+LoKOVIkPLtfj12Yg3Uju2ajsjVnPGhaHT0Gvm30aPm9DoGwKTkp+mjrXmBcWFPw7wpwCWKaA+nR7FXU9ODpwz/b1MxW1zBXBwKr1H2bunw+QTqol/GSalQ30iOT4iTYbiUyCK/PjFTiktYi93As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788050845; c=relaxed/simple;
	bh=ZjowJL90shhLhwCvUblqpkXylzAxN4mwAM+Zq4ODyMs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B9sohNOCR9fGTo1pNiY+xZpVe3FnjHT9M3uQNHMYimer0UaX+5W9101wCmk0w9Z7ObZPldEEPAG2l5o7ZxuuXAHh3hSXh2o/zHZR/DYOvq8TY+YZBaEWxd3HVjnsq37stE6dJNACGIUJ9CtW7Qim6GyxpkvzwJgD6IpzUZsJlx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bdUVFd0Q; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bdUVFd0Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788050843;
	bh=oYA8D0m+lDewSIPnnNXEQAsao4aKZl/4N7L5bwJY8dM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bdUVFd0QURP5ugPAoYtfn0FWtm+Ck2Qi7iQaCGcIZA6Wpbx9JFu3HJ8U8Ofix0P0T
	 4jYdPY5Fb8JBQ816XkGXc/Fdd1xQp0AqZ+fmfl7Axt84deEF9326QiYzOAgI/PvZ2A
	 Qr9VyPVSgX+Z5ErD79O/9UnwagtU3Z0Gr57jhKwc=
Received: from github.com (hubbernetes-node-32e1ab1.va3-iad.github.net [10.48.77.77])
	by smtp.github.com (Postfix) with ESMTPA id 20CDC341026
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 17:47:23 -0700 (PDT)
Date: Sat, 29 Aug 2026 17:47:23 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1153725/000000-80ad2f@github.com>
Subject: [bluez/bluez] 7d9c6f: emulator: bthost: don't crash on ecred_conn_req
 wi...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1153725
  Home:   https://github.com/bluez/bluez
  Commit: 7d9c6f97282b702a2bf19cff70668183139f159b
      https://github.com/bluez/bluez/commit/7d9c6f97282b702a2bf19cff70668=
183139f159b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-30 (Sun, 30 Aug 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  emulator: bthost: don't crash on ecred_conn_req with too many scid

l2cap_ecred_conn_req() crashes if the request contains more SCID than
specification allows (5).

Respond 0x000C - All connections refused =E2=80=93 invalid parameters to =
such
invalid requests.


  Commit: 80ad2f628f4b568b8167fe763f9721f2f3c26587
      https://github.com/bluez/bluez/commit/80ad2f628f4b568b8167fe763f972=
1f2f3c26587
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-30 (Sun, 30 Aug 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: add test for too many ECRED deferred sockets

Add test tries to trigger connection with 5+1 ECRED channels, and
require the last connect() shall fail with -EPROTO.  On some kernels
this causes invalid ECRED REQ be sent with 6 SCID, and stack overwrite.

L2CAP Ext-Flowctl Client - Defer limit


Compare: https://github.com/bluez/bluez/compare/7d9c6f97282b%5E...80ad2f6=
28f4b

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
