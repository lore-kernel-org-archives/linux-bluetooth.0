Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17236CDFF
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053357; cv=none; b=dPD2zCm3G0VPSwdBXb6tNo0fUiK3I2AEWVFoCvzt1K3EYHvfcZQ9N3sCrIk/U4W532kZjl/4eFFzGzMfs+QInaPhH09iYIl2GbUyfyo6DXr3D6hqRjaSIoEb/lhhDLEJ7NZGTROK0XgWQn7Kn0JnRYtw/EjCMGLb6lcAPsxSVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053357; c=relaxed/simple;
	bh=iRDHBrRFxRh7l5wjgVZCautAUmmNy6wD6jP6Z3UHcE0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f+NxrybrVvtx4P06njPdf7NWZsAw0wp7blYPh2+7kP9WsefL6+xowjFKSIKfDt56vT8eQm93VS6KXl3gkoq6yaHjzGZomhQ+YILZvAWrAdweP22K+hAoURrXzDzx6Io43KjYCDOEwzP1/CcyK2k3pkbg5pFK1scOeewHgNxXV6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=irtbs/zZ; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="irtbs/zZ"
Received: from github.com (hubbernetes-node-7a2f9e4.va3-iad.github.net [10.48.180.50])
	by smtp.github.com (Postfix) with ESMTPA id 04CB93C13EE
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763053355;
	bh=1U8vRdFfOvlNE/+gOBXT12ZpZ+Ohj1k758GsO4XIrbw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=irtbs/zZTSxFIqJIgusoeUV5XaT5V7F56ffODSebqjCYVaBjNrwj8lc/HkAcf8JtF
	 Xng/v0kKRSb7pkGc9wBanOrlUyfwEap48wx6XTkT2K6tMLLS/KBw7/ARPZ5e9G/PyZ
	 gDXv9QSwkfZvETpi/7rJ5kLJyW+N8cACdKM07Crc=
Date: Thu, 13 Nov 2025 09:02:35 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023092/000000-6a39a6@github.com>
Subject: [bluez/bluez] 4b22bc: shared/bap: fix channel allocation logic in
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

  Branch: refs/heads/1023092
  Home:   https://github.com/bluez/bluez
  Commit: 4b22bc73f2f03403200b2aa6ffc80d6be05c9bef
      https://github.com/bluez/bluez/commit/4b22bc73f2f03403200b2aa6ffc80d6be05c9bef
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

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


  Commit: f6fe2a9ae4062fbdc57279d3bb43f7e1ded377c1
      https://github.com/bluez/bluez/commit/f6fe2a9ae4062fbdc57279d3bb43f7e1ded377c1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: adjust macros for customizing remote audio locations

Add arguments to customize audio locations, in the macros defining data
for remote PACS.


  Commit: 5d5c5e243c0b383c837c396632614f7fb0df9d96
      https://github.com/bluez/bluez/commit/5d5c5e243c0b383c837c396632614f7fb0df9d96
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: add tests for bt_bap_select()

Add basic tests for bt_bap_select(), for configurations in BAP.TS. 4.10.

UCL Select LC3 AC 1 (0a)
UCL Select LC3 AC 1 (0b)
UCL Select LC3 AC 1 (0c)
UCL Select LC3 AC 1 (0d)
UCL Select LC3 AC 1 (1)
UCL Select LC3 AC 1 (1a)
UCL Select LC3 AC 1 (1b)
UCL Select LC3 AC 1 (1c)
UCL Select LC3 AC 4 (2)
UCL Select LC3 AC 4 (2a)
UCL Select LC3 AC 4 (2b)
UCL Select LC3 AC 4 (2c)
UCL Select LC3 AC 2 (0a)
UCL Select LC3 AC 2 (0b)
UCL Select LC3 AC 2 (0c)
UCL Select LC3 AC 2 (0d)
UCL Select LC3 AC 2 (1)
UCL Select LC3 AC 2 (1a)
UCL Select LC3 AC 2 (1b)
UCL Select LC3 AC 2 (1c)
UCL Select LC3 AC 10 (2)
UCL Select LC3 AC 10 (2a)
UCL Select LC3 AC 10 (2b)
UCL Select LC3 AC 10 (2c)
UCL Select LC3 AC 3
UCL Select LC3 AC 5
UCL Select LC3 AC 7i
UCL Select VS AC 7i
UCL Select LC3 AC 6i
UCL Select LC3 AC 6ii L
UCL Select LC3 AC 6ii R
UCL Select LC3 AC 9i
UCL Select LC3 AC 9ii L
UCL Select LC3 AC 9ii R
UCL Select LC3 AC 8i
UCL Select LC3 AC 8ii L
UCL Select LC3 AC 8ii R
UCL Select LC3 AC 11i
UCL Select LC3 AC 11ii L
UCL Select LC3 AC 11ii R
UCL Select LC3 Many 2
UCL Select LC3 Many 8


  Commit: 6a39a6a17e3798f629538cf247f2b2e2a39f1070
      https://github.com/bluez/bluez/commit/6a39a6a17e3798f629538cf247f2b2e2a39f1070
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

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


Compare: https://github.com/bluez/bluez/compare/4b22bc73f2f0%5E...6a39a6a17e37

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
