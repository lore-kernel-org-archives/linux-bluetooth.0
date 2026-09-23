Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E83C1F57
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157697; cv=none; b=QI3KJo+brGLuH593m+mp3i7tlgtO2EWRmGKvRPFX7plOnp0V+3QpoYPip0gxF6lFFgzHjxL/6krwjly4rVSs+hh1GGcztHU3wukJ0E9Oq8Dm5Eskv8acHVNbkYHiMsfkx1/LRy0s5OVFhWXTOMJKjjn5hRRvRctWgjco5e40Nwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157697; c=relaxed/simple;
	bh=0lSxCq4AOsPjmVWmDFzOsebCIRm3I0d4D8CiCz00DQI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LxNzhctlxMZIpLp9XHNhRXt4k14YxgBmY1PBQs87AYxKbpdTDmO1i9lGvrfVPazwV5fihuh2pV+xA1+jErl+BG3upx/iqvdsQrQZafMOCX8ziEecqKqZfko2b6/L/979GOeJgJEgoHBh+3B2pBylD7gLp4+XdmTjRR+kGqvDRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GQ4WsXA0; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GQ4WsXA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790157695;
	bh=ze1ficu1ORmyw7c/Vt4ibDUIVvM1blLrBWTzQvJwhg4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GQ4WsXA0gbu4j01wTCd9tggAIHY+XxWFdcYUF2pnRUy4gHoj4g778t1CyeOUnKJUM
	 w/1Le6HlBt2/SMWlizyF5lHO8nm5bn3K2cqLgJbTPE3sfoaDGZTc54/58U4lBL6Rzb
	 OjRImPKCX9CUR48i1aKXqhd2h2/G9DYil19hj6SY=
Received: from github.com (hubbernetes-node-3885b8b.ac4-iad.github.net [10.52.205.73])
	by smtp.github.com (Postfix) with ESMTPA id 7993BA1114
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 03:01:35 -0700 (PDT)
Date: Wed, 23 Sep 2026 03:01:35 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1172004/000000-f38719@github.com>
Subject: [bluez/bluez] f38719: audio/avrcp: Poll GetPlayStatus when position
 chan...
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

  Branch: refs/heads/1172004
  Home:   https://github.com/bluez/bluez
  Commit: f3871915e00363e61bbc82bfaba337e2bf58065d
      https://github.com/bluez/bluez/commit/f3871915e00363e61bbc82bfaba33=
7e2bf58065d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  audio/avrcp: Poll GetPlayStatus when position changed event unsupported=


Some remote targets do not support the AVRCP_EVENT_PLAYBACK_POS_CHANGED
notification, meaning bluetoothd never learns about track position
updates for such devices.

When this event is not present in the capabilities reported by the
remote, fall back to polling AVRCP_GET_PLAY_STATUS once a second so
the media player position stays in sync. Polling is only kept running
while playback is actively progressing (playing/forward-seek/
reverse-seek) and is stopped otherwise, and is torn down on session
destruction.

Assisted-by: Copilot CLI:claude-sonnet-5



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
