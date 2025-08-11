Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640422222DD
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922210; cv=none; b=nLmecRmfhR+0f1GvGpWkcQND5zXTvZfwT/UPBvJqKqaH7QEZ5eAUU+OTAR7m+hzwMNwDNecCjr9kRrosK4Zy144fg/LH1xbdgJXQOlChNIDhjkjdCwVXR4uu2NATlOWfLc0/sb49csLs0j5eCtpIJQj5d7Dd1ZOIFfX7cHZLcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922210; c=relaxed/simple;
	bh=JBJ+I9BZExgTDph6La1Ri8Q+hEDu+Eu2tQCfbqB90Jk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HE9KM5KTPY1AIl2fa+dFKXTRDYRVIPW0eyxkoZka3GMV2leVDAdWVBYIvdV7Cfv0nbQguCHeeIpX+6dQ0xfIs7o0H35tQ6AVFzMmRQNUgXbJS9c1uAQDQMMGpFU3RhDju0ukItoI7gXMGPbi+TkSsjt+Y50dTOLcWMriYsI/MWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YXTv8Rp7; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YXTv8Rp7"
Received: from github.com (hubbernetes-node-f12aa05.ac4-iad.github.net [10.52.176.31])
	by smtp.github.com (Postfix) with ESMTPA id 7DBBC203F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754922208;
	bh=atvS8Z3R9FmoX/lavvaFhs4319fyfG2onrg2U0dNpQo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YXTv8Rp73aDCfJP+tZCxuzNazfP94sY68nN4ilN/o1irdJfvZWYG3LKlrt36/FjZH
	 d3WBp81BsfHadVXDk+U8LjUK8mqzWAUeBL6K3Ny/bSKvoBfQFtDEPlO/ZL6YrG8RMC
	 j8HS4aLUYDXWIkNm3IC3K72u7iNp7AdQ9CTCan/8=
Date: Mon, 11 Aug 2025 07:23:28 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0cac14-5ccbff@github.com>
Subject: [bluez/bluez] 5ab820: bap: fix multiple release of stream when
 closing s...
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
  Commit: 5ab82029d22592f47af04a59b5b84f96e86d1af5
      https://github.com/bluez/bluez/commit/5ab82029d22592f47af04a59b5b84f96e86d1af5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: fix multiple release of stream when closing setup

If setup->closing, then the stream was already released and should not
be released again.  Also, if stream is RELEASING on setup_close(),
freeing the setup should be delayed until the stream exits that state.

Fixes issue where setup is closed, stream goes RELEASING->CONFIG, the
setup is freed and a duplicate release op is queued. Before that
completes, the stream is reused for a new setup.  In this case, the new
setup is incorrectly destroyed when the release op completes although it
was intended to destroy the old setup.


  Commit: a98314919a85da6f02b0d9e5b6e69e6c40c082ac
      https://github.com/bluez/bluez/commit/a98314919a85da6f02b0d9e5b6e69e6c40c082ac
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: send correct framing value to kernel

Get framing value to use from the QoS of the appropriate stream, instead
of hardcoding unframed.


  Commit: bb0122151d2f6b5c57f3e573e654f4685288ff49
      https://github.com/bluez/bluez/commit/bb0122151d2f6b5c57f3e573e654f4685288ff49
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: use correct parser for Config Codec message

ASCS Config Codec gets Codec_Specific_Configuration, not
Codec_Specific_Capabilities so use the correct parser.

Fixes spurious 'invalid size' printed in debug logs.


  Commit: caa495332e4b0b2c209e2b28ab43640369f01601
      https://github.com/bluez/bluez/commit/caa495332e4b0b2c209e2b28ab43640369f01601
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: fix pac_select(), pac_config() return values

These return 0 on success, < 0 on error, not TRUE/FALSE.


  Commit: 84c336f2bd7aec174b516615c1bb521c57b1c5e0
      https://github.com/bluez/bluez/commit/84c336f2bd7aec174b516615c1bb521c57b1c5e0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: clear transport if reconfiguring in pac_config()

We are not updating transport->configuration if transport already exists
in pac_config(), so reconfiguration of a stream leaves sound server with
old configuration.

Do this in the same way we do for A2DP: first ClearConfiguration() to
remove old transport, then SetConfiguration() to make new one with the
new settings.


  Commit: aba67693b934a0e67e7ab11538d43d1c3c838a3b
      https://github.com/bluez/bluez/commit/aba67693b934a0e67e7ab11538d43d1c3c838a3b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: clear server streams when ucast disconnects

Streams are freed by bap_detach() without state change callback. Clear
data->server_streams explicitly before bap_detach().

Fixes UAF due to stale stream pointers in server_streams.


  Commit: 5ccbff0898fa4b006cb4b26c9b82cae129aa368f
      https://github.com/bluez/bluez/commit/5ccbff0898fa4b006cb4b26c9b82cae129aa368f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: check ASE state in find_ep_ucast

ASE may be in non-configurable state also if it has no associated
stream, eg. as a result of failed stream teardown or other misbehavior.
Check also ASE state when selecting a "free" one.

Fixes wrongly picking ASE that is not IDLE/CONFIG/QOS and cannot be
configured.


Compare: https://github.com/bluez/bluez/compare/0cac149a4bdf...5ccbff0898fa

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
