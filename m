Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D42C21DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407041; cv=none; b=YyrCS6UXJTFwWf2/XfKE2dmC13SQIv8S7DQx90+GNqoIDCzGm3f6s0gL5KojiHROOFrjK/nOXiAhivGiuuNMD2jOtyoioVw++3QAQKSGJhfTnWOthV8vvq2OUtFGDu3SxPLQmQpQthadFsBLNJ9Qwoa3cl+oSq/TFAJRBg3K7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407041; c=relaxed/simple;
	bh=EwdRruTT8taT+MgR4CKYXYZWzgUDYh2+0TCYGYHB8Kk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AHyms4fgLEk/KYzUTUEc33NfC7N5vvyViGgiUlcmxUSLY6XvbY1hUQlstTTvW6JOq9N4+8inaBSpwOBcz+CBO5KnnRtGFRupXUzFcLScgVXNGitONu2o0hBjN0MJ5oSrstL6MmXdvmdl37/Ejd9x0SN7SXcC89naDBA2mwJQmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hHgJLPhY; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hHgJLPhY"
Received: from github.com (hubbernetes-node-5be8bcd.ac4-iad.github.net [10.52.86.29])
	by smtp.github.com (Postfix) with ESMTPA id E824F204E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 11:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763407038;
	bh=4dFwHP/dR4Oxex15TSziSC+sBMq0SYd6fLIH6KHnh6I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hHgJLPhYRyZWAWwk/jhnq4Q/dIHO/kAmyK+e6CfejxYAMNEvACGQP5sC6GiwUD4k3
	 IjofXonSN02jVhBM+Er6sFs6FS3Uxpx8ru6kKhUjnJ1sA+WGjt3d/LJKZaA6C9UfuS
	 7jIQJiYaeDa2E4+7eJ6HopX2B24XzTPETRLjtoVI=
Date: Mon, 17 Nov 2025 11:17:18 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c1493c-8a41ac@github.com>
Subject: [bluez/bluez] f1afca: shared/bap: fix channel allocation logic in
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f1afca6a097bdc5a2a21508146875bab322dbe48
      https://github.com/bluez/bluez/commit/f1afca6a097bdc5a2a21508146875bab322dbe48
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

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


  Commit: 0c56d482fd20c86d4a33cc91e117fc2af96ef570
      https://github.com/bluez/bluez/commit/0c56d482fd20c86d4a33cc91e117fc2af96ef570
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix packet length comparison to ATT MTU in bap_queue_req()

bap_queue_req() forgot to account for ATT command headers when comparing
to MTU, and fail to send if packet too big. Fix the MTU comparison.


  Commit: 231372ca5e1545eb505dd22be1ff28d89b68fd22
      https://github.com/bluez/bluez/commit/231372ca5e1545eb505dd22be1ff28d89b68fd22
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

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


  Commit: a1f8862a38a5f8d29565cd8c84f9880a740ae95e
      https://github.com/bluez/bluez/commit/a1f8862a38a5f8d29565cd8c84f9880a740ae95e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: better debug output on io memcmp failure


  Commit: 7858675e62818bae52300c24440e5fa4af68394c
      https://github.com/bluez/bluez/commit/7858675e62818bae52300c24440e5fa4af68394c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: make PDU macros parametrizable

Adjust PDU-forming macros, so that they can be used for connecting
multiple streams to parametrizable locations.


  Commit: 8a41ac3fde997137d374791a93a49d9a3abac0e0
      https://github.com/bluez/bluez/commit/8a41ac3fde997137d374791a93a49d9a3abac0e0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-17 (Mon, 17 Nov 2025)

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


Compare: https://github.com/bluez/bluez/compare/c1493c32d7da...8a41ac3fde99

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
