Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889E3093BD
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199701; cv=none; b=e7PMLZVb2+Nb6tCAo6Ahlegjrq2Rgt3C3cGdPjvQOzFeGFfMGSeT+UY6Wbu+gTU5z/4YfF4A1LuzcC0jmlQvnjvX/ghLQ9mdTxpMmW6PL3omZOKlUkDBHz1csPIrEqXoZe0oayJLjEfdhn2KQIuklCf4NIDfMrF9Js4ZH32IedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199701; c=relaxed/simple;
	bh=KzbBwj2lxZbKwhzjqIOLlv9VzAWMeWAY0xOqbK8VtPU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Xm8tB0CiBiTBz+OVwBb17WZ/rVNEE2ZkvBF74wJyAE9R8pboL20Vm1O8LDQbyvsWv5OfcunduDOEB2/Q9duvY4F9C1LIivVuK7uf9xr1yxJ1hfVzuEbd5fYTMveY1tpuUO9SQSOaLi5LtAYAop1ZCJOgTBrzzawx9C819hWT/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FMy9bAVC; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FMy9bAVC"
Received: from github.com (hubbernetes-node-33a737e.ac4-iad.github.net [10.52.223.73])
	by smtp.github.com (Postfix) with ESMTPA id B68A27006F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756199698;
	bh=ef+xnFIvcklGaLdoZYIAjjClDs5CPmIlKALMkjt0p+k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FMy9bAVCTlhs6G8uU+oUcJ1PeEa550O4ucj9oAWH//HoVnra+4tDJwgjp4VF++7mh
	 Q/c6FBqVyObEhHIBjOJIP2f1Ru6P3BzWOy9rp4krzftYBcCjKRqLSkzoekqp96JXvB
	 fQE2eYOSBIxNXo23lNHabwYO4z0JsMFVUI5UXfvM=
Date: Tue, 26 Aug 2025 02:14:58 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995585/000000-650f73@github.com>
Subject: [bluez/bluez] 650f73: avrcp: Fix not ending loop during item listing
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/995585
  Home:   https://github.com/bluez/bluez
  Commit: 650f73d43cfc3eb040fb14d0c103825dd9cc542a
      https://github.com/bluez/bluez/commit/650f73d43cfc3eb040fb14d0c1038=
25dd9cc542a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-26 (Tue, 26 Aug 2025)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix not ending loop during item listing

When a remote applications return item with UUID set to 0, which is
against the specs (see 6.10.3 UIDs in AVRCP_v1.6.2.pdf), bluetoothd may
try to retrieve the same item in no ending loop.

  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR2 =
Rheinland type audio uid 0
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() /org/=
bluez/hci0/dev_58_66_6D_84_ED_21/player0/NowPlaying/item0
  bluetoothd[2]: profiles/audio/player.c:media_player_set_metadata() Titl=
e: WDR 2 Rheinland
  bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 en=
d 9 items 1 total 10
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR 2=
 Rheinland type audio uid 0
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() D-Bus=
 failed to register org.bluez.MediaItem1 on /org/bluez/hci0/dev_58_66_6D_=
84_ED_21/player0/NowPlaying/item0 path
  bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 en=
d 9 items 0 total 10
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR 2=
 Rheinland type audio uid 0
  bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() D-Bus=
 failed to register org.bluez.MediaItem1 on /org/bluez/hci0/dev_58_66_6D_=
84_ED_21/player0/NowPlaying/item0 path
  bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 en=
d 9 items 0 total 10



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
