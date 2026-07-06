Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D929333A9C1
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355282; cv=none; b=pUl+mv8K2WODhoIYmWQsubjQy+9/77vVlhi5hn8Yg0D+8lEO4LHcCfJzxPImyoew41EkEE1pU8ehO8J32dVuwS7E8ZIkTJDbt9C0PJDJA7n8ibzA3oDBQqpEAyPpRq31KfCfgSQ9k5u18IvvufSmEOJ6jxOF5UgIrfed+ktREEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355282; c=relaxed/simple;
	bh=351EMRNpq4Wfmn340SoUHZT5Wm0qylbXbPywABAUfYg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AyrevxHpx6nj1VhgVWIQLia6T2m72JCHF79gxtSQGpox5K8c+/3xYIgZNiaqh59Vtf+xoYYcmMveFjCd/Mt6tSX4psWUCF3V9J39R1zS3PlNPmvx61DYAXr+dgbKSs4rhgEKq7wzWU9gXg6Zks7zbnoxDOX/vfWAn2SfsbMn+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aGR8Agnw; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aGR8Agnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783355280;
	bh=IYB9Ky6tgj3xRW/gWUIyvo45eG0JxvTR9w90Wk3C55E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aGR8AgnwAHSpPxe7+GheFkpl1CoS9R0QWs5d6gRrR+sw05oajCNxfH3DqfF0QfXLY
	 ncjQ8uSfA+6fahVsnqdTa+Ot8g9HDonNkQUZdnR4vcOye3iq4xrg3i8yFm8YJw71Ug
	 a5swxvz2xv4c3yxhlxEQelHgG6iqZZhtgy+kmANY=
Received: from github.com (hubbernetes-node-ec19324.ac4-iad.github.net [10.52.220.58])
	by smtp.github.com (Postfix) with ESMTPA id EF65478E822
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 09:27:59 -0700 (PDT)
Date: Mon, 06 Jul 2026 09:27:59 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1122551/000000-0606fa@github.com>
Subject: [bluez/bluez] 9684d4: rap: Add Channel Sounding parameter types and
 APIs
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

  Branch: refs/heads/1122551
  Home:   https://github.com/bluez/bluez
  Commit: 9684d43159a9a4aef418b997c07a7258d3c8854a
      https://github.com/bluez/bluez/commit/9684d43159a9a4aef418b997c07a7258d3c8854a
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-06 (Mon, 06 Jul 2026)

  Changed paths:
    M Makefile.am
    A src/shared/cs-types.h
    M src/shared/rap.h

  Log Message:
  -----------
  rap: Add Channel Sounding parameter types and APIs

Add shared Channel Sounding parameter structures
(bt_rap_le_cs_config, bt_rap_le_cs_frequency and
bt_rap_le_cs_default_settings) for exchanging
CS configuration, frequency, and default settings
between the RAP DBus layer and HCI state machine.

Add getter/setter APIs for CS config, frequency
and default settings, add measurement.


  Commit: 823530b78c0d860d29cac0e90d347e42018f7edd
      https://github.com/bluez/bluez/commit/823530b78c0d860d29cac0e90d347e42018f7edd
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-06 (Mon, 06 Jul 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  src: Register GATT profiles for Channel Sounding reflector

Probe and accept GATT_UUID profiles on non-initiator (reflector)
devices before gatt_client discovery checks,
ensuring RAP's org.bluez.ChannelSounding1 DBus interface is registered
even when GATT client discovery is skipped.


  Commit: 14f9b56c183e89ee8fe34e3ecb740683ec8ce582
      https://github.com/bluez/bluez/commit/14f9b56c183e89ee8fe34e3ecb740683ec8ce582
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-06 (Mon, 06 Jul 2026)

  Changed paths:
    A doc/bluetoothctl-cs.rst
    A doc/org.bluez.ChannelSounding1.rst

  Log Message:
  -----------
  doc/org.bluez.ChannelSounding1: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods


  Commit: a4d1ace3d802305597edbfef23182cef836a4211
      https://github.com/bluez/bluez/commit/a4d1ace3d802305597edbfef23182cef836a4211
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-06 (Mon, 06 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: Add D-Bus Channel Sounding control API

Expose org.bluez.ChannelSounding1 on the device path,
adding SetDefaultSettings, StartMeasurement, and StopMeasurement methods
and an Active property to let external clients configure and
control CS ranging sessions.

Replace hardcoded CS configuration values with configurable HCI accessors
(bt_rap_{get,set}_cs_config_params, bt_rap_{get,set}_cs_freq_params,
bt_rap_{get,set}_default_settings_params).
Add measurement control APIs (bt_rap_start_measurement,
bt_rap_stop_measurement) with optional timeout-based auto-stop
and callbacks for timeout and procedure-state changes,
allowing DBus Active state to reflect actual controller procedure status.


  Commit: 0606faed6a74a76adf527500cbd1f568cd35b361
      https://github.com/bluez/bluez/commit/0606faed6a74a76adf527500cbd1f568cd35b361
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-06 (Mon, 06 Jul 2026)

  Changed paths:
    M Makefile.tools
    A client/cs.c
    A client/cs.h
    M client/main.c

  Log Message:
  -----------
  client: Add Channel Sounding shell submenu

Add a cs bt_shell submenu for controlling
org.bluez.ChannelSounding1, supporting measurement start/stop,
default-setting configuration, and session status display.
Maintain reusable validated CS parameters and
track active sessions via D-Bus Active state,
replies, and disconnects.
Integrate with client/main.c to manage per-adapter
ChannelSounding proxies, device resolution,
property updates, and session cleanup.


Compare: https://github.com/bluez/bluez/compare/9684d43159a9%5E...0606faed6a74

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
