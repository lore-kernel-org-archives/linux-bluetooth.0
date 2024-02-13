Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02191DFE3
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834978; cv=none; b=jZ7JawtjBzNiIeAtl9iWVwymWCVoIdWJPxFW4OCRUwh7wzS9BGTtsACyPTIl37KKqEjRq+uraNRSD+3gepIazeoVxOPwvVxJISc9R5Nezl+MpvHSdqO07jtWchobAxcXArhH6lzJ3tP3b3iXvzMDyhUC2++kMDUQzVj1d2bWfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834978; c=relaxed/simple;
	bh=YPzZpIWDZjaGVW1s1Xmjw/tHzV6k7RDykInT+egjDS8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=o3VU5SPtahh9Z6XXTNM2l9kLNjlwbMBSzbgekpnF/PzT8lFA/5EwXnfKaD6PVKn8lyKA5AhXqPFyZ/dRJTxdbnT++WSz08WmCV1q8jyvMVxCFMxWvAF+A8wpNuhT0tP/uIPWNLhjRCFBiGqCUkLf5CBe6NtpbgIYvngnqq0B2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gwNABkb2; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gwNABkb2"
Received: from github.com (hubbernetes-node-dd27b07.va3-iad.github.net [10.48.156.34])
	by smtp.github.com (Postfix) with ESMTPA id A2DA5E134F
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 06:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1707834975;
	bh=gJEEpiRH3Igq0rJz1iLuERF+O5dfG6T9BgJAkx/hjcU=;
	h=Date:From:To:Subject:From;
	b=gwNABkb2Bjo+LSV4QF8LBnVyQdZuxgqCv/s8PO1gk8aimzM0fnOdFa7zxwh6jpbTF
	 tRSlEC0USm3Qcezc/PX/YU3p58JgTEGW8KNLOaFpg+Uh0SPsudy25MLTgXutOCtZ5X
	 Se0UB0r5PXu6/yziOJZagMqIyCzkpU/G7xQ72TQo=
Date: Tue, 13 Feb 2024 06:36:15 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/41c7f3-b16b19@github.com>
Subject: [bluez/bluez] f2671b: Return at least the title attribute from
 player_li...
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
  Commit: f2671bf8f951c84fbdd0c463c64c9aa3299a7e9a
      https://github.com/bluez/bluez/commit/f2671bf8f951c84fbdd0c463c64c9aa3299a7e9a
  Author: Sam Lantinga <slouken@libsdl.org>
  Date:   2024-02-12 (Mon, 12 Feb 2024)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  Return at least the title attribute from player_list_metadata()

This fixes Bluetooth AVRCP certification test AVRCP/TG/MDI/BV-04-C,
which requires a valid response from the get_element_attributes command.


  Commit: d3aeae79de4b2f54602498e39a4c7894b0780b9d
      https://github.com/bluez/bluez/commit/d3aeae79de4b2f54602498e39a4c7894b0780b9d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-02-12 (Mon, 12 Feb 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Remove experimental flag for PowerState

Now that the feature has been tested, that the API is deemed adequate
and the reliability sufficient.

[Emil Velikov]
The feature has landed in Sept 2022, with inclinations that "we might
switch it to stable in the next release", back in Nov 2022.

Today - a bit over 1 year later -  various distributions (Fedora, Gentoo
and by extension their derivatives) are carrying this patch. I think we
can say we're reasonably stable and can merge it upstream.


  Commit: d31f04aa928ae8fb7a4fc5b0876dd17ea65d4513
      https://github.com/bluez/bluez/commit/d31f04aa928ae8fb7a4fc5b0876dd17ea65d4513
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-02-12 (Mon, 12 Feb 2024)

  Changed paths:
    M test/agent.py
    M test/example-adv-monitor
    M test/example-advertisement
    M test/example-endpoint
    M test/example-player
    M test/exchange-business-cards
    M test/ftp-client
    M test/get-managed-objects
    M test/get-obex-capabilities
    M test/list-devices
    M test/list-folders
    M test/map-client
    M test/monitor-bluetooth
    M test/opp-client
    M test/pbap-client
    M test/simple-agent
    M test/simple-endpoint
    M test/simple-obex-agent
    M test/simple-player
    M test/test-adapter
    M test/test-device
    M test/test-discovery
    M test/test-gatt-profile
    M test/test-health
    M test/test-health-sink
    M test/test-hfp
    M test/test-manager
    M test/test-nap
    M test/test-network
    M test/test-profile
    M test/test-sap-server

  Log Message:
  -----------
  test: consistently use /usr/bin/env python3 shebang

