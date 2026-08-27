Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E0175D53
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844465; cv=none; b=PuFSyqtm4pXK9aAEpTnQv0OCXIEC6/g5JOvD2v8MZdjzTLQkRMTs5ohOTKSzDTfvJVyVYMFhwgi451ejZkQCS+WpT39q4gOhWgv6os+2sgGkvop8X2sGHtgDRwNSI4cf9ixRB6IvstxWxN+CNdYmHfAAU7ODiKi2XH13HiRK7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844465; c=relaxed/simple;
	bh=9NSkgirvLvKQeZe0YUug3u6vQgYvJo4WWD00xDCD6eM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PAm5VVR3wqlk9O7QlW/3swaduKj0/O7lOzxXCe+6ksdvcfy6NKTiVkpg7pxgaVRybIwjbWAzvgQd+CUxP24hNT5cTRfB8S2+xQfrXc1g+k1pcm+n/5wkz8DIs4Yguc1EnFx1o413ZSqN+Azg+MNg+fX5uvSUHrY4UbxOhicUzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iO9Sjbx/; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iO9Sjbx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787844462;
	bh=FR6kX+61RqUkg0Afg2rSgtfP8b11Ys9BhK0cerCNA+c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iO9Sjbx/THkBb4EQRYyhZJJ66RmKZ6w9FPLKevLOGjjGxlwW47eU2m+B8Pu3/j2C1
	 a8VvQO31donVgGgoRZRWL68k5qfzB39XOw7nmhLm8/esV20EZMnTn4lbknbKOrJjLQ
	 pEU00GDYvFrC/ByCYd+C4zx+qH/o9YkzSj0NZbOk=
Received: from github.com (hubbernetes-node-2d4d900.ash1-iad.github.net [10.56.128.62])
	by smtp.github.com (Postfix) with ESMTPA id C18BE180BAB
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:27:42 -0700 (PDT)
Date: Thu, 27 Aug 2026 08:27:42 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152414/000000-2e92f8@github.com>
Subject: [bluez/bluez] e8cdd5: doc: Add org.bluez.Ranging1 documentation
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

  Branch: refs/heads/1152414
  Home:   https://github.com/bluez/bluez
  Commit: e8cdd5d30e733c53f420691dbb88fcd7fcee120c
      https://github.com/bluez/bluez/commit/e8cdd5d30e733c53f420691dbb88fcd7fcee120c
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Ranging1.rst

  Log Message:
  -----------
  doc: Add org.bluez.Ranging1 documentation

Document org.bluez.Ranging1 interface, which
exposes the Distance estimate computed by an
external ranging provider registered via
RangingProviderManager.

Add org.bluez.ChannelSounding1.rst to EXTRA_DIST


  Commit: ec7f3986933b40b89b9fcf6241649553143ea946
      https://github.com/bluez/bluez/commit/ec7f3986933b40b89b9fcf6241649553143ea946
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.RangingProvider1.rst

  Log Message:
  -----------
  doc: Add org.bluez.RangingProvider1 documentation

Document org.bluez.RangingProvider1 interface,
implemented by external clients to expose per-device Channel Sounding
distance estimates that BlueZ reflects onto the corresponding device
object.


  Commit: 63d6e092c6eb7c05413f223f474078c4e0f7db7e
      https://github.com/bluez/bluez/commit/63d6e092c6eb7c05413f223f474078c4e0f7db7e
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.RangingProviderManager1.rst

  Log Message:
  -----------
  doc: Add org.bluez.RangingProviderManager1 documentation

Document org.bluez.RangingProviderManager1 interface,
used by external clients to register and unregister
themselves as Channel Sounding distance providers via
RegisterRangingProvider/UnregisterRangingProvider


  Commit: a27cde3ba9155a0b09fab860a15677ad2e032d13
      https://github.com/bluez/bluez/commit/a27cde3ba9155a0b09fab860a15677ad2e032d13
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc: Modify bluetoothctl-cs documentation

Add documentation for register-provider and
unregister-provider cs menu options


  Commit: 938bcfda7c8c3e6cca81de76148754fe1cd91794
      https://github.com/bluez/bluez/commit/938bcfda7c8c3e6cca81de76148754fe1cd91794
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M Makefile.am
    M src/adapter.c
    A src/ranging.c
    A src/ranging.h

  Log Message:
  -----------
  src: Add Ranging provider D-Bus API

Introduce org.bluez.Ranging1 and
org.bluez.RangingProvider1/ RangingProviderManager1
D-Bus interfaces

External providers can register a root path
via RegisterDistanceProvider and expose per-device
RangingProvider objects; updates to their Distance
property are mirrored onto exported Ranging objects via
btd_ranging_update(), emitting a PropertiesChanged signal.

The Ranging provider manager is wired into the adapter lifecycle,
created on adapter setup and destroyed on adapter
removal.


  Commit: e48adbe73547d39bf4eb565525ab1a1b6f4e0c01
      https://github.com/bluez/bluez/commit/e48adbe73547d39bf4eb565525ab1a1b6f4e0c01
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M client/cs.c
    M client/cs.h
    M client/main.c

  Log Message:
  -----------
  client: Add ranging distance display support to bluetoothctl

Track org.bluez.Ranging proxies and append/remove them
on InterfacesAdded/InterfacesRemoved.

Print the Distance property on PropertiesChanged,
and show it under info option alongside the existing
Battery Percentage and CS Active properties.

Add register-provider and unregister-provider options
as reference implementation.


  Commit: 2e92f87fdfc981cec6f8234e908356675fbb724d
      https://github.com/bluez/bluez/commit/2e92f87fdfc981cec6f8234e908356675fbb724d
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M Makefile.tools
    A test/example-ranging-provider

  Log Message:
  -----------
  test: Add Python Ranging Provider example

This patch introduces test/example-ranging-provider which implements
a simple D-Bus client application for ranging profile.


Compare: https://github.com/bluez/bluez/compare/e8cdd5d30e73%5E...2e92f87fdfc9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
