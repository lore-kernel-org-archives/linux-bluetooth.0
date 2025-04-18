Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFECA126BF7
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993054; cv=none; b=nRuq5/+CSIPqbcS4nawj2jIf9o4mpVbgLZOHI7xqR2k+cYCVMAZVaGZptbI1FmsjjmZMm0EWTVhZ0uWMknE8EpXBSeHi8JEj/JfrqsfI7UE36ae20DcpfS/5Ign5Jb2NWjaoW0i+polYxM2CxI8038Oly/zFkUyTD3jrZmvH5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993054; c=relaxed/simple;
	bh=+c6bbY+y3cmqe1V4+99LA+NpuapXb0qATD2Zu0pJaGQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h/l1vyk1DNKEwZuvCU1bUScdFNzdNeroXTf4DR+SY7qrSjwe11h86ENA7+VAx8kzgala8hwZ6kqbSjtMr+EO4qv0oNk0zzLkUstm7VDTCMf7Hzmof3rqzA8k8aPSyaXVMHEppVei7BClSOzBUllvo9rVX0KS+RUofvVky1IchMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T97fZZUB; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T97fZZUB"
Received: from github.com (hubbernetes-node-da265f8.ash1-iad.github.net [10.56.148.25])
	by smtp.github.com (Postfix) with ESMTPA id 7ED2E9210CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1744993051;
	bh=kzPAyws5GaSdDlvWc0SFq5qbaUjB1XIKWUXgGXX+ceE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T97fZZUBp/BuVQkkfStBcxGhj5JgPdaNOObTR1NGMxgxwQQKQr/IG4Fo0/XKg+rrM
	 gk/4B3XOApjIIdW+0MQDUfv/8uQbf/bJ64CgTomcul/C1w/QuM5vlQb9zQEHtqEpT9
	 OAvfWOyUuz+201sE3rPlWUUZgL3iz7xB2DJ9hVao=
Date: Fri, 18 Apr 2025 09:17:31 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2a569e-8d472b@github.com>
Subject: [bluez/bluez] 8d472b: obexd: only run one instance at once
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
  Commit: 8d472b8758dcdd89bf13cf2fb06a8846e1f483a0
      https://github.com/bluez/bluez/commit/8d472b8758dcdd89bf13cf2fb06a8846e1f483a0
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-18 (Fri, 18 Apr 2025)

  Changed paths:
    M obexd/src/obex.service.in

  Log Message:
  -----------
  obexd: only run one instance at once

Obex is a device-oriented protocol, so only one instance can run per device.
But Linux file security is user-oriented, so obexd should be a user service.
Tell systemd to only run this service for the first non-system user to log in.

Without this patch, errors like the following will occur if you
use the "switch account" feature of your desktop environment,
then log in with another account:

Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001133-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001132-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 0000112f-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001104-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001106-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00001105-0000-1000-8000-00805f9b34fb which is already registered
Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:register_profile() :1.2016 tried to register 00005005-0000-1000-8000-0002ee000001 which is already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered
Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestProfile error: org.bluez.Error.NotPermitted, UUID already registered

The above errors indicate the service completely failed to register, so this
does not change the user experience beyond removing the above messages.
Specifically, the first user who logs in to a multi-user system still retains
obex access to devices paired by users who log in later.

This is based on a pair of recent changes to the FluidSynth daemon:

https://github.com/FluidSynth/fluidsynth/pull/1491
https://github.com/FluidSynth/fluidsynth/pull/1528

This was discussed in the comments for a GitHub advisory available at
https://github.com/bluez/bluez/security/advisories/GHSA-fpgq-25xf-jcwv
but comments are not shown in the published version of the advisory.
To summarise the useful conversation with Luiz Augusto von Dentz:

Obex requires access to the user's home directory, so an attacker can only
transfer files between locations the user controls.  That may be a problem
if the user who runs obexd is different to the user who paired the device,
but solving that would involve pairing per-user, which causes other problems.
Bluetooth connections can be initiated by peripherals, so switching user could
trigger re-pairing and cause the original user to lose access to the device.
This may seem reasonable for file access, but for example users would likely
object to constantly re-pairing their Bluetooth keyboard.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
