Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83126B953
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441393; cv=none; b=mWdIyLKUmbOxUWmPKHyravHIbwjsjzHwW8nk8i82YGFKY7gTegmjkmSrhPbXZ4JFXbA1GIKNkpXYXGNzf8zpQKKifUwOexZHm0wsQEBc91wo4zMNqs3nsnDto7vDG7/DB6g8TBZPkipJwNlpZYhr1jbIUk0tr+2pHEpNx5NWAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441393; c=relaxed/simple;
	bh=BiwS+Aes0yak7XavQKOW4eSWgIE3T8yVNeBXn8wBFkw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MZgIzcloyDLvJEsP5fCYVNI9NhQM4Qa7N8g04xMc4yZ+uMX6v463MMCRtj6+ZN9WmiwDccQPTH+6OUnLxgrEoSTq86kLlrDzm3NggDmJbfo2N+klf1iooAdM6U+KQKBwB5IKe2bYoyroBuI2jqpPy1uRFy5dvVP303j/+GgUxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kHcIZ0HC; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kHcIZ0HC"
Received: from github.com (hubbernetes-node-0b24f29.va3-iad.github.net [10.48.142.32])
	by smtp.github.com (Postfix) with ESMTPA id 9E41DE1124
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745441390;
	bh=AjTBJRUhtbtH7ag2zHwnJVag31BQIt4OQ1PyDu0BBe4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kHcIZ0HCKM/jGl2X/F3Ybi38/xVcKLzjg0ShuDiW9oBOdY9aWdROvengX7Gp8ht6k
	 /DNpgzNAqz+CE2MlqkNxkKEyrFlNCPvbUgnnNbC3b+AyruGyfDVULF/9LZo0u6tQB2
	 e+3tLjOvPjPN+9N+KEZct+u2HVcssXVAkBEP7rbo=
Date: Wed, 23 Apr 2025 13:49:50 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2d98e0-6c582e@github.com>
Subject: [bluez/bluez] 6c582e: audio/source: Fix crash on authentication
 failure
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
  Commit: 6c582e7e136097cbbc92563790fe5e873f01a9fe
      https://github.com/bluez/bluez/commit/6c582e7e136097cbbc92563790fe5=
e873f01a9fe
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-04-23 (Wed, 23 Apr 2025)

  Changed paths:
    M profiles/audio/source.c

  Log Message:
  -----------
  audio/source: Fix crash on authentication failure

The AVDTP reference count may decrease under 0 if authentication fails
and avdtp_unref() is called from source_unregister() then when changing
state from SOURCE_STATE_CONNECTING to SOURCE_STATE_DISCONNECTED:

src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
src/adapter.c:connected_callback() hci0 device EC:28:D3:0B:3B:7B
 connected eir_len 33
src/shared/mgmt.c:can_read_data() [0x0000] event 0x0011
src/adapter.c:bonding_attempt_complete() hci0 bdaddr EC:28:D3:0B:3B:7B
 type 0 status 0x5
src/device.c:device_bonding_complete() bonding (nil) status 0x05
src/device.c:device_bonding_failed() status 5
src/adapter.c:resume_discovery()
src/profile.c:ext_connect() Hands-Free unit failed connect to
 EC:28:D3:0B:3B:7B: Permission denied (13)
src/service.c:change_state() 0x556200cee6d0: device EC:28:D3:0B:3B:7B
 profile Hands-Free unit state changed: connecting -> disconnected (-13)
src/device.c:device_profile_connected() Hands-Free unit Permission
 denied (13)
profiles/audio/a2dp.c:a2dp_source_connect() path
 /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B
profiles/audio/avdtp.c:avdtp_ref() 0x556200d2fb80: ref=3D1
profiles/audio/avdtp.c:avdtp_ref() 0x556200d2fb80: ref=3D2
profiles/audio/a2dp.c:setup_ref() 0x556200cf3760: ref=3D1
profiles/audio/source.c:source_set_state() State changed
 /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B: SOURCE_STATE_DISCONNECTED ->
 SOURCE_STATE_CONNECTING
profiles/audio/source.c:source_connect() stream creation in progress
src/service.c:change_state() 0x556200d08470: device EC:28:D3:0B:3B:7B
 profile a2dp-source state changed: disconnected -> connecting (0)
src/service.c:btd_service_unref() 0x556200cee6d0: ref=3D1
src/shared/mgmt.c:can_read_data() [0x0000] event 0x000c
src/adapter.c:dev_disconnected() Device EC:28:D3:0B:3B:7B disconnected,
 reason 0
src/adapter.c:adapter_remove_connection()
src/device.c:device_remove_connection() connection removed while
 Connect() is waiting reply
plugins/policy.c:disconnect_cb() reason 0
src/adapter.c:bonding_attempt_complete() hci0 bdaddr EC:28:D3:0B:3B:7B
 type 0 status 0xe
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
src/device.c:device_bonding_failed() status 14
src/adapter.c:resume_discovery()
src/service.c:change_state() 0x556200d08470: device EC:28:D3:0B:3B:7B
 profile a2dp-source state changed: connecting -> disconnected (-103)
src/device.c:device_profile_connected() a2dp-source Software caused
 connection abort (103)
src/service.c:change_state() 0x556200d08470: device EC:28:D3:0B:3B:7B
 profile a2dp-source state changed: disconnected -> unavailable (0)
profiles/audio/source.c:source_unregister()
 /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B
profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=3D1
profiles/audio/a2dp.c:setup_ref() 0x556200cf3760: ref=3D2
profiles/audio/a2dp.c:setup_unref() 0x556200cf3760: ref=3D1
profiles/audio/a2dp.c:a2dp_cancel() aborting setup 0x556200cf3760
profiles/audio/a2dp.c:setup_unref() 0x556200cf3760: ref=3D0
profiles/audio/a2dp.c:setup_free() 0x556200cf3760
profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=3D0
profiles/audio/avdtp.c:avdtp_ref() 0x556200d2fb80: ref=3D1
profiles/audio/avdtp.c:connection_lost() Disconnected from
 EC:28:D3:0B:3B:7B
profiles/audio/source.c:source_set_state() State changed
 /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B: SOURCE_STATE_CONNECTING ->
 SOURCE_STATE_DISCONNECTED
profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=3D0
profiles/audio/avdtp.c:avdtp_free() 0x556200d2fb80
profiles/audio/a2dp.c:channel_remove() chan 0x556200cf5400
profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=3D-1
profiles/audio/avdtp.c:avdtp_free() 0x556200d2fb80

This has been tested with:
- BlueZ 5.77 + kernel 5.4
- BlueZ upstream + kernel 6.11



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
