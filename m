Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741F33BBD7
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927971; cv=none; b=iSQ3mZ75XuEHYDQPz8W2Ub0mgg91eWmnCTdkMgUyrQM64aBaxrxDmiKlatIWSRyYzY3WgJATyZsMe2jD2EDxZdwG0ctCVxSOQuPGpfjYjcWkCgw9MZahFwEYMY5rE3D6o1uGu3gF1xKpUzLcK0Mv0l2Mx0S1K2sIUo5XBr/mnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927971; c=relaxed/simple;
	bh=sV+03QumNFOaHo9mgBvQR+Aq0XmI3feApwT9VZBOIv0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Oo5hozQACLBnRKHbRVzdVoaAXZeonCh8ea0Q+ljb0/8OnC/jbJMTmYlTy+YXIgrjtff61H1FdN4iAoFYinFTknfhj+BE25xpEHQUjKXyKPLmsQGJAr4a3qvn8/B4Gp7QWqhCEUa+bGZ/deQDD1o+NlBHoti/M4rVkzrP0mr0gM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UsLo95ib; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UsLo95ib"
Received: from github.com (hubbernetes-node-c334e33.va3-iad.github.net [10.48.141.44])
	by smtp.github.com (Postfix) with ESMTPA id C196D4E09E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768927968;
	bh=uXzopNZJkQVS5Z7vrfQ0E6qUPbnhEcGuAxGmFIlHzMk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UsLo95ib2ROsMjmLQZHAC95tswfYQkBud7jiULMxE9v8e5BLIQzMPmY4Nkg18s7Ny
	 tWaJ958Yc9hxsQ0Hhy/Mz39LbBIbJaK3ouxE0ftURztzqEnR3JudOu+NEXp7MId3c6
	 K89E1yXJB6xOwpG+BTx44+h02T6Lt85uPNlhcvzA=
Date: Tue, 20 Jan 2026 08:52:48 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6a9117-c24f0b@github.com>
Subject: [bluez/bluez] a1f2e5: src: Turn available priority macros into an
 enum
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
  Commit: a1f2e53de4e9e0475e41f850807fbeea550a3fe8
      https://github.com/bluez/bluez/commit/a1f2e53de4e9e0475e41f850807fbeea550a3fe8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    M src/plugin.h

  Log Message:
  -----------
  src: Turn available priority macros into an enum

This will allow generated bindings to know to use the same type
independent of individual values.


  Commit: 69fd644df0a2081b262c5fa6452e1f2d394df3cb
      https://github.com/bluez/bluez/commit/69fd644df0a2081b262c5fa6452e1f2d394df3cb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    M plugins/hostname.c
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  src: Prefix plugin-accessible adapter_set_name() function

Plugin-accessible functions are usually prefixed with btd_ to avoid
confusing them with internal private functions. Rename
adapter_set_name() to match the existing btd_adapter_set_class().


  Commit: 80828d5ff016cbb5cc3e4f36930be728d55afdaa
      https://github.com/bluez/bluez/commit/80828d5ff016cbb5cc3e4f36930be728d55afdaa
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  adapter: Fix const'ness of struct btd_adapter_driver

When registering or deregistering an adapter driver, the struct that
holds the function pointers to the various callbacks doesn't need to be
modified, so make it const.


  Commit: c24f0b487ca3d4e0ca315114a889dad4d2c3bb26
      https://github.com/bluez/bluez/commit/c24f0b487ca3d4e0ca315114a889dad4d2c3bb26
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    M plugins/hostname.c
    M src/adapter.c
    M src/adapter.h
    M src/agent.c
    M src/gatt-database.c
    M src/profile.c

  Log Message:
  -----------
  src: Prefix plugin-accessible adapter_foreach() function


Compare: https://github.com/bluez/bluez/compare/6a9117531e39...c24f0b487ca3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
