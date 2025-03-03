Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9121507C
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025924; cv=none; b=S1EqnIkZybmnBDi6+ZBafiECSZotPs95fhB7uTPS8nkxuKABGC/BmWDNTsnjEqkpOs8F21QnMjOxmUNSomTnjV5WuSOXRX8JuuJK4BoIANqZKmnlGYPNXBZXXGu0fF2aLjXh48FMD/hNpYna1XeKza93z+pKYEEop/X/GcUDK6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025924; c=relaxed/simple;
	bh=YVcgY4nqEJh8fNxDaKb18vloAbE63DB4TiZC+A+CokE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WBT9aXE/k16pYPe0aSsCtWurTvG6WblkJgfDPHWZIU/5ICLec5tfANGEWSsa4Qb+wKTYD4bI46RM2syMwsfln2/E+6kYRpIujaaMRYEoq2pKO2rs9fscQbYME7Y+86Go0fh3A5w7QeyxqIdJoMb7Ho6ZXfQTUVpAaWtPit3ydhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZZ0Mcngd; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZZ0Mcngd"
Received: from github.com (hubbernetes-node-a2fc7ff.ash1-iad.github.net [10.56.201.107])
	by smtp.github.com (Postfix) with ESMTPA id 664486009E5
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 10:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1741025921;
	bh=ULCVwnhBhcD3mPZ459aUGmyk9QN0XKbwswPHZTTlbi4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZZ0McngdQcUpenTdOv+CqQySXHmUMUvLkBSX/ZsYSPu/LS08eK6kKPdaMRZslGKBr
	 SFG7VJnsniOfY/cxWUUkfEyclqIK085hbVIQKmcRPWy/5BCo3wfnPcHDkaVIObluKL
	 kN4EP4LEGlev4FDZDrrk3Ve8hkCnsz0oQFf8CfrQ=
Date: Mon, 03 Mar 2025 10:18:41 -0800
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/711424-8479c2@github.com>
Subject: [bluez/bluez] f77ed4: uuid-helper: Accept any 16-bit HEX value as a
 vali...
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
  Commit: f77ed4911e01a43659d2daaa3724450489f6126b
      https://github.com/bluez/bluez/commit/f77ed4911e01a43659d2daaa3724450489f6126b
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-03-03 (Mon, 03 Mar 2025)

  Changed paths:
    M src/uuid-helper.c

  Log Message:
  -----------
  uuid-helper: Accept any 16-bit HEX value as a valid UUID

The bt_name2string() function restricts HEX values to the list of
predefined service names. This list is very limited, so loosing that
restriction will allow to pass any 16-bit HEX value as a profile to
D-Bus API calls like ConnectProfile or RegisterProfile.


  Commit: 32e2e5a42b2b51b7a196de0b5bd199eeb5ce4725
      https://github.com/bluez/bluez/commit/32e2e5a42b2b51b7a196de0b5bd199eeb5ce4725
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-03-03 (Mon, 03 Mar 2025)

  Changed paths:
    M src/device.c
    M src/profile.c

  Log Message:
  -----------
  core: Report error in case of bt_name2string failure


  Commit: 8479c279ea937c12b3091900c2783ca03e468542
      https://github.com/bluez/bluez/commit/8479c279ea937c12b3091900c2783ca03e468542
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-03-03 (Mon, 03 Mar 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: add input validation to main()

An error was found during fuzzing testing. When passing Unicode
characters to bluetoothctl the application crashes in dbus:

dbus[5324]: arguments to dbus_message_iter_append_basic() were
incorrect, assertion "_dbus_check_is_valid_utf8 (*string_p)"
failed in file .../dbus-message.c line 2765.

Check that all characters are written in utf8.

Fixes: https://github.com/bluez/bluez/issues/1118


Compare: https://github.com/bluez/bluez/compare/711424319562...8479c279ea93

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
