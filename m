Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9138B145
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494975; cv=none; b=G54logwDfP/8wjCut/C5DbOupVcl+UdST8S5V0RDyAzM8NSzXYKQoK2/Roj66nztR/py0IwG1mpMLlEqGjxMeLXdmMEM89ajWKVvtFRqAwdadLWcHPoHQagwkLZKpL3WPCCOYMIwPt9Im4bv7epnthHWvE7ZfKkUwezoHxODEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494975; c=relaxed/simple;
	bh=svzacSA+IZubiDeqVL2cQo/cWUeUoXZEr0oasM9Dfk0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cT4IUaLpE2HRmEdaVpiJXi7nOoyygelp9Ccwq61XCW1Wpj79EzLc5ganQn8QeZyQzDrucYiNtqlSzykA+nC3QBsOVk/yU61LGvQjuDfqLrO4uVZFR8KmXqaA2852Ni8od/VzCPgErgDxo3ehqjufRN6X2/zSJQbVDa4OnUFncYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dlqCkYRM; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dlqCkYRM"
Received: from github.com (hubbernetes-node-519f8ec.ash1-iad.github.net [10.56.14.72])
	by smtp.github.com (Postfix) with ESMTPA id B46BBC1136
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775494973;
	bh=jV8DECoGjYTYzv/toZpr4WwgxvuhZZBx1sIsoQGCo/4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dlqCkYRMtY1AB91Hku+TCW7+9DFpHNfcebX8lCsndQ/TJ1J5pg5j5aIErNpdjHCpz
	 f9eX2/Sgu15gzPgi4DN9JMubpV6EUV+iNWWgD3uqg8lFoxPqJDNdva29VhIeMaA2Pu
	 hcMgUZt+2n0Onj5E6mRewwKxp1FgKhCjj1bPbN6o=
Date: Mon, 06 Apr 2026 10:02:53 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/00dfd3-21db57@github.com>
Subject: [bluez/bluez] 46f2ed: tools/smp-tester: don't write array out of
 bounds
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
  Commit: 46f2edd29833e73664c6d80d04834f94bb7f5ed6
      https://github.com/bluez/bluez/commit/46f2edd29833e73664c6d80d04834f94bb7f5ed6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M tools/smp-tester.c

  Log Message:
  -----------
  tools/smp-tester: don't write array out of bounds

Fix accessing pdu data out of bounds in SMP Server - Invalid Request.


  Commit: 053c7c61ef97603ff00cfa120c0375878f38650f
      https://github.com/bluez/bluez/commit/053c7c61ef97603ff00cfa120c0375878f38650f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M tools/ioctl-tester.c

  Log Message:
  -----------
  tools/ioctl-tester: don't read array out of bounds

Fix accessing (invalid) param data out of bounds.


  Commit: 0e37aab12463e16fbaeebb6f204ff663d8b42fae
      https://github.com/bluez/bluez/commit/0e37aab12463e16fbaeebb6f204ff663d8b42fae
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: check data size properly in evt_num_completed_packets

Use util_iov_pull to check data size before dereferencing.


  Commit: 81111489faf4ee84c74db70d1a27ef1e80f00155
      https://github.com/bluez/bluez/commit/81111489faf4ee84c74db70d1a27ef1e80f00155
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  emulator: Remove assigned but unused variables

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about.

Fixes build on gcc 16.


  Commit: dfc5e135737be7f61e0eaa288813cd2868724603
      https://github.com/bluez/bluez/commit/dfc5e135737be7f61e0eaa288813cd2868724603
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M monitor/avctp.c

  Log Message:
  -----------
  monitor: Remove assigned but unused variables

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about.

Fixes build on gcc 16.


  Commit: 5a0932cc8e05bb24a8e63debcedfb6e5fa6ccaea
      https://github.com/bluez/bluez/commit/5a0932cc8e05bb24a8e63debcedfb6e5fa6ccaea
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M src/sdpd-request.c
    M src/shared/shell.c

  Log Message:
  -----------
  src: Remove assigned but unused variables

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about, or silence by void cast.

Fixes build on gcc 16.


  Commit: 474f2ee8597b62aca44ea2e1578359dc7c223af6
      https://github.com/bluez/bluez/commit/474f2ee8597b62aca44ea2e1578359dc7c223af6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M tools/btsnoop.c
    M tools/seq2bseq.c

  Log Message:
  -----------
  tools: Remove assigned but unused variables

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about.

Fixes build on gcc 16.


  Commit: dd9d9dab41353567abc1a127920ecfe31d167a86
      https://github.com/bluez/bluez/commit/dd9d9dab41353567abc1a127920ecfe31d167a86
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  build: never build test-runner with ASAN

test-runner cannot run as pid 1 inside VM when built with ASAN enabled.
Drop MISC_CFLAGS/LDFLAGS from its build; the additional flags they
contain beyond ASAN enable are not important for test-runner build.


  Commit: 46b859d82909b99c41327a41983302bdc2a42416
      https://github.com/bluez/bluez/commit/46b859d82909b99c41327a41983302bdc2a42416
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: fix crash on destroy after ATT gone

Tie lifetime of bt_mcs_session to that of ATT disconnect watch.  The
disconnect handler is not necessarily called before ATT is freed, but
destroy is.

Fixes UAF of session->att in bt_mcs_unregister() -> session_destroy() ->
bt_att_unregister_disconnect() if ATT was freed first.


  Commit: 21db57fc0c2f3f2d7300372263f8631f4cb1d3d0
      https://github.com/bluez/bluez/commit/21db57fc0c2f3f2d7300372263f8631f4cb1d3d0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M src/shared/mcp.c
    M unit/test-mcp.c

  Log Message:
  -----------
  shared/mcp: fix parsing of control point arguments

Fix parsing of control point argument lost in rebases.

Add tests for Move Relative command that need it:

MCS/SR/MCP/BV-12-C [Move Relative from Playing]
MCS/SR/MCP/BV-13-C [Move Relative from Paused]
MCS/SR/MCP/BV-14-C [Move Relative from Seeking]
MCS/SR/MCP/BV-75-C [Move Relative from Inactive]


Compare: https://github.com/bluez/bluez/compare/00dfd32af38a...21db57fc0c2f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
