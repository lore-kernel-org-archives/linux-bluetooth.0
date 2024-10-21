Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856371FCC7A
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541923; cv=none; b=W7a8DH8cuE9HxbalC268DDPRevFAa9NUJWYgBpqm0N9XcKUz2+6I04SYPlC/uWo/PIoQuHLwRYjggkaw90zaZCtcKs6lRjUgI0ulJXKXue/KDJJ81zTRsbU7/w5hUu9rg9VvwEtP6ms9ebfrznTAQndV4XEcGTGPZc73zDdhJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541923; c=relaxed/simple;
	bh=6XoOJaeUvQzW+MenFsh2r/DQYR6s0wgULdCCOTjCulc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B8bAp3w9r6SUw6X5/7zGHkfhUs6n5yzo9kI0KjpeXAloyIsRc9mag6eOPBWCnizDywehWLc/+RxPGaS3EijMuZs4gOj4rWaRgefHaA4o/LJ2N0zlJQD7MPtwToBIVFp9s+WeoZ0Utqpkd7HQF27SsUf5w+FIfukzAAbveEtSRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BpEjOIa7; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BpEjOIa7"
Received: from github.com (hubbernetes-node-f2a65c3.ash1-iad.github.net [10.56.207.95])
	by smtp.github.com (Postfix) with ESMTPA id 8E0B46C0C00
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1729541921;
	bh=rd2bJW8vM83q0fmatfW58p2V1bU1++TmteDt8w96slI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BpEjOIa7Or+WXJ2X3lSuQo1QnZknuxJAPywMgG0y3r2/brcXSe9YtfdZtAg24u3B3
	 uiYjRWlA30GnHdsaUo/cW4ogiewQWZe7XKHAADw84/K6Wqi86wvYXD/pp20N9cfa/H
	 mjZdPw7WToAuE4OYZR8XiVV3+DpguUSfsumkSNXM=
Date: Mon, 21 Oct 2024 13:18:41 -0700
From: Marijn Suijten <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b5b510-8baabd@github.com>
Subject: [bluez/bluez] 8572f2: doc: Add initial HCI(7) documentation
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
  Commit: 8572f2430980ae75c9df9b51adf86cca9e2d85f0
      https://github.com/bluez/bluez/commit/8572f2430980ae75c9df9b51adf86cca9e2d85f0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-18 (Fri, 18 Oct 2024)

  Changed paths:
    M Makefile.am
    A doc/hci.rst

  Log Message:
  -----------
  doc: Add initial HCI(7) documentation

This adds initial documentation for HCI sockets.


  Commit: 923379409010602254233103689c8ed2ff2a6cc6
      https://github.com/bluez/bluez/commit/923379409010602254233103689c8ed2ff2a6cc6
  Author: Marijn Suijten <marijn.suijten@somainline.org>
  Date:   2024-10-21 (Mon, 21 Oct 2024)

  Changed paths:
    M profiles/audio/avrcp.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  audio/avrcp: Guard SetAbsoluteVolume without target behind config value

Commit 179ccb936 ("avrcp: Set volume if volume changed event is
registered") invented a workaround that allows SetAbsoluteVolume to be
sent to a remote device that does _not_ implement the AVRCP TG profile,
as long as it previously registered for the EVENT_VOLUME_CHANGED
notification.  This is strange as the TG role is required to be able to
send commands to the peer, but the commit must have been applied to the
tree for a reason.

We discussed in [1] that workarounds for dubious peers and software
stacks should be guarded behind a config entry in main.conf, so this
starts out by introducing a new [AVRCP] category that will later be
extended with other workarounds.  It guards the changed functionality
behind a `VolumeWithoutTarget = false` boolean to disallow this obscure
check.

[1]: https://lore.kernel.org/linux-bluetooth/20211025210206.bkt5wovzmkmt6teg@SoMainline.org/


  Commit: 8baabd2f5c131f902d79e20829b117edffd46d1a
      https://github.com/bluez/bluez/commit/8baabd2f5c131f902d79e20829b117edffd46d1a
  Author: Marijn Suijten <marijn.suijten@somainline.org>
  Date:   2024-10-21 (Mon, 21 Oct 2024)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  audio/avrcp: Only allow absolute volume call/event on category-2 peers

Restrict the use of SetAbsoluteVolume and EVENT_VOLUME_CHANGED to peers
with at least AVRCP version 1.4 and AVRCP_FEATURE_CATEGORY_2 on their
respective target or controller profiles.

For backwards-compatibility, add a (default-enabled) `VolumeCategory =
true` configuration option under `[AVRCP]` to allow optionally disabling
this new check.


Compare: https://github.com/bluez/bluez/compare/b5b51017ea18...8baabd2f5c13

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
