Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491B1361
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679534; cv=none; b=CUg4jU0BSTw/RPqo0XiPHbQ7JnB4ZSuJ5gNs1eYjsFav/aBYhnFA59SQHPu6GyJiZRXax1AV/SyTcpv4hR4PktxsQ9J2gZ8HZ3jwEGvkcTeK49FTgLGRbDQ6KFYBP0ziFiIrqT12HczrmWzdtWPaP9Omc/l29HsY2Ng0CY7haoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679534; c=relaxed/simple;
	bh=8RAR0EqDAeSMUODldGAGkgbgDts+tJxoH3nCa1lii8U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SSiEWidXuss0tI5LFFXC6DXNPtl4hnRhCSPYY3ZWi2xUH3Jown6/x/GVnADFmwplazMnsMqUzHOp3Unmx5lXseIdPi7N4zeDjFeQMoRFhoZt/VETJdEjHW7SSxDc+pO3mu4sMhxCvVbCr9uJ60k16H2uwylNNKrTUy05gZV5K4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jyHu+6pX; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jyHu+6pX"
Received: from github.com (hubbernetes-node-31aca59.ac4-iad.github.net [10.52.137.37])
	by smtp.github.com (Postfix) with ESMTPA id BAEBF6403FB
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754679531;
	bh=kc/7nCf7W3y3L/6t7gg4vAZaeC4CbE8JwycusY4gQSk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jyHu+6pX+YILuV+4ywdpMo5qtTXusrh/BZud8gWhnwsMrp4Pqf+Wgy7MY2QVu0Yuu
	 RNrLiC0WFX02XiHQrRr4SOlcRgkl0I035zXU7hUuNmNsqffnUVXPe2VZVkE5g2C+5x
	 QiBkBtkrynB3y/auWady75+r2V/SI90wieKee96Y=
Date: Fri, 08 Aug 2025 11:58:51 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989501/000000-289167@github.com>
Subject: [bluez/bluez] b41876: bap: fix multiple release of stream when
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

  Branch: refs/heads/989501
  Home:   https://github.com/bluez/bluez
  Commit: b418763e634fe5f6166b327637d50d38e7b4e67a
      https://github.com/bluez/bluez/commit/b418763e634fe5f6166b327637d50d38e7b4e67a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

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


  Commit: d942791930626a3dd95ecb0ed848601f6b6cccd6
      https://github.com/bluez/bluez/commit/d942791930626a3dd95ecb0ed848601f6b6cccd6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: send correct framing value to kernel

Get framing value to use from the QoS of the appropriate stream, instead
of hardcoding unframed.


  Commit: 430cfe6ad388837d0c0b537a9fcfc9cb999d620e
      https://github.com/bluez/bluez/commit/430cfe6ad388837d0c0b537a9fcfc9cb999d620e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: use correct parser for Config Codec message

ASCS Config Codec gets Codec_Specific_Configuration, not
Codec_Specific_Capabilities so use the correct parser.

Fixes spurious 'invalid size' printed in debug logs.


  Commit: f3343b3bc89bc1b2e6e4d974b93cffce715991b8
      https://github.com/bluez/bluez/commit/f3343b3bc89bc1b2e6e4d974b93cffce715991b8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: fix pac_select(), pac_config() return values

These return 0 on success, < 0 on error, not TRUE/FALSE.


  Commit: 2e4396f5a15d1ebcc79b193cc14e5f1a3b171189
      https://github.com/bluez/bluez/commit/2e4396f5a15d1ebcc79b193cc14e5f1a3b171189
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

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


  Commit: b7348c0e9892c1c4ca3da3af3c5638851b2f4acf
      https://github.com/bluez/bluez/commit/b7348c0e9892c1c4ca3da3af3c5638851b2f4acf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: clear server streams when ucast disconnects

Streams are freed by bap_detach() without state change callback. Clear
data->server_streams explicitly before bap_detach().

Fixes UAF due to stale stream pointers in server_streams.


  Commit: 28916735e8321167746a661c2129ad2a2f936c5d
      https://github.com/bluez/bluez/commit/28916735e8321167746a661c2129ad2a2f936c5d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

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


Compare: https://github.com/bluez/bluez/compare/b418763e634f%5E...28916735e832

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
