Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C82EECB
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672370; cv=none; b=qniBSWsGSMNFt+iIXvq6t1v48HFxlf6pxXn61KoEu8Jl4Dmoy8eR3r0A+ZLpoMO/jYdFPlqmnxeb4jPt7ct4CLvdOBQ3S5QleirajJLyGiy4Sj4kkz3oQYuqo8RY0jCN1tQUNKjgfzvfcc/aLLG7vXYcpxWAK+t163/y3R/Pboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672370; c=relaxed/simple;
	bh=Lt+SZN0czUq7/J8vvynG/6BpeYxk/RWnnxc4GziNCkw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KJ5gupQZWcjr3ryaBUmXh9CBdacPT7VrU/s8b0gA+ox4k+i9LxftnHyAmFOq3ScM/b3sfuVrtTrsDzbDMMVu1wt82yUDJgd5IxmX0XFMF60UI+/Np9x/7e3bBIgLOaRrqYvFge0zKZ+WY69NEIMO1JE+7KZJrpJv1iWG6vxG+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=SdCzitR3; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="SdCzitR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791672368;
	bh=oQ5doEQXr8UXnjuOti43RM2l/dlMFJsqnmA8bEFG0RA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SdCzitR31RW5bpsh/0/N5Hz0i73OwOTWtp1QleYOTW2dds2UwEK4rPKVD1d8YAbLx
	 XnJP+S01LGODusrJjnfPOaH6iLjjqjLWsXeD9VO+vm8zZySmWwYzTsVnR/stufV/VM
	 D+vthS2QdSjtl8y8dqnRj3hsvzoEn9VJOmOXqbQxU/7+vznfQ+s2Qic0u7dHV6ywXT
	 se6Rj46SkDnXTKS5cDrGdOUuUpS5isp95D/TTGbyMbMVwGinosJUUHeBMotdAElmVT
	 ZRcBX0+UfArEXZFsmMHKBtUC7qPVv9jo97Nq6//prANoIA8vfkV39ZWlJB24YW3IeY
	 mg12QCY6P7SIg==
Received: from github.com (hubbernetes-node-f52fcbd.va3-iad.github.net [10.48.81.71])
	by smtp.github.com (Postfix) with ESMTPA id 6921A2803FF
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 15:46:08 -0700 (PDT)
Date: Sat, 10 Oct 2026 15:46:08 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1183123/000000-ccca92@github.com>
Subject: [bluez/bluez] ccca92: test: functional: retry pairable when Busy
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

  Branch: refs/heads/1183123
  Home:   https://github.com/bluez/bluez
  Commit: ccca929855e95a50928e3d6db7233b45330eb011
      https://github.com/bluez/bluez/commit/ccca929855e95a50928e3d6db7233b45330eb011
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-10-10 (Sat, 10 Oct 2026)

  Changed paths:
    M test/functional/test_a2dp.py
    M test/functional/test_bluetoothctl.py

  Log Message:
  -----------
  test: functional: retry pairable when Busy

bluetoothctl registers an agent on connect, which toggles bondable.
Before it completes, "pairable on" fails with org.bluez.Error.Busy.

Retry "pairable on" until accepted via a pairable_on() helper.

Fixes flaky test_bluetoothctl_pair_bredr / a2dp tests.

Log:
src/agent.c:add_default_agent() Default agent set to :1.2 /org/bluez/agent
src/adapter.c:set_mode() sending set mode command for index 0
src/agent.c:agent_ref() 0x7c1fb6700110: ref=1
src/agent.c:register_agent() agent :1.2
[:1.2:method_return] < [#22]
[:1.2:method_call] > org.freedesktop.DBus.Properties.Set [#31]
[:1.2:error] < org.bluez.Error.Busy [#31]
src/shared/mgmt.c:send_request() [0x0000] command 0x0009
src/shared/mgmt.c:can_read_data() [0x0000] command 0x0009 complete: 0x00
src/adapter.c:new_settings_callback() Settings: 0x03fc0ad1
src/adapter.c:settings_changed() Changed settings: 0x00000010
[bluetoothctl]> 	SupportedUUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[bluetoothctl]> 	SupportedUUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[bluetoothctl]> Agent registered
[bluetoothctl]> Failed to set pairable on: org.bluez.Error.Busy

Assisted-by: opencode:qwen3.8-flash-next



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
