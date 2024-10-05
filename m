Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE0170A3F
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Oct 2024 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165009; cv=none; b=SOM83Brb3PKzsutK1Hkss52iE9+jsxkQMsnYsQihi263gzh899mlAoVFLA2cMYSBangJrzE8X7m9rJKqtvpxRL9kCv5PzLxZQg7AptYR4Fnegzzd0R8GuPYyEahgrK0yBf7TGQCUATccYvrqobqt0DSWUB48eAYxa9T7leroOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165009; c=relaxed/simple;
	bh=OJNO0lzP3OUBpT7DuXoP0LXmPkHrEMOS6GDtH8/LYo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2mynTNrWVJL0TdieA0hMIcNtalD3POy3RuYHl5I2GNP6wX8/ddb3R70UPxrtFHeLyFzanUvsMJhK/RPW6vtPZDza3Vw7D6V19z2+3ra1RkQKTYVdfy0HRfgERr5me91xNmP2kohQbwrGH10uUsYFYt/fuDbX/w4sHxIlG0i88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 687F51F907;
	Sat,  5 Oct 2024 23:43:22 +0200 (CEST)
From: Marijn Suijten <marijn.suijten@somainline.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Yu Liu <yudiliu@google.com>,
	Bartosz Fabianowski <bartosz@fabianowski.eu>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ v4 0/3] audio/avrcp: Determine Absolute Volume support from feature category 2
Date: Sat,  5 Oct 2024 23:43:05 +0200
Message-ID: <20241005214321.84250-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apologies for the very long delay to send v4.  As it turns out review comments
initially failed to reach my inbox [1], and I haven't pursued these patches
afterwards until receiving yet another ping about it on an ancient pulseaudio
MR.

Note that I'm not entirely satisfied with the much longer `if` conditionals
that are increasingly hard to read.  Suggestions are welcome, such as confirming
whether factoring them out into local `bool` variables is desired.

This series can still be tested on recent Android phones by setting `Bluetooth
AVRCP version` to 1.3 in developer settings, followed by **repairing** the phone
to a machine running BlueZ to refresh SDP records.  Absolute volume control
should work unless `VolumeVersion` is set to `false`, resulting in useful error
messages instead.

Keep in mind that this `VolumeVersion` property only applies to when the machine
running BlueZ is "in control of" the volume (i.e. we are the sink) and receiving
SetAbsoluteVolume commands from the peer (and sending EVENT_VOLUME_CHANGED
*to* the peer).  This is because Android appears to use AVRCP 1.4 or higher
in its TG profile (our `session->controller->version`) which should succeed
the version check (and not in the first place because phones generally have
their "audio sink" functionality disabled to not confuse various bidirectional
audio/ bluetooth stacks... unless it's "Android Auto" where it is the other
way around).

[1]: https://marc.info/?l=linux-bluetooth&m=168548631319097&w=2

Changes since v3:
- Shortened `[AVRCP]` configuration parameter names, now `VolumeWithoutTarget`
  and `VolumeVersion`.
- Allow disabling new "strict category-2 checking" from v3 behind a new
  `VolumeCategory` (default `true`) parameter;
- Mentioned in main.conf that `VolumeWithoutTarget` (from a strange patch
  further described below) also skips the AVRCP 1.4 version requirement;
- Rebased 1.5 year old patches.

v3: https://marc.info/?l=linux-bluetooth&m=167849515409848&w=2

Changes since v2:

- New patch to guard target-less SetAbsoluteVolume calls with main.conf
  config;
- New patch to more strictly require category-2 _and_ peer CT/TG 1.4;
- Use main.conf to relax 1.4 version constraint for TGs registering
  AbsVol notifications;

v2: https://marc.info/?l=linux-bluetooth&m=163519566912788&w=2

Note that I still misunderstand commit 179ccb936 ("avrcp: Set volume if volume
changed event is registered").  If we're planning on sending a SetAbsoluteVolume
command to the (inexistant...) TG profile on our peer, why would it check
whether the CT on the peer previously registered for EVENT_VOLUME_CHANGED?  In
that case the peer seems to assume that we know/control the volume, and have to
*reply to the event* instead?

Marijn Suijten (3):
  audio/avrcp: Guard SetAbsoluteVolume without target behind config
    value
  audio/avrcp: Only allow absolute volume call/event on category-2 peers
  audio/avrcp: Determine Absolute Volume support from feature category 2

 profiles/audio/avrcp.c | 57 ++++++++++++++++++++++++++++++++++++------
 src/btd.h              |  7 ++++++
 src/main.c             | 26 +++++++++++++++++++
 src/main.conf          | 20 +++++++++++++++
 4 files changed, 103 insertions(+), 7 deletions(-)

-- 
2.46.2

