Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F61A1FCCF2
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336016; cv=none; b=n1EaqwHkTVmWCD0T13hokLmMoMG6SAWtd3t0hj3PbY0h28yiEJmJT4tO9xdd/D+hppfON4bNbm6bavWbI7R4vlg1CjSHVeiOSWSua6bbsjUQl23+ilRkbcn3kn7Jp8MOirfrN0rceDSZg46Ok+6Hg7TmqfGov3EjNZ8Vj6xuu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336016; c=relaxed/simple;
	bh=rftD2s4UantuypfnH1/QPbyTncy389cuQZane2LfuB4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BpGULTGAzxQbKDQJp2P/Qxk6kEsuhYcjV7E+5/7oOdg/XJsSK3XrKuhXObXB8tq/UepfTUZCJgc7gqb/PawM5WMO/40ek4bg2T5VfsDrhM/NOotUg9UB4USrpHzw0s7XymlBl01l+joZNgfqI6HTYub1e+u3lKKoK6xZlVmj5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VoQxWvVQ; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VoQxWvVQ"
Received: from github.com (hubbernetes-node-b190362.ac4-iad.github.net [10.52.200.39])
	by smtp.github.com (Postfix) with ESMTPA id 3AB3E2123A
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1742336013;
	bh=8h8C1SlT7klF3SZzffb++m0IvPtnEa3zOvmqVaxHZ4U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VoQxWvVQE6oJMGv8wIc+wM/5SBoXemDgbJQB5ZqT6r/ZND3hYJIk+qPsrUBm1wnJW
	 e8aZFVuYvdFzAcbcmai/P5QtlX+FF59tGKkZgHHrwz2FLxHajfyxq7/yciEQnOGfAo
	 BA86Unwhyhho89gcFBeMcgFFfLhU68klEgw2zFsQ=
Date: Tue, 18 Mar 2025 15:13:33 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3b9a6d-f4b6a6@github.com>
Subject: [bluez/bluez] c89e18: tools/tester: test COMPLETION timestamps
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
  Commit: c89e18fa55e2d261e002a1f667eb8f351e0258fb
      https://github.com/bluez/bluez/commit/c89e18fa55e2d261e002a1f667eb8f351e0258fb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-03-18 (Tue, 18 Mar 2025)

  Changed paths:
    M configure.ac
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/sco-tester.c
    M tools/tester.h

  Log Message:
  -----------
  tools/tester: test COMPLETION timestamps

Add support for SOF_TIMESTAMPING_TX_COMPLETION also in cases where
errqueue.h is old and doesn't define it.

Support timestamps of different types arriving out of order, as multiple
SND may well arrive before COMPLETION.  Also allow TX timestamp arriving
before bthost receives data, as that may well happen.

Remove tests SCHED timestamps, as those won't be generated for now.

Don't test COMPLETION for SCO, since it's not supported now either.

Add test:

SCO CVSD Send No Flowctl - TX Timestamping


  Commit: fe5a5f509e0cd1ab60e524863dbacd461fb38023
      https://github.com/bluez/bluez/commit/fe5a5f509e0cd1ab60e524863dbacd461fb38023
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-03-18 (Tue, 18 Mar 2025)

  Changed paths:
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/sco-tester.c
    M tools/tester.h

  Log Message:
  -----------
  l2cap-tester: add test for stream socket TX timestamping

Stream socket TX timestamp ids shall refer to the byte positions.
Add test:

L2CAP BR/EDR Client - Stream TX Timestamping


  Commit: f4b6a649ccdd0ff63817bab13b9c94f2bc3d648e
      https://github.com/bluez/bluez/commit/f4b6a649ccdd0ff63817bab13b9c94f2bc3d648e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-03-18 (Tue, 18 Mar 2025)

  Changed paths:
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/sco-tester.c

  Log Message:
  -----------
  tools/tester: enable TX timestamping tests by default


Compare: https://github.com/bluez/bluez/compare/3b9a6d3f6186...f4b6a649ccdd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
