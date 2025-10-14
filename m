Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94732308F39
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475512; cv=none; b=J8dYlq6E9YwXNug7b3MeDPZabO/XdxfmGc8PyKgVdNr/f/Ou0ed/5qvScLbtOKx0+cLnJ4wzfomOaxnI2B5VfO5uDVQZvYgEgg/zzUt83LddGFfeYf4Zqp9GzCPx8l1BvI8Fjb8AXx09NbeU0q5/dApRUvAnMBCy1Ok8P7usTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475512; c=relaxed/simple;
	bh=mHMYxOIZegyZJPKMp8sZt+Ll6z9pPtG0WsBxWlSDdEI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ngzeaRAHwMDdYoRNEbvZgHqnYvK19Z25k30h16orGPlKCRU4HWP9SLpTH9Rj4K9yfC1bsv+p102LvqpxVfeevO8rdQ8LVbi6RJNVsgr6ojgXuCbPJRQB+0x7QBD3sgXGe4EhWBxIboShyl497rdV0DVZFxLgvjTeWBcwHjjF6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FApPUe5q; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FApPUe5q"
Received: from github.com (hubbernetes-node-1edca12.va3-iad.github.net [10.48.12.42])
	by smtp.github.com (Postfix) with ESMTPA id A36708C06F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760475509;
	bh=zHGE2WG2L0bRUSIHlytQYf8a3z1QmuwDp8RYl8OF0A8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FApPUe5qzDU4AsK1l2Vtipe1fTBb1VzCa2QCbTou3q5lYkL/Pt7dGj4mTNGKy3Bk/
	 6amwbRi9QdBOkr4mEuJGtf+OZ+NLiqqbesxzG/kv+bZKkQXi+fU3vj2m7cloEnjimI
	 vDGEMQ+lyZfA4ZSQ9oM+ecZLWUKmVSHk6EgGt8EM=
Date: Tue, 14 Oct 2025 13:58:29 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1011519/000000-3f1f13@github.com>
Subject: [bluez/bluez] c27221: monitor: Use PAST to refer to Periodic
 Advertising...
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

  Branch: refs/heads/1011519
  Home:   https://github.com/bluez/bluez
  Commit: c27221c2d730ca794182c18eb615cf56cada6d48
      https://github.com/bluez/bluez/commit/c27221c2d730ca794182c18eb615cf56cada6d48
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Use PAST to refer to Periodic Advertising Sync Transfer

This simplify the command and event names and their structs to just
use PAST in place of other terminology currently in use.


  Commit: bdc72a05b97ca045ae47f20a3e2fad59c8a308e1
      https://github.com/bluez/bluez/commit/bdc72a05b97ca045ae47f20a3e2fad59c8a308e1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M client/scripts/broadcast-sink.bt
    M emulator/btdev.c
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  emulator: Add initial support for PAST


  Commit: f33bc8d4146c436a71d586cf614b3f59c41806fc
      https://github.com/bluez/bluez/commit/f33bc8d4146c436a71d586cf614b3f59c41806fc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for PAST procedures

This introduces the following tests that test PAST procedures both as
a sender, either for colocated broadcast source or a third peer, and as
receiver:

ISO Broadcaster PAST Info - Success
ISO Broadcaster PAST Info RPA - Success
ISO Broadcaster PAST Sender - Success
ISO Broadcaster PAST Receiver - Success


  Commit: 2e978a27aa7ef663ef778cc8f42b9cad57b2e761
      https://github.com/bluez/bluez/commit/2e978a27aa7ef663ef778cc8f42b9cad57b2e761
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for PAST MGMT settings and flags

This adds parising support for PAST MGMT settings and device flags.


  Commit: 861a807eb867ec5337c84554363926a1c22c895a
      https://github.com/bluez/bluez/commit/861a807eb867ec5337c84554363926a1c22c895a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M doc/mgmt.rst
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  MGMT: Add PAST Settings and Flags

This adds PAST Settings and Flags definitions and documentation.


  Commit: 3f1f131476d2f1cb6bbbb15f26244f99f90c8cef
      https://github.com/bluez/bluez/commit/3f1f131476d2f1cb6bbbb15f26244f99f90c8cef
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M doc/iso.rst

  Log Message:
  -----------
  iso.rst: Add documentation for PAST/rebind

This documents how to use PAST procedures by doing bind on already
connected socket.


Compare: https://github.com/bluez/bluez/compare/c27221c2d730%5E...3f1f131476d2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
