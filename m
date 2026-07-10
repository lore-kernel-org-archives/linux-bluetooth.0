Received: from out-1.smtp.github.com (out-1.smtp.github.com [192.30.252.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877441C2FB
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682944; cv=none; b=mUqNme6aqVRYDUfsemSU8IMox66KbDg+KoXWZ0tcmn90Bf5wXf4DvzctuczH5J/zzomaOEi0rmdCTTr+XY4iBssWtNnJgdK/vq2eKKojwi37mDLDcozOFornnfWc3pqJCnbyDci0LQw3RuTB+vPfZWe/cJB/0utLOIgcF9OHdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682944; c=relaxed/simple;
	bh=FV16pxDI6X7FsJh2fWEeplYMMyuRJYocQsw0o3dCw74=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H00o1ZE1dOXawWAPrU/hmZS4lSnCR3ofm5VHQHnZRKbcGwAIg/irDc1GbubZKi8Qxd4i4zMeJl7iWg7hZHdo0Tn3fY+AD1IEtE/r/DTpWVZtl9qzl3LcMUNKzF7JddywxDYxTNb9ZpbL8L2qQ3ip6SuQaErVN7RFWVB8rz6y064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HV5eVgut; arc=none smtp.client-ip=192.30.252.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HV5eVgut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783682933;
	bh=fCshfpjO9UC1C5hN3NVMtwfQTtP7/ZmK+vVOWgF48Lk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HV5eVgutnXw9VWNS8UoBLu8K0pyfHw8+Hcmb5LitWgGv9A41OKO/j6QuhW1Go9vhO
	 hr1yDfCwBcrnYtchVBmhkKPmK2vprxpy9z25lyg3BzzkdHJodlS2bMMqOCDgl0mPSb
	 YNrJ57MDvhqCTZtjtJh9kDPiaurchDBEWftipwB0=
Received: from github.com (hubbernetes-node-95aaa0f.va3-iad.github.net [10.48.143.10])
	by smtp.github.com (Postfix) with ESMTPA id DBC8A341338
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 04:28:53 -0700 (PDT)
Date: Fri, 10 Jul 2026 04:28:53 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125291/000000-1bbf7d@github.com>
Subject: [bluez/bluez] 21cfab: rap: Add Channel Sounding parameter types and
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

  Branch: refs/heads/1125291
  Home:   https://github.com/bluez/bluez
  Commit: 21cfabe9fbe7bb97a519be5fd209b690e9378952
      https://github.com/bluez/bluez/commit/21cfabe9fbe7bb97a519be5fd209b690e9378952
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

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


  Commit: 01d1afb713431379d4148e9ff0ec30ba440c53e0
      https://github.com/bluez/bluez/commit/01d1afb713431379d4148e9ff0ec30ba440c53e0
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  src: Register GATT profiles for Channel Sounding reflector

Probe and accept GATT_UUID profiles on non-initiator (reflector)
devices before gatt_client discovery checks,
ensuring RAP's org.bluez.ChannelSounding1 DBus interface is registered
even when GATT client discovery is skipped.


  Commit: 46b6e4659ee4ea50ca84ed5c56d0dc00fb51ccc8
      https://github.com/bluez/bluez/commit/46b6e4659ee4ea50ca84ed5c56d0dc00fb51ccc8
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

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


  Commit: 1bbf7d512778ba3bbb2797d23c90a0e432d387af
      https://github.com/bluez/bluez/commit/1bbf7d512778ba3bbb2797d23c90a0e432d387af
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

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


Compare: https://github.com/bluez/bluez/compare/21cfabe9fbe7%5E...1bbf7d512778

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
