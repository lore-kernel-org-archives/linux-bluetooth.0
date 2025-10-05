Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D028E9
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Oct 2025 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759703204; cv=none; b=hxudAnZSVxppLl/wddisKEM1Sx/iEJtD9KAUf/fQYczBnxk1F8fENJ4xIzhp3cJ/NtNLnKBbX4quhiYu0zzhKNaxdIWISD2EBHMQ0HnybXPwlgdvUHfl2mkWRIm2SEBcwWh/PEb1yjhc2PgmWt2WCBV5VDZkQQDhJmbAeE74oHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759703204; c=relaxed/simple;
	bh=8Z7I3uFcmOsDWwUUjHqxP+lBqEClhUnLgUYqH3OvhY4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iedcxlegTOoVHu+wYjtghtKRqMcqWvWC1rZ5S/0+CZ3jLF+A307QK+kOGw7E86LNIAuqqS5PCch3x8GLw3VEP4YSRVME7fQ+yi82wREGb9MgbFAeKUXNjpFjQVyykdO7U6aex2+v0TX9SHMM9+rIu1gkoUYGBwCFzhGtTGO0L2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PTY3tNC2; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PTY3tNC2"
Received: from github.com (hubbernetes-node-a61110a.va3-iad.github.net [10.48.220.99])
	by smtp.github.com (Postfix) with ESMTPA id 24F44E0422
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Oct 2025 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759703202;
	bh=+x7znhQLSY6Iv4Kn1eWsnSW6bwU9Dg7ieIPozqctMzU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PTY3tNC2vScZDZChSG6j+yRtP8/EWoywsI4wvCMAQS+9Hcz3zx1hDs7vZKPRgXLXl
	 iQe9Y0JpdNcaZmwQEU4mxonYFlM1JvcrfBGSCyfpQkx9Mix3e5hKwuK89T5l5vSYSQ
	 BEZ5OfvBTQT3Ij7KQDdJZYOeftpj2lGplgRguOXg=
Date: Sun, 05 Oct 2025 15:26:42 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008564/000000-a0dda3@github.com>
Subject: [bluez/bluez] beecf8: bthost: handle L2CAP_DISCONN_RSP and remove
 l2cap_...
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

  Branch: refs/heads/1008564
  Home:   https://github.com/bluez/bluez
  Commit: beecf8acbff7660f7bef1ea6988e8fa90b98c2d8
      https://github.com/bluez/bluez/commit/beecf8acbff7660f7bef1ea6988e8fa90b98c2d8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-05 (Sun, 05 Oct 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/l2cap-tester.c

  Log Message:
  -----------
  bthost: handle L2CAP_DISCONN_RSP and remove l2cap_conns

Handle L2CAP disconnection response. On receiving disconnection request
or response, remove the associated connection.

Change disconnect handler signature to take also the handle and CID.


  Commit: 711e559d23b11bfa56bd15d6e13c4b036b0cc242
      https://github.com/bluez/bluez/commit/711e559d23b11bfa56bd15d6e13c4b036b0cc242
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-05 (Sun, 05 Oct 2025)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: handle L2CAP_FLOW_CONTROL_CREDIT_IND

Parse L2CAP_FLOW_CONTROL_CREDIT_IND and track credits, instead of
sending reject response.  Nothing is done with the credit counts
currently.


  Commit: 95c839b757f40c0db5446f869da53990c971070e
      https://github.com/bluez/bluez/commit/95c839b757f40c0db5446f869da53990c971070e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-05 (Sun, 05 Oct 2025)

  Changed paths:
    M Makefile.tools
    A tools/6lowpan-tester.c

  Log Message:
  -----------
  tools: add 6lowpan-tester

Add 6lowpan smoke testing. It only exercises the kernel 6lowpan L2CAP
connection handling, ipv6 testing is mostly out of scope for the tester.

Add tests:

Basic Framework - Success
Client Connect - Terminate
Client Connect - Disable
Client Connect - Disconnect
Client Recv Dgram - Success
Client Recv Raw - Success


  Commit: a0dda34804c7927708229b3375a6fb37cec765fa
      https://github.com/bluez/bluez/commit/a0dda34804c7927708229b3375a6fb37cec765fa
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-05 (Sun, 05 Oct 2025)

  Changed paths:
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable 6lowpan in tester.config and explain in test-runner.rst

Now that there is a 6lowpan-tester, enable requirements in tester
config, and explain what is needed in test-runner.rst


Compare: https://github.com/bluez/bluez/compare/beecf8acbff7%5E...a0dda34804c7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
