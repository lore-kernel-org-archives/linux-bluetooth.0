Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED282D8397
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971350; cv=none; b=kaYAB3XAsJa327lH2Jt1BvnIPkW9FfDvSmXm81s7C1Cw2EJUUOX19hyDpys/k9Xs+JjUa/JCDkGlWIaQ9/hgd6ekzAk0lMuq06bfLNmSKvb+wSjq4o0jSkldbTueAsbCeE34T6I+vnDG//jHLGoOGX+TxcgNvUkH5SencQCH5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971350; c=relaxed/simple;
	bh=fCcXOlF86em/hSvr9YgV8EWr0byKIaRUc88SPg7ihAY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s4eId/7iJyUGVMaii4hhE+BfTHgWp6SiLi6i0FKxrCM4kp3USw35He+nivPINxwd74X4BN6G6uNbVH4UHf1vSPjib1DabZ1VS+DBCNSTd4UkxG6ERcDBP6dDxwWqHezg8LHMKQo363YQ99/VPbHTYKvHnjztGWw/X28fr/NnLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=d2TFyNJk; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="d2TFyNJk"
Received: from github.com (hubbernetes-node-3a5170f.ac4-iad.github.net [10.52.184.34])
	by smtp.github.com (Postfix) with ESMTPA id 617622114B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 03:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751971348;
	bh=mIRqw4Q35SBYCNbv/lf/2Pn7YTGtDv6cUrb1WX/NKIc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=d2TFyNJk/IV8mY8jURf0w/K0XSiz0nLwAWcp+IG0AP1kc0Ym6NPGLydmp8WDeMmJe
	 rdD8MlOBV0f9eTFMgTzuU0zbQ+5aIZQtNSjh/2bAt3aKx5ch+BfoJUX/TbAHzKlEz0
	 tfWkO3ghn4qIL4xiRcUU4p6XqPbzpvcC3lnoweVM=
Date: Tue, 08 Jul 2025 03:42:28 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979993/000000-c99487@github.com>
Subject: [bluez/bluez] 13d79c: build: Remove deleted configure option
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

  Branch: refs/heads/979993
  Home:   https://github.com/bluez/bluez
  Commit: 13d79ca76aa5088939112969d6cbfd9ffddc3bc5
      https://github.com/bluez/bluez/commit/13d79ca76aa5088939112969d6cbfd9ffddc3bc5
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M bootstrap-configure

  Log Message:
  -----------
  build: Remove deleted configure option

Remove this option now that that the supporting code has been
removed, fixes a configure warning:
configure: WARNING: unrecognized options: --enable-android

Fixes: f0512114aacf ("Remove android support")


  Commit: c9948759d928f5fb009c3d1925e97739b44f46d6
      https://github.com/bluez/bluez/commit/c9948759d928f5fb009c3d1925e97739b44f46d6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  build: Remove deleted files from .gitignore

As all the android support was removed in
f0512114aacf ("Remove android support").


Compare: https://github.com/bluez/bluez/compare/13d79ca76aa5%5E...c9948759d928

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
