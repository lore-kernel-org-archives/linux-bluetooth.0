Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B3474274
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509464; cv=none; b=jenjiFj1FCINREdYrVm3oeLoIStgpfRdylCvh89SXNYn1LJRJzZYDzjfiPENNy7J0A4SKjrd/DBTmOLfxztxqbXe6zlBc2dUB9WQGk8XLqPNYiGJNlqmnGd9C/q/cv7EliMt3hz6Cq5J1oaDzzr9W/8nJPFGSxpIHO7eNp7/AHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509464; c=relaxed/simple;
	bh=v2lAZIMRj4zu/cLS6110VCOq7KFGA5rkN0eqCjqxQJw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=G8CWt/biZ0Gh61XlG23+0y7979yh1iDiP1eJNpMRgYugg/aAI1TKf/2Qu/G+9J1T8AEhbqLCnmv/awIAyo3njxuL60e6YqQwV5yfaYMaF594xu0p4RoDfil0XaOfzOxZ9lHAqpju0STHV4B89SS+B5J3WU4+XLkKFUum3k9om28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Yz5XSIjJ; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Yz5XSIjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789509462;
	bh=U9sfGGuJKaaN4RlNAUd+W4iBurkRk03wtwtsktG7b0c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Yz5XSIjJ4iMKtmppQuHbrQ6b4rQDDA/VtXFTC5pnxyd9YVQuRaAj1iDhBc/QC5q4l
	 KwnAaCStWerANOUj+IFtyRfqvhWeYjMbHYyll975H31M7abUq3I7epkyABoU4TLvY5
	 XWvnCqqiiW1ReQXnLNITlSdBq1GBQ9LpuoJoDTdk=
Received: from github.com (hubbernetes-node-9c2bfaa.ash1-iad.github.net [10.56.159.57])
	by smtp.github.com (Postfix) with ESMTPA id 4753C60088D
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:57:42 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:57:42 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6dc064-e2ec68@github.com>
Subject: [bluez/bluez] 3e7fb4: test: functional: add mpris-proxy BR/EDR test
 cases
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
  Commit: 3e7fb4ac2e28a13eb44293c0e4de4281c65ab1ed
      https://github.com/bluez/bluez/commit/3e7fb4ac2e28a13eb44293c0e4de4281c65ab1ed
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M Makefile.am
    A doc/functional-mpris-proxy.rst
    M doc/functional-testing.rst
    A test/functional/test_mpris_proxy.py

  Log Message:
  -----------
  test: functional: add mpris-proxy BR/EDR test cases

Add functional tests for mpris-proxy over BR/EDR: a dummy MPRIS player
on the server is bridged by mpris-proxy to an AVRCP Target, and a
second mpris-proxy on the client, run with --export, exports the
remote player back to the client session bus as an MPRIS player, which
the tests control as MPRIS clients.

test/functional/test_mpris_proxy.py::test_mpris_proxy_playback_control
test/functional/test_mpris_proxy.py::test_mpris_proxy_track_control

Assisted-by: opencode:qwen3.8-flash-next


  Commit: acab65d06795292031f93aeecb455c6e9a1b72d7
      https://github.com/bluez/bluez/commit/acab65d06795292031f93aeecb455c6e9a1b72d7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M doc/functional-testing.rst
    M test/functional/conftest.py
    A test/functional/le_utils.py
    M test/functional/test_avrcp.py
    M test/functional/test_mpris_proxy.py
    M test/functional/test_obex.py

  Log Message:
  -----------
  test: functional: deduce pairing bearer in shared fixtures

Make paired_hosts deduce the pairing bearer from the host
configuration instead of using BR/EDR only, with the LE pairing helper
pair_le in le_utils. No behavior change.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: e2ec6827f7bed94912c23288a34f868e7002e847
      https://github.com/bluez/bluez/commit/e2ec6827f7bed94912c23288a34f868e7002e847
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M doc/functional-mpris-proxy.rst
    M test/functional/le_utils.py
    M test/functional/test_mpris_proxy.py

  Log Message:
  -----------
  test: functional: run mpris-proxy tests over LE via MCP

Also run the mpris-proxy tests over LE, where the player is exposed via
MCS instead of AVRCP.

Add an LE advertisement helper for connecting the service.

test/functional/test_mpris_proxy.py::test_mpris_proxy_playback_control[le-vm2]
test/functional/test_mpris_proxy.py::test_mpris_proxy_track_control[le-vm2]

Assisted-by: opencode:qwen3.8-flash-next


Compare: https://github.com/bluez/bluez/compare/6dc064623c57...e2ec6827f7be

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
