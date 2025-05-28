Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A528315B
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448763; cv=none; b=m3g7UDwA6b/ThubwmshUhdngev4WOYPpol76oncUUCXCQ05l+ClZJ8H3aUa7lW/ZTazMkjaQpZ85RXtWvxphqM3qj9aI3n2bVIPRtdWvzjmFDSfcYN7wio9GNknuBBmmK5U/HPV77zQHI7pARm0RlAEEfFkYW73oamTOPBQe9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448763; c=relaxed/simple;
	bh=Ofbdiy4M4HXXtZQE0Mm1m7brgoUkxphhSCbFs4qS4z8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rs4t04t5JCm3jsdgKqb6Qfcjzk35fD700bpWB0GgxW9ZXlNYpQZ6Hq0WtVIwJp0HWO4TFVza91i7cZMwttad1KNLjB8geZjAEIxnOy6Jn7YcUxKhNPeGPjLYWHBamxi/4ZYw6zx3sMO9lWKt4ZMjsiW2CH51cX54Zam3k5yNo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IEZjNppX; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IEZjNppX"
Received: from github.com (hubbernetes-node-61756e7.ac4-iad.github.net [10.52.167.35])
	by smtp.github.com (Postfix) with ESMTPA id 0908C70045A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748448761;
	bh=AMNfDmFG589aaFKU2MPwvTXi7EuVlLrrErvPGcGH7Uw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IEZjNppXZ64zyOLIF4QaYCuIbjqt3EfvB+JeYRzSmAXi65QXkPTJjiTIibBPPDj+H
	 Zu2zvCvbcGjiXL7oTvrTLiZWRkupTd3UPBph8ZKHTXVEjEGIOY+DxYrHc4UbjpVJj/
	 ImPKnrCkUnzjADjXzni7QeL2kSfsJFtCGvOjL+MU=
Date: Wed, 28 May 2025 09:12:41 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2a552b-760c6c@github.com>
Subject: [bluez/bluez] f2cc37: audio/player: Fix not being able to register
 playe...
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
  Commit: f2cc370504024af22db297dac0ef919fe232e3d8
      https://github.com/bluez/bluez/commit/f2cc370504024af22db297dac0ef919fe232e3d8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/mcp.c
    M profiles/audio/player.c
    M profiles/audio/player.h

  Log Message:
  -----------
  audio/player: Fix not being able to register players of different types

When registering players both AVRCP and MCP were using the same object
path making them clash, so this fix it by adding a type to the object
path so each profile can register their player in their own domain.

Fixes: https://github.com/bluez/bluez/issues/1290


  Commit: a5f3e243dd4edd8a92f152e16a6c2b87e68728db
      https://github.com/bluez/bluez/commit/a5f3e243dd4edd8a92f152e16a6c2b87e68728db
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  audio/mcp: Fix passing callbacks as reference

Callbacks are already a function pointer.


  Commit: 760c6c2ec14acc142ebbd2983ec86c9d6d768164
      https://github.com/bluez/bluez/commit/760c6c2ec14acc142ebbd2983ec86c9d6d768164
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-28 (Wed, 28 May 2025)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Fix make dist

This fixes the make dist cuasing the following error:

make[2]: *** No rule to make target 'doc/mgmt-api.txt', needed by 'distdir-am'.  Stop.


Compare: https://github.com/bluez/bluez/compare/2a552b93de8b...760c6c2ec14a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
