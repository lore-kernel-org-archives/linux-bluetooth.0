Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAB1EFFA1
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328843; cv=none; b=Do63e8LsexS2zPu2zRC2yXsfvKQI+WrjcnEFailYIlS36c8MnbDYmSetbhiUOde757X4ipJfP5qrNhD3PtUVuFUPidthtAk4HePt6wExXMSm9IqAsHU3xPCC+r1ltIG+MY7AFoY+h/U5kSeJ7vLazCchEXJegwJtGdhdaiIiS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328843; c=relaxed/simple;
	bh=+KOHolt7b+kf/3kDIRIDX/g2bxbiBp3D+kslp93pxqI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Zk916SlwIm2C19GgQQ2KXBjZgyHKPp/qUIQ0GWBddcwMv6WMaHRCby/mtMGjT7YWOZjLpw0a7Abm0/PF2zjIUnsO/7pDtD9TXxOcdKMtMw9gTpcvUARqgcl5oZUUPrUxmv63j+fKQKHbDTHpg9LzNniGZIhytOF32hulpbiaWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XdpsPUa3; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XdpsPUa3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787328839;
	bh=2t7C9fsVCDmJVCE6HBYwa/XcIdFgNlkA89Q7ChA2cec=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XdpsPUa3ewMmuQ7/PEhb7zmErQV9jbt8PgDkkuHtg8pkzgOH+315BjkQHcpUFjKXD
	 26o8+Xy6ZU+RRV8E2n5N4dMMnJxOvh/E2bATkBZCVDYFzHuj9nMdqpcqznIxDuuqN+
	 ly7sdDA2rUXuJeWIPHsi5SoL4NBvUoSxYlup2dxk=
Received: from github.com (hubbernetes-node-a16cbab.ac4-iad.github.net [10.52.152.12])
	by smtp.github.com (Postfix) with ESMTPA id A4F79741299
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:13:59 -0700 (PDT)
Date: Fri, 21 Aug 2026 09:13:59 -0700
From: Matthias Kurz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149924/000000-8fa503@github.com>
Subject: [bluez/bluez] 9ab88d: battery: Add component battery objects
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

  Branch: refs/heads/1149924
  Home:   https://github.com/bluez/bluez
  Commit: 9ab88d0763238ae8c7ba85fed11bc33773a2b80c
      https://github.com/bluez/bluez/commit/9ab88d0763238ae8c7ba85fed11bc33773a2b80c
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M src/battery.c
    M src/battery.h

  Log Message:
  -----------
  battery: Add component battery objects

Allow one Bluetooth device to export multiple Battery1 objects while
keeping the legacy aggregate object at the device path.

Component objects expose their parent Device1 path, a stable identifier,
an optional percentage, and an optional charging state. Extend
BatteryProvider1 handling with the same semantics so external providers can
publish multiple batteries too.

Keep component objects and their new properties behind the experimental
D-Bus flag while the API is being established.

Assisted-by: Codex:gpt-5.6-sol


  Commit: 6d2e72a68fa77812d0dbf2014c663feeab6200f9
      https://github.com/bluez/bluez/commit/6d2e72a68fa77812d0dbf2014c663feeab6200f9
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M doc/org.bluez.Battery.rst
    M doc/org.bluez.BatteryProvider.rst

  Log Message:
  -----------
  doc: Document component battery objects

Describe the experimental component Battery1 properties, their opaque
object paths, and how BatteryProvider1 implementations publish several
batteries for one device.

Assisted-by: Codex:gpt-5.6-sol


  Commit: a5aa7e55ce267ac510968e3cfcbc19440d48309f
      https://github.com/bluez/bluez/commit/a5aa7e55ce267ac510968e3cfcbc19440d48309f
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M Makefile.plugins
    M doc/test-coverage.txt
    A profiles/fastpair/fastpair.c
    A profiles/fastpair/message-stream.c
    A profiles/fastpair/message-stream.h
    A unit/test-fastpair.c

  Log Message:
  -----------
  fastpair: Add Message Stream battery profile

Connect to the experimental Fast Pair Message Stream service advertised by
compatible BR/EDR devices and parse its 16-bit-length framed messages.

The Message Stream specification defines a fixed endpoint UUID over RFCOMM
and a separate L2CAP PSM transport. This implementation supports the RFCOMM
variant; L2CAP support is left for future work:

https://developers.google.com/nearby/fast-pair/specifications/extensions/messagestream

Publish left, right, and case values as component Battery1 objects. The
Device Information extension defines the battery update message. Its three
component bytes use the Battery Notification encoding:

https://developers.google.com/nearby/fast-pair/specifications/extensions/deviceinformation
https://developers.google.com/nearby/fast-pair/specifications/extensions/batterynotification

Include unknown percentage and charging-state transitions. Decode unknown
levels using the generic Battery Notification status bit while treating the
TWS-specific case value 0xff as unavailable, as required for hearables:

https://developers.google.com/nearby/fast-pair/specifications/devicefeaturerequirement/devicefeaturerequirement_hearables

If only the Message Stream is lost, invalidate its values and reconnect.
Use exponential backoff and reset it only after a battery-producing stream
remains stable. Remove the objects once the BR/EDR bearer disappears.

Keep pending connection callbacks alive through cancellation and ignore
callbacks for detached or superseded channels.

Assisted-by: Codex:gpt-5.6-sol


  Commit: 8fa503661cb8cbbde1ebae72fbc8db48ae18ded8
      https://github.com/bluez/bluez/commit/8fa503661cb8cbbde1ebae72fbc8db48ae18ded8
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M Makefile.tools
    A test/test-fastpair

  Log Message:
  -----------
  test: Add Fast Pair Message Stream tool

Add a standalone profile client that prints Fast Pair Message Stream frames
and can optionally publish left, right, and case values through
BatteryProvider1.

Publish dynamic component lifecycle signals, scope providers per adapter,
and invalidate measurements when a stream closes. Warn users to disable the
built-in Fast Pair plugin when using the external profile.

Assisted-by: Codex:gpt-5.6-sol


Compare: https://github.com/bluez/bluez/compare/9ab88d076323%5E...8fa503661cb8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
