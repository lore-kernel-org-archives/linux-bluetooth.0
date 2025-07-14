Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A952E370F
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526446; cv=none; b=c6paKNQHIv8FC2NEZpjigkvn/7xnKvbH0uPojXGaCtYLH4HqoKLVyZ4ZO+wjXw4QF6wCUuEHdZXZpbyIVJCH4RwOtooEjdqKEpJarKgIZM9D4CEQRp5QhKGwEIU8D6v5DWaO+I3PiwhGCdaS7FGZzcY2mvWuPHB0dYGL9FO+h8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526446; c=relaxed/simple;
	bh=gfIa1nbux0YOaXQKcPLTUGHRJaw2nIjG0JcYSMp0SWA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qujcRK2QY831nxA+llBlZkJuEXFEkmCpDxXhui032oJxAbZcctZ0whfCF4X5aaqWYuRvO4MQ1Gyt6AzW0J+DAjcaxk48Fq8sk3GGrn5JICR3nkJVlgkrcbpWvU+395qKlfnLxjlF7kb6+lClFah49Ame8KRDHBwWIY+qW38qqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gBq4jSzx; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gBq4jSzx"
Received: from github.com (hubbernetes-node-c9acc27.ac4-iad.github.net [10.52.171.46])
	by smtp.github.com (Postfix) with ESMTPA id CF7566410D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752526443;
	bh=cuQdXPpH4+OTE2PKzTSSSV5NVeOstoyMKK/LTAzc4bQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gBq4jSzxzKMeVY/xdDEAT+jHaXjQIaoB+h8SHvz83hrW0fdbwV6eYtf0ywESY2fyb
	 x1TtGa4o45FanyGbWjaotxer0aQwBK6WCrVwiQSHe07VbOCMetWYOq7v1z9F+qJI6H
	 1s0+n5OLkgr+2cnWzmbaUmycz6GkODsuQz9N8B84=
Date: Mon, 14 Jul 2025 13:54:03 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/806dd7-b0a138@github.com>
Subject: [bluez/bluez] 468c58: monitor: Add sequence number and SDU length to
 ISO...
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
  Commit: 468c5877c3badced2c18e765d4a68d8b5d89e759
      https://github.com/bluez/bluez/commit/468c5877c3badced2c18e765d4a68d8b5d89e759
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M lib/hci.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add sequence number and SDU length to ISO packets

This prints sequence number and SDU length of ISO packets:

> ISO Data RX: Handle 2304 SN 48 flags 0x02 dlen 64 slen 60


  Commit: 893a47e5beb1aa1391fddb8614245d9f277920c0
      https://github.com/bluez/bluez/commit/893a47e5beb1aa1391fddb8614245d9f277920c0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M doc/l2cap.rst
    M doc/sco.rst

  Log Message:
  -----------
  doc: explain SCO and L2CAP timestamping related socket features

Add explanations and examples for SCO and L2CAP timestamping-related
features.


  Commit: db061936394d6e625c33d4e34a9f639cd3df1328
      https://github.com/bluez/bluez/commit/db061936394d6e625c33d4e34a9f639cd3df1328
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M lib/bluetooth.h
    M src/shared/util.c
    M tools/iso-tester.c

  Log Message:
  -----------
  lib: tools: remove POLL_ERRQUEUE

This experimental feature did not land to mainline kernel, and probably
would need to be done differently.

Remove defines and tests for it.


  Commit: 9e117ebee13f591a7a0376f31229c715348860b0
      https://github.com/bluez/bluez/commit/9e117ebee13f591a7a0376f31229c715348860b0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M lib/bluetooth.h

  Log Message:
  -----------
  lib: add BT_PKT_SEQNUM and BT_SCM_PKT_SEQNUM

Socket options and CMSG identifier for ISO packet sequence numbers.


  Commit: b0a1386f98c25af7db83c7ca42a13878e55e1365
      https://github.com/bluez/bluez/commit/b0a1386f98c25af7db83c7ca42a13878e55e1365
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: add tests for BT_PKT_SEQNUM

Add test

ISO Receive Packet Seqnum - Success


Compare: https://github.com/bluez/bluez/compare/806dd732fcda...b0a1386f98c2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
