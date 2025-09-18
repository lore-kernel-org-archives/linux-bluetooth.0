Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD2308F1E
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202287; cv=none; b=KYU0FkU0S49Xv2nV0X4kzj62yJ8ph3R3p+9CUPyhA9IP5FVaxPy/XlRvUbuJZg2PtTrys4pvlF647bvhORG+FPgk7JZwpH3cK+DssQBt+n52blVWPZVxpWpLkSUiQypJsDVvWuRc4GUOG/3MQoSqYrO+Dx1fRRQYuf2Zet8242c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202287; c=relaxed/simple;
	bh=Pfuh3lq27W2j2TrBaAxYAs1NkQQQXRn30cO6Hb5xNjg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=udWg46HkZ9R8LXzESLfp9yK5mmwJ1uaxsRQCHKXwjCBD2auPl08SlDe5WsT/Fg5Q03wiYF/GohrYQFTjV+fFb0uTJQX3EJAvm0YotB+RSgxmtU+xkYuIMUCJcHE3On4khPZiwUOyHM5oe/W1A4D5GrktW/h4TwVUxBgbw77hmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HPEzVDw7; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HPEzVDw7"
Received: from github.com (hubbernetes-node-bab89fd.va3-iad.github.net [10.48.177.39])
	by smtp.github.com (Postfix) with ESMTPA id 05360E00F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758202285;
	bh=9Hprv//uuwcYO9MyZCMoxeP2VYJPm5b5wjRK6YBmEk0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HPEzVDw77k5AgcP9+nbs34ax0lkhWEZ28CagIKsvBGQZHlSR88PNOGEzTf+qIObqm
	 yCyGJAuJfQtqX1lsgJQQc7ilbZUReAFfGe953Yb8XCMA9fJcGBXGQts+d0vqEFmjcJ
	 hfIwSMK3807nvxACIzAJNZO7J4wq42LpW1bAEzoY=
Date: Thu, 18 Sep 2025 06:31:25 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c6dcf6-61d3e4@github.com>
Subject: [bluez/bluez] 72b02d: profiles/audio/a2dp: Clear suspend timer on
 A2DP s...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 72b02df3b2b40a3ac38832e2e80a16eb6b3bef04
      https://github.com/bluez/bluez/commit/72b02df3b2b40a3ac38832e2e80a1=
6eb6b3bef04
  Author: Alex Studer <alex@studer.dev>
  Date:   2025-09-18 (Thu, 18 Sep 2025)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  profiles/audio/a2dp: Clear suspend timer on A2DP stream free

When an A2DP stream is created in start_ind, a timer is set, suspending
the AVDTP stream if there have been no users within 5 seconds. However,
if the AVDTP stream transitions to the IDLE state before the timer
fires, the A2DP stream is freed without the timer being cleared. This
meant that when the timer fired, it tried to suspend a stream with a
pointer that was previously freed and so segfaulted.

This commit fixes that by ensuring that suspend_timer is cleared before
freeing the A2DP stream.

This was causing random segfaults when connecting my Sony WH-1000XM5
headphones.


  Commit: 61d3e447f9d47f03e5cbd55b805d7841ccc93319
      https://github.com/bluez/bluez/commit/61d3e447f9d47f03e5cbd55b805d7=
841ccc93319
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-09-18 (Thu, 18 Sep 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix build with A2DP support disabled

$ ./bootstrap-configure --disable-a2dp && make
[...]
profiles/audio/transport.c: In function =E2=80=98media_transport_update_d=
elay=E2=80=99:
profiles/audio/transport.c:2653:33: error: implicit declaration of functi=
on =E2=80=98a2dp_avdtp_get=E2=80=99 [-Wimplicit-function-declaration]
 2653 |                 a2dp->session =3D a2dp_avdtp_get(transport->devic=
e);
      |                                 ^~~~~~~~~~~~~~
profiles/audio/transport.c:2653:31: error: assignment to =E2=80=98struct =
avdtp *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer wi=
thout a cast [-Wint-conversion]
 2653 |                 a2dp->session =3D a2dp_avdtp_get(transport->devic=
e);
      |                               ^

Reported-by: Arun Raghavan <arun@accosted.net>
Fixes: 0bb66d3d1abd ("transport: fix A2DP Delay values missing from DBus"=
)


Compare: https://github.com/bluez/bluez/compare/c6dcf6b71450...61d3e447f9=
d4

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