Currently we have a mix of /usr/bin/python, /usr/bin/python3 and
/usr/bin/env python3. Use the latter since is the more common way of
handling this, plus it allows people to override the system python (for
what ever reason).

Inspired by a Debian patch, doing a mass /usr/bin/python{,3} conversion.

Cc: Nobuhiro Iwamatsu <iwamatsu@debian.org>


  Commit: 1313351f7144e0cec5fe7a25cbe50fc5bd796b5f
      https://github.com/bluez/bluez/commit/1313351f7144e0cec5fe7a25cbe50fc5bd796b5f
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-02-12 (Mon, 12 Feb 2024)

  Changed paths:
    M Makefile.plugins
    R profiles/input/suspend-dummy.c

  Log Message:
  -----------
  profiles: remove unused suspend-dummy.c

The file has been used for about 8 years now - see commit
fb55b7a6ab48c4f782b16030e051029bcfa93e07 ("profiles/hog: Use no suspend
support instead of the dummy FIFO").

Inspired by a Debian patch by Nobuhiro Iwamatsu, which was changing the
/tmp/hogsuspend socket patch to /run. Looking through the codebase we
have a few more sockets that could use a to /run fix, but that will
follow-up at another day.

Cc: Nobuhiro Iwamatsu <iwamatsu@debian.org>


  Commit: be0e796299b0e7a73bf06c5655b56180588550b0
      https://github.com/bluez/bluez/commit/be0e796299b0e7a73bf06c5655b56180588550b0
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-02-13 (Tue, 13 Feb 2024)

  Changed paths:
    M Makefile.am
    M Makefile.mesh

  Log Message:
  -----------
  build: ship all config files with --enable-datafiles

Currently we ship only the dbus/systemd policy files and omit the other
four - /etc/bluetooth/{main,mesh-main,input,network}.conf.

Outside of those files, there is no documentation what the defaults are
and the other possible options. A number of distributions (Arch, Gentoo,
Fedora) have opted to manually copy those into the package. Alas this
does not scale and leaves other distros at disadvantage, in a sense.

Note: we need a custom install target to ensure confdir and statedir
have the correct permissions.


  Commit: b16b19885c5383cd0499503617b98ceb188c898e
      https://github.com/bluez/bluez/commit/b16b19885c5383cd0499503617b98ceb188c898e
  Author: Giovanni Campagna <gcampagna-cNUdlRotFMnNLxjTenLetw@public.gmane.org>
  Date:   2024-02-13 (Tue, 13 Feb 2024)

  Changed paths:
    M Makefile.obexd
    M configure.ac
    R obexd/src/org.bluez.obex.service
    A obexd/src/org.bluez.obex.service.in

  Log Message:
  -----------
  Allow using obexd without systemd in the user session

Not all sessions run systemd --user and in some cases one may be missing
systemd all together.

Provide the correct path instead of /bin/false, allowing dbus to start
the service in such cases.

DBUS implementations can ignore the Exec line all together when run in
systemd aware mode - at least the OG dbus does that. So ultimately this
change is a no-op for the systemd --user case.

On my system, this is literally the only non-system service which uses
/bin/false.


Compare: https://github.com/bluez/bluez/compare/41c7f3af0352...b16b19885c53
