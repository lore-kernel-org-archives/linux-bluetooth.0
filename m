Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45F12D201
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257650; cv=none; b=H9XR5CJ19NVQrtr1m+kIf/mOxYemuVcGKf9EaVbweJGTKcP8MEnthCjhKf3WSKdtBzrMTJgf9KIU7/OHd8jU5sFzZvPV7IL+gIitCBT480AHzbz8DVdctB72phijRyy2KdmIPtm8M7A5W7QjSTdej0V0U/nXp4cZYsBs8Pd0go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257650; c=relaxed/simple;
	bh=l69Sk01Ys3USS2abDWovhI7y9XcHi6L6bIoDYDHskow=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=X+AelLqyxX5ACV6FB0F7NUOP7HRaDiuO5RhqHVY/ArWguxXpsE9zAL90dMQg9OjAtnBIo1B4e3QUfzJhWFl9NBH3mSAExjHETbkqZrwPZvOqkdmS96M+6qG75BnOeyAeLXeiuBFJFDociWm63UqZbmbxBju1FqbPOa3f+cT0qZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A9nDuNEm; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A9nDuNEm"
Received: from github.com (hubbernetes-node-741fd13.va3-iad.github.net [10.48.160.18])
	by smtp.github.com (Postfix) with ESMTPA id 5B373E1111
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712257648;
	bh=fB0MnapLegmmN2BzBkVIaKnYnjGY0GWWWBiSHj/f0bU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A9nDuNEmsfzA0qWWEaRYLYbVH3INU0B5a2v+NomH6XEBkrfhDsZYE+Md9WQNeRX25
	 HxjIqyBObfP0YHfubFRGnabwq2hnCkg8QPyT+TAqoVfUeiEsQCWc7bWzlyD4LtSYrt
	 PWrgBHy/PHX7AVuyFcqD4RFrYSSRixlWn9x9ABXg=
Date: Thu, 04 Apr 2024 12:07:28 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b8b408-4fe4fd@github.com>
Subject: [bluez/bluez] 036583: device: Add btd_device_bearer_is_connected
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
  Commit: 036583f9bbec8540fbd85b980674aad4916d3093
      https://github.com/bluez/bluez/commit/036583f9bbec8540fbd85b980674aad4916d3093
  Author: Dimitris <dimitris.on.linux@gmail.com>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add btd_device_bearer_is_connected

This adds btd_device_bearer_is_connected and use it when testing if
device needs to be disconnected.

Fixes: https://github.com/bluez/bluez/issues/785


  Commit: b3bfe2110b7a90e285e52679679ac8f496f4ad5b
      https://github.com/bluez/bluez/commit/b3bfe2110b7a90e285e52679679ac8f496f4ad5b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M lib/bluetooth.h

  Log Message:
  -----------
  lib: add BT_SCM_ERROR

Add new CMSG type used in new kernel TX timestamping support.


  Commit: 5e85956e11e76bfffd84c095f160d0d841d38041
      https://github.com/bluez/bluez/commit/5e85956e11e76bfffd84c095f160d0d841d38041
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M tools/iso-tester.c
    A tools/tester.h

  Log Message:
  -----------
  iso-tester: Add tests for TX timestamping

Add TX timestamping test utilities in new tools/tester.h, so that they
can be shared between testers.

Add tests:

ISO Send - TX Timestamping
ISO Send - TX Sched Timestamping
ISO Send - TX Msg Timestamping


  Commit: 349d7975e6083848de90dedd2a481927eb1da4d7
      https://github.com/bluez/bluez/commit/349d7975e6083848de90dedd2a481927eb1da4d7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: Add test for TX timestamping

Add test

L2CAP BR/EDR Client - TX Timestamping


  Commit: 7158101e6c35a499c646ca9827f3366bfd3bf07a
      https://github.com/bluez/bluez/commit/7158101e6c35a499c646ca9827f3366bfd3bf07a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: set nonzero SCO mtu & max pkt

Set nonzero max pkt count, so that kernel can transmit data.
The request & accept/reject flow is not emulated yet.


  Commit: 9faf6f908fcc40ec194eb6cbae10824d809e0167
      https://github.com/bluez/bluez/commit/9faf6f908fcc40ec194eb6cbae10824d809e0167
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add TX timestamping test

Add test:

SCO CVSD Send - TX Timestamping


  Commit: 9b21ce6f7956db0343842dfea1f34586b0ec59d3
      https://github.com/bluez/bluez/commit/9b21ce6f7956db0343842dfea1f34586b0ec59d3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: handle client L2CAP conn in LE credit based mode

Allow bthost hooks to receive data from L2CAP LE credit based
connections. Handle LE credit header when receiving, and reassemble
received SDU.

Handle L2CAP LE credit header also in bthost_send_cid.


  Commit: 4fe4fda73be1f649b212dc594e3631a51b84afff
      https://github.com/bluez/bluez/commit/4fe4fda73be1f649b212dc594e3631a51b84afff
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-04 (Thu, 04 Apr 2024)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: add tests for LE Client read/write/tx-timestamping

Add tests:

L2CAP LE Client - Read Success
L2CAP LE Client - Write Success
L2CAP LE Client - TX Timestamping


Compare: https://github.com/bluez/bluez/compare/b8b4083c179e...4fe4fda73be1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
