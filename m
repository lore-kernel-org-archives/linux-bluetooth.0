Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB982030A
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450174; cv=none; b=BXx5RpxGWYOo2qFJO9nth9MKHnZQsOfTZ8nDhVHynppWF5djowKA9ErYTQIMa1R+xrPRWEtiO3luXGnRLTHTERVj1EmZldJvsFibY3GeYIK/rqgCMp6hKTIPKjqxVTMaAgB/59vhi7UuFff31abjYsSDMHBXsTBHfhrZRjA+wso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450174; c=relaxed/simple;
	bh=vU+G9oBFU4IsYqhtRL6Cw66IZr2YOI/bXv8/m6pe2VE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q+1dZT2op3J8glIb1f0REG6ANOYHqqdSVLQZG80TnGCFk8Hh3ILYXB3/uNUblSReYcNr3tSmg/TB/f7wbDdClcL/DbS2y6VrtjIEg25sbbQxQUjKVJW4DRVSQ9mqV7hCTKT2w1kCCFEms63oIBvrF4FkkdsNdLzq4A8PzKlMOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VpUIwa9I; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VpUIwa9I"
Received: from github.com (hubbernetes-node-60b6a68.va3-iad.github.net [10.48.178.47])
	by smtp.github.com (Postfix) with ESMTPA id CE8DE4E079E
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 20:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754450172;
	bh=7UZNOFF/L6qnaA4VO8itfeW/Fj5Y9Idxk9UxQ+KYmfs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VpUIwa9IhV69w7G0i0gK6I3tvwHqULLFZcywUea+Ut0AM1VFrUs4NEUtXLhomojsJ
	 8h3w01sA3y7QuVu2rV9CoOrU41WOACVaomfGf/ah8kVd7rvR5RhWFCGJaDCxpR+ED+
	 YVC5eOEPVHjl3bkBIvllRbrL0xosZmUzddpEhHqw=
Date: Tue, 05 Aug 2025 20:16:12 -0700
From: Myrrh Periwinkle <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/988599/000000-784cb2@github.com>
Subject: [bluez/bluez] 58b257: audio: Don't initialize media transport volume
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

  Branch: refs/heads/988599
  Home:   https://github.com/bluez/bluez
  Commit: 58b2575f863242a2fdd79f1fd34febd9670581d4
      https://github.com/bluez/bluez/commit/58b2575f863242a2fdd79f1fd34febd9670581d4
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


  Commit: 784cb28e8c8b548ff0c3189dd9a1a1f7594dab14
      https://github.com/bluez/bluez/commit/784cb28e8c8b548ff0c3189dd9a1a1f7594dab14
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


Compare: https://github.com/bluez/bluez/compare/58b2575f8632%5E...784cb28e8c8b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
