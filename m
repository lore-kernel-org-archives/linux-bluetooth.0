Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C5313278
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967375; cv=none; b=Y+Q0g3EliPrpmV/wTEub3FqawbjaXRq6J2opvm5XcXzVK1t7ThGlf1bwwdlNhbsp/ZvpqTyE74Nvy8f7xZ4iIykDtWGXoBVKmUhioOzcT4x7dwBR//v2o7MsD4+/qBddoJVgfWuw/aLH3TDfKbZ6u+Cip01YYiCVAcolUUWCR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967375; c=relaxed/simple;
	bh=NuJ2/083Sfv5DXeWo4EaW44dmlRPCXWpDc3SHjd4ktw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=reUMPAnHnLjJAPGblPf/O/7Lz0TVdiv+IOpxo/IPJdAKX9ySB5MfRuuMYdHTMdP/wD8pA8KwNsaOiHKMZwjhzgRqd5I6NOHFYwqD5I4bGnRuwXhclIT0rx+MULTDp+5wysYL5JiLqBUDKb9g0g+lgyjuBXeSXoTu1q5foknW03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jDiBhAsw; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jDiBhAsw"
Received: from github.com (hubbernetes-node-cab0cf5.ac4-iad.github.net [10.52.14.26])
	by smtp.github.com (Postfix) with ESMTPA id 7495B640CF1
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760967372;
	bh=crgnzGKr9c9dWMDsFf27ZOj2UrUfaVAZPQOySZuV57Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jDiBhAswu5qsa/KA3JpfALubJLQJR4BzYOmKTvjXe5D0KyT+phYjGOj+P3xIUb7Tt
	 sfsJofH0xKalVk5reBz0Q2qpRgezi+UbYbVMe63RxnWbpRCXAfj7ktvOGOh/fsW42Q
	 ED7JGzW9yOgLg/OblVC37tQ9FeQet/q+crim93EY=
Date: Mon, 20 Oct 2025 06:36:12 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8d181e-39b541@github.com>
Subject: [bluez/bluez] c58433: bap: tolerate inverted STREAMING and
 iso_connect_cb()
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
  Commit: c584335d44365520d14bc63abeaa48dd3da9a38f
      https://github.com/bluez/bluez/commit/c584335d44365520d14bc63abeaa48dd3da9a38f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-17 (Fri, 17 Oct 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: tolerate inverted STREAMING and iso_connect_cb()

Ordering of STREAMING and iso_connect_cb() is unspecified, as
kernel/Glib do not preserve the order of these events.

STREAMING before iso_connect_cb() causes transport to fail Acquire()
since bt_bap_stream_io::connecting == true.

Fix by marking IO as connected even though the connection didn't yet
complete. The socket fd is valid, although not yet writable/readable.

Fixes: https://github.com/bluez/bluez/issues/1506


  Commit: bac077c96b67c8db8df76a49f68f4493db39fc61
      https://github.com/bluez/bluez/commit/bac077c96b67c8db8df76a49f68f4493db39fc61
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-17 (Fri, 17 Oct 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: wait until BAP fd is writable/readable before resuming

Connection may still be pending when entering STREAMING.

Wait until the fd becomes readable/writable before continuing.


  Commit: c2d072641aa9015fdfab196d095566fea364d4dc
      https://github.com/bluez/bluez/commit/c2d072641aa9015fdfab196d095566fea364d4dc
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-10-17 (Fri, 17 Oct 2025)

  Changed paths:
    M src/shared/uhid.c
    M src/shared/uhid.h

  Log Message:
  -----------
  shared/uhid.c: Fix 32-bit integer truncation

Id paramter given to bt_uhid_set_report_reply() and
bt_uhid_get_report_reply() corresponds to a 32-bit tag value passed to
us from the kernel side of UHID. Specifying this parameter as uint8_t
breaks the synchronization after 255 request and renders the attached
BLE device inoperable.

Fixes: 92ed637ab2bc ("shared/uhid: Add dedicated functions for each UHID opcode")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


  Commit: 50487180813dfa7e7f106076e0cb9c5c0ad58bb3
      https://github.com/bluez/bluez/commit/50487180813dfa7e7f106076e0cb9c5c0ad58bb3
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-10-17 (Fri, 17 Oct 2025)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Fix 32-bit integer truncation

Id paramter stored in getrep_id and setrep_id corresponds to a 32-bit
tag value passed to us from the kernel side of UHID. Specifying this
parameter as uint16_t breaks the synchronization after 65536 request
and renders the attached BLE device inoperable.

Fixes: cdddd7e69e06 ("android/hog: implement get_report functionality")
Fixes: 83ed02d06fca ("android/hog: Implement set_report functionality")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


  Commit: 39b541edb2731204c988ab329afc0e226c0b8c76
      https://github.com/bluez/bluez/commit/39b541edb2731204c988ab329afc0e226c0b8c76
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-10-17 (Fri, 17 Oct 2025)

  Changed paths:
    M plugins/hostname.c

  Log Message:
  -----------
  hostname: Remove unneeded include


Compare: https://github.com/bluez/bluez/compare/8d181e4e4a06...39b541edb273

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
