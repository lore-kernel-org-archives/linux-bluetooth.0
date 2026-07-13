Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1F1E1E12
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957548; cv=none; b=Co6m6PiPPDd81xQafJhs6bvS26esACcWy9cLbURxCduXDcgFHOYYTPLj4TwCWaQ4XKQ5e0LGeMKDfWixM80bH2NbVB0xhNd4ILSOKBt6xYRwgDbkk69R9EwCV7hDzqatRZss8gMxuuSPoxMP3vrKCWmZsd364kYK3oM3HovUhAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957548; c=relaxed/simple;
	bh=fBx9jNHLwgZH0zF5QDeyzWjWkqAu3o0/pykRaaTWOHg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=swQq/AD8I+jKe/WnJQyZtNvVjVY/uqk2/4YoKgvdOvUPQHS+1wXfHHCDYbDX6bxM8nSF4n5jDZv50e4NrwVBW1jTeZkPOFEUFricus6b3jwOk4phYT2quwOlIOvAeuqWqLTZY4AItjncQTCYrsofnc2Ljohu8b2zvJHh6ob+XPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XanZyFWa; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XanZyFWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783957546;
	bh=ivN94xqyU0e0NpyiRqHK9ebUuPfz6ryI4d6YJauE/9A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XanZyFWaK9H4EGV1JXGWyU9lfh4vF93+9VdPHZTmns43D8AI9ncZ9w5ZChKmaEClk
	 0u09QiMqzgn8LUiU4K1mvER68oWvHadKPzrDjaaI423gTnRo5ScPg45Qqa0Bmrsqwk
	 T81Nz1DPS6+e9LNXWu8Um/qyeEVV82jBkpTdkZ5U=
Received: from github.com (hubbernetes-node-aeceebd.ac4-iad.github.net [10.55.99.33])
	by smtp.github.com (Postfix) with ESMTPA id 5713B40400
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 08:45:46 -0700 (PDT)
Date: Mon, 13 Jul 2026 08:45:46 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1126713/000000-014940@github.com>
Subject: [bluez/bluez] d2c7b4: tools/sco-tester: fix missing clear of io_id in
 ca...
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

  Branch: refs/heads/1126713
  Home:   https://github.com/bluez/bluez
  Commit: d2c7b4d5e9e1b1593c4a42ebf50a03bfc6a75adf
      https://github.com/bluez/bluez/commit/d2c7b4d5e9e1b1593c4a42ebf50a03bfc6a75adf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  tools/sco-tester: fix missing clear of io_id in callbacks

Fixes issues

GLib-CRITICAL **: Source ID 126 was not found when attempting to remove it


  Commit: 7a59e65f97de3b074ee3fff383ea8c6d554817fd
      https://github.com/bluez/bluez/commit/7a59e65f97de3b074ee3fff383ea8c6d554817fd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  tools/6lowpan-tester: fix race in Client Connect - Disable

It's possible client_l2cap_disconnect_cb() is called after 6lowpan
disable on connect. Prevent failing test in finish_step() in this case.


  Commit: b8406469847f2b89c32ff698dc9f0fb5992ee029
      https://github.com/bluez/bluez/commit/b8406469847f2b89c32ff698dc9f0fb5992ee029
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  tools/6lowpan-tester: add test for VHCI teardown without disable

Check 6lowpan teardown when controller disappers with active devices.
Add test

Client Connect - No Disable


  Commit: 0149405c62f18c69de814a4b24c35776a8ace540
      https://github.com/bluez/bluez/commit/0149405c62f18c69de814a4b24c35776a8ace540
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-13 (Mon, 13 Jul 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: fix Set PHY test spurious failures

Setting BT_PHY does not take effect instantaneously as kernel waits for
controller, so checking getsockopt() sometimes fails here. In PHY tests,
use retry with timeout to check again later.


Compare: https://github.com/bluez/bluez/compare/d2c7b4d5e9e1%5E...0149405c62f1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
