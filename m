Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020A325782A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918165; cv=none; b=MD4p72Tg8LObLMP4sPSWBgXbdsop46PdQV7ltT2zNh/hOoJdZUH7/eyjSsxGgTGyUCm+RjTpejn9IyC7NfC64wFuMOJPSnSjP00fMtLLXGpdR61WnpeUiSRNG8MZX4eMWtbtT3FNmct+NUTHC41niaU+KSHsr7OG0S/ANGxztSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918165; c=relaxed/simple;
	bh=HNkpEMjDMntMYpro5W5inj8vFmtEx+EcFmI0tPNlSJ0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aCQnowKCruC0m1O168pvUIfCbZhYlkmPgLpUttSTuNkx5VGDe7VzfuQhm0iKkKfGJ8AsDvYSUDi5QdX6h9VBJUVs+qHDiszNXphLZEfY+Q3mCs4vKcXPXLDmN5qXSDrNVIKpylqUYWlSkLEUAvcgATthmqmXGkC1jmztSbd6h4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=G0YHf4SD; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="G0YHf4SD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780918163;
	bh=PQD/SZiI5mbi2Z6jL2uGz8etSVYLcynBeycDWqAvpCw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=G0YHf4SDdrpHf2s/fSwUIwxZWxDKuV4M8/XDqy4gEBadOyXC4mfGKMANB4GkL8Olt
	 z9asl72UzR1WgAqsKTPe/kaZiZAQaIZjirl3of1/bPRzm0gqVAbJ5yY024nmg4MBGa
	 By5GMoJiX/KgjpCL32muLVk7LtCGa+t/Fkb340ac=
Received: from github.com (hubbernetes-node-b746d89.ash1-iad.github.net [10.56.202.84])
	by smtp.github.com (Postfix) with ESMTPA id 2E9A6841088
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 04:29:23 -0700 (PDT)
Date: Mon, 08 Jun 2026 04:29:23 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107759/000000-2c1a4f@github.com>
Subject: [bluez/bluez] a8832a: device: Refactor device_discover_services
 function
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

  Branch: refs/heads/1107759
  Home:   https://github.com/bluez/bluez
  Commit: a8832a9553fb3b9c4c41723a5498f84ae1f0e280
      https://github.com/bluez/bluez/commit/a8832a9553fb3b9c4c41723a5498f84ae1f0e280
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/input/server.c
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Refactor device_discover_services function

After refactoring we can reuse function once more in function
void device_bonding_complete(...)


  Commit: 04c3a58df0f657149e12565edc87174882fd22f5
      https://github.com/bluez/bluez/commit/04c3a58df0f657149e12565edc87174882fd22f5
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Rename start_discovery function

Rename it to start_discovery_cb to indicate that it is callback function
from timer.


  Commit: 2c1a4f11da736bc4218d869fdaca7d5ac8cd1ec8
      https://github.com/bluez/bluez/commit/2c1a4f11da736bc4218d869fdaca7d5ac8cd1ec8
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix returning discovery error for Device.Pair

If discovery was requesed from pair request we will report successfull
pairing even if there was an error during discovery.


Compare: https://github.com/bluez/bluez/compare/a8832a9553fb%5E...2c1a4f11da73

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
