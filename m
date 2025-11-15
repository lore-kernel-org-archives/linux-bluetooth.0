Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0F23D288
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209268; cv=none; b=B0YO18eY70QfOU4mE4c/D/Lyohpgaa2y5+1pIew1tKH+W1j68lIV/lglzxw4Oe/oUmMtbaK+6V8IrcukSzVjcezSb2H3XIEPVb0E8w6wNUFXIiqtTu6arN9Lxasiom0+5JQ9Jf1ZbDazUTrmpz4FyinBHtV0Y6njgLI9ZsOXiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209268; c=relaxed/simple;
	bh=vrBAwkejio9screjv8OjVZyv6Vp+8GwnbtXq4YqGpFM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VG766Z+RwMxhJ3bf0SbQIH9NATP8jhtM02pqkwNejjMbaJDx2ZOj1LwxAooRVnaHpIv9TZ+jIYie//Hx4JUjZ6bU7ixHV277pl/tkq5Wf8AT3UVvSMUouXCDUByPPQjTBBC9jVpRzRwhY6k+70YUbg0+34o8xydiVRXHZoQMj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LuIH72Q0; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LuIH72Q0"
Received: from github.com (hubbernetes-node-7519e9d.va3-iad.github.net [10.48.206.38])
	by smtp.github.com (Postfix) with ESMTPA id B5D8E4E03D0
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 04:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763209265;
	bh=5Iqb/j0A2WsK11P9lNX9biAd+Nc8w7CeKt4n8Rd9kPs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LuIH72Q0lZGwe/jE0BeZG8UMxRbtQGVGdfS0gXArcWC6SyPUcNf/WeNkWq/Dh7Aut
	 9txe3qjpDBq1lintSeXsIw7Xjxal++dsA4VjxpGMG2ukOLF+4XSa8GSs+/kYfOeuQo
	 QIu1FSU5eArWQftuC7bnUrXsRQvaA0FQC00oc+QQ=
Date: Sat, 15 Nov 2025 04:21:05 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023829/000000-3c55fe@github.com>
Subject: [bluez/bluez] 0e844b: shared/bap: fix channel allocation logic in
 bt_bap...
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

  Branch: refs/heads/1023829
  Home:   https://github.com/bluez/bluez
  Commit: 0e844bb28006d85f813481cc82e6b700d6435da9
      https://github.com/bluez/bluez/commit/0e844bb28006d85f813481cc82e6b700d6435da9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: fix channel allocation logic in bt_bap_select()

bt_bap_select() does not correctly determine the need for multi-stream
configurations 6,7,8,9,11(i), as its result depends on whether Audio
Locations is read before or after the PACs, doesn't work with general
location bits, etc.

Fix the procedure to be simpler: create streams for all locations, up to
a specific number of channels.  By default, limit to max 2 channels per
direction for compatibility (BAP doesn't have explicit AC with larger
channel counts.) Also simplify the code.

Ignore lpac Locations when selecting: the value mostly makes sense for
Unicast Server role, but Client and Server cannot use the same value as
only a few bits can be set. As Client, we should be able to configure
any Location bits.  The sound server can simply ignore our suggested
channel allocation if really needed, or use SetConfiguration() API to
build custom configurations.


  Commit: d13e20bae2e74cd199faa5d728f3922d6bab8a46
      https://github.com/bluez/bluez/commit/d13e20bae2e74cd199faa5d728f3922d6bab8a46
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix packet length comparison to ATT MTU in bap_queue_req()

bap_queue_req() forgot to account for ATT command headers when comparing
to MTU, and fail to send if packet too big. Fix the MTU comparison.


  Commit: d6626d3e3f8011d0070ee40ffb73efd3485c7208
      https://github.com/bluez/bluez/commit/d6626d3e3f8011d0070ee40ffb73efd3485c7208
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: don't configure endpoints of all codecs at once

When device is connected we currently try create all streams for all
endpoints. If there are multiple (= vendor codecs), this likely causes
creating multiple streams for same location, which is not allowed.

Change it to create streams only for the first endpoint, for each
direction.

Sound server can later request switching to another endpoint if
necessary.


  Commit: 4b20921da2c2eb8ac75f31d2825c06a2df1b38eb
      https://github.com/bluez/bluez/commit/4b20921da2c2eb8ac75f31d2825c06a2df1b38eb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: better debug output on io memcmp failure


  Commit: 71e68d3f0ee707f5c0833e2ee2d711c7431ab018
      https://github.com/bluez/bluez/commit/71e68d3f0ee707f5c0833e2ee2d711c7431ab018
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: make PDU macros parametrizable

Adjust PDU-forming macros, so that they can be used for connecting
multiple streams to parametrizable locations.


  Commit: 3c55fe3b6cb6e98a4823b3149c8e775da82d90ee
      https://github.com/bluez/bluez/commit/3c55fe3b6cb6e98a4823b3149c8e775da82d90ee
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: add audio configuration selection and streaming tests

Add tests from BAP.TS 4.10.

The tests testing (ii) configurations only test configuration selection
with L/R separately. Can be filled in later to use two simultaneous BAP.

The difference between CIS Establishment at QoS vs. Enable is not
properly simulated, so only one variant is added.


Compare: https://github.com/bluez/bluez/compare/0e844bb28006%5E...3c55fe3b6cb6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
