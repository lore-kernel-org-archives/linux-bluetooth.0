Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E249426EC1
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219933; cv=none; b=PQDv99DUVOtTeZdgFjmyhDomP83dp6tiDBIdUChwmPE3BSIwyAdyYRBzXwga/MTb3oGLzRIwyp50inF2oXeTFB4v8HA4LLpbiM+WyMjOyQNEXZ15IgIB1WD9Oh3w7CamLC2oZ5xaLacEwkbeoy5hRk0df6sT8422gNg7QwD2MbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219933; c=relaxed/simple;
	bh=f8+nC92p+csavZm+TtIT7ekKP5e9gfghpctUt8BFaFo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mg+HkqIVeZmWV4G+4Kld8R6avDvt/vZFskfCbj1xFsRD3+ax8xPqstAmT1ZbGsrXfp33bYTFniLrq/NNx8F49f0QZZZ1PAMbfKGIB9fI7jv89YiEEr19lGM0DX3HwWmpAzNqv2Sevl5e/6NPjyBRF9lxSGVfL/ZG3e3Ka1uduHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Js+f2gaF; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Js+f2gaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784219919;
	bh=9DWnSlGg41GC08zt5M9QlkmmOWOUD8xtVB1vMUiwP4U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Js+f2gaFu1H9VfvFee3RfPlhyIPLAc2B+8U8UVrYDVvEZ85hMosrGFcEOWPHifTHd
	 tYxPt7JRWAvKFRghpulD8pqwoL0Cj42Ef1MKpSNoygwFTv5UPrgrG+zXA7RahXaD1r
	 MuHLKn6ckI4FkjwRBuiLpQHKkecq8mtarWp03nmo=
Received: from github.com (hubbernetes-node-2429117.va3-iad.github.net [10.48.73.46])
	by smtp.github.com (Postfix) with ESMTPA id 0F7E9340D0D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:38:39 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:38:39 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ae5d5a-efd216@github.com>
Subject: [bluez/bluez] befde3: rap: Add Channel Sounding parameter types and
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: befde3661e03049f2c84288a658433ba1559b357
      https://github.com/bluez/bluez/commit/befde3661e03049f2c84288a658433ba1559b357
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-16 (Thu, 16 Jul 2026)

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


  Commit: 66d986081360dbd9531432fc378affe9df5912e0
      https://github.com/bluez/bluez/commit/66d986081360dbd9531432fc378affe9df5912e0
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-16 (Thu, 16 Jul 2026)

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


  Commit: 79d1a58208e8a23b3df0003d9452195e0b4105c3
      https://github.com/bluez/bluez/commit/79d1a58208e8a23b3df0003d9452195e0b4105c3
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-16 (Thu, 16 Jul 2026)

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


  Commit: efd216fe280ba5dd38d1b6084f64784bf1328731
      https://github.com/bluez/bluez/commit/efd216fe280ba5dd38d1b6084f64784bf1328731
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-16 (Thu, 16 Jul 2026)

  Changed paths:
    A client/scripts/cs-initiator.bt
    A client/scripts/cs-reflector.bt

  Log Message:
  -----------
  client: Add scripts to start cs Initiator/reflector

This adds sample bluetoothctl scripts for cs initiator/
reflector.

cs-initiator.bt sets up and runs a CS measurement as an Initiator
cs-reflector.bt sets up the device to respond as a Reflector


Compare: https://github.com/bluez/bluez/compare/ae5d5a1e3032...efd216fe280b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
