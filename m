Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AC1B6CFF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802649; cv=none; b=GLiTpAbCn7Rp8OIIOvwfGSf4j6bwcXrv3p99S3PkbihOvEy3LCUXLprqd2pJq6b8CzX8Cr9j5lgS93bMBf3UfhE1DAMmq5CPHZ/9YaxbcnkF6gI1OfhLiBBMHv429dX5Pieasiz6CvFT9cA91bdg+MjQ0NXwJFrEhlteaNV9+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802649; c=relaxed/simple;
	bh=JqSyNNocfmsysEVa1g/f7Pxq5F7biCDtU9UIpWah4JA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=soMQLfMaBM7BsBsUgy0swge9Dw85FMCHUMFmqofwrude5Iz/rri9KCEjjOUK4XORfTvFf4wD6PBQWxOFZReZOfVsPCEJZ9aH6Feg0sXJ1YwZy/kFZVfz66l/st9hIyaABop1YfzwJ1GTQdjhPMtBV+sLbM3W4QS75iMA5I0XKrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DYHC/kt0; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DYHC/kt0"
Received: from github.com (hubbernetes-node-9f98c32.ac4-iad.github.net [10.52.14.64])
	by smtp.github.com (Postfix) with ESMTPA id 383845E0336
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 13:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1736802647;
	bh=e3Jh8giI86Foj0B6C5NitI5u70c8e0cXrHX126wLSnc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DYHC/kt08FsPcKWT8z0xZTFc0kUjoE9zOYoI+XA88OMTPk/1z5cJTC1KMpnwlMfmw
	 64C4vCbWGfWozrFcgwPyHziyH7wJ/IkQCIj7KbCwCRgJoZ48KCXkwgG+8tyJzrxwTM
	 s7Gf+5FcZpGTuyuBE4fGkgfD1EqGsa9HFxurKhxc=
Date: Mon, 13 Jan 2025 13:10:47 -0800
From: Ludovico de Nittis <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2762df-2ee08f@github.com>
Subject: [bluez/bluez] 5f8a68: build: Fix --disable-asha
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
  Commit: 5f8a68d9f2996bdee2bc27a0e2d8e28d400a5b91
      https://github.com/bluez/bluez/commit/5f8a68d9f2996bdee2bc27a0e2d8e28d400a5b91
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-01-10 (Fri, 10 Jan 2025)

  Changed paths:
    M configure.ac
    M profiles/audio/transport.c

  Log Message:
  -----------
  build: Fix --disable-asha

This fixes --disable-asha causing build errors:

/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_set_volume':
/bluez/profiles/audio/transport.c:2362:(.text.transport_asha_set_volume+0x2f): undefined reference to `bt_asha_device_set_volume'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_get_volume':
/bluez/profiles/audio/transport.c:2345:(.text.transport_asha_get_volume+0x9): undefined reference to `bt_asha_device_get_volume'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `get_asha_delay':
/bluez/profiles/audio/transport.c:1566:(.text.get_asha_delay+0xd): undefined reference to `bt_asha_device_get_render_delay'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `asha_transport_sync_state':
/bluez/profiles/audio/transport.c:2216:(.text.asha_transport_sync_state+0x8): undefined reference to `bt_asha_device_get_state'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `asha_transport_state_cb':
/bluez/profiles/audio/transport.c:2245:(.text.asha_transport_state_cb+0x1d): undefined reference to `bt_asha_device_get_state'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2252:(.text.asha_transport_state_cb+0x94): undefined reference to `bt_asha_device_get_fd'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2253:(.text.asha_transport_state_cb+0xa0): undefined reference to `bt_asha_device_get_imtu'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2254:(.text.asha_transport_state_cb+0xad): undefined reference to `bt_asha_device_get_omtu'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_resume':
/bluez/profiles/audio/transport.c:2290:(.text.transport_asha_resume+0x19): undefined reference to `bt_asha_device_start'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_suspend':
/bluez/profiles/audio/transport.c:2303:(.text.transport_asha_suspend+0x1e): undefined reference to `bt_asha_device_stop'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2307:(.text.transport_asha_suspend+0x48): undefined reference to `bt_asha_device_stop'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_cancel':
/bluez/profiles/audio/transport.c:2318:(.text.transport_asha_cancel+0x17): undefined reference to `bt_asha_device_get_state'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2320:(.text.transport_asha_cancel+0x22): undefined reference to `bt_asha_device_device_get_resume_id'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2334:(.text.transport_asha_cancel+0x61): undefined reference to `bt_asha_device_state_reset'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2328:(.text.transport_asha_cancel+0x81): undefined reference to `bt_asha_device_stop'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6378: src/bluetoothd] Error 1
make: *** [Makefile:4696: all] Error 2


  Commit: a30763866b7a6d5bf5001df66223c286c63698b4
      https://github.com/bluez/bluez/commit/a30763866b7a6d5bf5001df66223c286c63698b4
  Author: Shuai Zhang <quic_shuaz@quicinc.com>
  Date:   2025-01-13 (Mon, 13 Jan 2025)

  Changed paths:
    M profiles/network/server.c

  Log Message:
  -----------
  BNEP: Fix the BNEP Unknown Control Message in PTS testing:

This change is required for passing below PTS testcase:
1. BNEP/CTRL/BV-01-C

Fix the flag judgment issue, it should check type
instead of ctrl.


  Commit: 2ee08ffd4d469781dc627fa50b4a015d9ad68007
      https://github.com/bluez/bluez/commit/2ee08ffd4d469781dc627fa50b4a015d9ad68007
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-01-13 (Mon, 13 Jan 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Clear pending_wake_allowed on error

If setting WakeAllowed fails, we should unset the `pending_wake_allowed`
property, or subsequent requests will be rejected due to another
"Property change in progress".

Fixes: https://github.com/bluez/bluez/issues/1047


Compare: https://github.com/bluez/bluez/compare/2762dffb062e...2ee08ffd4d46

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
