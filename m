Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E741C30D
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205944; cv=none; b=pg/VHNF7bKeiNpcVOzGitvsRm0PkaxJA2jlINm/hr2wEQc74boRe2Jf/ntqk3H8jemPVeis0+Td4HFfO844A1jx/8JpxiAuuIRpby6qm1VQ8Xcp2ylHc93h3bwv1DYB/MNLk7iEaIDiqYQ3jkzblblcJklYG4kFyv8uiBmstQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205944; c=relaxed/simple;
	bh=MxI1RoUzQFD/wyD2uioLG6faXK2Mh3/pI+1JgnbmJrs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DkqQDlaihxObzsS2TuJIX1KnZcpjlRqW3wqCc+7vLmF8KWpYyVyYRiNlZDOoiWKBGGtSGIhUl2taXTALl6esicRfJR6RQ8Hl5g7pFQBaGdCvkQ9UlS8W5oa8u/7307E+1vFCnlDa0Yzo9PtBrYKdIsM872SbY1fBStNVAYODw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h/8vqqXI; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h/8vqqXI"
Received: from github.com (hubbernetes-node-bd2b122.va3-iad.github.net [10.48.148.41])
	by smtp.github.com (Postfix) with ESMTPA id 251753C106C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 07:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772205942;
	bh=bhAdfR/IHLI1dfZAoBCW7uE2e/TmIGQXSDovH4g/qZI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h/8vqqXIETsaDsJumdDe0ND6Wye8tMxHR8cd0evdIxgW70t44bjiPT6Nw1domNz4L
	 QD1C/jf3Z6diyMZp9i7Pf2TXerL3Jjjnt3nSljkFnppjwx6B1Kn/gjjsWv3nureSSd
	 HGj67KzLcjfkrNy33Spe0ejcWcGuzNT5y/CoMzrA=
Date: Fri, 27 Feb 2026 07:25:42 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/21459a-21e139@github.com>
Subject: [bluez/bluez] 61f25f: shared/mgmt: Add mgmt_parse_io_capability
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
  Commit: 61f25f9aacdc4edeca6f6ea3c4d5daf1574b05df
      https://github.com/bluez/bluez/commit/61f25f9aacdc4edeca6f6ea3c4d5daf1574b05df
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  shared/mgmt: Add mgmt_parse_io_capability

This can be shared between bluetoothd (adapter/agent/device) and
bluetootctl (mgmt).


  Commit: 47a1be34629fdd059d6ab603bd5df982b2430801
      https://github.com/bluez/bluez/commit/47a1be34629fdd059d6ab603bd5df982b2430801
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/agent.c
    M src/agent.h
    M src/device.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  adapter/agent/device: migrate to shared enum/parser for IO capabilities


  Commit: 63b82054c3449ceff1e975586b5a6c0843b47a16
      https://github.com/bluez/bluez/commit/63b82054c3449ceff1e975586b5a6c0843b47a16
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M client/mgmt.c
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  client/mgmt: align implementation cmd_io_cap with its documentation

Documentation of io-cap in doc/bluetootctl-mgmt.rst states that the IO
capability has to passed as string instead of an integer. Additionally
improve error checking after calling strtol().


  Commit: 65fcbe05dce15ebac27157c2d37c94b9e355a2c3
      https://github.com/bluez/bluez/commit/65fcbe05dce15ebac27157c2d37c94b9e355a2c3
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: align implementation cmd_pair with its documentation

Documentation of 'pair' in doc/bluetootctl-mgmt.rst states that the IO
capability has to passed as string instead of an integer. Additionally
improve error checking after calling strtol().


  Commit: b33e923b55e4d0e9d78a83cfcb541fd1f687ef54
      https://github.com/bluez/bluez/commit/b33e923b55e4d0e9d78a83cfcb541fd1f687ef54
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  Revert "shared/shell: Don't init input for non-interactive shells"

This reverts commit e73bf582dae60356641a32fc27ae03d359ec4c47.

The fix caused "bluetoothctl list" to not output any text, breaking
a lot of existing scripts.

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2440346


  Commit: 21e13976f2e375d701b8b7032ba5c1b2e56c305f
      https://github.com/bluez/bluez/commit/21e13976f2e375d701b8b7032ba5c1b2e56c305f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-02-27 (Fri, 27 Feb 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  tools: Work-around broken stdin handling in home-made mainloop

bluetoothd has 3 mainloop implementations, one relying on ell, one
relying on glib, and another home-made.

The home-made mainloop handler use epoll() without any fallbacks, and
will hang if one tries to epoll() an stdin that redirects from
/dev/null.

Closes: https://github.com/bluez/bluez/issues/700


Compare: https://github.com/bluez/bluez/compare/21459ac269ed...21e13976f2e3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
