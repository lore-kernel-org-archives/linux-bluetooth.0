Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FE1DE2A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128748; cv=none; b=O+x6Oxk8P1dWyTE7GpWJrek/REKwsk7O+RQRHkr3CJ181rA5vdR1N4HS5PNGi3OY5Lp4f45VqS82aQEiExhv0XGc5Bq9HUhKkOix0lLRRSvcJAYVQr9nOqSTQgzdsh/lH+Ya1W+LXckhi5/DAYvehlKXeb3r0T+Wv/j+54Gxofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128748; c=relaxed/simple;
	bh=AGI0u4i0exvwbTWgSkQ+hDqphAfXYwYLGs/FD1c4C9o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pse7F3kcjyez3Vt+HJZ/mNIgv5qYEAvNj0defgaTYss7olnfMKhV+KqF8qJzemKJ+R9m99paaNroQFEB1fZfyJgADOZmDFD7UYIYIUCSyK1Y337GmropfGYRcne9VQsGUs13gba7JdMZ64fFCUVk0VrNc2SMswOGsLipAhQLRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HWZhsnL7; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HWZhsnL7"
Received: from github.com (hubbernetes-node-17fba82.ac4-iad.github.net [10.52.208.93])
	by smtp.github.com (Postfix) with ESMTPA id B25635E142C
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730128745;
	bh=J8ChXn9nAJLD9qeHZP4S322a5GCJ41KAu2lrRnzqrqQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HWZhsnL7/ePGI236PohXEOCTSNfY3Mchu/WhIvIJPbebBk7mtiMb8OpL3RWwq8wDr
	 4ZfbI0AEp06lq3emxNhokgLUcknhVv/80HeyREjHi6CCG23JAAyiZvKmyu0Sh8C8n8
	 u3WJf6DKcTSMPDZJToxusQx0UqBd/AUFtiY7A1A8=
Date: Mon, 28 Oct 2024 08:19:05 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8c8ca7-c009be@github.com>
Subject: [bluez/bluez] 1782bf: input: Add support for UserspaceHID=persist
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
  Commit: 1782bfd791f76317a3f3ded2884606c1b5b164eb
      https://github.com/bluez/bluez/commit/1782bfd791f76317a3f3ded2884606c1b5b164eb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-28 (Mon, 28 Oct 2024)

  Changed paths:
    M profiles/input/device.c
    M profiles/input/device.h
    M profiles/input/hog.c
    M profiles/input/input.conf
    M profiles/input/manager.c

  Log Message:
  -----------
  input: Add support for UserspaceHID=persist

This adds support for persist mode via input.conf:UserspaceHID but
don't default to it since this appears to create more problems than
it solves.

Fixes: https://github.com/bluez/bluez/issues/983
Fixes: https://github.com/bluez/bluez/issues/977
Fixes: https://github.com/bluez/bluez/issues/949


  Commit: c009be5c5973eeef7783903ec02e359d5b035654
      https://github.com/bluez/bluez/commit/c009be5c5973eeef7783903ec02e359d5b035654
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-10-28 (Mon, 28 Oct 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: ucast streams can only have one link

In unicast, linked streams mean bidirectional CIS.  Ucast stream can
have at most one linked stream.

Fix ucast streams to have only single link. This fixes eg. configuring
for AC 11(i).


Compare: https://github.com/bluez/bluez/compare/8c8ca715e05f...c009be5c5973

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
