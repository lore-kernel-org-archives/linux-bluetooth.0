Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952E472F8A
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940033; cv=none; b=cJS95Fy/Rd162k6HzS9CXw1R46jUyPnR6P3JHcX4OFclTVEEs/xg3HUtvmQG+aMuqwWEeSL0R1VhdAQDX+CxuFO8je3RyZZ0O5FYW62hnxH+dzFEQrnUDe+ueKMKgY/gru2Ie9WqLX/tYVpv+JJk4w3rRo9Z7TFmY2zdDJTspG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940033; c=relaxed/simple;
	bh=2Hww7TyFbokj7fB6zhgElWV0CXEkByBTmcOtVxWCfJU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=I9kQPa+VOw3L5m/QOnWJwHT5zfI7V9bRvYzAT6OJmM/NGbgVdw9GLMcOeUO53BQdfHDJJ55CgkC2GqmU1pLGsguzfUEXvmFGNzvySGCMdqm9Om2+Vym1eZeStuGWymh6dwHR49FmPCEgKqzp67AwantdwvJVfp4w3laughvnKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=iDxg4pkU; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="iDxg4pkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790940031;
	bh=fExVVq2wIWJa4186QU7hakqvKD61fZcgoioH2XGDsCY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iDxg4pkUU/vI8C/XxDK/obDe5vHEOaC8fdxtpRf90xYGHrFmtzifrikQnl1zxMfca
	 yCR227610liHWVLe0neGRMIEeaCVlZ9EFczFyEYuZeRx3JMqIDQ0WVHXKUbU1gDRCI
	 7R1i5QjOVzfYcWEVooCeaeQU1r2FwdUHc1r8sb2neYS+qURAJdgUlgDxofQ27Ya9Rw
	 M9rnK+CSkcN7aJMmTfVqqwuzXmhzyB3jjx1W6R6+bn6DkVXposND3ReYJTDH61ZXmJ
	 pdcPHqvPvyHGPlHR3PkC34dPnR9p/HHS1jyaQ2BMboIVBy8XvH65KkCNBMr7Mjo9D9
	 GzMk1qdSr6tow==
Received: from github.com (hubbernetes-node-1c25844.ash1-iad.github.net [10.56.181.28])
	by smtp.github.com (Postfix) with ESMTPA id 348161806B9
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 04:20:31 -0700 (PDT)
Date: Fri, 02 Oct 2026 04:20:31 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1178077/000000-0ad9be@github.com>
Subject: [bluez/bluez] 5b5da0: org.bluez.Device: Add Connectable property
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

  Branch: refs/heads/1178077
  Home:   https://github.com/bluez/bluez
  Commit: 5b5da032abbf80920c45bf059792bd8577a46e82
      https://github.com/bluez/bluez/commit/5b5da032abbf80920c45bf059792bd8577a46e82
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add Connectable property

This adds Connectable property which indicates whether the remote
device accepts connections, as reported by its last advertising report
or inquiry result.

bluetoothd already tracks this per bearer from the Device Found event,
but it is not exposed over D-Bus, so applications cannot tell
connectable advertisers such as peripherals from non-connectable ones
such as beacons without attempting a connection.


  Commit: 435cee00b1f51dd1dda29f31c1b45d6a5c8680c8
      https://github.com/bluez/bluez/commit/435cee00b1f51dd1dda29f31c1b45d6a5c8680c8
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M doc/org.bluez.Bearer.BREDR.rst
    M doc/org.bluez.Bearer.LE.rst

  Log Message:
  -----------
  org.bluez.Bearer: Add Connectable property

This adds Connectable property to org.bluez.Bearer.LE1 and
org.bluez.Bearer.BREDR1, so it is possible to tell which bearer of a
dual-mode device accepts connections, since Device1.Connectable is
always true for them as BREDR is always considered connectable.


  Commit: 79c9fa3b88de364c38dafeaf3facc913b417c96b
      https://github.com/bluez/bluez/commit/79c9fa3b88de364c38dafeaf3facc913b417c96b
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Add Connectable property

This implements Connectable property using device_is_connectable, which
reports whether the last advertising report on the device's bearer was
connectable, and emits PropertiesChanged from device_update_last_seen
when the value changes or first becomes known.


  Commit: 82b1143abb3d5f54871f692955d0e465fa58019d
      https://github.com/bluez/bluez/commit/82b1143abb3d5f54871f692955d0e465fa58019d
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M src/bearer.c
    M src/bearer.h
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Add Connectable property

This implements Connectable property for both bearers. For LE it
reflects whether the last advertising report was connectable, and
PropertiesChanged is emitted from device_update_last_seen when it
changes or first becomes known. BREDR always reports it as true.


  Commit: 7ad376befa6757249cc4d7f674691d5c989eba92
      https://github.com/bluez/bluez/commit/7ad376befa6757249cc4d7f674691d5c989eba92
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print Connectable in info

This prints the Connectable property of the device and its bearers with
the likes of info command:

bluetoothctl> info <addr>
...
        Connectable: yes
...
        LE.Connectable: yes


  Commit: 0ad9be996396ded044d29187cf756c3b0b053478
      https://github.com/bluez/bluez/commit/0ad9be996396ded044d29187cf756c3b0b053478
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print discoverable broadcasters in red

This prints devices in red when they set the discoverable flags but are
not connectable, to warn the user they cannot be connected to despite
being discoverable.


Compare: https://github.com/bluez/bluez/compare/5b5da032abbf%5E...0ad9be996396

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
