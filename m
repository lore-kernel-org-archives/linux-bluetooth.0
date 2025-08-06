Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EA2A1BA
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443031; cv=none; b=NoEFYXcKit4uM5WLmBfJc7NAYXqgBgisv7JP6ZsEAG4zkR5Tq3Nsif342JBsg0wswdjTBwS3iEOoYudJPcg6eKyNY0rFt0q+D2cz52EYSFoLxykCy3DnxNXuA3gZ+VpX74rYhIMQpdNMU0igBUrcaGxJY0HAZ8npGMGH8G9iUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443031; c=relaxed/simple;
	bh=US5IPcRPM2w6vqszInyxmhFnD1EsgipGvYgjaZJRv68=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kSua08iylAZ6UtyhmJTvraPhxaRoE0RyDHOjBR00q1MBGaLsgPANc9uxugO1XaphUzt+3Gd9gXkc7jpQFG6Posa/51YjoNJeBkdpm1oUoTEsekCJN/WBRKJrINlwqhaIg/Fvx3LFJUbefl4Vq3LLtC7J1yA/yOoQpKfM0+G0c8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B4GWHk5d; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B4GWHk5d"
Received: from github.com (hubbernetes-node-05585b4.ash1-iad.github.net [10.56.201.83])
	by smtp.github.com (Postfix) with ESMTPA id C9905920A1A
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754443028;
	bh=Eh1U+DWa0IHhCyHKD/+6evXwCZIKAh93FePz/Cx7DFU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B4GWHk5d71qSB3yxo9DQR68/9/ybNW/c0Mk9NIyFrTWAL5zw2qeqt8lp+0E5ZwTU0
	 O23Ar3AkMg/CxeuwsgJ4NTxsalKmo8I4t5J8Y6CkBazrhjMgpb8SZVz1BbX9ov1ecb
	 PU3T72+8Wt+vISDS7dkwOj2yQdWqsdsB0TF66L9M=
Date: Tue, 05 Aug 2025 18:17:08 -0700
From: Myrrh Periwinkle <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/988586/000000-e8d54f@github.com>
Subject: [bluez/bluez] 44b461: audio: Don't initialize media transport volume
 fro...
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

  Branch: refs/heads/988586
  Home:   https://github.com/bluez/bluez
  Commit: 44b461d8b2c66711bf0bc6e88dda6cd37b406bbd
      https://github.com/bluez/bluez/commit/44b461d8b2c66711bf0bc6e88dda6cd37b406bbd
  Author: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
  Date:   2025-08-06 (Wed, 06 Aug 2025)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M profiles/audio/media.h

  Log Message:
  -----------
  audio: Don't initialize media transport volume from media player

Media player objects may be shared between devices. As a result,
a device without support for hardware volume that is connected after one
that does may end up being erroneously considered hardware
volume-capable.

fa7828bdd ("transport: Fix not being able to initialize volume properly")
introduced btd_device_{get,set}_volume that is used as an alternative in
case no media player objects are present. Therefore, we can remove
media_player_get_device_volume and instead use btd_device_get_volume to
determine the initial volume.


  Commit: e8d54fe4e24bae02c1ed0f465eeefec1f672498b
      https://github.com/bluez/bluez/commit/e8d54fe4e24bae02c1ed0f465eeefec1f672498b
  Author: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
  Date:   2025-08-06 (Wed, 06 Aug 2025)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/avrcp.h
    M profiles/audio/media.c

  Log Message:
  -----------
  audio: Remove media_player.volume

With the previous commit, the media_player.volume field is now
completely unused. As this was never the right place to store the
initial volume to begin with, remove this field entirely as well as its
associated supporting methods to prevent confusion.


Compare: https://github.com/bluez/bluez/compare/44b461d8b2c6%5E...e8d54fe4e24b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
