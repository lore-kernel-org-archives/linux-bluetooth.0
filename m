Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A93750CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347843; cv=none; b=lX0ZNZMYE99O4qYTru9bBOMS2QW6WWWZkc+TaUgLcs0vovk6dXauYUs/GKmCTnUM/3FQMR9mf1OdmeOTE6YxAOiklJ8hAcXEOpnLxY9KnMW7y1GHolt4q038c41gc8fNl8tJ5u8gDoeOT0qSoCp+MTobQD7xFE4Rloka3+lpGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347843; c=relaxed/simple;
	bh=l6EIuTk1PkAUBFx0gLyp3Z58+xlC6E15xSOldbzr1dM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kgWkmvVrhBwvKqbE989Bx52O2QP+yPvOD1uDR7xYZFx37GQn+H0PtfKmPHTjkURGCGliuygtm1vVdXTbkQ66M+X93ZPymkVAi+fOPr/9YEPaL0/ip6qXDs9J1yZCbZBrlONhd86WJScPGupJNPC1KxUVxmcE6iqdbopgIStAFnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ERtBmq13; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ERtBmq13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790347840;
	bh=d8X8oElaupkNvVAgR04VryH7j+7X6WVDZqn+mAbDPvA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ERtBmq137B1C23bi6l1roqT5dwMdbTqe7MQ+gavJ6rz+lRwqVtrdbomqGdnX/brLF
	 mAaGIixCA6QJ+w8BmG39AHGCuFszZfPt5VEcnxY2QA3ACZ+KAblHHMysUgIH01wz6q
	 lcee2vv4p84+cTjxxW5otCAEMv4CQOX9DtxVcgxoh4MxSy1+gfixWl1t91z4Ta3J9b
	 Fso5m4mn3m/UnfiRvAuehI59wRfK06PQt255CCvAlWvaBHFeS4FOliJnYcARfF99PH
	 FlqG9/93QvhMgrhJhcPKi4k2ahMnijWAml9zK0RYH4KVbvYISB1TJmHj0xF5scx2ou
	 wqyFlot3hAJcg==
Received: from github.com (hubbernetes-node-890ae1e.ash1-iad.github.net [10.56.147.36])
	by smtp.github.com (Postfix) with ESMTPA id C21B1600B27
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 07:50:40 -0700 (PDT)
Date: Fri, 25 Sep 2026 07:50:40 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173825/000000-4a2f05@github.com>
Subject: [bluez/bluez] 4a2f05: audio/avrcp: Poll GetPlayStatus when position
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

  Branch: refs/heads/1173825
  Home:   https://github.com/bluez/bluez
  Commit: 4a2f056fb73d16c677a512ed9607071aaa717030
      https://github.com/bluez/bluez/commit/4a2f056fb73d16c677a512ed96070=
71aaa717030
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

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
while playback is actively progressing (playing) and is stopped
otherwise, and is torn down on session destruction.

Assisted-by: Copilot CLI:claude-sonnet-5



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
