Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD13170A11
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606400; cv=none; b=seIaSmk700D6pgQssV1iC3BRhcqwXfwvDuIW0SHG0Iksswm35foolK6LF/dBFNQnIYQMAX6uhzwvAf94V0hmwE2S0ggVaQf2/7oZnzGAB3I568KsqCV3DW5uygB3NJSCoDxwY4cv+t7ce65D+wWL42AtT/CI2H8IM3y+PEUtz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606400; c=relaxed/simple;
	bh=dKNU92LlCa6GOJ8WEsO3TOTp8eBWPTJg+CReC+zJZA4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NB/a0dL7kF7br+TDLG00PElSAt1rHIRB8+kKts5d0zk3TLTUsCfRccGp2U5wYWwJLfsdCccw91hfpIpsAgco6biRLhE8NVbcUBdWgI1ZtPInn07JfYtAPENbUWufB1mOPFrJB9hKKmxl4DV79Uy5w5ELHyn1W8CZimLuJTAIsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jykaUpPP; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jykaUpPP"
Received: from github.com (hubbernetes-node-222d189.va3-iad.github.net [10.48.133.37])
	by smtp.github.com (Postfix) with ESMTPA id 115084E0AF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745606396;
	bh=GrQy94pzngR6ZeXEYvNhg41lTo/AayN7KdTe/0Kyr5w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jykaUpPP1qUYSyrrd71UcbI11H8vbqYvZi6k9faF2lEcdGaeRTKbcd1H1I8R2qrw2
	 YKRVgnSJt07qk9OZQ2GGxyjchyuDsUh2y2sLYtinmMjg8M+p+GmdT0yXacBJ8t2JEC
	 0tQzQUCIj6Nt0O9D+TUf6NwBr9GdcM4F/VGrMpmo=
Date: Fri, 25 Apr 2025 11:39:56 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/faca96-c3b6f4@github.com>
Subject: [bluez/bluez] 42f518: Add support clang-format
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 42f5184b98821900867ae2a99e75069352dff2b7
      https://github.com/bluez/bluez/commit/42f5184b98821900867ae2a99e750=
69352dff2b7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    A .clang-format

  Log Message:
  -----------
  Add support clang-format

This adds .clang-format (based on kernel) which can be used by linters,
editors, etc to check the coding style.


  Commit: cb8f216f51b7f9712873870701f48f39d94bf3c9
      https://github.com/bluez/bluez/commit/cb8f216f51b7f9712873870701f48=
f39d94bf3c9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    A .editorconfig

  Log Message:
  -----------
  Add .editorconfig file for basic formatting

See https://editorconfig.org


  Commit: c29bb3f92825eb8b688a11bc0a7ade9b8ed1c287
      https://github.com/bluez/bluez/commit/c29bb3f92825eb8b688a11bc0a7ad=
e9b8ed1c287
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    M src/shared/asha.c

  Log Message:
  -----------
  shared/asha: Only update device set after start succeeds

This ensures that one side's connected status is only exposed to the
other after the connection is actually complete.


  Commit: c3b6f4e4b4562b5c5350bb44a16af40e97658321
      https://github.com/bluez/bluez/commit/c3b6f4e4b4562b5c5350bb44a16af=
40e97658321
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Check presence of ServiceRecords when loading from store

For a HID paired device, if the cache file containing the SDP records
is not present this will prevent the device to connect and need to
remove it and pair again.

Current bluetoothd traces:
src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
src/adapter.c:connected_callback() hci0 device EC:83:50:76:BD:67
  connected eir_len 31
src/shared/mgmt.c:can_read_data() [0x0000] event 0x0006
profiles/input/server.c:connect_event_cb() Incoming connection from
  EC:83:50:76:BD:67 on PSM 17
profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
  psm 17
profiles/input/server.c:confirm_event_cb()
profiles/input/server.c:connect_event_cb() Incoming connection from
  EC:83:50:76:BD:67 on PSM 19
profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
  psm 19
profiles/input/device.c:hidp_add_connection() Could not parse HID SDP
  record: No such file or directory (2)
profiles/input/device.c:ctrl_watch_cb() Device EC:83:50:76:BD:67
  disconnected
profiles/input/device.c:intr_watch_cb() Device EC:83:50:76:BD:67
  disconnected

This commit sets BREDR svc_resolved to false if the ServiceRecords
entry is not present in the cache file, triggering service rediscover
on next device connection.


Compare: https://github.com/bluez/bluez/compare/faca96e9c9a3...c3b6f4e4b4=
56

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
