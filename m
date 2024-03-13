Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DC4D108
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363928; cv=none; b=UD6H34WPBoTdDMYtVGdNmlsQ0YEB15hOC3U/nu3+n7IfpS5aVNlFvl7m2m0vi+GuXAajpGwQPGlVInzd6Im333YsWWtM8Rz3tjsW8bnJn3Qmfu7stEqHw7J1BL9ln192AWhN5QKGBfBj+ZfKyBO3+M8RQ4MEm1z8UxZlMKrxDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363928; c=relaxed/simple;
	bh=vox78MA4+TZUITnfjOxR4Ve7Rj6U+eqL1p/4nY/HL70=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MxXxljanjghvjE+FOzG5TgUG6jdJAzBcjgqMRXdb8e1r8bAKJKspi3IZdU/spb3tYHF17E3PF1g1CEq0aPeO0RG9RW4TLQ/x5fqSvW//8CzgEF6LkFJ6nOF+YamAV0e3VLSMwmAwhqqTxZozbqIncWoeobw2DyKNGvgTluM2yks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DlxZ8B8D; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DlxZ8B8D"
Received: from github.com (hubbernetes-node-c47b15d.va3-iad.github.net [10.48.142.38])
	by smtp.github.com (Postfix) with ESMTPA id 740768C02F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 14:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1710363925;
	bh=sC4J1Qu9DdeXHJMMlB0hiwCfSj3ZS7usA7x/ZNX4pvM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DlxZ8B8DrsWSwgyFyvdJT0TB78NlLVHNelPFwTh37KGxUClKCOZtXtczwPR4aZ8BD
	 ikQcCOWxoJsQs9b6EFrNIUdkQHQXY3TazkoUoGJM1qTDSFuITLipEHFP1ja/BftqQU
	 vT2njhDMWx8lyh4bHTQFjLHwK/yTBzAOJ9GcCHmY=
Date: Wed, 13 Mar 2024 14:05:25 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f5fecf-3ad367@github.com>
Subject: [bluez/bluez] e35f45: client/player: Split unicast and broadcast
 presets
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
  Commit: e35f4583421c17fe7108dbbd82e6b07e4e96f3c4
      https://github.com/bluez/bluez/commit/e35f4583421c17fe7108dbbd82e6b07e4e96f3c4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-13 (Wed, 13 Mar 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Split unicast and broadcast presets

Although their name matches unicast and broadcast are not actually the
same when it comes to RTN and Max Latency, so this splits their settings
into 2 presets tables and fix the values for broadcast.


  Commit: cae922c63bd5c63a8ce077b3c2c694b2fe988245
      https://github.com/bluez/bluez/commit/cae922c63bd5c63a8ce077b3c2c694b2fe988245
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-13 (Wed, 13 Mar 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Use macros from lc3.h to define presets

This makes use of macros for for lc3.h to define preset configuration
and remove existing macros since they were just duplicates.


  Commit: 47df60e8b21ef795e0f1438b1dc44ac309f72781
      https://github.com/bluez/bluez/commit/47df60e8b21ef795e0f1438b1dc44ac309f72781
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-13 (Wed, 13 Mar 2024)

  Changed paths:
    A src/shared/bap-defs.h
    M src/shared/bap.h
    M src/shared/lc3.h

  Log Message:
  -----------
  shared/lc3: Add definition for broadcast configurations

This adds defines for broadcast settings as they don't really match
unicast when it comes to RTN and Latency.


  Commit: 25f42cfc4653ff0125a1f079207b74193aa617ea
      https://github.com/bluez/bluez/commit/25f42cfc4653ff0125a1f079207b74193aa617ea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-13 (Wed, 13 Mar 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Use QOS macros from lc3.h to define presets

This makes use of QOS macros for for lc3.h to define preset
configuration and remove existing macros since they were just
duplicates.


  Commit: fffa21d084ecc3dfe789a965039980f2cf582a44
      https://github.com/bluez/bluez/commit/fffa21d084ecc3dfe789a965039980f2cf582a44
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-13 (Wed, 13 Mar 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Add proper default for broadcast setup

This adds proper default for broadcast setup so it doesn't fail to
create the socket due to users not setting them.


  Commit: 3ad367874630bb62719ea02184a473cb1efeca34
      https://github.com/bluez/bluez/commit/3ad367874630bb62719ea02184a473cb1efeca34
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-13 (Wed, 13 Mar 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Cleanup broadcast QoS

There is no need to setup broadcast QoS related to PA/BIG as bluetootd
already sets default settings.


Compare: https://github.com/bluez/bluez/compare/f5fecf037b1e...3ad367874630

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
