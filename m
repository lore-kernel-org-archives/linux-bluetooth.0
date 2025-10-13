Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E827A477
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379972; cv=none; b=TI41Ekko1pbVbpFWmdnDzBHEGRFyAXRu0yx+MXa+YyYkzJNCDLRw8rzBFozOZgMqrKCdJdKquwbMGnetnA6dFGg70wY2xcvA6yItSnORIAwSyAnJi1vUadrw0bnz119K1tNJOlBbtOF+HWfP8C2hgezcU5fAHyaUJRWlxTcf43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379972; c=relaxed/simple;
	bh=KbsVdu7lMaU/UutGvehI+S85plVG23e/x1RraJaHC8I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sErTSkCqqFmu/6tZvE46ThyB0k1BjuzSJDcUK2tnZ3ORYgwo9JTHvNJwnnYyb8AnALe7HJmw/oPDcgfKGszZ5HG7qhCXpkJXqHkioolVhFwtNKvVPIbC+Gk7LfpUGS3+EXNK8AMkcSCA0rKfZdM8DkS0LRcJkkZSjaLbxOkOg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LzodUhS0; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LzodUhS0"
Received: from github.com (hubbernetes-node-73331f0.ash1-iad.github.net [10.56.128.50])
	by smtp.github.com (Postfix) with ESMTPA id D09D89211D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760379969;
	bh=JcJFaapCDaBWiZYlEye+dczDx9dWMjbrJURljmCu4V0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LzodUhS0GyF0vcYmcrUfDd3f1zVD4aWvaLFvFKEIWRhzgPHhYsZonWEvcmvu85IbW
	 41GoffIrQzcO7ZqUBiHeQILo8h+IZIZcaa6rT2AsMya9n31h++kPG9J4S+0kVcTpf9
	 9NMsiNsLjatPzW9bpqOVeD8n37KrMASPzR6Eph/M=
Date: Mon, 13 Oct 2025 11:26:09 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1010888/000000-d4d506@github.com>
Subject: [bluez/bluez] c34787: tools: add 6lowpan-tester
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

  Branch: refs/heads/1010888
  Home:   https://github.com/bluez/bluez
  Commit: c347870b7794a8b0c8c962830a079e8af3d4fe14
      https://github.com/bluez/bluez/commit/c347870b7794a8b0c8c962830a079e8af3d4fe14
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

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


  Commit: d4d50668c8bc4f402b1a71923b515b521e01727c
      https://github.com/bluez/bluez/commit/d4d50668c8bc4f402b1a71923b515b521e01727c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable 6lowpan in tester.config and explain in test-runner.rst

Now that there is a 6lowpan-tester, enable requirements in tester
config, and explain what is needed in test-runner.rst


Compare: https://github.com/bluez/bluez/compare/c347870b7794%5E...d4d50668c8bc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
