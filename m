Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F873126B0
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783859647; cv=none; b=dZ29tLg7cPXzsXpc2x671GEiwT6W2vHYovnSLBc6InbGbUNStMKM1QC4L0Lm17pHAisinFcFBjEbXsNk0ipS46JPYBxGF+cU4TPYtTQKkYT3alWSZfUVJ/DWgKuYaY+iiVSaFuqA1LRNA6OOxCsczEsOillT4di0mkOTrmf134c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783859647; c=relaxed/simple;
	bh=G51SjxgYyrMGvPo0GfwWgunj0n1ad1yGakMdvIW5Ez0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U4kxXi9fZLucA9DxPXEVEeOdYHOAuoQKJ4+h2rr9IepaTy04seQLXNpnKy4mV5GdUTxrG2lmcvzh9emFiP2y8p1fKaCJRbEGrigvtAM09RmRCK6gtyA5fqEc3ewNF6JNh05UNbxsHPuuwUouA6x5Smcg2cbivCV4Xjo7MQqm1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kej6txNy; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kej6txNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783859645;
	bh=+sCjuq0I/vZ7Oszkh7LDNrRBcAOpz1r5p/55FMEB4tM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kej6txNyidB+8y2DaVhqYr4qD8/PJv43k0CYCw18YZyUbflBUxR4g8CwMNXwVYfP6
	 Meqj5Q6GftHoZCNXg7I7jTmNuqFCxrLv54PMkzKZfUzHYBWbWAASyGUUtRaWLZF0bc
	 WJIEOg+qud+LbAqLwsCHoBpD7vFqxbzw91sJ3pX8=
Received: from github.com (hubbernetes-node-2f5a1e3.ac4-iad.github.net [10.52.131.37])
	by smtp.github.com (Postfix) with ESMTPA id AA8DB3207F1
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 05:34:05 -0700 (PDT)
Date: Sun, 12 Jul 2026 05:34:05 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1126078/000000-a317a3@github.com>
Subject: [bluez/bluez] e60637: rap: Add Channel Sounding parameter types and
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

  Branch: refs/heads/1126078
  Home:   https://github.com/bluez/bluez
  Commit: e60637ba8cc4fa3eaf41de1f913138af64673571
      https://github.com/bluez/bluez/commit/e60637ba8cc4fa3eaf41de1f913138af64673571
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-12 (Sun, 12 Jul 2026)

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


  Commit: dbbf2ac08f40b6537568fc2a418c3aeba75842ec
      https://github.com/bluez/bluez/commit/dbbf2ac08f40b6537568fc2a418c3aeba75842ec
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-12 (Sun, 12 Jul 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  src: Register GATT profiles for Channel Sounding reflector

Probe and accept GATT_UUID profiles on non-initiator (reflector)
devices before gatt_client discovery checks,
ensuring RAP's org.bluez.ChannelSounding1 DBus interface is registered
even when GATT client discovery is skipped.


  Commit: 481899b86437b09f50ee68c7ad0e9d1fabe9ce5a
      https://github.com/bluez/bluez/commit/481899b86437b09f50ee68c7ad0e9d1fabe9ce5a
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-12 (Sun, 12 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: Add D-Bus Channel Sounding control APIs

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


  Commit: a317a3fb368cde3546ce52c1371ce57f4947f56a
      https://github.com/bluez/bluez/commit/a317a3fb368cde3546ce52c1371ce57f4947f56a
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-12 (Sun, 12 Jul 2026)

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


Compare: https://github.com/bluez/bluez/compare/e60637ba8cc4%5E...a317a3fb368c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
