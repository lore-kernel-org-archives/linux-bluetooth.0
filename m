Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F0754BDB
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183929; cv=none; b=lidVkPKzNBOR1qE1r4kpyOmfRuSfZNDYpNoG3DegtwK4BfT1v85Dr6+n+vOfQNTg164jWrTcYnGx1XK7UElXP13rdUHuoIXpj6zs4rZIVWcD0jcHt3pkcbGodvsEOQBijbJFIHA0BDvm94Kuimw08oqiL0UVAWK3n5ERMMYkt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183929; c=relaxed/simple;
	bh=oZ0nj5sfiv04jveDZVyBl3lsU1hC6StrwMRfIf/Sc1M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AGo8we/kbV1BFhgrmusA1YOubeBcSmDf5BZQq8uZpLxeUliG4AcAvIZnMRJjTn6Pyeid6L2F/3SyuEnIlB106UL/nlIyjpJLbVv2a3Rpru24UH6gq1BXNEJQTwG/Phk1BOwbD4PI1d7ey5LeMw29dzeJZeeg7HMVCLIgqCdh8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=avzHBWDA; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="avzHBWDA"
Received: from github.com (hubbernetes-node-c8f8bbb.ash1-iad.github.net [10.56.206.89])
	by smtp.github.com (Postfix) with ESMTPA id ECC1F6005EB
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1710183926;
	bh=CV/Mibulrm3877XgTQkah8CGk/SD9w1gLRUvyTGlOBA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=avzHBWDA6uN/7ZxmreEOuikWTEx8RKUhTC7GkGuQNs9Yaiyd1G9QBb8c2wyMn27WZ
	 1jyRfrAtnY0oaRH76YS+Wp9t/OQYMWc8CYb+TkAcVtZl8PobfRn7Dr3C1sU8XcGqIm
	 w5KA5zvKCjwT02jqV1xbO113GNWfz7UOy2WdmLZg=
Date: Mon, 11 Mar 2024 12:05:26 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a23239-c9dddb@github.com>
Subject: [bluez/bluez] c9dddb: shared/bap: fix setting io on linked stream
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
  Commit: c9dddb642663b8bafe8998fef6132a2bb36d609d
      https://github.com/bluez/bluez/commit/c9dddb642663b8bafe8998fef6132a2bb36d609d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-03-11 (Mon, 11 Mar 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix setting io on linked stream

Fix the second bap_stream_set_io call to set the io on the linked
transport, as it's clearly meant to.

Fixes sending duplicate stream stop/start requests.

bluetoothd[588207]: < ACL Data TX: Handle 2048 flags 0x00 dlen 11   #492 [hci1]
      ATT: Write Command (0x52) len 6
        Handle: 0x0098 Type: ASE Control Point (0x2bc6)
          Data: 04020505
            Opcode: Receiver Start Ready (0x04)
            Number of ASE(s): 2
            ASE: #0
            ASE ID: 0x05
            ASE: #1
            ASE ID: 0x05



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
