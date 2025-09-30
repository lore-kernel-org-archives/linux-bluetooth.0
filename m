Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF34D8CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243941; cv=none; b=SwSMvpI/2yqfHSYt+qMDYTEpn9n7X56i/etVLC+WEs/iMApDlcqkK7XwTITYrn1UE4aKfxu5qTc6Qv5spxs2ImPpQb+buOw5kw5MJB+91603AXDW+sJR3RfWQb+snrvMXsfNOAxBqN0GxJ1V8jQQ2U7EvxOplU7/lx5SNy9uNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243941; c=relaxed/simple;
	bh=vy9zeFNQC5he3plAEpU9LMfQDLm4h1HR2MVjS5objDI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U0lTl8Cclj0r/Ht1d4XXaVmlC/LMKA5CWZGtUc5YQ3OKj1dPzB+BNYw8Gif71cTngUqTWKp0L+ybGPNEptETskpYFKnGZbQxp4xgRd3v5oThzJXwGoEhpHrYOkYV+hXrV2olacrLthzar7WwM8Lx5MMvox1OTSFHe34/jp9o9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=C2SJXwBD; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="C2SJXwBD"
Received: from github.com (hubbernetes-node-e2b9cc1.va3-iad.github.net [10.48.160.16])
	by smtp.github.com (Postfix) with ESMTPA id 51681E1208
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759243938;
	bh=knXof1qopiBf9NKGvMhbwIjwjJUIrDY3bXBJUG7/wLI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=C2SJXwBDWLEVI51+iMcPggjPBPa4H1Ah1ze063j/O1gDKZpeT1epf8OfmWZi6Ig7H
	 V7paL+NAt6m9k1kSysemn3ibf/VbrrkloBYK2sxzBABbAmkwp6ijE2hcMLhHE9fzZD
	 gi0JMT+3SR4s7DK3qXcE2CjH1W3tHI+D0QZlWw2A=
Date: Tue, 30 Sep 2025 07:52:18 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007463/000000-1199c6@github.com>
Subject: [bluez/bluez] 1199c6: device: Fix privacy
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

  Branch: refs/heads/1007463
  Home:   https://github.com/bluez/bluez
  Commit: 1199c63fb45fc077b02e518ecbd0a570cfbcf06d
      https://github.com/bluez/bluez/commit/1199c63fb45fc077b02e518ecbd0a570cfbcf06d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-09-30 (Tue, 30 Sep 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Fix privacy

In order for devices to properly be programmed into the adapter
resolving list they need to set the flag DEVICE_FLAG_ADDRESS_RESOLUTION
but that is only done if device_address_is_private return true but
currently it doesn't check the rpa flag which indicates that the address
has been updated to its identity.

While at it this also update the rpa flag to privacy to better indicate
the feature rather than just the address type and then introduces
device_set_privacy/device_get_privacy and replaces the usage of
device_address_is_private with device_get_privacy whenever the features
itself needs to be checked, rather than the current address type in use.

Fixes: https://github.com/bluez/bluez/issues/1079



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
