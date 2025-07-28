Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623021D3DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729922; cv=none; b=YexGP7EyHb5XZ7fLzLHkoL6yzUo+y92yrKgF/LxF21cE4J4IGAP/ofQNXEhCjL0L12T/cgvGoMGkZ6z+0s3yDsULb/5UUh4wsK1Y5Pvp/uhND8JWvHzHp4Rt8UH9b3x+fdBUSAyqldb2O4XAJGP5fUme8iKFRHbtRNyKFuYVQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729922; c=relaxed/simple;
	bh=wGrvgIOOVerEF4lGKQ/VosRrH/5eVhNvYTQWL49qFRM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gc+RF32N0NAKkk00701EhctcAWQCBBDqfRDgs9/0OlVs2S+5z0VOcXC2vdBbfq8fslzu/AeDZUsduYRpSB2NW3jlLyD1dVIVANRMl+9kAvAMHJOXXsCRbESVkL/dPI6rovCU2C9NprLRDsturXD9ZDU/FZiiG0EsrVKCyV24rcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kPyGFAic; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kPyGFAic"
Received: from github.com (hubbernetes-node-df9422e.ash1-iad.github.net [10.56.197.30])
	by smtp.github.com (Postfix) with ESMTPA id 49972140B75
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753729919;
	bh=B2afibzQx+SHMeytk2X968hQolzCmwgYiFACq7a2Yg8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kPyGFAicwRXysPFyamIlfzzQQmfCsn6NP/miwR0lyy+iO3QBurdsmZpjjSW64vqMk
	 wd2kYpj3BacRlhIsEi5yEAx42KWpwkeltk857Et759MA5Ex4ClAr/5yxt14DnhAHgy
	 zTOVv0HRuneZHORwb+KxC8NTaDwRj1JbQLle6V7E=
Date: Mon, 28 Jul 2025 12:11:59 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/00ffc5-0084cf@github.com>
Subject: [bluez/bluez] fd80f2: bthost: fragment when sending ISO packets
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
  Commit: fd80f2354ead90111dc6a9d9831a7dd1d5aa6352
      https://github.com/bluez/bluez/commit/fd80f2354ead90111dc6a9d9831a7dd1d5aa6352
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-28 (Mon, 28 Jul 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M emulator/hciemu.c

  Log Message:
  -----------
  bthost: fragment when sending ISO packets

Support fragmentation to controller MTU when sending ISO packets.
By default, fragment when exceeding btdev iso_mtu.


  Commit: 0084cfe5634bbe42b66b37887ed362dc26aed4c8
      https://github.com/bluez/bluez/commit/0084cfe5634bbe42b66b37887ed362dc26aed4c8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-28 (Mon, 28 Jul 2025)

  Changed paths:
    M tools/iso-tester.c
    M tools/tester.h

  Log Message:
  -----------
  iso-tester: add tests for hardware RX timestamps

Add tests for HW RX timestamping.  Also add test that sends large
packets to test ISO fragmentation.

Add tests:

ISO Receive - HW Timestamping
ISO Receive Fragmented - Success
ISO Receive Fragmented - HW Timestamping


Compare: https://github.com/bluez/bluez/compare/00ffc553a194...0084cfe5634b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
