Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49641DDA2D
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543362; cv=none; b=BctlfeXL0tam/oh5YquoDeNyyE0i7mLKSx9ak4U6WMrNkrKNlYmJCPlxh+cUXnMUbxxNz6ivl/eJ0vH+onewdj8AtGqwlnTcViu3EZK0JdPXhQfwyjndhXC4MiXypyQSm03WvI7TcBATX2S+bCOU+5Snqo8X7k+aKii1kdGGoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543362; c=relaxed/simple;
	bh=2Y/9QLvrM7oDGfQzYnDP0Uv0gnCkIlq8XkdG7P6N1Gg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j2jnhVh01x7Twrjc0x0dJ6XuWoCpnu8cJH0nlingH8xpKSIm3lIbBmzxN2n4/Oa7r74VtR808c7wm9XMZh//PUwC9xjSvF6h+B1UOEosMvEB0XLRoqctALsdEGfwz/ptMPsRX4aBEIBVwQR2gVIb059E1IZG2kCcFWPGP30nWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O8Qliq3j; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O8Qliq3j"
Received: from github.com (hubbernetes-node-4f0dedc.va3-iad.github.net [10.48.181.30])
	by smtp.github.com (Postfix) with ESMTPA id E035E8C0416
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746543359;
	bh=u6rsB3IOphli37V0V5yAehUH8vpd5oo1cvWo1c+FsdE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O8Qliq3jaoGAjZif4bAA03MJivXiM/R1F9igoo564gjFQsvRy594j5W243azZy9rM
	 uE+FgVgBQL3czJGSzrUOmVIKIw04hX+waan3OkEa6+KVKgu50j0qvPMBaMQlusFAlb
	 JYaMQg0nOu5+yHwIBGBQCljfVJzC3fObQgraOBAA=
Date: Tue, 06 May 2025 07:55:59 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/57df14-313de9@github.com>
Subject: [bluez/bluez] 269f04: mesh: acceptor: fix endianess issues
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
  Commit: 269f04cd264bda0353514ab2b39de33dcbf2a77a
      https://github.com/bluez/bluez/commit/269f04cd264bda0353514ab2b39de33dcbf2a77a
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M mesh/prov-acceptor.c

  Log Message:
  -----------
  mesh: acceptor: fix endianess issues

Members of 'struct mesh_net_prov_caps' are in Over-the-Air order and
must be converted to host order first.

Fixes: 838ddc931263 ("mesh: provisionee: Check prov start parameters")


  Commit: 7ca238921f6b69fbc50b51f73bc023ad4e9c9981
      https://github.com/bluez/bluez/commit/7ca238921f6b69fbc50b51f73bc023ad4e9c9981
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M mesh/agent.c

  Log Message:
  -----------
  mesh: agent: add hash calculation of URI

Mesh profile spec, 3.9.2 Unprovisioned Device beacon:
Along with the Unprovisioned Device beacon, the device may also
advertise a separate non-connectable advertising packet with a Uniform
Resource Identifier (URI) data type ...

The remaining implementation of this feature does already exist.


  Commit: 24d053c09cb797a35574055bfb4846aceabf98ca
      https://github.com/bluez/bluez/commit/24d053c09cb797a35574055bfb4846aceabf98ca
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: remove redundant hexdumps in Mesh Provisioning

Paket data is already dumped in the statement above.

Fixes: ad0cdbc1e943 ("monitor: Add basic decoding for Mesh Provisioning")


  Commit: f9c8327e5ed1b0d608a4d5b2905e5cb7337c0938
      https://github.com/bluez/bluez/commit/f9c8327e5ed1b0d608a4d5b2905e5cb7337c0938
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M tools/mesh/cfgcli.c

  Log Message:
  -----------
  tools/mesh-cfgclient: constify


  Commit: 30d2de12868d69cb67835b530ed4a0a51f2a5dd8
      https://github.com/bluez/bluez/commit/30d2de12868d69cb67835b530ed4a0a51f2a5dd8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M doc/org.bluez.Media.rst

  Log Message:
  -----------
  org.bluez.Media: add SupportedFeatures

Add SupportedFeatures property for feature information that applications
cannot find otherwise.

Add feature tx-timestamping. Applications cannot enable it on old BlueZ
versions without that feature, as it requires special handling on BlueZ
side.


  Commit: 9ea27141c71fef1ae33ac426bc9245cf2aa267eb
      https://github.com/bluez/bluez/commit/9ea27141c71fef1ae33ac426bc9245cf2aa267eb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: implement SupportedFeatures property

Add org.bluez.Media.SupportedFeatures. Add feature tx-timestamping.


  Commit: 313de9af36cbbd02d69ba12b8819e28f6a89bbd5
      https://github.com/bluez/bluez/commit/313de9af36cbbd02d69ba12b8819e28f6a89bbd5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-06 (Tue, 06 May 2025)

  Changed paths:
    M src/main.conf

  Log Message:
  -----------
  main.conf: Fix documentation of TemporaryTimeout=0

Setting TemporaryTimeout to 0 never enables temporary_timer which means
device_disappeared will never be called and the device will remain
temporary forever (until the service is restarted).

Fixes: https://github.com/bluez/bluez/issues/1100


Compare: https://github.com/bluez/bluez/compare/57df14b8f8b1...313de9af36cb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
