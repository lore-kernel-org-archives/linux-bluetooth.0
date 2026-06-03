Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD44368D73
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515719; cv=none; b=bPZST1pkCgf6StSBVYKGqKYyglg8zqWS3yK0DPfL9vIu2v0eOrSWqmjWZg2dajNFwsdU/Ef86YQXy5BpfCmyeV1SlvEHD6a/8PL1WyjWa6h06InyunpmyLjd3DYhQoVt06h6d/I7VCVE+noNGxbmZIDmxKegXosyfg1nDpqyemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515719; c=relaxed/simple;
	bh=iYpoASBkZqV43N71UjX+PmvMSaTc/krkdULKOWVGwKk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gpQ+qPnkTsobvBaCZa1m7JwSQgHJePOOtSKqTobTgM0QwHa9E6OlUweOiXKtxtUIthQZwYA1NUgyRV9Ier42CUKX8W/7lni4P20bl56amD77Bb4/VNpIZ5jLv+qe/Xnc5+6q1qSB5RC1BC3tFRhonji4flH778F0PZporPZ49bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IWerYQRz; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IWerYQRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780515718;
	bh=+vtiKl1gX6LBCsV2b6F5dbziHcxdvAdYG83aW0xnO3U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IWerYQRzJHJXlNb8YG/7RuqMPLSt7Eo5KhGw0yUq6FZtU9X+MQ0ZBXh8CyX+jruej
	 wlyNFyMoamB5PYj23yNPvcOqkTvHZQ8cnA9gWzbQH2J67FRYLcLtk+Xhpt6hk25jYI
	 kDxpgrAoYevOrunU2noZ0kJMDloqv9DSHih91xSM=
Received: from github.com (hubbernetes-node-33e419d.ac4-iad.github.net [10.52.138.41])
	by smtp.github.com (Postfix) with ESMTPA id EB03640225
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 12:41:57 -0700 (PDT)
Date: Wed, 03 Jun 2026 12:41:57 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105509/000000-14aeb5@github.com>
Subject: [bluez/bluez] 67058b: client/mgmt: Add options to ltks command for
 loadi...
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

  Branch: refs/heads/1105509
  Home:   https://github.com/bluez/bluez
  Commit: 67058b3f707cbd1acc867b598f471c744bd95f85
      https://github.com/bluez/bluez/commit/67058b3f707cbd1acc867b598f471c744bd95f85
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-03 (Wed, 03 Jun 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Add options to ltks command for loading entries

Add support for optionally specifying a single LTK entry when using
the ltks command. When called without arguments it clears all LTKs
(existing behavior). When called with an address and key parameters
it loads exactly one LTK entry, useful for testing.

Options:
  -a addr_type  Address type (1=LE Public, 2=LE Random)
  -t key_type   Key type (0=Unauthenticated, 1=Authenticated)
  -c central    Central flag (0 or 1)
  -e enc_size   Encryption key size (7-16)
  -d ediv       Encrypted Diversifier
  -r rand       Random number (64-bit)
  -k key        128-bit key as 32 hex characters


  Commit: 14aeb5480c3b59ad83320d712a0290949d524baa
      https://github.com/bluez/bluez/commit/14aeb5480c3b59ad83320d712a0290949d524baa
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-03 (Wed, 03 Jun 2026)

  Changed paths:
    M doc/bluetoothctl-mgmt.rst

  Log Message:
  -----------
  doc/bluetoothctl-mgmt: Update ltks command documentation

Document the new options for the ltks command including address type,
key type, central flag, encryption size, EDIV, random number and key
value parameters.


Compare: https://github.com/bluez/bluez/compare/67058b3f707c%5E...14aeb5480c3b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
