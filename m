Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7236B
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915530; cv=none; b=iWhJ9TNcc3LdOj0ZqwuvT1J6ijKul/67rWesGT8sKDOKAz/92h1Z4Bw/b2vyj7zSTemyvy09HnKfll5ZRIs9i3Dfmz84DjYs1ywHcK1FpyEzPMDPLkqtMU98SwGFVN2/Kq+ECrNK1xNtiZ0cPcfkZaAi5C94Ehqdola3zstqqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915530; c=relaxed/simple;
	bh=rOw88emrHamHwfrqr6LoUrsdiecgkJzyDuepotob6q0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kF6kFIQ7RVibsDDSpXfges1JAkM6jJU4E7dobS4WynOxv3zKs40Nygn47WSJu0xLQ9BOodO4njE1Ix672YVFdAAzEzq1jsKGZG+DKmUZbWXlBVHzNdX57wTr5WaQ/Jw5L1FwMe1P3jwHwIAmwEKDu9pYz30t+ixwXdLlreMa0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BOb1s4vN; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BOb1s4vN"
Received: from github.com (hubbernetes-node-1df99b6.ash1-iad.github.net [10.56.152.25])
	by smtp.github.com (Postfix) with ESMTPA id A9757340C9A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1709915527;
	bh=lMCsqoStxOTB/oqyq+/wvdZ7TP+EY2DLXWlYs3Z5LC0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BOb1s4vN55gi/XOs6TdB8nH5RTNhNs1gSapMqxPQ6qu0MoC7GldeIAqExRToIEzAF
	 zxzOMZep2ufPLoKGz6at/w0NIK4RZA7GnOq5Wy1yDEf8XzURoeXMobTTW215uCMTLg
	 yVPXcZHOnBO2xcazcTnol0iIDtPlS11K1p5GHRwo=
Date: Fri, 08 Mar 2024 08:32:07 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/19f8fc-a23239@github.com>
Subject: [bluez/bluez] aa7a81: bluetooth: Add BT_ISO_SYNC_TIMEOUT
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
  Commit: aa7a814690d062349af4f3951f9d381086bb8994
      https://github.com/bluez/bluez/commit/aa7a814690d062349af4f3951f9d3=
81086bb8994
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-08 (Fri, 08 Mar 2024)

  Changed paths:
    M lib/bluetooth.h
    M profiles/audio/bap.c
    M src/shared/bass.c
    M tools/iso-tester.c

  Log Message:
  -----------
  bluetooth: Add BT_ISO_SYNC_TIMEOUT

This defines BT_ISO_SYNC_TIMEOUT(20 sec) which shall be considered the
default sync_timeout and make all instance previously hardcoding a
value to use it.


  Commit: 352e75263632edb8105e2fc1e75153f9f40bf518
      https://github.com/bluez/bluez/commit/352e75263632edb8105e2fc1e7515=
3f9f40bf518
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-03-08 (Fri, 08 Mar 2024)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: Quit shell after user input has been processed

Inside gatt_register_service and gatt_register_chrc,
bt_shell_noninteractive_quit should be called after
the input was processed.


  Commit: 32e9d15a60948ad1e912f6660e9dea6d8c5265d1
      https://github.com/bluez/bluez/commit/32e9d15a60948ad1e912f6660e9de=
a6d8c5265d1
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-03-08 (Fri, 08 Mar 2024)

  Changed paths:
    M client/adv_monitor.c

  Log Message:
  -----------
  client/adv_monitor: Remove shell quit from adv_monitor_register_app

In adv_monitor, adv_monitor_register_app is called when an advertising
monitor manager proxy has been added, when a new adapter is added.

This commit removes bt_shell_noninteractive_quit from this function,
since it causes the shell to exit without a user command having
executed.


  Commit: fcbea6f3658d979622aad1a7f1311aaf0f7abd53
      https://github.com/bluez/bluez/commit/fcbea6f3658d979622aad1a7f1311=
aaf0f7abd53
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-03-08 (Fri, 08 Mar 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Add fixes for the init script scenario

This adds some fixes to the scenario when the shell is run with
the -i/--init-script command line option.

In bt_shell_dequeue_exec, if a prompt was released with the current
line, all other prompts, if any left, should also try to be released.
If no other prompts are available, the next line should be executed
on bt_shell_noninteractive_quit.

In bt_shell_prompt_input, if data is already available in data.queue,
execution should continue and the prompt should be released with the
input.


  Commit: 9e9f079e8952bc29e3fa0f9dc8dfbad19c3edcc8
      https://github.com/bluez/bluez/commit/9e9f079e8952bc29e3fa0f9dc8dfb=
ad19c3edcc8
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-03-08 (Fri, 08 Mar 2024)

  Changed paths:
    A client/scripts/broadcast-sink.bt
    A client/scripts/broadcast-source.bt

  Log Message:
  -----------
  client: Add scripts to start broadcast source/sink

This adds sample bluetoothctl scripts for the broadcast source/sink
scenarios.

The broadcast-source.bt script does the full setup: It registers a
broadcast source endpoint, with supported locations as FL/FR and
media context supported. It then configures the endpoint to create
a stereo media stream, for the BIG handle 1. The transport is also
acquired.

The broadcast-sink.bt script registers a broadacast sink endpoint,
supporting FL/FR locations and the media context. It also starts
scanning, and the user is responsible to detect sources and select
which endpoint to config.


  Commit: a23239f591d70c68b9fce449294bc1154969de10
      https://github.com/bluez/bluez/commit/a23239f591d70c68b9fce449294bc=
1154969de10
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-03-08 (Fri, 08 Mar 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix eir name length related tests

According to Section 1.2 of Core Specification Supplement Part A the
complete or short name strings are defined as utf8s, which should not
include the trailing NULL for variable length array as defined in Core
Specification Vol1 Part E Section 2.9.3.

This patch remove the trailing NULL in expected packets, and update the
lengths accordingly, to be in sync with Kernel patch "Bluetooth: Fix eir
name length"


Compare: https://github.com/bluez/bluez/compare/19f8fcdc2084...a23239f591=
d7

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
