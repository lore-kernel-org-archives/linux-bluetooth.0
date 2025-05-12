Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8E1E0E1A
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060906; cv=none; b=u2X7VG94Woyvb21ppTKddtTeIMQ+XJ/ItIjHlHI1njZEUOFZPjh2wtQIAmnwThnFKoUXwOC00ZvrTmShVsfNEfpATxQOKuIoPWJoKXAUuZQzYlOiJfFxjbYHocwvQBwU2E+e3DGFk3myzJr/4CTKN0Pjaf/ox9gM8j8GlwAZbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060906; c=relaxed/simple;
	bh=m3loeZYFB5V/yFkGdDsTrSIVxwK2z/gDOGhpgtrIrkA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XxA1JWaK/sdcv+cryJTAGC73usZqP76CyYcbWXwP3DaA2UEROs7kNkQboxtOy0rRcUQUFu2hhGv7B6inNc+DyYeN08v/o0sYYqW7T/cuYShulWQrtjW2b1kfREq7ILbOyJ2Fb6SIyvwahoU0Nku4vDCGDQwaITwZ7vfzcMFNQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lOmTtcEZ; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lOmTtcEZ"
Received: from github.com (hubbernetes-node-4961e4d.va3-iad.github.net [10.48.173.23])
	by smtp.github.com (Postfix) with ESMTPA id B4E2A8C0AFE
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747060903;
	bh=cA5BL+lx70ZgbmTh9JFEp7TY7jaQMpKSWGCOcdk1rwE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lOmTtcEZMtVMNJgla7ZiA5JEgPHA9pCkDaYFTn4WPBrqG8dv7HD+OLBeisCHbHrfi
	 mUYG8fYvUtCXbgCzSwOoNr567hbK2oQK3QK9NNqsLXi+oQgJAGso+xU7biEfGMja+k
	 BrGSWnzJ60/sep0tNYUT4V3BLwGxhomPCgFhk/DA=
Date: Mon, 12 May 2025 07:41:43 -0700
From: Sanchayan Maity <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962080/000000-72f7f3@github.com>
Subject: [bluez/bluez] 76ca55: shared/asha: Don't wait for status notification
 on...
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

  Branch: refs/heads/962080
  Home:   https://github.com/bluez/bluez
  Commit: 76ca55651a6c816cf667bde069fa081ed14daabd
      https://github.com/bluez/bluez/commit/76ca55651a6c816cf667bde069fa081ed14daabd
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2025-05-12 (Mon, 12 May 2025)

  Changed paths:
    M profiles/audio/asha.c
    M profiles/audio/asha.h
    M profiles/audio/transport.c
    M src/shared/asha.c
    M src/shared/asha.h

  Log Message:
  -----------
  shared/asha: Don't wait for status notification on stop

Not all devices respond with the status update, so let's just send it
out and assume it worked.


  Commit: 72f7f3ecba0064fa7675ccbd1487522aa6793cdb
      https://github.com/bluez/bluez/commit/72f7f3ecba0064fa7675ccbd1487522aa6793cdb
  Author: Sanchayan Maity <sanchayan@asymptotic.io>
  Date:   2025-05-12 (Mon, 12 May 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix the use of callback in transport_asha_suspend

Some devices do not send a response to the stop command, so
audio status notification might not be received after stop.

Instead, as with the Android implementation, we just immediately
acknowledge the client's stop request after sending it to the device.


Compare: https://github.com/bluez/bluez/compare/76ca55651a6c%5E...72f7f3ecba00

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
