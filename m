Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF04A8FEB
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959397; cv=none; b=EJUmeuG/bKHruyWczvsV5pcVwudf8vHYcx8RadFpTQbAb+qNswlxLKHobaFZws2qs5CXaJhjh2pdMAEECM9f1F/VgEtpg1ixYJMaifA7oROw5RuUWJXD6GDsnLWT47ly9Gjie0Uu5JDzjYVk519bosLm3BJussaqZRU6L2QWVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959397; c=relaxed/simple;
	bh=lyG9HnDub9u8AwEYlNg5xjM+YgUcwiodIsyr/oSQQyM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WCtwHqZZVOrSxp12F1Kx/MT3G4wIiHimOgaK6FzX+LN5INPRmHtsOwDU8y4fotMo1REOpNHwutstcf3iQL/hHFtDWUqYN+VQ8NWBNZfjil+MjXsNZree8anNcvRGsWCWX0TzlIefXpe/aCVFE21lE4zOpU5ANotR809vZUg9c+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=OCpeuWYA; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="OCpeuWYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790959394;
	bh=49yoaYv2exEmy5RehvqcmNeoKHD0IQznhFv6mmQ2544=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OCpeuWYA1sDPGQ3LwIscb30Dhf/fTycqbLM3cih7Fych5/fI1mkZwh2BXH3xxFEyR
	 XCYYTq2vbgP5IzKPrjhI+cyDUPemHh51slVPgZMt/ftW6KoMrP2RJerpaQDRtKyzU5
	 xe+Iarg2Urm9n6uh7rfY0zhebgU0G/RT/4orAOWlz2zk29fxehhIzL4p9BqFU61RJi
	 oMDV52T//mQlkgHjDcFg/ZgOdN5rnIdmAWjqr/LpPMGYp7xtSn/F8GA8RsHkT/0zLi
	 gOTisKJgn3chXQZ/053iVAtlZr+duNg7rNfoNHemk8GgZ9dOuOm1fPTCfEtIje3knx
	 CR8BIxaXehThQ==
Received: from github.com (hubbernetes-node-a599025.va3-iad.github.net [10.48.66.48])
	by smtp.github.com (Postfix) with ESMTPA id D4DFC800B2A
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 09:43:14 -0700 (PDT)
Date: Fri, 02 Oct 2026 09:43:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ae69dc-4dc15b@github.com>
Subject: [bluez/bluez] 7a55a6: mgmt-tester: Fix LE Security Level Changed
 expecte...
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
  Commit: 7a55a67cb49bce2e302963ee0fca627ec3b270c7
      https://github.com/bluez/bluez/commit/7a55a67cb49bce2e302963ee0fca627ec3b270c7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix LE Security Level Changed expected encryption type

LE pairing results in an AES-CCM encrypted link, so expect
MGMT_CONN_SEC_ENCRYPT_AES_CCM instead of MGMT_CONN_SEC_ENCRYPT_NONE,
which only matched the event emitted on connection before pairing.

Fixes: 74334ac97049 ("mgmt-tester: Add Security Level Changed event tests")
Assisted-by: OpenCode:claude-opus-5.5


  Commit: 75a778e17f49560097c684058a9ff814e2279bfc
      https://github.com/bluez/bluez/commit/75a778e17f49560097c684058a9ff814e2279bfc
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


  Commit: f890d4b660c664ccca0e146ecfd2d58688f917d7
      https://github.com/bluez/bluez/commit/f890d4b660c664ccca0e146ecfd2d58688f917d7
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


  Commit: 6afb6e729270a3e85f020c724baae621a413fc8e
      https://github.com/bluez/bluez/commit/6afb6e729270a3e85f020c724baae621a413fc8e
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


  Commit: ab50d5e88fb652f1a1c35336c1aab632b2e80993
      https://github.com/bluez/bluez/commit/ab50d5e88fb652f1a1c35336c1aab632b2e80993
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


  Commit: 82f671c83429aa3548a26c92e05d3e7125356068
      https://github.com/bluez/bluez/commit/82f671c83429aa3548a26c92e05d3e7125356068
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


  Commit: 4dc15be8ee3f7422d447087f1893d215575cb2c8
      https://github.com/bluez/bluez/commit/4dc15be8ee3f7422d447087f1893d215575cb2c8
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


Compare: https://github.com/bluez/bluez/compare/ae69dcddd549...4dc15be8ee3f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
