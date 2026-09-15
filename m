Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E607DA66
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433431; cv=none; b=jZUcTGlmJWiIIk+8QINUbkDGmeMof+E6VGdcl5mLzJqVttka86vRtItryVviOs9NaC5aLwpI3Ri+SVVMfXPoa5wBgGee1ZPAgzGfOTQO49KX7xmqSVAs2JOv/wCdYtJdURh7Xi+ogLbIwDfPj45Y5b0EUF4R30DKz5qaxnehhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433431; c=relaxed/simple;
	bh=aJcqupcSlOl368NlRVdOvdFtXqPpI3elS2no+f67sKI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QaiQdYA4AjJDp8PkJO3KfbZMpF5njLOabqpywHVOfApDLI3p1iajHGv5SyYOs5xRJa8Du66eYVrEaOaoqQuoUcn5R+WiHlL6DtuKHuOorDgwPYzywl5fZSMkmqhQJR0gPiSFWmzKJlXl1MxA5t4vMrf7xhv5XdT1wQPLfQd/kY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dInbFOfp; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dInbFOfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789433428;
	bh=zL8EXaSFFIdLporOhp+4lxjvHucaWRo3974rLxHFzqA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dInbFOfpx/T50Wr8wzwwGb3sbIJP5+xKqv/6efiJT24Nbs/S2dMka78VUP3ROGRO+
	 g42nIftScNlh0EFfZ6ZPdNV318zaibZf8xBbVsoKj5tRi6nH0jkQDYVYJJm7xou+vd
	 3Uv7Zg+McRmfpBQL7kDPMIZpyd4xrasJnPmfbOew=
Received: from github.com (hubbernetes-node-6b2b666.va3-iad.github.net [10.48.77.76])
	by smtp.github.com (Postfix) with ESMTPA id D4151340AF8
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 17:50:28 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:50:28 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1164934/000000-9183ed@github.com>
Subject: [bluez/bluez] 499d91: test: functional: add mpris-proxy BR/EDR test
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

  Branch: refs/heads/1164934
  Home:   https://github.com/bluez/bluez
  Commit: 499d91699cfc7f0a079984806abd8c8e109165b0
      https://github.com/bluez/bluez/commit/499d91699cfc7f0a079984806abd8c8e109165b0
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


  Commit: 4f360a485a85119fcbd5c35b91ae056ee30f9876
      https://github.com/bluez/bluez/commit/4f360a485a85119fcbd5c35b91ae056ee30f9876
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


  Commit: 9183ed5ea3578a4b4f829104f8dcd81e6413111d
      https://github.com/bluez/bluez/commit/9183ed5ea3578a4b4f829104f8dcd81e6413111d
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


Compare: https://github.com/bluez/bluez/compare/499d91699cfc%5E...9183ed5ea357

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
